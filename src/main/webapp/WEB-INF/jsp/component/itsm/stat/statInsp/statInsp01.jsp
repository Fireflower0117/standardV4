<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:if test="${searchVO.menuCd ne 'statAll'}">
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
            <th scope="col">일일점검</th>
            <th scope="col">정기점검</th>
            <th scope="col">특별점검</th>
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
</c:if>
<script type="text/javaScript">
<c:if test="${searchVO.menuCd ne 'statAll'}">
    <%-- 점검현황1 --%>
    Highcharts.chart('statInsp01', {
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
            text: '전체건수 <em style="font-size: 55px;">${resultList[0].all1}</em>건',
            useHTML: true,
            style: {
                fontSize: '30px',
                fontWeight: '700',
                color: '#000',
            }
        },
        xAxis: {
            categories: ['일일점검', '정기점검', '특별점검'],
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
                    enabled: true,
                    format: '{y: ,.0f}건'
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
            name: "name",
            data: [${resultList[0].cnt1}, ${resultList[0].cnt2}, ${resultList[0].cnt3}],
            colorByPoint: true
        }]
    });
</c:if>
    <%-- 점검현황2 --%>
    Highcharts.chart('statInsp02', {
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
            text: '전체건수 <em style="font-size: 55px;">${not empty resultList[0].all1 ? resultList[0].all1 : '0'}</em>건',
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
        tooltip: {
            shared: true,
        },
        series: [
            {
                name: '일일점검',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt1},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '정기점검',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt2},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '특별점검',
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