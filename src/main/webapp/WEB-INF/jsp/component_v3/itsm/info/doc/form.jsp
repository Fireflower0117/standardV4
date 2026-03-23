<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
var oEditors = [];
$(document).ready(function(){
	<%-- CKeditr 설정--%>
	CKEDITOR.replace("docCont",{height : 400, contentsCss: '${pageContext.request.contextPath}/component/itsm/js/ckeditor/contents.css'});

	fncCodeList("DOGB", "select", "선택", "${itsmDocVO.docGbn}", "", "docGbn", "", "ASC");
	fncCodeList("DOC", "select", "선택", "${itsmDocVO.docAreaCd}", "", "docAreaCd", "", "ASC");
	fncSvcList("select", "선택", "${itsmDocVO.svcSn}", "svcSn",${sessionScope.itsm_user_info.userSvcSn});

	<c:if test="${searchVO.procType eq 'update'}">
		fncCodeList("${itsmDocVO.docAreaCd}", "select", "선택", "${itsmDocVO.docStepCd}", "", "docStepCd", "", "ASC");
	</c:if>

	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload", 1));

	$("#btn_submit").on("click", function () {
		$("#docCont").val(CKEDITOR.instances.docCont.getData());
		if(wrestSubmit(document.defaultFrm)){
		    fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {
				itsmFncProc("${searchVO.procType}");
			});
			return false;
		}
	});
	
});

function fncDocArea(val){
	if(val){
		fncCodeList(val, "select", "선택", "${itsmDocVO.docStepCd}", "", "docStepCd", "", "ASC");
	}else{
		$("#docStepCd").html('<option>선택</option>')
	}
}


</script>
<form:form modelAttribute="itsmDocVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="docSn"/>
	<form:hidden path="docNo"/>
	<form:hidden path="atchFileId" id="atchFileId" title="첨부파일" required="required"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">문서 정보</h4></div>
		<div class="tbl_right"><span class="essential_txt"><span>*</span>는 필수입력</span></div>
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
					<th scope="row"><strong class="th_tit">서비스 구분</strong></th>
					<td>
						<form:select path="svcSn" id="svcSn" title="서비스 구분" required="true">
						</form:select>
					</td>
					<th scope="row"><strong class="th_tit">문서 구분</strong></th>
					<td>
						<form:select path="docGbn" id="docGbn" title="문서 구분" required="true">
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong class="th_tit">영역</strong></th>
					<td>
						<form:select path="docAreaCd" id="docAreaCd" title="영역" required="true" onchange="fncDocArea(this.value)">
						</form:select>
					</td>
					<th scope="row"><strong class="th_tit">단계</strong></th>
					<td>
						<form:select path="docStepCd" id="docStepCd" title="단계" required="true">
						</form:select>
					</td>
				</tr>
	        	<tr>
	                <th scope="row"><strong class="th_tit">문서 이름</strong></th>
            		<td colspan="3">
                		<form:input path="docNm" id="docNm" title="문서 이름" maxlength="30" cssClass="text required" required="true" />
                	</td>
	            </tr>
	            <tr>
					<th scope="row">문서 내용</th>
					<td colspan="3">
						<form:textarea path="docCont" id="docCont" class="text_area_big" title="문서 내용" style="resize: none;height:400px;" maxlength="900"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong class="th_tit">첨부파일</strong></th>
					<td colspan="3">
						<div id="atchFileUpload"></div>
					</td>
				</tr>

	        </tbody>
	    </table>
	</div>
</form:form>
<div class="btn_area">
	<c:choose>
		<c:when test="${searchVO.procType eq 'update' }">
			<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY}">
				<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
			</c:if>
		</c:when>
		<c:otherwise>
			<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
		</c:otherwise>
	</c:choose>
	<a href="javascript:void(0)" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_cancel">취소</a>
</div>