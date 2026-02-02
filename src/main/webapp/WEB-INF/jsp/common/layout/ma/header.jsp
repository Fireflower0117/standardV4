<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>



<header id="header" class="header_leftfix">
	<div class="header_inner">
		<div class="sidebyside">
			<h1 class="logo">
				<strong style="color: white; margin-left: 20px; font-size: 20px;">표준안 Version4</strong>
			</h1>
			<div class="right">
				<c:if test="${ sessionScope.systemPolicyVo.itsmUseYn == 'Y'}">
					<a href="/itsm/login.do" class="btn_itsm" target="_blank">ITSM</a>
				</c:if>
				<div class="utils">
				<c:choose>
					<c:when test="${not empty sessionScope.userDetails}">
						<span class="user_info" id="header_userNm"><strong class="user_name"><c:out value="${sessionScope.userDetails.userKorNm}"/>님</strong></span>
						<a href="/ma/logout.do" class="btn_logout">로그아웃</a>
					</c:when>
					<c:otherwise>
					 	<span class="user_info" id="header_userNm"><strong class="user_name">익명사용자님 님</strong></span>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>
	</div>
</header>
