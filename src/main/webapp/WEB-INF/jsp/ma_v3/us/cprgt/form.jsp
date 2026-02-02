<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
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
            
			$('#coPostNo').val(post);
			$('#coAddr').val(roadAddr);
			$('#coLtnoAddr').val(jibunAddr);
			$("#coDtlsAddr").focus();
        }
    }).open();
}
$(document).ready(function(){
	
	<%-- 주소 찾기 --%>
	$('#coPostNo, #btn_findAddr').on('click', function(){
		fncFindAddr();
	});
	
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<%-- 등록,수정 처리 --%>
		$('#btn_submit').on('click', function(){
			if(wrestSubmit(document.defaultFrm)){
				fncProc("<c:out value='${empty cprgtVO.cprgtSerno ? \'insert\' : \'update\'}'/>");
			}
		});
	</c:if>
});

</script>
<form:form modelAttribute="cprgtVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="cprgtSerno"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(저작권 내용, 우편번호, 도로명주소, 지번주소, 상세주소, 영어주소, 유선번호, 팩스번호로 구성)</caption>
		<colgroup>
			<col class="w20p">
            <col>
            <col class="w20p">
            <col>
		</colgroup>
		<tbody>
			<tr>
                <th scope="row"><span class="asterisk">*</span>저작권 내용</th>
                <td colspan="3">
                	<form:input path="cprgtCtt" cssClass="w100p" title="저작권 내용" maxlength="60" required="true"/>
                </td>
            </tr>
			<tr>
                <th scope="row"><span class="asterisk">*</span>우편번호</th>
                <td>
                	<form:input path="coPostNo" cssClass="w30p numOnly" title="우편번호" maxlength="5" required="true" readonly="true"/>
                	<button type="button" id="btn_findAddr" class="btn sml">주소찾기</button>
                </td>
                <th scope="row">영어주소</th>
                <td>
                	<form:input path="coEngAddr" cssClass="w100p" title="영어주소" maxlength="60"/>
                </td>
            </tr>
			<tr>
                <th scope="row"><span class="asterisk">*</span>도로명주소</th>
                <td>
                	<form:input path="coAddr" cssClass="w100p" title="도로명주소" maxlength="60" required="true" readonly="true"/>
                </td>
                <th scope="row"><span class="asterisk">*</span>지번주소</th>
                <td>
                	<form:input path="coLtnoAddr" cssClass="w100p" title="지번주소" maxlength="60" required="true" readonly="true"/>
                </td>
            </tr>
			<tr>
                <th scope="row"><span class="asterisk">*</span>상세주소</th>
                <td colspan="3">
                	<form:input path="coDtlsAddr" cssClass="w100p" title="상세주소" maxlength="60" required="true"/>
                </td>
            </tr>
            <tr>
                <th scope="row"><span class="asterisk">*</span>유선번호</th>
                <td>
                	<form:input path="coTelNo" cssClass="w60p numOnly" title="유선번호" placeholder="'-'를 빼고 숫자만 입력해주세요." maxlength="11" required="true"/>
                </td>
                <th scope="row"><span class="asterisk">*</span>팩스번호</th>
                <td>
                	<form:input path="coFaxNo" cssClass="w60p numOnly" title="팩스번호" placeholder="'-'를 빼고 숫자만 입력해주세요." maxlength="11" required="true"/>
                </td>
            </tr>
		</tbody>
	</table>
</form:form>
<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
    <div class="btn_area">
        <button type="button" id="btn_submit" class="btn blue"><c:out value="${empty cprgtVO.cprgtSerno ? '등록' : '수정'}"/></button>
    </div>
</c:if>
