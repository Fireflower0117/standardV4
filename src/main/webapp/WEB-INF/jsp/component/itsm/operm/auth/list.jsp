<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
	$(document).ready(function(){

		fncPageBoard('addList','addList.do', <c:out value="${searchVO.currentPageNo}"/>);

		if ("${procMsg}") {
			alert("${procMsg}");
		}

		$("#btn_reset").click(function(){
			$("#schEtc03").val("");
			$("#searchCondition").val("");
			$("#searchKeyword").val("");
		});
	});


	<%-- 검책창 엔터 입력 --%>
function enterkey() {
	if (window.event.keyCode == 13) {
		fncPageBoard("addList", "addList.do", '1');
	}
	return false;
}
</script>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="grpAuthSerno"/>
		<table class="search_tbl">
			<caption>검색</caption>
			<colgroup>
				<col style="width: 10%;">
				<col>
			</colgroup>
			<tbody>
			<tr>

				<th scope="row">검색</th>
				<td>
					<form:select path="searchCondition" id="searchCondition" title="구분 선택" cssClass="selec" cssStyle="width:100px;">
						<form:option value="" label="전체"/>
						<form:option value="1" label="권한그룹코드"/>
						<form:option value="2" label="권한그룹명"/>
					</form:select>
					<form:input path="searchKeyword" id="searchKeyword" cssClass="text" onKeyDown="enterkey();"/>
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