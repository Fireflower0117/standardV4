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
    <div class="tbl_right">
        <jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<c:if test="${searchVO.schEtc03 ne '4' and searchVO.schEtc03 ne '3' }">
    <table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:5%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:${searchVO.schEtc03 eq '3' ? '30%;':'15%;'}">
            <col>
            <c:if test="${searchVO.schEtc03 eq '2' }">
                <col style="width:8%;">
            </c:if>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">영역</th>
                <th scope="col">ID</th>
                <th scope="col">성명</th>
                <th scope="col">${searchVO.schEtc03 eq '1' or searchVO.schEtc03 eq '3' ? '접속시간':'최근로그인'}</th>
                <th scope="col">접속IP</th>
                <c:if test="${searchVO.schEtc03 eq '2' }">
                    <th scope="col">접속횟수</th>
                </c:if>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(resultList) > 0}">
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr class="cursor">
                            <td>${paginationInfo.totalRecordCount+1 - ((searchVO.currentPageNo-1) * searchVO.recordCountPerPage + status.count)}</td>
                            <td>${result.authrtAreaNm }</td>
                            <td>${result.regrId }</td>
                            <td>${result.name }</td>
                            <td class="subject c"><span>${result.regDt }</span></td>
                            <td>${result.logIpAddr }</td>
                            <c:if test="${searchVO.schEtc03 eq '2' }">
                                <td><fmt:formatNumber value="${result.logCnt }" pattern="#,###"/></td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="${searchVO.schEtc03 eq '2' ? '7': searchVO.schEtc03 eq '3' ? '3':'6'}" class="no_data">데이터가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</c:if>
<%-- 접속지점이상 --%>
<c:if test="${searchVO.schEtc03 eq '3'}">
    <table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:5%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:${searchVO.schEtc03 eq '3' ? '30%;':'15%;'}">
            <col>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">영역</th>
                <th scope="col">유형</th>
                <th scope="col">ID</th>
                <th scope="col">성명</th>
                <th scope="col">접속시간</th>
                <th scope="col">접속IP</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(resultList) > 0}">
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td class="c">${paginationInfo.totalRecordCount+1 - ((searchVO.currentPageNo-1) * searchVO.recordCountPerPage + status.count)}</td>
                            <td class="c">${result.authrtAreaNm }</td>
                            <td class="c">${result.lgnYn eq 'Y' ? '접근시도' : '' }${result.logIpErrYn eq 'Y' ? '비허가IP접근' : '' }</td>
                            <td class="c">${result.regrId }${result.acsId }</td>
                            <td class="c">${result.name }</td>
                            <td class="c" class="subject"><a href="#"><span>${result.regDt }</span></a></td>
                            <td class="c">${result.logIpAddr }</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="7" class="no_data">데이터가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</c:if>
<%-- 사용자관리 들어오면 생성 --%>
<c:if test="${searchVO.schEtc03 eq '4' }">
    <table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:5%;">
            <col style="width:15%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:15%;">
            <col>
            <col style="width:8%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">부서</th>
                <th scope="col">ID</th>
                <th scope="col">성명</th>
                <th scope="col">최근로그인</th>
                <th scope="col">최근 접속 IP</th>
                <th scope="col">로그인 실패횟수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(resultList) > 0}">
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="7" class="no_data">데이터가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</c:if>
<%-- //tbl --%>
<%-- paging --%>
<div class="paging_wrap">
    <div class="paging">
        <ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncAddList" />
    </div>
</div>
<%-- //paging --%>