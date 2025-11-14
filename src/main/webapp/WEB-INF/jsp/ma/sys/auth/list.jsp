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
		<input type="hidden" name="grpAuthSerno" id="grpAuthSerno"/>
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
							<form:option value="1" label="그룹권한ID"/>
							<form:option value="2" label="그룹권한명"/>
							<form:option value="3" label="그룹권한설명"/>
						</form:select>
						<form:input path="searchKeyword"/>
					</td>
				</tr>
			</tbody>
		</table>
			<button id="btn_reset" class="btn btn_reset"><i class="xi-refresh"></i>초기화</button>
          	<button id="btn_search" class="btn btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
