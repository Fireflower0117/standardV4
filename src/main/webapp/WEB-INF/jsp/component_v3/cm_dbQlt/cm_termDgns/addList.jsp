<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();

	// 상세 페이지 이동
	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function(){
			<c:if test="${searchVO.schEtc01 eq '02'}">
				fncPageBoard('view', 'view.do', String($(this).closest('tr').data('serno1')) + ',' + String($(this).closest('tr').data('serno2')) + ',' + $(this).closest('tr').data('stdcd'), 'tableName,columnName,stdCd');
				return false;
			</c:if>
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
	<caption>내용(스키마명, 테이블영문명, 컬럼영문명, 컬럼한글명, 데이터타입(길이), 상태로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w10p"/>
		<col class="w25p"/>
		<col/>
		<c:choose>
			<c:when test="${searchVO.schEtc01 eq '02'}">
				<col class="w15p"/>
				<col class="w10p"/>
				<col class="w10p"/>
			</c:when>
			<c:otherwise>
				<col class="w10p"/>
			</c:otherwise>
		</c:choose>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">스키마명</th>
			<th scope="col">테이블영문명</th>
			<th scope="col">컬럼영문명</th>
			<c:choose>
				<c:when test="${searchVO.schEtc01 eq '02'}">
					<th scope="col">컬럼한글명</th>
					<th scope="col">데이터타입(길이)</th>
					<th scope="col">상태</th>
				</c:when>
				<c:otherwise>
					<th scope="col">데이터타입(길이)</th>
				</c:otherwise>
			</c:choose>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno1="<c:out value='${result.tableName}'/>"
						data-serno2="<c:out value='${result.columnName}'/>"
						data-stdcd="<c:out value='${result.stdCd}'/>"
					>
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.tableSchema}"/></td>
						<td class="l ellipsis"><a href="#" class="ellipsis td_view"><c:out value="${result.tableName}"/></a></td>
						<td class="l"><c:out value="${result.columnName}"/></td>
						<c:choose>
							<c:when test="${searchVO.schEtc01 eq '02'}">
								<td class="l"><c:out value="${result.columnComment}"/></td>
								<td><c:out value="${result.columnType}"/></td>
								<td>
									<span class="state <c:out value="${result.stdCd eq 'ST01' ? 'red' : 'blue'}"/>">
										<c:out value="${result.stdCdNm}"/>
									</span>
								</td>
							</c:when>
							<c:otherwise>
								<td><c:out value="${result.columnType}"/></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="${searchVO.schEtc01 eq '02' ? '7' : '5'}">데이터가 없습니다.</td>
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
