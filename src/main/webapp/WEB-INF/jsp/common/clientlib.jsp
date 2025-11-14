<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>   

<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/internal/project/images/common/favicon.png" type="image/x-icon">

<!-- 외부에가 가져온 라이브러리 --> 
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/ckeditor/ckeditor.js?ver=1"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/html2canvas/html2canvas.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/clipboard/clipboard.min.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/sha/sha512.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/simplebar/simplebar.min.js"></script>   
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/swiper/swiper-bundle.min.js"></script> 
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/aos/aos.js"></script>
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.css">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/aos/aos.css">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/swiper/swiper-bundle.min.css">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/simplebar/simplebar.min.css"> 


<!-- 오픈노트 표준 라이브러리 -->
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/css/basic.css">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/css/board.css">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/css/common.css">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/css/member.css">  
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/js/cm.validate.js"></script> 
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/js/basic.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/js/board.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/js/atchFile.js"></script>  
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/js/common.js"></script> 
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/js/clientbase.js"></script> 

<!-- 프로젝트에서 생성한 라이브러리 -->
<!--script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/project/........"></script -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>