<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/member.js"></script>
<%
	/* sns 로그인 api 콜백 후 redirect url 세션에 저장 */
    session.setAttribute("sns_returnUrl", "/ft/snsLogin.do");
%>
<script type="text/javascript">
const fncLogin = function () {
	if(wrestSubmit(document.defaultFrm)){
		<%-- 로그인 처리 --%>
		$.ajax({
			url: "/ft/login.do",
			type: "post",
			data: $("#defaultFrm").serialize(),
			dataType: "json",
			success: function(data){
				if (data.result) {
                 	location.href = data.returnUrl;
             	} else {
                 	alert(data.message);
             	}
         	},
         	error: function (xhr, status, error) {
         		
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
};
const enterkey = function() {
	if (window.event.keyCode == 13) {
		fncLogin();
		return false;
	}
}

$(document).ready(function(){
	<%-- 로그인 클릭시 --%>
	$('#btn_login').on('click', function(){
		fncLogin(); 
		return false;
	});
});
</script>
<div class="login_wrap">
    <div class="login_box">
        <h1 class="logo"><img src="/ma/images/common/logo.png" alt="로고"></h1>
        <form:form modelAttribute="loginVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;" onkeydown="enterkey();">
            <fieldset>
                <div class="input_box">
                    <ul>
                        <li>
                            <label for="userId">아이디</label>
                            <form:input path="userId" title="아이디" maxlength="30" placeholder="아이디를 입력해주세요." required="true"/>
                        </li>
                        <li>
                            <label for="userPswd">비밀번호</label>
                            <form:password path="userPswd" title="비밀번호 입력" pattern="${sessionScope.lginPlcy_info.regepsPswd }" maxlength="20" placeholder="비밀번호를 입력해주세요." required="true" autocomplete="off"/>
                        </li>
                    </ul>
                </div>
                <span class="chk">
                    <span class="cbx"><input type="checkbox" name="saveIdYn" id="saveIdYn" value="Y" <c:out value="${loginVO.saveIdYn eq 'Y' ? 'checked=\"checked\"' : '' }"/>><label for="saveIdYn">아이디 저장</label></span>
                </span>
                <div class="btn_area">
                    <button type="button" id="btn_login" class="btn blue btn_login">로그인</button>
                </div>
                <ul class="links">
                    <li><a href="/ft/findInfoVrfct.do" class="btn_find btn_line">아이디 찾기</a></li>
                    <li><a href="/ft/findInfoVrfct.do" class="btn_find btn_line">비밀번호 찾기</a></li>
                    <li><a href="/ft/join/useAgrTerms.do" class="btn_line blue">회원가입</a></li>
                </ul>
                <div class="member_sns">
                    <strong class="tit"><span>간편 로그인</span></strong>
                    <div class="btn_area">
                        <a href="/oauth/naver" id="btn_naver" class="naver">네이버 로그인</a>
                        <a href="/oauth/kakao" id="btn_kakao" class="kakao">카카오톡 로그인</a>
                    </div>
                </div>
            </fieldset>
        </form:form>
    </div>
</div>
