<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
	<div class="tbl_left">
		<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
	</div>
	<div class="tbl_right">
		<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
	</div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
		<caption>목록</caption>
		<colgroup>
			<col style="width: 6%;">
			<col>
			<col style="width: 15%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">게시기간</th>
				<th scope="col">팝업구분</th>
				<th scope="col">게시여부</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.popupSn}', 'popupSn');" style="cursor:pointer;">
							<td class="ellipsis"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.index) }"/></td>
							<td class="ellipsis l"><span class="ellipsis"><c:out value="${result.popupTtlNm }"/></span></td>
							<td class="ellipsis">
								<c:if test="${result.popupPstgPrdYn eq 'Y' }">
			                		<c:out value="${result.pstgBgngDt}"/> ~ <c:out value="${result.pstgEndDt}"/>                	
		                    	</c:if>
		                    	<c:if test="${result.popupPstgPrdYn eq 'N' }">
		                    		항상
		                    	</c:if>
	                    	</td>
							<td class="ellipsis"><c:out value="${result.seValNm}"/></td>
							<td class="ellipsis"><c:out value="${result.popupYn eq 'Y' ? '게시' : '미게시'}"/></td>
							<td class="ellipsis"><c:out value="${result.regrNm}"/></td>
							<td class="ellipsis"><c:out value="${result.regDt}"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="7">등록된 내역이 없습니다.</td>
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
	<div class="btn_right">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<a href="javascript:void(0)" class="btn btn_mdl btn_write" onclick="fncPageBoard('write','insertForm.do');">등록</a>
		</c:if>
	</div>
</div>