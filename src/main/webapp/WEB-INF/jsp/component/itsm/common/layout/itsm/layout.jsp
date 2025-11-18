<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>

<!DOCTYPE HTML>
<html lang="ko-KR">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Pragma" content="no-store" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<title>ITSM</title>
	<link rel="icon" href="${pageContext.request.contextPath}/component/itsm/images/icon/favicon2.ico" type="image/x-icon">

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/font/pretendard.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/font/xeicon/xeicon.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/css/style.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/itsm/css/jquery-ui-1.12.1.custom.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/jquery-ui-1.12.1.custom.js"></script>
	<script src="${pageContext.request.contextPath}/resource/editor/js/HuskyEZCreator.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/cm.validate.js" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/fileDownload.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/highcharts.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/exporting.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/board.js"></script>
	<script src="${pageContext.request.contextPath}/component/itsm/js/atchFile.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/itsm/js/jquery.ui.monthpicker.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/component/itsm/js/ckeditor/ckeditor.js?ver=2"></script>
	<script>
		var depth1 = "${sessionScope.menuCdMap.depth1}";
		var depth2 = "${sessionScope.menuCdMap.depth2}";
		var depth3 = "${sessionScope.menuCdMap.depth3}";
		var depth4 = "${sessionScope.menuCdMap.depth4}";
		var userNm = "${sessionScope.itsm_user_info.userNm}"
	</script>
</head>

<body>
	<div id="skipnavi">
		<a href="#container">▶본문 바로가기</a>
		<a href="#gnb_area">▶주메뉴 바로가기</a>
	</div>
	<div id="wrapper">
	
		<tiles:insertAttribute name="header" />
			<c:choose>
				<c:when test="${not empty sessionScope.menuCdMap.depth0 }">
					<jsp:include page="/WEB-INF/jsp/component/itsm/common/layout/itsm/aside/${not empty sessionScope.itsm_user_info.grpAuthId ? sessionScope.itsm_user_info.grpAuthId : 'default'}.jsp" flush="true"/>
				</c:when>
				<c:otherwise>
					<div id="container">
					<section id="content">
				</c:otherwise>
			</c:choose>
				<div class="inner">
					<tiles:insertAttribute name="body" />
				</div>
			</section>
		</div> <!-- container 의 닫기 태그-->
	</div>


	<div class="popup_bg itemB" id="cmmnLoading">
		<div class="itemB" style="height: 100%;">
			<div class="loading" id="loading03" style="height: 100% !important; background: none; ">
				<p>loading</p>
			</div>
		</div>
	</div>

	<div id="modal_div">
	</div>
	<div class="popup_bg itemB" id="js-popup-bg" onclick="modal_hide_all();"></div>
	<!-- 전체 페이지 로딩 -->
	<div class="loading_wrap" style="display: none;" id="loadingDiv">
		<div class="loading"></div>
	</div>
	<form name="fileDownFrm" id="fileDownFrm">
		<input type="hidden" name="atchFileId" id="downAtchFileId" />
		<input type="hidden" name="fileSeqo" id="downAtchSeqo" />
		<input type="hidden" name="fileRlNm" id="downAtchRlNm" />
	</form>
</body>

</html>