<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="${pageContext.request.contextPath}/resource/editor/js/HuskyEZCreator.js"></script>
<script>
	$(document).ready(function(){
		fncCmntList()
		$("#prcsStts_"+'${itsmIdeaVO.prcsStts}').prop('checked',true);
		
		<%-- 첨부파일 출력 HTML function --%>
		$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "byteView"));

		<%-- 삭제 클릭시 --%>
		$('#btn_delete').on('click', function(){
			itsmFncProc('delete');
		});
	
	});
	
	function fncCmntList(){
		$.ajax({  method: "POST",  url: "commentList.do",  data : $("#defaultFrm").serialize(), dataType: "html", success: function(data) {$(".cmnt_tbl").html(data);}});
	}
	
	<%-- 처리상태 변경 --%>
	function fncChgState(){
		var chkVal = $("input[name=prcsStts]:checked").val()

		$.ajax({
			type: 'patch'
			, url: 'chgState'
			, data: $("#defaultFrm").serialize()
			, dataType: 'json'
			, success: function (data) {
				if(data.result == 0){
					chkVal = '${itsmIdeaVO.prcsStts}'
				}else{
					var sttsText = chkVal == 'B' ? '접수완료' : chkVal == 'I' ? '처리중' : '처리완료'
					$("#sttsTd").text(sttsText)
				}
				$("#prcsStts_"+chkVal).prop('checked',true)
				alert(data.message);
				return false;

			}
		})
	}
	
</script>
<form:form modelAttribute="itsmIdeaVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
    <form:hidden path="ideaSn" id="ideaSn"/>
    <form:hidden path="atchFileId" id="atchFileId"/>
    <form:hidden path="cmntCurrentPageNo" id="cmntCurrentPageNo"/>
	<input type="hidden" id="cmntAtchFileId" name="cmntAtchFileId"/>
	<input type="hidden" name="serno" id="serno" value="${itsmIdeaVO.ideaSn }"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h3 class="md_tit">의견게시판</h3></div>
		<div class="tbl_right"></div>
	</div>
	<div class="tbl_wrap">
		<table class="board_row_type01" style="table-layout: fixed;">
			<colgroup>
				<col style="width:10%">
				<col style="width:40%">
				<col style="width:10%">
				<col style="width:40%">
			</colgroup>
			<tbody>
			<tr>
				<th>서비스구분</th>
				<td colspan="3"><c:out value="${itsmIdeaVO.svcNm}"/></td>
			</tr>
				<tr>
					<th>처리상황</th>
					<td id="sttsTd" colspan="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY  ? '' : '3'}">
						<c:out value="${itsmIdeaVO.prcsStts eq 'B' ? '접수완료' : itsmIdeaVO.prcsStts eq 'I' ? '처리중' : '처리완료'}"/>
					</td>
					<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY  }">
					<th>처리상황 수정</th>
					<td>
						<span class="chk">
							<span class="radio"><input type="radio" name="prcsStts" id="prcsStts_B" value="B" ${itsmIdeaVO.prcsStts eq 'B' ? 'checked' : ''}/><label for="prcsStts_B">접수완료</label></span>
							<span class="radio"><input type="radio" name="prcsStts" id="prcsStts_I" value="I" ${itsmIdeaVO.prcsStts eq 'I' ? 'checked' : ''}/><label for="prcsStts_I">처리중</label></span>
							<span class="radio"><input type="radio" name="prcsStts" id="prcsStts_E" value="E" ${itsmIdeaVO.prcsStts eq 'E' ? 'checked' : ''}/><label for="prcsStts_E">처리완료</label></span>
							<a target="_self" href="javascript:void(0);" class="btn btn_sml btn_save" onclick="fncChgState();">수정</a>
						</span>
					</td>
					</c:if>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><c:out value="${itsmIdeaVO.ideaTtl}"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3" style="word-wrap: break-word;word-break: break-all;">
						<pre><c:out value="${(itsmIdeaVO.bltnbCn) }" escapeXml="false"/></pre>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
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
				<tr>
					<th>등록자</th>
					<td>
						<c:out value="${itsmIdeaVO.rgtrNm }(${itsmIdeaVO.rgtrId})"/>
					</td>
					<th>등록일</th>
					<td>
						<c:out value="${itsmIdeaVO.regDt }"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="btn_area">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<c:if test="${itsmIdeaVO.rgtrSn eq searchVO.loginSerno}">
				<a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmIdeaVO.ideaSn }', 'ideaSn');">수정</a>
				<a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
			</c:if>
		</c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
    <div class="cmnt_tbl mar_t30"></div>
</form:form>
