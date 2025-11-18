<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">

$(document).ready(function(){
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');

	<%-- 체크박스 전체가 선택되어있나 확인 --%>
	funCheckAllAction();
});

<%-- 사용자 일련번호 저장용 배열 --%> 
let userArr = new Array();

<%-- 전체 선택 체크박스 클릭시 --%>
const fncCheckAll = function(obj) {
	let isChk = $(obj).is(":checked");
	$('input[type="checkbox"][id^="cbx_"]').prop('checked', isChk).trigger('change');
}
<%-- 체크박스 전체가 선택되어있나 확인 --%>
const funCheckAllAction = function(){
	<%-- 체크박스 개수 --%>
	let checkboxLength = $('input[id^=cbx_]').length;
	<%-- 체크된 체크박스 개수 --%>
	let checkedLength = $('input[id^=cbx_]:checked').length;
	
	if(checkboxLength > 0){
		<%-- 전체 체크 --%>
		if(checkboxLength === checkedLength) {
			$('#allChk').prop('checked',true);
		<%-- 그 외 --%>
		} else {
			$('#allChk').prop('checked',false);
		}
	}
}
<%-- 체크박스 클릭시 --%>
const fncCheckAction = function(obj){
	let serno = $(obj).parents('tr').data('serno');
	let idx = userArr.indexOf(serno);

	if($(obj).is(":checked")){
		if(idx === -1){
			userArr.push(serno);
		}
	}else{
		if(idx > -1){
			userArr.splice(idx, 1);
		}
	}
	
	<%-- 체크박스 전체가 선택되어있나 확인 --%>
	funCheckAllAction();
}

<%-- 페이지 이동시 체크박스 유지 --%>
const fncPageMoveCheckSet = function(){
	for (let i = 0; i < userArr.length; i++) {
	    let data = userArr[i];
	    $('#cbx_' + data).prop('checked', true);
	}
	
	<%-- 체크박스 전체가 선택되어있나 확인 --%>
	funCheckAllAction();
}

/* 한글다운로드 미리보기 */
const cmFncHwpDown = function(){

	if(userArr.length <= 0){
		alert("선택된 항목이 없습니다.")
		return false;
	}else{
		$("#schEtc11").val(userArr)
	}

	window.open("", "childForm", "width=600, height=800, resizable = no, scrollbars = no");

	var defaultFrm = document.defaultFrm;

	defaultFrm.action = "/ma/us/hwp/hwpView.do";
	defaultFrm.method = "post";
	defaultFrm.target = "childForm";
	defaultFrm.submit();
	defaultFrm.target = "";

	return false;
}

const cmFncHwplibDown = function(){
	$.ajax({
		url      : "/ma/us/cm_hwp/hwplibDown",
		type     : "post",
		success  : function(data){
			alert("c:/hwpDown에 hwplib 다운로드 완료");
		},
		error   : function(error, status){
			console.log(error);
		}
	})
}

</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<input type="hidden" id="authAreaCd" name="authAreaCd" value="FT"/>
		<input type="hidden" id=schEtc11 name="schEtc11"/>
		<table>
			<caption>검색</caption>
			<colgroup>
				<col class="w10p">
				<col>
				<col class="w10p">
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
		<button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
    	<button type="button" class="btn btn_search" id="btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
