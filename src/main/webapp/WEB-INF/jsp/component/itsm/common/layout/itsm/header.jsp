<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>


<script type="text/javascript">
</script>
<header id="header">
	<a href="/itsm/main.do" class="logo"><img src="/component/itsm/images/icon/logo.png" alt="IT서비스 관리시스템"></a>
	<!-- gnb -->
	<div id="gnb_area">
		<nav id="gnb">
			<ul class="gnb">
				<jsp:include page="/WEB-INF/jsp/component/itsm/common/layout/itsm/menuList/${not empty sessionScope.itsm_user_info.grpAuthId ? sessionScope.itsm_user_info.grpAuthId : 'default'}.jsp" flush="true"/>
			</ul>
		</nav>
	</div>
	<!-- gnb -->

</header>
