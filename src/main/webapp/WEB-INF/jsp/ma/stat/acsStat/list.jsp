<%--@elvariable id="searchVO" type="com.opennote.standard.ma.cmmn.domain.CmmnDefaultVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/highcharts.js"></script>
<script type="text/javascript">
const colorArr = ["#79A5E9","#378846","#5ca8b4","#f78b24","#2c9673","#893a8d","#9ed1e1","#16a8c0","#5f338d","#c83c6d"];
const columnColorArr = ["#9FD4DD","#16A8C0","#C9E79B","#84B932","#2c9673","#378846","#f78b24","#893a8d","#5f338d","#c83c6d"];
const today = new Date(); // 현재날짜
const yyyy = today.getFullYear();
const mm = String(today.getMonth() + 1).padStart(2, '0');
const dd = String(today.getDate()).padStart(2, '0');
$(document).ready(function(){
	// 메뉴별 접속수(Top5) 차트
	fncAjax('getAcsStat', {procType : 'chart1'}, 'json', true, '', callBack1);
	// 메뉴별 접속수(현재날짜) 차트
	fncAjax('getAcsStat', {procType : 'chart2'}, 'json', true, '', callBack2);
	// 시간별 접속수(현재날짜) 차트
	fncAjax('getAcsStat', {procType : 'chart3'}, 'json', true, '', callBack3);
	// 메뉴별 에러 건수
	fncAjax('getAcsStat', {procType : 'chart4'}, 'json', true, '', callBack4);
	// 월별 가입추이(현재년도) 차트
	fncAjax('getAcsStat', {procType : 'chart5'}, 'json', true, '', callBack5);
	// 월별 탈퇴추이(현재년도) 차트
	fncAjax('getAcsStat', {procType : 'chart6'}, 'json', true, '', callBack6);

});

// 차트 함수
const chart = function (chartId, type, title, yTitle, category, series) {
	Highcharts.chart(chartId, {
		chart: {
			type: type,
			height: '400' // 차트 높이 지정
		},
		navigation: false, // 차트 메뉴 버튼 유/무
		credits: {
			enabled: false // 하단 하이차트 주소 숨김
		},
		title: { // 없을 경우 → title: undefined or null
			text: title
		},
		subtitle: { // 없을 경우 → subtitle: undefined or null
			text: null
		},
		xAxis: {
			categories: category,
		},
		yAxis: {
			min: 0,
			title: {
				text: yTitle
			},
		},
		plotOptions: {
			column: {
				pointPadding: 0.2,
				borderWidth: 0
			},series: {
				dataLabels:{
					enabled:true
				}
			},pie: {
				allowPointSelect: true,
				cursor: 'pointer',
				dataLabels: {
					enabled: true,
					format: '<b>{point.name}</b>: {point.percentage:.1f} %'
				}
			}
		},
		series: [{
			name: yTitle,
			data: series,
			events:{
				click: function (event){ // 차트 클릭이벤트
					const idx = parseInt(event.point.index);
					if (chartId == 'chart1') {
						fncAjax('getAcsStat', {
							menuCd: series[idx].menuCd,
							schEtc00: category[idx],
							procType: 'chart1Dtls'
						}, 'json', true, '', callBack1);
					}
					if (chartId == 'chart2') {
						fncAjax('getAcsStat', {
							menuCd: category[idx],
							schEtc00: series[idx].name,
							procType: 'chart2Dtls'
						}, 'json', true, '', callBack2);
					}
					if (chartId == 'chart4') {
						if (category[idx]) {
							fncAjax('getAcsStat', {
								menuCd: category[idx],
								schEtc00: series[idx].name,
								procType: 'chart4Dtls'
							}, 'json', true, '', callBack4);
						} else {
							location.href = '/ma/sys/log/errlog/list.do';
						}
					}
					if (chartId == 'chart5') {
						if (category[idx].indexOf('월') > -1) {
							fncAjax('getAcsStat', {
								schEtc00: category[idx].replace(' 월', ''),
								procType: 'chart5Dtls'
							}, 'json', true, '', callBack5);
						} else {
							fncAjax('userList.do', {
								schEtc00: yyyy + '.' + title.substr(0,2) + '.' + category[idx].replace(' 일', ''),
								procType: 'scrb'
							}, 'html', true, '', function (data) {
								$("#display_view1").html(data);
								view_show(1);
							});
						}
					}
					if (chartId == 'chart6') {
						if (category[idx].indexOf('월') > -1) {
							fncAjax('getAcsStat', {
								schEtc00: category[idx].replace(' 월', ''),
								procType: 'chart6Dtls'
							}, 'json', true, '', callBack6);
						} else {
							fncAjax('userList.do', {
								schEtc00: yyyy + '.' + title.substr(0,2) + '.' + category[idx].replace(' 일', ''),
								procType: 'scss'
							}, 'html', true, '', function (data) {
								$("#display_view1").html(data);
								view_show(1);
							});
						}
					}
				}
			}
		}]
	});
};

// 메뉴별 접속수(Top5) 차트 콜백함수
const callBack1 = function (data) {
	if (data.resultList && data.resultList.length > 0) {
		let category = [];
		let series = [];
		let titleDtls = (data.props ? ' - ' + data.props : '');
		for (let i = 0; i < data.resultList.length; i++) {
			let obj = {};
				obj.menuCd = data.resultList[i].menuCd;
				obj.y = Number(data.resultList[i].cnt);
				obj.color = columnColorArr[i];

			category.push(data.resultList[i].menuNm);
			series.push(obj);
		}
		chart('chart1', 'column', '메뉴별 접속수(Top5)' + titleDtls, '접속수', category, series);
	}

};
// 메뉴별 접속수(현재날짜) 차트 콜백함수
const callBack2 = function (data) {
	let category = [];
	let series = [];
	let titleDtls = "";
	if (data.resultList && data.resultList.length > 0) {
		titleDtls = (data.props ? ' - ' + data.props : '');
		for (let i = 0; i < data.resultList.length; i++) {
			let obj = {};
				obj.name = data.resultList[i].menuNm;
				obj.y = Number(data.resultList[i].cnt);
				obj.color = colorArr[i];

			category.push(data.resultList[i].menuCd);
			series.push(obj);
		}
		chart('chart2', 'pie', '메뉴별 접속수(' + yyyy + '.' + mm + '.' + dd + ')' + titleDtls, '접속수', category, series);
	}
	if (!data.props) {
		chart('chart2', 'pie', '메뉴별 접속수(' + yyyy + '.' + mm + '.' + dd + ')' + titleDtls, '접속수', category, series);
	}
}
// 시간별 접속수(현재날짜) 차트 콜백함수
const callBack3 = function (data) {
	let category = [];
	let series = [];
	if (data.resultList && data.resultList.length > 0) {
		for (let i = 0; i < data.resultList.length; i++) {
			category.push(data.resultList[i].regDt);
			series.push(Number(data.resultList[i].cnt));
		}
	}
	chart('chart3', 'spline', '시간별 접속수(' + yyyy + '.' + mm + '.' + dd + ')', '접속수', category, series);
}
// 메뉴별 접속수(현재날짜) 차트 콜백함수
const callBack4 = function (data) {
	let category = [];
	let series = [];
	let titleDtls = '메뉴별 에러 건수';
	if (data.resultList && data.resultList.length > 0) {
		if (data.props) {
			titleDtls = data.props + ' 에러 건수';
		}
		for (let i = 0; i < data.resultList.length; i++) {
			let obj = {};
				obj.name = data.resultList[i].menuNm;
				obj.y = Number(data.resultList[i].cnt);
				obj.color = colorArr[i];

			category.push(data.resultList[i].menuCgNm);
			series.push(obj);
		}
		chart('chart4', 'pie', titleDtls, '건수', category, series);
	}
	if (!data.props) {
		chart('chart4', 'pie', titleDtls, '건수', category, series);
	}
}
// 월별 가입추이(현재년도) 차트 콜백함수
const callBack5 = function (data) {
	let category = [];
	let series = [];
	let title = '월별 가입추이(' + yyyy + ')';
	if (data.resultList && data.resultList.length > 0) {
		if (!data.props) {
			let mon = monArr();
			for (let i = 0; i < mon.length; i++) {
				category.push(mon[i] + ' 월');
				let obj = {};
					obj.y = 0;
					obj.color = columnColorArr[i];

				for (let j = 0; j < data.resultList.length; j++) {
					if (mon[i] == data.resultList[j].regDt) {
						obj.y = Number(data.resultList[i].cnt);
					}
				}
				series.push(obj);
			}
		} else {
			title = data.props + '월 일별 가입추이'
			for (let j = 0; j < data.resultList.length; j++) {
				category.push(data.resultList[j].regDt + ' 일');
				let obj = {};
					obj.y = Number(data.resultList[j].cnt);
					obj.color = columnColorArr[j];
				series.push(obj);
			}
		}
	}
	chart('chart5', 'column', title, '가입자수', category, series);
}
// 월별 탈퇴추이(현재년도) 차트
const callBack6 = function (data) {
	let category = [];
	let series = [];
	let title = '월별 탈퇴추이(' + yyyy + ')';
	if (data.resultList && data.resultList.length > 0) {
		if (!data.props) {
			let mon = monArr();
			for (let i = 0; i < mon.length; i++) {
				category.push(mon[i] + ' 월');
				let obj = {};
					obj.y = 0;
					obj.color = columnColorArr[i];

				for (let j = 0; j < data.resultList.length; j++) {
					if (mon[i] == data.resultList[j].regDt) {
						obj.y = Number(data.resultList[i].cnt);
					}
				}
				series.push(obj);
			}
		} else {
			title = data.props + '월 일별 탈퇴추이'
			for (let j = 0; j < data.resultList.length; j++) {
				category.push(data.resultList[j].regDt + ' 일');
				let obj = {};
					obj.y = Number(data.resultList[j].cnt);
					obj.color = columnColorArr[j];
				series.push(obj);
			}
		}
	}
	chart('chart6', 'column', title, '탈퇴자수', category, series);
}

// 현재 월까지 배열 ex) ['01','02','03']
const monArr = function () {
	let nowMon = today.getMonth() + 1;
	let result = [];
	for (let i = 1; i <= nowMon; i++) {
		result.push(String(i).padStart(2, '0'));
	}
	return result;
}
</script>
<div class="board_top">
	<div class="sidebyside">
		<div id="chart1" class="w33p"></div>
		<div id="chart2" class="w33p"></div>
		<div id="chart3" class="w33p"></div>
	</div>
	<div class="sidebyside">
		<div id="chart4" class="w33p"></div>
		<div id="chart5" class="w33p"></div>
		<div id="chart6" class="w33p"></div>
	</div>
</div>

<!-- popup -->
<div id="display_view1" class="layer_pop js_popup w1000px"></div>
<div class="popup_bg" id="js_popup_bg"></div>
<!-- //popup -->