<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
    </div>
    <div class="tbl_right">
    	<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel" onclick="fncExcel('${paginationInfo.totalRecordCount }')"><span>엑셀 다운로드</span></a>&nbsp;
    	<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:5%;">
            <col style="width:13%;">
            <col style="width:7%;">
            <col>
            <col style="width:10%;">
            <col style="width:9%;">
            <col style="width:8%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">서비스구분</th>
                <th scope="col">요청구분</th>
                <th scope="col">제목</th>
                <th scope="col">요청자</th>
                <th scope="col">요청일</th>
                <th scope="col">답변유무</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
			<c:when test="${fn:length(resultList) gt 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.qnaSn}', 'qnaSn');" style="cursor:pointer">
	                <td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
					<td><c:out value="${empty result.svcNm ? '-' : result.svcNm }"/></td>
					<td>
						<p class="${result.dmndCdNm eq '일반' ? 'gnr rq_dv' : result.dmndCdNm eq '긴급' ? 'emg rq_dv' : result.dmndCdNm eq '중요' ? 'imp rq_dv' : '-' }">
							<c:out value="${empty result.dmndCdNm ? '-' : result.dmndCdNm }"/>
						</p>
					</td>
	                <td class="subject ellipsis">
	                	<c:out value="${result.dmndTtl }"/>
<%-- 	                	${result.comCnt gt 0 ? ['+result.comCn+'] : ''} --%>
 	                	<c:choose>
	                		<c:when test="${result.cmntCnt gt 0 }">
	                			[${result.cmntCnt }]
	                		</c:when>
	                		<c:otherwise>
	                		</c:otherwise>
	                	</c:choose> 
						<c:if test="${result.newCmntCnt gt 0 }">
							&nbsp;<p class="new">new</p>
						</c:if>
	                </td>
	                <td><c:out value="${empty result.rqstrNm ? '-' : result.rqstrNm }"/></td>
	                <td><c:out value="${empty result.regDt ? '-' : result.regDt }"/></td>
	                <td>
						<c:choose>
							<c:when test="${result.cmntCnt > 0}">
								답변
							</c:when>
							<c:otherwise>
								미답변
							</c:otherwise>
						</c:choose>
	                </td>
	            </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            <tr class="no_data">
                <td colspan="7">데이터가 없습니다.</td>
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
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<a href="javascript:void(0);" class="btn btn_mdl btn_write" onclick="fncPageBoard('write', 'insertForm.do');">등록</a>
		</c:if>
	</div>
</div>
