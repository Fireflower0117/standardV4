<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
$(document).ready(function(){
	fncManagerList("select", "선택", "${sessionScope.itsm_user_info.userSerno}", "mngrSn", ${itsmErrVO.svcSn});
	fncMenuList("", "select", "선택", "${itsmErrVO.menuCd}", "", "menuCd", "", "ASC");
	fncCodeList("ERGB", "select", "선택", "${itsmErrVO.errGbn}","", "errGbn", "", "ASC");

	$("#errResCn_submit").on("click", function () {
		if(wrestSubmit(document.defaultFrm)){
			itsmFncProc("update")
			return false;
		}
	});
})

</script>
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="errSn" id="errSn"/>
	<form:hidden path="svcSn" id="svcSn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">에러 정보</h4></div>
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
				<th scope="row"><strong>서비스구분</strong></th>
				<td colspan="3">
					<c:out value="${itsmErrVO.svcNm}"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><strong>에러유형</strong></th>
				<td>
					<c:out value="${itsmErrVO.errTpNm}"/>
				</td>
				<th scope="row"><strong>에러설명</strong></th>
				<td>
					<c:out value="${itsmErrVO.errExpl}"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><strong>에러페이지URL</strong></th>
				<td colspan="3">
					<c:out value="${itsmErrVO.errPageUrlAddr}"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><strong>에러발생IP</strong></th>
				<td>
					<c:out value="${itsmErrVO.ipAddr}"/>
				</td>
				<th scope="row"><strong>에러발생일시</strong></th>
				<td>
					<c:out value="${itsmErrVO.errOccrDt}"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><strong>에러내용</strong></th>
				<td colspan="3">
					<c:out value="${itsmErrVO.svrErrInfoCtt}"/>
				</td>
			</tr>
	        </tbody>
	    </table>
	</div>

	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">장애 해결 정보</h4></div>
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
			<c:choose>
				<c:when test="${empty itsmErrVO.errResDt}">
					<c:if test="${grpAuthId eq 'developer'}">
						<tr>
							<th>진행 단계</th>
							<td><p class="c rqu stt_dv">미해결</p></td>
							<th><strong class="th_tit">담당자</strong></th>
							<td>
								<form:select path="mngrSn"  cssClass="select w30p" title="담당자" required="true" >
								</form:select>
							</td>
						</tr>
						<tr>
							<th><strong class="th_tit">메뉴</strong></th>
							<td>
								<form:select path="menuCd" cssClass="select w30p" title="메뉴" required="true" >
								</form:select>
							</td>
							<th><strong class="th_tit">에러 구분</strong></th>
							<td>
								<form:select path="errGbn"  cssClass="select w30p" title="에러 구분" required="true" >
								</form:select>
							</td>
						</tr>
						<tr>
							<th>처리 내용</th>
							<td colspan="3">
								<form:input type="text" path="errResCn" class="text" title="처리 내용"  maxlength="900"/>
							</td>
						</tr>
					</c:if>
					<c:if test="${grpAuthId ne 'developer'}">
						<tr>
							<th>진행 단계</th>
							<td colspan="3"><p class="c rqu stt_dv">미해결</p></td>
						</tr>
						<tr>
							<th>처리 내용</th>
							<td colspan="3">처리 진행 중입니다.</td>
						</tr>
					</c:if>

				</c:when>
				<c:otherwise>
					<c:if test="${grpAuthId eq 'developer'}">
						<tr>
							<th>진행 단계</th>
							<td><p class="c prc stt_dv">처리완료</p></td>
							<th><strong class="th_tit">담당자</strong></th>
							<td>
								<form:select path="mngrSn" cssClass="select w30p" title="담당자" required="true" >
								</form:select>
							</td>
						</tr>
						<tr>
							<th><strong class="th_tit">메뉴</strong></th>
							<td>
								<form:select path="menuCd" cssClass="select w30p" title="메뉴" required="true" >
								</form:select>
							</td>
							<th><strong class="th_tit">에러 구분</strong></th>
							<td>
								<form:select path="errGbn"  cssClass="select w30p" title="에러 구분" required="true" >
								</form:select>
							</td>
						</tr>
						<tr>
							<th>처리 내용</th>
							<td colspan="3">
								<form:input type="text" path="errResCn"  class="text" title="처리 내용"  maxlength="900"/>
							</td>
						</tr>
					</c:if>
					<c:if test="${grpAuthId ne 'developer'}">
						<tr>
							<th>진행 단계</th>
							<td><p class="c prc stt_dv">처리완료</p></td>
							<th>담당자</th>
							<td><c:out value="${itsmErrVO.mngrNm} "/></td>
						</tr>
						<tr>
							<th>메뉴</th>
							<td><c:out value="${itsmErrVO.menuNm} "/></td>
							<th>에러 구분</th>
							<td><c:out value="${itsmErrVO.errGbnNm} "/></td>
						</tr>
						<tr>
							<th>처리내용</th>
							<td><c:out value="${empty itsmErrVO.errResCn ? '-' : itsmErrVO.errResCn} "/></td>
							<th>처리완료일시</th>
							<td><c:out value="${itsmErrVO.errResDt} "/></td>
						</tr>
					</c:if>

				</c:otherwise>
			</c:choose>

			</tbody>
		</table>
	</div>
	<div class="btn_area">
			<c:if test="${grpAuthId eq 'developer'}">
			       <a href="javascript:void(0)" id="errResCn_submit" class="btn btn_mdl btn_rewrite">${empty itsmErrVO.errResDt ? '해결내용 등록' : '해결내용 수정'}</a>
			</c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
</form:form>
