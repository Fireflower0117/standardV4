<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<option value="">템플릿 타입</option>
<c:if test="${fn:length(selOptionList) gt 0 }">
	<c:forEach var="item" items="${selOptionList }" varStatus="status">
		<option value="<c:out value="${item.cdVal }"/>"><c:out value="${item.cdNm}"/></option>
	</c:forEach>	
</c:if>
