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
	<c:choose>
		<c:when test="${not empty logoInfo.LGFC.atchFileId}">
			<link rel="icon" href="/file/getByteImage.do?atchFileId=<c:out value='${logoInfo.LGFC.atchFileId}'/>&fileSeqo=<c:out value='${logoInfo.LGFC.fileSeqo}'/>&fileNmPhclFileNm=<c:out value='${logoInfo.LGFC.fileNmPhclFileNm}'/>" type="image/x-icon">
		</c:when>
		<c:otherwise>
			<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/ft/images/common/logo.png" type="image/x-icon">
		</c:otherwise>
	</c:choose>
<%-- 	<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>${logo.value.imgPath }" type="image/x-icon"> --%>
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/jquery-ui-1.12.1.custom.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/basic.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/board.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/common.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/lib/simplebar/simplebar.min.css">
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery-ui-1.12.1.custom.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/common.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/cm.validate.js" charset="utf-8"></script>
    <script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/basic.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/board.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/atchFile.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/fileDownload.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/lib/simplebar/simplebar.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/ckeditor/ckeditor.js?ver=2"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/html2canvas.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/clipboard.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		<%-- 단위테스트용 함수 호출 --%>
		$(function(){
			$(document).on("click",".page_title",function(){
				fncSetTestInput();
			});
		});

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
			<section id="content">
				<tiles:insertAttribute name="body"/>
			</section>
		</div>
		<footer id="footer">
			<div class="loading_wrap entire" style="display: none;">
			    <div class="loading_box">
			        <svg class="loader" width="79px" height="79px" viewBox="0 0 80 80" xmlns="http://www.w3.org/2000/svg">
			            <circle class="path" fill="none" stroke-width="8" stroke-linecap="round" cx="40" cy="40" r="25"></circle>
			        </svg>
			        <b>loading</b>
			    </div>
			</div>
		</footer>
	</div>
	<form name="fileDownFrm" id="fileDownFrm">
		<input type="hidden" name="atchFileId" id="downAtchFileId"/>
		<input type="hidden" name="fileSeqo" id="downAtchSeqo"/>
		<input type="hidden" name="fileRlNm" id="downAtchRlNm"/>
		<input type="hidden" name="fileNmPhclFileNm" id="downAtchPhclNm" />
	</form>
</body>
</html>