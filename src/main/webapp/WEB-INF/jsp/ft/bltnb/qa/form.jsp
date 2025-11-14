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

	
	<%-- 공개글, 비밀글 성정 여부에따라 disabled, required 설정 --%>
	$('.scretYn').on('click', function(){
		if("${empty bltnbVO.bltnbSerno}" == "true"){
			if($(this).val() == 'Y'){
					$("#bltnb_pswd").prop("disabled", false);
					$("#bltnb_pswd_check").prop("disabled", false);
					$("#bltnb_pswd").attr("required","required");
					$("#bltnb_pswd_check").attr("required","required");
			}
		}
		if($(this).val() == 'N'){
			$("#bltnb_pswd").val("");
			$("#bltnb_pswd_check").val("");
			$("#bltnb_pswd").prop("disabled", true);
			$("#bltnb_pswd_check").prop("disabled", true);
			$("#bltnb_pswd").removeAttr("required");
			$("#bltnb_pswd_check").removeAttr("required");
			if($(this).val() == 'N'){
				$("#check_pswd").prop("checked", false);
			}
		}
	})
	
	<%-- 수정폼, 비밀글 일때만 생성 --%>
	<c:if test="${not empty bltnbVO.bltnbSerno and bltnbVO.scretYn eq 'Y'}">
		$('#check_pswd').on('click', function(){
			if($(this).prop("checked")){
				if($("#scretYn_Y").prop("checked")){
					$("#bltnb_pswd").prop("disabled", false);
					$("#bltnb_pswd_check").prop("disabled", false);
					$("#bltnb_pswd").attr("required","required");
					$("#bltnb_pswd_check").attr("required","required");
				}else{
					alert("비밀글을 체크해주세요.");
					$(this).prop("checked", false);
					return false;
				}
			}else{
				$("#bltnb_pswd").val("");
				$("#bltnb_pswd_check").val("");
				$("#bltnb_pswd").prop("disabled", true);
				$("#bltnb_pswd_check").prop("disabled", true);
				$("#bltnb_pswd").removeAttr("required");
				$("#bltnb_pswd_check").removeAttr("required");
			}
		});
	</c:if>

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
				<th scope="row"><span class="asterisk">*</span>비밀글여부</th>
				<td>
					<span class="chk">
						<span class="radio"><form:radiobutton path="scretYn" id="scretYn_N" class="scretYn" title="비밀글여부"  value="N" required="true" checked="true"/><label for="scretYn_N">공개글</label></span>
						<span class="radio"><form:radiobutton path="scretYn" id="scretYn_Y" class="scretYn" title="비밀글여부"  value="Y" required="true"/><label for="scretYn_Y">비밀글</label></span>
					</span>
					<c:if test="${not empty bltnbVO.bltnbSerno and bltnbVO.scretYn eq 'Y'}">
		            	<span class="cbx">
		            		<input type="checkbox" id="check_pswd"/><label for="check_pswd">비밀번호 변경</label>
		            	</span>
	            	</c:if>
				</td>
				<th scope="row">비밀번호</th>
				<td>
					<input type="password" name="bltnbPswd" id="bltnb_pswd" title="비밀번호" class="w49p" maxlength="10"  <c:out value="${empty bltnbVO.bltnbSerno or bltnbVO.scretYn eq 'Y' ? 'disabled=disabled' : ''}"/> autocomplete="off"/>
					<input type="password" name="bltnbPswdCheck" id="bltnb_pswd_check" title="비밀번호확인" class="w48p" maxlength="10" <c:out value="${empty bltnbVO.bltnbSerno or bltnbVO.scretYn eq 'Y' ? 'disabled=disabled' : ''}"/> autocomplete="off"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>내용</th>
				<td colspan="3">
					<form:textarea path="bltnbCtt" id="editrCont" class="txt_area w100p" value="<c:out value='${contTmplVO.editrCont}' escapeXml = 'false'/>"/>
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
