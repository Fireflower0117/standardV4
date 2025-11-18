<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	var oEditors = [];
	$(document).ready(function(){
		fncDate("inspBegnDt");
		let procType = "${searchVO.procType}";
		fncSvcList("select", "선택", "${itsmInspMngVO.svcSn}", "svcSn");

		if(procType == 'update') {
			<%-- 스마트에디터 설정 --%>
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "inspCn",
				sSkinURI : "${pageContext.request.contextPath}/resource/editor/SmartEditor2Skin.html",
				fCreator : "createSEditor2"
			});
			$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload"));

		}

		$("#btn_submit").click(function(){

			if(wrestSubmit(document.defaultFrm)){
				oEditors.getById["inspCn"].exec("UPDATE_CONTENTS_FIELD", []);
				fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {fncPageBoard("submit", "${searchVO.procType}Proc.do")});
				return false;
			}
		});
	});
	<%-- 처리사항 검색 --%>
	function fncFindInspForm(){
		fncAjax('popInspFormList.do',  $('#defaultFrm').serialize(), 'html', true, '', function(data){
			modal_show('50%','60%',data);
		});
	}


</script>
<div class="board_write">
	<form:form modelAttribute="itsmInspMngVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
		<form:hidden path="inspSn" id="inspSn"/>
		<form:hidden path="atchFileId" id="atchFileId"/>
		<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
		<div class="tbl_top">
			<div class="tbl_left"><h4 class="md_tit">점검 정보</h4></div>
			<div class="tbl_right"><span class="essential_txt"><span>*</span>는 필수입력</span></div>
		</div>
		<div class="tbl_wrap">
			<table class="board_row_type01">
				<colgroup>
					<col style="width:11%">
					<col style="width:39%">
					<col style="width:10%">
					<col style="width:40%">
				</colgroup>
				<tbody>
				<tr>
					<th><strong class="th_tit">서비스 구분</strong></th>
					<td colspan="3">
						<form:select path="svcSn" id="svcSn" cssClass="select" title="서비스 구분" required="true">
						</form:select>
					</td>
				</tr>
				<tr>
					<th><strong class="th_tit">점검 양식</strong>
						<c:if test="${procType eq 'insert'}">
						<button type="button" class="btn btn_sml btn_rewrite" style="margin-left: 15px" onclick="fncFindInspForm()">검색</button></th>
					</c:if>
					<td >
						<span id="frmNm">${itsmInspMngVO.frmNm}</span>
						<input type="hidden" name="frmSn" id="frmSn" title="점검 양식" required="true" value="${itsmInspMngVO.frmSn}"/>
					</td>
					<th><strong class="th_tit">점검일</strong></th>
					<td>
						<span class="calendar_input w120">
							<form:input path="inspBegnDt" id="inspBegnDt" readonly="true" cssClass="text"/>
						</span>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="tbl_top">
			<div class="tbl_left"><h4 class="md_tit">점검 내용</h4></div>
		</div>
		<div class="tbl_wrap" id="addFrm">
			<table class="board_row_type01">
				<colgroup>
					<col style="width:6%">
					<col style="width:6%">
					<col style="width:20%">
					<col style="width:10%">
					<col style="width:20%">
					<col >
				</colgroup>
				<thead>
					<th scope="col">번호</th>
					<th scope="col">구분</th>
					<th colspan="2" scope="col">점검 항목</th>
					<th scope="col">점검 결과</th>
					<th scope="col">조치내용</th>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(resultList) > 0 }">
							<c:forEach var="result"  items="${resultList }" varStatus="status">
								<tr>
									<td class="c"><span><c:out value="${status.count }"/></span></td>
									<td class="c"><span><c:out value="${result.itmGbnNm }"/></span></td>
									<td colspan="2" class="l">
										<strong class="${result.esntlYn eq 'Y' ? 'th_tit' : ''}"></strong>
										<c:out  value="${result.itmCn}"/>
										<input type="hidden" id="inspItmSn_${status.index}" name="itmList[${status.index}].inspItmSn" value="${result.inspItmSn}"/>
										<input type="hidden" id="itmCn_${status.index}" name="itmList[${status.index}].itmCn" value="${result.itmCn}"/>
										<input type="hidden" id="itmSn_${status.index}" name="itmList[${status.index}].itmSn" value="${result.itmSn}"/>
										<input type="hidden" id="frmItmSn_${status.index}" name="itmList[${status.index}].frmItmSn" value="${result.frmItmSn}"/>
										<input type="hidden" id="itmSeqo_${status.index}" name="itmList[${status.index}].itmSeqo" value="${result.itmSeqo}"/>
									</td>
									<td>
										<span class="radios">
											<label><input type="radio" class="radio" id="rsltY_${status.index}" name="itmList[${status.index}].rslt" ${result.rslt eq 'Y' ? 'checked' : ''} value="Y"/> 정상</label>
											<label><input type="radio" class="radio" id="rsltN_${status.index}" name="itmList[${status.index}].rslt" ${result.rslt eq 'N' ? 'checked' : ''}  value="N"/> 비정상</label>
										</span>
									</td>
									<td>
										<input type="text" class="text" id="rsltCn_${status.index}" name="itmList[${status.index}].rsltCn" value="${result.rsltCn}"/>
									</td>
								</tr>
							</c:forEach>
							<tr>
								<th colspan="2" class="c">특이사항</th>
								<td colspan="4">
									<form:textarea path="inspCn" id="inspCn" cssClass="text_area_big" title="요청내용" style="resize: none;" maxlength="1000"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><strong>첨부파일</strong></th>
								<td colspan="5">
									<div id="atchFileUpload"></div>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr class="no-data">
								<td colspan="6" class="c">점검 양식을 선택하세요.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="btn_area right">
			<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY or searchVO.procType eq 'insert'}">
				<a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl btn_save" id="btn_submit">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
				<a href="javascript:void(0)" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_cancel">취소</a>
			</c:if>
		</div>
	</form:form>
</div>