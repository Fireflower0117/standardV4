<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
$(document).ready(function(){
	fncDate('prnmntDt')
	fncManagerList("select", "선택", "${empty itsmImpFncVO.userSerno ? sessionScope.itsm_user_info.userSerno : itsmImpFncVO.userSerno}", "userSerno", "${itsmImpFncVO.svcSn}");
	fncCommentList("${itsmImpFncVO.imprvSn}");
	fncCodeList("PG", "select", "선택", "${itsmImpFncVO.prcsGbn}","prcsGbn" , "prcsGbn", "", "ASC");
	fncMenuList("", "select", "선택", "", "", "menuCd", "", "ASC");

	<%-- 첨부파일 출력 HTML function --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "byteView"));


	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
		itsmFncProc('delete');
	});

})



function fncUpdateManager() {
	itsmFncProc('update','procManager');
}

function fncUpdateSubmit() {
	itsmFncProc('update','procSubmit');
}

<%-- 추가요청사항 코멘트 --%>
function fncCommentList(seq){
    $.ajax({
        url      : "getComment.do",
        type     : "post",
        data     : {"imprvSn" : seq},
        dataType : "html",
        success  : function(data){
            $("#commentList").html(data);
        }
    })
    
}

<%-- 첨부파일 다운 --%>
function fncFileDown(url, id, sn, stre){
	$("#atchFileId").val(id);
	$("#fileSn").val(sn);
	$("#streFileNm").val(stre);
	$("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
};

function fncReport(){
	fncPageBoard('view','/itsm/svcReq/conferRec/view.do','${itsmImpFncVO.cofSn}','cofSn')
}


</script>
<form:form modelAttribute="itsmImpFncVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="imprvSn" id="imprvSn"/>
	<input type="hidden" id="regDt" name="regDt" value="${itsmImpFncVO.regDt}"/>
	<input type="hidden" id="cmntAtchFileId" name="cmntAtchFileId"/>
	<input type="hidden" id="atchFileId" name="atchFileId" value="${itsmImpFncVO.atchFileId}"/>
	<input type="hidden" id="fileSn" name="fileSn"/>
	<input type="hidden" id="streFileNm" name="streFileNm"/>
	<input type="hidden" id="cofSn" name="cofSn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">요청정보</h4></div>
		<div class="tbl_right">
			<c:if test="${not empty itsmImpFncVO.cofSn}">
				<a href="javascript:void(0);" class="btn btn_sml btn_confer" onclick="fncReport();"><span>회의록</span></a>
			</c:if>
		</div>
	</div>
	<div class="tbl_wrap">
	    <table class="board_row_type01" style="table-layout: fixed;">
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
					<td colspan="3">
						<c:out value="${itsmImpFncVO.svcNm}"/>
					</td>
				</tr>
				<tr>
	                <th scope="row"><strong>요청번호</strong></th>
	                <td colspan="3"><c:out value="${itsmImpFncVO.imprvSn }"/></td>
	            </tr>
	            <tr>
	            	<th scope="row"><strong>요청제목</strong></th>
	                <td colspan="3"><c:out value="${itsmImpFncVO.dmndTtl }"/></td>
	            </tr>
	            <tr>
	            	<th scope="row"><strong>요청자</strong></th>
	                <td><c:out value="${itsmImpFncVO.rqstrNm }"/></td>
					<th scope="row"><strong>요청구분</strong></th>
	                <td><c:out value="${itsmImpFncVO.dmndCdNm }"/></td>
				</tr>
	            <tr>
	            	<th scope="row"><strong>요청일자</strong></th>
	                <td><c:out value="${itsmImpFncVO.regDt }"/></td>
	            	<th scope="row"><strong>처리요청일</strong></th>
	                <td><c:out value="${itsmImpFncVO.dmndDt }"/></td>
				</tr>
	            <tr>
					<th scope="row"><strong>내용</strong></th>
	                <td colspan="3" style="word-wrap: break-word;word-break: break-all;">
	                	<pre><c:out value="${(itsmImpFncVO.dmndCn)}" escapeXml="false" /></pre>
	                </td>
				</tr>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
	                <td colspan="3">
						<div class="gallery_wrap photo_board">
							<ul class="thum_list">
								<c:if test="${fn:length(fileList) gt 0}">
									<c:forEach var="file" items="${fileList}" varStatus="fileStatus">
										<c:if test="${fn:contains(file.fileTpNm, 'image') }">
											<li>
												<a href="#" onclick="fncPreviewShow('${file.atchFileId}', '${file.fileSeqo}','${file.fileRlNm}');return false;">
													<figure class="thum_img">
														<img src='/itsm/file/getByteImage.do?atchFileId=${file.atchFileId}&fileSeqo=${file.fileSeqo}' alt="image">
														<div class="thum_img_info right_btm" style="max-width: 90%">
															<span class="ellipsis l" style="font-size: 12px;"><c:out value="${file.fileRlNm}"/></span>
														</div>
													</figure>
												</a>
											</li>
										</c:if>
									</c:forEach>
								</c:if>
							</ul>
						</div>
	                	<div id="atchFileUpload"></div>
	                </td>
				</tr>
	        </tbody>
	    </table>
	</div>
	<div class="btn_area">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<c:if test="${itsmImpFncVO.rgtrSn eq searchVO.loginSerno}">
				<c:if test="${itsmImpFncVO.prcsCd ne 'PO03' }">
					<a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmImpFncVO.imprvSn }', 'imprvSn');">수정</a>
					<a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
				</c:if>
			</c:if>
		</c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">처리현황 정보</h4></div>
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
					<th>진행 단계</th>
					<td colspan="3" >
						<p class="c stt_dv ${itsmImpFncVO.prcsCd eq 'PO01' ? 'rqu' : itsmImpFncVO.prcsCd eq 'PO02' ? 'prg' : 'prc'}">
								${itsmImpFncVO.prcsCd eq 'PO01' ? '요청' : itsmImpFncVO.prcsCd eq 'PO02' ? '처리중' : '처리완료'}
						</p>
					</td>
				</tr>
				<c:choose>
					<c:when test="${itsmImpFncVO.prcsCd eq 'PO01'}">
						<%-- 요청 상태일때 개발자 화면과 사용자 화면 분기처리 --%>
						<c:choose>
							<c:when test="${grpAuthId eq 'developer'}">
								<th><strong class="th_tit">담당자</strong></th>
								<td>
									<form:select path="userSerno" id="userSerno"  cssClass="select w30p" title="담당자" required="true" >
									</form:select>
								</td>
								<th scope="row"><strong class="th_tit">처리예정일</strong></th>
									<td>
									<span class="calendar_input w130">
										<form:input path="prnmntDt" id="prnmntDt" readonly="true" cssClass="text w130" required="true"/>
									</span>
										<button class="btn btn_sml btn_rewrite" style="float: right;" type="button" onclick="fncUpdateManager()">담당자 배정</button>
								</td>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="c" colspan="4">담당자에게 요청 대기 중입니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${itsmImpFncVO.prcsCd eq 'PO02'}">
						<%-- 담당자배정 상태일때 개발자 화면과 사용자 화면 분기처리 --%>
						<c:choose>
							<c:when test="${grpAuthId eq 'developer'}">
								<tr>
									<th><strong class="th_tit">담당자</strong></th>
									<td>
										<form:select path="userSerno" id="userSerno"  cssClass="select w30p" title="담당자" required="true" >
										</form:select>
									</td>
									<th scope="row">처리예정일</th>
									<td><c:out value="${itsmImpFncVO.prnmntDt}"/>
										<form:hidden path="prnmntDt" id="prnmntDtHidden" readonly="true"/>
										<button class="btn btn_sml btn_rewrite" style="float: right;" type="button" onclick="fncUpdateManager()">담당자 배정</button></td>
								</tr>
								<c:if test="${sessionScope.itsm_user_info.userSerno eq itsmImpFncVO.userSerno}">
									<%-- 로그인한 담당자가 해당 서비스의 담당자로 배정된 경우 처리완료 기능 이용 가능 --%>
									<tr>
										<th scope="row"><strong class="th_tit">메뉴</strong></th>
										<td>
											<form:select path="menuCd"  cssClass="select w30p" title="메뉴" required="true" >
											</form:select>
										</td>
										<th scope="row"><strong class="th_tit">처리구분</strong></th>
										<td>
											<form:select path="prcsGbn" title="처리구분"></form:select>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong id="cnStrong">처리내용</strong></th>
										<td colspan="3">
											<div class="flex_inpbtn">
												<form:textarea path="prcsCn" id="prcsCn" cssClass="text_area_sml" maxlength="1000"/>
												<button class="btn btn_mdl btn_completed" onclick="fncUpdateSubmit()">처리완료</button>
											</div>
										</td>
									</tr>
								</c:if>
							</c:when>
							<c:otherwise>
								<th>담당자</th>
								<td><c:out value="${itsmImpFncVO.userNm}"/></td>
								<th scope="row">처리예정일</th>
								<td><c:out value="${itsmImpFncVO.prnmntDt}"/></td>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${itsmImpFncVO.prcsCd eq 'PO03'}">
						<%-- 처리완료 상태일때는 같은 화면 --%>
						<tr>
							<th>담당자</th>
							<td><c:out value="${itsmImpFncVO.userNm}"/></td>
							<th scope="row">처리예정일</th>
							<td><c:out value="${itsmImpFncVO.prnmntDt}"/></td>
						</tr>
						<tr>
							<th>메뉴</th>
							<td><c:out value="${itsmImpFncVO.menuNm}"/></td>
							<th>처리구분</th>
							<td><c:out value="${itsmImpFncVO.prcsGbnNm}"/></td>
						</tr>
						<tr>
							<th>처리 내용</th>
							<td colspan="3">
								<c:out value="${itsmImpFncVO.prcsCn}"/>
							</td>
						</tr>
					</c:when>
					<c:otherwise>

					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
    <%-- 추가요청사항 코멘트 --%>
	<div id="commentList" class="reply_area"></div>
</form:form>
