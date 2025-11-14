<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$('.btns > li > a').on('click', function(){
		location.href = 'joinForm.do';
	});
});
</script>
<ul class="step">
	<c:if test="${fn:length(sessionScope.ft_termsList) > 0}"><li><a href="javascript:void(0);">약관동의</a></li></c:if>
    <c:if test="${empty sessionScope.sns_user_info }"><li><a href="javascript:void(0);" class="current">본인인증</a></li></c:if>
    <li><a href="javascript:void(0);">정보입력</a></li>
    <li><a href="javascript:void(0);">가입완료</a></li>
</ul>
<form id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
	<div class="join sign mar_t5p">
	    <b class="page_tit">
	        본인인증
	        <span>본인인증 방법을 선택해 주세요.</span>
	    </b>
	    <ul class="btns">
	        <li><a href="javascript:void(0);"><img src="/ft/images/icon/i_sign_kakao.png" alt="">
	            <p>카카오 본인인증</p>
	        </a></li>
	        <li><a href="javascript:void(0);"><img src="/ft/images/icon/i_sign_naver.png" alt="">
	            <p>네이버 본인인증</p>
	        </a></li>
	        <li><a href="javascript:void(0);"><img src="/ft/images/icon/i_sign_lock.png" alt="">
	            <p>휴대폰 본인인증</p>
	        </a></li>
	    </ul>
	    <p class="sub_txt"><i class="xi-error"></i>본인명의 휴대폰 본인인증 시 제공되는 정보는 해당 인증기관에서 직접 수집하며,<br> 인증 이외의 용도로 이용, 저장하지 않습니다.</p>
	</div>
</form>
