<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<nav id="gnb" class="leftfix">
    <ul class="gnb js_gnb">
    	<c:if test="${fn:length(menuVO.menuList) > 0 }">
			<c:forEach items="${menuVO.menuList}" var="depth1" varStatus="status">  
		        <li id="li_depth1_<c:out value="${depth1.menuCd}"/>" data-menunm="${depth1.menuNm}"> 
			        <c:choose>
			        	<c:when test="${depth1.isLeaf eq 0}"> <%-- 자식메뉴가 없을경우 본인의URL 출력 --%>
			        		 <a href="<c:out value="${depth1.menuUrlAddr}"/>" target="<c:out value="${depth1.tgtBlankYn}"/>"> 
			        	</c:when>
			        	<c:otherwise>
					        <c:forEach items="${depth1.menuList}" var="depth2">
					           <c:if test="${depth1.menuCd eq depth2.uprMenuCd and depth2.menuSeqo eq 1}"> <%-- 자식의 첫번째 메뉴가 손자가 없을경우 자식 URL출력 --%>
					        		<c:choose>
					            	<c:when test="${depth2.isLeaf eq 0}">
					            		 <a href="<c:out value="${depth2.menuUrlAddr}"/>" target="<c:out value="${depth2.tgtBlankYn}"/>">
					            	</c:when>
					            	<c:otherwise>
					            		<c:forEach items="${depth2.menuList}" var="depth3">
								            <c:if test="${depth2.menuCd eq depth3.uprMenuCd and depth3.menuSeqo eq 1}"> <%-- 손자의 첫번째 메뉴가 증손이 없을경우 손자 URL출력 --%>
							            		<c:choose>
									            	<c:when test="${depth3.isLeaf eq 0}">
									            		 <a href="<c:out value="${depth3.menuUrlAddr}"/>" target="<c:out value="${depth3.tgtBlankYn}"/>">
									            	</c:when>
									            	<c:otherwise>
									            		<c:forEach items="${depth3.menuList}" var="depth4">
												            <c:if test="${depth3.menuCd eq depth4.uprMenuCd  and depth4.menuSeqo eq 1}"> <%-- 증손중 첫번째 메뉴 URL 출력--%>
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
		            <span class="gnb_i0<c:out value='${status.count}'/>"></span><c:out value="${depth1.menuNm}"/></a> 
		            <c:if test="${depth1.isLeaf eq 1}">
				        <div class="subwrap js_subwrap">
						  	<ul class="deps2">
				        	<c:forEach items="${depth1.menuList}" var="depth2">
				        		<c:if test="${depth1.menuCd eq depth2.uprMenuCd}">
						            <li id="li_depth2_<c:out value="${depth2.menuCd}"/>" class="<c:out value="${depth2.menuCd eq 'bltnb' or depth2.isLeaf eq 1 ? 'has_sub' : ''}"/>" data-menunm="<c:out value="${depth2.menuNm}"/>">
						            <c:choose> 
						            	<c:when test="${depth2.menuCd eq 'bltnb' and fn:length(menuBltnbList) > 0 }">
											<c:set var="firstCheck" value=""/>
											<c:forEach items="${menuBltnbList}" var="bltnb">
					                    		<c:if test="${bltnb.isLeaf eq 0 and firstCheck ne 'check'}">
													<a href="<c:out value="${bltnb.menuUrlAddr}"/>" target="<c:out value="${bltnb.tgtBlankYn}"/>">
					                    			<c:set var="firstCheck" value="check"/>
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
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
										</c:otherwise>
									</c:choose>
									<c:out value="${depth2.menuNm}"/></a>
									<c:choose>
										<c:when test="${depth2.menuCd eq 'bltnb' and fn:length(menuBltnbList) > 0 }"><%-- 공통게시판인 경우depth3 바로 출력 --%>
											<ul class="deps3">
												<c:forEach items="${menuBltnbList}" var="bltnb">
													<c:if test="${bltnb.isLeaf eq 0}">
									                	<li id="li_depth3_<c:out value="${bltnb.menuCd}"/>" data-menunm="<c:out value="${bltnb.menuNm}"/>">
															<a href="<c:out value="${bltnb.menuUrlAddr}"/>" target="<c:out value="${bltnb.tgtBlankYn}"/>">
															<c:out value="${bltnb.menuNm}"/></a>
									                    </li>
								                    </c:if>
												</c:forEach>
					                    	</ul>
										</c:when>
										<c:when test="${depth2.isLeaf eq 1}">
					                        <ul class="deps3">
							                    <c:forEach items="${depth2.menuList}" var="depth3">
							                    	<c:if test="${depth2.menuCd eq depth3.uprMenuCd}">
							                    		<li id="li_depth3_<c:out value="${depth3.menuCd}"/>" data-menunm="<c:out value="${depth3.menuNm}"/>">
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
							                    		</li>
						                        	</c:if>
						                        </c:forEach>
					                    	</ul>
						                	</c:when>
					                	</c:choose>
						            </li>
					            </c:if>
				            </c:forEach>
							</ul>
						</div>
		            </c:if>
		        </li>
	        </c:forEach>
		</c:if>
    </ul>
</nav>

<div id="container">
				<div class="page_top">
					<h2 class="page_title"></h2>
					<ul class="breadcrumb">
					</ul>
				</div>
				<c:if test="${fn:length(menuVO.tabList) > 0}">
					<div class="tab wide mar_b15 mar_t15" id="tab_box" style="display: none;">
						<ul class="tab_menu js_tmenu" role="tablist" >
							<c:forEach var="tab" items="${menuVO.tabList}" varStatus="status">
								<li id="tab1_0<c:out value="${status.count}"/>" class="tab_uprMenuCd_<c:out value="${tab.uprMenuCd}"/> tab_menuCd_<c:out value="${tab.menuCd}"/>" data-menunm="<c:out value="${tab.menuNm}"/>" style="display: none" role="tab"><a href="<c:out value="${tab.menuUrlAddr}"/>" target="<c:out value="${tab.tgtBlankYn}"/>"><c:out value="${tab.menuNm}"/></a></li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
				
<script>
var depthLi1 = "";
var depthLi2 = "";
var depthLi3 = "";
var depthLi4 = "";

var depthNm1 = "";
var depthNm2 = "";
var depthNm3 = "";
var depthNm4 = "";

<%-- breadcrumb 지정 --%>
if($(".tab_menuCd_"+depth4).length){
	depthLi4 = "<li class='last'>" + $(".tab_menuCd_"+depth4).data("menunm") + "</li>";
	depthNm4 = $(".tab_menuCd_"+depth4).data("menunm")
}

var lastCheck3 = depthLi4 == "" ? "last" : "";
if($("#li_depth3_" + depth3).length){ 
	depthLi3 = "<li class='" + lastCheck3 + "'>" + $("#li_depth3_" + depth3).data("menunm") + "</li>";
	depthNm3 = $("#li_depth3_" + depth3).data("menunm");
}else if($(".tab_menuCd_" + depth3).length){
	depthLi3 = "<li class='" + lastCheck3 + "'>" + $(".tab_menuCd_" + depth3).data("menunm") + "</li>";
	depthNm3 = $(".tab_menuCd_"+depth3).data("menunm");
}

var lastCheck2 = depthLi3 == "" ? "last" : "";
if($("#li_depth2_" + depth2).length){
	depthLi2 = "<li class='" + lastCheck2 + "'>" + $("#li_depth2_" + depth2).data("menunm") + "</li>";
	depthNm2 = $("#li_depth2_" + depth2).data("menunm");
}else if($(".tab_menuCd_" + depth2).length){
	depthLi2 = "<li class='" + lastCheck2 + "'>" + $(".tab_menuCd_" + depth2).data("menunm") + "</li>";
	depthNm2 = $(".tab_menuCd_"+depth2).data("menunm");
}

var lastCheck1 = depthLi2 == "" ? "last" : "";
if($("#li_depth1_" + depth1).length){
	depthLi1 = "<li class='" + lastCheck1 + "'>" + $("#li_depth1_" + depth1).data("menunm") + "</li>";
	depthNm1 = $("#li_depth1_" + depth1).data("menunm");
}

var liList = "<li class='home'><i class='xi-home'></i></li>";
liList += depthLi1 + depthLi2 + depthLi3 + depthLi4;
$(".breadcrumb").html(liList);

<%-- pageTitle 지정 --%>
var pageTitle = depthNm4;
pageTitle = pageTitle == "" ? depthNm3 : pageTitle;
pageTitle = pageTitle == "" ? depthNm2 : pageTitle;
pageTitle = pageTitle == "" ? depthNm1 : pageTitle;
$(".page_title").html(pageTitle);

<%-- 메인화면에서는 class="main_type" 서브화면에서는 class="sub_type" --%>
if(depth2 != null && depth2 != ""){
	$("#gnb").addClass("main_type");
}else{
	$("#gnb").addClass("sub_type");
}
<%-- 서브화면에서 열려 있는 화면의 depth1인 경우 class="visible" --%>
$("#li_depth1_" + depth1).addClass("visible");

<%-- 서브화면에서 열려 있는 화면의 depth2인 경우 class="active open" --%>
$("#li_depth2_" + depth2).addClass("active");
$("#li_depth2_" + depth2).addClass("open");

<%-- 서브화면에서 열려 있는 화면의 depth3인 경우 class="on" --%>
$("#li_depth3_" + depth3).addClass("on");

<%-- URL에 해당하는 tabList show --%>
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
<%-- URL에 해당하는 tabList on --%>
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