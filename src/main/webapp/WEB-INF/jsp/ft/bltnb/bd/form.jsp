<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

	<%-- 첨부파일 등록폼 생성 --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload", '5' , '20' ));
	
	<%-- CKeditr 설정--%>
	CKEDITOR.replace("bltnbCtt",{height : 400, contentsCss: '${pageContext.request.contextPath}/ma/js/ckeditor/contents.css'});

	
	$('#btn_bltnb_submit').on('click', function(){
		var submitCheck = false;
		if("${not empty empty bltnbVO.bltnbSerno}"){
			<%-- update시 작성자인지 체크--%>
			if("${sessionScope.ft_user_info.userSerno eq bltnbVO.regrSerno}"){
				submitCheck = true;	
			}else{
				alert("수정할 권한이 없습니다.")
				return false;
			}
		}else{
			submitCheck = true;
		}
		if(submitCheck){
			<%-- 에디터 유효성 검사 --%>
			if(!CKEDITOR.instances.editrCont.getData() || !CKEDITOR.instances.editrCont.getData().length){
				alertMsg("bltnbCtt", "red", "에디터 내용을 입력해주세요");
				CKEDITOR.instances.editrCont.focus();
				return false;
			}else{
			$("#editrCont").val(CKEDITOR.instances.editrCont.getData());
				<%-- 유효성 검사후 등록--%>
				if(wrestSubmit(document.defaultFrm)){
					<%-- 파일 업로드후 ATCh_FILE_ID  가져오기--%>
					fileFormSubmit("defaultFrm", "${empty bltnbVO.bltnbSerno ? 'insert' : 'update'}", function () {
						fncProc("${empty bltnbVO.bltnbSerno ? 'insert' : 'update'}");
					});
				};
			}
		}
	});
	
});
</script>
<form:form modelAttribute="bltnbVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="bltnbSerno"/>
	<form:hidden path="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<colgroup>
			<col class="w20p">
			<col class="w30p">
			<col class="w20p">
			<col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>제목</th>
				<td colspan="3">
					<form:input path="bltnbTitl" title="제목" cssClass="w100p" maxlength="80" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>내용</th>
				<td colspan="3">
					<form:textarea path="bltnbCtt" id="editrCont" class="txt_area w100p" value="<c:out value = '${contTmplVO.editrCont}' escapeXml = 'false'/>"/>
				</td>
			</tr>
			<tr>
	        	<th><strong>첨부파일</strong></th>
	            <td colspan="3">
	            	<div id="atchFileUpload"> </div>
	            </td>
	        </tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<button type="button" id="btn_bltnb_submit" class="btn blue"><c:out value="${empty bltnbVO.bltnbSerno ? '등록' : '수정'}"/></button>
	<button type="button" id="btn_<c:out value="${empty bltnbVO.bltnbSerno ? 'list' : 'view'}"/>" class="btn gray">취소</button>
</div>
</body>
