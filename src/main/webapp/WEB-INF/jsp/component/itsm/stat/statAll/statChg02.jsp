<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<div id="chart2"></div>
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
        <c:choose>
            <c:when test="${searchVO.menuCd eq 'statAll'}">
            title: {
                <c:set var="total" value="0"/>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:set var="total" value="${total + result.cnt}"/>
                </c:forEach>
                text: '전체건수 <em style="font-size: 55px;">${total}</em>건',
                useHTML: true,
                style: {
                    fontSize: '30px',
                    fontWeight: '700',
                    fontFamily: 'Pretendard',
                    color: '#000',
                }
            },
            </c:when>
            <c:otherwise>
                title: false,
            </c:otherwise>
        </c:choose>
        xAxis: {
            categories: [
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.menuCd}">
                        '${result.menuNm}',
                    </c:if>
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
                    <c:if test="${not empty result.menuCd}">
                        ${result.cnt},
                    </c:if>
                </c:forEach>
            ],
            colorByPoint: true
        }]
    });
</script>