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
			 fncPageBoard('update', 'updateForm.do', String($(this).closest('tr').data('serno')), 'userSerno');
			 return false;
		});
	</c:if>
	
	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
		<%-- 잠금 해제 클릭시 --%>
		$('#btn_unlock').on('click', function(){
			fncUserUnlock();
		});
	</c:if>

	<%-- 엑셀 다운로드 --%>
	$('#btn_big_excel').on('click', function(){
		fncBigExcelDown();
		
	});
	$('#btn_excel').on('click', function(){
		fncExcelDown();
	});
	
	<%-- 체크박스 체크 유지 --%>
	fncPageMoveCheckSet();
	
	<%-- 전체선택 클릭시 --%>
	$('#allChk').on('click', function(){
		fncCheckAll($(this));
	});
	
	<%-- 체크박스 부모 td 클릭시 이벤트 막기 --%>
	$('input[type="checkbox"][id^="cbx_"]').parents('td').on('click', function(e){
		e.stopPropagation();
	});
	
	<%-- 체크박스 클릭시 --%>
	$('input[type="checkbox"][id^="cbx_"]').on('change', function(e) {
		fncCheckAction($(this));
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
    	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
			<button type="button" id="btn_unlock" class="btn blue"><i class="xi-unlock"></i>잠금해제</button>
		</c:if>
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
	<caption>목록(번호, 아이디, 이름, 전화번호, 이메일, 권한, 차단여부, 사용여부, 잠금여부로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col/>
		<col class="w20p"/>
		<col class="w10p"/>
		<col class="w20p"/>
		<col class="w10p"/>
		<col class="w5p"/>
		<col class="w5p"/>
		<col class="w5p"/>
		<col class="w5p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">아이디</th>
			<th scope="col">이름</th>
			<th scope="col">전화번호</th>
			<th scope="col">이메일</th>
			<th scope="col">권한</th>
			<th scope="col">차단여부</th>
			<th scope="col">사용여부</th>
			<th scope="col">잠금여부</th>
			<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
				<th scope="col"><span class="chk"><span class="cbx"><input type="checkbox" id="allChk" name="allChk"/><label for="allChk"></label></span></span></th>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr class="cursor" data-serno="<c:out value='${result.userSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="ellipsis">
			                <a href="#" class="ellipsis td_view"><c:out value="${result.userId }"/></a>
			            </td>
						<td><c:out value="${result.userNm }"/>
			            </td>
						<td><c:out value="${util:getDecryptAES256HyPhen(result.userTelNo) }"/></td>
						<td class="ellipsis"><c:out value="${result.userEmailAddr }"/></td>
			            <td><c:out value="${result.grpAuthNm }"/></td>
			            <td><c:out value="${result.brkYn eq 'Y' ? '차단' : '미차단' }"/></td>
			            <td><c:out value="${result.useYn eq 'Y' ? '사용' : '미사용' }"/></td>
			            <td><c:out value="${result.lockYn eq 'Y' ? '잠금' : '미잠금' }"/></td>
			            <c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
			            	<c:choose>
			            		<c:when test="${result.lockYn eq 'Y' }">
						            <td>
						            	<span class="chk">
						            		<span class="cbx">
						            			<input type="checkbox" id="cbx_<c:out value='${result.userSerno}'/>"/><label for="cbx_<c:out value='${result.userSerno}'/>"></label>
						            		</span>
						            	</span>
						            </td>
			            		</c:when>
			            		<c:otherwise>
			            			<td>-</td>
			            		</c:otherwise>
			            	</c:choose>
			            </c:if>
					</tr>
				</c:forEach> 
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="<c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '10' : '9'}"/>">데이터가 없습니다.</td>
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
