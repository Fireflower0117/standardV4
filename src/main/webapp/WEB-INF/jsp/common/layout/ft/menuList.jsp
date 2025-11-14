<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>

<c:if test="${fn:length(menuVO.menuList) > 0}">
	<c:forEach items="${menuVO.menuList}" var="depth1" varStatus="status">  
        <li id="li_depth1_<c:out value='${depth1.menuCd}'/>">
            <c:choose>
	        	<c:when test="${depth1.isLeaf eq 0}"> <!-- 자식메뉴가 없을경우 본인의URL 출력 -->
	        		 <a href="<c:out value="${depth1.menuUrlAddr}"/>" target="<c:out value="${depth1.tgtBlankYn}"/>"> 
	        	</c:when>
	        	<c:otherwise>
			        <c:forEach items="${depth1.menuList}" var="depth2">
			           <c:if test="${depth1.menuCd eq depth2.uprMenuCd and depth2.menuSeqo eq 1}"> <!-- 자식의 첫번째 메뉴가 손자가 없을경우 자식 URL출력 -->
			        		<c:choose>
			            	<c:when test="${depth2.isLeaf eq 0}">
			            		 <a href="<c:out value="${depth2.menuUrlAddr}"/>" target="<c:out value="${depth2.tgtBlankYn}"/>">
			            	</c:when>
			            	<c:otherwise>
			            		<c:forEach items="${depth2.menuList}" var="depth3">
						            <c:if test="${depth2.menuCd eq depth3.uprMenuCd and depth3.menuSeqo eq 1}"> <!-- 손자의 첫번째 메뉴가 증손이 없을경우 손자 URL출력 -->
					            		<c:choose>
							            	<c:when test="${depth3.isLeaf eq 0}">
							            		 <a href="<c:out value="${depth3.menuUrlAddr}"/>" target="<c:out value="${depth3.tgtBlankYn}"/>">
							            	</c:when>
							            	<c:otherwise>
							            		<c:forEach items="${depth3.menuList}" var="depth4">
										            <c:if test="${depth3.menuCd eq depth4.uprMenuCd  and depth4.menuSeqo eq 1}"> <!-- 증손중 첫번째 메뉴 URL 출력-->
											             <a href="<c:out value="${depth4.menuUrlAddr}"/>" target="<c:out value="${depth4.tgtBlankYn}"/>">
										            </c:if>
									            </c:forEach>
							            	</c:otherwise>
						            	</c:choose>
						            </c:if>
					            </c:forEach>
			            	</c:otherwise>
			           	</c:choose>
			           </c:if>
			        </c:forEach>
	        	</c:otherwise>
	        </c:choose>
            <c:out value="${depth1.menuNm}"/></a>
            <c:if test="${depth1.lwrTabYn eq 'N'}">
                <ul class="dp2">
            		<c:forEach items="${depth1.menuList}" var="depth2">
            			<c:if test="${depth1.menuCd eq depth2.uprMenuCd}">
                        	<li>	
                        		<c:choose>
									<c:when test="${depth2.isLeaf eq 0}">
										 <a href="<c:out value="${depth2.menuUrlAddr}"/>" target="<c:out value="${depth2.tgtBlankYn}"/>">
									</c:when>
									<c:otherwise>
								        <c:forEach items="${depth2.menuList}" var="depth3">
								           <c:if test="${depth2.menuCd eq depth3.uprMenuCd and depth3.menuSeqo eq 1}">
								        		<c:choose>
								            	<c:when test="${depth3.isLeaf eq 0}">
								            		 <a href="<c:out value="${depth3.menuUrlAddr}"/>" target="<c:out value="${depth3.tgtBlankYn}"/>">
								            	</c:when>
								            	<c:otherwise>	
												    <c:forEach items="${depth3.menuList}" var="depth4">
													    <c:if test="${depth3.menuCd eq depth4.uprMenuCd  and depth4.menuSeqo eq 1}">
													         <a href="<c:out value="${depth4.menuUrlAddr}"/>" target="<c:out value="${depth4.tgtBlankYn}"/>">
													    </c:if>
													</c:forEach>
								            	</c:otherwise>
								           	</c:choose>
								           </c:if>
								        </c:forEach>
									</c:otherwise>
								</c:choose>
								<c:out value="${depth2.menuNm}"/></a>
                        	</li>
                        </c:if>
                    </c:forEach>
                </ul>
        	</c:if>
        </li>
    </c:forEach>
</c:if>
<script>
<%-- 열려 있는 화면이 depth1인 경우 class="on" --%>
$("#li_depth1_" + depth1).addClass("active_on");
</script>