<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
.cursor_none {
	cursor: default;
}
</style>
<div class="tbl_top">
	<div class="tbl_left">
		<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
	</div>
	<div class="tbl_right">
		<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel" ><span>엑셀다운로드</span></a>
		<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
	</div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
		<caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
		<colgroup>
			<col style="width: 6%">
			<col style="width: 15%;">
			<col style="width: 15%;">
			<col style="width: 15%;">
			<col>
			<col style="width:10%">
			<col style="width: 6%;">

		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<th scope="col">전화번호</th>
				<th scope="col">이메일</th>
				<th scope="col">권한</th>
				<th scope="col">사용여부</th>

			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<c:choose>
							<c:when test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
								<tr onclick="fncPageBoard('update', 'updateForm.do', '${result.userSn}', 'userSn')" class="cursor">
							</c:when>
							<c:otherwise>
								<tr class="cursor_none">
							</c:otherwise>
						</c:choose>
							<td><c:out value="${paginationInfo.totalRecordCount + 1 - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
							<td><c:out value="${result.userId }"/></td>
							<td><c:out value="${result.userNm}"/></td>
							<td>
								<c:out value="${not empty result.userTelNo ? util:getDecryptAES256HyPhen(result.userTelNo) : '-' }"/>
							</td>
							<td class="ellipsis"><c:out value="${result.userEmlAddr}"/></td>
							<td class="ellipsis"><c:out value="${result.grpAuthrtNm }"/></td>
							<td><c:out value="${result.useYn eq 'Y' ? '사용' : '미사용' }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="8">등록된 내역이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
<div class="paging_wrap">
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</div>
	<div class="btn_right">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<a href="javascript:void(0)" class="btn btn_mdl btn_write" onclick="fncPageBoard('write', 'insertForm.do');">등록</a>
		</c:if>
	</div>
</div>
<script>
$(document).ready(function(){
	<%-- 선택된 값들 선택 유지 --%>
	fncChkReLoad();
	
	<%-- 선택에 따른 변화 셋팅 --%>
	fncCheckActionSet();
});
</script>