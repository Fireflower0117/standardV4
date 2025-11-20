Highcharts.setOptions({
    lang: {
        thousandsSep: ',' // 1000 단위로 , 추가. 선언 후에 개별적으로 format변경 필수
    }
});


// column
Highcharts.chart('columnChart1_1', {
    chart: {
        type: 'column',
        height: '400' // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: {
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    },
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '장애발생건수',
        data: [1, 2, 1, 1, 4, 3, 2, 1, 1, 0, 1, 2]
    }]
});

Highcharts.chart('columnChart1_2', {
    chart: {
        type: 'column',
        height: '400' // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: {
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    },
    yAxis: {
        min: 0, // 축 최소값 (기본값 undefined)
        title: null,
        labels: {
            style: {
                color: '#222429',
                fontSize: '12px'
            },
            format: '{value}개' // y축 format 설정
        },
        tickInterval: 2, // y축 값 간격
    },
    legend: {
        enabled: false, // legend 없애기. (기본값 true)
    },
    tooltip: {
        shared: true, // series 각 툴팁을 한 개의 툴팁으로
        useHTML: true, // html 사용 여부
        headerFormat: '<div><b style="color: #000;">{point.key}</b></div>',
        style: { // tooltip 스타일 지정
            color: '#058DC7',
            fontWeight: 'bold'
        }
    },
    plotOptions: {
        column: {
            stacking: true, // 단일 series를 사용하는 경우, dataLabel을 상하 center 정렬 할때 사용. column chart 인데 series가 여러개일 경우 사용불가
            pointWidth: 35, // 막대 width 지정
            borderWidth: 0, // 막대 border 값
            opacity: 0.9, // 막대 opacity 값
            dataLabels: {
                enabled: true, // 각 data에 label 추가, 기본값 false
                format: '{y}개', // data label format 설정
                style: {
                    fontWeight: '700',
                    color: '#fff',
                    textOutline: 'none'
                }
            }
        }
    },
    series: [{
        color: '#058DC7', // series의 컬러값 지정방법 2번. 각 series 안에 컬러값 직접 지정
        name: '장애발생건수',
        data: [1, 2, 1, 1, 4, 3, 2, 1, 1, 0, 1, 2]
    }]
});

Highcharts.chart('columnChart2_1', {
    chart: {
        type: 'column',
        height: '400' // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: {
        categories: [
            'x축 카테고리 이름1',
            'x축 카테고리 이름2',
            'x축 카테고리 이름3',
            'x축 카테고리 이름4',
            'x축 카테고리 이름5'
        ]
    },
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00'], // series의 컬러값 지정방법 1번. series 순서에 맞게 컬러값 넣기
    series: [{
        name: '데이터1 이름',
        data: [490, 710, 1060, 1290]
    }, {
        name: '데이터2 이름',
        data: [830, 780, 1980, 930]
    }, {
        name: '데이터3 이름',
        data: [480, 380, 1390, 410],
    }, {
        name: '데이터4 이름',
        data: [420, 330, 1340, 390]
    }]
});

Highcharts.chart('columnChart2_2', {
    chart: {
        type: 'column',
        height: '400' // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: {
        categories: [
            'x축 카테고리 이름1',
            'x축 카테고리 이름2',
            'x축 카테고리 이름3',
            'x축 카테고리 이름4',
            'x축 카테고리 이름5'
        ],
        crosshair: true, // 가리킨 지점에 따라가는 선 그리기. column에 적용시 해당 영역 background color 들어감 (기본값 false)
    },
    yAxis: {
        min: 0, // 축 최소값 (기본값 undefined)
        title: null,
        labels: {
            style: {
                color: '#222429',
                fontSize: '12px'
            },
            format: '{value: ,.0f}개' // y축 label에 1000 단위로 , 추가
        },
    },
    tooltip: {
        shared: true, // series 각 툴팁을 한 개의 툴팁으로
        useHTML: true, // html 사용 여부
    },
    plotOptions: {
        column: {
            pointPadding: 0.2, // 막대 사이 padding (기본값 0.1 / ex 0 = 막대 사이 빈 공간 x, 숫자가 커질수록 막대 얇아짐)
            borderWidth: 0, // 막대 border 값
            // highcharts-border-radius js 필수 (borderRadiusTopLeft / TopRight / BottomLeft / BottomRight)
            // 각 막대별로 주려면 series에 추가
            borderRadiusTopLeft: 5,
            borderRadiusTopRight: 5,
            dataLabels: {
                enabled: true, // 각 data에 label 추가, 기본값 false
                format: '{y: ,.0f}개', // data label format 설정 
                y: 0, // data label 위치 설정 
                allowOverlap: true // 겹치는것 때문에 data label 안나오는것 방지, 기본값 false
            }
        }
    },
    colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00'], // series의 컬러값 지정방법 1번. series 순서에 맞게 컬러값 넣기
    series: [{
        name: '데이터1 이름',
        data: [490, 710, 1060, 1290]
    }, {
        name: '데이터2 이름',
        data: [830, 780, 1980, 930]
    }, {
        name: '데이터3 이름',
        data: [480, 380, 1390, 410],
    }, {
        name: '데이터4 이름',
        data: [420, 330, 1340, 390]
    }]
});

Highcharts.chart('columnChart3', {
    chart: {
        type: 'column'
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: {
        type: 'category'
    },
    yAxis: {
        title: null
    },
    legend: {
        enabled: false
    },
    plotOptions: {
        series: {
            borderWidth: 0,
            dataLabels: {
                enabled: true,
            }
        }
    },
    tooltip: {
        headerFormat: '<span style="font-size: 11px">{series.name}</span><br>',
        pointFormat: '<span>{point.name}</span>: <b>{point.y}건</b>'
    },
    series: [{
        name: '시리즈이름',
        colorByPoint: true, // 데이터마다 color 다르게
        data: [{
            name: '카테고리1',
            y: 60,
            drilldown: '카테고리1'
        }, {
            name: '카테고리2',
            y: 50,
            drilldown: '카테고리2'
        }, {
            name: '카테고리3',
            y: 40,
            drilldown: '카테고리3'
        }, {
            name: '카테고리4',
            y: 30,
            drilldown: null
        }]
    }],
    drilldown: {
        activeAxisLabelStyle: {
            color: "#000",
            fontWeight: "normal"
        },
        activeDataLabelStyle: {
            color: "#000",
            fontWeight: "bold",
            textDecoration: 'none',
        },
        breadcrumbs: {
            position: {
                align: 'left'
            }
        },
        series: [{
            name: '카테고리1',
            id: '카테고리1',
            data: [
                ['카테고리1-1', 30],
                ['카테고리1-2', 40],
                ['카테고리1-3', 50],
            ]
        }, {
            name: '카테고리2',
            id: '카테고리2',
            data: [
                ['카테고리2-1', 30],
                ['카테고리2-2', 40],
                ['카테고리2-3', 50],
            ]
        }, {
            name: '카테고리3',
            id: '카테고리3',
            data: [
                ['카테고리3-1', 30],
                ['카테고리3-2', 40],
                ['카테고리3-3', 50],
            ]
        },
        ]
    }
});


// bar
Highcharts.chart('barChart', {
    chart: {
        type: 'bar',
        height: '400' // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: {
        categories: [
            'x축 카테고리 이름1',
            'x축 카테고리 이름2',
            'x축 카테고리 이름3',
            'x축 카테고리 이름4',
            'x축 카테고리 이름5'
        ],
        gridLineWidth: 1,
        lineWidth: 0
    },
    yAxis: {
        title: null,
        gridLineWidth: 0,
    },
    plotOptions: {
        bar: {
            dataLabels: {
                enabled: true, // 각 data에 label 추가, 기본값 false
                allowOverlap: true // 겹치는것 때문에 data label 안나오는것 방지, 기본값 false
            }
        }
    },
    colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00'], // series의 컬러값 지정방법 1번. series 순서에 맞게 컬러값 넣기
    series: [{
        name: '데이터1 이름',
        data: [490, 710, 1060, 1290]
    }, {
        name: '데이터2 이름',
        data: [830, 780, 1980, 930]
    }, {
        name: '데이터3 이름',
        data: [480, 380, 1390, 410],
    }, {
        name: '데이터4 이름',
        data: [420, 330, 1340, 390]
    }]
});


// stacked
Highcharts.chart('stackedChart1_1', {
    chart: {
        type: 'column',
        height: '400' // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: {
        categories: [
            'x축 카테고리 이름1',
            'x축 카테고리 이름2',
            'x축 카테고리 이름3',
            'x축 카테고리 이름4',
            'x축 카테고리 이름5'
        ],
    },
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '데이터1 이름',
        data: [49, 71, 106, 129, 144]
    }, {
        name: '데이터2 이름',
        data: [83, 78, 98, 93, 106]
    }, {
        name: '데이터3 이름',
        data: [48, 38, 39, 41, 47],
    }, {
        name: '데이터4 이름',
        data: [42, 33, 34, 39, 52]
    }]
});

Highcharts.chart('stackedChart1_2', {
    chart: {
        type: 'column',
        height: '400', // 차트 높이 지정
        backgroundColor: '#222',
        marginTop: 60,
        marginRight: 50,
        marginLeft: 70,
        marginBottom: 60
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: {
        categories: [
            'x축 카테고리 이름1',
            'x축 카테고리 이름2',
            'x축 카테고리 이름3',
            'x축 카테고리 이름4',
            'x축 카테고리 이름5'
        ],
        labels: { // 축 label 설정. yAxis 에도 동일한 옵션 사용
            style: { // label 스타일 설정
                color: '#fff',
                fontSize: '11px',
                fontWeight: '500'
            },
        },
        lineColor: '#727272', // x축 가장 하단 line color 지정
    },
    yAxis: {
        min: 0, // 축 최소값 (기본값 undefined)
        title: '',
        labels: { // 축 label 설정. yAxis 에도 동일한 옵션 사용
            style: { // label 스타일 설정
                color: '#fff',
                fontSize: '12px',
                fontWeight: '500'
            },
            format: '{value}개' // y축 format 설정
        },
        gridLineColor: '#727272', // y축 그리드 color 지정
        stackLabels: { // stack 차트 상단에 데이터의 합 표출
            enabled: true, // 기본값 false
            style: {
                fontWeight: 'bold',
                color: '#fff',
                textOutline: 'none'
            }
        }
    },
    legend: {
        useHTML: true,
        align: 'right', // legend x축 기준 기본위치. left, center(기본값), right
        verticalAlign: 'top', // legend y축 기준 기본위치. top, middle, bottom(기본값)
        y: 0, // y축 기준 위치
        x: -30, // x축 기준 위치
        itemStyle: { // legend 아이템 스타일
            fontWeight: '500',
            fontSize: '12px',
            color: '#fff',
            lineHeight: '20px'
        },
        itemHoverStyle: { // legend 아이템 hover 스타일
            color: '#fff'
        },
        symbolWidth: 8, // legend symbol 가로사이즈
        symbolHeight: 8, // legend symbol 세로사이즈
        symbolRadius: 0, // legend symbol 둥근정도
        itemDistance: 10, // legend 아이템 사이 간격 
        floating: true // 공간을 차지하는 여부, 기본값 false (차지함)
    },
    tooltip: {
        shared: true, // series 각 툴팁을 한 개의 툴팁으로
        useHTML: true // html 사용 여부
    },
    plotOptions: {
        column: {
            stacking: true, // 기본값 undefined
            pointPadding: 0.2, // 막대 사이 padding (기본값 0.1 / ex 0 = 막대 사이 빈 공간 x, 숫자가 커질수록 막대 얇아짐)
            borderWidth: 2, // 막대 border 값
            borderColor: '#222', // 막대 border 색상
            dataLabels: {
                enabled: true
            }
        }
    },
    series: [{
        name: '데이터1 이름',
        data: [49, 71, 106, 129, 144],
        // highcharts-border-radius js 필수 (borderRadiusTopLeft / TopRight / BottomLeft / BottomRight)
        // 각 막대별로 주려면 series에 추가
        borderRadiusTopLeft: 5,
        borderRadiusTopRight: 5
    }, {
        name: '데이터2 이름',
        data: [83, 78, 98, 93, 106]
    }, {
        name: '데이터3 이름',
        data: [48, 38, 39, 41, 47],
    }, {
        name: '데이터4 이름',
        data: [42, 33, 34, 39, 52]
    }]
});

Highcharts.chart('stackedChart2_1', {
    chart: {
        type: 'column'
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: {
        categories: ['서울', '인천', '경기', '충남', '세종', '대전'],
    },
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '데이터1',
        color: '#36a7e1',
        data: [350, 418, 312, 350, 418, 312],
    }, {
        name: '데이터2',
        color: '#e1b670',
        data: [100, 87, 54, 37, 70, 100],
    }, {
        name: '데이터3',
        color: '#7d9cea',
        data: [25, 30, 12, 73, 40, 25],
    }, {
        name: '데이터4',
        color: '#ff8ec6',
        data: [77, 72, 80, 77, 72, 80],
    }, {
        name: '데이터5',
        color: '#4eccc3',
        data: [77, 72, 80, 77, 72, 80],
    }]
});

Highcharts.chart('stackedChart2_2', {
    chart: {
        type: 'column'
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: {
        categories: ['서울', '인천', '경기', '충남', '세종', '대전'],
        crosshair: true, // 가리킨 지점에 따라가는 선 그리기. column에 적용시 해당 영역 background color 들어감 (기본값 false)
        labels: { // label 스타일 설정
            style: {
                fontSize: '13px',
                color: '#000',
                fontWeight: 'bold'
            }
        },
        lineColor: '#999999', // x축 가장 하단 line color 지정
    },
    yAxis: {
        allowDecimals: false,
        min: 0,
        title: {
            text: ''
        },
        gridLineColor: '#999999', // y축 그리드 color 지정
        tickInterval: 100, // y축 값 간격
        labels: {
            enabled: false // y축 label 숨김
        }
    },
    tooltip: {
        shared: true, // series 각 툴팁을 한 개의 툴팁으로
        useHTML: true, // html 사용 여부
        /*formatter: function() { // 툴팁 format 지정
        return '<b>' + this.x + '</b><br/>' +
            this.series.name + ': ' + this.y + '<br/>' +
            'Total: ' + this.point.stackTotal;
        }*/
        headerFormat: '<div><b style="color: #000;">{point.key}</b></div>',
    },
    plotOptions: {
        column: {
            stacking: true
        },
        series: {
            borderWidth: 0 // stack 차트 border 없애기
        }
    },
    series: [{
        name: '데이터1',
        color: '#36a7e1',
        data: [350, 418, 312, 350, 418, 312],
        stack: 'first' // 쌓이는 위치 지정. 지정하지 않으면 하나의 막대에 쌓이고, 위치를 다르게 서로 지정하면 하나의 x 카테고리에 여러개의 막대가 생성되어 stack 됨.
    }, {
        name: '데이터2',
        color: '#e1b670',
        data: [100, 87, 54, 37, 70, 100],
        stack: 'second'
    }, {
        name: '데이터3',
        color: '#7d9cea',
        data: [25, 30, 12, 73, 40, 25],
        stack: 'second'
    }, {
        name: '데이터4',
        color: '#ff8ec6',
        data: [77, 72, 80, 77, 72, 80],
        stack: 'second'
    }, {
        name: '데이터5',
        color: '#4eccc3',
        data: [77, 72, 80, 77, 72, 80],
        stack: 'second'
    }]
});


// pie
Highcharts.chart('pieChart1_1', {
    chart: {
        type: 'pie',
        height: '300', // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: { // 하단 하이차트 주소 숨김
        enabled: false
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    series: [{
        name: '점유율',
        data: [{
            name: 'Chrome',
            y: 60,
        }, {
            name: 'Internet Explorer',
            y: 20
        }, {
            name: 'Firefox',
            y: 15
        }, {
            name: 'Edge',
            y: 5
        }]
    }]
});

Highcharts.chart('pieChart1_2', {
    chart: {
        type: 'pie',
        height: '300', // 차트 높이 지정
        options3d: { // 3d 옵션
            enabled: true, // 3d 적용
            alpha: 15, // x축 기준 회전
            beta: 15 // y축 기준 회전
        }
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: { // 하단 하이차트 주소 숨김
        enabled: false
    },
    title: null,
    subtitle: null,
    tooltip: {
        headerFormat: '<div><b style="color: #000;">{point.key}</b></div><br>', // 툴팁 format 지정
        pointFormat: '{series.name}: <b>{point.y}</b><br/>', // 툴팁 format 지정
        valueSuffix: ' %' // 툴팁 valueSuffix 고정
    },
    plotOptions: {
        pie: {
            startAngle: 90, // 파이 조각 시작 각도 (기본값 0 / ex 90 -> 오른쪽)
            innerSize: 100, // 원형 차트 내부 공간 크기 지정 (도넛형)
            depth: 80, // 3d 차트 두께
            allowPointSelect: true, // point 선택 가능 여부 (기본값 false)
            cursor: 'pointer',
            dataLabels: {
                distance: -30, // 라벨 위치 지정
                style: {
                    fontWeight: 'bold',
                    color: '#fff',
                    fontSize: '14px'
                }
            }
        }
    },
    series: [{
        name: '점유율',
        colorByPoint: true, // 자동 포인트 색 사용
        data: [{
            name: 'Chrome',
            y: 60,
            sliced: true, // point 분리 가능 여부 (기본값 undefined)
            selected: true, // 선택 상태 (기본값 false)
            color: {
                // 선형 그라디언트 >> 시작 위치(x1, y1), 끝 위치(x2, y2), 0: 상단/왼쪽, 1: 하단/오른쪽
                linearGradient: {
                    x1: 1,
                    x2: 0,
                    y1: 0,
                    y2: 0
                },
                stops: [
                    [0, '#6190E8'],
                    [1, '#A7BFE8']
                ]
            }
        }, {
            name: 'Internet Explorer',
            y: 20,
        }, {
            name: 'Firefox',
            y: 15
        }, {
            name: 'Edge',
            y: 5
        }]
    }]
});

Highcharts.chart('pieChart1_3', {
    chart: {
        type: 'pie',
        height: '300', // 차트 높이 지정
        options3d: { // 3d 옵션
            enabled: true, // 3d 적용
            alpha: 15, // x축 기준 회전
            beta: 15 // y축 기준 회전
        },
        marginRight: 80
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: { // 하단 하이차트 주소 숨김
        enabled: false
    },
    title: null,
    subtitle: null,
    tooltip: {
        headerFormat: '<div><b style="color: #000;">{point.key}</b></div><br>', // 툴팁 format 지정
        pointFormat: '{series.name}: <b>{point.y}</b> ({point.percentage: .1f}%)<br/>' // 툴팁 format 지정
    },
    legend: {
        layout: 'vertical', // legend 아이템 정렬방식. horizontal(기본값), vertical
        align: 'right', // legend x축 기준 기본위치. left, center(기본값), right
        itemMarginTop: 10, // legend가 vertical일때 아이템 사이 간격
        x: 0, // x축 기준 위치
        y: 0, // y축 기준 위치
        floating: true // 공간을 차지하는 여부, 기본값 false (차지함)
    },
    plotOptions: {
        pie: {
            startAngle: 90, // 파이 조각 시작 각도 (기본값 0 / ex 90 -> 오른쪽)
            innerSize: 60, // 원형 차트 내부 공간 크기 지정 (도넛형)
            depth: 40, // 3d 차트 두께  
            dataLabels: {
                distance: 0, // 라벨 위치 지정
                format: '<b>{point.name}</b>: {point.percentage: .1f}%' // 라벨 커스텀
            },
            showInLegend: true // pie 차트에서는 기본값 false
        }
    },
    series: [{
        name: '점유율',
        colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00'], // series의 컬러값 지정방법 1번. series 순서에 맞게 컬러값 넣기
        data: [{
            name: 'Chrome',
            y: 60,
        }, {
            name: 'Internet Explorer',
            y: 20,
        }, {
            name: 'Firefox',
            y: 15
        }, {
            name: 'Edge',
            y: 5
        }]
    }]
});

Highcharts.chart('pieChart2_1', {
    chart: {
        type: 'pie',
        height: '300', // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    series: [{
        name: '거래일',
        data: [{
            name: '1주이내',
            y: 30,
            color: "#058DC7"
        }, {
            name: '1~2주',
            y: 25,
            color: "#50B432"
        }, {
            name: '2~3주',
            y: 22,
            color: "#ED561B"
        }, {
            name: '4주 이상',
            y: 11,
            color: "#DDDF00"
        }]
    }]
});

Highcharts.chart('pieChart2_2', {
    chart: {
        type: 'pie',
        height: '300', // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    tooltip: {
        headerFormat: '<div><b style="color: #000;">{series.name}</b></div><br>', // 툴팁 format 지정
        pointFormat: '{point.name} : <b>{point.y}건</b>' // 툴팁 format 지정
    },
    plotOptions: {
        pie: {
            allowPointSelect: true, // point 선택 가능 여부 (기본값 false)
            cursor: 'pointer',
            depth: 35, // 3d 차트 두께
            dataLabels: {
                enabled: false // 라벨 숨기기(기본값 true)
            },
            showInLegend: true, // pie 차트에서는 기본값 false
            startAngle: -90, // pie 차트 시작 각도
            endAngle: 90, // pie 차트 끝 각도. 시작 각도와 끝 각도가 -90, 90이면 반원모양 파이차트 생성
            center: ['50%', '95%'], // 파이차트 상하 좌우 기준 위치
            size: '150%' // 차트 사이즈
        }
    },
    series: [{
        name: '거래일',
        innerSize: '50%',
        borderColor: '#e9e9e9', // pie차트 border 색상
        borderWidth: 0, // pie차트 border 두께. 0일경우 border 사라짐
        data: [{
            name: '1주이내',
            y: 30,
            color: "#058DC7"
        }, {
            name: '1~2주',
            y: 25,
            color: "#50B432"
        }, {
            name: '2~3주',
            y: 22,
            color: "#ED561B"
        }, {
            name: '4주 이상',
            y: 11,
            color: "#DDDF00"
        }]
    }]
});

Highcharts.chart('pieChart3_1', {
    chart: {
        type: 'pie',
        height: '300', // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    series: [{
        name: '판매량',
        data: [{
            name: '감자',
            y: 5,
        }, {
            name: '고구마',
            y: 55,
        }, {
            name: '옥수수',
            y: 30,
        }, {
            name: '호박',
            y: 13,
        }]
    }]
});

Highcharts.chart('pieChart3_2', {
    chart: {
        type: 'pie',
        height: '300', // 차트 높이 지정
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: {
        text: '<strong>5</strong><span style="font-size: 16px;color: #000;">%</span>', // 타이틀에 값을 넣어 커스텀
        useHTML: true,
        verticalAlign: 'middle', // title 정렬방식. top, middle, bottom
        y: 45, // y축 기준 위치
        x: -40, // x축 기준 위치
        style: {
            fontSize: '60px',
            fontWeight: 'bold',
            fontFamily: 'Pretendard',
            color: '#29285c',
        }
    },
    subtitle: {
        text: '<strong>판매량</strong>',
        useHTML: true,
        verticalAlign: 'middle', // title 정렬방식. top, middle, bottom
        x: -40, // x축 기준 위치
        y: 45, // y축 기준 위치
        style: {
            color: '#000',
            fontSize: '18px',
            fontFamily: 'Pretendard',
        },
    },
    plotOptions: {
        pie: {
            innerSize: 150, // 원형 차트 내부 공간 크기 지정 (도넛형)
            showInLegend: true, // pie 차트에서는 기본값 false
            dataLabels: {
                enabled: false // 라벨 숨기기(기본값 true)
            },
        }
    },
    series: [{
        name: '판매량',
        data: [{
            name: '감자',
            y: 5,
        }, {
            name: '고구마',
            y: 55,
        }, {
            name: '옥수수',
            y: 30,
        }, {
            name: '호박',
            y: 13,
        }, {
            name: '가지',
            y: 33,
        }]
    }],
    legend: {
        title: { // legend title
            text: '판매물품',
            style: {
                fontSize: '20px',
                fontWeight: 'bold',
                fontFamily: 'Pretendard',
                textAlign: 'left',
                whiteSpace: 'normal'
            }
        },
        width: 65, // legend 영역 width. default: 좌우 legend의 경우 차트 너비의 절반 / 상하 legend의 경우 차트 너비
        maxHeight: 147, // legend 영역 max height. 높이가 줄어들면 navigation이 생김
        itemStyle: { // legend 아이템 스타일
            fontSize: '15px',
            fontWeight: '400',
            fontFamily: "pretendard",
        },
        itemMarginTop: 5, // legend가 vertical일때 아이템 사이 간격
        align: 'right', // 가로정렬. left, center(기본값), right
        layout: 'proximate', // legend 아이템 정렬방식. horizontal(기본값), vertical, proximate(차트에 가장 가깝게 배치)
        y: 50, // y축 기준 위치
        navigation: {
            enabled: true,
            animation: true, // 슬라이드될 때 애니메이션 적용 유무. 기본값: true
            arrowSize: 10,
            inactiveColor: '#ddd',
            activeColor: '#00b974',
        }
    },
});


// line
Highcharts.chart('lineChart1_1', {
    chart: {
        type: 'line',
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: { // 하단 하이차트 주소 숨김
        enabled: false
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '데이터1 이름',
        data: [130, 100, 180, 200, 150, 170, 180, 200, 150, 170]
    }, {
        name: '데이터2 이름',
        data: [150, 180, 200, 150, 170, 100, 200, 150, 170, 100]
    }, {
        name: '데이터3 이름',
        data: [160, 200, 150, 170, 100, 130, 150, 170, 100, 130]
    }],
});

Highcharts.chart('lineChart1_2', {
    chart: {
        type: 'line',
        zoomType: 'x', // 마우스로 차트 확대/축소 (x, y, xy)
        panning: true,
        panKey: 'shift'
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: { // 하단 하이차트 주소 숨김
        enabled: false
    },
    title: null,
    subtitle: null,
    xAxis: {
        crosshair: true, // 가리킨 지점에 따라가는 선 그리기. column에 적용시 해당 영역 background color 들어감 (기본값 false)
        lineColor: '#999', // x축 가장 하단 line color 지정
        tickLength: 7, // x축 tick height값
        tickWidth: 2 // x축 tick width값
    },
    yAxis: {
        title: null,
        gridLineColor: '#eee', // y축 그리드 color 지정
        tickInterval: 20, // y축 값 간격
    },
    legend: {
        backgroundColor: '#fff', // legend 배경색
        borderColor: '#CCC', // legend border색
        borderWidth: 1, // legend border 굵기
        itemDistance: 10, // legend 아이템 사이 간격 
    },
    tooltip: {
        shared: true, // series 각 툴팁을 한 개의 툴팁으로
    },
    plotOptions: {
        series: {
            pointStart: 2010, // x축 시작 값 설정 (기본값 0)
            dataLabels: {
                enabled: true // 각 data에 label 추가, 기본값 false
            },
            label: {
                enabled: false, // 차트영역에 나오는 series name 숨기기, 기본값 true
            },
        }
    },
    series: [{
        name: '데이터1 이름',
        data: [130, 100, 180, 200, 150, 170, 180, 200, 150, 170],
        color: '#058DC7'
    }, {
        name: '데이터2 이름',
        data: [150, 180, 200, 150, 170, 100, 200, 150, 170, 100],
        color: '#50B432'
    }, {
        name: '데이터3 이름',
        data: [160, 200, 150, 170, 100, 130, 150, 170, 100, 130],
        color: '#ED561B'
    }]
});

Highcharts.chart('lineChart2_1', {
    chart: {
        type: 'line',
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: {
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    },
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '데이터1 이름',
        data: [16, 18, 23, 27, 32, 36, 39, 38, 35, 29, 22, 17]
    }, {
        name: '데이터2 이름',
        data: [22, 30, 25, 18, 12, 25, 23, 14, 19, 35, 31, 33]
    }]
});

Highcharts.chart('lineChart2_2', {
    chart: {
        type: 'line',
        backgroundColor: '#28292e',
        marginRight: 150,
        marginTop: 30,
        marginBottom: 50
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: {
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        labels: { // 축 label 설정. yAxis 에도 동일한 옵션 사용
            style: { // label 스타일 설정
                color: '#ffffff',
                fontSize: '11px',
                transform: 'translate(0, 0)'
            }
        },
        lineColor: '#8f8f8f', // x축 가장 하단 line color 지정
    },
    yAxis: [{ // 왼쪽 y축 설정
        title: {
            text: '왼쪽 y축 타이틀',
            style: { // y축 title 스타일 설정
                color: '#ffffff'
            }
        },
        gridLineColor: '#5d5d5d', // y축 그리드 color 지정
        labels: {
            style: {
                color: '#ffffff'
            }
        },
    }, { // 오른쪽 y축 설정
        title: {
            text: '오른쪽 y축 타이틀',
            style: {
                color: '#ffffff'
            }
        },
        labels: {
            style: {
                color: '#ffffff'
            }
        },
        opposite: true, // y축을 2개 사용하는 경우, 해당 축을 반대쪽에 표시할지 여부 (기본값 false)
    }],
    legend: {
        layout: 'vertical', // legend 아이템 정렬방식. horizontal(기본값), vertical
        align: 'right', // legend x축 기준 기본위치. left, center(기본값), right
        verticalAlign: 'middle', // legend y축 기준 기본위치. top, middle, bottom(기본값)
        itemMarginTop: 10, // legend가 vertical일때 아이템 사이 간격
        itemStyle: { // legend 아이템 스타일
            fontWeight: 'bold',
            fontSize: '10px',
            color: '#fff'
        },
        itemHoverStyle: { // legend 아이템 hover 스타일
            color: '#fff'
        }
    },
    tooltip: {
        shared: true, // series 각 툴팁을 한 개의 툴팁으로
        useHTML: true, // html 사용 여부
        headerFormat: '<div><b style="color: #000;">{point.key}</b></div>',
        style: { // tooltip 스타일 지정
            color: '#000',
            fontWeight: 'bold'
        }
    },
    plotOptions: {
        line: {
            dataLabels: {
                enabled: true // 각 data에 label 추가, 기본값 false
            },
            label: {
                enabled: false, // 차트영역에 나오는 series name 숨기기, 기본값 true
            },
            // enableMouseTracking: false // 차트 hover action 막기
        }
    },
    colors: ['#9fd6ff', '#ffff47'],
    series: [{
        name: '데이터1 이름',
        y: 0, // 기준 y축 설정. 0이면 왼쪽, 1이면 오른쪽
        data: [16, 18, 23, 27, 32, 36, 39, 38, 35, 29, 22, 17],
        lineWidth: 3, // 차트 라인 width, 기본값 1
        marker: {
            fillColor: '#fff', // 심볼 색상
            lineWidth: 2, // 심볼 border width
            lineColor: '#9fd6ff', // 심볼 border color
            radius: 3 // 심볼 사이즈
        },
        dashStyle: 'shortdot' // line chart일때 선 스타일
    }, {
        name: '데이터2 이름',
        y: 1, // 기준 y축 설정. 0이면 왼쪽, 1이면 오른쪽
        data: [22, 30, 25, 18, 12, 25, 23, 14, 19, 35, 31, 33]
    }]
});


// area
Highcharts.chart('areaChart1_1', {
    chart: {
        type: 'area',
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: [{
        categories: ['x축 카테고리 이름1', 'x축 카테고리 이름2', 'x축 카테고리 이름3', 'x축 카테고리 이름4', 'x축 카테고리 이름5'],
    }],
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '데이터1 이름',
        data: [100, 200, 350, 250, 705],
    }, {
        name: '데이터2 이름',
        data: [234, 343, 645, 755, 124],
    }, {
        name: '데이터3 이름',
        data: [12, 34, 65, 12, 34],
    }]
});

Highcharts.chart('areaChart1_2', {
    chart: {
        type: 'area',
        marginRight: 180,
        marginTop: 30,
        backgroundColor: '#fafafa'
    },
    navigation: false, // 차트 메뉴 버튼 유/무
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    xAxis: [{
        categories: ['x축 카테고리 이름1', 'x축 카테고리 이름2', 'x축 카테고리 이름3', 'x축 카테고리 이름4', 'x축 카테고리 이름5'],
        labels: { // x축 label 설정. yAxis 에도 동일한 옵션 사용
            style: { // label 스타일 설정
                color: '#000',
            },
        },
        lineColor: '#5d5d5d', // x축 가장 하단 line color 지정
        crosshair: true, // 가리킨 지점에 따라가는 선 그리기. column에 적용시 해당 영역 background color 들어감 (기본값 false)
    }],
    yAxis: [{ // 왼쪽 y축 설정
        title: { // 왼쪽 y축 title 설정
            text: '왼쪽 y축 타이틀',
            style: {
                color: '#000'
            }
        },
        labels: { // 왼쪽 y축 label 설정
            format: '{value} 만원',
            style: {
                color: '#000'
            },
        },
        gridLineColor: '#5d5d5d', // y축 그리드 color 지정
    }, { // 오른쪽 y축 설정
        title: { // 오른쪽 y축 title 설정
            text: '오른쪽 y축 타이틀',
            style: {
                color: '#000'
            }
        },
        labels: { // 오른쪽 y축 label 설정
            format: '{value} 건',
            style: {
                color: '#000'
            }
        },
        gridLineColor: '#5d5d5d', // y축 그리드 color 지정 (왼쪽 y축과 동일한 색상 지정)
        opposite: true, // y축을 2개 사용하는 경우, 해당 축을 반대쪽에 표시할지 여부 (기본값 false)
    }],
    plotOptions: {
        area: {
            label: {
                enabled: false, // 차트영역에 나오는 series name 숨기기, 기본값 true
            },
        }
    },
    legend: {
        layout: 'vertical', // legend 아이템 정렬방식. horizontal(기본값), vertical
        align: 'right', // legend x축 기준 기본위치. left, center(기본값), right
        verticalAlign: 'middle', // legend y축 기준 기본위치. top, middle, bottom(기본값)
        itemMarginTop: 10, // legend가 vertical일때 아이템 사이 간격
        itemStyle: { // legend 아이템 스타일
            fontWeight: 'bold',
            fontSize: '10px',
        },
    },
    tooltip: {
        shared: true // series 각 툴팁을 한 개의 툴팁으로
    },
    series: [{
        name: '데이터1 이름',
        yAxis: 0, // 기준 y축 설정. 0이면 왼쪽, 1이면 오른쪽
        data: [100, 200, 350, 250, 705],
        tooltip: {
            valueSuffix: '만원' // tooltip에 나오는 값 뒤의 단위 고정
        },
        color: '#e87026', // legend symbol 에 나오는 marker color
        fillColor: 'rgba(236, 156, 107,0.4)', // area 영역 color
        lineColor: '#fff', // area 라인 color
        marker: { // area marker color
            enabled: false // 마커 숨기기
        }
    }, {
        name: '데이터2 이름',
        yAxis: 0, // 기준 y축 설정. 0이면 왼쪽, 1이면 오른쪽
        data: [234, 343, 645, 755, 124],
        tooltip: {
            valueSuffix: '만원'
        },
        color: '#36d100',
        fillColor: { // area 영역 color gradient로 넣기
            linearGradient: [0, 0, 0, 300],
            stops: [
                [0, 'rgb(101, 228, 57)'],
                [1, 'rgba(255,255,255,.1)']
            ]
        },
        // lineColor, marker 미지정시 color값과 동일한 컬러 사용
    }, {
        name: '데이터3 이름',
        data: [12, 34, 65, 12, 34],
        yAxis: 1, // 기준 y축 설정. 0이면 왼쪽, 1이면 오른쪽
        tooltip: {
            valueSuffix: '건'
        },
        // fillColor, lineColor, marker 미지정시 color값과 동일한 컬러 사용
        color: '#DDDF00',
    }]
});


// dual
Highcharts.chart('dualChart1_1', {
    navigation: false, // 차트 메뉴 버튼 유/무 (필수)
    credits: {
        enabled: false // 하단 하이차트 주소 숨김 (필수)
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: [{
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    }],
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '데이터1 이름',
        data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
    }, {
        name: '데이터2 이름',
        data: [1016, 1016, 1015.9, 1015.5, 1012.3, 1009.5, 1009.6, 1010.2, 1013.1, 1016.9, 1018.2, 1016.7],
    }]
});

Highcharts.chart('dualChart1_2', {
    chart: {
        zoomType: 'xy' // 마우스로 차트 확대/축소 (x, y, xy)
    },
    navigation: false, // 차트 메뉴 버튼 유/무 (필수)
    credits: {
        enabled: false // 하단 하이차트 주소 숨김 (필수)
    },
    title: null,
    subtitle: null,
    xAxis: [{
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    }],
    yAxis: [{
        gridLineWidth: 0, // y축 그리드 선(가로선) 넓이 (기본값 1)
        title: {
            text: '왼쪽 y축 타이틀',
            style: {
                color: Highcharts.getOptions().colors[0] // highchart 기본 색상 배열
            }
        },
        labels: {
            format: '{value} mm',
            style: {
                color: Highcharts.getOptions().colors[0]
            }
        }
    }, {
        gridLineWidth: 0, // y축 그리드 선(가로선) 넓이 (왼쪽 y축과 동일하게 지정 필요) (기본값 1)
        title: {
            text: '오른쪽 y축 타이틀',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        },
        labels: {
            format: '{value} mb',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        },
        opposite: true // 축을 반대쪽에 표시할지 여부 (기본값 false)
    }],
    tooltip: {
        shared: true // series 각 툴팁을 한 개의 툴팁으로
    },
    plotOptions: {
        series: {
            borderRadius: 10,
            label: {
                enabled: false, // 차트영역에 나오는 series name 숨기기, 기본값 true
            },
        },
    },
    series: [{
        name: '데이터1 이름',
        type: 'column', // series 내에서 type 지정
        data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
    }, {
        name: '데이터2 이름',
        type: 'spline', // series 내에서 type 지정
        yAxis: 1, // 기준 y축 설정. 0이면 왼쪽, 1이면 오른쪽
        data: [1016, 1016, 1015.9, 1015.5, 1012.3, 1009.5, 1009.6, 1010.2, 1013.1, 1016.9, 1018.2, 1016.7],
        marker: {
            enabled: false // 포인트 마커 활성화 여부 (기본값 undefined)
        },
        dashStyle: 'shortdot' // 선 스타일
    }]
});

Highcharts.chart('dualChart2_1', {
    navigation: false, // 차트 메뉴 버튼 유/무 (필수)
    credits: {
        enabled: false // 하단 하이차트 주소 숨김 (필수)
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    xAxis: {
        categories: ['1월줄바꿈', '2월줄바꿈', '3월줄바꿈', '4월줄바꿈', '5월줄바꿈', '6월줄바꿈', '7월줄바꿈', '8월줄바꿈', '9월줄바꿈', '10월줄바꿈', '11월줄바꿈', '12월줄바꿈'],
    },
    yAxis: {
        title: {
            text: 'yAxis title'
        },
    },
    series: [{
        name: '방문자',
        data: [50, 82, 70, 100, 120, 80, 70, 82, 70, 100, 120, 80],
    }, {
        name: '페이지뷰',
        data: [40, 60, 90, 80, 100, 95, 40, 60, 90, 80, 100, 95],
    }]
});

Highcharts.chart('dualChart2_2', {
    chart: {
        backgroundColor: 'transparent',
        marginTop: 45,
        marginBottom: 65,
        marginRight: 0,
        marginLeft: 35
    },
    navigation: false, // 차트 메뉴 버튼 유/무 (필수)
    credits: {
        enabled: false // 하단 하이차트 주소 숨김 (필수)
    },
    title: null,
    subtitle: null,
    xAxis: {
        // category 안에서 줄바꿈 할때 <br>사용
        categories: ['1월<br>줄바꿈', '2월<br>줄바꿈', '3월<br>줄바꿈', '4월<br>줄바꿈', '5월<br>줄바꿈', '6월<br>줄바꿈', '7월<br>줄바꿈', '8월<br>줄바꿈', '9월<br>줄바꿈', '10월<br>줄바꿈', '11월<br>줄바꿈', '12월<br>줄바꿈'],
        lineColor: '#d0d0d0', // x축 가장 하단 line color 지정
        labels: { // x축 label 설정. yAxis 에도 동일한 옵션 사용
            style: {
                fontSize: '12px',
                color: '#393939',
                letterSpacing: -2
            }
        }
    },
    yAxis: {
        allowDecimals: false, // label에 소수점 사용여부, 기본값 true
        min: 0, // y축 최소값 (기본값 undefined)
        title: null,
        gridLineColor: '#d0d0d0', // y축 그리드 color 지정
        tickInterval: 50, // y축 값 간격
        labels: { // y축 label 설정. yAxis 에도 동일한 옵션 사용
            style: {
                fontSize: '11px',
                color: '#393939',
                letterSpacing: -2
            }
        }
    },
    legend: {
        align: 'right', // legend x축 기준 기본위치. left, center(기본값), right
        verticalAlign: 'top', // legend y축 기준 기본위치. top, middle, bottom(기본값)
        x: 15, // x축 기준 위치
        y: 0, // y축 기준 위치
        floating: true, // 공간을 차지하는 여부, 기본값 false (차지함)
        itemStyle: { // legend 아이템 스타일
            color: '#393939',
            fontSize: '12px',
            letterSpacing: -1
        }
    },
    tooltip: {
        shared: true, // series 각 툴팁을 한 개의 툴팁으로
        useHTML: true, // html 사용 여부
    },
    plotOptions: {
        series: {
            lineWidth: 1, // 라인차트일 경우 line width
            label: {
                enabled: false, // 차트영역에 나오는 series name 숨기기, 기본값 true
            },
        }
    },
    series: [{
        type: 'column',
        name: '방문자',
        data: [50, 82, 70, 100, 120, 80, 70, 82, 70, 100, 120, 80],
        color: '#72aae1', // series의 컬러값 지정방법 2번. 각 series 안에 컬러값 직접 지정
        borderColor: 'transparent'
    }, {
        type: 'line',
        name: '페이지뷰',
        data: [40, 60, 90, 80, 100, 95, 40, 60, 90, 80, 100, 95],
        color: '#e47720',
        marker: {
            lineWidth: 0,
            fillColor: '#e47720',
        }
    },]
});


// solidgauge
Highcharts.chart('solidgaugeChart1_1', {
    chart: {
        type: 'solidgauge',
        height: 200
    },
    navigation: false, // 차트 메뉴 버튼 유/무 (필수)
    credits: {
        enabled: false // 하단 하이차트 주소 숨김 (필수)
    },
    title: { // 없을 경우 -> title: undefined or null
        text: 'title'
    },
    subtitle: { // 없을 경우 -> subtitle: undefined or null
        text: 'subtitle'
    },
    series: [{
        name: '데이터1',
        data: [40]
    }]
});

Highcharts.chart('solidgaugeChart1_2', {
    chart: {
        type: 'solidgauge',
        height: 200,
        marginTop: 0,
        marginBottom: 0,
    },
    exporting: {
        enabled: false // 내보내기 활성화 여부 (기본값 true) (navigation: false와 비슷)
    },
    credits: {
        enabled: false // 하단 하이차트 주소 숨김
    },
    title: null,
    subtitle: null,
    pane: {
        startAngle: -90, // 시작 각도 위치 (기본값 0)
        endAngle: 90, // 끝 각도 위치 (기본값 0)
        background: {
            backgroundColor: '#eee',
            innerRadius: '60%', // 원 내부 반경 (가운데 구멍 크기) (기본값 0)
            outerRadius: '100%', // 원 외부 반경 (기본값 105%)
            shape: 'arc' // 반원 모양으로 변경
        },
        center: ['50%', '85%'], // 상하 좌우 기준 위치
        size: '160%' // 차트 사이즈
    },
    tooltip: {
        enabled: false // 툴팁 활성화 여부 (기본값 true)
    },
    yAxis: {
        min: 0, // 축 최소값 (기본값 undefined)
        max: 100, // 축 최대값 (기본값 undefined)
        stops: [ // 게이지 값 별 색상(그라디언트 형식) 정의 (solidgauge만 해당)
            [0.1, '#e14159'],
            [0.3, '#f99d42'],
            [0.5, '#facf4c'],
            [0.7, '#83ab47'],
            [0.9, '#5587a2']
        ],
        lineWidth: 0, // 선 너비 (기본값 1)
        tickWidth: 0, // 눈금 표시 픽셀 너비 (기본값 undefined)
        tickAmount: 2, // 눈금 개수 (기본값 undefined)
        minorTickInterval: undefined, // 눈금 사이 보조 눈금 간격 (기본값 undefined)
        labels: { // 게이지 시작과 끝에 표시되는 최소값, 최대값 label 설정
            y: 20,
            style: {
                fontSize: '14px'
            }
        }
    },
    plotOptions: {
        solidgauge: {
            dataLabels: { // data label  설정 (solidgauge 차트에서는 기본값 true)
                y: -40,
                borderWidth: 0, // 기본값 1
                useHTML: true, // html 사용 여부
                format: '<span style="font-size: 28px;">{y}</span>'
            },
        }
    },
    series: [{
        name: '데이터1',
        data: [40]
    }]
});