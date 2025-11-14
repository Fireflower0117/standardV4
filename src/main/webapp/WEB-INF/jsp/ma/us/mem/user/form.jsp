<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY and userVO.lockYn eq 'Y' }">
	<%-- 잠금 해제 --%>
	const fncUserUnlock = function(){
		$.ajax({
			 type : 'patch'
			,url : 'unlockProc'
			,data : {'schEtc11' : '<c:out value="${userVO.userSerno}"/>'}
			,dataType : 'json'
			,success : function(data) {
				if(data.result > 0){
					alert('잠금해제가 완료되었습니다.');
					fncPageBoard('update','updateForm.do','<c:out value="${userVO.userSerno}"/>');
				}
			}
			,error: function (xhr, status, error) {

				if (xhr.status == 401) {
					window.location.reload();
				}
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
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
</c:if>
<%-- 비밀번호 변경 여부에 따른 속성변경 --%>
const fncSetPswd = function(){
	
	let obj = $('#cbx_pswd');
	
	if($(obj).is(':checked')){
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
			$('#userPswd').parent().append('<p class="error_txt disin">비밀번호를 입력해주세요.</p>');
			$('#userPswd').focus();
			return false;
		}
		if(!$('#re_userPswd').val()){
			$('#re_userPswd').parent().append('<p class="error_txt disin">비밀번호를 입력해주세요.</p>');
			$('#re_userPswd').focus();
			return false;
		}
		
		if($('#userPswd').val() === $('#re_userPswd').val()){
			return true;
		}else{
			$('#re_userPswd').parent().append('<p class="error_txt disin">비밀번호가 일치하지 않습니다.</p>');
			return false;
		}
	}
	
	return true;
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
$(document).ready(function(){
	
	<%-- 비밀번호 변경 여부에 따른 속성변경 --%>
	fncSetPswd();
	
	<%-- 주소 찾기 --%>
	$('#postNo, #btn_findAddr').on('click', function(){
		fncFindAddr();
	});
	
	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY and userVO.lockYn eq 'Y' }">
		<%-- 잠금 해제 --%>
		$('#btn_unlock').on('click', function(){
			fncUserUnlock();
		});
	</c:if>
	
	<%-- 수정 --%>
	$('#btn_submit').on('click', function(){
		if(fncCheckPswd()){
			if(wrestSubmit(document.defaultFrm)){
				fncProc('update');
			}
		}
	});
	
	<%-- 비밀번호 변경 클릭시 --%>
	$('#cbx_pswd').on('click', function(){
		<%-- 비밀번호 변경 여부에 따른 속성변경 --%>
		fncSetPswd();
	});
});
</script>
<form:form modelAttribute="userVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="userSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(아이디, 이름, 비밀번호, 전화번호, 이메일, 우편번호, 주소, 권한, 차단여부, 사용여부, SNS계정 연동여부로 구성)</caption>
		<colgroup>
			<col class="w10p"/>
			<col/>
			<col class="w10p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>아이디</th>
				<td><c:out value="${userVO.userId }"/><form:hidden path="userId"/></td>
				<th scope="row"><span class="asterisk">*</span>이름</th>
				<td><form:input path="userNm" title="이름" cssClass="w100p" maxlength="30" required="true"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>비밀번호</th>
				<td>
					<form:password path="userPswd" cssClass="w50p" title="비밀번호" pattern="${sessionScope.lginPlcy_info.regepsPswd }" maxlength="20" required="true" autocomplete="off"/>
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
				<td><form:input path="userTelNo" value="${util:getDecryptAES256(userVO.userTelNo) }" cssClass="numOnly" title="전화번호" pattern="${sessionScope.lginPlcy_info.regepsPhone }" maxlength="11" required="true" /></td>
				<th scope="row"><span class="asterisk">*</span>이메일</th>
				<td><form:input path="userEmailAddr" title="이메일" cssClass="w100p" pattern="${sessionScope.lginPlcy_info.regepsEmail }" maxlength="100" required="true"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>우편번호</th>
				<td colspan="3">
					<form:input path="postNo" cssClass="numOnly" title="우편번호" maxlength="5" required="true"/>
					<button type="button" id="btn_findAddr" class="btn sml">주소찾기</button>
				</td>
			</tr>
			<tr>
				<th scope="row" rowspan="2"><span class="asterisk">*</span>주소</th>
				<td colspan="3">
					<form:input path="homeAddr" title="주소" cssClass="w100p" maxlength="60" required="true"/>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<form:input path="homeAddrDtls" title="상세주소" cssClass="w100p" maxlength="60" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>권한</th>
				<td>
					<form:hidden path="authAreaCd"/>
					<form:select path="grpAuthId" title="권한" cssClass="w30p" required="true">
	                    <c:forEach var="auth" items="${authList}" varStatus="status">
	                    	<form:option value="${auth.grpAuthId }" label="${auth.grpAuthNm }"/>
	                    </c:forEach>
	                </form:select>
				<th scope="row">SNS 계정 연동여부</th>
              	<td>
              		<ul class="sns_linkage">
					    <li class="naver ${userVO.snsSeCd eq 'N' ? 'on' : '' }">네이버 연동 완료</li>
					    <li class="kakao ${userVO.snsSeCd eq 'K' ? 'on' : '' }">카카오 연동 완료</li>
					</ul>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>차단여부</th>
				<td>
					<span class="chk">
					    <span class="radio"><form:radiobutton path="brkYn" id="brkYn_Y" title="차단여부" value="Y" required="true" checked="true"/><label for="brkYn_Y">차단</label></span>
					    <span class="radio"><form:radiobutton path="brkYn" id="brkYn_N" title="차단여부" value="N" required="true"/><label for="brkYn_N">미차단</label></span>
					</span>
				</td>
				<th scope="row"><span class="asterisk">*</span>사용여부</th>
				<td>
					<span class="chk">
					    <span class="radio"><form:radiobutton path="useYn" id="useYn_Y" title="사용여부" value="Y" required="true" checked="true"/><label for="useYn_Y">사용</label></span>
					    <span class="radio"><form:radiobutton path="useYn" id="useYn_N" title="사용여부" value="N" required="true"/><label for="useYn_N">미사용</label></span>
					</span>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY and userVO.lockYn eq 'Y' }"><button type="button" id="btn_unlock" class="btn blue"><i class="xi-unlock"></i>잠금해제</button></c:if>
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY }">
		<button type="button" id="btn_submit" class="btn blue">수정</button>
	    <button type="button" id="btn_del" class="btn red">삭제</button>
	</c:if>
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
