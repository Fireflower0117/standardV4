<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>

<form:form modelAttribute="itsmImpFncVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="imprvSn" id="imprvSn"/>
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
	            <col style="width:20%;">
	            <col style="width:30%;">
	            <col style="width:20%;">
	            <col style="width:30%;">
	        </colgroup>
	        <tbody>
	        	<tr>
	                <th scope="row"><strong class="th_tit">서비스 구분</strong></th>
            		<td colspan="3">
						<form:select path="svcSn" id="svcSn" title="서비스 구분" required="true" cssClass="select"></form:select>
                	</td>
	            </tr>
				<tr>
					<th scope="row"><strong class="th_tit">요청구분</strong></th>
					<td>
						<form:select path="dmndCd" id="dmndCd" title="요청구분" required="true" cssClass="select w30p">
							<form:option value="" label="선택"/>
							<form:option value="RE01" label="긴급"/>
							<form:option value="RE02" label="일반"/>
							<form:option value="RE03" label="중요"/>
						</form:select>
					</td>
					<th scope="row"><strong class="th_tit">처리요청일</strong></th>
					<td>
						<span class="calendar_input w150">
							<form:input path="dmndDt" id="dmndDt" title="처리요청일" required="true" cssClass="text"/>
						</span>

					</td>
				</tr>
	        	<tr>
	                <th scope="row"><strong class="th_tit">요청제목</strong></th>
            		<td colspan="3">
                		<form:input path="dmndTtl" id="dmndTtl" title="요청제목" maxlength="80" cssClass="text required" required="true" />
                	</td>
	            </tr>
	            <tr>
					<th scope="row"><strong>요청내용</strong></th>
	                <td colspan="3">
	                	<form:textarea path="dmndCn" id="dmndCn" class="text_area_big" title="요청내용" style="resize: none;height:400px;" maxlength="1000"/>
	                </td>
				</tr>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
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
<script type="text/javascript">
	$(document).ready(function(){
		fncSvcList("select", "선택", "${itsmImpFncVO.svcSn}", "svcSn",${sessionScope.itsm_user_info.userSvcSn})
		<%-- CKeditr 설정--%>
		CKEDITOR.replace("dmndCn",{height : 400, contentsCss: '${pageContext.request.contextPath}/component/itsm/js/ckeditor/contents.css'});

		fncDate('dmndDt')
		$("#dmndDt").datepicker('option', 'minDate' , '${today}')


		$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload"));

		$("#btn_submit").on("click", function () {
			$("#dmndCn").val(CKEDITOR.instances.dmndCn.getData());
			if(wrestSubmit(document.defaultFrm)){
				fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {
					itsmFncProc('${searchVO.procType}');
				});
				return false;
			}

		});

	});
	var oEditors = [];

</script>