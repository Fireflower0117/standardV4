<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 등록, 수정 클릭시 --%>
	$('#btn_submit').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			fncProcAjax("${empty itsmSinfoVO.svcSn ? 'insert' : 'update'}");
		}
	});

});

const fncProcAjax = function(procType, func, errFunc, compFunc){

	if (procType === 'insert'){
		procType = 'post';
	}else if (procType === 'update'){
		procType = 'patch';
	}

	$.ajax({
		type 		: procType
		,url 		: 'proc'
		,data 		: $('#defaultFrm').serialize()
		,dataType 	: 'json'
		,success 	: function(data) {

			if(func !== undefined && typeof func === "function"){
				func(data);
			} else{
				alert(data.message);
				if(procType === 'post') {
					$("#svcSn").val(data.svcSn)
				}
				// 폼 속성 설정 및 제출
				$("#defaultFrm").attr({"action" : data.returnUrl, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
			}

		}
		,error		: function (xhr, status, error) {

			// 로그인 세션 없는 경우
			if (xhr.status == 401) {
				window.location.reload();
			}

			if(errFunc !== undefined && typeof errFunc === "function"){
				errFunc();
			} else{
				$('.error_txt').remove();
				let errors = xhr.responseJSON;

				// 오류 메세지 출력
				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					for (let i = 0; i < errors.length; i++) {
						let e = errors[i];

						// List 오류
						if(e.codes.some(item => item.includes('java.util.List'))){
							alert(e.defaultMessage);

							// 일반 오류
						} else{
							$('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
						}

					}
				}
			}
		}
		,beforeSend : function(){
			fncLoadingStart();
		}
		,complete 	: function(){

			fncLoadingEnd();

			if(compFunc !== undefined && typeof compFunc === "function"){
				compFunc();
			}
			return false;
		}
	});
}
</script>
<form:form modelAttribute="itsmSinfoVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="svcSn" id="svcSn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">시스템 정보</h4></div>
		<div class="tbl_right"><span class="essential_txt"><span>*</span>는 필수입력</span></div>
	</div>
	<div class="tbl_wrap">
	    <table class="board_row_type01">
	        <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
	        <colgroup>
	            <col style="width:20%;">
	            <col>
	            <col style="width:20%;">
	            <col>
	        </colgroup>
	        <tbody>
				<tr>
					<th scope="row"><strong class="th_tit">서비스명</strong></th>
					<td colspan="3">
						<form:input path="svcNm" id="svcNm" title="서비스명" maxlength="30" cssClass="text required" required="true" />
					</td>
				</tr>
				<tr>
					<th scope="row"><strong class="th_tit">도메인 URL</strong></th>
					<td colspan="3">
						<form:input path="svcUrl" id="svcUrl" title="도메인 URL" maxlength="100" cssClass="text required" required="true" />
					</td>
				</tr>
				<tr>
					<th scope="row">서비스 담당자(정)</th>
					<td>
						<form:input path="svcMngr" id="svcMngr" title="서비스 담당자" maxlength="30" cssClass="text "/>
					</td>
					<th scope="row">개발 담당자(정)</th>
					<td>
						<form:input path="devMngr" id="devMngr" title="개발 담당자" maxlength="30" cssClass="text "/>
					</td>
				</tr>
				<%--<tr>
					<th scope="row">서비스 담당자</th>
					<td>
						<form:input path="svcMngr" id="svcMngr" title="서비스 담당자" maxlength="30" cssClass="text "/>
					</td>
					<th scope="row">서비스 담당자(부)</th>
					<td>
						<form:input path="svcMngrSub" id="svcMngrSub" title="서비스 담당자(부)" maxlength="30" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th scope="row">개발 담당자</th>
					<td>
						<form:input path="devMngr" id="devMngr" title="개발 담당자" maxlength="30" cssClass="text "/>
					</td>
					<th scope="row">개발 담당자(부)</th>
					<td>
						<form:input path="devMngrSub" id="devMngrSub" title="개발 담당자(부)" maxlength="30" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th scope="row">정보시스템 등급</th>
					<td>
						<form:input path="svcRank" id="svcRank" title="정보시스템 등급" maxlength="10" cssClass="text "/>
					</td>
					<th scope="row">언어</th>
					<td>
						<form:input path="svcLng" id="svcLng" title="언어" maxlength="30" cssClass="text" />
					</td>
				</tr>--%>
	        </tbody>
	    </table>
	</div>
</form:form>
<div class="btn_area c">
	<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY}">
		<a  href="javascript:void(0)"  id="btn_submit" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '다음' : '수정'}</a>
	</c:if>
	<a href="javascript:void(0)" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_cancel">취소</a>
</div>
