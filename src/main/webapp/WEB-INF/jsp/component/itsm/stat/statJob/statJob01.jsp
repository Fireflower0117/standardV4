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
        </colgroup>
        <thead>
        <tr>
            <th scope="col" rowspan="2">월</th>
            <th scope="col" rowspan="2">총 완료건수</th>
            <th scope="col" rowspan="2">당자 투입현황</th>
            <th scope="col" colspan="4">소요일</th>
        </tr>
        <tr>
            <th scope="col">총 소요일</th>
            <th scope="col">평균</th>
            <th scope="col">최소</th>
            <th scope="col">최대</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${resultList}" varStatus="status">
            <tr class="${not empty result.month? '' : 'all'}">
                <th scope="row"><c:out value="${not empty result.month? result.month : '총계'}"/></th>
                <td><c:out value="${result.all1 > 0 ? result.all1 : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.cnt > 0 ? result.cnt : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.sum > 0 ? result.sum : status.index > nowMonth ? '-' : 0}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${status.index > nowMonth}">
                            -
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${result.avg}" pattern="#,###.##" />
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><c:out value="${result.min > 0 ? result.min : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.max > 0 ? result.max : status.index > nowMonth ? '-' : 0}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script type="text/javaScript">
    <%-- 월별 총건수 --%>
    Highcharts.chart('statJob01', {
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
        title: {
            text: '총 완료건수 <em style="font-size: 55px;">${not empty resultList[0].all1 ? resultList[0].all1 : '0'}</em>건',
            useHTML: true,
            style: {
                fontSize: '30px',
                fontWeight: '700',
                fontFamily: 'Pretendard',
                color: '#000',
            }
        },
        xAxis: {
            categories: [
                <c:forEach var="i" begin="1" end="12">
                    '${i}월',
                </c:forEach>
            ],
            crosshair: true,
        },
        yAxis: {
            title: {
                text: '건수'
            }
        },
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true
                },
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            shared: true,
        },
        series: [{
            name: "건수",
            data: [
                <c:forEach var="result" items="${resultList}" varStatus="status">
                <c:if test="${not empty result.month}">
                ${result.all1},
                </c:if>
                </c:forEach>
            ],
            colorByPoint: true
        }]
    });

    <%-- 소요일 --%>
    Highcharts.chart('statJob02', {
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
                text: '시간'
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
                name: '평균',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.avg},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '최소',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.min},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '최대',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.max},
                    </c:if>
                    </c:forEach>
                ]
            }
        ]
    });
</script>