<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<div id="chart1"></div>
<script type="text/javaScript">
	Highcharts.chart('chart1', {
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
			text: '전체건수 <em style="font-size: 55px;">${not empty resultList[0].cnt1 ? resultList[0].cnt1 : '0'}</em>건',
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
                ${result.cnt1},
                </c:if>
                </c:forEach>

            ],
			colorByPoint: true
		}]
	});
</script>