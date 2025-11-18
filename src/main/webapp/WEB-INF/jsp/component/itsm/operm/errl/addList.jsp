<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
$(document).ready(function(){
})
</script>
<div class="tbl_top">
    <div class="tbl_left">
        <span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
    </div>
    <%--<div class="tbl_right"><a href="#" class="btn btn_sml btn_excel"><span>엑셀다운로드</span></a></div>--%>
    <div class="tbl_right">
    	<!-- <a href="javascript:void(0);" class="btn btn_sml btn_excel" onclick="fncExcel('down')"><span>엑셀다운로드</span></a> -->
    	<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="tbl_wrap">
    <table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width: 5%;">
            <col style="width: 8%;">
            <col style="width: 25%;">
            <col >
            <col style="width: 8%;">
            <col style="width: 10%;">
            <col style="width: 10%;">
            <col style="width: 10%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">에러유형</th>
                <th scope="col">에러설명</th>
                <th scope="col">에러페이지URL</th>
                <th scope="col">메뉴명</th>
                <th scope="col">메뉴 한글명</th>
                <th scope="col">IP주소</th>
                <th scope="col">발생일시</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(resultList) > 0}">
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr onclick="fncPageBoard('view','view.do','${result.serno}','serno')" class="cursor">
                            <td class="ellipsis">${paginationInfo.totalRecordCount+1 - ((searchVO.currentPageNo-1) * searchVO.recordCountPerPage + status.count)}<!-- <span class="tag_notice">공지</span> --></td>
                            <td class="ellipsis">${result.errTpNm}</td>
                            <td class="ellipsis">${result.errExpl}</td>
                            <td class="ellipsis">${result.errPageUrlAddr}</td>
                            <td class="ellipsis">${result.menuCgNm}</td>
                            <td class="ellipsis">${result.menuKorNm}</td>
                            <td class="ellipsis">${result.ipAddr}</td>
                            <td class="ellipsis">${result.errOccrDt}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="8" class="no_data">데이터가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>
<%-- //tbl --%>
<div class="paging_wrap">
    <div class="paging">
    	<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard" />
    </div>
</div>