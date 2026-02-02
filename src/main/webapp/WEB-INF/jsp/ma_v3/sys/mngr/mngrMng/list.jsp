<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 체크박스 serno 저장용 배열 --%> 
let checkArray = new Array();

$(document).ready(function(){
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
});

<%-- 전체 선택 체크박스 클릭시 --%>
function fncCheckAll(obj) {
	let isChk = $(obj).is(":checked");
	$('input[type="checkbox"][id^="cbx_"]').prop('checked', isChk).trigger('change');
}

<%-- 체크박스 클릭시 --%>
function fncCheckAction(obj){
	let serno = $(obj).parents('tr').data('serno');
	let idx = checkArray.indexOf(serno);

	if($(obj).is(":checked")){
		if(idx === -1){
			checkArray.push(serno);
		}
	}else{
		if(idx > -1){
			checkArray.splice(idx, 1);
		}
	}
	
	funCheckAllAction();
}

<%-- 체크박스 전체가 선택되어있나 확인 --%>
function funCheckAllAction(){
	<%-- 체크박스 개수 --%>
	let checkboxLength = $('input[id^=cbx_]').length;
	<%-- 체크된 체크박스 개수 --%>
	let checkedLength = $('input[id^=cbx_]:checked').length;
	
	if(checkboxLength > 0){
		<%-- 전체 체크 --%>
		if(checkboxLength == checkedLength) {
			$('#allChk').prop('checked',true);
		<%-- 그 외 --%>
		} else {
			$('#allChk').prop('checked',false);
		}
	}
}

<%-- 페이지 이동시 체크박스 유지 --%>
function fncPageMoveCheckSet(){
	for (let i = 0; i < checkArray.length; i++) {
		let data = checkArray[i];
		$('#cbx_' + data).prop('checked', true);
	};
	
	funCheckAllAction();
}
</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<input type="hidden" id=userSerno name="userSerno"/>
		<input type="hidden" id="authAreaCd" name="authAreaCd" value="MA"/>
		<table>
			<caption>검색</caption>
			<colgroup>
					<col style="width:10%">
					<col>
					<col style="width:10%">
					<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>검색</label></td>
					<td colspan="3">
						<form:select path="searchCondition" title="구분선택" cssClass="w150">
							<form:option value="" label="전체"/>
							<form:option value="1" label="아이디"/>
							<form:option value="2" label="이름"/>
							<form:option value="3" label="이메일"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword"/>
					</td>
				</tr>
			</tbody>
		</table>
		<button id="btn_reset" class="btn btn_reset"><i class="xi-refresh"></i>초기화</button>
		<button id="btn_search" class="btn btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
