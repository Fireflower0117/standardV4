<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncAddList('${searchVO.currentPageNo}');
	
});
function fncPopBackup() {
	fncAjax('popBackup.do', {}, 'html', true, '', function(html){
		modal_show('400px', '300px', html);
	});
}
function fncPopSchedule(){
	fncAjax('popSchedule.do', {}, 'html', true, '', function(html){
		modal_show('800px', '300px', html);
	});
}
</script>

<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="bakSn" id="bakSn"/>
		<input type="hidden" id="svcSn" name="svcSn" value="2"/>
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
				<th scope="row">서비스 구분</th>
				<td colspan="3">
					<form:select path="schEtc00" id="schEtc00"  cssClass="select">
						<form:option value="" label="전체"/>
					</form:select>
				</td>

			</tr>
				<tr>
					<th scope="row">백업 구분</th>
					<td colspan="3">
						<form:select path="schEtc01" id="schEtc01"  cssClass="select w10p">
							<form:option value="" label="전체"/>
							<form:option value="Y" label="자동백업"/>
							<form:option value="N" label="수동"/>
						</form:select>
					</td>
					<%--<th scope="row">검색</th>
					<td >
						<form:select path="searchCondition" id="searchCondition" title="구분선택" cssClass="selec w25p">
							<form:option value="" label="전체"/>
							<form:option value="1" label="백업 이름"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="text w70p"/>
					</td>--%>
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
