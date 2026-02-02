<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 검증용 변수 --%>
<c:if test="${searchVO.procType eq 'insert'}">
	let idChkYn = 'N';
</c:if>
let regepsChkYn = 'N';
<%-- 검증 여부 체크 --%>
const fncValChk = function(){
	
	<c:if test="${searchVO.procType eq 'insert'}">
		if(idChkYn === 'N'){
			alert('정규표현식ID 중복확인을 해주세요.');
			return false;
		}
	</c:if>
	
	if(regepsChkYn === 'N'){
		alert('정규표현식텍스트와 예시를 입력한 후 검증해주세요.');
		return false;
	}
	
	return true;
}
<%-- 정규표현식ID 검증 --%>
const fncRegepsIdChk = function(){
	
	$('.id_msg').remove();
	
	if(!$('#regepsId').val()) {
		alert('정규표현식ID를 입력해주세요.');
		$('#regepsId').focus();
		return false;
	}
	
	$.ajax({
		type : 'post'
	   ,url : 'regepsIdCheckProc'
	   ,data : $('#defaultFrm').serialize()
	   ,dataType : 'json'
	   ,success : function(data){
			if(data.result){
				idChkYn = 'Y';
				$('#regepsId').parent().append("<span class='id_msg blue_txt'>" + data.message + "</span>");
			} else {
				idChkYn = 'N';
				$('#regepsId').parent().append("<span class='id_msg red_txt'>" + data.message + "</span>");
			}
	   }
	   ,error: function (xhr, status, error) {
			
			if (xhr.status == 401) {
		  		window.location.reload();
			} else {
				alert(errors[0].defaultMessage);
			}
	    }
	});
}
<%-- 정규표현식 검증 --%>
const fncRgepsTest = function(){
	
	$('.regeps_msg').remove();
	
	if(!$('#regepsTxt').val()) {
		alert('정규표현식텍스트를 입력해주세요.');
		$('#regepsTxt').focus();
		return false;
	}
	if(!$('#regepsExm').val()) {
		alert('정규표현식예시를 입력해주세요.');
		$('#regepsExm').focus();
		return false;
	}
	
	let regeps = new RegExp($('#regepsTxt').val());
	let exm = $('#regepsExm').val();
	
	if(regeps.test(exm)){
		regepsChkYn = 'Y';
		$('#regepsExm').parent().append("<p class='regeps_msg blue_txt'>정규표현식 검증에 성공하였습니다.</p>");
	} else {
		regepsChkYn = 'N';
		$('#regepsExm').parent().append("<p class='regeps_msg red_txt'>정규표현식 검증에 실패하였습니다.</p>");
	}
}
$(document).ready(function(){
	
	<c:if test="${searchVO.procType eq 'insert'}">
		<%-- 정규표현식ID 입력시 검증 여부 'N' 처리 --%>
		$('#btn_idChk').on('input', function(){
			idChkYn = 'N';
		});
		
		<%-- 정규표현식ID 검증 --%>
		$('#btn_idChk').on('click', function(){
			fncRegepsIdChk();
		});
	</c:if>
	
	<%-- 정규표현식텍스트, 정규표현식예시 입력시 검증 여부 'N' 처리 --%>
	$('#regepsTxt, #regepsExm').on('input', function(){
		regepsChkYn = 'N';
	});
	
	<%-- 정규표현식 검증 --%>
	$('#btn_txtChk').on('click', function(){
		fncRgepsTest();
	});
	
	<%-- 등록,수정 --%>
	$('#btn_submit').on('click', function(){
		if(fncValChk()){
			if(wrestSubmit(document.defaultFrm)){
				fncProc("<c:out value='${searchVO.procType}'/>");
			}
		}
		return false;
	});
});
</script>
<form:form modelAttribute="regepsVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="regepsSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(정규표현식ID, 정규표현식명, 정규표현식텍스트, 정규표현식예시, 플레이스홀더텍스트, 오류 메세지로 구성)</caption>
		<colgroup>
			<col class="w10p"/>
			<col/>
			<col class="w10p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>정규표현식ID</th>
				<td>
					<c:choose>
						<c:when test="${searchVO.procType eq 'insert' }">
							<form:input path="regepsId" title="정규표현식ID" maxlength="10" required="true"/>
							<button type="button" id="btn_idChk" class="btn sml bd blue">중복확인</button>
						</c:when>
						<c:otherwise>
							<c:out value="${regepsVO.regepsId }"/>
						</c:otherwise>
					</c:choose>
				</td>
				<th scope="row"><span class="asterisk">*</span>정규표현식명</th>
				<td><form:input path="regepsNm" class="w100p" title="정규표현식명" maxlength="30" required="true"/></td>
			</tr>
			<tr>
				<th scope="row">
					<span class="asterisk">*</span>정규표현식텍스트</br>(실제사용)
				</th>
				<td colspan="3">
					/<form:input path="regepsTxt" class="w98p" title="정규표현식텍스트" maxlength="100" required="true"/>/
					<br/>
					<span class="red_txt">※ 맨앞과 뒤의 '/'제외</span>					
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>정규표현식예시</br>(검증용)</th>
				<td colspan="3">
					<form:input path="regepsExm" class="w40p" title="정규표현식예시" maxlength="30" required="true"/>
					<button type="button" id="btn_txtChk" class="btn sml bd blue">검증</button>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>플레이스홀더텍스트</th>
				<td><form:input path="placeholderTxt" class="w100p" title="플레이스홀더텍스트" maxlength="100" required="true"/></td>
				<th scope="row"><span class="asterisk">*</span>오류 메세지</th>
				<td><form:input path="errMsg" class="w100p" title="오류 메세지" maxlength="100" required="true"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY }">
		<button type="button" id="btn_submit" class="btn blue"><c:out value="${empty regepsVO.regrSerno ? '등록' : '수정'}"/></button>
		<c:if test="${not empty regepsVO.regrSerno }">
		    <button type="button" id="btn_del" class="btn red">삭제</button>
		</c:if>
	</c:if>
	<button type="button" id="btn_list" class="btn gray">취소</button>
</div>
