<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncAddList('${searchVO.currentPageNo}');

	$("#searchStartDate").monthpicker({
		monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		showOn : "button",
		buttonImage : "/component/itsm/images/sub/icon_calendar.png",
		buttonImageImageOnly : true,
		changeYear : false,
		yearRange : 'c-2:c+2',
		dateFormat : 'yy.mm',
		onSelect: function(value){
			 if(value > $("#searchEndDate").val()){
	        	alert("기간을 확인해주세요.");
	        	$("#searchStartDate").val("${searchVO.searchStartDate}")
	        	$("#searchEndDate").val("${searchVO.searchEndDate}")
	        }
	    }
	});
	
	$("#searchEndDate").monthpicker({
		monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		showOn : "button",
		buttonImage : "/component/itsm/images/sub/icon_calendar.png",
		buttonImageImageOnly : true,
		changeYear : false,
		yearRange : 'c-2:c+2',
		dateFormat : 'yy.mm',
		onSelect: function(value){
	        if(value < $("#searchStartDate").val()){
	        	alert("기간을 확인해주세요.");
	        	$("#searchStartDate").val("${searchVO.searchStartDate}")
	        	$("#searchEndDate").val("${searchVO.searchEndDate}")
	        }
	    }
	})
	
});
	
	<%-- 수동업데이트 팝업 --%>
	function weekJobUpdatePop(){
	 	$.ajax({  
			method : "POST", 
			url    : "weekJobUpdatePop.do", 
			/* data : $("#defaultFrm").serialize(), */
			dataType : "html", 
			success  : function(data) {
				modal_show('35%','30%', data);
			  		 }
			});  
	}
	
	function siteReportPop(rptMonthSn){
		$("#rptMonthSn").val(rptMonthSn);
		var childWindow;
		
		childWindow = window.open("", "childForm", "width=1000, height=1000, resizable = no, scrollbars = no");
		
		var defaultFrm = document.defaultFrm;

		defaultFrm.action = "/itsm/rpt/rptMth/weekReport.do";
		defaultFrm.method = "post";
		defaultFrm.target = "childForm";
		defaultFrm.submit();

		defaultFrm.target = "";
		
		return false;
		
	}

</script>

<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="rptMonthSn"/>
		<table class="search_tbl">
			<caption>검색</caption>
			<colgroup>
				<col style="width:10%">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">서비스 구분</th>
				<td >
					<form:select path="schEtc00" id="schEtc00"  cssClass="select">
					</form:select>
				</td>
			</tr>
				<tr>
					<th scope="row">기간검색</th>
					<td>
 						<span class="calendar_input w120">
							<form:input path="searchStartDate" id="searchStartDate" readonly="true" cssClass="text w120" value="${searchVO.searchStartDate }"/>
						</span>
						<span class="mar_l10">~</span>
						<span class="calendar_input w120 mar_l10">
							<form:input path="searchEndDate" id="searchEndDate" readonly="true" cssClass="text w120" value="${searchVO.searchEndDate }" />
						</span>
					</td>
				</tr>
				</tbody>
			</table>
			<div class="btn_area">
	           	<a href="javascript:void(0);" id="btn_search" class="btn btn_search">검색</a>
				<a href="javascript:void(0);" id="btn_reset" class="btn btn_reset">초기화</a>
			</div>
	</form:form>
</div>
<div class="tbl"></div>
