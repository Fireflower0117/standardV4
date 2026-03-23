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
	<meta name="_csrf" content="${_csrf}" />
    <meta name="_csrf_header" content="X-CSRF-TOKEN" />
	<title>오픈노트 - 표준안 Ver.4</title>
	<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/images/logo.png" type="image/x-icon">

    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/css/basic.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/css/board.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/css/common.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/simplebar/simplebar.min.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/jstree/3.3.12/themes/default/style.min.css">


	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/clipboard/clipboard.min.js"></script>

    <!-- jquery-validate -->
    <script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/googleapi/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-validate/1.17.0/dist/jquery.validate.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-filedown/fileDownload.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/simplebar/simplebar.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/ckeditor/ckeditor.js?ver=2"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/html2canvas/html2canvas.js"></script>

	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jstree/3.3.12/js/jstree.min.js"></script>

	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/js/common.js"></script>
	<!-- script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/js/cm.validate.js" charset="utf-8"></script -->
    <script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/js/basic.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/js/board.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/js/atchFile.js"></script>
    <jsp:include  page="/WEB-INF/jsp/common/clientlib.jsp" />
</head>
<body>
	<div class="win_popup">
		<div id="win_container">
			<tiles:insertAttribute name="body"/>
		</div>
	</div>
</body>
</html>