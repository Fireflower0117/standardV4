<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
    <div class="tbl_right">
        <button type="button" class="btn btn_excel" onclick="fncExcel('1');"><span>엑셀다운로드</span></button>
    </div>
</div>
<div class="tbl">
    <table class="tbl_col_type02">
        <colgroup>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
        </colgroup>
        <thead>
        <tr>
            <th scope="col" rowspan="2">메뉴</th>
            <th scope="col" colspan="13">처리완료건수</th>
        </tr>
        <tr>
            <th scope="col">전체</th>
            <c:forEach var="i" begin="1" end="12">
                <th scope="col">${i}월</th>
            </c:forEach>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${resultList}" varStatus="status">
            <tr class="${empty result.menuCd ? 'all' : ''}">
                <td><c:out value="${empty result.menuCd ? '총계' : result.menuNm}"/></td>
                <td><c:out value="${result.cnt }"/></td>
                <td><c:out value="${nowMonth >= 1 ? result.month1 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 2 ? result.month2 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 3 ? result.month3 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 4 ? result.month4 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 5 ? result.month5 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 6 ? result.month6 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 7 ? result.month7 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 8 ? result.month8 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 9 ? result.month9 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 10 ? result.month10 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 11 ? result.month11 : '-'}"/></td>
                <td><c:out value="${nowMonth >= 12 ? result.month12 : '-'}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

