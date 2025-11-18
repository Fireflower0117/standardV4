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
	return false;
}

$(document).ready(function(){
    
	<%-- no_data 처리 --%>
	fncColLength();
	
	<c:if test="${fn:length(resultList) > 0 }">
	   	$('.board_list tbody tr td, a.td_view').not(".srvy_not_view").on('click', function(){
	   	 	fncPageBoard('update', 'updateForm.do', String($(this).closest('tr').data('srvyserno')), 'srvySerno');
            return false;
	   	});
   	</c:if>
        
    <%-- 설문결과 보기 --%>
    $(".btn_result_pop").on("click", function () {
    	fncResultPop($(this).parent().parent().data("srvyserno"));
    });
    
    <%-- 설문지 보기 --%>
    $(".btn_view_pop").on("click", function () {
    	fncFormSubmit($(this).parent().parent().data("srvyserno"));
    });
    
    <%-- 등록 --%>
    $("#btn_srvy_write").on("click", function () {
    	fncPageBoard('write', 'insertForm.do');
    });
    
    <%-- 엑셀 다운로드 --%>
	$('#btn_excel').on('click', function(){
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				fncPageBoard("view", "excelDownload.do");
				$("#defaultFrm").attr("onsubmit","return false;");
			</c:when>
			<c:otherwise>
				alert("데이터가 없습니다");
				return false;
			</c:otherwise>
		</c:choose>	
	});
});
</script>
<div class="board_top">
	<div class="tbl_left">
		<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
	<div class="board_right">
	    <button class="btn btn_excel" id="btn_excel">엑셀 다운로드</button>
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
    <caption>목록(번호,상태,설문제목,설문기간,게시여부,설문지보기,결과확인,등록자,등록일 등으로 구성)</caption>
    <colgroup>
        <col class="w4p">
        <col class="w6p">
        <col>
        <col class="w10p">
        <col class="w6p">
        <col class="w6p">
        <col class="w6p">
        <col class="w6p">
        <col class="w6p">
    </colgroup>
    <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">상태</th>
            <th scope="col">설문 제목</th>
            <th scope="col">설문 기간</th>
            <th scope="col">게시 여부</th>
            <th scope="col">설문 확인</th>
            <th scope="col">결과 확인</th>
            <th scope="col">등록자</th>
            <th scope="col">등록일</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${fn:length(resultList) > 0}">
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr data-srvyserno="<c:out value="${result.srvySerno}"/>">
                        <td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.currentPageNo-1) * searchVO.recordCountPerPage + status.count)}"/></td>
                        <td><span class="state ${result.srvyIng eq '대기' ? 'gray' : result.srvyIng eq '진행중' ? 'blue' : 'black' }"><c:out value="${result.srvyIng}"/></span></td>
                        <td class="l ellipsis"><a href="#" class="ellipsis td_view"><span><c:out value="${result.srvyNm}"/></span></a></td>
                        <td><c:out value="${result.srvyStrtDt }~${result.srvyEndDt }"/></td>
                        <td><c:out value="${result.srvySts eq 'Y' ? '게시' : '미게시'}"/></td>
                        <td class="srvy_not_view" style="cursor:default;"><button type="button" class="btn_view_pop btn sml">설문 보기</button></td>
                        <td class="srvy_not_view" style="cursor:default;"><button type="button" class="btn_result_pop btn sml">설문 확인</button></td>
                        <td><c:out value="${result.regrNm }"/></td>
                        <td><c:out value="${result.regDt }"/></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td class="no_data">데이터가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
<div class="paging_wrap">
    <div class="paging">
    	<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard" />
    </div>
    <div class="btn_right">
    	<button type="button" class="btn blue"  id="btn_srvy_write">등록</button>
	</div>
</div>