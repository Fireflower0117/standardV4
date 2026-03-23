<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="stat_chart">
    <dl class="sc_rows">
        <dd class="sc_item">
            <div id="statMngr01"></div>
        </dd>
        <dd class="sc_item">
            <div id="statMngr02"></div>
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
            <th scope="col" rowspan="2">담당자</th>
            <th scope="col" colspan="13">처리완료건수</th>
            <th scope="col" colspan="3">소요일</th>
        </tr>
        <tr>
            <th scope="col">전체</th>
            <c:forEach var="i" begin="1" end="12">
                <th scope="col">${i}월</th>
            </c:forEach>
            <th scope="col">평균</th>
            <th scope="col">최소</th>
            <th scope="col">최대</th>
        </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(resultList) gt 0}">
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr class="${empty result.userSerno ? 'all' : ''}">
                            <th scope="row"><c:out value="${not empty result.userSerno ? result.userNm : '총계'}"/></th>
                            <td><c:out value="${result.all1}"/></td>
                            <td><c:out value="${nowMonth >= 1 ? result.cnt1 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 2 ? result.cnt2 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 3 ? result.cnt3 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 4 ? result.cnt4 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 5 ? result.cnt5 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 6 ? result.cnt6 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 7 ? result.cnt7 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 8 ? result.cnt8 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 9 ? result.cnt9 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 10 ? result.cnt10 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 11 ? result.cnt11 : '-'}"/></td>
                            <td><c:out value="${nowMonth >= 12 ? result.cnt12 : '-'}"/></td>
                            <td><fmt:formatNumber value="${not empty result.avg ? result.avg : 0 }" pattern="#,###.##"/></td>
                            <td><fmt:formatNumber value="${not empty result.min ? result.min : 0 }" pattern="#,###.#"/></td>
                            <td><fmt:formatNumber value="${not empty result.max ? result.max : 0 }" pattern="#,###.#"/></td>
                        </tr>
                    </c:forEach>
                </c:when>
            </c:choose>
        </tbody>
    </table>
</div>
<script type="text/javaScript">
    Highcharts.chart('statMngr01', {
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
            text: '담당자 수 <em style="font-size: 55px;">${fn:length(resultList) -1}</em>명',
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
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.userSerno}">
                        '${result.userNm}',
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
                    <c:if test="${not empty result.userSerno}">
                        ${result.all1},
                    </c:if>
                </c:forEach>
            ],
            colorByPoint: true
        }]
    });

    Highcharts.chart('statMngr02', {
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
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${not empty result.userSerno}">
                        '${result.userNm}',
                    </c:if>
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
                        <c:if test="${not empty result.userSerno}">
                            ${result.avg},
                        </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '최소',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <c:if test="${not empty result.userSerno}">
                            ${result.min},
                        </c:if>
                    </c:forEach>
                ]
            },
            {
                name: '최대',
                data: [
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <c:if test="${not empty result.userSerno}">
                            ${result.max},
                        </c:if>
                    </c:forEach>
                ]
            }
        ]
    });
</script>