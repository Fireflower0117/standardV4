<%--@elvariable id="cmWrdVO" type="com.opennote.standard.component.std.wrd.vo.CmWrdVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

});
</script>
<form:form modelAttribute="cmWrdVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="wrdSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(단어명, 영문약어명, 영문명, 단어유형, 표준단어, 단어설명, 최초등록자, 최초등록일시, 최종변경자, 최종변경일시로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">단어명</th>
				<td colspan="3"><c:out value="${cmWrdVO.wrdNm}"/></td>
			</tr>
			<tr>
				<th scope="row">영문약어명</th>
				<td><c:out value="${cmWrdVO.engAbrvNm}"/></td>
				<th scope="row">영문명</th>
				<td><c:out value="${cmWrdVO.engNm}"/></td>
			</tr>
			<tr>
				<th scope="row">단어유형</th>
				<td><c:out value="${cmWrdVO.wrdTp}"/></td>
				<th scope="row">표준단어</th>
				<td><c:out value="${cmWrdVO.stdWrd}"/></td>
			</tr>
			<tr>
				<th scope="row">단어설명</th>
				<td colspan="3"><c:out value="${cmWrdVO.wrdExpl}"/></td>
			</tr>
			<tr>
				<th scope="row">최초등록자</th>
				<td><c:out value="${cmWrdVO.regrNm}"/></td>
				<th scope="row">최초등록일시</th>
				<td><c:out value="${cmWrdVO.regDt}"/></td>
			</tr>
			<tr>
				<th scope="row">최종변경자</th>
				<td><c:out value="${cmWrdVO.updrNm}"/></td>
				<th scope="row">최종변경일시</th>
				<td><c:out value="${cmWrdVO.updDt}"/></td>
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
