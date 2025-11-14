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
	<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/common.css">
	<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/board.css">
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery-ui-1.12.1.custom.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/common.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/basic.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/board.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/atchFile.js"></script>
</head>
<body>
	<div class="win_popup">
		<div id="win_container">
			<tiles:insertAttribute name="body"/>
		</div>
	</div>
</body>
</html>