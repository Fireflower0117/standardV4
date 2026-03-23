<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">

$(document).ready(function(){

	<%-- view 하단 탭 --%>
	$("#serverGbn").val($('li.current').attr('id'));
	fncAddView();
	$(".tab_menu li").click(function(event) {
		$("#serverGbn").val($(this).attr('id'));
		fncAddView()
		$(this).addClass("current");
		$(this).siblings().removeClass("current");
	});

	<c:if test="${not empty itsmSinfoVO.svcSn }">
	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			itsmFncProc('delete');
		}
	});
	</c:if>

})


function fncProcAjax(procType, url){

	if (procType === 'insert'){
		procType = 'post';
	}else if (procType === 'update'){
		procType = 'patch';
	}else if (procType === 'delete'){
		procType = 'delete';
	}
	$.ajax({
		type : procType
		,url : url
		,data : $('#defaultFrm').serialize()
		,dataType : 'json'
		,success : function(data) {
			alert(data.message);
			if(procType === 'post') {
				$("#svcSn").val(data.svcSn)
			}
			<%--  폼 속성 설정 및 제출 --%>
			$("#defaultFrm").attr({"action" : data.returnUrl, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
		}
		,error: function (xhr, status, error) {
			$('.error').remove();
			let errors = xhr.responseJSON;

			if(procType === 'delete'){
				alert(errors[0].defaultMessage);
			}else{
				errors.forEach(function(e){
					$('#' + e.field).after('<span class="error">' + e.defaultMessage + '</span>');
				});
			}
		}
	});
}

<%-- view 하단 탭 --%>
function fncAddView(){
	fncAjax('addView.do', $("#defaultFrm").serialize(), 'html', true, '', function(data){
		$("#addTab").html(data);
	});
}

function fncDelMngr(userSerno) {

	if (confirm("담당자를 삭제하시겠습니까? ")) {
		$.ajax({
			type : "delete"
			,url : "procManager"
			,data: {"userSerno" : userSerno, "svcSn" : $("#svcSn").val()}
			,dataType : 'json'
			,success : function(data) {
				alert(data.message);
				<%--  폼 속성 설정 및 제출 --%>
				$("#defaultFrm").attr({"action" : data.returnUrl, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
			}
			,error: function (xhr, status, error) {
				$('.error').remove();
				let errors = xhr.responseJSON;

				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					errors.forEach(function(e){
						$('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
					});
				}
			}
		});
	}
}

function serverForm(){
	fncAjax('serverForm.do', $("#defaultFrm").serialize(), 'html', true, '', function(data){
		$("#addTab").html(data);
	});

}

function serverSubmit(){
	if($("#serverGbn").val() == 'net') {
		fileFormSubmit("defaultFrm", "update", function () {
			fncProcAjax('patch', "procServer");
		});
	} else {
		fncProcAjax('patch', "procServer");
	}



}
</script>
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="svcSn" id="svcSn"/>
	<input type="hidden" name="serverGbn" id="serverGbn">
	<input type="hidden" name="userSnList" id="userSnList"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">시스템 정보</h4></div>
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
					<th scope="row"><strong>서비스명</strong></th>
					<td colspan="3" ><c:out value="${itsmSinfoVO.svcNm }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>도메인 URL</strong></th>
					<td colspan="3"><c:out value="${itsmSinfoVO.svcUrl }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>서비스 담당자(정)</strong></th>
					<td><c:out value="${not empty itsmSinfoVO.svcMngr ? itsmSinfoVO.svcMngr : '-' }"/></td>
					<th scope="row"><strong>개발 담당자(정)</strong></th>
					<td><c:out value="${not empty itsmSinfoVO.devMngr ? itsmSinfoVO.devMngr : '-' }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>등록자</strong></th>
					<td><c:out value="${itsmSinfoVO.rgtrNm }"/></td>
					<th scope="row"><strong>등록일시</strong></th>
					<td><c:out value="${itsmSinfoVO.regDt }"/></td>
				</tr>
	        </tbody>
	    </table>
	</div>
	<div class="btn_area">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<c:if test="${grpAuthId eq 'allAdmin' || grpAuthId eq 'developer' || itsmSinfoVO.rgtrSn eq searchVO.loginSerno}">
				<a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmSinfoVO.svcSn }', 'svcSn')">수정</a>
				<a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
			</c:if>
		</c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">운영 정보</h4></div>
	</div>
	<div class="tmenu">
		<ul class="tab_menu">
			<li value="mngr" id="mngr" class="${empty searchVO.serverGbn or searchVO.serverGbn eq 'mngr'? 'current' : ''}"><a href="javascript:void(0);">담당자 정보</a></li>
			<li value="dev" id="dev" class="${searchVO.serverGbn eq 'dev' ? 'current' : ''}"><a href="javascript:void(0);">개발서버 정보</a></li>
			<li value="web" id="web" class="${searchVO.serverGbn eq 'web' ? 'current' : ''}"><a href="javascript:void(0);">WEB서버 정보</a></li>
			<li value="was" id="was" class="${searchVO.serverGbn eq 'was' ? 'current' : ''}"><a href="javascript:void(0);">WAS서버 정보</a></li>
			<li value="db" id="db" class="${searchVO.serverGbn eq 'db' ? 'current' : ''}"><a href="javascript:void(0);">DB서버 정보</a></li>
			<li value="net"  id="net" class="${searchVO.serverGbn eq 'net' ? 'current' : ''}"><a href="javascript:void(0);">네트워크 정보</a></li>
		</ul>
	</div>
	<div id="addTab" style="margin-top: 20px"></div>
</form:form>
