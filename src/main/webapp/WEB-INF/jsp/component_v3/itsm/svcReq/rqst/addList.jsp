<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
</script>
<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong>${paginationInfo.totalRecordCount}</strong> 건</span>
   	</div>
	<div class="tbl_right">
		<%--<a href="javascript:void(0);" class="btn btn_sml btn_excel" onclick="fncNotExmnExcelForm(${paginationInfo.totalRecordCount});"><span>엑셀 업로드</span></a>--%>
			<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel" onclick="fncExcel('${paginationInfo.totalRecordCount }')"><span>엑셀 다운로드</span></a>&nbsp;
		<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
	</div>
</div>
<!-- board -->
<!-- tbl -->
<div class="tbl_wrap">
	<table id="addListTable" class="board_col_type01">
        <caption>목록</caption>
		<colgroup>
			<col style="width:3%;">
			<col style="width:13%;">
			<col style="width:10%;">
			<col style="width:8%;">
			<col style="width:13%;">
			<col style="width:10%;">
			<col style="width:7%;">
			<col style="width:6%;">
			<col style="width:6%;">
			<col style="width:5%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">서비스구분</th>
				<th scope="col">요구사항 ID</th>
		        <th scope="col">요구사항 항목</th>
		        <th scope="col">요구사항 상세 ID</th>
		        <th scope="col">요구사항 세부내역</th>
		        <th scope="col">분류</th>
		        <th scope="col">고객담당자</th>
		        <th scope="col">개발담당자</th>
		        <th scope="col">진행현황</th>
			</tr>
		</thead>
        <tbody>
        	<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.rqrSn}', 'rqrSn');" style="cursor:pointer;">
							<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
							<td><c:out value="${empty result.svcNm ? '-' : result.svcNm }"/></td>
							<td><c:out value="${result.rqrId}"/></td>
							<td class="ellipsis"><c:out value="${result.rqrItm}"/></td>
							<td><c:out value="${result.rqrDtlId}"/></td>
							<td class="ellipsis"><c:out value="${result.rqrDtl}"/></td>
							<td><c:out value="${result.rqrCls}"/></td>
							<td><c:out value="${empty result.custMngrNm? '-' : result.custMngrNm}"/></td>
							<td><c:out value="${empty result.dvlpMngrNm? '-' : result.dvlpMngrNm}"/></td>
							<td>
								<p class="${empty result.rqrProcNm ? '' : result.rqrProcNm eq '진행' ? 'prg stt_dv' : result.rqrProcNm eq '완료' ? 'prc stt_dv' : result.rqrProcNm eq '제외' ? 'red stt_dv' : 'rqu stt_dv'}">
									<c:out value="${not empty result.rqrProcNm ? result.rqrProcNm : '-'}"/>
			                	</p>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="10">등록된 내역이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
        </tbody>
    </table>
</div>
<!-- //tbl -->
<div class="paging_wrap">
	<div class="btn_right">
		<a href="javascript:void(0)" class="btn btn_mdl btn_write" onclick="fncPageBoard('write', 'insertForm.do');">등록</a>
	</div>
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard" />
	</div>
</div>