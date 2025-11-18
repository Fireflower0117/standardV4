<%--@elvariable id="cmDmnVO" type="com.opennote.standard.component.std.dmn.vo.CmDmnVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

});
</script>
<form:form modelAttribute="cmDmnVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="dmnSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(도메인유형명, 도메인그룹, 도메인명, 도메인영문명, 데이터타입(길이), 분류어, 코드유형, 코드상세유형, 시스템명, 설명, 최초등록자, 최초등록일시, 최종변경자, 최종변경일시로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">도메인유형명</th>
				<td><c:out value="${cmDmnVO.dmnTp}"/></td>
				<th scope="row">도메인그룹</th>
				<td><c:out value="${cmDmnVO.dmnGrp}"/></td>
			</tr>
			<tr>
				<th scope="row">도메인명</th>
				<td><c:out value="${cmDmnVO.dmnNm}"/></td>
				<th scope="row">도메인영문명</th>
				<td><c:out value="${cmDmnVO.dmnEngNm}"/></td>
			</tr>
			<tr>
				<th scope="row">데이터타입(길이)</th>
				<td>
					<c:out value="${cmDmnVO.dataLen}"/>
					(<c:out value="${cmDmnVO.dataLen}"/><c:if test="${!empty cmDmnVO.dataLenDcpt}">, <c:out value="${cmDmnVO.dataLenDcpt}"/></c:if>)
				</td>
				<th scope="row">분류어</th>
				<td><c:out value="${cmDmnVO.cgCd}"/></td>
			</tr>
			<tr>
				<th scope="row">코드유형</th>
				<td><c:out value="${cmDmnVO.cdTp}"/></td>
				<th scope="row">코드상세유형</th>
				<td><c:out value="${cmDmnVO.cdDtlsTp}"/></td>
			</tr>
			<tr>
				<th scope="row">시스템명</th>
				<td colspan="3"><c:out value="${cmDmnVO.sysNm}"/></td>
			</tr>
			<tr>
				<th scope="row">설명</th>
				<td colspan="3"><c:out value="${cmDmnVO.dmnExpl}"/></td>
			</tr>
			<tr>
				<th scope="row">최초등록자</th>
				<td><c:out value="${cmDmnVO.regrNm}"/></td>
				<th scope="row">최초등록일시</th>
				<td><c:out value="${cmDmnVO.regDt}"/></td>
			</tr>
			<tr>
				<th scope="row">최종변경자</th>
				<td><c:out value="${cmDmnVO.updrNm}"/></td>
				<th scope="row">최종변경일시</th>
				<td><c:out value="${cmDmnVO.updDt}"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
	<button type="button" id="btn_update" class="btn blue">수정</button>
	<button type="button" id="btn_del" class="btn red">삭제</button>
</c:if>
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
