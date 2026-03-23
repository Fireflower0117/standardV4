<%--@elvariable id="cmDmnVO" type="com.opennote.standard.component.std.dmn.vo.CmDmnVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$('#cm_btn_submit').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			fncProc('<c:out value="${empty cmDmnVO.dmnSerno ? 'insert' : 'update'}"/>');
		}
	});
});
</script>
<form:form modelAttribute="cmDmnVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="dmnSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(도메인유형, 도메인그룹, 도메인명, 도메인영문명, 데이터타입, 분류어, 길이, 길이(소수점), 코드유형, 코드상세유형, 시스템명, 설명으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>도메인유형</th>
				<td>
					<form:select path="dmnTp" title="도메인유형" cssClass="w100p" required="true">
						<form:option value="그룹도메인" label="그룹도메인"/>
						<form:option value="코드도메인" label="코드도메인"/>
					</form:select>
				</td>
				<th scope="row"><span class="asterisk">*</span>도메인그룹</th>
				<td>
					<form:select path="dmnGrp" title="도메인그룹" cssClass="w100p" required="true">
						<form:option value="금액" label="금액"/>
						<form:option value="날짜/시간" label="날짜/시간"/>
						<form:option value="명칭/내용" label="명칭/내용"/>
						<form:option value="물리량" label="물리량"/>
						<form:option value="번호" label="번호"/>
						<form:option value="비율" label="비율"/>
						<form:option value="수량" label="수량"/>
						<form:option value="식별자" label="식별자"/>
						<form:option value="여부/유무" label="여부/유무"/>
						<form:option value="좌표" label="좌표"/>
						<form:option value="주소" label="주소"/>
						<form:option value="코드" label="코드"/>
						<form:option value="크기" label="크기"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>도메인명</th>
				<td>
					<form:input path="dmnNm" title="도메인명" cssClass="w100p" maxlength="20" required="true"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>도메인영문명</th>
				<td>
					<form:input path="dmnEngNm" title="도메인영문명" cssClass="w100p" maxlength="20" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>데이터타입</th>
				<td>
					<form:input path="lgclDataTp" title="데이터타입" cssClass="w100p" maxlength="20" required="true"/>
				</td>
				<th scope="row">분류어</th>
				<td>
					<form:input path="cgCd" title="분류어" cssClass="w100p" maxlength="60"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>길이</th>
				<td>
					<form:input path="dataLen" title="길이" cssClass="w100p numOnly" maxlength="5" required="true"/>
				</td>
				<th scope="row">길이(소수점)</th>
				<td>
					<form:input path="dataLenDcpt" title="길이(소수점)" cssClass="w100p numOnly" maxlength="5"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>코드유형</th>
				<td>
					<form:select path="cdTp" title="코드유형" cssClass="w100">
						<form:option value="공통코드" label="공통코드"/>
						<form:option value="개별코드" label="개별코드"/>
					</form:select>
				</td>
				<th scope="row"><span class="asterisk">*</span>코드상세유형</th>
				<td>
					<form:select path="cdDtlsTp" title="코드상세유형" cssClass="w100">
						<form:option value="단일코드" label="단일코드"/>
						<form:option value="통합코드" label="통합코드"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th scope="row">시스템명</th>
				<td colspan="3">
					<form:input path="sysNm" title="시스템명" cssClass="w100p" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>설명</th>
				<td colspan="3">
					<form:textarea path="dmnExpl" title="설명" maxlength="1000" required="true"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<button type="button" id="cm_btn_submit" class="btn blue"><c:out value="${empty cmDmnVO.dmnSerno ? '등록' : '수정'}"/></button>
	<button type="button" id="btn_<c:out value="${empty cmDmnVO.dmnSerno ? 'list' : 'view'}"/>" class="btn gray">취소</button>
</div>
