<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();

	// 상세 페이지 이동
	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function(){
			fncPageBoard('view', 'view.do', String($(this).closest('tr').data('serno')), 'dmnSerno');
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
	<caption>내용(도메인명, 도메인영문명, 논리데이터타입, 길이, 도메인유형, 도메인그룹, 코드유형명, 코드상세유형명, 분류어, 최종변경일로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col/>
		<col/>
		<col class="w10p"/>
		<col class="w5p"/>
		<col class="w8p"/>
		<col class="w8p"/>
		<col class="w8p"/>
		<col class="w10p"/>
		<col class="w5p"/>
		<col class="w8p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">도메인명</th>
			<th scope="col">도메인영문명</th>
			<th scope="col">논리데이터타입</th>
			<th scope="col">길이</th>
			<th scope="col">도메인유형</th>
			<th scope="col">도메인그룹</th>
			<th scope="col">코드유형명</th>
			<th scope="col">코드상세유형명</th>
			<th scope="col">분류어</th>
			<th scope="col">최종변경일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno="<c:out value='${result.dmnSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l ellipsis"><a href="#" class="ellipsis td_view"><c:out value="${result.dmnNm}"/></a></td>
						<td class="l ellipsis"><c:out value="${result.dmnEngNm}"/></td>
						<td><c:out value="${result.lgclDataTp}"/></td>
						<td>
							<c:out value="${result.dataLen}"/><c:if test="${!empty result.dataLenDcpt}">, <c:out value="${result.dataLenDcpt}"/></c:if>
						</td>
						<td class="l ellipsis"><c:out value="${result.dmnTp}"/></td>
						<td><c:out value="${result.dmnGrp}"/></td>
						<td><c:out value="${result.cdTp}"/></td>
						<td><c:out value="${result.cdDtlsTp}"/></td>
						<td class="l ellipsis"><c:out value="${result.cgCd}"/></td>
						<td><c:out value="${result.updDt}"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="11">데이터가 없습니다.</td>
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
