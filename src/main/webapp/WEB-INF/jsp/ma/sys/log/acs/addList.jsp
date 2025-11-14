<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();

});
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
	<div class="board_right">
		<jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
	</div>
</div>
<table class="board_list">
	<caption>내용(영역, ID, 성명, 최근로그인, 접속IP, 접속시간, 접속횟수, 유형으로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w10p"/>
		<c:if test="${searchVO.schEtc01 eq '04' }">
			<col class="w10p"/>
		</c:if>
		<col class="w15p"/>
		<col class="w15p"/>
		<col class="w10p"/>
		<c:if test="${searchVO.schEtc01 eq '03' }">
			<col class="w10p"/>
		</c:if>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">영역</th>
			<c:if test="${searchVO.schEtc01 eq '04' }">
				<th scope="col">유형</th>
			</c:if>
			<th scope="col">ID</th>
			<th scope="col">성명</th>
			<th scope="col"><c:out value="${searchVO.schEtc01 eq '02' || searchVO.schEtc01 eq '04' ? '접속시간' : '최근로그인'}"/></th>
			<c:if test="${searchVO.schEtc01 eq '03' }">
				<th scope="col">접속횟수</th>
			</c:if>
			<th scope="col">접속IP</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.authAreaCd eq 'MA' ? '관리자' : '사용자'}"/></td>
						<c:if test="${searchVO.schEtc01 eq '04' }">
							<td><c:out value="${result.lginYn eq 'Y' ? '접근시도' : ''}"/><c:out value="${result.ipErrYn eq 'Y' ? '비허가IP접근' : ''}"/></td>
						</c:if>
						<td><c:out value="${result.acsId}"/></td>
						<td><c:out value="${result.regrNm}"/></td>
						<td><c:out value="${result.regDt}"/></td>
						<c:if test="${searchVO.schEtc01 eq '03' }">
							<td><fmt:formatNumber value="${result.logCnt}" pattern="#,###"/></td>
						</c:if>
						<td><c:out value="${result.acsLogIpAddr}"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data">데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
</div>
