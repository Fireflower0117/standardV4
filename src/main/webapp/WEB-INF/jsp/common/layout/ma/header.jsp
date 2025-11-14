<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<header id="header" class="header_leftfix">
	<div class="header_inner">
		<div class="sidebyside">
			<h1 class="logo">
				<c:choose>
					<c:when test="${empty logoInfo.LGHD.atchFileId}">
						<strong style="color: white; margin-left: 20px; font-size: 20px;">표준안</strong>
					</c:when>
					<c:otherwise>
						<a style="cursor: <c:out value="${logoInfo.LGHD.lnkYn eq 'Y' ? 'pointer' : 'default'}"/>" href="<c:out value="${logoInfo.LGHD.lnkYn eq 'Y' ? logoInfo.LGHD.url : 'javascript:void(0)'}"/>" target="<c:out value="${logoInfo.LGHD.lnkTgtCd eq 'blank' ? '_blank' : '' }"/>">
							<img src="/file/getByteImage.do?atchFileId=<c:out value='${logoInfo.LGHD.atchFileId}'/>&fileSeqo=<c:out value='${logoInfo.LGHD.fileSeqo}'/>&fileNmPhclFileNm=<c:out value='${logoInfo.LGHD.fileNmPhclFileNm}'/>" alt="로고"> 
						</a>  
					</c:otherwise>
				</c:choose>
			</h1>
			<div class="right">
				<a href="/itsm/login.do" class="btn_itsm" target="_blank">ITSM</a>
				<div class="utils">
					<span class="user_info" id="header_userNm"><strong class="user_name"><c:out value="${sessionScope.ma_user_info.userNm}"/>님</strong></span>
					<a href="/ma/logout.do" class="btn_logout">로그아웃</a>
				</div>
			</div>
		</div>
	</div>
</header> 
<jsp:include page="/WEB-INF/jsp/common/layout/ma/menuList/${sessionScope.ma_user_info.grpAuthId}.jsp" flush="true"/> 