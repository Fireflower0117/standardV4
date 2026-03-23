<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
	<div class="tbl_left">
		<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
	</div>
	<div class="tbl_right">
		<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel" onclick="fncExcel('${paginationInfo.totalRecordCount }')"><span>엑셀 다운로드</span></a>&nbsp;
		<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
	</div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
		<caption>목록</caption>
		<colgroup>
			<col style="width:5%;">
			<col style="width:13%;">
	        <col>
	        <col style="width:10%;">
	        <col style="width:10%;">
	        <col style="width:10%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
		        <th scope="col">서비스구분</th>
		        <th scope="col">제목</th>
		        <th scope="col">처리상황</th>
		        <th scope="col">등록자</th>
		        <th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody id="tblBody">
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.ideaSn}', 'ideaSn');" style="cursor:pointer;">
							<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.index) }"/></td>
							<td><c:out value="${empty result.svcNm ? '-' : result.svcNm }"/></td>
							<td class="l">
								<span class="ellipsis"><c:out value="${result.ideaTtl }"/></span>
								<c:choose>
									<c:when test="${result.comCnt gt 0 }">
										[${result.comCnt }]
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								<c:if test="${result.newComCnt gt 0 }">
									&nbsp;<p class="new">N</p>
								</c:if>
							</td>
							<td>
								<p class="${result.prcsStts eq 'B' ? 'rqu stt_dv' : result.prcsStts eq 'I' ? 'prg stt_dv' : result.prcsStts eq 'E' ? 'prc stt_dv' : '-' }">
									<c:out value="${result.prcsStts eq 'B' ? '접수완료' : result.prcsStts eq 'I' ? '처리중' : '처리완료'}"/>
								</p>

							</td>
							<td><c:out value="${result.rgtrNm}"/></td>
							<td><c:out value="${result.regDt}"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<%-- colspan 동적 할당기능이 오류가 날수도 있으므로 하드코딩은 필수 --%>
						<td colspan="6">등록된 내역이 없습니다.</td>
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
			<a href="javascript:void(0);" class="btn btn_mdl btn_write" onclick="fncPageBoard('write', 'insertForm.do');">등록</a>
		</c:if>
	</div>
</div>
<script type="text/javaScript">

</script>