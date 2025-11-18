<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function() {
	
});

</script>
<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong>${paginationInfo.totalRecordCount}</strong> 건</span>
   	</div>
    <div class="tbl_right">
    	<div class="btn_area">
    		<a href="javascript:void(0);" class="btn btn_sml btn_update" onclick="weekJobUpdatePop();" ><span>수동업데이트</span></a>
    		<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    	</div>
    </div>
</div>
<!-- board -->
<!-- tbl -->
<div class="tbl_wrap">
	<table id="addListTable" class="board_col_type01">
        <caption>목록</caption>
		<colgroup>
			<col style="width:7%;">
			<col>
			<col>
			<col style="width:10%;">
			<col>
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">서비스 구분</th>
				<th scope="col">제목</th>
				<th scope="col">월</th>
				<th scope="col">기간</th>
				<th scope="col">보기</th>
			</tr>
		</thead>
        <tbody>
        	<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.rptMonthSn}', 'rptMonthSn');" style="cursor:pointer;">
							<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
							<td><c:out value="${result.svcNm }"/></td>
							<td><c:out value="${result.monWeek } 월간공정"/></td>
							<td><c:out value="${result.monWeek }"/></td>
							<td><c:out value="${result.thisMonthStartYmd } ~ ${result.thisMonthEndYmd }"/></td>
							<td onclick="event.cancelBubble=true;" style="cursor: default">
								<a href="#" class="btn btn_down" id="btn_excel" onclick="siteReportPop('${result.rptMonthSn}');" ><span>보고서 보기</span></a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="6">등록된 내역이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
        </tbody>
    </table>
</div>
<!-- //tbl -->
<div class="paging_wrap">
	<div class="btn_right">
		<!-- <a href="javascript:void(0)" class="btn btn_mdl btn_write" onclick="fncPageBoard('write', 'insertForm.do');">등록</a> -->
	</div>
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard" />
	</div>
</div>