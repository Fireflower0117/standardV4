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
        </colgroup>
        <thead>
        <tr>
            <th scope="col">월</th>
            <th scope="col">전체</th>
            <th scope="col">긴급</th>
            <th scope="col">일반</th>
            <th scope="col">중요</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${resultList}" varStatus="status">
                <tr class="${not empty result.month? '' : 'all'}">
                    <th scope="row"><c:out value="${not empty result.month? result.month : '총계'}"/></th>
                    <td><c:out value="${result.all1 > 0 ? result.all1 : status.index > nowMonth ? '-' : 0}"/></td>
                    <td><c:out value="${result.cnt1 > 0 ? result.cnt1 : status.index > nowMonth ? '-' : 0}"/></td>
                    <td><c:out value="${result.cnt2 > 0 ? result.cnt2 : status.index > nowMonth ? '-' : 0}"/></td>
                    <td><c:out value="${result.cnt3 > 0 ? result.cnt3 : status.index > nowMonth ? '-' : 0}"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script type="text/javaScript">
    Highcharts.chart('chart2', {
        chart: {
            type: 'column',
            style: {
                fontFamily: 'Pretendard',
            }
        },
        navigation: false,
        credits: {
            enabled: false
        },
        title: false,
        xAxis: {
            categories: [
                <c:forEach var="i" begin="1" end="12">
                    '${i}월',
                </c:forEach>
            ],
            crosshair: true,
            gridLineWidth: 1,
            lineWidth: '0'
        },
        yAxis: {
            title: {
                text: '처리건수'
            },
            gridLineWidth: 0
        },
        legend: {
            borderWidth: '1',
            borderColor: '#e1e1e1'
        },
        tooltip: {
            shared: true,
        },
        series: [
            {
                name: '긴급',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <c:if test="${not empty result.month}">
                            ${result.cnt1},
                        </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '일반',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt2},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '중요',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt3},
                    </c:if>
                    </c:forEach>
                ]
            }
        ]
    });
</script>