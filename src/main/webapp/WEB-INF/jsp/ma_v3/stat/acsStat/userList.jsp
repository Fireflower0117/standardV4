<%--@elvariable id="searchVO" type="com.opennote.standard.ma.cmmn.domain.CmmnDefaultVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
	$(document).ready(function(){
		fncPageBoard('addList','userAddList.do','<c:out value="${searchVO.currentPageNo}"/>');
	});

	$('.pop_close, .btn_close').on('click', function(){
		view_hide(1);
	})

</script>
<div class="pop_header">
	<h2><c:out value="${searchVO.procType eq 'scrb' ? '가입' : '탈퇴'}"/>회원 리스트</h2>
	<button type="button" class="pop_close"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="min-height: 500px;" data-simplebar data-simplebar-auto-hide="false">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="schEtc00"/>
		<form:hidden path="procType"/>
	</form:form>
	<div class="tbl"></div>
</div>
<div class="pop_footer">
	<button type="button" class="btn btn_close">닫기</button>
</div>