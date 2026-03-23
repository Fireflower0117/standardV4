<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncDate("searchStartDate", "searchEndDate");
	fncAddList('${searchVO.currentPageNo}');

});

</script>

<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="imprvSn" id="imprvSn"/>
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
					<td colspan="3">
						<form:select path="schEtc00" id="schEtc00"  cssClass="select">
	                	</form:select>
	                </td>

				</tr>
				<tr>
					<th scope="row">요청일</th>
					<td colspan="3">
 						<span class="calendar_input w120">
							<form:input path="searchStartDate" id="searchStartDate" readonly="true" placeholder="시작일" cssClass="text w120"/>
						</span>
						<span class="mar_l10">~</span>
						<span class="calendar_input w120 mar_l10">
							<form:input path="searchEndDate" id="searchEndDate" readonly="true" placeholder="종료일" cssClass="text w120"/>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row">요청구분</th>
					<td>
						<form:select path="schEtc01" id="schEtc01"  cssClass="select w25p">
							<form:option value="" label="전체"/>
							<form:option value="RE01" label="긴급"/>
							<form:option value="RE02" label="일반"/>
							<form:option value="RE03" label="중요"/>
						</form:select>
					</td>
					<th scope="row">처리상태</th>
					<td>
						<form:select path="schEtc02" id="schEtc02"  cssClass="select w25p">
							<form:option value="" label="전체"/>
							<form:option value="PO01" label="요청"/>
							<form:option value="PO02" label="처리중"/>
							<form:option value="PO03" label="처리완료"/>
						</form:select>
					</td>
				</tr>

				<tr>
					<th scope="row">검색</th>
					<td colspan="3">
						<form:select path="searchCondition" id="searchCondition" title="구분선택" cssClass="selec w10p">
							<form:option value="" label="전체"/>
							<form:option value="1" label="제목"/>
							<form:option value="2" label="요청자"/>
							<form:option value="3" label="처리자"/>
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
