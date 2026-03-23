<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
(function() {
    $(document).ready(function() {

       /********************************************************************
       ********************* 공통코드 렌더링         **********************
       *********************************************************************/
       // 1. 공통코드 일괄조회 (권역, 경력레벨)
       let comCodeRsltList = on.xhr.ajaxComCdList({
            condiList : [
                { rsId : "rsRegionDivCd", sqlCondi : { uppComCd : "REGION_DIV_CD" } },
                { rsId : "rsCareerLevel", sqlCondi : { uppComCd : "CAREER_LEVEL" } }
            ]
       });

       // 2. 권역구분 (Select Box) 생성
       on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#region" }
                                    , optionValInfo : { optId : "comCd", optTxt : "cdNm" }
                                    , dataInfo      : comCodeRsltList.rsRegionDivCd
       });

       // 3. 경력레벨 (Radio) 생성
       on.html.dynaGenRadio({ targetInfo    : { targetId : "#careerLvlArea", style : "display: inline-flex; align-items: center; gap: 15px; flex-wrap: nowrap; white-space: nowrap;" }
                            , targetProp    : { eleId : "careerLvl", eleNm : "careerLvl", style : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;" }
                            , optionWrapper : { useYn : "Y", tagName : "label", style : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;" }
                            , optionValInfo : { optId : "comCd", optTxt : "cdNm" }
                            , dataInfo      : comCodeRsltList.rsCareerLevel
       });

       /********************************************************************
       ********************* 입력조건 세팅         **********************
       *********************************************************************/
       // content Editor 적용
       CKEDITOR.replace("editerContent",{height : 400, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>'+'/external/ckeditor/contents.css'});

       // 파일 업로드 영역 설정
       on.file.setFileList({ displayTarget : "#fileUploadArea", atchFileIdNm : "atchFileId" });


       /********************************************************************
       ******************* 버튼 이벤트         **********************
       *********************************************************************/
        // 등록
        $('#btnRegist').on('click', function(){

             // ★ 입력폼 유효성 검증 (권역, 경력레벨 추가)
             let validateOptions = {
                 formId       : "#defaultFrm",
                 validateList : [
                     { name : "boardTitl",     label : "게시글제목", rule: {"required":true} },
                     { name : "region",      label : "권역구분",   rule: {"required":true} },
                     { name : "careerLvl",      label : "경력단계",   rule: {"required":true} },
                     { name : "editerContent", label : "게시글내용", rule: {"required":true} }
                 ]
             };

             let isValid = on.valid.formValidationCheck(validateOptions);
             if(!isValid) return;


             // 여러건의 파일을 업로드한다면, 파일업로드 영역이 포함된 form의 정보를 array로 입력한다.
             on.file.fileFormSubmit({
                 formIdArr : ["#defaultFrm"], // 폼이 여러개일경우 array에 추가하면 추가된 form내부에 on.file.setFileList함수로 생성판 파일은 전부 업로드 된다.
                                              // 업로드 결과 그룹코드는 successFn의 rs로  atchFileIdNm에 지정했던 값으로 파일그룹ID가 전달된다.
                 procType  : "insert",
                 successFn : function(rs){
                       $("#editerContent").val(CKEDITOR.instances.editerContent.getData()); // CKEditor makup 재정의

                       on.xhr.ajax({
                             cmd : "insert"
                           , sql : "on.standard.board.sampleboard.mergeSampleBoardList"
                           , data : $("#defaultFrm").serializeArray()
                           , atchFileId : rs.atchFileId
                           , successFn  : function(rs) {
                               if( rs[0].execResult === "success"){
                                   on.msg.showMsg({message : "저장했습니다."});
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

        // ★ 취소 버튼 (HTML id와 스크립트 선택자 일치하도록 수정)
        $("#btnList").on("click" , (evt) =>{
            goList();
        });

        function goList (){
             on.html.dynaGenHiddenForm({
                   formDefine : { fid: "listForm", action: "/ma/board/stanboard/list.do", method: "post", isSubmit : true }
                 , formAttrs  : { condition : { name : "searchCondition" , val: JSON.stringify(${param.searchCondition}) } }
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
<div class="btn_area right"> <button type="button" id="btnRegist" class="btn blue">등록</button>
    <button type="button" id="btnList" class="btn gray">취소</button>
</div>