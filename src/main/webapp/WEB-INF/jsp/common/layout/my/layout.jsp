<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Pragma" content="no-store"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<title>오픈노트 - 표준안</title>
	<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/ft/images/common/logo.png" type="image/x-icon">
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/jquery-ui-1.12.1.custom.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/basic.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/board.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ft/css/common.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ft/css/member.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ft/css/my.css">
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery-ui-1.12.1.custom.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/common.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/cm.validate.js" charset="utf-8"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/basic.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/board.js"></script>
	<script>
		var depth1 = "${sessionScope.menuCdMap.depth1}";
		var depth2 = "${sessionScope.menuCdMap.depth2}";
		var depth3 = "${sessionScope.menuCdMap.depth3}";
		var depth4 = "${sessionScope.menuCdMap.depth4}";
	</script>
</head>
<body>
	<!-- skip menu -->
    <div class="skip" id="skipnavi">
        <ul>
            <li><a href="#gnb">메뉴바로가기</a></li>
            <li><a href="#container">본문바로가기</a></li>
        </ul>
    </div>
    <!-- //skip menu -->
    
    <!-- wrapper -->
	<div id="wrapper">
		<tiles:insertAttribute name="header"/>
		<div id="main_container">
			<section id="content">
				<jsp:include page="/WEB-INF/jsp/common/layout/my/aside/${not empty sessionScope.ft_user_info.grpAuthId ? sessionScope.ft_user_info.grpAuthId : 'default'}.jsp" flush="true"/>
				<tiles:insertAttribute name="body"/>
			</section>
		</div>
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>