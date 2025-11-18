<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
$(document).ready(function(){
	
	<%-- 검색 클릭시 --%>
	$('#btn_search').on('click', function(){
		fncPopAddList(1);
	});
	
	<%--구분, 분류 호출--%>
	fncCodeList('FRM','select','전체','${searchVO.schEtc01}','','schEtc01','');

	fncPopAddList(1);

	//검색 엔터 체크
	$("#searchKey").keydown(function(e){
		if (e.keyCode == 13) {
			fncPopAddList(1);
		}
	});
});

<%--항목 리스트 호출--%>
function fncPopAddList(a, b, pageNo){
	<%-- currentPageNo 담을 임시변수 --%>
	$("#schEtc10Pop").val(pageNo);
	 $.ajax({
		 method: "POST"
	   , url: "popAddList.do"
	   , data : $("#defaultFrm").serialize()
	   , dataType: "html"
	   , success: function(data) {
	   	    $(".popTbl").html(data);
	     }, error: function (){
	   		alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
		 }
	 });
}

<%--리스트 갯수 change--%>
function chngRecordCnt(recordCnt){
	$("#recordCountPerPage").val(recordCnt);
	fncPopAddList(1);
}


<%-- tr눌렀을 때 체크박스 체크 --%>
function fncChkTr(divnSn){
	if($('#chkBox_'+divnSn).is(':checked') == false){
		$('#chkBox_'+divnSn).prop('checked', true).change();
	}else{
		$('#chkBox_'+divnSn).prop('checked', false).change();
	}
}

</script>
<div class="pop_header">
	<div class="pop_tit">
		<h2>점검항목 선택</h2>
	</div>
	<button onclick="window.close();" class="pop_close"><i class="xi-close-thin"></i></button>
</div>
<div class="pop_content" style="padding: 30px;">
	<div class="search_area">
		<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post">
			<form:hidden path="schEtc10" id="schEtc10Pop"/> <%-- currentPageNo 담을 임시변수 --%>
			<form:hidden path="currentPageNo" id="currentPageNoPop"/>
			<input type="hidden" name="itmSnList" id="itmSnList" value="${searchVO.itmSnList}"/>
			<div class="search_wrap">
				<table class="search_tbl">
					<caption>검색</caption>
					<colgroup>
						<col style="width: 100px;">
						<col>
						<col style="width: 140px;">
						<col>
					</colgroup>
					<tbody>
					<tr class="search_fixed">
						<th scope="row"><strong class="search_tit">구분</strong></th>
						<td>
							<form:select path="schEtc01" class="selec">
								<form:option value="" label="구분"/>
							</form:select>
						</td>
						<th scope="row"><strong class="search_tit">검색</strong></th>
						<td>
							<form:select path="searchCondition" class="selec w30p">
								<form:option value="0" label="전체"/>
								<form:option value="1" label="항목 내용"/>
							</form:select>
							<form:input id="searchKey" path="schEtc04" cssClass="text" placeholder="검색어를 입력해 주세요" type="text" style="width: calc(100% - 6px - 30%);"/>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="btn_area">
					<button type="button" id="btn_search" class="btn btn_search">
						<span>검색</span>
					</button>
				</div>
			</div>
		</form:form>
		<div class="popTbl"></div>
	</div>
