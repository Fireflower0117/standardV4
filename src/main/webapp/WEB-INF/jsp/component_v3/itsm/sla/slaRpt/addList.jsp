<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">

function fncSlaReport(svcSn, bgngDt, ttl){
    fncAjax('rptPop.do', {"svcSn" : svcSn, "bgngYm" : bgngDt, "rptdTtl" : ttl}, 'html', true, '', function(data){
        modal_show('1200px', '900px', data);
    });
}

</script>

<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
    </div>
    <div class="tbl_right">
        <a href="javascript:void(0);" class="btn btn_sml btn_update" onclick="fncUpdatePop()"><span>수동 업데이트</span></a>
    	<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width: 6%;">
            <col style="width: 15%;">
            <col>
            <col style="width: 15%;">
            <col style="width: 15%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">서비스 구분</th>
                <th scope="col">제목</th>
                <th scope="col">기간</th>
                <th scope="col">보기</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
			<c:when test="${fn:length(resultList) gt 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr style="cursor:default;">
	                <td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
                    <td><c:out value="${empty result.svcNm ? '-' : result.svcNm }"/></td>
                    <td class="l"><c:out value="${result.rptdTtl}"/></td>
                    <td>${result.bgngDt} ~ ${result.endDt}</td>
                    <td><a href="javascript:void(0);" class="btn btn_down" onclick="fncSlaReport('${result.svcSn}','${result.bgngDt}', '${result.rptdTtl}')"><span>보고서 보기</span></a></td>
	            </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            <tr class="no_data">
                <td colspan="5">데이터가 없습니다.</td>
            </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<div class="paging_wrap">
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</div>
	<div class="btn_right">
	</div>
</div>
