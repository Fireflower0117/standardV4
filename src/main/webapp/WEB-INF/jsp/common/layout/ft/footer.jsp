<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp" />
<footer id="footer">
	<div class="inner">
		<div class="logo">오픈노트</div>
		<div class="txt">
			<ul>
				<li><a href="#"
					class="blue">개인정보처리방침</a></li>
				<li><a href="#">이메일주소무단수집금지</a></li>
			</ul>
			<div>
				<address>
					<c:if test="${not empty sessionScope.copyright_info.cprgtSerno}">
						<span>(<c:out value="${sessionScope.copyright_info.coPostNo}" />) <c:out
								value="${sessionScope.copyright_info.coAddr += ' ' += sessionScope.copyright_info.coDtlsAddr}" /></span>
						<br/>
						<span>Tel. <c:out value="${sessionScope.copyright_info.coTelNo }" /></span>
						<span>Fax. <c:out value="${sessionScope.copyright_info.coFaxNo }" /> 
						</span>
					</c:if>
				</address>
				<%-- copyright --%>
				<c:out value="${sessionScope.copyright_info.cprgtCtt }"/>
			</div>
		</div>
		<div class="fake_sel footBtn">
			<button type="button" class="btn_site">관련사이트 바로가기</button>
			<div class="family_list_box">
				<div class="family_list mCustomScrollbar">
					<ul>
						<c:choose>
							<c:when test="${fn:length(sessionScope.relSite_info) gt 0}">
								<c:forEach items="${sessionScope.relSite_info }" var="relSite" varStatus="status">
									<li><a <c:if test="${not empty relSite.relSiteUrlAddr}">href='${relSite.relSiteUrlAddr }' target='blank'</c:if>><c:out value="${relSite.relSiteNm }" /></a></li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li class="no_data">등록된 관련사이트가 없습니다.</li>
							</c:otherwise>
						</c:choose> 
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="popup_bg" id="js_popup_bg"></div>
	<div class="loading_wrap entire" style="display: none;">
		<div class="loading_box">
			<svg class="loader" width="79px" height="79px" viewBox="0 0 80 80" xmlns="http://www.w3.org/2000/svg">
		    	<circle class="path" fill="none" stroke-width="8" stroke-linecap="round" cx="40" cy="40" r="25"></circle>
		    </svg>
			<b>loading</b>
		</div>
	</div>
</footer>