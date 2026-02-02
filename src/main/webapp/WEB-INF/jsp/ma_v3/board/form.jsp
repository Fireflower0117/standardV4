<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 등록, 수정 클릭시 --%>
	$('#btn_submit').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			fncProc("<c:out value='${searchVO.procType}'/>");
		}
	});
});
</script>
<form:form modelAttribute="boardVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="boardSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(제목, 내용으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>제목</th>
				<td colspan="3">
					<form:input path="boardTitl" title="제목" cssClass="w100p" maxlength="80" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>내용</th>
				<td colspan="3">
					<form:textarea path="boardCtt" title="내용" style="resize: none;" maxlength="900" required="true"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<button type="button" id="btn_submit" class="btn blue"><c:out value="${empty boardVO.boardSerno ? '등록' : '수정'}"/></button>
	<c:if test="${not empty boardVO.boardSerno }"><button type="button" id="btn_del" class="btn red">삭제</button></c:if>
	<button type="button" id="<c:out value="${empty boardVO.boardSerno ? 'btn_list' : 'btn_view'}"/>" class="btn gray">취소</button>
</div>
