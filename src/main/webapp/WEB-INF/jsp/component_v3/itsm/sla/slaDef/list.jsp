<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">

	$(function() {
		tab();
		//searchBgnDe, searchEndDe
		$("#searchBgnDe").datepicker({
			buttonImage: "/component/itsm/images/sub/icon_calendar.png",
			buttonImageOnly: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			dateFormat: "yy.mm",
			onClose: function(dateText, inst) {
				var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
				var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
				$(this).datepicker('setDate', new Date(year, month, 1));
				fncPageBoard('addList', 'addList.do', $("#pageIndex").val());
			},
			beforeShow : function(input, inst) {
				if ((datestr = $(this).val()).length > 0) {
					actDate = datestr.split('.');
					year = actDate[0];
					month = actDate[1]-1;
					$(this).datepicker('option', 'defaultDate', new Date(year, month));
					$(this).datepicker('setDate', new Date(year, month));
				}
			}
		}).datepicker('setDate', '0');

		if('${searchVO.searchbgngYm}' && '${searchVO.svcSn}'){
			$("#tab_li01").removeClass()
			$("#tab_li02").addClass("current")
			$("#tab01").css("display", "none")
			$("#tab02").css("display", "block")
			fncPage('slaMngList.do','tab02');
		}

	});

	var upChk = "N";

	jQuery(document).on('click', '.code_rewrite', function() {

		if (upChk == "Y") {
			alert("수정중인 정보를 완료해 주세요.");
			return false;
		} else {

			$(this).parents('tr').find('.code_basic').hide();
			$(this).parents('tr').find('.code_correct').show();

			//searchBgnDe, searchEndDe
			$("[id^='useBgnYm_']").datepicker({
				buttonImage: "/component/itsm/images/sub/icon_calendar.png",
				buttonImageOnly: true,
				changeMonth: true,
				changeYear: true,
				showButtonPanel: true,
				dateFormat: "yy.mm",
				onClose: function(dateText, inst) {
					var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
					var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
					$(this).datepicker('setDate', new Date(year, month, 1));
				},
				beforeShow : function(input, inst) {
					if ((datestr = $(this).val()).length > 0) {
						actDate = datestr.split('.');
						year = actDate[0];
						month = actDate[1]-1;
						$(this).datepicker('option', 'defaultDate', new Date(year, month));
						$(this).datepicker('setDate', new Date(year, month));
					}
				}
			}).datepicker('setDate', '0');

			upChk = "Y";
		}

	});

	jQuery(document).on('click', '.code_cancel', function() {

		$(this).parents("tr").find('.code_correct').hide();
		$(this).parents("tr").find('.code_basic').show();
		upChk = "N";

	});

	<%-- 등록 ,수정, 삭제 처리  --%>
	var formAction = function(type) {
		$.ajax({
			method: "POST",
			url: type + "Proc.do",
			data : $("#defaultFrm").serialize(),
			dataType: "json",
			success: function(data) {
				var callType= data.type;
				alert(callType + "되었습니다.");
				upChk = "N";
				fncPageBoard('addList', 'addList.do', $("#pageIndex").val());
			}
		});
	}

	<%-- 탭이동 --%>
	function fncPage(url, id){
		fncAjax(url, {searchbgngYm : '${searchVO.searchbgngYm}', svcSn : '${searchVO.svcSn}'}, 'html', true, '', function(data){
			$("#"+id).html(data);
		});
	}

</script>

<div class="tbl_top">
	<div class="tbl_left"><h4 class="md_tit">지표관리</h4></div>
	<div class="tbl_right"></div>
</div>

<!-- 탭메뉴 -->
<ul class="js-tab tab_menu">
	<li id="tab_li01" class="current"><a href="#tab01">SLA 지표</a></li>
	<li id="tab_li02"><a href="#tab02" onclick="fncPage('slaMngList.do','tab02');">항목별 배점 및 측정방법</a></li>
	<li id="tab_li03"><a href="#tab03">배점별 등급구간</a></li>
	<li id="tab_li04"><a href="#tab04">장애발생 영향도 가중치</a></li>
	<li id="tab_li05"><a href="#tab05">인력유지율 가중치</a></li>
</ul>
<!-- 탭 1 -->
<div id="tab01" class="tab_content js-tab-content">
	<div class="tbl_wrap">
		<table class="tbl_col_type02">
			<colgroup>
				<col style="width:10%;">
				<col style="width:20%;">
				<col style="width:35%;">
				<col>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">항목</th>
				<th scope="col">세부지표</th>
				<th scope="col">세부 지표 정의</th>
				<th scope="col">측정방법</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<th scope="row" rowspan="5">적시성</th>
				<td rowspan="2">서비스 요구 납기 준수율</td>
				<td rowspan="2">요구 서비스의 납기 내 완료 정도</td>
				<td>(납기 내 완료 건수/전체요구서비스건수)×100</td>
			</tr>
			<tr>
				<td>납기 내 완료요청일은 상호 협의된 일정된 일정</td>
			</tr>
			<tr>
				<td>서비스 요구 처리율</td>
				<td>월 단위 요청한 서비스의 처리정도</td>
				<td>(월 처리완료건수/월 전체 요구 서비스건수)×100</td>
			</tr>
			<tr>
				<td>서비스 장애 적기 해결율</td>
				<td>서비스 장애 발생 시 적기 내 관련 장애를 해소</td>
				<td>(1시간 이내 장애처리건수/월 단위 장애발생건수)×100</td>
			</tr>
			<tr>
				<td>긴급 서비스요구 처리율</td>
				<td>긴급으로 요청한 서비스 요구사항에 대한 적정 처리율</td>
				<td>(납기 내 완료건수/긴급 요청건수)×100</td>
			</tr>
			<tr>
				<th scope="row" rowspan="6">품질</th>
				<td>SW 응답속도</td>
				<td>소프트웨어의 3초 이내 응답여부</td>
				<td>(운영 시스템 내에서 테스트 시 3초 이내 응답건수/개발 및 시스템 개선 건수)</td>
			</tr>
			<tr>
				<td>신규개발 후 해당 SW 장애율</td>
				<td>신규개발 프로그램의 SW 장애 발생율</td>
				<td>(장애건수/개발 및 시스템 개선 건수)×100</td>
			</tr>
			<tr>
				<td>동일 장애 발생율</td>
				<td>기존에 발생한 장애 중 2회 이상 발생한 장애 건수</td>
				<td>(이전 장애유형 중 동일 장애발생건수/월 전체장애발생건수)×100</td>
			</tr>
			<tr>
				<td>프로그램 장애 및 오류발생 건수</td>
				<td>응용 프로그램에 의하여 장애 및 오류가 발생한 건수</td>
				<td>발생 건수</td>
			</tr>
			<tr>
				<td>변경 서비스 적용 후 장애율</td>
				<td>기존 개발 기능이 개선, 변경 후 장애가 발생한 건수</td>
				<td>(변경 건수 중 장애발생건수/기존 기능 변경 건수)×100</td>
			</tr>
			<tr>
				<td>시스템 개선 제안 건수</td>
				<td>운영 유지보수 업체에서 자발적으로 제안하여 개선한 건수</td>
				<td>제안 건수</td>
			</tr>
			<tr>
				<th scope="row">인력</th>
				<td>인력 유지율</td>
				<td>투입인력의 교체없이 유지되는 정도</td>
				<td>(현 투입인력/전월 투입인력)×100</td>
			</tr>
			<tr>
				<th scope="row">만족도</th>
				<td>현업 담당자 만족도</td>
				<td>문의응대, 유지보수 처리 만족도</td>
				<td>현업 담당자 만족도 점수</td>
			</tr>
			<tr>
				<th scope="row" rowspan="3">보안</th>
				<td>웹취약점 점검시 발생건수</td>
				<td>웹취약점 점검 시 발생건수</td>
				<td>월간 발생건수</td>
			</tr>
			<tr>
				<td>보안 관련사고 발생건수</td>
				<td>보안 관련 정부 유·누·노출 및 사고건수</td>
				<td>월간 발생건수</td>
			</tr>
			<tr>
				<td>보안위반 횟수</td>
				<td>국정원, 농식품부, 자체감사시 보안 적발건수</td>
				<td>국정원, 농식품부, IT지원팀 및 사업담당자 점검 시 보안위반 횟수</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>
<!-- 탭 2 -->
<div id="tab02" class="tab_content js-tab-content">

</div>
<!-- 탭 3 -->
<div id="tab03" class="tab_content js-tab-content">
	<div class="tbl_wrap">
		<table class="tbl_col_type02">
			<colgroup>
				<col>
				<col style="width:16%;">
				<col style="width:16%;">
				<col style="width:16%;">
				<col style="width:16%;">
				<col style="width:16%;">
			</colgroup>
			<thead>
			<tr>
				<th scope="col" rowspan="2"></th>
				<th scope="col">A</th>
				<th scope="col">B</th>
				<th scope="col">C</th>
				<th scope="col">D</th>
				<th scope="col">F</th>
			</tr>
			<tr>
				<th scope="col">우수</th>
				<th scope="col">양호</th>
				<th scope="col">보통</th>
				<th scope="col">미흡</th>
				<th scope="col">매우 미흡</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<th scope="row">상향 지표</th>
				<td>90~100%</td>
				<td>80~89%</td>
				<td>70~79%</td>
				<td>60~69%</td>
				<td>60% 미만</td>
			</tr>
			<tr>
				<th scope="row">하향 지표 보정치</th>
				<td>측정결과 0~5%구간 항목배점×1.0</td>
				<td>측정결과 6~10%구간 항목배점×0.8</td>
				<td>측정결과 11~20%구간 항목배점×0.7</td>
				<td>측정결과 21~30%구간 항목배점×0.6</td>
				<td>측정결과 31%~구간 항목배점×0.5</td>
			</tr>
			<tr>
				<th scope="col" colspan="6">별도 지표 보정치</th>
			</tr>
			<tr>
				<th scope="row">프로그램 장애 및 오류발생 건수</th>
				<td>측정결과 0~2회 구간 항목배점×1.0</td>
				<td>측정결과 3~5회 구간 항목배점×0.8</td>
				<td>측정결과 6~8회 구간 항목배점×0.7</td>
				<td>측정결과 9~11회 구간 항목배점×0.6</td>
				<td>측정결과 12회 이상구간 항목배점×0.5</td>
			</tr>
			<tr>
				<th scope="row">시스템 제안 건수</th>
				<td>측정결과 5건 이상구간 항목배점×1.0</td>
				<td>측정결과 3~4건 구간 항목배점×0.8</td>
				<td>측정결과 2건 구간 항목배점×0.7</td>
				<td>측정결과 1건 구간 항목배점×0.6</td>
				<td>측정결과 0건시 0점 처리</td>
			</tr>
			<tr>
				<th scope="row">보안 관련사고 발생건수</th>
				<td>측정결과 0건 구간 항목배점×1.0</td>
				<td>측정결과 0건 구간 항목배점×1.0</td>
				<td>측정결과 0건 구간 항목배점×1.0</td>
				<td>측정결과 1건 구간 항목배점×0.5</td>
				<td>측정결과 2건 이상구간 항목배점×0.2</td>
			</tr>
			<tr>
				<th scope="row">보안 위반횟수/외부 웹취약점 발생건수</th>
				<td>측정결과 0건 구간 항목배점×1.0</td>
				<td>측정결과 1건 구간 항목배점×0.8</td>
				<td>측정결과 2~3건 구간 항목배점×0.7</td>
				<td>측정결과 4~5건 구간 항목배점×0.6</td>
				<td>측정결과 6건 이상구간 항목배점×0.5</td>
			</tr>
			<tr class="point">
				<th scope="col">월 단위 측정 100점 환산 종합평가 시 패널티 적용</th>
				<th scope="col" colspan="2">80점 이상 패널티 없음</th>
				<th scope="col">70~79점 월 지급금액의 5% 차감</th>
				<th scope="col">60~69점 월 지급금액의 10% 차감</th>
				<th scope="col">59점 이하 월 지급금액의 15% 차감</th>
			</tr>
			</tbody>
		</table>
	</div>
	<ul class="tbl_txt">
		<li>상향지표에 해당되는 지표는 지표별 배점×측정방법에서 나온 점수<br>&nbsp;&nbsp;&nbsp;예) 서비스요구납기준수율 : 5점 × 0.875점 = 4.375점</li>
		<li>하향지표에 해당되는 지표는 지표별 배점×하향지표 보정치 적용<br>&nbsp;&nbsp;&nbsp;예) 동일장애발생율이 월 전체 6건 장애 중 1건 발생 시 : 8점 × 0.7점(보정지표) = 5.6점</li>
		<li>별도지표에 해당되는 지표는 지표별 배점×별도지표 보정치 적용<br>&nbsp;&nbsp;&nbsp;예) 보안 위반횟수가 월 1회일 경우 : 5점 × 0.8점(보정지표) = 4점</li>
		<li><strong>월 단위 전체 측정점수가 C등급 2회, D.F등급 1회 이상일 경우에는 누적된 시점에 사업수행 부실로 계약해지 처리</strong><br>&nbsp;&nbsp;&nbsp;예) 6월에 1월 C등급, 3월 C등급인 경우 3월 기준으로 계약해지
			<br>- 신규 사업자 선정 시점과 인수인계 완료 시점까지는 기존 사업자가 수행
			<br>- <strong>보안 관련 사고의 경우 사회적으로 물의를 일으키거나 심각한 경우 등급에 관계없이 계약해지 및 추가 조치 이행</strong>
		</li>
		<li><strong>전년도 운영.유지보수 평균 점수(12개월 평균)가 85점 미만</strong>일 경우 <strong>2차 또는 3차 년도 사업 시작 시점에 계약 해지 처리</strong></li>
	</ul>
</div>
<!-- 탭 4 -->
<div id="tab04" class="tab_content js-tab-content">
	<div class="tbl_wrap">
		<table class="tbl_col_type02">
			<colgroup>
				<col style="width:20%;">
				<col>
				<col>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">장애등급</th>
				<th scope="col">등급기준</th>
				<th scope="col">가중치</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>상</td>
				<td>
					<ul>
						<li>- 웹사이트 접속 중단</li>
						<li>- 웹사이트 메인페이지 주요콘텐츠 노출 결함</li>
						<li>- 주요기능의 심각한 오류 (회원가입, 로그인, 게시물 읽기 등)</li>
						<li>- 데이터 무결성 오류</li>
					</ul>
				</td>
				<td>측정점수×0.8</td>
			</tr>
			<tr>
				<td>중</td>
				<td>
					<ul>
						<li>- 메인을 제외한 웹페이지의 중대하지 않은 결함</li>
						<li>- 장애등급 '상','하' 제외한 오류</li>
					</ul>
				</td>
				<td>측정점수×0.9</td>
			</tr>
			<tr>
				<td>하</td>
				<td>단순 경미한 오류</td>
				<td>측정점수×1</td>
			</tr>
			</tbody>
		</table>
	</div>
	<ul class="tbl_txt">
		<li>재해로 발생한 시스템 장애는 제외</li>
		<li>장애는 보고서로 제출 후 H/W, 패키지 S/W, N/W 장애영역에 대한 판단은 발주기관에서 판정 후 예외처리</li>
		<li>응용 프로그램 오류는 응용프로그램, DB 패키지 포함</li>
		<li>측정 지표 중 품질항목의 신규개발 후 해당SW장애율, 동일 장애 발생율, 프로그램 장애 및 오류발생 건수, 변경 서비스 적용 후 장애율 지표가 해당</li>
	</ul>
</div>
<!-- 탭 5 -->
<div id="tab05" class="tab_content js-tab-content">
	<div class="tbl_wrap">
		<table class="tbl_col_type02">
			<colgroup>
				<col style="width:50%;">
				<col>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">투입구분</th>
				<th scope="col">가중치</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>PM</td>
				<td>교체인력수 × 3</td>
			</tr>
			<tr>
				<td>응용SW개발-리더</td>
				<td>교체인력수 × 2</td>
			</tr>
			<tr>
				<td>응용SW개발-일반</td>
				<td>교체인력수 × 1.5</td>
			</tr>
			<tr>
				<td>고객지원</td>
				<td>교체인력수 × 1</td>
			</tr>
			</tbody>
		</table>
	</div>
	<ul class="tbl_txt">
		<li>상위 기술자가 교체될수록 용역사업에 미치는 영향도가 많이 발생되므로, 등급이 높을수록 高패널티를 부여</li>
		<li>예를 들어, 총사업 투입인력 10명 중 개발-리더 1명, 개발-일반 1명의 인력 교체시 인력유지율은 <strong>80%이나, 가중치 적용시 65%임</strong></li>
	</ul>
</div>

</section>
<!--// content -->