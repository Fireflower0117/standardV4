<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();

	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function () {
			fncPageBoard('update', 'view.do', String($(this).closest('tr').data('serno')), 'errLogSerno');
			return false;
		});
	</c:if>

	// 엑셀 다운로드
	$('#btn_excel').on('click', function(){
		$("#defaultFrm").attr({"action" : "excelDownload.do", "method" : "post", "onsubmit" : ""}).submit();
	});

});
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
	<div class="board_right">
		<button class="btn btn_excel" id="btn_excel">엑셀 다운로드</button>
		<jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
	</div>
</div>
<table class="board_list">
	<caption>목록(에러유형, 에러설명, 에러페이지URL, 메뉴명, 메뉴 한글명, IP주소, 발생일시로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w10p"/>
		<col/>
		<col class="w20p"/>
		<col class="w10p"/>
		<col class="w10p"/>
		<col class="w10p"/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">에러유형</th>
			<th scope="col">에러설명</th>
			<th scope="col">에러페이지URL</th>
			<th scope="col">메뉴명</th>
			<th scope="col">메뉴 한글명</th>
			<th scope="col">IP주소</th>
			<th scope="col">발생일시</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno="<c:out value='${result.errLogSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l ellipsis"><c:out value="${result.errTpNm}"/></td>
						<td class="l ellipsis"><c:out value="${result.errExpl}"/></td>
						<td class="l ellipsis"><a href="#" class="ellipsis td_view"><c:out value="${result.errOccrUrlAddr}"/></a></td>
						<td><c:out value="${result.menuCgNm}"/></td>
						<td><c:out value="${result.menuNm}"/></td>
						<td class="l ellipsis"><c:out value="${result.errOccrIpAddr}"/></td>
						<td><c:out value="${result.errOccrDt}"/></td>
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
