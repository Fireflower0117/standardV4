<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	$(document).ready(function(){

		<%-- 스마트에디터 설정 --%>
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "inspCn",
			sSkinURI : "${pageContext.request.contextPath}/resource/editor/SmartEditor2Skin.html",
			fCreator : "createSEditor2"
		});
		$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload"));
	})


</script>
<table class="board_row_type01">
	<colgroup>
		<col style="width:6%">
		<col style="width:6%">
		<col style="width:20%">
		<col style="width:10%">
		<col style="width:20%">
		<col>
	</colgroup>
	<thead>
		<th scope="col">번호</th>
		<th scope="col">구분</th>
		<th colspan="2" scope="col">점검 항목</th>
		<th scope="col">점검 결과</th>
		<th scope="col">조치내용</th>
	</thead>
	<tbody>
		<c:forEach var="result"  items="${resultList }" varStatus="status">
			<tr>
				<td class="c"><span><c:out value="${status.count }"/></span></td>
				<td class="c"><span><c:out value="${result.itmGbnNm }"/></span></td>
				<td colspan="2" class="l">
					<strong class="${result.esntlYn eq 'Y' ? 'th_tit' : ''}"></strong>
					<c:out  value="${result.itmCn}"/>
					<input type="hidden" id="itmCn_${status.index}" name="itmList[${status.index}].itmCn" value="${result.itmCn}"/>
					<input type="hidden" id="itmSn_${status.index}" name="itmList[${status.index}].itmSn" value="${result.itmSn}"/>
					<input type="hidden" id="frmItmSn_${status.index}" name="itmList[${status.index}].frmItmSn" value="${result.frmItmSn}"/>
					<input type="hidden" id="itmSeqo_${status.index}" name="itmList[${status.index}].itmSeqo" value="${result.itmSeqo}"/>
				</td>
				<td>
					<span class="radios">
						<label><input type="radio" class="radio" id="rsltY_${status.index}" name="itmList[${status.index}].rslt" ${result.rslt eq 'Y' ? 'checked' : ''} value="Y"/> 정상</label>
						<label><input type="radio" class="radio" id="rsltN_${status.index}" name="itmList[${status.index}].rslt" ${result.rslt eq 'N' ? 'checked' : ''} value="N" title="결과"  ${result.esntlYn eq 'Y'  ? 'required' : '' } /> 비정상</label>
					</span>
				</td>
				<td>
					<input type="text" class="text" id="rsltCn_${status.index}" name="itmList[${status.index}].rsltCn" value="${result.rsltCn}"/>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<th>비고</th>
			<td colspan="5">
				<textarea name="inspCn" id="inspCn" class="text_area_big" title="요청내용" style="resize: none;" maxlength="1000"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><strong>첨부파일</strong></th>
			<td colspan="5">
				<div id="atchFileUpload"></div>
			</td>
		</tr>
	</tbody>
</table>