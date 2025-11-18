<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">

</script>
<div>
	평균소요시간 : <c:out value="${itsmPrfmVO.avgTime}"/> ms<br/>
	최대소요시간 : <c:out value="${itsmPrfmVO.maxTime}"/> ms<br/>
	최소소요시간 : <c:out value="${itsmPrfmVO.minTime}"/> ms
</div>
	

