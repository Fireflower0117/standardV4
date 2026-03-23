<%--@elvariable id="searchVO" type="com.opennote.standard.component.std.dmn.vo.CmDmnVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
});
</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<input type="hidden" name="dmnSerno" id="dmnSerno"/>
		<table>
			<caption>내용(도메인유형, 도메인그룹, 코드유형, 검색으로 구성)</caption>
			<colgroup>
				<col class="w10p">
				<col class="w10p">
				<col class="w10p">
				<col class="w10p">
				<col class="w8p">
				<col class="w8p">
				<col class="w8p">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>도메인유형</label></td>
					<td>
						<form:select path="schEtc00" title="도메인유형" cssClass="w150">
							<form:option value="" label="전체"/>
							<form:option value="그룹도메인" label="그룹도메인"/>
							<form:option value="코드도메인" label="코드도메인"/>
						</form:select>
					</td>
					<td><label>도메인그룹</label></td>
					<td>
						<form:select path="schEtc01" title="도메인그룹" cssClass="w120" required="true">
							<form:option value="" label="전체"/>
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
					<td><label>코드유형</label></td>
					<td>
						<form:select path="schEtc02" title="코드유형" cssClass="w100">
							<form:option value="" label="전체"/>
							<form:option value="공통코드" label="공통코드"/>
							<form:option value="개별코드" label="개별코드"/>
						</form:select>
					</td>
					<td><label>검색</label></td>
					<td>
						<form:select path="searchCondition" title="구분선택" cssClass="w120">
							<form:option value="" label="전체"/>
							<form:option value="1" label="도메인명"/>
							<form:option value="2" label="도메인영문명"/>
							<form:option value="3" label="도메인설명"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="w300" maxlength="100"/>
					</td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
		<button type="button" class="btn btn_search" id="btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
