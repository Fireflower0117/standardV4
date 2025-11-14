<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<%
	/* sns 로그인 api 콜백 후 redirect url 세션에 저장 */
    session.setAttribute("sns_returnUrl", "/my/userInfo/amend/snsVrfct.do");
%>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 취소버튼 클릭시 --%>
	$('#btn_cancel').on('click', function(){
		location.href = 'list.do';		
	});
});
</script>
<form id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
	<div class="join sign mar_t5p">
	    <b class="page_tit">
	        본인인증
	        <span>본인인증 방법을 선택해 주세요.</span>
	    </b>
	    <ul class="btns">
	        <c:if test="${sessionScope.ft_user_info.snsSeCd eq 'N' }">
		        <li><a href="/oauth/naver" id="btn_naver"><img src="/ft/images/icon/i_sign_naver.png" alt="">
		            <p>네이버 본인인증</p>
		        </a></li>
	        </c:if>
	        <c:if test="${sessionScope.ft_user_info.snsSeCd eq 'K' }">
		        <li><a href="/oauth/kakao" id="btn_kakao"><img src="/ft/images/icon/i_sign_kakao.png" alt="">
		            <p>카카오 본인인증</p>
		        </a></li>
	        </c:if>
	        <li><a href="pswdChkForm.do"><img src="/ft/images/icon/i_sign_lock.png" alt="">
	            <p>휴대폰 본인인증</p>
	        </a></li>
	        <li><a href="pswdChkForm.do"><img src="/ft/images/icon/i_sign_lock.png" alt="">
	            <p>현재비밀번호 재확인</p>
	        </a></li>
	    </ul>
	    <p class="sub_txt"><i class="xi-error"></i>본인명의 휴대폰 본인인증 시 제공되는 정보는 해당 인증기관에서 직접 수집하며,<br> 인증 이외의 용도로 이용, 저장하지 않습니다.</p>
	    <div class="btn_area">
            <button type="button" id="btn_cancel" class="btn gray btn_change">취소</button>
        </div>
	</div>
</form>
