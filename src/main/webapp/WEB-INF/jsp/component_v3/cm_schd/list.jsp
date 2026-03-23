<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 로컬스토리지에 저장된 탭 유형 가져오기 --%>
let schdType = localStorage.getItem('schdType');

<%-- 탭별 검색조건 영역 세팅 --%>
const cm_fncSetSearchBox = function(schdType){
	$('[class^="searchBox_"]').hide();
	$('.searchBox_' + schdType).show();
}
<%-- 탭영역 addList --%>
const cm_fncAddList = function(){
	<%-- 탭 유형 세팅 --%>
	schdType = localStorage.getItem('schdType');
	if(!schdType){
		schdType = 'schBasic';
	}

	<%-- 탭영역 addList 호출 --%>
	$('.sch_type > li').each(function(){
		
		let schUrl = $(this).data('url');
		let schType = $(this).attr('id');
			
		if(schType === 'schList'){
			$('.searchBox_schList input, .searchBox_schList select').prop('disabled', false);
		} else{
			$('.searchBox_schList input, .searchBox_schList select').prop('disabled', true);
		}

		$.ajax({
			 url : schUrl
		  	,type : 'post'
		   	,data : $("#defaultFrm").serialize()
		   	,dataType : "html"
		   	,success : function (data) {
		   		$('[data-tab="' + schType + '"]').html(data);
			}
			,error : function (xhr, status, error) {
			
				if (xhr.status == 401) {
			  		window.location.reload();
				}
				
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
				
		    }
		});
	});
	
	<%-- 일정 클릭시 수정폼 --%>
	$(document).off().on('click', '.tab_cont_01 .sch_tbl .sch_txt, .tab_cont_02 .sch_list div.sch_detail, .tab_cont_03 .board_list tbody tr:not(:has(td.no_data))', function(){
		cm_fncPopForm($(this).data('serno') ,'update');
	});

	<%-- 탭별 검색조건 영역 세팅 --%>
	cm_fncSetSearchBox(schdType);
	
	$('.sch_type > li#' + schdType + ' > a').trigger('click');
}
<%-- 달력형, 축약형 : 월 변경 --%>
const cm_fncChangeMonth = function(selMonth){
	<%-- 선택월 세팅 --%>
	$('.sch_mon > li').removeClass('on');
	$('.sch_mon > li#sch_mon_li_' + selMonth).addClass('on');
	$('#schEtc02').val(selMonth);
	
	<%-- 탭영역 addList --%>
	cm_fncAddList();
}

<%-- 달력형, 축약형 : 연도 변경 --%>
const cm_fncChangeYear = function(type){
	<%-- 선택 연도 세팅 --%>
	let changeYear = 0;
	if (type === "prev") {
		changeYear = parseInt($("#currentYear").text()) - 1;
	} else if (type === "next") {
		changeYear = parseInt($("#currentYear").text()) + 1;
	}
	
	$("#currentYear").text(changeYear);
	$('#schEtc01').val(changeYear);
	
	<%-- 탭영역 addList --%>
	cm_fncAddList();
}

<%-- 축약형 : 날짜 변경 --%>
const cm_fncChangeDate = function(){
    let tab = $('.sch_sm td a.on').data('id');
    $('#schEtc00').val(tab.split('_')[1]);
	$('.sch_list').not(tab).css('display', 'none');
	$(tab).fadeIn();
}

<%-- 공휴일 연도 selectBox 세팅 --%>
const cm_fncSetHdayYear = function(){
	
	let html = '';
	let firstYear = 2004;
	let thisYear = new Date().getFullYear();
	
	for (let i = thisYear; i >= firstYear; i--) {
		if(i === thisYear){
			html += '<option value="' + i + '" label="' + i + '년" selected/>';
		} else {
			html += '<option value="' + i + '" label="' + i + '년"/>';
		}
	}
	
	$('#selYear').html(html);
}

<%-- 등록,수정 팝업 --%>
const cm_fncPopForm = function(serno, procType){
	$('#schdSerno').val(serno);
	
	$.ajax({
		 url : procType + 'PopForm.do'
	  	,type : 'post'
	   	,data : $("#defaultFrm").serialize()
	   	,dataType : "html"
	   	,success : function (data) {
			$('#display_view1').html(data);
			space();
			view_show(1);
		}
		,error : function (xhr, status, error) {
		
			if (xhr.status == 401) {
		  		window.location.reload();
			}
			
			let errors = xhr.responseJSON;
			alert(errors[0].defaultMessage);
			
	    }
	    ,beforeSend : function(){
			fncLoadingStart();
		}
	    ,complete 	: function(){
	    	fncLoadingEnd();
	    	
	    	<%-- 축약형인 경우, 선택된 날짜 세팅 --%>
	    	if($('.tab_cont_02').hasClass('on')){
	   			$('#schdStrtYmd, #schdEndYmd').val('<c:out value="${searchVO.schEtc01}"/>.<c:out value="${searchVO.schEtc02}"/>.' + $('#schEtc00').val());
	   		}
	    	
			return false;
		}
	});	
}
const cm_fncSaveHday = function(){
	$.ajax({
		 url : 'hdayInsertProc'
	  	,type : 'post'
	   	,data : {'selYear' : $('#selYear').val()}
	   	,dataType : "json"
	   	,success : function (data) {
			alert(data.holidayMessage + '\n' + data.anniversaryMessage);
		}
		,error : function (xhr, status, error) {
		
			if (xhr.status == 401) {
		  		window.location.reload();
			}
			
			let errors = xhr.responseJSON;
			alert(errors[0].defaultMessage);
			
	    }
	    ,beforeSend : function(){
			fncLoadingStart();
		}
	    ,complete 	: function(){
	    	fncLoadingEnd();
			return false;
		}
	});	
}
$(document).ready(function(){
	
	<%-- 탭영역 addList --%>
	cm_fncAddList();
	
	<%-- 탭 클릭시 --%>
	$('.sch_type > li > a').on('click', function(){
		<%-- 탭 유형 로컬스토리지 저장 --%>
		localStorage.setItem('schdType', $(this).parent().attr('id'));
		<%-- 탭별 검색조건 세팅 --%>
		cm_fncSetSearchBox($(this).parent().attr('id'));
	});
	
	<%-- 업무구분 영역 클릭시 --%>
	$('.sch_legend > span > input:checkbox').on('click', function(){
		cm_fncAddList();
	});
	
	<%-- 달력형, 축약형 : 월 변경 --%>
	$("li[id^=sch_mon_li_]").on("click", function () {
		cm_fncChangeMonth($(this).attr("id").replace("sch_mon_li_", ""));
	});
	
	<%-- 달력형, 축약형 : 연도 변경 --%>
	$("span[class$=_y]").on("click", function () {
		cm_fncChangeYear($(this).attr("class").replace("_y", ""));
	});
	<%-- 목록형인경우 검색날짜 세팅 --%>
	fncDate("searchStartDate", "searchEndDate");
	
	<%-- 일정등록 클릭시 --%>
	$('.btn_write').on('click', function(){
		cm_fncPopForm('', 'insert');
	});
	
	<%-- 공휴일 연도 selectBox 세팅 --%>
	cm_fncSetHdayYear();
	
	<%-- 공휴일 수동저장 클릭시 --%>
	$('#btn_hday_save').on('click', function(){
		cm_fncSaveHday();
	});
});

</script>
<div class="scheduler_wrap tab">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<%-- 선택 날짜 --%>
		<form:hidden path="schEtc00"/>
		<%-- 선택 연도 --%>
		<form:hidden path="schEtc01"/>
		<%-- 선택 월 --%>
		<form:hidden path="schEtc02"/>
		<%-- 오늘날짜 --%>
		<form:hidden path="schEtc03"/>
		<input type="hidden" id="schdSerno" name="schdSerno"/> 
	    <div class="sch_top">
	        <div class="sch_year">
	            <span class="prev_y"></span>
	            <span id="currentYear"><c:out value="${searchVO.schEtc01 }"/></span>
	            <span class="next_y"></span>
	        </div>
	        <div class="right">
	            <span class="chk sch_legend">
	                <span class="personal_work"><form:checkbox path="schEtc04" id="schEtc04" value="personal_work" checked="checked"/><label for="schEtc04">개인업무</label></span>
	                <span class="department_work"><form:checkbox path="schEtc05" id="schEtc05" value="department_work" checked="checked"/><label for="schEtc05">부서업무</label></span>
	                <span class="company_work"><form:checkbox path="schEtc06" id="schEtc06" value="company_work" checked="checked"/><label for="schEtc06">회사업무</label></span>
	                <span class="meeting"><form:checkbox path="schEtc07" id="schEtc07" value="meeting" checked="checked"/><label for="schEtc07">회의</label></span>
	                <span class="director_work"><form:checkbox path="schEtc08" id="schEtc08" value="director_work" checked="checked"/><label for="schEtc08">경영진일정</label></span>
	            </span>
	            <ul class="sch_type js_tmenu">
	                <li id="schBasic" class="cal" data-url="addCalList.do"><a href="javascript:void(0);">calendar</a></li>
	                <li id="schToday" class="today" data-url="addDayList.do"><a href="javascript:void(0);">today</a></li>
	                <li id="schList" class="list" data-url="addList.do"><a href="javascript:void(0);">list</a></li>
	            </ul>
	        </div>
	    </div>
	    <div class="searchBox_schBasic searchBox_schToday display_none">
		    <%-- 1~12월 --%>
			<ul class="sch_mon">
				<c:forEach begin="1" end="12" var="mm">
					<fmt:formatNumber value="${mm}" pattern="00" var="formattedMm"/>
					<li id="sch_mon_li_<c:out value="${formattedMm}"/>" <c:out value="${searchVO.schEtc02 eq formattedMm ? 'class=on' : ''}"/>>
						<a href="javascript:void(0)"><c:out value="${mm}"/>월</a>
					</li>
				</c:forEach>
			</ul>
	    </div>
	    <div class="searchBox_schList display_none">
			<div class="search_basic">
			    <table>
			        <colgroup>
			            <col class="w90px">
			            <col>
			            <col class="w120px">
			            <col>
			            <col class="w120px">
			            <col>
			            <col class="w120px">
			            <col>
			        </colgroup>
			        <tbody>
			            <tr>
			                <td><label>기간</label></td>
			                <td colspan="3">
			                    <span class="calendar_input"><form:input path="searchStartDate" disabled="true"/></span>
			                    <span class="gap">~</span>
			                    <span class="calendar_input"><form:input path="searchEndDate" disabled="true"/></span>
			                </td>
			                <td><label>검색</label></td>
			                <td colspan="3">
			                    <form:select path="searchCondition" title="구분선택" cssClass="w150" disabled="true">
			                        <form:option value="" label="전체"/>
									<form:option value="1" label="제목"/>
									<form:option value="2" label="내용"/>
			                    </form:select>
			                    <form:input path="searchKeyword" id="searchKeyword" disabled="true"/>
			                </td>
			            </tr>
			        </tbody>
			    </table>
			    <button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
    			<button type="button" class="btn btn_search" id="btn_search"><i class="xi-search"></i>검색</button>
			</div>
	    </div>
		
		<%-- 달력형 --%>
		<div class="tab_cont js_tcont tab_cont_01" data-tab="schBasic"></div>
		<%-- 축약형 --%>
		<div class="tab_cont js_tcont tab_cont_02" data-tab="schToday"></div>
		<%-- 목록형 --%>
		<div class="tab_cont js_tcont tab_cont_03" data-tab="schList"></div>
	</form:form>
</div>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
		<select id="selYear"></select>
		<button type="button" id="btn_hday_save" class="btn">공휴일 수동저장</button>
	</c:if>
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}"><button type="button" class="btn blue btn_write">일정등록</button></c:if>
</div>
<div id="display_view1" class="layer_pop js_popup w1370px"></div>
<div id="display_view2" class="layer_pop js_popup w1370px"></div>
<div class="popup_bg" id="js_popup_bg"></div>