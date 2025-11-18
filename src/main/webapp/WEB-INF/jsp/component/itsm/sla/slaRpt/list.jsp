<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function(){

	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncMonth("schEtc01");
	fncAddList('${searchVO.currentPageNo}');

	
});
function fncUpdatePop(){
	$.ajax({
		method : "POST",
		url    : "updatePop.do",
		data : $("#defaultFrm").serialize(),
		dataType : "html",
		success  : function(data) {
			modal_show('30%','30%', data);
		}
	});
}
</script>

<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
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
					<th scope="row">서비스구분</th>
					<td>
						<form:select path="schEtc00" id="schEtc00"  cssClass="select">
						</form:select>
					</td>
					<th scope="row">보고서 기준달</th>
					<td>
 						<span class="calendar_input w120">
							<form:input path="schEtc01" id="schEtc01" readonly="true" cssClass="text w120" placeholder="기준달"/>
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
