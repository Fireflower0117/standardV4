<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
const fncFormSubmit = function (srvyAnsSerno,srvyAnscgval) {
	$("#srvyAnsSerno").val(srvyAnsSerno);
	$("#srvyAnsCgVal").val(srvyAnscgval);

	$("#defaultFrm").attr({"action": "resultPopDetail.do", "method": "post", "target": "_self", "onsubmit" : ""}).submit();
	return false;
};

$(document).ready(function(){
	fncPageBoard("addList", "resultPopDetailAddList.do", '<c:out value="${searchVO.currentPageNo}"/>');
});
</script>
<div style="padding:40px;">
	<div class="page_top">
	    <h2 class="page_title">설문결과 상세보기</h2>
	    <ul class="breadcrumb">
	    	<li class="home"><i class="xi-home"></i></li>
	    	<li>사용자지원</li>
	    	<li>설문조사</li>
	    	<li>설문결과보기</li>
	    	<li class="last">설문결과 상세보기</li>
	    </ul>
	</div>
	<section id="content">
		<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false">
			<form:hidden path="srvySerno"/>
			<form:hidden path="srvyQstSerno"/>
			<form:hidden path="srvyAnsCgVal"/>
			<form:hidden path="srvyAnsSerno"/>
			<form:hidden path="currentPageNo"/>
			<div class="tbl"></div>
		</form:form>
	</section>
</div>