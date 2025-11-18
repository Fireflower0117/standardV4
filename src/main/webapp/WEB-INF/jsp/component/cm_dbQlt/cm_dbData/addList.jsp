<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();

	// 상세 페이지 이동
	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function(){
			fncPageBoard('view', 'view.do', String($(this).closest('tr').data('serno')), 'tableName');
			return false;
		});
	</c:if>

	// 엑셀 다운로드
	$('#cm_btn_excel').on('click', function(){
		$("#defaultFrm").attr({"action" : "excelDownload.do", "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
	});

});
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
        <button class="btn btn_excel" id="cm_btn_excel">엑셀 다운로드</button>
		<jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
	<caption>내용(스키마명, 테이블영문명, 테이블한글명, 컬럼개수, 데이터개수, 최초생성일, 최종수정일로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w10p"/>
		<col class="w15p"/>
		<col/>
		<col class="w7p"/>
		<col class="w10p"/>
		<col class="w10p"/>
		<col class="w10p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">스키마명</th>
			<th scope="col">테이블영문명</th>
			<th scope="col">테이블한글명</th>
			<th scope="col">컬럼개수</th>
			<th scope="col">데이터개수</th>
			<th scope="col">최초생성일</th>
			<th scope="col">최종수정일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno="<c:out value='${result.tableName}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.tableSchema}"/></td>
						<td class="l ellipsis"><a href="#" class="ellipsis td_view"><c:out value="${result.tableName}"/></a></td>
						<td class="l"><c:out value="${result.tableComment}"/></td>
						<td><c:out value="${result.columnCnt}"/></td>
						<td><c:out value="${result.tableRows}"/></td>
						<td><c:out value="${result.createTime}"/></td>
						<td><c:out value="${result.updateTime}"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="8">데이터가 없습니다.</td>
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
