<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>  
<script> 
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
           *******************             Button Event Setting         ****************
           ****************************************************************************/ 
           
           <%-- 첨부파일 view 세팅 --%>
	       $("#atchFileUpload").html(setFileList( '<c:out value="${resultMap.atchFileId}"/>' , "atchFileId", "view"));
           
           // 수정 버튼
           $("#btn_update").on("click", () => {
                $.opnt.html.dynaGenHiddenForm({ formDefine : { fid: "regionUpdateForm", action: "/ma/board/regionupdate.do", method: "post", isSubmit : true }
                                              , formAttrs  : { condition  : { name : "searchCondition" , val: JSON.stringify(${param.searchCondition})    }
                                                             , bltnbSerno : { name : "bltnbSerno"      , val: '<c:out value="${resultMap.bltnbSerno}"/>' }
                                                             , menuCd     : { name : "menuCd"          , val: 'region'                                    } 
                                                             }
                });
           }); 
           
           // 삭제 버튼
           $("#btn_del").on("click", () => {
                $.opnt.xhr.ajax({sid : "insRegionProc", cmd : "update", sql : "rapa.board.updRegionUseYn" 
                                , successFn : function(){
                                        goList();
                                  }
                                , failFn  : function(){ 
                                        $.opnt.msg.showMsg("삭제중 장애가 발생했습니다.\n관리자에게 문의하세요.");
                                  } 
                                , menuCd : "region" 
                                , bltnbSerno :  '<c:out value="${resultMap.bltnbSerno}"/>' 
                                        
                         });  
           });
           
           // 목록 버튼
           $("#btn_list").on("click", () => {
                goList ();
           });
            
          
           function goList (){
                $.opnt.html.dynaGenHiddenForm({ formDefine : { fid: "regionListForm", action: "/ma/board/regionlist.do", method: "post", isSubmit : true }
                                              , formAttrs  : { condition : { name : "searchCondition" , val: JSON.stringify(${param.searchCondition}) } 
                                                             }
                });
           }
            
    });  
</script>
<div class="tbl">
    <form id="defaultFrm" name="defaultFrm" action="" method="post" onsubmit="return false;">
         <div class="board_top"></div>
            <table class="board_view">
                <colgroup>
                    <col class="w15p">
                    <col class="">
                    <col class="w15p">
                    <col class="">
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">기관명</th>
                        <td><c:out value="${resultMap.bltnbTitl}"/></td>
                        <th scope="row">홈페이지 url</th>
                        <td><a href="<c:out value="${resultMap.bltnbCtt}"/>" target="_blank" title="새 창 열림"><c:out value="${resultMap.bltnbCtt}"/></a></td>
                    </tr>
                    <tr>
                        <th><strong>로고 파일</strong></th>
                        <td colspan="3">
                            <div id="atchFileUpload"></div>
                        </td>
                    </tr>
                </tbody>
            </table>
    </form>
    <div class="btn_area">
        <button type="button" id="btn_update" class="btn blue">수정</button>
        <button type="button" id="btn_del" class="btn red">삭제</button>
        <button type="button" id="btn_list" class="btn gray">목록</button>
    </div>
</div>