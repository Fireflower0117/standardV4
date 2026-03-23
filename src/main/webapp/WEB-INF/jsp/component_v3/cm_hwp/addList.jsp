<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	$(document).ready(function(){
		<%-- no_data colspan 자동 셋팅 --%>
		fncColLength();

		<%-- 페이지당 건수 변경시 --%>
		$('#recordCountPerPage_board_right').on('change', function() {
			if($('#recordCountPerPage_board_right').val()) {
				$('#recordCountPerPage').val($('#recordCountPerPage_board_right').val());
			}
			fncPageBoard('list','list.do',1);
		});

		<%-- 한글 다운로드 클릭--%>
		$('#btn_hwp').on('click', function(){
			cmFncHwpDown();
		});

		$('#btn_hwplib').on('click', function(){
			cmFncHwplibDown();
		});

		<%-- 체크박스 체크 유지 --%>
		fncPageMoveCheckSet();

		<%-- 전체선택 클릭시 --%>
		$('#allChk').on('click', function(){
			fncCheckAll($(this));
		})

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
		<button type="button" id="btn_hwp" class="btn btn_hwp">hwp다운로드</button>
		<button type="button" id="btn_hwplib" class="btn btn_hwp">hwp(lib)다운로드</button>
		<select id="recordCountPerPage_board_right">
			<option value="10" label="10건" ${searchVO.recordCountPerPage eq '10' ? 'selected="selected"' : '' }/>
			<option value="20" label="20건" ${searchVO.recordCountPerPage eq '20' ? 'selected="selected"' : '' }/>
			<option value="30" label="30건" ${searchVO.recordCountPerPage eq '30' ? 'selected="selected"' : '' }/>
			<option value="50" label="50건" ${searchVO.recordCountPerPage eq '50' ? 'selected="selected"' : '' }/>
		</select>
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
			<th scope="col"><span class="chk"><span class="cbx"><input type="checkbox" id="allChk" name="allChk"/><label for="allChk"></label></span></span></th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr class="no_cursor" data-serno="<c:out value='${result.userSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="ellipsis"><c:out value="${result.userId }"/></td>
						<td><c:out value="${result.userNm }"/>
						<td><c:out value="${util:getDecryptAES256HyPhen(result.userTelNo) }"/></td>
						<td class="ellipsis"><c:out value="${result.userEmailAddr }"/></td>
			            <td><c:out value="${result.grpAuthNm }"/></td>
			            <td><c:out value="${result.brkYn eq 'Y' ? '차단' : '미차단' }"/></td>
			            <td><c:out value="${result.useYn eq 'Y' ? '사용' : '미사용' }"/></td>
			            <td><c:out value="${result.lockYn eq 'Y' ? '잠금' : '미잠금' }"/></td>
						<td>
							<span class="chk">
								<span class="cbx">
									<input type="checkbox" id="cbx_<c:out value='${result.userSerno}'/>"/><label for="cbx_<c:out value='${result.userSerno}'/>"></label>
								</span>
							</span>
						</td>
					</tr>
				</c:forEach> 
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="10">데이터가 없습니다.</td>
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
