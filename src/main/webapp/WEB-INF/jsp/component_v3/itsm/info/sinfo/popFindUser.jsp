<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
    <h2>사용자 목록</h2>
    <a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
</div>
<div class="pop_content">
	<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="popFrm" name="popFrm" method="post" onsubmit="fncPopBoard(); return false;">
		<form:hidden path="schEtc10" id="schEtc10Pop"/> <%-- currentPageNo 담을 임시변수 --%>
		<form:hidden path="svcSn" id="svcSn"/>
		<form:hidden path="currentPageNo" id="currentPageNoPop"/>

		<div class="search_basic">
			<table class="search_tbl"> 
				<caption>검색</caption>
				<colgroup>
					<col style="width: 10%">
					<col style="width: 80%">
				</colgroup>
				<tbody>
					<tr>
						<th><label>검색</label></th>
						<td>
							<form:select path="schEtc08" id="schEtc08Pop" cssClass="selec w20p">
								<form:option value="" label="전체"/>
								<form:option value="1" label="이름"/>
								<form:option value="2" label="이메일"/>
							</form:select>
							<form:input id="schEtc09Pop" path="schEtc09" cssClass="text" placeholder="검색어를 입력해 주세요" type="text"/>
						</td>
						<td>
							<button type="button" class="btn btn_cancel" id="btn_pop_search"><i class="xi-search"></i>검색</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form:form>
	</div>
	<div class="tbl_pic"></div>
</div>
<script type="text/javaScript">
	var userArr = [];
$(document).ready(function(){

	fncPopBoard();

});

<%-- tr눌렀을 때 체크박스 체크 --%>
function fncChkTr(divnSn){
	if($('#chkBox_'+divnSn).is(':checked') == false){
		$('#chkBox_'+divnSn).prop('checked', true).change();
	}else{
		$('#chkBox_'+divnSn).prop('checked', false).change();
	}
}

<%-- 검색버튼 클릭시 --%>
$("#btn_pop_search").on("click",function(){
	fncPopBoard();
})

function fncPopBoard(a, b, pageNo){
	<%-- currentPageNo 담을 임시변수 --%>
	$("#schEtc10Pop").val(pageNo);
	$.ajax({  
		method: "POST",  
		url: "popFindUserAddList.do",
		data : $("#popFrm").serialize(), 
		dataType: "html", 
		success: function(data) {
			$(".tbl_pic").html(data); 
	   }
	});
	
}

function fncAddManager() {
	if($("[id^=chkBox_]:checked").length == 0){
		alert("체크된 사용자가 없습니다");
		return false;
	}

	userArr = [];
	$("[id^=chkBox_]:checked").each(function(index, item){
		userArr.push($(this).val())
	});

	$("#userSnList").val(userArr);
	/*fncPageBoard("submit", "managerProc.do");*/
	fncProcAjax('patch', "procManager");

}
</script>