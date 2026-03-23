<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javascript">
$(document).ready(function(){

	<%-- CKeditr 설정--%>
	CKEDITOR.replace("rqrCn",{height : 400, contentsCss: '${pageContext.request.contextPath}/component/itsm/js/ckeditor/contents.css'});

	fncSvcList("select", "선택", "${itsmRqstVO.svcSn}", "svcSn",${sessionScope.itsm_user_info.userSvcSn});
	fncCodeList("RP", "select", "선택", "${itsmRqstVO.rqrProc}", "", "rqrProc", "", "ASC");

	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload"));

	$("#btn_submit").on("click", function () {
		<%-- 에디터 유효성 검사 --%>
		if(!CKEDITOR.instances.rqrCn.getData() || !CKEDITOR.instances.rqrCn.getData().length){
			alertMsg("rqrCn", "red", "요구정의 진행현황 : 필수 입력입니다.");
			CKEDITOR.instances.rqrCn.focus();
			wrestSubmit(document.defaultFrm)
			return false;
		}else{
			$("#msg_rqrCn").remove();
			$("#rqrCn").val(CKEDITOR.instances.rqrCn.getData());
			if(wrestSubmit(document.defaultFrm)){
				fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {
					itsmFncProc('${searchVO.procType}');
				});
				return false;
			}
		}
		
	});
	
});
var oEditors = [];

<%-- 요청자 검색 팝업 --%>
function fncPopFindUser(divn){
	if(!$("#svcSn").val()){
		alert("서비스 구분을 선택해주세요.")
		$("#svcSn").focus();
		return false
	}

	$.ajax({
		method   : "POST",
		url      : "popFindUser.do",
		dataType : "html",
		data     : {"mngrGbn" : divn, "svcSn" : $("#svcSn").val()},
		success  : function(data) {
			modal_show('60%','80%', data);
		}
	});

}

function fncIptVal(id, color ,msg){ 
	$("#msg_" + id).remove();
	if(color && msg){
		var msgHtml = '<strong id="msg_' + id + '" ><font color=' + color + '>&nbsp;' + msg + '</font></strong>';
		$("#"+id).parent().append(msgHtml);
	}
};
</script>
<form:form modelAttribute="itsmRqstVO" name="defaultFrm" id="defaultFrm" method="post">
	<form:hidden path="rqrSn" id="rqrSn" />
	<form:hidden path="atchFileId" id="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">요청정보</h4></div>
		<div class="tbl_right"><span class="essential_txt"><span>*</span>는 필수입력</span></div>
	</div>
	<div class="tbl_wrap">
	    <table class="board_row_type01">
	        <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
	        <colgroup>
				<col style="width:20%">
				<col style="width:30%">
				<col style="width:20%">
				<col style="width:30%">
			</colgroup>
	        <tbody>
				<tr>
					<th scope="row"><strong class="th_tit">서비스구분</strong></th>
					<td colspan="3">
						<form:select path="svcSn" id="svcSn" title="서비스구분" class="selec" required="true" style="width:18%;"></form:select>
					</td>
				</tr>
				<tr>
					<th><strong class="th_tit">요구사항 ID</strong></th>
					<td>
						<form:input path="rqrId" id="rqrId" cssClass="text w50p" maxlength="10" title="요구사항 ID" required="true"/>
					</td>
					<th><strong class="th_tit">요구사항 항목</strong></th>
					<td>
						<form:input path="rqrItm" id="rqrItm" cssClass="text w100p" maxlength="50" title="요구사항 항목" required="true"/>
					</td>

				</tr>
				<tr>
					<th><strong class="th_tit">요구사항 상세 ID</strong></th>
					<td>
						<form:input path="rqrDtlId" id="rqrDtlId" cssClass="text w50p" maxlength="20" title="요구사항 상세 ID" required="true"/>
					</td>
					<th><strong class="th_tit">세부내역</strong></th>
					<td>
						<form:input path="rqrDtl" id="rqrDtl" cssClass="text w100p" maxlength="50" title="세부내역" required="true"/>
					</td>
				</tr>
				<tr>
					<th><strong>출처</strong></th>
					<td>
						<form:input path="rqrSrc" id="rqrSrc" cssClass="text w50p" maxlength="10" title="출처"/>
					</td>
					<th><strong class="th_tit">분류</strong></th>
					<td>
						<form:input path="rqrCls" id="rqrCls" cssClass="text w50p" maxlength="10" title="분류" required="true"/>
					</td>
				</tr>
				<tr>
					<th><strong>고객담당자</strong><button type="button" class="btn btn_sml btn_add mar_l10" onclick="fncPopFindUser('MNGB02');">검색</button></th>
					<td>
						<span id="custMngrNm"><c:out value="${empty itsmRqstVO.custMngrNm? '-' : itsmRqstVO.custMngrNm}"/></span>
						<form:hidden path="custMngrSn" id="custMngrSn" cssClass="text w100p" maxlength="20" title="고객담당자"/>
					</td>
					<th><strong>개발담당자</strong><button type="button" class="btn btn_sml btn_add mar_l10" onclick="fncPopFindUser('MNGB01');">검색</button></th>
					<td>
						<span id="dvlpMngrNm"><c:out value="${empty itsmRqstVO.dvlpMngrNm? '-' : itsmRqstVO.dvlpMngrNm}"/></span>
						<form:hidden path="dvlpMngrSn" id="dvlpMngrSn" cssClass="text w100p" maxlength="20" title="개발담당자"/>
					</td>
				</tr>
				<tr>
					<th><strong class="th_tit">진행현황</strong></th>
					<td colspan="3">
						<form:select path="rqrProc" id="rqrProc" cssClass="sel w20p" title="진행현황" required="true">
						</form:select>
					</td>
				</tr>
                <tr>
					<th><strong class="th_tit">요구정의 진행현황</strong></th>
                    <td colspan="3">
						<form:textarea path="rqrCn" id="rqrCn" class="text_area_big" title="요구정의 진행현황" required="true" style="height: 400px;`"/>
                    </td>
                </tr>
				<tr>
                    <th><strong>첨부파일</strong></th>
                    <td colspan="3">
                        <div id="atchFileUpload"></div>
                    </td>
                </tr>
	        </tbody>
	    </table>
	</div>
</form:form>
<div class="btn_area">
	<a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
	<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">취소</a>
</div>