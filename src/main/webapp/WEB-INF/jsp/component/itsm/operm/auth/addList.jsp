<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
	<div class="tbl_left">
		<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
	</div>
	<div class="tbl_right">
		<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel" ><span>엑셀다운로드</span></a>
		<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
	</div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
		<caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
		<colgroup>
			<col style="width:5%;">
			<col style="width:15%;">
			<col>
			<col style="width:15%;">
			<col style="width:15%;">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">권한그룹코드</th>
			<th scope="col">권한그룹명</th>
			<th scope="col">사용구분</th>
			<th scope="col">등록일</th>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:choose>
						<c:when test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
							<tr onclick="javascript:fncPageBoard('update', 'updateForm.do', '${result.grpAuthSerno}', 'grpAuthSerno');" style="cursor:pointer;">
						</c:when>
						<c:otherwise>
							<tr style="cursor: default;">
						</c:otherwise>
					</c:choose>
					<td ${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : 'style="cursor: default;"' }><c:out value="${paginationInfo.totalRecordCount + 1 - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
					<td ${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY == true ? '' : 'style="cursor: default;"' }><c:out value="${result.grpAuthId }"/></td>
					<td class="subject" ${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : 'style="cursor: default;"' }><a><span><c:out value="${result.grpAuthNm }"/></span></a></td>
					<td ${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY == true ? '' : 'style="cursor: default;"' }><c:out value="${result.useYn eq 'Y' ? '사용' : '미사용' }"/></td>
					<td ${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY == true ? '' : 'style="cursor: default;"' }><c:out value="${result.regDt }"/></td>
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
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</div>
</div>