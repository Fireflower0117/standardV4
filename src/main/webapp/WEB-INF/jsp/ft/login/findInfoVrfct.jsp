<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$('.btns > li > a').on('click', function(){
		location.href = '/ft/findInfoForm.do';
	});
	
	$('#btn_cancel').on('click', function(){
		location.href = '/ft/login.do';
	});
});
</script>
<div class="login_wrap">
    <div class="login_box find_box">
		<form id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
			<div class="join sign mar_t5p">
			    <b class="page_tit">
			        본인인증
			        <span>본인인증 방법을 선택해 주세요.</span>
			    </b>
			    <ul class="btns">
			        <li><a href="javascript:void(0);"><img src="/ft/images/content/img_mail.png" alt="" width="100px" height="100px">
			            <p>이메일 인증</p>
			        </a></li>
			        <li><a href="javascript:void(0);"><img src="/ft/images/icon/i_sign_lock.png" alt="">
			            <p>휴대폰 본인인증</p>
			        </a></li>
			    </ul>
			    <p class="sub_txt"><i class="xi-error"></i>본인명의 휴대폰 본인인증 시 제공되는 정보는 해당 인증기관에서 직접 수집하며,<br> 인증 이외의 용도로 이용, 저장하지 않습니다.</p>
			</div>
		</form>
		<div class="btn_area">
			<button type="button" id="btn_cancel" class="btn gray">취소</button>
		</div>
	</div>
</div>
