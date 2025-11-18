<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
	.imgClass {max-width: 930px;height: auto;}
</style>
<div class="pop_header">
	<h2><c:out value="${itsmFileVO.fileRlNm}"/></h2>
	<button type="button" class="pop_close" onclick="modal_hide_all();"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content c" style="overflow-y:auto;max-width: 100%;">
	<img src='/itsm/file/getByteImage.do?atchFileId=${itsmFileVO.atchFileId}&fileSeqo=${itsmFileVO.fileSeqo}' alt="image" class="imgClass">
</div>
<script type="text/javaScript">
$(document).ready(function(){

});

</script>