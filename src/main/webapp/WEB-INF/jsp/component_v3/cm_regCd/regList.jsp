<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:if test="${not empty searchVO.def}">
    <option value=""><c:out value="${searchVO.def}"/></option>
</c:if>
<c:choose>
	<c:when test="${menuTp eq 'SIDO' }"><%-- 시도 --%>
	  <c:forEach var="result" items="${selectList}" varStatus="status">
	      <option value="<c:out value="${result.sidoCd}"/>" <c:out value="${searchVO.sel eq result.sidoCd ? 'selected=\"selected\"' : ''}"/>><c:out value="${result.sidoNm}"/></option>
	  </c:forEach>
	</c:when>
	<c:when test="${menuTp eq 'CGG' }"><%-- 시군구 --%>
	  <c:forEach var="result" items="${selectList}" varStatus="status">
	      <option value="<c:out value="${result.cggCd}"/>" <c:out value="${searchVO.sel eq result.cggCd ? 'selected=\"selected\"' : ''}"/>><c:out value="${result.cggNm}"/></option>
	  </c:forEach>
	</c:when>
	<c:when test="${menuTp eq 'UMD' }"><%-- 읍면동 --%>
	  <c:forEach var="result" items="${selectList}" varStatus="status">
	      <option value="<c:out value="${result.umdCd}"/>" <c:out value="${searchVO.sel eq result.umdCd ? 'selected=\"selected\"' : ''}"/>><c:out value="${result.umdNm}"/></option>
	  </c:forEach>
	</c:when>
	<c:when test="${menuTp eq 'RI' }"><%-- 리 --%>
	  <c:forEach var="result" items="${selectList}" varStatus="status">
	      <option value="<c:out value="${result.riCd}"/>" <c:out value="${searchVO.sel eq result.riCd ? 'selected=\"selected\"' : ''}"/>><c:out value="${result.riNm}"/></option>
	  </c:forEach>
	</c:when>
</c:choose>
