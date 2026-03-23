<%--@elvariable id="cmDbDataVO" type="com.opennote.standard.component.dbQlt.dbData.vo.CmDbDataVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$('#cm_btn_submit').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			fncProc('insert');
		}
	});
});
</script>
<form:form modelAttribute="cmDbDataVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<h4 class="md_tit">컬럼 상세</h4>
	<table class="board_view">
		<caption>내용(스키마명, 테이블영문명, 컬럼영문명, 컬럼한글명, 데이터타입, NULL여부, KEY, 기본값으로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">스키마명</th>
				<td><c:out value="${cmDbDataVO.tableSchema}"/></td>
				<th scope="row">테이블영문명</th>
				<td><c:out value="${cmDbDataVO.tableName}"/></td>
			</tr>
			<tr>
				<th scope="row">컬럼영문명</th>
				<td><c:out value="${cmDbDataVO.columnName}"/></td>
				<th scope="row">컬럼한글명</th>
				<td><c:out value="${cmDbDataVO.columnComment}"/></td>
			</tr>
			<tr>
				<th scope="row">데이터타입</th>
				<td><c:out value="${cmDbDataVO.columnType}"/></td>
				<th scope="row">NULL여부</th>
				<td><c:out value="${cmDbDataVO.isNullable}"/></td>
			</tr>
			<tr>
				<th scope="row">KEY</th>
				<td><c:out value="${cmDbDataVO.columnKey}"/></td>
				<th scope="row">기본값</th>
				<td><c:out value="${cmDbDataVO.columnDefault}"/></td>
			</tr>
		</tbody>
	</table>
	<c:if test="${searchVO.stdCd eq 'ST02'}">
		<h4 class="md_tit mar_t30">용어 상세</h4>
		<table class="board_view">
			<colgroup>
				<col class="w20p">
				<col class="w30p">
				<col class="w20p">
				<col class="w30p">
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">도메인명</th>
				<td><c:out value="${cmTermVO.dmnNm}"/></td>

				<th scope="row">표준여부</th>
				<td><c:out value="${cmTermVO.stdYn}"/></td>
			</tr>
			<tr>
				<th scope="row">용어영문명</th>
				<td><c:out value="${cmTermVO.termEngNm}"/></td>
				<th scope="row">용어명</th>
				<td><c:out value="${cmTermVO.termNm}"/></td>
			</tr>
			<tr>
				<th scope="row">도메인그룹</th>
				<td><c:out value="${cmTermVO.dmnGrp}"/></td>
				<th scope="row">데이터타입(길이)</th>
				<td>
					<c:out value="${cmTermVO.dataTp}"/>
					(<c:out value="${cmTermVO.dataLen}"/><c:if test="${!empty cmTermVO.dataLenDcpt}">, <c:out value="${cmTermVO.dataLenDcpt}"/></c:if>)
				</td>
			</tr>
			<tr>
				<th scope="row">용어설명</th>
				<td colspan="3"><c:out value="${cmTermVO.termExpl}"/></td>
			</tr>
			</tbody>
		</table>
	</c:if>
	<c:if test="${searchVO.stdCd eq 'ST01'}">
		<h4 class="md_tit mar_t30">용어 등록</h4>
		<div class="board_top">
			<div class="board_right">
				<div class="form_guide"><span class="asterisk">*</span>필수입력</div>
			</div>
		</div>
		<table class="board_write">
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
					<input type="text" name="termNm" id="termNm" value="<c:out value="${cmDbDataVO.columnComment}"/>" title="용어명" class="w100p" maxlength="30" required="required">
				</td>
				<th scope="row"><span class="asterisk">*</span>표준여부</th>
				<td>
					<select name="stdYn" id="stdYn" title="표준여부" class="w30p" required="required">
						<option value="Y">표준</option>
						<option value="N">비표준</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>용어영문명</th>
				<td>
					<input type="text" name="termEngNm" id="termEngNm" value="<c:out value="${cmDbDataVO.columnName}"/>" title="용어영문명" class="w100p" maxlength="30" required="required">
				</td>
				<th scope="row"><span class="asterisk">*</span>도메인명</th>
				<td>
					<input type="text" name="dmnNm" id="dmnNm" title="도메인명" class="w100p" maxlength="20" required="required">
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>도메인그룹</th>
				<td>
					<select name="dmnGrp" id="dmnGrp" title="도메인그룹" class="w30p" required="required">
						<option value="금액">금액</option>
						<option value="날짜/시간">날짜/시간</option>
						<option value="명칭/내용">명칭/내용</option>
						<option value="물리량">물리량</option>
						<option value="번호">번호</option>
						<option value="비율">비율</option>
						<option value="수량">수량</option>
						<option value="식별자">식별자</option>
						<option value="여부/유무">여부/유무</option>
						<option value="좌표">좌표</option>
						<option value="주소">주소</option>
						<option value="코드">코드</option>
						<option value="크기">크기</option>
					</select>
				</td>
				<th scope="row"><span class="asterisk">*</span>데이터타입</th>
				<td>
					<select name="dataTp" id="dataTp" title="데이터타입" class="w30p" required="required">
						<option value="가변문자열">가변문자열</option>
						<option value="고정문자열">고정문자열</option>
						<option value="공간정보">공간정보</option>
						<option value="바이너리">바이너리</option>
						<option value="수">수</option>
						<option value="일시">일시</option>
						<option value="정수">정수</option>
						<option value="타임스탬프">타임스탬프</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>데이터길이</th>
				<td>
					<input type="text" name="dataLen" id="dataLen" title="데이터길이" class="w30p numOnly" maxlength="5" required="required">
				</td>
				<th scope="row">데이터길이(소수점)</th>
				<td>
					<input type="text" name="dataLenDcpt" id="dataLenDcpt" title="데이터길이(소수점)" class="w30p numOnly" maxlength="5">
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>용어설명</th>
				<td colspan="3">
					<textarea name="termExpl" id="termExpl" title="용어설명" maxlength="1000" required="required"></textarea>
				</td>
			</tr>
			</tbody>
		</table>
	</c:if>
</form:form>
<div class="btn_area">
<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY && searchVO.stdCd eq 'ST01'}">
	<button type="button" id="cm_btn_submit" class="btn blue">용어등록</button>
</c:if>
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
