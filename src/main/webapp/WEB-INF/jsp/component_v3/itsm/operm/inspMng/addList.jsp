<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	itsmFncColLength();	
	
	<c:if test="${fn:length(resultList) > 0 }">
		<%-- tr 클릭시 상세페이지 이동 --%>
		$('#tblBody tr').on('click', function(){			
			fncPageBoard('view', 'updateForm.do', $(this).attr('data-frmSn'), 'frmSn');
		});
	</c:if>
	
	<%-- 등록 클릭시 --%>
	$('#btn_write').on('click', function(){
		fncPageBoard('write', 'insertForm.do');
	});
	
	$("#btn_excel").on("click", function(){
		fncExcelDown();
	});
});

<%-- 엑셀 기본 다운로드 --%>
const fncExcelDown = function(){
	<c:choose>
		<c:when test="${fn:length(resultList) > 0 }">
			fncPageBoard("view", "excelDownload.do");
			$("#defaultFrm").attr("onsubmit","return false;");
		</c:when>
		<c:otherwise>
			alert("데이터가 없습니다");
			return false;
		</c:otherwise>
	</c:choose>
}
</script>            
<div class="tbl_top">
	<div class="tbl_left">
		<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
	</div>
	<div class="tbl_right">
		<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel"><span>엑셀 다운로드</span></a>&nbsp;
		<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
	</div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
		<caption>목록</caption>
		<colgroup>
			<col style="width: 6%;">
			<col style="width: 8%;">
			<col style="">
			<col style="width: 8%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">점검 구분</th>
				<th scope="col">양식 명</th>
				<th scope="col">항목 수</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody id="tblBody">
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr data-frmSn="<c:out value='${result.frmSn}'/>" style="cursor:pointer;">
							<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.index) }"/></td>
							<td class="ellipsis c"><c:out value="${empty result.inspGbnNm ? '-' : result.inspGbnNm}"/></td>
							<td class="ellipsis l"><c:out value="${result.frmNm }"/></td>
							<td class="ellipsis c"><c:out value="${result.itmCnt }"/></td>
							<td class="ellipsis c"><c:out value="${result.rgtrNm }"/></td>
							<td class="ellipsis c"><c:out value="${result.regDt }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td class="no_data">등록된 내역이 없습니다.</td>
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
			<a href="javascript:void(0);" id="btn_write" class="btn btn_mdl btn_write">등록</a>
		</c:if>
	</div>
</div>