<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<style>
	tr, td {cursor: default !important;}
</style>
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="chgSn" id="chgSn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">변경 이력 정보</h4></div>
	</div>
	<div class="tbl_wrap">
	    <table class="board_row_type01">
	        <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
	        <colgroup>
	            <col style="width:20%;">
	            <col style="width:30%;">
	            <col style="width:20%;">
	            <col style="width:30%;">
	        </colgroup>
	        <tbody>
				<tr>
					<th scope="row"><strong>서비스 구분</strong></th>
					<td colspan="3"><c:out value="${itsmSysStsVO.svcNm }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>제목</strong></th>
					<td colspan="3"><c:out value="${itsmSysStsVO.chgTtl }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>처리 내용</strong></th>
					<td colspan="3"><pre><c:out value="${itsmSysStsVO.chgCn }" escapeXml="false"/></pre></td>
				</tr>
				<tr>
					<th scope="row"><strong>등록자</strong></th>
					<td><c:out value="${itsmSysStsVO.rgtrNm}"/></td>
					<th scope="row"><strong>반영일</strong></th>
					<td><c:out value="${itsmSysStsVO.regDt }"/></td>
				</tr>
	        </tbody>
	    </table>
	</div>
	<%--요청내용--%>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">변경 항목</h4></div>
	</div>
	<div class="tbl_wrap">
		<table id="mng_table" class="board_col_type01">
			<caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
			<colgroup>
				<col style="width: 6%;">
				<col style="width: 15%;">
				<col style="width: 8%;">
				<col style="width: 30%;">
				<col style="width: 30%;">
				<col style="width: 8%;">
				<col style="width: 8%;">
			</colgroup>
			<thead>
			<tr>
				<th class="c" style="padding: 8px 25px 8px 25px;"><strong>구분</strong></th>
				<th class="c" style="padding: 8px 25px 8px 25px;"><strong>메뉴</strong></th>
				<th class="c" style="padding: 8px 25px 8px 25px;"><strong>처리구분</strong></th>
				<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요청내용</strong></th>
				<th class="c" style="padding: 8px 25px 8px 25px;"><strong>처리내용</strong></th>
				<th class="c" style="padding: 8px 25px 8px 25px;"><strong>처리일</strong></th>
				<th class="c" style="padding: 8px 25px 8px 25px;"><strong>담당자</strong></th>
			</tr>
			</thead>
			<tbody id="tbody_cnList">
			<c:choose>
				<c:when test="${fn:length(resultList) gt 0 }">
					<c:forEach var="result" items="${resultList }" varStatus="status">
						<tr id="tr_dmndCn_${status.index }">
							<td class="no_bdl c" id="td_dmndCdNm_${status.index }">
								<c:out value="${result.dmndCdNm}"/>
							</td>
							<td class="c">
								<c:choose>
									<c:when test="${result.menuCd eq 'common'}">
										공통
									</c:when>
									<c:otherwise>
										<c:out value="${result.upMenuNm}"/><c:if test="${not empty result.upMenuNm}"> > </c:if><c:out value="${result.menuNm}"/>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="ellipsis"><c:out value="${result.prcsGbnNm}"/></td>
							<td class="ellipsis"><c:out value="${result.dmndTtl}"/></td>
							<td class="ellipsis"><c:out value="${result.prcsCn}"/></td>
							<td class="c"><c:out value="${result.prcsDt}"/></td>
							<td class="no_bdr c"><c:out value="${result.userNm}"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="7">반영 항목이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>

			</tbody>
		</table>
	</div>
	<div class="btn_area">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<c:if test="${grpAuthId eq 'allAdmin' || grpAuthId eq 'developer' || itsmImpFncVO.rgtrSn eq searchVO.loginSerno}">
			       <a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmSysStsVO.chgSn }', 'chgSn');">수정</a>
			       <a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
			</c:if>
	    </c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
</form:form>
<script type="text/javascript">
	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
		itsmFncProc('delete');
	});
</script>