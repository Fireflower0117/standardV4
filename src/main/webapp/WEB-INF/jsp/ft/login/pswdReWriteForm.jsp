<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/member.js"></script>
<script type="text/javascript">
<%-- 비밀번호 일치 여부 --%>
const fncCheckPswd = function(){
	$('#re_userPswd').siblings('.error_txt').remove();
	
	if($('#userPswd').val() === $('#re_userPswd').val()){
		return true;
	}else{
		$('#re_userPswd').after('<p class="error_txt">비밀번호가 일치하지 않습니다.</p>');
		return false;
	}
}
<%-- 비밀번호 수정 처리 --%>
const fncPswdReWriteProc = function(){
	if(wrestSubmit(document.defaultFrm)){
		<%-- 비밀번호 일치 여부 체크 --%>
		if(fncCheckPswd()){
			$.ajax({
		        url: "pswdReWriteProc"
		       ,type: "patch"
		       ,data: $("#defaultFrm").serialize()
		       ,dataType: "json"
		       ,success: function(data){
		        	alert(data.message);
		        	if(data.result){
		        		location.href = data.returnUrl;
		        	}
		        }
		       ,error: function (xhr, status, error) {
	         		
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
}
<%-- 다음에 변경 처리 --%>
const fncChgNext = function(){
	if(confirm("다음에 변경하시겠습니까?")){
		$.ajax({
	        url: "lastPswdChgDtUpdateProc"
           ,data: $("#defaultFrm").serialize()
	       ,type: "patch"
	       ,dataType: "json"
	       ,success: function(data){
	        	if(!data.result){
	        		alert(data.message);
	        	}
        		location.href = data.returnUrl;
	        }
	       ,error: function (xhr, status, error) {
        		
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
$(document).ready(function(){
	<%-- 비밀번호 수정 --%>
	$('#btn_submit').on('click', function(){
		fncPswdReWriteProc();
	});
	
	<%-- 다음에 변경 --%>
	$('#btn_cancel').on('click', function(){
		fncChgNext();
	});
});
</script>
<form id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
	<div class="login_wrap">
	    <div class="login_box change_box">
	    	<h1 class="logo"><img src="images/common/logo2.png" alt="로고"></h1>
	        <div class="box">
	            <b>마지막 비밀번호 변경일로부터 <c:out value="${sessionScope.ft_user_info.pswdChgDt }"/>일이 지났습니다.</br>비밀번호를 다시 설정해 주세요.</b>
                <fieldset>
                    <div class="input_box">
                        <ul>
                            <li>
                                <label for="">아이디</label>
                                <span>
                                	<c:out value="${sessionScope.ft_user_info.userId }"/>
                                	<input type="hidden" id="userId" name="userId" value="<c:out value="${sessionScope.ft_user_info.userId }"/>"/>
                                </span>
                            </li>
                            <li>
                                <label for="beforeUserPswd">이전 비밀번호</label>
                                <input type="password" id="beforeUserPswd" name="beforeUserPswd" title="이전 비밀번호" maxlength="20" required="true" autocomplete="off"/>
                            </li>
                            <li>
                                <label for="userPswd">새 비밀번호</label>
                                <input type="password" id="userPswd" name="userPswd" title="비밀번호" pattern="<c:out value="${sessionScope.lginPlcy_info.regepsPswd }"/>" maxlength="20" required="true" autocomplete="off"/>
                            </li>
                            <li>
                                <label for="re_userPswd">새 비밀번호 확인</label>
                                <input type="password" id="re_userPswd" name="re_userPswd" title="비밀번호 확인" placeholder="비밀번호를 다시 한번 입력해주세요." maxlength="20" required="true" autocomplete="off"/>
                            </li>
                        </ul>
                    </div>
                    <div class="btn_area">
                        <button type="button" id="btn_submit" class="btn blue btn_change">확인</button>
                        <button type="button" id="btn_cancel" class="btn gray btn_change"><c:out value="${sessionScope.lginPlcy_info.pwdChgCyclDd }"/>일후에 변경하기</button>
                    </div>
                </fieldset>
	        </div>
	    </div>
	</div>
</form>