<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- no_data colspan 자동 셋팅 --%>
	fncColLength();
	
	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function(){
			 fncPageBoard('view', 'view.do', String($(this).closest('tr').data('serno')), 'bltnbSerno');
			 return false;
		});
	</c:if>
	
	$('#btn_bltnb_write').on('click', function(){
		fncPageBoard('write', 'insertForm.do');
	});
})
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
	<colgroup>
		<col class="w5p"/>
		<col/>
		<col class="w10p"/>
		<col class="w10p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">등록자</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno="<c:out value='${result.bltnbSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l ellipsis">
			                <a href="#" class="ellipsis td_view"><c:out value="${result.bltnbTitl }"/></a>
			            </td>
			            <td><c:out value="${result.regrNm}"/></td>
						<td><c:out value="${result.regDt }"/></td>
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
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<div class="btn_right">
			<button type="button" id="btn_bltnb_write" class="btn blue">등록</button>
		</div>
	</c:if>
</div>
