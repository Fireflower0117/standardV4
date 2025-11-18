<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncCodeList("DOGB", "select", "전체", "${searchVO.schEtc01}", "schEtc01", "schEtc01", "", "ASC");
	fncCodeList("DOC", "select", "전체", "${searchVO.schEtc02}", "schEtc02", "schEtc02", "", "ASC");
	fncCodeList("${searchVO.schEtc02}", "select", "전체", "${searchVO.schEtc03}", "", "schEtc03", "", "ASC");
	fncAddList('${searchVO.currentPageNo}');

});



function fncFilePop(docSn) {
	fncAjax('filePop.do', {"docSn" : docSn}, 'html', true, '', function(html){
		modal_show('800px', '300px', html);
	});
}


function fncDocArea(val){
	if(val){
		fncCodeList(val, "select", "전체", "${searchVO.schEtc03}", "", "schEtc03", "", "ASC");
	}else{
		$("#schEtc03").html('<option>전체</option>')
	}
}


</script>

<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="docSn" id="docSn"/>
		<input type="hidden" id="atchFileId" name="atchFileId">
		<input type="hidden" id="fileSn" name="fileSn">
		<input type="hidden" id="streFileNm" name="streFileNm">
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

					<th scope="row">영역</th>
					<td>
						<form:select path="schEtc02" id="schEtc02"  cssClass="select w25p" onchange="fncDocArea(this.value)">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
					<th scope="row">단계</th>
					<td>
						<form:select path="schEtc03" id="schEtc03"  cssClass="select w25p">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row">문서 구분</th>
					<td>
						<form:select path="schEtc01" id="schEtc01"  cssClass="select w25p">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
					<th scope="row">검색</th>
					<td>
						<form:select path="searchCondition" id="searchCondition" title="구분선택" cssClass="select w25p">
							<form:option value="" label="전체"/>
							<form:option value="1" label="문서 이름"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="text w70p"/>
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
