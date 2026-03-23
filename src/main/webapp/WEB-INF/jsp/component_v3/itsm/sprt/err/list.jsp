<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncMenuList("", "select", "선택", "${searchVO.schEtc02}", "schEtc02", "schEtc02", "", "ASC");
	fncCodeList("ERGB", "select", "선택", "${searchVO.schEtc03}","schEtc03", "schEtc03", "", "ASC");

	fncAddList('${searchVO.currentPageNo}');

});

function fncOpenPop() {
	if($("[id^=chkBox_]:checked").length == 0){
		alert("체크된 항목이 없습니다.");
		return false;
	}
	fncAjax('openPop.do', $("#defaultFrm").serialize(), 'html', true, '', function(html){
		modal_show('600px', '400px', html);
	});
}
	
</script>

<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="errSn" id="errSn"/>

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
					<th scope="row">진행단계</th>
					<td>
						<form:select path="schEtc05" id="schEtc05"  cssClass="select w25p">
							<form:option value="" label="전체"/>
							<form:option value="1" label="처리완료"/>
							<form:option value="2" label="미해결"/>
						</form:select>
					</td>
					<th scope="row">에러 유형</th>
					<td>
						<form:select path="schEtc01" id="schEtc01"  cssClass="select w25p">
							<form:option value="" label="전체"/>
							<form:option value="404" label="404 error"/>
							<form:option value="500" label="500 error"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row">메뉴 구분</th>
					<td>
						<form:select path="schEtc02" id="schEtc02"  cssClass="select w25p">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
					<th scope="row">에러 구분</th>
					<td>
						<form:select path="schEtc03" id="schEtc03"  cssClass="select w25p">
							<form:option value="" label="전체"/>
						</form:select>
					</td>

				</tr>
				<tr>

					<th scope="row">검색</th>
					<td colspan="3">
						<form:select path="searchCondition" id="searchCondition" title="구분선택" cssClass="select w10p">
							<form:option value="" label="전체"/>
							<form:option value="1" label="URL"/>
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
