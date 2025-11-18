<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
	
	/* 엑셀다운 */
	$("#btn_excel").click(function(){
		<c:choose>
			<c:when test="${fn:length(resultList) gt 0}">
				fncPageBoard('list','excelDown.do');
			</c:when>
			<c:otherwise>
				alert("데이터가 없습니다.");
				return false;
			</c:otherwise>
		</c:choose>
	});

</script>

<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
    </div>
    <div class="tbl_right">
    	<%--<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel"><span>엑셀 다운로드</span></a>&nbsp;--%>
    	<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:5%;">
            <col style="width:15%;">
            <col style="width:6%;">
            <col style="width:6%;">
            <col style="width:6%;">
            <col style="width:6%;">
            <col style="width:6%;">
            <col>
            <col style="width:6%;">
            <col style="width:10%;">
            <col style="width:10%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">서비스 구분</th>
                <th scope="col">문서 구분</th>
                <th scope="col">영역</th>
                <th scope="col">단계</th>
                <th scope="col">코드</th>
                <th scope="col">문서번호</th>
                <th scope="col">문서이름</th>
                <th scope="col">첨부파일</th>
                <th scope="col">등록자</th>
                <th scope="col">등록일</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
			<c:when test="${fn:length(resultList) gt 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.docSn}', 'docSn');" style="cursor:pointer">
	                <td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
	                <td><c:out value="${empty result.svcNm ? '-' : result.svcNm  }"/></td>
	                <td><c:out value="${result.docGbnNm }"/></td>
	                <td><c:out value="${result.docAreaNm}"/></td>
	                <td><c:out value="${result.docStepNm}"/></td>
	                <td><c:out value="${result.docStepCd}"/></td>
	                <td><c:out value="${result.docNo}"/></td>
	                <td class="ellipsis l"><c:out value="${result.docNm }"/></td>
	                <td onclick="event.cancelBubble=true; fncFilePop('${result.docSn}');"><a href="javascript:void(0)" class="btn btn_down"><span></span></a></td>
	                <td><c:out value="${result.rgtrNm }"/></td>
	                <td><c:out value="${result.regDt }"/></td>
	            </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            <tr class="no_data">
                <td colspan="11">데이터가 없습니다.</td>
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


