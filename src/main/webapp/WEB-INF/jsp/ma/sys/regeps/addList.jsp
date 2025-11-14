<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- 대용량 엑셀 다운로드 --%>
	const fncBigExcelDown = function(){
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">	
				fncLoadingStart();
				$.fileDownload("bigExcelDownload.do", {
					httpMethod : "POST",
					data : $("#defaultFrm").serialize(),
					successCallback : function(url){
						fncLoadingEnd();
						return false;
					}, 
					failCallback : function(responseHtml, url, error){
						alert("엑셀 다운로드가 실패하였습니다");
						fncLoadingEnd();
						return false;
					}
				});
			</c:when>
			<c:otherwise>
				alert("데이터가 없습니다");
				return false;
			</c:otherwise>
		</c:choose>
	}
	<%-- 기존 다운로드 --%>
	const fncExcelDown = function(){
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
	
	<c:if test="${fn:length(resultList) > 0 }">
		<%-- tr 클릭시 상세페이지 이동 --%>
		$('.board_list tbody tr, a.td_view').on('click', function(){
			 fncPageBoard('update', 'updateForm.do', String($(this).closest('tr').data('serno')), 'regepsSerno');
			 return false;
		});
	</c:if>
	
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<%-- 등록버튼 클릭시 --%>
		$('.btn_write').on('click', function(){
			fncPageBoard('write', 'insertForm.do');
		});
	</c:if>
	
	<%-- 엑셀 다운로드 --%>
	$('#btn_big_excel').on('click', function(){
		fncBigExcelDown();
		
	});
	$('#btn_excel').on('click', function(){
		fncExcelDown();
	});
	
	<%-- 정규표현식 테스트 클릭시 --%>
	$('#btn_test').on('click', function(){
		fncRegepsTest();
	});
});

</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
    	<button type="button" id="btn_big_excel" class="btn btn_excel">대용량 엑셀 다운로드</button>
    	<button type="button" id="btn_excel" class="btn btn_excel">엑셀 다운로드</button>
    	<button type="button" id="btn_test" class="btn green">정규표현식 테스트</button>
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
	<caption>목록(정규표현식ID, 정규표현식명, 정규표현식텍스트, 등록자, 등록일로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col/>
		<col class="w10p"/>
		<col/>
		<col class="w10p"/>
		<col class="w10p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">정규표현식ID</th>
			<th scope="col">정규표현식명</th>
			<th scope="col">정규표현식텍스트</th>
			<th scope="col">등록자</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr class="cursor" data-serno="<c:out value='${result.regepsSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l ellipsis">
			                <a href="#" class="ellipsis td_view"><c:out value="${result.regepsId }"/></a>
			            </td>
						<td class="l"><c:out value="${result.regepsNm }"/></td>
						<td class="l ellipsis"><c:out value="${result.regepsTxt }"/></td>
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
	<div class="btn_right">
		<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
			<button type="button" class="btn blue btn_write">등록</button>
		</c:if>
	</div>
</div>
