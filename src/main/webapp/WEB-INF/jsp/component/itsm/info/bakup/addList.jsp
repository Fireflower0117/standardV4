<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>


<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
    </div>
    <div class="tbl_right">
    	<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel"  onclick="fncExcel('${paginationInfo.totalRecordCount }')"><span>엑셀 다운로드</span></a>&nbsp;
    	<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:5%;">
            <col style="width:12%;">
            <col style="width:7%;">
            <col>
            <col style="width:10%;">
            <col style="width:7%;">
            <col style="width:7%;">
            <col style="width:10%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">서비스 구분</th>
                <th scope="col">백업 구분</th>
                <th scope="col">백업파일경로</th>
                <th scope="col">용량</th>
                <th scope="col">처리여부</th>
                <th scope="col">소요시간</th>
                <th scope="col">백업일</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
			<c:when test="${fn:length(resultList) gt 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.bakSn}', 'bakSn');" style="cursor:pointer">
	                <td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
	                <td><c:out value="${empty result.svcNm ? '-' : result.svcNm  }"/></td>
	                <td><c:out value="${result.autoYn eq 'Y' ? '자동' : '수동' }"/></td>
	                <td><c:out value="${result.bakPath }"/></td>
	                <td><c:out value="${result.bakVol }MB"/></td>
	                <td><c:out value="${result.bakYn eq 'Y' ? '완료' : result.bakYn eq 'F' ?  '실패' : result.bakYn eq 'N' ? '처리중' : '-'} "/></td>
	                <td><c:out value="${result.bakTime }초"/></td>
	                <td><c:out value="${result.regDt }"/></td>
	            </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            <tr class="no_data">
                <td colspan="8">데이터가 없습니다.</td>
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
        <a href="javascript:void(0);" class="btn btn_mdl btn_list" onclick="fncPopSchedule()">주기설정</a>
        <a href="javascript:void(0);" class="btn btn_mdl btn_write" onclick="fncPopBackup()">실행</a>
	</div>
</div>