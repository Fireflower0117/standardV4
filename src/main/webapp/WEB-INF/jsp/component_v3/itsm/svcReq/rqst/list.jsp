<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	
	fncDate("searchStartDate", "searchEndDate");
	fncPageBoard("addList", "addList.do", <c:out value="${searchVO.currentPageNo}"/>);

});

</script>

<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;" onkeydown="enterkey();">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="rqrSn"/>
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
						</form:select>
					</td>

				</tr>
				<tr>
					<th scope="row">작성일</th>
					<td colspan="">
 						<span class="calendar_input w120">
							<form:input path="searchStartDate" id="searchStartDate" readonly="true" cssClass="text w130"/>
						</span>
						<span class="mar_l10">~</span>
						<span class="calendar_input w120 mar_l10">
							<form:input path="searchEndDate" id="searchEndDate" readonly="true" cssClass="text w130"/>
						</span>
					</td>
					<th scope="row">진행현황</th>
					<td>
						<form:select path="schEtc01" id="schEtc01" cssClass="select w25p">
							<form:option value="" label="선택"/>
							<form:option value="P" label="진행"/>
							<form:option value="C" label="완료"/>
						</form:select>
					</td>

				</tr>
				<tr>
					<th scope="row">검색</th>
					<td colspan="3">
						<form:select path="searchCondition" id="searchCondition" title="구분 선택" cssClass="select w10p" >
							<form:option value="" label="전체"/>
							<form:option value="1" label="요구사항ID"/>
							<form:option value="2" label="요구사항 항목"/>
							<form:option value="3" label="요구사항 상세ID"/>
							<form:option value="4" label="요구사항 세부내역"/>
							<form:option value="5" label="출처"/>
							<form:option value="6" label="분류"/>
							<form:option value="7" label="고객담당자"/>
							<form:option value="8" label="개발담당자"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="text w85p"  />
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
