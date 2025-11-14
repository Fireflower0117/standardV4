<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<header id="header">
    <div class="gnb_bg"></div>
    <div class="hd_top">
        <div class="wrap">
            <h1 class="logo"><a href="/ft/main.do"><img src="/ft/images/common/logo.png" alt="logo"></a></h1>
            <div class="utils">
                <ul>
                	<c:choose>
                		<c:when test="${empty sessionScope.ft_user_info }">
		                    <li><a href="/ft/login.do">로그인</a></li>
		                    <li><a href="/ft/join/useAgrTerms.do">회원가입</a></li>
                		</c:when>
                		<c:otherwise>
		                    <li><a href="">${sessionScope.ft_user_info.userNm }님</a></li>
		                    <li><a href="/ft/logout.do">로그아웃</a></li>
		                    <li><a href="/my/userInfo/amend/list.do">마이페이지</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
        </div>
    </div>
    <div class="gnb_area">
        <div class="wrap">
            <nav id="gnb">
                <ul class="gnb">
                    <jsp:include page="/WEB-INF/jsp/common/layout/my/menuList/${not empty sessionScope.ft_user_info.grpAuthId ? sessionScope.ft_user_info.grpAuthId : 'default'}.jsp" flush="true"/>
                </ul>
            </nav>
        </div>
    </div>
</header>