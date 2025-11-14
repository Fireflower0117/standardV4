<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<aside id="lnb">
	<c:if test="${fn:length(menuVO.menuList) > 0}">
		<c:forEach items="${menuVO.menuList}" var="depth1">  
			<c:if test="${depth1.isLeaf eq 1}">
		   	 	<h3 class="lnb_title box_depth1_<c:out value='${depth1.menuCd}'/>" style="display: none;"><c:out value="${depth1.menuNm}"/></h3> 
			    <ul class="box_depth1_<c:out value='${depth1.menuCd}'/>" style="display: none;">
			    	<c:forEach items="${depth1.menuList}" var="depth2">  
			    		<c:if test="${depth1.menuCd eq depth2.uprMenuCd}">
					        <li class="${depth2.isLeaf eq 1 and depth2.lwrTabYn eq 'N' ? 'has_sub' : ''}" id="li_depth2_<c:out value="${depth2.menuCd}"/>">
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
				       			<c:if test="${depth2.isLeaf eq 1}">
									<ul>
								    	<c:forEach items="${depth2.menuList}" var="depth3">
								      		<c:if test="${depth2.menuCd eq depth3.uprMenuCd}">
									        	<li id="li_depth3_<c:out value="${depth3.menuCd}"/>">
									               <c:choose>
														<c:when test="${depth3.isLeaf eq 0}">
															<a href="<c:out value="${depth3.menuUrlAddr}"/>" target="<c:out value="${depth3.tgtBlankYn}"/>">
														</c:when>
														<c:otherwise>
													        <c:forEach items="${depth3.menuList}" var="depth4">
													           <c:if test="${depth3.menuCd eq depth4.uprMenuCd and depth4.menuSeqo eq 1}">
													        		<a href="<c:out value="${depth4.menuUrlAddr}"/>" target="<c:out value="${depth4.tgtBlankYn}"/>">
													           </c:if>
													        </c:forEach>
														</c:otherwise>
													</c:choose>
													<c:out value="${depth3.menuNm}"/></a>
													<c:if test="${depth3.lwrTabYn eq 'Y'}">
														<c:set var="tabList" value="${depth3.menuList}"/>
										       		</c:if>
									           	</li>
									        </c:if>
								        </c:forEach>
								    </ul>
						   		</c:if>
					        </li>
				        </c:if>
			        </c:forEach>
			    </ul>
		   	</c:if>
	    </c:forEach>
    </c:if>
</aside>

<c:if test="${fn:length(menuVO.tabList) > 0}">
	<div class="tab wide mar_b15"  id="tab_box" style="display: none;">
		<ul class="tab_menu js_tmenu" role="tablist" >
			<c:forEach var="tab" items="${menuVO.tabList}" varStatus="status">
					<li id="tab1_0<c:out value="${status.count}"/>" class="tab_uprMenuCd_<c:out value="${tab.uprMenuCd}"/> tab_menuCd_<c:out value="${tab.menuCd}"/>" style="display: none" role="tab"><a href="<c:out value="${tab.menuUrlAddr}"/>" target="<c:out value="${tab.tgtBlankYn}"/>"><c:out value="${tab.menuNm}"/></a></li>
			</c:forEach>
		</ul>
	</div>
</c:if>


<script>

<%-- URL 해당하는 메뉴 show/on --%>
$(".box_depth1_"+depth1).show();
$("#li_depth2_"+depth2).addClass("on");
$("#li_depth3_"+depth3).addClass("on");

<%-- URL에 해당하는 tabList show / on --%>
if($(".tab_uprMenuCd_"+depth4).length){
	$(".tab_uprMenuCd_"+depth4).show();
	$("#tab_box").show();
}else if($(".tab_uprMenuCd_"+depth3).length){
	$(".tab_uprMenuCd_"+depth3).show();
	$("#tab_box").show();
}else if($(".tab_uprMenuCd_"+depth2).length){
	$(".tab_uprMenuCd_"+depth2).show();
	$("#tab_box").show();
}
if($(".tab_menuCd_"+depth4).length){
	$(".tab_menuCd_"+depth4).addClass("on");
}else if($(".tab_menuCd_"+depth3).length){
	$(".tab_menuCd_"+depth3).addClass("on");
}else if($(".tab_menuCd_"+depth2).length){
	$(".tab_menuCd_"+depth3).addClass("on");
}

$(document).ready(function(){
	$(".tab_menu li a").on("click", function(){
		location.href= $(this).attr("href");
	})
}); 

</script>