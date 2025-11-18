<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));

	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
		itsmFncProc('delete');
	});

});

</script>
<div class="board_write">
<form:form modelAttribute="smInspVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
	<form:hidden path="inspSn" id="inspSn"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">점검 정보</h4></div>
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
				<td colspan="3"><c:out value="${smInspVO.svcNm}"/></td>

			</tr>
			<tr>
				<th><strong class="th_tit">점검 양식</strong>
				<td colspan="3"><c:out value="${smInspVO.frmNm}"/></td>
			</tr>
			<tr>
				<th><strong class="th_tit">점검자</strong>
				<td><c:out value="${smInspVO.rgtrNm}"/></td>
				<th><strong class="th_tit">점검일</strong>
				<td><c:out value="${smInspVO.inspBegnDt}"/></td>
			</tr>

			</tbody>
		</table>
	</div>

	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">점검 내용</h4></div>
	</div>
	<div class="tbl_wrap" >
		<table class="board_row_type01">
			<colgroup>
				<col style="width:6%">
				<col style="width:6%">
				<col style="width:20%">
				<col style="width:25%">
				<col style="width:10%">
				<col style="width:40%">
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
								<c:out  value="${result.itmCn}"/>
							</td>
							<td>
								<span class="radios">
									<label><input  type="radio" class="radio" id="rsltY_${status.index}" name="itmList[${status.index}].rslt" ${result.rslt eq 'Y' ? 'checked' : 'disabled'} value="Y"/> 정상</label>
									<label><input  type="radio" class="radio" id="rsltN_${status.index}" name="itmList[${status.index}].rslt" ${result.rslt eq 'N' ? 'checked' : 'disabled'}  value="N"/> 비정상</label>
								</span>
							</td>
							<td>
								<input type="text" disabled class="text" id="rsltCn_${status.index}" name="itmList[${status.index}].rsltCn" value="${result.rsltCn}"/>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<th class="c">비고</th>
						<td colspan="5" style="height: 200px;">
							<pre>
								<c:out value="${smInspVO.inspCn}" escapeXml="false"/>
							</pre>
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
						<td colspan="6" class="c">점검 항목이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
</form:form>
</div>
<div class="btn_area right">
		<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY || smInspVO.rgtrSn eq searchVO.loginSerno}">
			<a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${smInspVO.inspSn }', 'inspSn')">수정</a>
			<a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
		</c:if>
	<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
</div>