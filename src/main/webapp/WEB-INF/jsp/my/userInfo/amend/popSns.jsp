<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<%
	/* sns 로그인 api 콜백 후 redirect url 세션에 저장 */
    session.setAttribute("sns_returnUrl", "/my/userInfo/amend/snsConn.do");
%>
<div class="pop_header">
    <h2>SNS 연동</h2>
    <button type="button" class="pop_close" onclick="view_hide(1);"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="max-height: 300px;" data-simplebar data-simplebar-auto-hide="false">
	<ul class="mypage btns">
		<li><a href="/oauth/naver" id="btn_naver"><img src="/ft/images/icon/i_sign_naver.png" alt="">
            <p>네이버 연동</p>
        </a></li>
		<li><a href="/oauth/kakao" id="btn_kakao"><img src="/ft/images/icon/i_sign_kakao.png" alt="">
			<p>카카오 연동</p>
		</a></li>
	</ul>
</div>