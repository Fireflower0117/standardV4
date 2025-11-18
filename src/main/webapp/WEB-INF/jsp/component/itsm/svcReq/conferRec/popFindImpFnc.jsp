<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
    <h2>서비스요청사항 목록</h2>
    <a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
</div>
<div class="pop_content">
	<div class="search_wrap">
	<form:form modelAttribute="popVO" id="popImpFncFrm" name="popFrm" method="post">
		<form:hidden path="schEtc09" id="schEtc09_impFnc"/> <%-- addList 구분값 --%>
		<form:hidden path="schEtc10" id="schEtc10_impFnc"/> <%-- currentPageNo 담을 임시변수 --%>
		<form:hidden path="currentPageNo" id="currentPageNo_impFnc"/>
		<form:hidden path="cofSn" id="cofSn_impFnc"/>
		<form:hidden path="svcSn" id="svcSn_impFnc"/>
		<form:hidden path="svcDivn" id="svcDivn_impFnc"/>
		<div class="search_basic">
			<table class="search_tbl">
				<caption>검색</caption>
				<colgroup>
					<col style="width: 80px;">
					<col style="width: 130px;">
					<col style="width: 100px;">
					<col>
					<col style="width: 100px;">
				</colgroup>
				<tbody>
					<tr>
						<th><label>구분</label></th>
						<td>
							<form:select path="schEtc06" id="schEtc06" cssClass="selec w100p">
								<form:option value="" label="선택"/>
								<form:option value="impFnc" label="기능개선요청"/>
								<form:option value="rqst" label="요구사항관리"/>
							</form:select>
						</td>
						<th><label>검색</label></th>
						<td>
							<form:select path="schEtc07" id="schEtc07" cssClass="selec w25p">
								<form:option value="" label="전체"/>
								<form:option value="1" label="요청내용"/>
							</form:select>
							<form:input id="schEtc08" path="schEtc08" cssClass="text w70p" placeholder="검색어를 입력해 주세요" type="text" />
						</td>
						<td>
							<a href="javascript:void(0);" id="btn_pop_search" class="btn btn_cancel">검색</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form:form>
	</div>
	<div class="tbl_user"></div>
</div>
<script type="text/javaScript">
$(document).ready(function(){

	fncPopBoard();

});

<%-- 검색버튼 클릭시 --%>
$("#btn_pop_search").on("click",function(){
	fncPopBoard();
})

<%-- 검색창 엔터입력시 --%>
$("#schEtc08").keydown(function(e){
	if (e.keyCode == 13) {
		e.preventDefault();
		fncPopBoard();
	}
});

<%-- 전체선택 --%>
function fncAllChk(obj){
	if($(obj).is(":checked")){
		$(".allSrchChk").prop("checked",true).change();
	}else{
		$(".allSrchChk").prop("checked",false).change();
	}
	
	$(".allSrchChk").each( function() {
		fncAddUser($(this).val());
	})
}

<%-- 초기화 --%>
$("#btn_reset2").click( function() {
	
	var defaultFrm = $("#defaultFrm input, select");
	
	$.each( defaultFrm, function(index, el) {
		 if( $(this).attr("id") === "schEtc07") {
			$(this).val("");
		} else if( $(this).attr("id") === "schEtc08") {
			$(this).val("");
		}
	})
	$('#schEtc10').val("1");  
	fncPopBoard();
})

function fncPopBoard(a, b, pageNo){
	<%-- currentPageNo 담을 임시변수 --%>
	$("#schEtc10").val(pageNo);
	$.ajax({  
		method: "POST",  
		url: 'popFindPrcsAddList.do',
		data : $("#popImpFncFrm").serialize(),
		dataType: "html", 
		success: function(data) {
			$(".tbl_user").html(data);
	   }});
	
}
</script>