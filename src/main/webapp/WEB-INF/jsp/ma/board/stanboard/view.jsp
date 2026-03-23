<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
(function() {
    $(document).ready(function() {

       /********************************************************************
       ********************* 공통코드 렌더링         **********************
       *********************************************************************/
       let comCodeRsltList = on.xhr.ajaxComCdList({
                                    condiList : [ { rsId : "rsRegionDivCd", sqlCondi : { uppComCd : "REGION_DIV_CD" }}
                                                , { rsId : "rsCareerLevel", sqlCondi : { uppComCd : "CAREER_LEVEL"  }}
                                    ]
                             });

       on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#region" }
                                    , addOption     : [ { position : "top", txt : "선택", val : "" } ]
                                    , optionValInfo : { optId : "comCd", optTxt : "cdNm" }
                                    , dataInfo      : comCodeRsltList.rsRegionDivCd
       });

       on.html.dynaGenRadio({ targetInfo    : { targetId : "#careerLvlArea", style : "display: inline-flex; align-items: center; gap: 15px; flex-wrap: nowrap; white-space: nowrap;" }
                            , targetProp    : { eleId : "careerLvl", eleNm : "careerLvl", style : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;" }
                            , optionWrapper : { useYn : "Y", tagName : "label", style : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;" }
                            , optionValInfo : { optId : "comCd", optTxt : "cdNm" }
                            , dataInfo      : comCodeRsltList.rsCareerLevel
       });

       /********************************************************************
       ********************* 상세 데이터 조회 및 바인딩 *********************
       *********************************************************************/
       <c:if test="${USER_AUTH.READ_YN == 'Y'}">
       if (!on.valid.isEmpty("${param.boardSerno}")) {
           // 1. 단건 상세 조회
            on.xhr.ajax({ cmd: "selectOne",  sql: "on.standard.board.sampleboard.inqSampleBoardDetail"
                        , boardSerno: "${param.boardSerno}"
                        , successFn : function(rs){
                            if (!on.valid.isEmpty(rs)) {
                                 // 조회 결과값 자동 세팅 (select column = element id가 일치할경우 )
                                  on.html.resetElementsByObject(rs);

                                   // CKEditor 읽기 전용으로 세팅 및 데이터 바인딩
                                   CKEDITOR.replace("editerContent", {
                                       height: 400,
                                       readOnly: true, // ★ 에디터 읽기 전용 모드
                                       contentsCss: '<c:out value="${pageContext.request.contextPath}"/>/external/ckeditor/contents.css'
                                   });

                                   // 내용역역 값 세팅 (TestArea = CKEditor)
                                   CKEDITOR.instances.editerContent.on('instanceReady', function() {
                                       this.setData(rs.editerContent);
                                   });

                                    // 폼 전체 비활성화 (수정 불가 처리)
                                    on.html.docFormDisEnable({ formId: "#defaultFrm", isAbleDiv: true });

                                    // 첨부파일 영역 세팅 (보기 전용 모드)
                                    on.file.setFileList({
                                         displayTarget : "#fileUploadArea"
                                       , atchFileIdNm  : "atchFileId"
                                       , atchFileId    : rs.atchFileId
                                       , uploadType    : "view"
                                    });
                            }

                         }
           });
       }
       </c:if>

       /********************************************************************
       ******************* 버튼 이벤트         **********************
       *********************************************************************/
        <c:if test="${USER_AUTH.WRITE_YN == 'Y'}">
            // 수정 페이지로 이동 (Update 화면 라우팅)
            $('#btnModify').on('click', function(){
                on.html.dynaGenHiddenForm({
                    formDefine : { fid: "modifyForm", action: "/ma/board/stanboard/update.do", method: "post", isSubmit : true },
                    formAttrs  : [
                        { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) },
                        { name : "boardSerno"      , value : "${param.boardSerno}" } // 수정 페이지에 식별자 전달
                    ]
                });
            });
        </c:if>
        <c:if test="${USER_AUTH.DELETE_YN == 'Y'}">
            // 삭제 처리 (Delete)
            $('#btnDelete').on('click', function(){
                if(confirm("게시글을 삭제하시겠습니까?")) {
                    on.xhr.ajax({
                          cmd: "update"
                        , sql: "on.standard.board.sampleboard.deleteSampleBoard" // ★ 삭제용 SQL ID
                        , boardSerno: "${param.boardSerno}"
                        , successFn: function(rs) {
                            on.msg.showMsg({message: "삭제되었습니다."});
                            goList();
                        }
                        , failFn: function(err) {
                            on.msg.showMsg({message : err.message});
                        }
                    });
                }
            });
        </c:if>

        // 목록으로 이동
        $("#btnList").on("click" , (evt) =>{
            goList();
        });

        function goList (){
             on.html.dynaGenHiddenForm({ formDefine : { fid: "listForm", action: "/ma/board/stanboard/list.do", method: "post", isSubmit : true }
                                       , formAttrs  : [ { name : "searchCondition" , value: JSON.stringify(${param.searchCondition}) } ]
             });
        }
    });
})();
</script>

<form id="defaultFrm" name="defaultFrm" >
    <input type="hidden" name="boardSerno" id="boardSerno" value="${param.boardSerno}" />

    <div class="board_top">
        <div class="board_right">
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
                <th scope="row">제목</th>
                <td>
                    <input id="boardTitl" name="boardTitl" class="w100p" title="제목" type="text" value=""/>
                </td>
                <th scope="row">공지여부</th>
                <td>
                    <span class="chk round">
                       <span class="cbx"><input type="checkbox" name="ntiYn" id="ntiYn" value="Y"><label for="ntiYn">공지</label></span>
                    </span>
                </td>
            </tr>
            <tr>
                <th scope="row">권역</th>
                <td><select id="region" name="region" class="w50p" title="권역구분"></select></td>
                <th scope="row">경력단계</th>
                <td><div id="careerLvlArea"></div></td>
            </tr>
            <tr>
                <th scope="row">내용</th>
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
    <c:if test="${USER_AUTH.WRITE_YN == 'Y'}">
        <button type="button" id="btnModify" class="btn blue">수정</button>
    </c:if>
    <c:if test="${USER_AUTH.DELETE_YN == 'Y'}">
        <button type="button" id="btnDelete" class="btn red">삭제</button>
    </c:if>
    <button type="button" id="btnList" class="btn gray">목록</button>
</div>