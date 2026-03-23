<%--@elvariable id="cmWrdVO" type="com.opennote.standard.component.std.wrd.vo.CmWrdVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$('#cm_btn_submit').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			fncProc('<c:out value="${empty cmWrdVO.wrdSerno ? 'insert' : 'update'}"/>');
		}
	});
});
</script>
<form:form modelAttribute="cmWrdVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="wrdSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(단어명, 영문약어명, 영문명, 단어유형, 표준단어, 단어설명으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>단어명</th>
				<td colspan="3">
					<form:input path="wrdNm" title="단어명" cssClass="w100p" maxlength="20" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>영문약어명</th>
				<td>
					<form:input path="engAbrvNm" title="영문약어명" cssClass="w100p" maxlength="20" required="true"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>영문명</th>
				<td>
					<form:input path="engNm" title="영문명" cssClass="w100p" maxlength="300" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>단어유형</th>
				<td>
					<form:select path="wrdTp" title="단어유형" cssClass="w30p" required="true">
						<form:option value="기본어" label="기본어"/>
						<form:option value="분류어" label="분류어"/>
						<form:option value="유사어" label="유사어"/>
						<form:option value="금칙어" label="금칙어"/>
					</form:select>
				</td>
				<th scope="row">표준단어</th>
				<td>
					<form:input path="stdWrd" title="표준단어" cssClass="w100p" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>단어설명</th>
				<td colspan="3">
					<form:textarea path="wrdExpl" title="단어설명" maxlength="1000" required="true"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<button type="button" id="cm_btn_submit" class="btn blue"><c:out value="${empty cmWrdVO.wrdSerno ? '등록' : '수정'}"/></button>
	<button type="button" id="btn_<c:out value="${empty cmWrdVO.wrdSerno ? 'list' : 'view'}"/>" class="btn gray">취소</button>
</div>
