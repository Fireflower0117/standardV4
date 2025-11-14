<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
<%-- 비밀번호 변경 체크 여부에 따른 속성변경 --%>
const fncSetPswd = function(){
	
	let $cbx = $('#cbx_pswd');
	
	if($cbx.is(':checked')){
		$('input[name*="userPswd"]').prop({'readonly' : false, 'disabled' : false, 'required' : true});
	}else{
		$('input[name*="userPswd"]').prop({'readonly' : true, 'disabled' : true, 'required' : false}).val('');
	}
}

<%-- 비밀번호 일치 여부 --%>
const fncCheckPswd = function(){
	$('#re_userPswd').siblings('.error_txt').remove();
	
	if($('#cbx_pswd').is(':checked')){
		if(!$('#userPswd').val()){
			$('#userPswd').siblings().after('<p class="error_txt disin">비밀번호를 입력해주세요.</p>');
			$('#userPswd').focus();
			return false;
		}
		if(!$('#re_userPswd').val()){
			$('#re_userPswd').after('<p class="error_txt disin">비밀번호를 입력해주세요.</p>');
			$('#re_userPswd').focus();
			return false;
		}
		
		if($('#userPswd').val() === $('#re_userPswd').val()){
			return true;
		}else{
			$('#re_userPswd').after('<p class="error_txt disin">비밀번호가 일치하지 않습니다.</p>');
			return false;
		}
	}
	
	return true;
}
<%-- 주소 API --%>
const fncFindAddr= function(){
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
<%-- 수정 처리 --%>
const fncUpdateProc = function(){
	if(fncCheckPswd()){
		if(wrestSubmit(document.defaultFrm)){
			$.ajax({
				type : 'patch'
				,url : 'proc'
				,data : $('#defaultFrm').serialize()
				,dataType : 'json'
				,success : function(data) {
					alert(data.message);
					location.href = data.returnUrl;
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
						    $('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
		   				}
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
	<%-- 비밀번호 변경 체크 여부에 따른 속성변경 --%>
	fncSetPswd();
	
	<%-- 주소 찾기 --%>
	$('#postNo, #btn_findAddr').on('click', function(){
		fncFindAddr();
	});
	
	<%-- 비밀번호 변경 클릭시 --%>
	$('#cbx_pswd').on('click', function(){
		fncSetPswd();
	});

	<%-- 수정 --%>
	$('#btn_submit').on('click', function(){
		fncUpdateProc();
	});
	
	<%-- 취소 --%>
	$('#btn_cancel').on('click', function(){
		location.href = 'list.do';		
	});
});
</script>
<div class="sidebyside">
   	<div class="left">
		<h4 class="md_tit">개인정보 수정</h4>
	</div>
</div>
<form name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(아이디, 이름, 휴대전화번호, 이메일, 우편번호, 주소, SNS계정 연동여부로 구성)</caption>
		<colgroup>
			<col class="w10p"/>
			<col/>
			<col class="w10p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>아이디</th>
				<td>
					<c:out value="${sessionScope.ft_user_info.userId }"/><input type="hidden" id="userId" name="userId" value="<c:out value="${sessionScope.ft_user_info.userId }"/>"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>이름</th>
				<td><input type="text" id="userNm" name="userNm" value="<c:out value="${sessionScope.ft_user_info.userNm }"/>" title="이름" class="w100p" maxlength="30" required="true"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>비밀번호</th>
				<td>
					<input type="password" id="userPswd" name="userPswd" class="w50p" title="비밀번호" <c:if test="${not empty sessionScope.lginPlcy_info.regepsPswd}">pattern="<c:out value='${sessionScope.lginPlcy_info.regepsPswd }'/>"</c:if> maxlength="20" required="true" autocomplete="off"/>
					<span class="chk">
	            		<span class="cbx">
	            			<input type="checkbox" id="cbx_pswd"/><label for="cbx_pswd">비밀번호 변경</label>
	            		</span>
	            	 </span>
				</td>
				<th scope="row"><span class="asterisk">*</span>비밀번호재입력</th>
				<td><input type="password" id="re_userPswd" name="re_userPswd" title="비밀번호재입력" class="w50p" maxlength="20" required="true" placeholder="비밀번호를 다시 한번 입력해주세요." autocomplete="off"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>전화번호</th>
				<td><input type="text" id="userTelNo" name="userTelNo" value="<c:out value="${util:getDecryptAES256(sessionScope.ft_user_info.userTelNo) }"/>" class="numOnly" title="전화번호" <c:if test="${not empty sessionScope.lginPlcy_info.regepsPhone}">pattern="<c:out value='${sessionScope.lginPlcy_info.regepsPhone }'/>"</c:if> maxlength="11" required="true" /></td>
				<th scope="row"><span class="asterisk">*</span>이메일</th>
				<td><input type="text" id="userEmailAddr" name="userEmailAddr" value="<c:out value="${sessionScope.ft_user_info.userEmailAddr }"/>" class="w100p" title="이메일" <c:if test="${not empty sessionScope.lginPlcy_info.regepsEmail}">pattern="<c:out value='${sessionScope.lginPlcy_info.regepsEmail }'/>"</c:if> maxlength="100" required="true" /></td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>우편번호</th>
				<td colspan="3">
					<input type="text" id="postNo" name="postNo" value="<c:out value="${sessionScope.ft_user_info.postNo }"/>" title="우편번호" maxlength="5" required="true"/>
					<button type="button" id="btn_findAddr" class="btn sml">주소찾기</button>
				</td>
			</tr>
			<tr>
				<th scope="row" rowspan="2"><span class="asterisk">*</span>주소</th>
				<td colspan="3">
					<input type="text" id="homeAddr" name="homeAddr" value="<c:out value="${sessionScope.ft_user_info.homeAddr }"/>" class="w100p" title="주소" maxlength="60" required="true"/>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input type="text" id="homeAddrDtls" name="homeAddrDtls" value="<c:out value="${sessionScope.ft_user_info.homeAddrDtls }"/>" class="w100p" title="상세주소" maxlength="60" required="true"/>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<div class="btn_area">
	<button type="button" id="btn_submit" class="btn blue">수정</button>
	<button type="button" id="btn_cancel" class="btn gray">취소</button>
</div>
