<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/ckeditor/ckeditor.js?ver=1"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/html2canvas.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
});
</script>
<div class="tbl">
</div>

