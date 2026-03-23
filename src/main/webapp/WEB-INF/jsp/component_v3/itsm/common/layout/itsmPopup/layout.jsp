<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<title>오픈노트</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/css/jquery-ui-1.12.1.custom.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/js/jquery.mCustomScrollbar.concat.min.js">

	<!--기본요소(form & 텍스트 / 버튼 & 태그 / 테이블 / 탭 / 팝업 / 기타(안내메시지, 메시지박스)) css/-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/font/pretendard.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/font/xeicon/xeicon.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/css/style.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/css/jquery-ui-1.12.1.custom.css" />

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/font/pretendard.css">

    
	<script src="${pageContext.request.contextPath}/component/itsm/js/jquery-1.11.3.min.js"></script>
	<script src="${pageContext.request.contextPath}/component/itsm/js/jquery-ui-1.12.1.custom.js"></script>
	<script src="${pageContext.request.contextPath}/component/itsm/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/component/itsm/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/component/itsm/js/atchFile.js"></script>
	<script src="${pageContext.request.contextPath}/component/itsm/js/board.js"></script>
	<script src="${pageContext.request.contextPath}/component/itsm/js/cm.validate.js"></script>

	<script src="${pageContext.request.contextPath}/component/itsm/js/jquery.cookie.js"></script>s

</head>
<body>
	<div class="win_popup">
		<div id="win_container">
			<tiles:insertAttribute name="body"/>
		</div>
		<div id="modal_div"></div>
		<div class="popup_bg itemB" id="js-popup-bg" onclick="modal_hide_all();"></div>
	</div>
</body>
<script type="text/javascript">
function closeWinPopup(num) {
	if($("input:checkbox[name=popUp" +num+ "]")) {
		if ($("input:checkbox[name=popUp" +num+ "]").is(":checked") == true) {
			opener.parent.closePopup("popUpYn" + num, "window");
			window.close();
		}
	}
}
</script>
</html>