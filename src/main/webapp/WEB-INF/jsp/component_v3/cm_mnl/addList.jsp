<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

	<%-- 엑셀 다운로드 --%>
	const cm_fncExcelDown = function(){
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
	
	<%-- no_data colspan 자동 셋팅 --%>
	fncColLength();

	<c:if test="${fn:length(resultList) > 0 }">
		<%-- tr 클릭시 상세페이지 이동 --%>
		$('.board_list tbody tr, a.td_view').on('click', function(){
			fncPageBoard('update', 'view.do', String($(this).closest('tr').data('serno')), 'mnlSerno');
			return false;
		});
	</c:if>
	
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<%-- 등록버튼 클릭시 --%>
		$('.btn_write').on('click', function(){
			fncPageBoard('write', 'insertForm.do');
		});
	</c:if>

	<%-- 엑셀 다운로드 --%>
	$('#btn_excel').on('click', function(){
		cm_fncExcelDown();
	});
});
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
	<caption>목록(번호, 메뉴구분명, 메뉴설명, 담당자명, 등록일로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w20p"/>
		<col/>
		<col class="w10p"/>
		<col class="w10p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">메뉴구분명</th>
			<th scope="col">메뉴설명</th>
			<th scope="col">담당자명</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno="<c:out value='${result.mnlSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l ellipsis"><a href="#" class="ellipsis td_view"><c:out value="${result.menuClNm}"/></a></td>
						<td class="l ellipsis"><c:out value="${result.menuExpl}"/></td>
						<td><c:out value="${result.tchgrNm}"/></td>
						<td><c:out value="${result.regDt}"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="5">데이터가 없습니다.</td>
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
			<button type="button" class="btn blue btn_write">등록</button>
		</div>
	</c:if>
</div>
