<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();
});
</script>
<div class="tbl_scroll scr_h">
	<table class="data_tbl">
		<colgroup>
			<c:forEach var="col" items="${searchVO.colList}" varStatus="status">
				<col class="w150">
			</c:forEach>
		</colgroup>
		<thead>
		<tr>
			<c:forEach var="col" items="${searchVO.colList}" varStatus="status">
				<th scope="col"><c:out value="${col.columnComment}"/></th>
			</c:forEach>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<c:forEach var="item" begin="0" end="${fn:length(searchVO.colList) - 1 }">
							<c:set var="col" value="col${item}"/>
							<td class="ellipsis"><c:out value="${result[col]}"/></td>
						</c:forEach>
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
</div>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="cmDataList"/>
	</ul>
</div>
