<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/> 
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/> 
<script>
    $(document).ready(function(){

           /********************************************************************
           *********************          입력조건         **********************
           *********************************************************************/ 

           // 파일 업로드 영역 설정
           on.file.setFileList({ displayTarget : "#atchFileIdArea", atchFileIdNm : "atchFileId" });
             
           /********************************************************************
           *******************          버튼 이벤트         **********************
           *********************************************************************/
           $("#btnSubmit").on("click", function () {

                  // 입력폼 유효성 검증 (권역, 경력레벨 추가)
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







                if(wrestSubmit(document.defaultFrm)){  // insert , update
                    fileFormSubmit("defaultFrm", "insert", function () { 
                         on.xhr.ajax({sid : "insRegionProc", cmd : "insert", sql : "rapa.board.insertContents"
                                        , bltnbTitl : $("#bltnbTitl").val()
                                        , bltnbCtt : $("#regionUrl").val()
                                        , atchFileId : $("#atchFileId").val()

                                         , successFn : function(){
                                                goList();
                                          }
                                         , failFn  : function(){ 
                                                $.opnt.msg.showMsg("등록중 장애가 발생했습니다.\n관리자에게 문의하세요.");
                                          } 

                                        
                         }); 
                    });
                    return false;
                }
           });
           
           // 취소
           $("#btn_list").on("click" , () => {
                goList();
           });
           
           
           function goList (){
                on.html.dynaGenHiddenForm({ formDefine : { fid: "regionListForm", action: "/ma/board/regionlist.do", method: "post", isSubmit : true }
                                              , formAttrs  : { condition : { name : "searchCondition" , val: JSON.stringify(${param.searchCondition}) } 
                                                             }
                });
           }
                                                    
    });
</script> 
<form name="defaultFrm" id="defaultFrm" >
    <div class="board_top">
        <div class="board_left">
        </div>
        <div class="board_right">
            <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
        </div>
    </div>
    <table class="board_write">
        <colgroup>
            <col class="w15p">
            <col class="">
            <col class="w15p">
            <col class="">
        </colgroup>
        <tbody>
            <tr>
                <th scope="row"><span class="asterisk">*</span>기관명</th>
                <td > 
                    <input id="boardTitl" name="boardTitl" title="기관명" class="w50p" maxlength="80"/>
                </td>
                <th scope="row"><span class="asterisk">*</span>홈페이지 url</th>
                <td>
                  <input name="urlUrl" id="urlUrl" title="홈페이지 Url"  class="w50p" required="true"/>
                </td>
            </tr>
            <tr>
                <th><strong><span class="asterisk">*</span>로고 파일</strong></th>
                <td colspan="3">
                     <div id="atchFileIdArea"></div>
                </td>
            </tr>
        </tbody>
    </table>
</form>
<div class="btn_area">
  <button type="button" id="btnSubmit" class="btn blue">등록</button>
  <button type="button" id="btnList" class="btn gray">취소</button>
</div>