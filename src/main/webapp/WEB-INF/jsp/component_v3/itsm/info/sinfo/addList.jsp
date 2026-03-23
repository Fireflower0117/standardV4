<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
    .hhover:hover {
        text-decoration-line: underline;
        color: blue;
    }
</style>

<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
    </div>
    <div class="tbl_right">
    	<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel" onclick="fncExcel('${paginationInfo.totalRecordCount }')"><span>엑셀 다운로드</span></a>&nbsp;
    	<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:5%;">
            <col style="width:20%;">
            <col>
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">서비스명</th>
                <th scope="col">도메인 URL</th>
                <th scope="col">서비스담당자</th>
                <th scope="col">개발담당자</th>
                <th scope="col">등록자</th>
                <th scope="col">등록일</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
			<c:when test="${fn:length(resultList) gt 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.svcSn}', 'svcSn');" style="cursor:pointer">
	                <td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
	                <td><c:out value="${result.svcNm }"/></td>
	                <td ><span class="hhover" onclick="event.cancelBubble=true; window.open('${fn:contains(result.svcUrl, 'http') ? '' : 'https://'}${result.svcUrl}' , '_blank')"><c:out value="${result.svcUrl } "/><i class="xi-external-link"></i></span></td>
	                <td><c:out value="${result.svcMngr }"/></td>
	                <td><c:out value="${result.devMngr }"/></td>
	                <td><c:out value="${result.rgtrNm }"/></td>
	                <td><c:out value="${result.regDt }"/></td>
	            </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            <tr class="no_data">
                <td colspan="7">데이터가 없습니다.</td>
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
		<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
			<a href="javascript:void(0);" class="btn btn_mdl btn_write" onclick="fncPageBoard('write', 'insertForm.do');">등록</a>
		</c:if>
	</div>
</div>
