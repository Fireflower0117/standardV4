<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 스마트에디터 설정 --%>
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "chgCn",
		sSkinURI : "${pageContext.request.contextPath}/resource/editor/SmartEditor2Skin.html",
		fCreator : "createSEditor2"
	});
	fncSvcList("select", "선택", "${itsmSysStsVO.svcSn}", "svcSn",${sessionScope.itsm_user_info.userSvcSn});
	if(${searchVO.procType eq 'insert'}) {
		fncInsertForm();
	} else {
		if(${fn:length(resultList) == 0}) {
			fncInsertForm();
		}
	}

	<c:if test="${fn:length(resultList) > 0 }">
		<c:forEach var="result" items="${resultList }">
			var user = {
				imprvSn : '${result.imprvSn}',
				dmndCdNm : '${result.dmndCdNm}',
				dmndTtl : '${result.dmndTtl}',
				prcsDt : '${result.prcsDt}'
			};
			userArray.push(user);
		</c:forEach>
	</c:if>


	$("#btn_submit").on("click", function () {
		oEditors.getById["chgCn"].exec("UPDATE_CONTENTS_FIELD", []);
		if(wrestSubmit(document.defaultFrm)){
			fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {
				itsmFncProc('${searchVO.procType}');
			});
			return false;
		}
	});
	
});
var oEditors = [];
var userArray = [];

<%-- insert 폼이거나,
 	처리내용 검색에서 아무것도 선택하지 않았을 때 초기화면 세팅 함수 --%>
function fncInsertForm() {
	$("#dmndCnTable").hide();
}
<%-- 처리사항 검색 --%>
function fncDmndCn(){
	if(!$("#svcSn").val()) {
		alert("서비스 구분을 선택하세요.")
		return false;
	}
	fncAjax('popFindPrcs.do',  $('#defaultFrm').serialize(), 'html', true, '', function(data){
		modal_show('60%','60%',data);
	});
}

<%-- 삭제 버튼 --%>
function fncDelCn(divnSn) {
	$("#tr_dmnd_"+divnSn).remove();
	if ($('.dmndArr').length < 1) {
		fncInsertForm();
	}

}
</script>
<form:form modelAttribute="itsmSysStsVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="chgSn" id="chgSn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">변경 이력 등록</h4></div>
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
	                	<form:select path="svcSn" id="svcSn" class="selec" title="서비스 구분" required="true">
	                	</form:select>
	                </td>
				</tr>
				<tr>
					<th scope="row"><strong class="th_tit">제목</strong></th>
					<td colspan="3">
						<form:input path="chgTtl" id="chgTtl" title="제목" maxlength="80" cssClass="text required" required="true" />
					</td>
				</tr>
	            <tr>
					<th rowspan="2"><strong>처리내용</strong></th>
	                <td colspan="3" id="dmndCnTd">
						<button type="button" class="btn btn_sml btn_rewrite" onclick="fncDmndCn()">처리내용 검색</button>
						<table id="dmndCnTable" style="border-top: 1px solid #dddddd !important; margin-top: 10px;" class="tbl col link board board_col_type01">
							<colgroup>
								<col style="width:10%;">
								<col>
								<col style="width:10%;">
								<col style="width:10%;">
							</colgroup>
							<thead>
								<tr>
									<th class='c'>구분</th>
									<th class='c'>요청내용</th>
									<th class='c'>처리일</th>
									<th class='c'>비고</th>
								</tr>
							</thead>
							<tbody  id="dmndCn">
							<c:if test="${fn:length(resultList) gt 0 }">
								<c:forEach var="result" items="${resultList }" varStatus="status">
									<tr id="tr_dmnd_${result.imprvSn}">
										<input class='dmndArr' type='hidden' name='dmndArr[${status.index}].imprvSn' value='${result.imprvSn}'>
										<td class='c ellipsis' style='padding: 8px 25px 8px 25px;'><c:out value="${result.dmndCdNm}"/></td>
										<td class='ellipsis'><c:out value="${result.dmndTtl}"/></td>
										<td class='c' style='padding: 8px 25px 8px 25px;' class='ellipsis'><c:out value="${result.prcsDt}"/></td>
										<td class='c' style='padding: 8px 25px 8px 25px;'><a href='javascript:void(0)' class='btn btn_sml btn_cancel' onclick="fncDelCn('${result.imprvSn}');">삭제 </a></td>
									</tr>
								</c:forEach>
							</c:if>
							</tbody>
						</table>

					</td>
				</tr>
				<tr>
					<td colspan="3">
						<form:textarea path="chgCn" id="chgCn" class="text_area_mdl" title="변경 내용" style="resize: none; height:400px;" maxlength="1000"/>
					</td>
				</tr>
	        </tbody>
	    </table>
	</div>
</form:form>
<div class="btn_area">
	<c:choose>
		<c:when test="${searchVO.procType eq 'update' }">
			<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
				<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
			</c:if>
		</c:when>
		<c:otherwise>
			<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
		</c:otherwise>
	</c:choose>
	<a href="javascript:void(0)" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_cancel">취소</a>
</div>