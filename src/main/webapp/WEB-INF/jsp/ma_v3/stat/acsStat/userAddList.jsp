<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	$(document).ready(function(){
		// no_data 처리
		fncColLength();
	})
</script>
<div class="board_top">
	<div class="board_left">
		<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
</div>
<table class="board_list">
	<caption>내용(아이디, 이름, 권한으로 구성)</caption>
	<colgroup>
		<col class="w10p">
		<col>
		<col class="w30p">
		<col class="w20p">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">아이디</th>
			<th scope="col">이름</th>
			<th scope="col">권한</th>
		</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${fn:length(resultList) > 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
					<td><c:out value="${result.userId}"/></td>
					<td><c:out value="${result.userNm}"/></td>
					<td><c:out value="${result.grpAuthNm}"/></td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td class="no_data" colspan="4">데이터가 없습니다.</td>
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
