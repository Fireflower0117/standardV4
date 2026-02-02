<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%--업로드된 템플릿파일 가져오기--%>
const fncTmplFileList = function(){
	
	$.ajax({
		method : "POST",
		url : "tmplFileList",
		data : {tmplFileSerno : $("#tmplFileSerno").val()},
		dataType : "HTML",
		success : function (data){
			$("#div_tmplFiles").html(data);
		},error : function(xhr, status, error){
		 	if (xhr.status == 401) {
				window.location.reload();
		 	}
		 	alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	});
}

<%--템플릿파일 업로드 --%>
const fncUploadTmplFile = function(obj){
	
	var maxFileSize= 10 * 1024 * 1024;
	var targetFiles = $(obj)[0].files;
	
	var fileChk = true;
	for(var i =0; i < targetFiles.length; i++){
		if(fileChk && (targetFiles[i].size > maxFileSize)){
			alert("최대 10MB까지 첨부가능 합니다.");
			fileChk = false;
		}			
	}
	
	if(!fileChk){return false;}

	const formData = new FormData();
	if($("#tmplFileSerno").val()){
		formData.append("tmplFileSerno", $("#tmplFileSerno").val());
	}
	for(var i =0; i < targetFiles.length; i++){
		formData.append("files", targetFiles[i]);			
	}
	
	$.ajax({
		method : "POST",
		url : "uploadTmplFile",
		data : formData,
		dataType : "JSON",
		contentType : false,	
		processData : false,	
		enctype : "multipart/form-data",
		error : function(xhr, status, error){
	 		if (xhr.status == 401) {
				window.location.reload();
		 	}
	 		alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		},
		beforeSend : function(){
			fncLoadingStart();
		},
		complete : function(){
			fncLoadingEnd();
		}
	}).done(function(data){
		if(data.result == "fail"){
			alert(data.failMsg);
		}else{
			if(data.tmplFileSerno){
				$("#tmplFileSerno").val(data.tmplFileSerno);
				fncTmplFileList();
			}
		}
	});
}

<%-- 등록시 템플릿파일 먼저 등록해 미리보기 이미지 생성 --%>
const fncSubmitTmpl = function(){ 
	if(CKEDITOR.instances.editrCont.getData() && CKEDITOR.instances.editrCont.getData().length){
		var target = $("#td_editor").find("iframe").contents().find(".cke_editable")[0]; 
		if(target == null || typeof target == "undefined"){
			alertMsg("editrCont", "red", "에디터 소스 모드를 종료해주세요.");
			return false;
		}
		html2canvas(target).then(function(canvas) {
			var imgDataUrl = canvas.toDataURL("image/png");
			
			var blobBin = atob(imgDataUrl.split(',')[1]);	// base64 데이터 디코딩
		    var array = [];
		    for (var i = 0; i < blobBin.length; i++) {
		        array.push(blobBin.charCodeAt(i));
		    }
		    var file = new Blob([new Uint8Array(array)], {type: "image/png"});	// Blob 생성
		    
		    const formData = new FormData();
		    formData.append("files", file);	// file data 추가
			
			if($("#prvwFileSerno").val()){
				formData.append("tmplFileSerno", $("#prvwFileSerno").val());
			}
		    formData.append("divn", "preview");
			
			$.ajax({
				method : "POST",
				url : "uploadTmplFile",
				data : formData,
				dataType : "JSON",
				contentType : false,
				processData : false,
				enctype : "multipart/form-data",
				success : function (data){
					$("#prvwFileSerno").val(data.tmplFileSerno);
				},error : function(xhr, status, error){
		 			if (xhr.status == 401) {
						window.location.reload();
			 		}
		 			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
				},
				beforeSend : function(){
					fncLoadingStart();
				},
				complete : function(){
					<%-- ckEditor 데이터 editrCont에 담아주기 --%>
					$("#editrCont").val(CKEDITOR.instances.editrCont.getData());
					<%-- 등록 / 수정 --%>
					fncProc('<c:out value="${searchVO.procType}"/>');
					fncLoadingEnd();
				}
			});
		});
	}
}

<%-- 템플릿 유형 변경시 템플릿타입 불러오기--%>
const fncChangeSel = function(obj){
	var $target = $(obj).next();
	
	$.ajax({
		method : "POST",
		url : "changeSel",
		data : {tmplCl : $(obj).val()},
		dataType : "HTML",
		success : function(data){
			$target.html(data);
			$target.children("option").eq(0).html($target.attr("data-text"));
			if($target.children("option").length > 1){
				$target.prop("disabled", false);
			}else{
				$target.prop("disabled", true);
			}
		},error : function(xhr, status, error){
 			if (xhr.status == 401) {
				window.location.reload();
	 		}
 			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	});
}

<%-- 선택된 파일 삭제--%>
const fncDelTmplFile = function(){
	
	var delFileList = [];
	var $targetChk = $(".chkList input[type='checkbox']:checked");
	
	if(!$targetChk.length){
		alert("선택된 파일이 없습니다.");
		return false;
	}else{
		if(!confirm("파일을 삭제하시겠습니까?")){
			return false;
		}
	}
	
	$targetChk.each(function(){
		delFileList.push($(this).attr("data-fileseqo"));
	});
	
	$.ajax({
		method : "POST",
		url : "delTmplFile",
		data : {tmplFileSerno : $("#tmplFileSerno").val(), tempArr : delFileList.toString()},
		dataType : "JSON",
		success : function (data){
			alert(data.message);
		},error : function(xhr, status, error){
			if (xhr.status == 401) {
				window.location.reload();
	 		}
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		},
		beforeSend : function(){
			fncLoadingStart();
		},
		complete : function(){
			fncLoadingEnd();
		}
	}).done(function(data){
		if(data.result == "success"){
			fncTmplFileList();
		}
	});
}

const fncCopyToClip = function(obj) {
	
	var copyText = $(obj).data("link");
	$("#btn_copy").attr("data-clipboard-text", copyText);
    $("#btn_copy").trigger("click");
    $("#btn_copy").attr("data-clipboard-text", "");
}

const fncCopyToClipSet = function(target){
	
	var clipboard = new ClipboardJS(target);

	clipboard.on('success', function(e) {
		alert(e.text+"\n복사되었습니다.");
		e.clearSelection();
	});

	clipboard.on('error', function(e) {
		alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
	});
}

$(document).ready(function(){
	
	<%-- 템플릿유형 selectBox 조회--%>
	fncCodeList("TMCL", "select", "템플릿 유형", '<c:out value="${contTmplVO.tmplCl}"/>', "", "tmplCl");
	<%-- 템플릿타입 selectBox 조회--%>
	fncCodeList("${contTmplVO.tmplCl}", "select", "템플릿 유형", '<c:out value="${contTmplVO.tmplTp}"/>', "", "tmplTp");
	
	<%-- CKeditr 설정--%>
	CKEDITOR.replace("editrCont",{height : 400, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>'+'/ma/js/ckeditor/contents.css'});
	
	<%-- 파일업로드 경로 복사 trigger--%>
	fncCopyToClipSet("#btn_copy");
	
	<%-- 저장된 tmplfileList 불러오기--%>
	<c:if test="${not empty contTmplVO.tmplSerno}">
		fncTmplFileList();
	</c:if>
	
	$("#btn_tmpl_submit").on("click", function(){

		<%-- 에디터 유효성 검사 --%>
		if(!CKEDITOR.instances.editrCont.getData() || !CKEDITOR.instances.editrCont.getData().length){
			alertMsg("editrCont", "red", "에디터 내용을 입력해주세요");
			CKEDITOR.instances.editrCont.focus();
			return false;
		}else{
			if(wrestSubmit(document.defaultFrm)){
				fncSubmitTmpl();
			}			
		}
		
	});
	
	$('#btn_tmpl_delete').on('click', function(){
		if(confirm("주의! 미리보기 및 템플릿 파일도 함께 삭제됩니다.")){
			if(wrestSubmit(document.defaultFrm)){
				fncProc('delete');
			}
		}
	});

	<%-- 템플릿유형 바뀔때마다 템플릿타입 불러오기--%>
	$('#tmplCl').on('change', function(){
		fncChangeSel($(this));
	});

	<%-- 첨부파일 업로드 --%>
	$('#tmplFile').on('change', function(){
		fncUploadTmplFile($(this));
	});

	<%-- 첨부파일 삭제 --%>
	$('#file_del').on('click', function(){
		fncDelTmplFile();
	});
	
	<%-- 클립보드 복사--%>
	$(document).on("click", '.click_clipboard', function(){
		fncCopyToClip(this);
	});
});
</script>
<form:form modelAttribute="contTmplVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="tmplSerno"/>
	<form:hidden path="prvwFileSerno"/>
	<form:hidden path="tmplFileSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>유형/타입</th>
				<td>
				<select name="tmplCl" id="tmplCl" title="템플릿 유형" class="w50p" required="required">
				</select>
				<select name="tmplTp" id="tmplTp" title="템플릿 타입" class="w48p" required="required"> 
				</select>
				</td>
				<th scope="row"><span class="asterisk">*</span>템플릿 설명</th>
				<td>
					<form:input path="tmplExpl" title="템플릿 설명" cssClass="w100p" maxlength="80" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><strong>템플릿 파일</strong></th>
				<td colspan="3">
					<div class="filebox">
							<c:if test="${empty contTmplVO.tmplSerno and sessionScope.SESSION_WRITE_BTN_KEY or not empty contTmplVO.tmplSerno and searchVO.loginSerno eq contTmplVO.regrSerno}">
								<label for="tmplFile" class="btn bd blue">파일선택 <i class="xi-upload"></i></label>
								<label class="btn bd red" id="file_del">파일삭제<i class="xi-close"></i></label>
							</c:if>
			    			<input type="file" id="tmplFile" name="tmplFile" class="file_input" multiple="multiple"/>
			    			<div id="div_tmplFiles"></div><button id="btn_copy" class="disno"></button>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>에디터 내용<br/>[ <c:out value="${empty contTmplVO.tmplCd ? 'TMPL_TEMP' : contTmplVO.tmplCd }"/> ] </th>  
				<td colspan="3" id="td_editor">
					<form:textarea path="editrCont" class="txt_area w100p" value="<c:out value = '${contTmplVO.editrCont}' escapeXml = 'false'/>"/> 
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<c:if test="${empty contTmplVO.tmplSerno and sessionScope.SESSION_WRITE_BTN_KEY or not empty contTmplVO.tmplSerno and searchVO.loginSerno eq contTmplVO.regrSerno}">
		<button type="button" id="btn_tmpl_submit" class="btn blue"><c:out value="${empty contTmplVO.tmplSerno ? '등록' : '수정'}"/></button>
		<c:if test="${not empty contTmplVO.tmplSerno}">
			<button type="button" id="btn_tmpl_delete" class="btn red">삭제</button>
		</c:if>
	</c:if>
	<button type="button" id="btn_list" class="btn gray">취소</button>
</div>
