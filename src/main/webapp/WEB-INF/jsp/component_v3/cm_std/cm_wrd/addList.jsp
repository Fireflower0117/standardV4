<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();

	// 상세 페이지 이동
	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function(){
			fncPageBoard('view', 'view.do', String($(this).closest('tr').data('serno')), 'wrdSerno');
			return false;
		});
	</c:if>

	// 엑셀 다운로드
	$('#cm_btn_excel').on('click', function(){
		$("#defaultFrm").attr({"action" : "excelDownload.do", "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
	});

	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		// 등록 버튼
		$('#cm_btn_write').on('click', function(){
			fncPageBoard('write', 'insertForm.do');
		});
	</c:if>

})
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
	<caption>내용(단어명, 영문약어명, 단어설명, 단어유형, 영문명, 최종변경일로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w10p"/>
		<col class="w10p"/>
		<col/>
		<col class="w7p"/>
		<col class="w20p"/>
		<col class="w10p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">단어명</th>
			<th scope="col">영문약어명</th>
			<th scope="col">단어설명</th>
			<th scope="col">단어유형</th>
			<th scope="col">영문명</th>
			<th scope="col">최종변경일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno="<c:out value='${result.wrdSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l ellipsis"><a href="#" class="ellipsis td_view"><c:out value="${result.wrdNm}"/></a></td>
						<td class="l"><c:out value="${result.engAbrvNm}"/></td>
						<td class="l ellipsis"><c:out value="${result.wrdExpl}"/></td>
						<td><c:out value="${result.wrdTp}"/></td>
						<td class="l ellipsis"><c:out value="${result.engNm}"/></td>
						<td><c:out value="${result.updDt}"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="7">데이터가 없습니다.</td>
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
		<button type="button" id="cm_btn_write" class="btn blue">등록</button>
	</div>
</c:if>
</div>
