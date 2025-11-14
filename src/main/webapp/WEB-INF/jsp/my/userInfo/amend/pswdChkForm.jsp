<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/member.js"></script>
<script type="text/javascript">
<%-- 비밀번호 재확인 --%>
const fncPswdCheck = function(){
	if(wrestSubmit(document.defaultFrm)){
		$.ajax({
	        url: "pswdChkProc"
	       ,type: "post"
	       ,data: $("#defaultFrm").serialize()
	       ,dataType: "json"
	       ,success: function(data){
	        	if(data.result){
	        		location.href = data.returnUrl;
	        	} else{
		        	alert(data.message);
	        	}
	        }
	       ,error: function(xhr, status, error){
	    	   
	    	   if (xhr.status == 401) {
			  		window.location.reload();
				}
	    	   
	    	   $('.error_txt').remove();
				let errors = xhr.responseJSON;
				
				for (let i = 0; i < errors.length; i++) {
   				    let e = errors[i];
				    $('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
   				}
	        }
	       ,beforeSend : function(){
   			fncLoadingStart();
	   		}
	   	    ,complete 	: function(){
	   	    	fncLoadingEnd();
	   			return false;
	   		}
	    });
	}
}
const enterkey = function() {
    if (window.event.keyCode == 13) {
    	fncPswdCheck();
    }
}
$(document).ready(function(){
	<%-- 확인버튼 클릭시 --%>
	$('#btn_submit').on('click', function(){
		<%-- 비밀번호 재확인 --%>
		fncPswdCheck();
	});
	
	<%-- 취소버튼 클릭시 --%>
	$('#btn_cancel').on('click', function(){
		location.href = 'list.do';		
	});
});
</script>
<form id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;" onkeydown="enterkey();">
	<div class="login_wrap">
	    <div class="login_box change_box">
	    	<h1 class="logo"><img src="/ft/images/common/logo2.png" alt="로고"></h1>
	        <div class="box">
	            <b>안전한 사용을 위해 비밀번호를 다시 한 번 입력해주세요.</b>
	            <form>
	                <fieldset>
	                    <div class="input_box">
	                        <ul>
	                            <li>
	                                <label for="userId">아이디</label>
	                                <span>
	                                	<c:out value="${sessionScope.ft_user_info.userId }"/>
	                                	<input type="hidden" id="userId" name="userId" value="<c:out value="${sessionScope.ft_user_info.userId }"/>"/>
	                                </span>
	                            </li>
	                            <li>
	                                <label for="userPswd">비밀번호</label>
                                	<input type="password" id="userPswd" name="userPswd" title="비밀번호" <c:if test="${not empty sessionScope.lginPlcy_info.regepsPswd}">pattern="<c:out value='${sessionScope.lginPlcy_info.regepsPswd }'/>"</c:if> maxlength="20" required="true" autocomplete="off"/>
	                            </li>
	                        </ul>
	                    </div>
	                    <div class="btn_area">
	                        <button type="button" id="btn_cancel" class="btn gray btn_change">취소</button>
	                        <button type="button" id="btn_submit" class="btn blue btn_change">확인</button>
	                    </div>
	                </fieldset>
	            </form>
	        </div>
	    </div>
	</div>
</form>