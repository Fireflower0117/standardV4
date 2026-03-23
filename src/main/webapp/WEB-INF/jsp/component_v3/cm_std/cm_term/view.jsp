<%--@elvariable id="cmTermVO" type="com.opennote.standard.component.std.term.vo.CmTermVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

});
</script>
<form:form modelAttribute="cmTermVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="termSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(용어명, 표준여부, 용어영문명, 도메인명, 도메인그룹, 데이터타입(길이), 용어설명, 최초등록자, 최초등록일시, 최종변경자, 최종변경일시로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">용어명</th>
				<td><c:out value="${cmTermVO.termNm}"/></td>
				<th scope="row">표준여부</th>
				<td><c:out value="${cmTermVO.stdYn}"/></td>
			</tr>
			<tr>
				<th scope="row">용어영문명</th>
				<td><c:out value="${cmTermVO.termEngNm}"/></td>
				<th scope="row">도메인명</th>
				<td><c:out value="${cmTermVO.dmnNm}"/></td>
			</tr>
			<tr>
				<th scope="row">도메인그룹</th>
				<td><c:out value="${cmTermVO.dmnGrp}"/></td>
				<th scope="row">데이터타입(길이)</th>
				<td>
					<c:out value="${cmTermVO.dataTp}"/>
					(<c:out value="${cmTermVO.dataLen}"/><c:if test="${!empty cmTermVO.dataLenDcpt}">, <c:out value="${cmTermVO.dataLenDcpt}"/></c:if>)
				</td>
			</tr>
			<tr>
				<th scope="row">용어설명</th>
				<td colspan="3" style="white-space: pre-wrap; word-break: break-all;"><c:out value="${cmTermVO.termExpl}"/></td>
			</tr>
			<tr>
				<th scope="row">최초등록자</th>
				<td><c:out value="${cmTermVO.regrNm}"/></td>
				<th scope="row">최초등록일시</th>
				<td><c:out value="${cmTermVO.regDt}"/></td>
			</tr>
			<tr>
				<th scope="row">최종변경자</th>
				<td><c:out value="${cmTermVO.updrNm}"/></td>
				<th scope="row">최종변경일시</th>
				<td><c:out value="${cmTermVO.updDt}"/></td>
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
