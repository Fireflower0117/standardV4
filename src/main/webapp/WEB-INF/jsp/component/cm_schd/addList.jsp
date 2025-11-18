<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	space();
	
	<%-- 엑셀 다운로드 --%>
	const cm_fncExcelDown = function(){
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
	}
	
	<%-- no_data colspan 자동 셋팅 --%>
	fncColLength();
	
	<%-- 엑셀 다운로드 --%>
	$('#btn_excel').on('click', function(){
		cm_fncExcelDown();
	});
});
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
    	<button type="button" id="btn_excel" class="btn btn_excel">엑셀 다운로드</button>
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
	<caption>목록(번호, 일정기간, 일정구분, 일정명, 등록자, 등록일으로 구성)</caption>
    <colgroup>
	    <col class="w5p">
	    <col class="w20p">
	    <col class="w10p">
	    <col>
	    <col class="w10p">
	    <col class="w10p">
	</colgroup>
	<thead>
       <tr>
           <th scope="col">번호</th>
           <th scope="col">일정기간</th>
           <th scope="col">일정구분</th>
           <th scope="col">일정명</th>
           <th scope="col">등록자</th>
           <th scope="col">등록일</th>
       </tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr class="cursor" data-serno="<c:out value='${result.schdSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.schdStrtDt += ' ~ ' += result.schdEndDt }"/></td>
						<td>
							<c:choose>
								<c:when test="${result.schdClCd eq 'personal_work' }">
									개인업무
								</c:when>
								<c:when test="${result.schdClCd eq 'department_work' }">
									부서업무
								</c:when>
								<c:when test="${result.schdClCd eq 'company_work' }">
									회사업무
								</c:when>
								<c:when test="${result.schdClCd eq 'meeting' }">
									회의
								</c:when>
								<c:otherwise>
									경영진 일정
								</c:otherwise>
							</c:choose>
						</td>
						<td class="l ellipsis"><c:out value="${result.schdTitlNm }"/></td>
						<td><c:out value="${result.regrNm }"/></td>
						<td><c:out value="${result.regDt }"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="6">데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
</div>
