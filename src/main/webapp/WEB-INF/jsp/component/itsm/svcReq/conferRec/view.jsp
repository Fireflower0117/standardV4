<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">

$(document).ready(function(){

	$("#slideUp1").click(function () {
		if($(this).text() == "목록열기"){
			$(this).text("목록닫기");
		} else {
			$(this).text("목록열기");
		}
		$('.js-srchDet1').slideToggle(300);
		$(this).toggleClass('open');
	});

	<%-- 첨부파일 출력 HTML function --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));
	
	$("#open_table").rowspan(0);
	
})

<%-- 요청자 검색 팝업 --%>
function fncPopFindUser(){
 	$.ajax({  
		method : "POST",  
		url    : "popFindUser.do",   
		dataType : "html", 
		success  : function(data) {
				 	modal_show('60%','60%', data);
		  		 }
		});  
	
}

<%-- 첨부파일 다운 --%>
function fncFileDown(url, id, sn, stre){
	$("#atchFileId").val(id);
	$("#fileSn").val(sn);
	$("#streFileNm").val(stre);
	$("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
};

<%-- 인쇄하기 --%>
function fncConferPrint(cofSn){
	$("#cofSn").val(cofSn);
	var childWindow;
	
	childWindow = window.open("", "childForm", "width=800, height=1000, resizable = no, scrollbars = no");
	
	var defaultFrm = document.defaultFrm;

	defaultFrm.action = "/itsm/confer/conferRec/conferPrint.do";
	defaultFrm.method = "post";
	defaultFrm.target = "childForm";
	defaultFrm.submit();

	defaultFrm.target = "";
	
	return false;
	
}

</script>
<form:form modelAttribute="itsmConferRecVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="cofSn" id="cofSn"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<input type="hidden" id="fileSn" name="fileSn"/>
	<input type="hidden" id="streFileNm" name="streFileNm"/>
	<input type="hidden" id="imprvSn" name="imprvSn"/>
	<input type="hidden" id="rqrSn" name="rqrSn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	
	<div class="r mar_b10">
		<a href="javascript:void(0);" class="btn btn_mdl btn_confer" onclick="fncConferPrint('${itsmConferRecVO.cofSn}');"><span>회의록 다운로드</span></a>
	</div>
	<div class="tbl_wrap mar_t30">
		<table class="board_row_type01">
			<caption>내용(로고, 사업명, 작성자, 작성일, 등으로 구성)</caption>
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 20%;">
				<col style="width: 20%;">
				<col style="width: 20%;">
			</colgroup>
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" class="c report_tit"><c:out value="${itsmConferRecVO.svcNm }"/></td>
					<td><p>작성자</p></td>
					<td><p><c:out value="${itsmConferRecVO.regNm }"/></p></td>
				</tr>
				<tr>
					<td><p>작성일</p></td>
					<td><c:out value="${itsmConferRecVO.regDt }"/></td>
				</tr>
				<tr>
					<td><p>ACTIVITY</p></td>
					<td><c:out value="${itsmConferRecVO.cofInfo }"/></td>
					<td><p>승인자</p></td>
					<td><c:out value="${itsmConferRecVO.apvrNm }"/></td>
				</tr>
				<tr>
					<td>표준 산출물</td>
					<td><c:out value="${itsmConferRecVO.cofKind }"/></td>
					<td>Version</td>
					<td><c:out value="${itsmConferRecVO.version }"/></td>
				</tr>
	
			</tbody>
		</table>
		<h4 class="md_tit mar_t30">사업개요</h4>
		<table class="board_row_type01">
			<caption>내용(사업명, 계약기간, 계약번호, 업체명 등으로 구성)</caption>
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 80%;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><strong>사업명</strong></th>
					<td><c:out value="${itsmConferRecVO.svcNm }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>회의일시</strong></th>
					<td>
						<c:out value="${itsmConferRecVO.cofDt }"/>
						<c:out value="${itsmConferRecVO.cofStaHh }"/>:<c:out value="${itsmConferRecVO.cofStaMi }"/>&nbsp;~&nbsp;<c:out value="${itsmConferRecVO.cofEndHh }"/>:<c:out value="${itsmConferRecVO.cofEndMi }"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong>회의제목</strong></th>
					<td><c:out value="${itsmConferRecVO.cofTtl }"/></td>
				</tr>
			</tbody>
		</table>
	
		<h4 class="md_tit mar_t30">참석자</h4>
		<div class="tbl_wrap02">
			<div class="tbl_half_wrap mar_r20">
				<table id="mng_table" class="board_row_type01 mar_b40">
					<colgroup>
						<col style="width: 40%">
						<col style="width: 30%">
						<col style="width: 30%">
					</colgroup>
					<thead>
						<tr>
							<th><strong>소속</strong></th>
							<th><strong>직급</strong></th>
							<th><strong>이름</strong></th>
						</tr>
					</thead>
					<tbody id="tbody_mng">
						<c:choose>
							<c:when test="${fn:length(mngList) gt 0 }">
								<c:forEach var="mng" items="${mngList }" varStatus="status">
									<tr id="tr_mng_${status.count }">
										<td><c:out value="${mng.attDeptNm }"/></td>
										<td><c:out value="${mng.attOftlNm }"/></td>
										<td><c:out value="${mng.attNm }"/></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="c" colspan="3">참석자가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="tbl_half_wrap">
				<table id="open_table" class="board_row_type01 mar_b40">
					<colgroup>
						<col style="width: 20%">
						<col style="width: 15%">
						<col style="width: 15%">
					</colgroup>
					<thead>
						<tr>
							<th><strong>소속</strong></th>
							<th><strong>직급</strong></th>
							<th><strong>이름</strong></th>
						</tr>
					</thead>
					<tbody id="tbody_open">
						<c:choose>
							<c:when test="${fn:length(openList) gt 0 }">
								<c:forEach var="att" items="${openList }" varStatus="status">
									<tr id="tr_mng_${status.count }">
										<td>(주)오픈노트</td>
										<td><c:out value="${att.attOftlNm }"/></td>
										<td><c:out value="${att.attNm }"/></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="c" colspan="3">참석자가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>

		<h4 class="md_tit mar_t30">요구사항 추가</h4>
		<a href="javascript:void(0)" class="btn btn_sml btn_toggle" id="slideUp1">${fn:length(impFncList) gt 0 or fn:length(rqstList) gt 0 ? '목록닫기' : '목록열기'}</a>
		<div class="js-srchDet1" style="display: ${fn:length(impFncList) gt 0 or fn:length(rqstList) gt 0 ? '' : 'none'};">
			<h4 class="sm_tit mar_t30">기능개선요청</h4>
			<table class="board_row_type01 mar_b40 mar_t10">
				<colgroup>
					<col style="width: 10%">
					<col>
					<col style="width: 10%">
				</colgroup>
				<thead>
				<tr>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>구분</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요청내용</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>상세보기</strong></th>
				</tr>
				</thead>
				<tbody id="impFncList">
					<c:choose>
						<c:when test="${fn:length(impFncList) gt 0}">
							<c:forEach var="result" items="${impFncList }" varStatus="status">
								<tr>
									<td class="c">
										<p class="${result.dmndCdNm eq '일반' ? 'gnr rq_dv' : result.dmndCdNm eq '긴급' ? 'emg rq_dv' : result.dmndCdNm eq '중요' ? 'imp rq_dv' : '-' }">
											<c:out value="${result.dmndCdNm}"/>
										</p>
									</td>
									<td><c:out value="${result.dmndTtl}"/></td>
									<td class="c"><a href="javascript:void(0);" class="btn btn_sml btn_detail" onclick="fncPageBoard('view', '/itsm/svcReq/impFnc/view.do', '${result.imprvSn}', 'imprvSn');"><span>상세보기</span></a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="c" colspan="3">기능개선요청 항목이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<h4 class="sm_tit mar_t30">요구사항관리</h4>
			<table class="board_row_type01 mar_b40 mar_t10">
				<colgroup>
					<col style="width: 20%">
					<col style="width: 20%">
					<col>
					<col style="width: 10%">
				</colgroup>
				<thead>
				<tr>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요구사항 ID</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요구사항 항목</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요구사항 세부내역</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>상세보기</strong></th>
				</tr>
				</thead>
				<tbody id="rqstList">
				<c:choose>
					<c:when test="${fn:length(rqstList) gt 0}">
						<c:forEach var="result" items="${rqstList }" varStatus="status">
							<tr>
								<td><c:out value="${result.rqrId}"/></td>
								<td><c:out value="${result.rqrItm}"/></td>
								<td><c:out value="${result.rqrDtl}"/></td>
								<td class="c"><a href="javascript:void(0);" class="btn btn_sml btn_detail" onclick="fncPageBoard('view', '/itsm/svcReq/rqst/view.do', '${result.rqrSn}', 'rqrSn');"><span>상세보기</span></a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td class="c" colspan="4">요구사항 항목이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<br>
		<h4 class="md_tit mar_t30">회의내용</h4>
		<table class="board_row_type01 mar_b40">
			<colgroup>
				<col style="width: 100%">
			</colgroup>
			<thead>
				<tr>
					<td class="no_bdl report_cont"><pre><c:out value="${itsmConferRecVO.cofCn }" escapeXml="false"/></pre></td>
				</tr>
			</thead>
		</table>
	
		<h4 class="md_tit mar_t30">첨부파일</h4>
		<table class="board_row_type01 mar_b40">
			<colgroup>
				<col style="width: 20%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
	                <td colspan="3">
	                	<div id="atchFileUpload"></div>
	                </td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="btn_area">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY && grpAuthId eq 'developer'}">
	    	<a href="javascript:void(0);" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmConferRecVO.cofSn }', 'cofSn');">수정</a>
			<a href="javascript:void(0);" id="btn_del" class="btn btn_mdl btn_del">삭제</a>
	    </c:if>
		<a href="javascript:void(0);" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
</form:form>
