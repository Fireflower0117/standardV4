<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "byteView"));
	window.scrollTo(0, document.body.scrollHeight)
});

<%-- 사용자 전체 검색 --%>
function fncPopFindUser(){
	$.ajax({
		method   : "POST",
		data	 : $("#defaultFrm").serialize(),
		url      : "popFindUser.do",
		dataType : "html",
		success  : function(data) {
			modal_show('50%','70%', data);
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


<%-- 파일 미리보기 --%>
function fncFileShow(fileId, seqo, nm){
	fncAjax('largeImg.do', {"atchFileId" : fileId, "fileSeqo" : seqo, "fileRlNm" : nm}, 'html', true, '', function(data){
		modal_show('1000px','650px',data);
	});
}


</script>
<style>
	#addTab td, #addTab th {
		height: 51px;
	}

	.tbl_file th {height: auto;}
	.tbl_file td {height: auto;}
</style>
<div class="tbl_top">
	<div class="tbl_left">
	</div>
</div>
<c:choose>
	<c:when  test="${searchVO.serverGbn eq 'mngr' }">
		<%-- 회원현황 --%>
		<div class="tbl_wrap">
			<table class="board_col_type01">
				<caption>목록</caption>
				<colgroup>
					<col style="width: 7%">
					<col style="width: 10%">
					<col style="width: 15%">
					<col style="width: 15%">
					<col>
					<col style="width: 7%">
				</colgroup>
				<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">이름</th>
					<th scope="col">아이디</th>
					<th scope="col">전화번호</th>
					<th scope="col">이메일</th>
					<th scope="col">관리</th>
				</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${fn:length(resultList) > 0 }">
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr style="cursor: default ">
								<input type="hidden" name="userSerno" value="${result.userSerno}"/>
								<td style="cursor: default " class="c"><c:out value="${paginationInfo.totalRecordCount + 1 - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
								<td style="cursor: default " class="c"><c:out value="${result.userNm}"/></td>
								<td style="cursor: default " class=""><c:out value="${result.userId }"/></td>
								<td style="cursor: default "><c:out value="${util:getDecryptAES256HyPhen(result.userTelNo) }"/></td>
								<td style="cursor: default " class="ellipsis"><c:out value="${result.userEmailAddr}"/></td>
								<td style="cursor: default " class="ellipsis c ">
									<c:choose>
										<c:when test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
											<a href="javascript:void(0);" id="mngrDel" class="btn btn_sml btn_del" onclick="fncDelMngr('${result.userSerno}')">삭제</a>
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="no_data">
							<td colspan="6">등록된 내역이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<div class="paging_wrap">
			<div class="paging">
				<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncAddView"/>
			</div>
			<div class="btn_right">
				<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
					<a href="javascript:void(0);" id="btn1123" class="btn btn_sml btn_save" onclick="fncPopFindUser()">담당자 배치</a>
				</c:if>
			</div>
		</div>
	</c:when>
	<c:when  test="${searchVO.serverGbn eq 'dev' or searchVO.serverGbn eq 'web' or searchVO.serverGbn eq 'was' or searchVO.serverGbn eq 'db' }">
		<div class="tbl_top">
			<div class="tbl_left"><h4 class="sm_tit">${searchVO.serverGbn eq 'dev' ? '개발 서버 정보' : searchVO.serverGbn eq 'web' ? 'WEB 서버 정보' : searchVO.serverGbn eq 'was' ? 'WAS 서버 정보' : 'DB 서버 정보'}</h4></div>
		</div>
			<div class="tbl_wrap">
				<table class="board_row_type01">
					<caption></caption>
					<colgroup>
						<col style="width:20%;">
						<col style="width:30%;">
						<col style="width:20%;">
						<col style="width:30%;">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row"><strong>IP</strong></th>
						<td><c:out value="${serverVO.serverIp }"/></td>
						<th scope="row"><strong>PORT</strong></th>
						<td><c:out value="${serverVO.serverPort }"/></td>
					</tr>
					<tr>
						<th scope="row"><strong>서버 디렉토리 경로</strong></th>
						<td colspan="3"><c:out value="${serverVO.serverPath }"/></td>
					</tr>
					<c:if test="${searchVO.serverGbn eq 'was' or searchVO.serverGbn eq 'web'}">
						<tr>
							<th scope="row"><strong>로그 경로</strong></th>
							<td colspan="3"><c:out value="${serverVO.serverLogPath }"/></td>
						</tr>
					</c:if>
					<tr>
						<th scope="row"><strong>OS</strong></th>
						<td colspan="3"><c:out value="${serverVO.serverOs }"/></td>
					</tr>
					<tr>
						<th scope="row"><strong>RAM 용량</strong></th>
						<td><c:out value="${serverVO.serverRamVol }"/></td>
						<th scope="row"><strong>스토리지 용량</strong></th>
						<td><c:out value="${serverVO.serverStrgVol }"/></td>
					</tr>
						<tr>
							<th scope="row"><strong>${searchVO.serverGbn eq 'db' ? 'DB 종류' : '개발도구'}</strong></th>
							<td><c:out value="${serverVO.serverType }"/></td>
							<th scope="row"><strong>버전</strong></th>
							<td><c:out value="${serverVO.serverVersion }"/></td>
						</tr>
						<c:if test="${searchVO.serverGbn eq 'db'}">
							<tr>
								<th scope="row"><strong>SID</strong></th>
								<td colspan="3"><c:out value="${serverVO.serverSid }"/></td>
							</tr>
						</c:if>
					<c:if test="${searchVO.serverGbn eq 'dev'}">
						<tr>
							<th scope="row"><strong>IDE</strong></th>
							<td colspan="3"><c:out value="${serverVO.serverIde }"/></td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			<div class="btn_area">
				<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
					<a href="javascript:void(0);" class="btn btn_sml btn_save" onclick="serverForm();">수정</a>
				</c:if>
			</div>

	</c:when>
	<c:when  test="${searchVO.serverGbn eq 'net'}">
		<input type="hidden" name="atchFileId" id="atchFileId" value="${serverVO.atchFileId}">
		<div class="tbl_top">
			<div class="tbl_left"><h4 class="sm_tit">네트워크 정보</h4></div>
		</div>
		<div class="tbl_wrap">
			<table class="board_row_type01">
				<caption></caption>
				<colgroup>
					<col style="width:20%;">
					<col style="width:30%;">
					<col style="width:20%;">
					<col style="width:30%;">
				</colgroup>
				<tbody>
				<tr>
					<th scope="row"><strong>출발지 IP</strong></th>
					<td><c:out value="${serverVO.startIp }"/></td>
					<th scope="row"><strong>출발지 PORT</strong></th>
					<td><c:out value="${serverVO.startPort }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>목적지 IP</strong></th>
					<td><c:out value="${serverVO.endIp }"/></td>
					<th scope="row"><strong>목적지 PORT</strong></th>
					<td><c:out value="${serverVO.endPort }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>서브넷 마스크</strong></th>
					<td colspan="3"><c:out value="${serverVO.subnetMask }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>브로드캐스트</strong></th>
					<td colspan="3"><c:out value="${serverVO.broadCast }"/></td>
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
												<a href="#" onclick="fncFileShow('${file.atchFileId}', '${file.fileSeqo}','${file.fileRlNm}');return false; ">
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
				<a href="javascript:void(0);" class="btn btn_sml btn_save" onclick="serverForm();">수정</a>
			</c:if>
		</div>
	</c:when>
</c:choose>

