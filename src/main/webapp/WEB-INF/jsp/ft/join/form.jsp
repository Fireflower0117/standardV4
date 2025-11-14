<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
<%-- 아이디 중복체크 결과 --%>
let overChkResult = false;
<%-- 아이디 중복체크 --%>
const fncUserIdOverChk = function(){
	if($('#userId').val()){
		$.ajax({
			 url: 'userIdOverChk'
			,type: 'post'
			,data: {'userId' : $('#userId').val()}
			,dataType: 'json'
			,success: function(data){
				$('#idOverCheck_msg').text(data.message);
				overChkResult = data.result;
				view_show(1);
			}
			,error: function(xhr, status, error){
				let errors = xhr.responseJSON;
				alert(errors[0].defaultMessage);
			}
		});
	} else {
		alert('아이디를 입력해주세요.');
		return false;
	}
}
<%-- 주소 API --%>
const fncFindAddr = function(){
	new daum.Postcode({
        oncomplete: function(data) {
            <%-- 우편번호 --%>
            let post = data.zonecode;
            <%-- 도로명 주소 변수 --%>
            let roadAddr = data.roadAddress;
            <%-- 지번 주소 변수 --%>
            let jibunAddr = data.jibunAddress
            
			$('#postNo').val(post);
			$('#homeAddr').val(roadAddr);
			$("#homeAddrDtls").focus();
        }
    }).open();
}
<%-- 아이디 중복 여부 --%>
const fncCheckId = function(){
	if(overChkResult){
		return true;
	} else {
		$('.form_group.id').after('<p class="error_txt msg_only">아이디 중복확인을 해주세요.</p>');
		$('#userId')[0].scrollIntoView({behavior:'smooth', block:'center'});
		return false;
	}
	
}
<%-- 비밀번호 일치 여부 --%>
const fncCheckPswd = function(){
	$('#re_userPswd').siblings('.error_txt').remove();
	
	if($('#userPswd').val() === $('#re_userPswd').val()){
		return true;
	}else{
		$('#re_userPswd').after('<p class="error_txt msg_only">비밀번호가 일치하지 않습니다.</p>');
		return false;
	}
}
<%-- 회원가입 처리 --%>
const fncJoinProc = function(){
	if(wrestSubmit(document.defaultFrm)){
		<%-- 아이디 중복 여부, 비밀번호 일치 여부 체크 --%>
		if(fncCheckId() && fncCheckPswd()){
			$.ajax({
		        url: "joinProc"
		       ,type: "post"
		       ,data: $("#defaultFrm").serialize()
		       ,dataType: "json"
		       ,success: function(data){
		        	alert(data.message);
		        	if(data.result){
		        		location.href = data.returnUrl;
		        	} else {
		        		if(data.returnUrl){
			        		location.href = data.returnUrl;
		        		}
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
$(document).ready(function(){
	
	<%-- 아이디 중복체크 --%>
	$('#btn_idChk').on('click', function(){
		fncUserIdOverChk();
	});
	
	<%-- 주소 찾기 --%>
	$('#postNo, #btn_findAddr').on('click', function(){
		fncFindAddr();
	});
	
	<%-- 회원가입 --%>
	$('#btn_submit').on('click', function(){
		fncJoinProc();
	});
	
	<%-- 아이디 중복체크 결과 팝업 --%>
	$('#btn_pop_close, .pop_close').on('click', function(){
		view_hide(1);
	});
});
</script>
<ul class="step">
    <c:if test="${fn:length(sessionScope.ft_termsList) > 0}"><li><a href="javascript:void(0);">약관동의</a></li></c:if>
    <c:if test="${empty sessionScope.sns_user_info }"><li><a href="javascript:void(0);">본인인증</a></li></c:if>
    <li><a href="javascript:void(0);" class="current">정보입력</a></li>
    <li><a href="javascript:void(0);">가입완료</a></li>
</ul>
<form id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
	<div class="join form mar_t3p">
	    <b class="page_tit">
	        회원정보 입력
	    </b>
	    <div class="form_box">
            <div class="form_guide"><span class="asterisk">*</span> 필수입력</div>
            <ul>
                <li>
                    <label for="userId" class="tit required">아이디</label>
                    <div class="form_group id">
                    	<input type="text" id="userId" name="userId" title="아이디" pattern="<c:out value="${sessionScope.lginPlcy_info.regepsId }"/>" maxlength="30" required="true"/>
                        <button type="button" id="btn_idChk" class="btn bd blue">중복확인</button>
                    </div>
                </li>
                <li>
                    <label for="userPswd" class="tit required">비밀번호</label>
                    <input type="password" id="userPswd" name="userPswd" title="비밀번호" pattern="<c:out value="${sessionScope.lginPlcy_info.regepsPswd }"/>" maxlength="20" required="true" autocomplete="off"/>
                </li>
                <li>
                    <label for="re_userPswd" class="tit required">비밀번호 확인</label>
                    <input type="password" id="re_userPswd" name="re_userPswd" title="비밀번호 확인" maxlength="20" required="true" placeholder="비밀번호를 다시 한번 입력해주세요." autocomplete="off"/>
                </li>
                <li>
                    <label for="userNm" class="tit required">이름</label>
                    <input type="text" id="userNm" name="userNm" title="이름" maxlength="30" required="true" placeholder="이름을 입력해주세요."/>
                </li>
                <li>
                	<label for="postNo" class="tit required">주소</label>
                	 <div class="form_group">
                        <input type="text" id="postNo" name="postNo" class="numOnly w20p mar_b10" title="우편번호" maxlength="5" required="true" placeholder="우편번호"/>
                        <button type="button" id="btn_findAddr" class="btn bd blue">주소찾기</button>
                    </div>
                    <input type="text" id="homeAddr" name="homeAddr" class="mar_b10" title="주소" maxlength="60" required="true" placeholder="주소를 입력해주세요."/>
                    <input type="text" id="homeAddrDtls" name="homeAddrDtls" title="상세주소" maxlength="60" required="true" placeholder="상세주소를 입력해주세요."/>
                </li>
                <li>
                    <label for="userTelNo" class="tit required">휴대전화번호</label>
                   	<input type="text" id="userTelNo" name="userTelNo" class="numOnly" title="휴대전화번호" pattern="<c:out value="${sessionScope.lginPlcy_info.regepsPhone }"/>" maxlength="11" required="true"/>
                </li>
                <li>
                    <label for="userEmailAddr" class="tit required">이메일</label>
                    <input type="text" id="userEmailAddr" name="userEmailAddr" title="이메일" pattern="<c:out value="${sessionScope.lginPlcy_info.regepsEmail }"/>" maxlength="100" required="true"/>
                </li>
            </ul>
        </div>
        <div class="btn_area">
            <button type="button" id="btn_submit" class="btn blue btn_join">확인</button>
        </div>
	</div>
</form>
<!-- 아이디 중복확인 팝업 -->
<div id="display_view1" class="layer_pop js_popup w340px">
    <div class="pop_header">
        <h2>중복확인</h2>
        <button type="button" class="pop_close"><i class="xi-close-thin"></i>닫기</button>
    </div>
    <div class="pop_content">
        <p id="idOverCheck_msg" class="c"></p>
        <div class="btn_area c">
            <button type="button" id="btn_pop_close" class="btn blue">확인</button>
        </div>
    </div>
</div>
