<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
	var trActive = $('.code_tbl tbody tr');

	trActive.click(function () {
		$(this).addClass('active');
		$(this).siblings().removeClass('active');
	});
</script>
<div class="cont">
	<table class="code_tbl">
		<caption>코드</caption>
		<colgroup>
			<col style="width: 398px;">
			<col>
		</colgroup>
		<c:choose>
			<c:when test="${fn:length(resultList)>0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<c:choose>
							<c:when test="${result.lwrTabYn eq 'Y' and result.menuLvl eq '3'}">
								<th scope="row" style="cursor: default;"  title="${result.menuExpl }"><span>${result.menuNm }</span></th>
							</c:when>
							<c:otherwise>
								<th scope="row" onclick="fncMenuCdSel('${result.menuCd }','${result.menuLvl+1 }');" title="${result.menuExpl }"><span>${result.menuNm }</span></th>
							</c:otherwise>
						</c:choose>
						<td class="c">
							<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
								<div class="code_basic">
									<c:choose>
										<c:when test="${status.first }">
											<a href="javascript:void(0)" class="btn sml code_up" onclick="alert('첫번째 항목입니다.');return false;"></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0)" class="btn sml code_up" onclick="fncSort('up','${result.uprMenuCd }','${result.menuCd }','${result.menuSeqo }','${result.menuLvl }');"></a>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${status.last }">
											<a href="javascript:void(0)" class="btn sml code_down" onclick="alert('마지막 항목입니다.');return false;"></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0)" class="btn sml code_down" onclick="fncSort('down','${result.uprMenuCd }','${result.menuCd }','${result.menuSeqo }','${result.menuLvl }');"></a>
										</c:otherwise>
									</c:choose>
									<a href="javascript:void(0)" class="btn sml code_rewrite" onclick="fncPageBoard('update', 'menuForm.do', '${result.menuSerno}', 'menuSerno');"></a>
									<a href="javascript:void(0)" class="btn sml code_del" onclick="fncDeleteMenu('${result.uprMenuCd }', '${result.menuLvl}', '${result.menuSerno }');"></a>
								</div>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="no_code">
					<td colspan="2">등록된 메뉴가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
</div>
<div class="code_add">
	<table class="code_tbl write">
		<caption>코드</caption>
		<colgroup>
			<col style="width: 80px;">
			<col style="width: 120px;">
			<col style="width: 150px;">
			<col style="width: 150px;">
			<col>
		</colgroup>
		<tbody>
		<tr>
			<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
				<td><input type="text" class="text" id="menuCd_${searchVO.menuLvl }" placeholder="메뉴코드" maxlength="30"/></td>
				<td><input type="text" class="text" id="menuNm_${searchVO.menuLvl }" placeholder="메뉴명" maxlength="20"/></td>
				<td>
					<select id="addUrl_${searchVO.menuLvl }" class="w100p">
						<option value="N">URL미생성</option>
						<option value="Y">URL생성</option>
					</select>
				</td>
				<td>
					<select id="targetBlankYn_${searchVO.menuLvl }" class="w100p">
						<option value="N">현재창에서 열기</option>
						<option value="Y">새창에서 열기</option>
					</select>
				</td>
				<td>
					<a class="btn sml code_add" onclick="fncMenuCdAdd('${searchVO.menuLvl }','${searchVO.uprMenuCd}');">추가</a>
				</td>
			</c:if>
		</tr>
		</tbody>
	</table>
</div>