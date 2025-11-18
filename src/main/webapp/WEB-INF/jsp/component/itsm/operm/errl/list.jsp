<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
var searchStartDate = "";
var searchEndDate = "";
$(document).ready(function(){
    fncDate('searchStartDate','searchEndDate');
    dateSetTing();
    /* fncSetToday("searchStartDate");
    fncSetToday("searchEndDate"); */
    fncPageBoard("addList", "addList.do", <c:out value="${searchVO.currentPageNo}"/>);
    
    $("#btnSearch").click(function(){
    	fncPageBoard("addList", "addList.do", "1")
    })
    
   	$("#reset").click(function(){
   	   	
		for(var i = 0 ; i < document.defaultFrm.elements.length ; i++){
			var el = document.defaultFrm.elements[i];
			if(el.id === "searchStartDate" || el.id === "searchEndDate"){
				// 날짜 지정
				$("#searchStartDate").val(searchStartDate);
				$("#searchEndDate").val(searchEndDate);
				continue;
			}
			if(el.id === "searchCondition") {
				$("#searchCondition").val("");
				continue;
			}
			el.value = "";
		}
		
		$("[id^=err]").val("");
		$('input[name="schEtc11"]').prop('checked', false);
		//fncPageBoard("addList", "addList.do", "1")
	}); 
    
  	//검색 엔터 체크
    $("#errKeyword").keydown(function(e){
    	if (e.keyCode == 13) {
    		e.preventDefault();
    		fncPageBoard("addList", "addList.do", "1")
    	}
    });
});
function dateSetTing() {
	searchStartDate = $('#searchStartDate').val();
	searchEndDate =  $('#searchEndDate').val();
}

// 엑셀 업로드,다운로드
function fncExcel(clcd){
	if(clcd == "down") {
		fncPageBoard("view", "excelDownload.do");
		$("#defaultFrm").attr("onsubmit","return false;");	
	}
}
</script>
<%-- search  --%>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post">
		<form:hidden path="currentPageNo" id="currentPageNo" />
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<input type="hidden" id="serno" name="serno" />
		<table class="search_tbl">
			<caption>검색</caption>
			<colgroup>
				<col style="width:10%">
				<col>
				<col style="width:10%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th><label>에러유형</label></th>
					<td colspan="3">
						<form:input path="schEtc01" id="schEtc01" class="text typeA w120" placeholder="에러유형" maxlength="10"/>
					</td>
				</tr>
				<tr>
					<th><label>발생기간</label></th>
					<td>
						<span class="calendar_input w120">
							<form:input path="searchStartDate" id="searchStartDate" class="selec w120" readonly="true"/>
						</span>
						<span class="gap">~</span>
						<span class="calendar_input w120">
							<form:input path="searchEndDate" id="searchEndDate" class="selec w120" readonly="true"/>
						</span>
					</td>
					<th><label>메뉴명</label></th>
					<td>
						<form:input path="errKeyword" id="errKeyword" class="text typeA w100p" placeholder="검색어를 입력하세요" maxlength="30"/>
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
<%-- //search --%>
<div class="tbl"></div>