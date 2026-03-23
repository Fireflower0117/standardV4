<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
$(document).ready(function(){

	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncAddList('${searchVO.currentPageNo}');
});

</script>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="inspSn" id="inspSn"/>
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
					<th scope="row">검색</th>
					<td colspan="3">
						<form:select path="searchCondition" id="searchCondition" title="구분선택" cssClass="select w10p">
							<form:option value="" label="전체"/>
							<form:option value="1" label="점검양식명"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="text w85p"/>
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