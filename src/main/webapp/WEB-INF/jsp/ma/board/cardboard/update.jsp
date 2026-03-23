<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/> 
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/> 
<script> 
    var oEditors = [];
    $(document).ready(function(){
        
           /****************************************************************************
           *******************          Page Title / 메뉴 포커스     *********************
           ****************************************************************************/
           $("#page_title").text("지역별 주요기관");
            $("#1depthNm").text("게시판관리");
            $("#2depthNm").text("지역별 주요기관");

            $("#li_depth1_board").addClass("visible")
            $("#li_depth2_region").addClass("active open")
           
           
           /****************************************************************************
           *******************              Page 속성 Settings          ****************
           ****************************************************************************/
          
           
           // 지역명
           $.opnt.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#selRegionCd" }
                                            , addOption     : { position : "top" , txt : "공통" , val : "all" }
                                            , optionValInfo : { optId : "code" , optTxt : "text" }
                                            , dataInfo      : [ { code : "chungbook" , text:"충북" }
                                                             , { code : "daegu"     , text:"대구" }
                                                             , { code : "yongsan"   , text:"용산" }
                                                            ]
                                           });
           
        
           /********************************************************************
           *********************          입력조건         **********************
           *********************************************************************/ 
            // 기관명
           $("#bltnbTitl").val('${bltnbVO.bltnbTitl}');
           
           // 기관명
           $("#bltnbCtt").val('${bltnbVO.bltnbCtt}');
            
           // 첨부파일
           $("#atchFileUpload").html(setFileList("${bltnbVO.atchFileId}", "atchFileId", "upload", 1));
           
           /********************************************************************
           *******************          버튼 이벤트         **********************
           *********************************************************************/
           $("#btn_submit").on("click", function () {  
                if(wrestSubmit(document.defaultFrm)){  // insert , update
                    fileFormSubmit("defaultFrm", "update", function () { 
                         $.opnt.xhr.ajax({sid : "updRegionProc", cmd : "update", sql : "rapa.board.updateRapaBoard" 
                                         , successFn : function(){
                                                $.opnt.msg.showMsg("수정 완료 했습니다.");
                                                goList();
                                          }
                                         , failFn  : function(){ 
                                                $.opnt.msg.showMsg("등록중 장애가 발생했습니다.\n관리자에게 문의하세요.");
                                          } 
                                        , bltnbSerno : "${bltnbVO.bltnbSerno}"
                                        , bltnbTitl : $("#bltnbTitl").val()
                                        , bltnbCtt : $("#bltnbCtt").val()
                                        , atchFileId : $("#atchFileId").val() 
                         }); 
                    });
                    return false;
                }
           });
             
           $("#btn_view").on("click", () => {
                 /* 검색조건 정보 포함하여 넘김 (상세보기호 List페이지 복귀시 상세페이기 보기전상태와 동일하게 유지 목적)*/
                  $.opnt.html.dynaGenHiddenForm({ formDefine : { fid: "regionViewForm", action: "/ma/board/regionview.do", method: "post", isSubmit : true }
                                                     , formAttrs : { condition  : { name : "searchCondition" , val: JSON.stringify(${param.searchCondition}) }
                                                                   , bltnbSerno : { name : "bltnbSerno"      , val: "${bltnbVO.bltnbSerno}" }
                                                                   , menuCd     : { name : "menuCd"          , val: "notice" }
                                                                   }
                  });
           });
           
           function goList (){
                $.opnt.html.dynaGenHiddenForm({ formDefine : { fid: "regionWriteForm", action: "/ma/board/regionlist.do", method: "post", isSubmit : true }
                                              , formAttrs  : { condition : { name : "searchCondition" , val: JSON.stringify(${param.searchCondition}) } 
                                                             }
                });
           }
                                                    
    });
</script> 
<form:form modelAttribute="bltnbVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="bltnbSerno"/>
	<form:hidden path="atchFileId" id="atchFileId" title="첨부파일" required="true" />
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
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
                <td><input type="text" aria-label="기관명" id="bltnbTitl"></input></td>
                <th scope="row"><span class="asterisk">*</span>홈페이지 url</th>
                <td><input type="text" aria-label="홈페이지 url" id="bltnbCtt"></input></td>
            </tr>
            <tr>
                <th><strong><span class="asterisk">*</span>로고 파일</strong></th>
                <td colspan="3">
                     <div id="atchFileUpload"></div>
                </td>
            </tr>
        </tbody>
    </table> 
</form:form>    
<div class="btn_area">
    <button type="button" id="btn_submit" class="btn blue">수정</button>
    <button type="button" id="btn_view" class="btn gray">취소</button>
</div>
  

