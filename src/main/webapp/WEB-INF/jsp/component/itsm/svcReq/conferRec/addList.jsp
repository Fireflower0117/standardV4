<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp" />
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>

<div class="tbl_top">
	<div class="tbl_left">
		<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }" /></strong> 건</span>
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
			<col style="width: 5%;">
			<col style="width: 14%;">
			<col>
			<col style="width: 7%;">
			<col style="width: 15%;">
			<col style="width: 7%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">서비스 구분</th>
				<th scope="col">회의제목</th>
				<th scope="col">총 참석인원</th>
				<th scope="col">회의일시</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">보기</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) gt 0 }">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td onclick="javascript:fncPageBoard('view', 'view.do', '${result.cofSn}', 'cofSn');" style="cursor: pointer"><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
							<td onclick="javascript:fncPageBoard('view', 'view.do', '${result.cofSn}', 'cofSn');" style="cursor: pointer"><c:out value="${empty result.svcNm ? '-' : result.svcNm }"/></td>
							<td onclick="javascript:fncPageBoard('view', 'view.do', '${result.cofSn}', 'cofSn');" style="cursor: pointer" class="subject ellipsis"><c:out value="${empty result.cofTtl ? '-' : result.cofTtl }"/></td>
							<td onclick="javascript:fncPageBoard('view', 'view.do', '${result.cofSn}', 'cofSn');" style="cursor: pointer"><c:out value="${empty result.attCnt ? '-' : result.attCnt }"/>명</td>
							<td onclick="javascript:fncPageBoard('view', 'view.do', '${result.cofSn}', 'cofSn');" style="cursor: pointer"><c:out value="${empty result.cofDt ? '-' : result.cofDt }"/>&nbsp;<c:out value="${result.cofStaHh }"/>:<c:out value="${result.cofStaMi }"/>&nbsp;~&nbsp;<c:out value="${result.cofEndHh }"/>:<c:out value="${result.cofEndMi }"/></td>
							<td onclick="javascript:fncPageBoard('view', 'view.do', '${result.cofSn}', 'cofSn');" style="cursor: pointer"><c:out value="${empty result.regNm ? '-' : result.regNm }"/></td>
							<td onclick="javascript:fncPageBoard('view', 'view.do', '${result.cofSn}', 'cofSn');" style="cursor: pointer"><c:out value="${empty result.regDt ? '-' : result.regDt }"/></td>
							<td><a href="javascript:void(0);" class="btn btn_down" onclick="fncConferPrint('${result.cofSn}');"><span>회의록 보기</span></a></td>
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
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard" />
	</div>
	<div class="btn_right">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY && grpAuthId eq 'developer' }">
			<a href="javascript:void(0)" class="btn btn_mdl btn_write" onclick="fncPageBoard('write', 'insertForm.do');">등록</a>
		</c:if>
	</div>
</div>



