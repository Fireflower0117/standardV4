<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- no_data colspan 자동 셋팅 --%>
	fncColLength();

	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		$('#btn_write').on('click', function(){
			fncPageBoard('write', 'insertForm.do');
		});

		$('.board_list tbody tr, a.td_view').on('click', function(){
			fncPageBoard("update", "updateForm.do", String($(this).closest('tr').data('serno')), "grpAuthSerno");
			return false;
		});
	</c:if>

	$('#btn_excel').on('click', function(){
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
	});
})


</script>
<div class="board_top">
    <div class="board_left">
		<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
	<div class="board_right">
		<button type="button" id="btn_excel" class="btn btn_excel">엑셀 다운로드</button>
		<jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
	</div>
</div>
<table class="board_list">
	<caption>목록(번호, 그룹권한ID, 그룹권한명, 그룹권한설명, 사용구분, 등록일으로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w10p"/>
		<col class="w15p"/>
		<col/>
		<col class="w5p"/>
		<col class="w10p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">그룹권한ID</th>
			<th scope="col">그룹권한명</th>
			<th scope="col">그룹권한설명</th>
			<th scope="col">사용구분</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) gt 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr class="${sessionScope.SESSION_WRITE_BTN_KEY? '' : 'no_cursor'}" data-serno="<c:out value="${result.grpAuthSerno}"/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="c"><c:out value="${result.grpAuthId }"/></td>
						<td class="c"><c:out value="${result.grpAuthNm }"/></td>
						<td class="l ellipsis">
			                <a href="#" class="ellipsis td_view"><c:out value="${result.grpAuthExpl }"/></a>
			            </td>
						<td class="c"><c:out value="${result.useYn eq 'Y' ? '사용' : '미사용'}"/></td>
						<td><c:out value="${result.regDt }"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="6">데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
	<div class="btn_right">
		<!-- c:if test="${sessionscope.session_write_btn_key}" -->
			<button id="btn_write" class="btn blue">등록</button>
		<!-- /c:if -->
	</div>
</div>
