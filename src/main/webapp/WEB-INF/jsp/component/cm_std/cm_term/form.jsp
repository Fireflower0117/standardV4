<%--@elvariable id="cmTermVO" type="com.opennote.standard.component.std.term.vo.CmTermVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$('#cm_btn_submit').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			termEngNmDuplChk().then(function (data) {
				if (data <= 0) {
					fncProc('<c:out value="${empty cmTermVO.termSerno ? 'insert' : 'update'}"/>');
				} else {
					alert('이미 존재하는 용어영문명입니다');
				}
			});
		}
	});

	// 영문, 숫자, '_'만 입력
	$('#termEngNm').on('input', function(){
		this.value = this.value.replace(/[^a-zA-Z0-9_]/g,'');
	});
});

// 용어영문명 중복체크
const termEngNmDuplChk = function () {
	return new Promise(function(resolve, reject) {
		$.ajax({
			type: 'post',
			url: 'termEngNmDuplChk',
			data: $("#defaultFrm").serialize(),
			success: function(data) {
				resolve(data);
			}
		});
	});
}
</script>
<form:form modelAttribute="cmTermVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="termSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(용어명, 표준여부, 용어영문명, 도메인명, 도메인그룹, 데이터타입, 데이터길이, 데이터길이(소수점), 용어설명으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>용어명</th>
				<td>
					<form:input path="termNm" title="용어명" cssClass="w100p" maxlength="30" required="true"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>표준여부</th>
				<td>
					<form:select path="stdYn" title="표준여부" cssClass="w30p" required="true">
						<form:option value="Y" label="표준"/>
						<form:option value="N" label="비표준"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>용어영문명</th>
				<td>
					<form:input path="termEngNm" title="용어영문명" cssClass="w100p" maxlength="30" required="true"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>도메인명</th>
				<td>
					<form:input path="dmnNm" title="도메인명" cssClass="w100p" maxlength="20" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>도메인그룹</th>
				<td>
					<form:select path="dmnGrp" title="도메인그룹" cssClass="w30p" required="true">
						<form:option value="금액" label="금액"/>
						<form:option value="날짜/시간" label="날짜/시간"/>
						<form:option value="명칭/내용" label="명칭/내용"/>
						<form:option value="물리량" label="물리량"/>
						<form:option value="번호" label="번호"/>
						<form:option value="비율" label="비율"/>
						<form:option value="수량" label="수량"/>
						<form:option value="식별자" label="식별자"/>
						<form:option value="여부/유무" label="여부/유무"/>
						<form:option value="좌표" label="좌표"/>
						<form:option value="주소" label="주소"/>
						<form:option value="코드" label="코드"/>
						<form:option value="크기" label="크기"/>
					</form:select>
				</td>
				<th scope="row"><span class="asterisk">*</span>데이터타입</th>
				<td>
					<form:select path="dataTp" title="데이터타입" cssClass="w30p" required="true">
						<form:option value="가변문자열" label="가변문자열"/>
						<form:option value="고정문자열" label="고정문자열"/>
						<form:option value="공간정보" label="공간정보"/>
						<form:option value="바이너리" label="바이너리"/>
						<form:option value="수" label="수"/>
						<form:option value="일시" label="일시"/>
						<form:option value="정수" label="정수"/>
						<form:option value="타임스탬프" label="타임스탬프"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>데이터길이</th>
				<td>
					<form:input path="dataLen" title="데이터길이" cssClass="w30p numOnly" maxlength="5" required="true"/>
				</td>
				<th scope="row">데이터길이(소수점)</th>
				<td>
					<form:input path="dataLenDcpt" title="데이터길이(소수점)" cssClass="w30p numOnly" maxlength="5"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>용어설명</th>
				<td colspan="3">
					<form:textarea path="termExpl" title="용어설명" maxlength="1000" required="true"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<button type="button" id="cm_btn_submit" class="btn blue"><c:out value="${empty cmTermVO.termSerno ? '등록' : '수정'}"/></button>
	<button type="button" id="btn_<c:out value="${empty cmTermVO.termSerno ? 'list' : 'view'}"/>" class="btn gray">취소</button>
</div>
</body>
