<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
    <h2>개발담당자 목록</h2>
    <a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
</div>
<div class="pop_content">
	<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="popFrm" name="popFrm" method="post" onsubmit="fncPopBoard(); return false;">
		<form:hidden path="schEtc09" id="schEtc09"/> <%-- addList 구분값 --%>	
		<form:hidden path="schEtc10" id="schEtc10"/> <%-- currentPageNo 담을 임시변수 --%>
		<form:hidden path="currentPageNo" id="currentPageNo"/>
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
							<form:select path="searchCondition" id="searchCondition" cssClass="selec w20p">
								<form:option value="" label="전체"/>
								<form:option value="1" label="이름"/>
								<form:option value="2" label="직급"/>
								<form:option value="3" label="전화번호"/>
							</form:select>
							<form:input id="searchKeyword" path="searchKeyword" cssClass="text sch_user_modal" placeholder="검색어를 입력해 주세요" type="text"/>
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
$(document).ready(function(){
	
	fncPopBoard();
});

<%-- 검색버튼 클릭시 --%>
$("#btn_pop_search").on("click",function(){
	fncPopBoard();
})

function fncPopBoard(a, b, pageNo){
	<%-- currentPageNo 담을 임시변수 --%>
	$("#schEtc10").val(pageNo);
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
</script>