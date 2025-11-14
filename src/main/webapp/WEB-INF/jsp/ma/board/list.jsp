<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
});
</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<input type="hidden" id="boardSerno" name="boardSerno"/>
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
							<form:option value="1" label="제목"/>
							<form:option value="2" label="내용"/>
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
