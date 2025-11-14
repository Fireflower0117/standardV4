<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 페이지당 건수 변경시 --%>
	$('#recordCountPerPage_board_right').on('change', function() {
		fncRecordCountPerPageSet();
		fncPageBoard('list','list.do',1);
	});

});
</script>
<select id="recordCountPerPage_board_right">
    <option value="10" label="10건" ${searchVO.recordCountPerPage eq '10' ? 'selected="selected"' : '' }/>
    <option value="20" label="20건" ${searchVO.recordCountPerPage eq '20' ? 'selected="selected"' : '' }/>
    <option value="30" label="30건" ${searchVO.recordCountPerPage eq '30' ? 'selected="selected"' : '' }/>
    <option value="50" label="50건" ${searchVO.recordCountPerPage eq '50' ? 'selected="selected"' : '' }/>
</select>
