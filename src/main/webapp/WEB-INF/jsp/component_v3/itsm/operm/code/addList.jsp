<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
	.code_correct .btn {margin: 0 !important;}
	.code_tbl .btn.code_add {width: 100%;}
</style>
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
			<col style="width: 73px;">
			<col style="width: 150px;">
			<col style="width: 370px;">
			<col>
		</colgroup>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(cdList)>0 }">
					<c:forEach items="${cdList }" var="result" varStatus="status">
						<tr>
							<!-- 조회 -->
							<th scope="row" class="code_basic" onclick="fncCdSel('${result.cdVal }','${searchVO.cdLvlVal+1 }');">
								<span>${result.cdVal }</span>
							</th>
							<td class="code_basic" onclick="fncCdSel('${result.cdVal }','${searchVO.cdLvlVal+1 }');">
								<span>${result.cdValNm } (${result.chldCnt })</span>
							</td>
							<td class="ellipsis code_basic" onclick="fncCdSel('${result.cdVal }','${searchVO.cdLvlVal+1 }');" title="${result.cdDtlsExpl }">
								<span style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 100%;">${result.cdDtlsExpl }</span>
							</td>
							<!-- 조회 -->
							<!-- 수정 -->
							<th scope="row" class="code_correct">
								<input type="text" id="cdVal_${result.cdVal}_up" class="text" value="${result.cdVal }" readonly="readonly">
							</th>
							<td class="code_correct">
								<input type="text" id="cdValNm_${result.cdVal}_up" class="text" value="${result.cdValNm }">
							</td>
							<td class="code_correct">
								<input type="text" id="cdDtlsExpl_${result.cdVal}_up" class="text" value="${result.cdDtlsExpl }">
							</td>
							<!-- 수정 -->
							<td class="c">
								<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
									<div class="code_basic">
										<c:choose>
											<c:when test="${status.first }">
												 <a href="javascript:void(0)" class="btn sml code_up" onclick="alert('첫번째 항목입니다.');return false;"></a>
											</c:when>
											<c:otherwise>
												 <a href="javascript:void(0)" class="btn sml code_up" onclick="fncSort('up','${result.uppoCdVal }','${result.cdVal }','${result.cdSortSeqo }','${searchVO.cdLvlVal }');"></a>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${status.last }">
												 <a href="javascript:void(0)" class="btn sml code_down" onclick="alert('마지막 항목입니다.');return false;"></a>
											</c:when>
											<c:otherwise>
												 <a href="javascript:void(0)" class="btn sml code_down" onclick="fncSort('down','${result.uppoCdVal }','${result.cdVal }','${result.cdSortSeqo }','${searchVO.cdLvlVal }');" ></a>
											</c:otherwise>
										</c:choose>
										<a class="btn sml code_rewrite" id="btn_rewrite_${result.cdVal }_${result.cdLvlVal}" onclick="fncRewrite('btn_rewrite_${result.cdVal }_${result.cdLvlVal}');"><span></span></a>
										<a class="btn sml code_del" onclick="fncCdAdd('delete', '${result.uppoCdVal }','${result.cdLvlVal}', '${result.cdVal }');" ><span></span></a>
									</div>
									<div class="code_correct">
										<a class="btn sml bd blue code_save" onclick="fncCdAdd('update', '${result.uppoCdVal }','${result.cdLvlVal}', '${result.cdVal }');">저장</a>
										<a class="btn sml bd gray code_cancel" onclick="upChk='N';fncCdSel('${result.uppoCdVal }','${result.cdLvlVal}');">취소</a>
									</div>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_code">
						<td colspan="4">등록된 코드가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
	<div class="code_add">
		<table class="code_tbl write">
			<caption>코드</caption>
			<colgroup>
				<col style="width: 75px;">
				<col style="width: 150px;">
				<col style="width: 370px;">
				<col>
			</colgroup>
			<tbody>
				<tr data-up="<c:out value="${searchVO.uppoCdVal }"/>" data-cd="<c:out value="${searchVO.cdVal }"/>" data-lvl="<c:out value="${searchVO.cdLvlVal }"/>">
					<td><input type="text" class="text" id="cdVal_${searchVO.cdLvlVal }" placeholder="코드" maxlength="${searchVO.cdLvlVal*2 }"></td>
					<td><input type="text" class="text" id="cdValNm_${searchVO.cdLvlVal }" placeholder="코드명" maxlength="20"></td>
					<td><input type="text" class="text" id="cdDtlsExpl_${searchVO.cdLvlVal }" placeholder="비고" maxlength="50"></td>
					<td>
						<a class="btn sml btn_code_add cdAdd code_add" data-type="insert">추가</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>