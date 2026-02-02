<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 항목 코드 목록 조회 --%>
	fncCodeList("LG", "select", "선택", "","", "itmCd", "", "ASC");
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
});
</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" id="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<input type="hidden" name="logoSerno" id="logoSerno"/>
		<table>
			<caption>검색</caption>
			<colgroup>
					<col class="w10p">
					<col class="w15p">
					<col class="w10p">
					<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>항목</label></td>
					<td>
						<select id="itmCd" name="itmCd" title="항목" cssClass="w100p" required="required">
						</select>
					</td>
					<td><label>검색</label></td>
					<td>
						<form:select path="searchCondition" title="구분선택" cssClass="w150">
							<form:option value="" label="전체"/>
							<form:option value="1" label="url"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword"/>
					</td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
		<button type="button" id="btn_search" class="btn btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
