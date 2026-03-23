<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left">
			<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
		</div>
	</div>
	<div class="tbl_wrap">
		<table class="board_col_type01 no_hover">
			<caption>목록(번호,제목,등록자,소속,등록일 로 구성)</caption>
			<colgroup>
				<col style="width:8%;">
				<col>
				<col style="width:10%;">
				<col style="width:15%;">
				<col style="width:10%;">
				<col style="width:10%;">
			</colgroup>
			<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">양식명</th>
				<th scope="col">항목 수</th>
				<th scope="col">비고</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
			</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${fn:length(resultList) > 0}">
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr onclick="fncAddFrm(${result.frmSn}, '${result.frmNm}', ${result.autoYn})">
								<td><c:out value="${paginationInfo.totalRecordCount + 1 - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
								<td class="subject"><c:out value="${result.frmNm}"/></td>
								<td><c:out value="${result.itmCnt}"/></td>
								<td><c:out value="${result.autoYn gt 0  ? '자동점검 포함' : '-'}"/></td>
								<td><c:out value="${result.rgtrNm}"/></td>
								<td><c:out value="${result.regDt}"/></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="no_data">
							<td colspan="5">데이터가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<div class="paging_wrap">
		<div class="paging">
			<ui:pagination paginationInfo="${paginationInfo}" type="default" jsFunction="fncPopAddList"/>
		</div>
	</div>