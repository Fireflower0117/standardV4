<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
(function() {
    $(document).ready(function() {

       /********************************************************************
       ********************* 공통코드 렌더링         **********************
       *********************************************************************/
       let comCodeRsltList = on.xhr.ajaxComCdList({
                                condiList : [
                                    { rsId : "rsRegionDivCd", sqlCondi : { uppComCd : "REGION_DIV_CD" } },
                                    { rsId : "rsCareerLevel", sqlCondi : { uppComCd : "CAREER_LEVEL" } }
                                ]
       });

       // 권역구분
       on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#region" }
                                    , optionValInfo : { optId : "comCd", optTxt : "cdNm" }
                                    , dataInfo      : comCodeRsltList.rsRegionDivCd
       });

       // 경력레벨 구분
       on.html.dynaGenRadio({ targetInfo    : { targetId : "#careerLvlArea", style : "display: inline-flex; align-items: center; gap: 15px; flex-wrap: nowrap; white-space: nowrap;" }
                            , targetProp    : { eleId : "careerLvl", eleNm : "careerLvl", style : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;" }
                            , optionWrapper : { useYn : "Y", tagName : "label", style : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;" }
                            , optionValInfo : { optId : "comCd", optTxt : "cdNm" }
                            , dataInfo      : comCodeRsltList.rsCareerLevel
       });

       /********************************************************************
       ********************* 기존 데이터 조회 및 폼 세팅 *******************
       *********************************************************************/
       // content Editor 적용 (수정 페이지이므로 readOnly 옵션 제거, 입력 가능하게!)
       CKEDITOR.replace("editerContent", { height: 400, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>/external/ckeditor/contents.css' });
       <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
           if (!on.valid.isEmpty("${param.boardSerno}")) {
               //  단건 상세 조회 (기존 데이터 불러오기)
               on.xhr.ajax({ cmd: "selectOne", sql: "on.standard.board.sampleboard.inqSampleBoardDetail"
                           , boardSerno: "${param.boardSerno}"
                           , successFn : function(rs){
                               if (!on.valid.isEmpty(rs)) {
                                   // 조회 결과 세팅
                                   on.html.resetElementsByObject(rs);

                                   // CKEditor 데이터 세팅
                                   CKEDITOR.instances.editerContent.on('instanceReady', function() {
                                       this.setData(rs.editerContent);
                                   });

                                   // 첨부파일 영역 세팅 (수정 가능하도록 uploadType 기본값인 "upload" 사용)
                                   on.file.setFileList({
                                         displayTarget : "#fileUploadArea"
                                       , atchFileIdNm  : "atchFileId"
                                       , atchFileId    : rs.atchFileId
                                       , uploadType    : "upload"
                                   });
                               }
                           }
               });

           }
      </c:if>

       /********************************************************************
       ******************* 버튼 이벤트         **********************
       *********************************************************************/
         <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
                // 저장 (Update) 버튼 클릭
                $('#btnUpdate').on('click', function(){

                     // 유효성 검증
                     let validateOptions = { formId : "#defaultFrm"
                                           , validateList : [
                                                 { name : "boardTitl",     label : "게시글제목", rule: {"required":true} },
                                                 { name : "region",        label : "권역구분",   rule: {"required":true} },
                                                 { name : "careerLvl",     label : "경력단계",   rule: {"required":true} },
                                                 { name : "editerContent", label : "게시글내용", rule: {"required":true} }
                                             ]
                     };
                     if(!on.valid.formValidationCheck(validateOptions)) return;


                     // 파일 먼저 업로드/삭제 처리 (procType: "update")
                     on.file.fileFormSubmit({ procType  : "update" , formIdArr : ["#defaultFrm"]
                                            , successFn : function(rs){
                                                   // 파일 처리 완료 후 CKEditor 내용 가져와서 폼 값 갱신
                                                   $("#editerContent").val(CKEDITOR.instances.editerContent.getData());

                                                   // DB 데이터 수정 ajax 호출
                                                   on.xhr.ajax({ cmd : "update" , sql : "on.standard.board.sampleboard.mergeSampleBoardList" // Merge 쿼리 또는 Update 쿼리
                                                       , data : $("#defaultFrm").serializeArray()
                                                       , boardSerno: "${param.boardSerno}"  // input type hidden 대용
                                                       , atchFileId : rs.atchFileId // 갱신된 파일 그룹 ID (입력당시 fileGroupId 그대로 유지)
                                                       , successFn  : function(rs) {
                                                           if( rs[0].execResult === "success"){
                                                               on.msg.showMsg({message : "수정되었습니다."});
                                                               goList();
                                                           }
                                                       }
                                                       , failFn: function(err) {
                                                            on.msg.showMsg({message : err.message});
                                                       }
                                                    });
                                            }
                     });
                });
         </c:if>

        // 취소 버튼 (수정 취소 시 상세 보기 페이지로 복귀)
        $("#btnCancel").on("click" , (evt) =>{
            goList();
        });

        // 상세 보기 페이지로 이동 함수
        function goList (){
             on.html.dynaGenHiddenForm({
                   formDefine : { fid: "viewForm", action: "/ma/board/stanboard/list.do", method: "post", isSubmit : true }
                 , formAttrs  : [   { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                   ]
             });
        }
    });
})();
</script>

<form id="defaultFrm" name="defaultFrm" >
    <div class="board_top">
        <div class="board_right">
            <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
        </div>
    </div>
    <table class="board_write">
        <colgroup>
          <col class="w20p">
          <col class="w40p">
          <col class="w20p">
          <col class="w20p">
       </colgroup>
        <tbody>
            <tr>
                <th scope="row"><span class="asterisk">*</span>제목</th>
                <td>
                    <input id="boardTitl" name="boardTitl" class="w100p" title="제목" type="text" value="" maxlength="80"/>
                </td>
                <th scope="row">공지여부</th>
                <td>
                    <span class="chk round">
                       <span class="cbx"><input type="checkbox" name="ntiYn" id="ntiYn" value="Y"><label for="ntiYn">공지</label></span>
                    </span>
                </td>
            </tr>
            <tr>
                <th scope="row"><span class="asterisk">*</span>권역</th>
                <td><select id="region" name="region" class="w50p" title="권역구분"></select></td>
                <th scope="row"><span class="asterisk">*</span>경력단계</th>
                <td><div id="careerLvlArea"></div></td>
            </tr>
            <tr>
                <th scope="row"><span class="asterisk">*</span>내용</th>
                <td colspan="3">
                    <textarea id="editerContent" name="editerContent" class="txt_area w100p editor" title="내용" aria-label="내용"></textarea>
                </td>
            </tr>
            <tr>
                <th scope="row">첨부파일</th>
                <td colspan="3">
                    <div id="fileUploadArea"> </div>
                </td>
            </tr>
        </tbody>
    </table>
</form>

<div class="btn_area right">
    <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
    <button type="button" id="btnUpdate" class="btn blue">저장</button>
    </c:if>
    <button type="button" id="btnCancel" class="btn gray">취소</button>
</div>