<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
$(document).ready(function(){


	fncPopAddList(1);

	<%-- 검색창 엔터입력시 --%>
	$("#schEtc09Pop").keydown(function(e){
		if (e.keyCode == 13) {
			e.preventDefault();
			fncPopAddList(1);
		}
	});
});

<%--항목 리스트 호출--%>
function fncPopAddList(a,b, pageNo){
	<%-- currentPageNo 담을 임시변수 --%>
	$("#schEtc10Pop").val(pageNo);
	 $.ajax({
		 method: "POST"
	   , url: "popInspFormAddList.do"
	   , data : $("#popFrm").serialize()
	   , dataType: "html"
	   , success: function(data) {
	   	    $(".popTbl").html(data);
	     }, error: function (){
	   		alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
		 }
	 });
}

function fncAddFrm(frmSn, frmNm, autoYn) {
	if(autoYn > 0) {
		if(!confirm("시스템 자동 점검을 수행한 후에 점검 등록이 진행됩니다. \n계속 하시겠습니까?")) {
			return false;
		}
	}
	<%--클릭한 양식을 form 화면에 입력--%>
	$("#frmNm").text(frmNm);
	$("#frmSn").val(frmSn);
	$.ajax({
		method: "POST"
		, url: "addFrm.do"
		, data : {frmSn : frmSn}
		, dataType: "html"
		, success: function(data) {
			modal_hide_all();
			$("#addFrm").html(data);
		}, error: function (){
			alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
		}
	});
}
</script>
<div class="pop_header">
	<div class="pop_tit">
		<h2>점검 양식 검색</h2>
	</div>
	<a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
</div>
<div class="pop_content" style="padding: 30px;">
	<div class="search_area">
		<form:form modelAttribute="searchVO" id="popFrm" name="popFrm" method="post">
			<form:hidden path="schEtc10" id="schEtc10Pop"/> <%-- currentPageNo 담을 임시변수 --%>
			<form:hidden path="currentPageNo" id="currentPageNoPop"/>
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
					<tr>
						<th scope="row"><strong class="search_tit">검색</strong></th>
						<td colspan="3">
							<form:select path="schEtc08" id="schEtc08Pop" class="selec w30p">
								<form:option value="0" label="전체"/>
								<form:option value="1" label="양식 명 "/>
							</form:select>
							<form:input id="schEtc09Pop" path="schEtc09" cssClass="text" placeholder="검색어를 입력해 주세요" type="text" style="width: calc(100% - 6px - 30%);"/>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="btn_area">
					<button type="button" class="btn btn_search" onclick="fncPopAddList(1);">
						<span>검색</span>
					</button>
				</div>
			</div>
		</form:form>
		<div class="popTbl"></div>
	</div>
</div>