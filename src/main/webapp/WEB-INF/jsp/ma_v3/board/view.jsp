<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<form:form modelAttribute="boardVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="boardSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(번호, 등록일, 제목, 내용으로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">번호</th>
				<td><c:out value="${boardVO.boardSerno }"/></td>
				<th scope="row">등록일</th>
				<td><c:out value="${boardVO.regDt }"/></td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3"><c:out value="${boardVO.boardTitl }"/></td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td colspan="3"><c:out value="${boardVO.boardCtt }"/><td>
			</tr>
			<tr>
            <td colspan="4">
                <c:out value="${boardVO.boardCtt }" escapeXml="false"/>
            </td>
        </tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY || searchVO.loginSerno eq boardVO.regrSerno}">
		<button type="button" id="btn_update" class="btn blue">수정</button>
		<button type="button" id="btn_del" class="btn red">삭제</button>
	</c:if>
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
