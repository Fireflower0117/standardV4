<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;" onkeydown="enterkey();">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="popupSn"/>
		<table class="search_tbl">
			<caption>검색</caption>
			<colgroup>
				<col style="width: 15%;">
				<col>
				<col style="width: 15%;">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th><label>게시여부</label></th>
					<td>
						<form:select path="schEtc00" cssClass="typeA selec w150px">
							<form:option value="">전체</form:option>
							<form:option value="Y">게시</form:option>
							<form:option value="N">미게시</form:option>
						</form:select>
					</td>
					<th><label>기간검색</label></th>
					<td>
						<form:select path="schEtc01" cssClass="typeA selec w150px" onchange="searchDate(this.value);">
							<form:option value="0">등록일</form:option>
							<form:option value="1">게시기간</form:option>
						</form:select>
						<span class="calendar_input">
							<form:input path="searchStartDate" id="searchStartDate" cssClass="typeA text" readonly="true"/>
						</span>
						<span class="gap">~</span>
						<span class="calendar_input">
							<form:input path="searchEndDate" id="searchEndDate" class="typeA text"  readonly="true"/>
						</span>
						<div class="btn sml reset" id="btn_today" style="position: static;cursor: pointer;">오늘</div>
					</td>
				</tr>
				<tr>
					<th><label>검색</label></th>
					<td colspan="3">
						<form:select path="searchCondition" cssClass="typeA selec w150px">
							<form:option value="">전체</form:option>
							<form:option value="1">제목</form:option>
							<form:option value="2">내용</form:option>
						</form:select>
						<form:input id="searchKeyword" path="searchKeyword" cssClass="typeA text" placeholder="검색어를 입력하세요."/>
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
<script type="text/javaScript">
$(document).ready(function(){

	fncDate("searchStartDate", "searchEndDate");
	fncPageBoard('addList','addList.do', <c:out value="${searchVO.currentPageNo}"/>);

	<%-- 초기화 --%>
	$("#reset").click( function() {
		
		var defaultFrm = $("#defaultFrm input, select");
		
		$.each( defaultFrm, function(index, el) {
			if( $(this).attr("id") === "searchStartDate" || $(this).attr("id") === "searchEndDate"){
			} else if( $(this).attr("id") === "schEtc01") {
				$(this).val("0");
			} else if( $(this).attr("type") != "hidden") {
				$(this).val("");
			}
		})
	});
	
});

$("#btn_today").click( function() {
})

function enterkey() {
    if (window.event.keyCode == 13) {
    	fncPageBoard('list','list.do');
    }
}
</script>