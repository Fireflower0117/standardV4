<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:if test="${searchVO.menuCd ne 'statAll'}">
<div class="stat_chart">
    <dl class="sc_rows row3_7">
        <dd class="sc_item">
            <div id="statErr01"></div>
        </dd>
        <dd class="sc_item stat_count">
            <ul>
                <li>FRONT<span><em><c:out value="${not empty resultList[0].cnt4 ? resultList[0].cnt4 : 0}"/></em>건</span></li>
                <li>PG<span><em><c:out value="${not empty resultList[0].cnt5 ? resultList[0].cnt5 : 0}"/></em>건</span></li>
                <li>DB<span><em><c:out value="${not empty resultList[0].cnt6 ? resultList[0].cnt6 : 0}"/></em>건</span></li>
                <li>SERVER<span><em><c:out value="${not empty resultList[0].cnt7 ? resultList[0].cnt7 : 0}"/></em>건</span></li>
            </ul>
            <div id="statErr02"></div>
        </dd>
    </dl>
</div>

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
        </colgroup>
        <thead>
        <tr>
            <th scope="col" rowspan="2">월</th>
            <th scope="col" colspan="3">에러유형</th>
            <th scope="col" colspan="4">에러구분</th>
        </tr>
        <tr>
            <th scope="col">404에러</th>
            <th scope="col">500에러</th>
            <th scope="col">기타</th>
            <th scope="col">FRONT</th>
            <th scope="col">PG</th>
            <th scope="col">DB</th>
            <th scope="col">SERVER</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${resultList}" varStatus="status">
            <tr class="${not empty result.month? '' : 'all'}">
                <th scope="row"><c:out value="${not empty result.month? result.month : '총계'}"/></th>
                <td><c:out value="${result.cnt1 > 0 ? result.cnt1 : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.cnt2 > 0 ? result.cnt2 : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.cnt3 > 0 ? result.cnt3 : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.cnt4 > 0 ? result.cnt4 : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.cnt5 > 0 ? result.cnt5 : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.cnt6 > 0 ? result.cnt6 : status.index > nowMonth ? '-' : 0}"/></td>
                <td><c:out value="${result.cnt7 > 0 ? result.cnt7 : status.index > nowMonth ? '-' : 0}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</c:if>
<script type="text/javaScript">
<c:if test="${searchVO.menuCd ne 'statAll'}">
    <%-- 에러유형 --%>
    Highcharts.chart('statErr01', {
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
                color: '#000',
            }
        },
        xAxis: {
            categories: ['404에러', '500에러', '기타'],
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
            name: "건수",
            data: [${resultList[0].cnt1},${resultList[0].cnt2},${resultList[0].cnt3}],
            colorByPoint: true
        }]
    });
</c:if>
    <%-- 에러구분 --%>
    Highcharts.chart('statErr02', {
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
            text: '전체건수 <em style="font-size: 55px;">${resultList[0].cnt4 + resultList[0].cnt5 + resultList[0].cnt6 + resultList[0].cnt7}</em>건',
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
        legend: {
            y: 10,
            margin: 0
        },
        tooltip: {
            shared: true,
        },
        series: [
            {
                name: 'FRONT',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt4},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: 'PG',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt5},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: 'DB',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt6},
                    </c:if>
                    </c:forEach>
                ]
            },
            {
                name: 'SERVER',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.month}">
                    ${result.cnt7},
                    </c:if>
                    </c:forEach>
                ]
            }
        ]
    });
</script>