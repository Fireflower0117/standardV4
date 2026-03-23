<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
});

</script>            
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
			<col style="width: 6%;">
			<col style="width: 15%;">
			<col>
			<col style="width: 8%;">
			<col style="width: 7%;">
			<col style="width: 7%;">
			<col style="width: 8%;">
			<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">서비스 구분</th>
				<th scope="col">점검양식명</th>
				<th scope="col">점검항목수</th>
				<th scope="col" colspan="2">점검결과</th>
				<th scope="col">등록자</th>
				<th scope="col">점검일</th>
			</tr>
		</thead>
		<tbody id="tblBody">
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.inspSn}', 'inspSn');" style="cursor:pointer;">
							<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.index) }"/></td>
							<td class="ellipsis c"><c:out value="${result.svcNm }"/></td>
							<td class="ellipsis l"><c:out value="${result.frmNm }"/></td>
							<td class="ellipsis c"><c:out value="${result.itmCnt }"/></td>
							<td class="ellipsis c"><c:out value="${result.itmYCnt }/${result.itmCnt }"/></td>
							<td class="ellipsis c">
								<span class="stt_dv ${result.itmCnt eq result.itmYCnt ? 'blue' : 'red'}"><c:out value="${result.itmCnt eq result.itmYCnt ? '정상' : '비정상'}"/></span>
							</td>
							<td class="ellipsis c"><c:out value="${result.rgtrNm }"/></td>
							<td class="ellipsis c"><c:out value="${result.inspBegnDt }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="8">등록된 내역이 없습니다.</td>
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