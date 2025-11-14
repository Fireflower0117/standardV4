<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
	$(document).ready(function(){
		<%-- no_data colspan 자동 셋팅 --%>
		fncColLength();
		<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
			<%-- 제한하기 : 선택된 값들 선택 유지 --%>
			fncChkReLoadBlk();
			<%-- 제한하기 : 선택에 따른 변화 셋팅 --%>
			fncCheckActionSetBlk();

			<%-- 제한 해제하기 : 선택된 값들 선택 유지 --%>
			fncChkReLoadClear();
			<%-- 제한 해제하기 : 선택에 따른 변화 셋팅 --%>
			fncCheckActionSetClear();

			$('.allBlk').on('click', function(){
				fncAll("BLK");
			});
			$('.allClear').on('click', function(){
				fncAll("Clear");
			});

			<%-- 전체 제한해제 --%>
			$('.allChkC').on('click', function(){
				fncAllChkClear(this);
			});

			<%-- 전체 제한 --%>
			$('.allChkB').on('click', function(){
				fncAllChkBlk(this)
			});

			<%-- 제한 삭제 --%>
			$('.del').on('click', function(){
				let serno = $(this).parents('tr').data('serno');
				let id = $(this).parents('tr').data('id');
				fncDel(serno, id);
			});
		</c:if>

		<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
			<%-- 등록 폼 이동 --%>
			$('#btn_write').on('click', function(){
				fncPageBoard('write', 'insertForm.do');
			});
		</c:if>

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
	<div class="board_left">
		<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
	<div class="board_right">
		<button type="button" id="btn_excel" class="btn btn_excel">엑셀 다운로드</button>
		<jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
	</div>
</div>
<table class="board_list">
	<caption>목록(번호, 아이디, 제한여부로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col>
		<col class="w15p"/>
		<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
			<col class="w15p"/>
			<col class="w15p"/>
			<col class="w15p"/>
		</c:if>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">아이디</th>
			<th scope="col">제한여부</th>
			<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
				<th scope="col">
					<a href="javascript:void(0);" class="btn sml red allBlk"><i class="xi-lock"></i>일괄 제한</a><br>
					<span class="chk">
						<span class="cbx"><input type="checkbox" name="allChkBlk" class="allChkB" id="allChkB"><label for="allChkB"></label></span>
					</span>
				</th>
				<th scope="col">
					<a href="javascript:void(0);" class="btn sml blue allClear"><i class="xi-unlock"></i>일괄 제한해제</a><br>
					<span class="chk">
						<span class="cbx"><input type="checkbox" name="allChkClear" class="allChkC" id="allChkC"><label for="allChkC"></label></span>
					</span>
				</th>
				<th scope="col">삭제</th>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach items="${resultList }" var="result" varStatus="status">
					<tr data-serno="<c:out value="${result.userSerno }"/>" data-id="<c:out value="${result.userId}"/>" class="no_cursor">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l"><c:out value="${result.userId }"/></td>
						<td>
							<c:out value="${result.brkYn eq 'Y' ? '제한' : '해제' }"/>
						</td>
						<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
							<c:choose>
								<c:when test="${result.brkYn eq 'Y'}">
									<td>-</td>
									<td>
										<span class="chk">
											<span class="cbx"><input type="checkbox" class="allChkClear"  value="<c:out value="${result.userSerno }"/>" id="clearChk_<c:out value="${result.userSerno}"/>"><label for="clearChk_<c:out value="${result.userSerno}"/>"></label></span>
										</span>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<span class="chk">
											<span class="cbx"><input type="checkbox" class="allChkBlk"  value="<c:out value="${result.userSerno }"/>" id="blkChk_<c:out value="${result.userSerno}"/>"><label for="blkChk_<c:out value="${result.userSerno}"/>"></label></span>
										</span>
									</td>
									<td>-</td>
								</c:otherwise>
							</c:choose>
							<td>
								<a href="javascript:void(0);" class="btn ic red del"><i class="xi-trash"></i>삭제</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="6">등록된 내역이 없습니다.</td>
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
			<button id="btn_write" class="btn blue">등록</button>
		</c:if>
	</div>
</div>