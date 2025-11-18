<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
<%-- 설문지 보기 --%>
const fncFormSubmit = function (srvySerno) {
	window.open("ViewPop", "ViewPop", "width=830, height=780, top=50, left=200, scrollbars=yes");
	$("#srvySerno").val(srvySerno);

	$("#defaultFrm").attr({"action" : "viewPop.do", "method" : "POST", "target" : "ViewPop", "onsubmit" : ""}).submit();
	return false;
};

<%-- 설문 결과 보기 --%>
const fncResultPop = function(srvySerno) {
	$("#srvySerno").val(srvySerno);
	$("#defaultFrm").attr({"action" : "resultPop.do", "method" : "POST", "target" : "_self", "onsubmit" : ""}).submit();
}

$(document).ready(function(){
    
    <%-- 설문지 보기 --%>
    $(".btn_view_pop").on("click", function () {
    	fncFormSubmit($(this).parent().parent().data("srvyserno"));
    });
    
    <%-- 설문결과 보기 --%>
    $(".btn_result_pop").on("click", function () {
    	fncResultPop($(this).parent().parent().data("srvyserno"));
    });
});
    
    
</script>
<div class="board_top">
	<div class="tbl_left">
		<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
	<div class="board_right">
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<ul class="survey_list">
	<c:choose>
	<c:when test="${fn:length(resultList) > 0}">
		<c:forEach var="result" items="${resultList}" varStatus="status">
		    <li>
		        <a href="javascript:void(0);" style="cursor:default;" data-srvyserno="<c:out value="${result.srvySerno}"/>">
		            <div class="survey_top">
		                <span class="state ${result.srvyIng eq '진행중' ? 'blue' : 'gray' }"><c:out value="${result.srvyIng }"/></span>
		                <p class="tit ellipsis"><c:out value="${result.srvyNm}"/></p>
		                <p class="exp"><c:out value="${result.srvyExpl}"/></p>
		            </div>
		            <div class="survey_mdl">
		            	<span class="info">
		                </span>
		            </div>
		            <div class="survey_btm">
		                <span class="date"><i class="xi-calendar"></i><c:out value="${result.srvyStrtDt }~${result.srvyEndDt }"/></span>
		                <c:choose>
 							<c:when test="${result.srvyIng eq '진행중' and not empty searchVO.ftLoginSerno }">
 								<c:if test="${result.srvyAnsCnt < 1 }">
	 								<button type="button" class="btn sml blue btn_view_pop">설문 참여</button>
 								</c:if>
 								<c:if test="${result.srvyAnsCnt > 0 }">
 									<span class="btn sml gray" style="cursor:default;">참여 완료</span>
 								</c:if>
 							</c:when>
 							<c:when test="${result.srvyIng eq '종료'}">
 								<button type="button" class="btn sml black btn_result_pop">설문 결과</button>
 							</c:when>
 						</c:choose>
		            </div>
		        </a>
		    </li>
	    </c:forEach>
	    </c:when>
		<c:otherwise>
			<li class="no_data">
				등록된 설문조사가 없습니다
			</li>
		</c:otherwise>
	</c:choose>
</ul>
<div class="paging_wrap">
    <div class="paging">
    	<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard" />
    </div>
</div>

