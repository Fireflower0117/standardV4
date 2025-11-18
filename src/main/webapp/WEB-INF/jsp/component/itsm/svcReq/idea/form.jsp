<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="${pageContext.request.contextPath}/resource/editor/js/HuskyEZCreator.js"></script>
<script>
	var oEditors = [];
	$(document).ready(function(){

		<%-- CKeditr 설정--%>
		CKEDITOR.replace("bltnbCn",{height : 400, contentsCss: '${pageContext.request.contextPath}/component/itsm/js/ckeditor/contents.css'});

		fncSvcList("select", "선택", "${itsmIdeaVO.svcSn}", "svcSn",${sessionScope.itsm_user_info.userSvcSn});

		<c:if test="${searchVO.procType eq 'update'}">
			$("#prcsStts_"+"${itsmIdeaVO.prcsStts}").prop('checked', true);
		</c:if>
		
		<%-- 첨부파일 출력 HTML function --%>
		$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload"));

		<%-- 등록 또는 수정 --%>
		$("#btn_submit").click(function(){
			<%-- 에디터 유효성 검사 --%>
			if(!CKEDITOR.instances.bltnbCn.getData() || !CKEDITOR.instances.bltnbCn.getData().length){
				alertMsg("bltnbCn", "red", "내용 : 필수 입력입니다.");
				CKEDITOR.instances.bltnbCn.focus();
				wrestSubmit(document.defaultFrm)
				return false;
			}else{
				$("#msg_bltnbCn").remove();
				$("#bltnbCn").val(CKEDITOR.instances.bltnbCn.getData());
				if(wrestSubmit(document.defaultFrm)){
					fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {
						itsmFncProc('${searchVO.procType}');
					});
					return false;
				}
			}
		});
	});


</script>
<form:form modelAttribute="itsmIdeaVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
    <form:hidden path="ideaSn" id="ideaSn"/>
    <form:hidden path="atchFileId" id="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h3 class="md_tit">의견게시판</h3></div>
		<div class="tbl_right"><span class="asterisk">*</span>필수입력</div>
	</div>
	<div class="tbl_wrap">
		<table class="board_row_type01">
			<colgroup>
				<col style="width:10%">
				<col style="width:90%">
			</colgroup>
			<tbody>
			<tr>
				<th scope="row"><strong class="th_tit">서비스구분</strong></th>
				<td colspan="3"><form:select path="svcSn" id="svcSn" title="서비스구분" required="true" /></td>
			</tr>
				<c:if test="${searchVO.procType eq 'update' }">
					<tr>
						<th><strong>처리상황</strong></th>
						<td>
							<c:choose>
								<c:when test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY  }">
									<span class="chk">
										<span class="radio"><input type="radio" name="prcsStts" id="prcsStts_B" value="B"/><label for="prcsStts_B">접수완료</label></span>
										<span class="radio"><input type="radio" name="prcsStts" id="prcsStts_I" value="I"/><label for="prcsStts_I">처리중</label></span>
										<span class="radio"><input type="radio" name="prcsStts" id="prcsStts_E" value="E"/><label for="prcsStts_E">처리완료</label></span>
									</span>
								</c:when>
								<c:otherwise>
									<c:out value="${itsmIdeaVO.prcsStts eq 'B' ? '접수완료' : itsmIdeaVO.prcsStts eq 'I' ? '처리중' : '처리완료'}"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:if>
				<tr>
					<th><strong class="th_tit">제목</strong></th>
					<td>
						<form:input path="ideaTtl" id="ideaTtl" cssClass="text w100p" maxlength="50" title="제목" required="true"/>
					</td>
				</tr>
				<tr>
					<th><strong class="th_tit">내용</strong></th>
					<td>
						<form:textarea path="bltnbCn" id="bltnbCn" cssClass="text_area_mdl editor" title="내용" required="true"/>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<div id="atchFileUpload"></div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="btn_area">
		<c:choose>
			<c:when test="${searchVO.procType eq 'update' }">
				<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
					<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
				</c:if>
			</c:when>
			<c:otherwise>
				<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
			</c:otherwise>
		</c:choose>
		<a href="javascript:void(0)" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_cancel">취소</a>
	</div>
</form:form>
