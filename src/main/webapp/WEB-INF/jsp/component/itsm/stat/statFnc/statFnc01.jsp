<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>'
<div id="chart1"></div>
<script type="text/javaScript">
    Highcharts.chart('statFnc01', {
        chart: {
            margin: [50, 0, 0, 0],
            style: {
                fontFamily: 'Pretendard',
            }
        },
        navigation: false,
        credits: {
            enabled: false
        },
        title: {
            text: '전체건수 <em style="font-size: 55px;">${itsmStatVO.all1}</em>건',
            useHTML: true,
            style: {
                fontSize: '30px',
                fontWeight: '700',
                color: '#000',
            }
        },
        subtitle: {
            text: '전체건수',
            align: 'center',
            verticalAlign: 'middle',
            y: 100,
            style: {
                fontSize: '22px',
                fontWeight: '500',
                color: '#000'
            }
        },
        plotOptions: {
            pie: {
                dataLabels: {
                    enabled: true,
                    format: '{key} {y: ,.0f}',
                    distance: -50,
                    style: {
                        fontWeight: 'bold',
                        color: 'white'
                    }
                },
                startAngle: -90,
                endAngle: 90,
                center: ['50%', '75%'],
                size: '110%'
            }
        },
        series: [{
            type: 'pie',
            name: '건수',
            innerSize: '50%',
            data: [
                ['일반', ${not empty itsmStatVO.cnt2 ? itsmStatVO.cnt2 : 0}],
                ['긴급', ${not empty itsmStatVO.cnt1 ? itsmStatVO.cnt1 : 0}],
                ['중요', ${not empty itsmStatVO.cnt3 ? itsmStatVO.cnt3 : 0}]
            ]
        }]
    });
</script>