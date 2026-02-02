<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="errLogSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(에러유형, 에러설명, 에러페이지URL, 메뉴명, 메뉴 한글명, 에러발생IP, 에러발생일시, 에러내용으로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
		<tr>
			<th scope="row"><strong>에러유형</strong></th>
			<td>
				<c:out value="${errlogVO.errTpNm}"/>
			</td>
			<th scope="row"><strong>에러설명</strong></th>
			<td>
				<c:out value="${errlogVO.errExpl}"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><strong>메뉴명</strong></th>
			<td>
				<c:out value="${errlogVO.menuCgNm}"/>
			</td>
			<th scope="row"><strong>메뉴 한글명</strong></th>
			<td>
				<c:out value="${errlogVO.menuNm}"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><strong>에러페이지URL</strong></th>
			<td>
				<c:out value="${errlogVO.errOccrUrlAddr}"/>
			</td>
			<th scope="row"><strong>에러발생IP</strong></th>
			<td>
				<c:out value="${errlogVO.errOccrIpAddr}"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><strong>에러발생일시</strong></th>
			<td colspan="3">
				<c:out value="${errlogVO.errOccrDt}"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><strong>에러내용</strong></th>
			<td colspan="3">
				<c:out value="${errlogVO.svrErrCtt}"/>
			</td>
		</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
