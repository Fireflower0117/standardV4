<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<input type="hidden" name="currentPageNo" id="currentPageNo" value="${searchVO.currentPageNo}"/>
<input type="hidden" name="recordCountPerPage" id="recordCountPerPage" value="${searchVO.recordCountPerPage}"/>
<input type="hidden" name="pageSize" id="pageSize" value="${searchVO.pageSize}"/>
<input type="hidden" name="searchCondition" id="searchCondition" value="${searchVO.searchCondition}"/>
<input type="hidden" name="searchKeyword" id="searchKeyword" value="${searchVO.searchKeyword}"/>
<input type="hidden" name="searchStartDate" id="searchStartDate" value="${searchVO.searchStartDate}"/>
<input type="hidden" name="searchEndDate" id="searchEndDate" value="${searchVO.searchEndDate}"/>
<input type="hidden" name="schEtc00" id="schEtc00" value="${searchVO.schEtc00}"/>
<input type="hidden" name="schEtc01" id="schEtc01" value="${searchVO.schEtc01}"/>
<input type="hidden" name="schEtc02" id="schEtc02" value="${searchVO.schEtc02}"/>
<input type="hidden" name="schEtc03" id="schEtc03" value="${searchVO.schEtc03}"/>
<input type="hidden" name="schEtc04" id="schEtc04" value="${searchVO.schEtc04}"/>
<input type="hidden" name="schEtc05" id="schEtc05" value="${searchVO.schEtc05}"/>
<input type="hidden" name="schEtc06" id="schEtc06" value="${searchVO.schEtc06}"/>
<input type="hidden" name="schEtc07" id="schEtc07" value="${searchVO.schEtc07}"/>
<input type="hidden" name="schEtc08" id="schEtc08" value="${searchVO.schEtc08}"/>
<input type="hidden" name="schEtc09" id="schEtc09" value="${searchVO.schEtc09}"/>
<input type="hidden" name="schEtc10" id="schEtc10" value="${searchVO.schEtc10}"/>
<c:choose>
	<c:when test="${fn:length(searchVO.schEtc11) > 0 }">
		<c:forEach items="${searchVO.schEtc11}" var="item" varStatus="status">
			<input type="hidden" name="schEtc11" id="schEtc11_${status.index }" value="${item}"/>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="schEtc11" id="schEtc11" value=""/>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${fn:length(searchVO.schEtc12) > 0 }">
		<c:forEach items="${searchVO.schEtc12}" var="item" varStatus="status">
			<input type="hidden" name="schEtc12" id="schEtc12_${status.index }" value="${item}"/>
		</c:forEach>
	</c:when>
	<c:otherwise>
			<input type="hidden" name="schEtc12" id="schEtc12" value=""/>
	</c:otherwise>
</c:choose>