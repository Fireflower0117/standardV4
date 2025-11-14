<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

	fncCodeList("LG", "select", "선택", "<c:out value="${logoVO.itmCd}"/>","", "itmCd", "", "ASC");

	<%-- 링크여부에 따른 url, 대상 tr태그 출력 여부 실행--%>
	fnLinkYn($('#lnkYn').prop('checked'));

	<%-- 첨부파일 등록폼 생성 --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "byteImage", '1' , '20' ));

	$('#btn_submit').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			<%-- 활성화 항목 중복 등록 판단 --%>
			$.ajax({
				type : "post"
				,url : "itmActvtYnChk"
				,data : $('#defaultFrm').serialize()
				,dataType: "json"
				,success : function (data){
					if(data > 0 && $("#actvtYnY").is(":checked")){
						alert("활성화된 항목을 최신화 합니다.")
					}
					<%-- 파일 업로드후 ATCh_FILE_ID  가져오기--%>
					fileFormSubmit("defaultFrm", "<c:out value="${searchVO.procType}"/>", function () {
						if(wrestSubmit(document.defaultFrm)){
							fncProc('<c:out value="${not empty logoVO.logoSerno ? \'update\' : \'insert\'}"/>');
						}
					});
				},error: function (xhr, status, error) {

					// 로그인 세션 없는 경우
					if (xhr.status == 401) {
						window.location.reload();
					}

					$('.error').remove();
					let errors = xhr.responseJSON;

					for (let i = 0; i < errors.length; i++) {
						let e = errors[i];
						$('#' + e.field).parent().append('<p class="error_txt">' + e.defaultMessage + '</p>');
					}
				}
			});
		} // if end
	});

	<%-- 링크여부 체크시 url, 대상 input창 보이기 --%>
	$('#lnkYn').on('click', function(){
		var chk = $(this).prop('checked')
		fnLinkYn(chk);
	});

});

<%-- 링크여부에 따른 url, 대상 tr태그 출력 여부 --%>
const fnLinkYn = function(chk){
	$('#lnkYnTr').toggle(chk);
	$('#url, #lnkTgtCd').prop('required', chk).attr('required', chk);
}

</script>
<form:form modelAttribute="logoVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="logoSerno"/>
	<form:hidden path="atchFileId" title="로고 이미지" required="true"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(항목, 링크여부, 활성화여부, URL, 대상, 로고이미지로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>항목</th>
				<td colspan="3">
					<form:select path="itmCd" title="항목" cssClass="w20p" required="true">
					</form:select>
				</td>
			</tr>
			<tr>
				<th scope="row">링크</th>
				<td>
					<span class="chk">
						<span class="cbx"><form:checkbox path="lnkYn" value="Y" label="링크여부"/></span>
					</span>
				</td>
				<th scope="row">활성여부</th>
				<td>
					<span class="chk">
						<span class="radio"><form:radiobutton path="actvtYn" value="Y" label="활성화" checked="true"/></span>
						<span class="radio"><form:radiobutton path="actvtYn" value="N" label="비활성화"/></span>
					</span>
				</td>
			</tr>
			<tr id="lnkYnTr">
				<th scope="row"><span class="asterisk">*</span>url</th>
				<td>
					<form:input path="url" cssClass="w80p" title="url" maxlength="300" placeholder="https://www.naver.com/"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>대상</th>
				<td>
					<form:select path="lnkTgtCd" title="대상">
						<form:option value="" label="선택"/>
						<form:option value="self" label="현재창"/>
						<form:option value="blank" label="새창"/>
					</form:select>
				</td>
			</tr>
			<tr>
	        	<th><strong>로고 이미지</strong></th>
	            <td colspan="3">
	            	<div id="atchFileUpload"></div>
	            </td>
	        </tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY }">
		<button type="button" id="btn_submit" class="btn blue">${empty logoVO.logoSerno ? '등록' : '수정'}</button>
		<c:if test="${not empty logoVO.logoSerno}"><button type="button" id="btn_del" class="btn red">삭제</button></c:if>
		<button type="button" id="btn_list" class="btn gray">취소</button>
	</c:if>
</div>
