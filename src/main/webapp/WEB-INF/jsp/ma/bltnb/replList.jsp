<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	const fncProcAjax = function(type){
		var procType;
		if(type == 'replUpdate'){
			procType = 'patch';
		}else if(type == 'replDelete'){
			procType = 'delete';
		}
		
		$.ajax({
			type : procType
			,url : 'replProc'
			,data : $('#defaultFrm').serialize()
			,dataType : 'json'
			,success : function(data) {
				alert(data.message);
				<%-- 댓글목록 다시 불러오기 --%>
					fncCallReplList();
			}
			,error: function (xhr, status, error) {
				if (xhr.status == 401) {
			  		window.location.reload();
				}
				
				$('.error_txt').remove();
				let errors = xhr.responseJSON;
				
				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					for (let i = 0; i < errors.length; i++) {
					    let e = errors[i];
						
					    if(e.codes.some(item => item.includes('java.util.List'))){
					    	alert(e.defaultMessage);
					    	
					    } else{
						    $('#' + e.field).parent().append('<p class="error_txt">' + e.defaultMessage + '</p>');
					    }
					    
					}
				}
		    },beforeSend : function(req){
				fncLoadingStart();
			},complete : function(){
				fncLoadingEnd();
			}
		});
	}
	
	<%-- 댓글 수정 폼 변경 --%>
	const fncReplModifyForm = function(index,replSerno){
		var html = '<textarea name="replCtt" rows="3" placeholder="0자 이내" id="replCtt_'+index+'">' + $("#repl_ctt_"+index).text() + '</textarea>'
		         + '<button type="button" class="btn blue btn_repl_modify">수정</button>'
		         + '<button type="button" class="btn gray btn_repl_cancle">취소</button>';
		$("#repl_btn_box_"+index).addClass("disno");
		$("#repl_ctt_"+index).addClass("disno");
		$("#repl_write_box_"+index).append(html);		
	}
	
	<%-- 대댓글 리스트 생성 --%>
	const fncCallReplReplList = function(index,replSerno){
		$.ajax({
			type : 'post'
			,url : 'replOfRepl'
			,data : $('#defaultFrm').serialize()
			,dataType : 'JSON'
			,success : function(data) {
				
				var html = "";
                <%-- 댓글 리스트 생성 --%>
                for(var i =0; i < data.returnData.length; i++){
                	html += '<li>'
                		  + 	'<div class="info">'
                		  + 		'<span>' + data.returnData[i].replRegrNm + '</span>'
                		  + 		'<span>' + data.returnData[i].replRegDt + '</span>'
                		  + 	'</div>'
                	<%-- 관리자 권한 있을 경우메만 생성--%>
                	if("${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }" == "true"){
                		html += '<div class="btns" id="repl_btn_box_' + index + '_' + i + '" data-index="' + index + '_' + i + '" data-replserno="' + data.returnData[i].replSerno + '">'
                		      + 	'<button class="btn sml btn_repl_modify_form">수정</button>'
                		      + 	'<button class="btn sml gray btn_repl_delete mar_l5">삭제</button>'
                		      + '</div>';
                    }
                	<%-- 댓글 내용 / 수정 폼 생성 --%>	  
                	html += 	'<p id="repl_ctt_' + index + '_' + i + '">' + data.returnData[i].replCtt + '</p>'
                		  + 	'<div class="write_box" id="repl_write_box_' + index + '_' + i + '" data-index="' + index + '_' + i + '" data-replserno="' + data.returnData[i].replSerno + '">'
                		  + 	'</div>'
                		  + '</li>';
                		 
                }		 
				$("#reply_ul_"+index).html(html);
			},error: function (xhr, status, error) {
				if (xhr.status == 401) {
			  		window.location.reload();
				}
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		    }
		});
	}
	
	<%-- 댓글수정 --%>
	$(document).on("click", ".btn_repl_modify", function(e){
		e.stopImmediatePropagation()
		<%-- 관리자 권한 있을 경우메만 실행 --%>
		if("${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }"){
			<%-- 댓글이 빈 값이 아닐때만 실행 --%>
			if($("#replCtt_"+$(this).parent().data("index")).val() != null && $("#replCtt_"+$(this).parent().data("index")).val() != ""){
				$('textarea[name="replCtt"]').prop("disabled", true);
				$("#replCtt_"+$(this).parent().data("index")).prop("disabled", false);
				$("#replSerno").val($(this).parent().data("replserno"));
				fncProcAjax('replUpdate');
			}else{
				alert("댓글을 작성후 수정해주세요.")
				$("#replCtt_"+$(this).parent().data("index")).focus();
			}
		}else{
			alert("댓글을 수정할 권한이 없습니다.");
		}
	});

	<%-- 댓글수정 취소--%>
	$(document).on("click", ".btn_repl_cancle", function(e){
		e.stopImmediatePropagation()
		$("#repl_ctt_"+$(this).parent().data("index")).removeClass("disno");
		$("#repl_btn_box_"+$(this).parent().data("index")).removeClass("disno");
		$("#repl_write_box_"+$(this).parent().data("index")).html("");	
	});

	<%-- 댓글수정 폼 변경--%>
	$(document).on("click", ".btn_repl_modify_form", function(e){
		e.stopImmediatePropagation()
		<%-- 관리자 권한 있을 경우메만 실행 --%>
		if("${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }"){
			fncReplModifyForm($(this).parent().data('index'),$(this).parent().data('replserno'));
		}else{
			alert("댓글을 수정할 권한이 없습니다.");
		}
	});

	<%-- 댓글 삭제--%>
	$(document).on("click", ".btn_repl_delete", function(e){
		e.stopImmediatePropagation()
		<%-- 관리자 권한 있을 경우메만 실행 --%>
		if("${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }"){
			if(confirm("댓글을 삭제하시겠습니까?")){
				$("#replSerno").val($(this).parent().data("replserno"));
				fncProcAjax('replDelete');
			}
		}else{
			alert("댓글을 삭제할 권한이 없습니다.");
		}
		
	});

	<%-- 댓글의 답변 열기--%>
    $('.js_reReply').on("click",function () {
	    $(this).parents('.reply_box').siblings('.re_reply').toggle();
	    $("#replSerno").val($(this).data("replserno"));
	    fncCallReplReplList($(this).data('index'),$(this).data("replserno"));
    });
});
</script>     
<input type="hidden" name="replSerno" id="replSerno">
<input type="hidden" name="uprReplSerno" id="uprReplSerno">
<div class="cmnt_list">
	<span class="cmnt_num">댓글<strong><c:out value="${replCount}"/></strong>건</span>
	<ul class="list">
		<c:if test="${fn:length(replList) > 0 }">
			<c:forEach var="result" items="${replList}" varStatus="status">
			            <li>
			                <div class="reply_box">
			                    <div class="reply_txt">
			                        <div class="info">
			                            <span><c:out value="${result.replRegrNm}"/></span>
			                            <span><c:out value="${result.replRegDt}"/></span>
			                        </div>
			                        <c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }">
				                        <div class="btns" id="repl_btn_box_<c:out value='${status.index}'/>" data-index="<c:out value="${status.index}"/>" data-replserno="<c:out value="${result.replSerno}"/>">
				                            <button class="btn sml btn_repl_modify_form">수정</button>
				                            <button class="btn sml gray btn_repl_delete">삭제</button>
				                        </div>
			                        </c:if>
			                        <p id="repl_ctt_<c:out value='${status.index}'/>"><c:out value="${result.replCtt}"/></p>
			                        <div class="write_box" id="repl_write_box_<c:out value='${status.index}'/>" data-index="<c:out value="${status.index}"/>" data-replserno="<c:out value="${result.replSerno}"/>" data-replregrserno="<c:out value="${result.replRegrSerno}"/>">
			                        </div> 
			                        <div class="btn_area">
			                            <button type="button" class="btn reply icl js_reReply" data-index="<c:out value="${status.index}"/>" data-replserno="<c:out value="${result.replSerno}"/>" data-replCnt="<c:out value="${result.replCnt}"/><"><i class="xi-speech-o"></i>답글<strong><c:out value="${result.replCnt}"/></strong></button>
			                        </div>
			                    </div>
			                </div>
			                <div class="re_reply">
			                    <ul id="reply_ul_<c:out value='${status.index}'/>"> 
			                    </ul>
			                </div>
			      		</li>
			</c:forEach>
		</c:if>
	</ul>
</div>
