<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
});
<%-- 정규표현식 테스트용 팝업 --%>
const fncRegepsTest = function(){
	fncAjax('regepsPop.do', $('#defaultFrm').serialize(), 'html', true, '', function(data){
		$('#display_view1').html(data);
		view_show('1');
	});
}
</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<input type="hidden" name="regepsSerno" id="regepsSerno"/>
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
	                		<form:option value="1" label="정규표현식ID"/>
	                		<form:option value="2" label="정규표현식명"/>
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
<%-- 정규표현식 테스트 팝업 --%>
<div id="display_view1" class="layer_pop js_popup w1200px"></div>
<div class="popup_bg" id="js_popup_bg"></div>