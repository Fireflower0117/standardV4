<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
	span.code_basic{
		width: 100%;
		height: 77%;
		display: inline-block;
	}
</style>
<script>
<%-- 코드 클릭 시 해당 tr 효과 주는 이벤트 --%>
$('.code_tbl tbody tr').click(function () {
  $(this).addClass('active');
  $(this).siblings().removeClass('active');
});

<%-- 코드가 있는 경우만 드래그 설정 --%>
<c:if test="${fn:length(codeList) > 0 and sessionScope.SESSION_WRITE_BTN_KEY}">
	<%-- cd_tblBody --%>
	$("#cd_tblBody").sortable({
		placeholder: "ui-state-highlight",	<%-- 드래그 시 뒤에 배경 설정 --%>
		cursor: "grabbing",					<%-- 드래그 시 커서 설정 --%>
		<%-- revert:true,						 부드러운 효과 --%>
		containment: ".code_box",			<%-- 드래그 고정 범위 지정 --%>
		helper: function(event, ui) {		<%-- 드래그 시 보이는 화면 커스텀 --%>
			<%-- console.log($(this).find("tr").data("cd")); --%>
			var helper = $("<div>").addClass("custom-drag-helper").html('<i class="xi-caret-down-min"></i>').css({fontSize: "30px"});
			return helper
		},
		stop: function(event, ui) {								<%-- 드래그 앤 드롭이 끝난 시점 이벤트 실행 --%>
			var cdSerno = ui.item.data("seqo");					<%-- 코드 일련번호 --%>
			var cdLvlVal = ui.item.data("lvl");					<%-- 코드 레벨 --%>
			var cdNextSerno = ui.item.next("tr").data("seqo");	<%-- 선택한 코드 다음 tr 레벨 --%>

			<%-- 정렬 --%>
			fncSort(cdSerno, cdNextSerno, cdLvlVal);
		}
	});
</c:if>

</script>
<div class="cont">
	<table class="code_tbl">
		<caption>코드목록(코드, 코드명(하위코드), 설명, 관리로 구성)</caption>
		<colgroup>
			<col style="width: 90px;">
			<col style="width: 160px">
			<col style="width: 350px">
			<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
				<col>
			</c:if>
		</colgroup>
		<tbody id="cd_tblBody">
			<c:choose>
				<c:when test="${fn:length(codeList)>0 }">
					<c:forEach items="${codeList }" var="result" varStatus="status">
						<tr class="<c:if test="${result.cdLvlVal ne '4'}">cursor</c:if>" data-up="<c:out value="${result.cdUppoVal }"/>" data-cd="<c:out value="${result.cdVal }"/>" data-seqo="<c:out value="${result.cdSerno }"/>" data-lvl="<c:out value="${searchVO.cdLvlVal }"/>" data-sort="<c:out value="${result.cdSortSeqo}"/>">
							<!-- 조회 -->
							<td scope="row" class="c" style="border-left: 0px;">
								<span class="code_basic cdSel"><c:out value="${result.cdVal }"/></span>
								<input type="text" id="cdVal_<c:out value="${result.cdVal}"/>_up" class="text code_correct" value="<c:out value="${result.cdVal }"/>" readonly="readonly">
							</td>
							<td>
								<span class="code_basic cdSel"><c:out value="${result.cdNm }"/> (<c:out value="${result.chldCnt }"/>)</span>
								<input type="text" id="cdNm_<c:out value="${result.cdVal}"/>_up" class="text code_correct" value="<c:out value="${result.cdNm }"/>">
							</td>
							<td>
								<span class="code_basic cdSel" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 100%;"><c:out value="${result.cdDtlsExpl }"/></span>
								<input type="text" id="cdDtlsExpl_<c:out value="${result.cdVal}"/>_up" class="text code_correct" value="<c:out value="${result.cdDtlsExpl }"/>">
							</td>
							<!-- 조회 -->
							<!-- 수정 -->
							<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
								<td class="c">
									<div class="code_basic">
										<a class="btn sml code_rewrite" data-id="btn_rewrite_<c:out value="${result.cdVal }"/>_<c:out value="${result.cdLvlVal}"/>" id="btn_rewrite_<c:out value="${result.cdVal }"/>_<c:out value="${result.cdLvlVal}"/>"></a>
										<a class="btn sml code_del cdAdd" data-type="delete"></a>
									</div>
									<div class="code_correct">
										<a class="btn sml blue cdAdd" data-type="update">수정</a>
										<a class="btn sml gray cdSel" data-upchk="N">취소</a>
									</div>
								</td>
							</c:if>
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
<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
	<div class="code_add">
		<table class="code_tbl write">
			<caption>코드등록 목록(코드, 코드명, 비고로 구성)</caption>
			<colgroup>
				<col style="width: 90px;">
				<col style="width: 160px">
				<col style="width: 254px">
				<col>
			</colgroup>
			<tbody>
				<tr data-up="<c:out value="${searchVO.cdUppoVal }"/>" data-cd="<c:out value="${searchVO.cdVal }"/>" data-lvl="<c:out value="${searchVO.cdLvlVal }"/>">
					<td><input type="text" class="text" id="cdVal_<c:out value="${searchVO.cdLvlVal }"/>" placeholder="코드" maxlength="<c:out value="${searchVO.cdLvlVal*2 }"/>"></td>
					<td><input type="text" class="text" id="cdNm_<c:out value="${searchVO.cdLvlVal }"/>" placeholder="코드명" maxlength="20"></td>
					<td><input type="text" class="text" id="cdDtlsExpl_<c:out value="${searchVO.cdLvlVal }"/>" placeholder="비고" maxlength="50"></td>
					<td>
						<a class="btn sml btn_code_add cdAdd code_add" data-type="insert">추가</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>