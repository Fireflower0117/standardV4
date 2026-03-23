<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
	<div class="tbl_left">
		<div class="all_num"><i class="i_all"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
	<div class="tbl_right"></div>
</div>
<div class="tbl_wrap">
	<table class="tbl col link board board_col_type01">
		<caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
		<colgroup>
			<col style="width: 5%;">
			<col style="width: 10%;">
			<col style="width: 15%;">
			<col style="width: 15%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">이름</th>
				<th scope="col">전화번호</th>
				<th scope="col">이메일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr style="cursor: default;" onclick="fncAddPic('${result.userSerno }','${result.userNm }');">
							<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.index) }"/></td>
							<td class="ellipsis c"><c:out value="${result.userNm }"/></td>
							<td class="ellipsis c"><c:out value="${empty result.userTelNo ? '-' : util:getDecryptAES256HyPhen(result.userTelNo) }"/></td>
							<td class="ellipsis c"><c:out value="${empty result.userEmailAddr ? '-' : result.userEmailAddr }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="4">조회된 내역이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
<%-- <div class="paging_wrap">
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="default" jsFunction="fncPopBoard"/>
	</div>
</div> --%>

<script>
function fncAddPic(serno, name) {
	let gbn = $("#mngrGbn").val();

	<%-- 고객담당자 --%>
	if(gbn == 'MNGB02') {
		$("#custMngrNm").text(name)
		$("#custMngrSn").val(serno)

	<%-- 개발담당자 --%>
	}else if(gbn == 'MNGB01'){
		$("#dvlpMngrNm").text(name)
		$("#dvlpMngrSn").val(serno)

	}
	
	$("#btn_remove").show();
	modal_hide_all();
}
</script>