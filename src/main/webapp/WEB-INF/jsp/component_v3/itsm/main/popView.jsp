<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
	table.tbl th, table.tbl td {
	    border-bottom: 2px solid #ffffff;
	}
</style>
<div class="board_write">
<form:form modelAttribute="maMainVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
	<form:hidden path="trgSn" id="trgSn"/>
	<form:hidden path="dtSe" id="dtSe"/>
	<div class="tbl_wrap">
		<table class="tbl row board">
			<colgroup>
				<col style="width:20%">
				<col style="width:30%">
				<col style="width:20%">
				<col style="width:30%">
			</colgroup>
			<tbody>
				<tr>
					<th><strong>대상자</strong></th>
					<td>
						<c:out value="${maMainVO.trgNm}"/>
					</td>
					<th><strong>대상구분</strong></th>
					<td>
						<c:out value="${maMainVO.trgDivnVal}"/>
					</td>
				</tr>
				<tr>
					<th><strong>담당자</strong></th>
					<td>
						<c:out value="${not empty maMainVO.userNm ? maMainVO.userNm : '-'}"/>
					</td>
					<th><strong>담당자전화번호</strong></th>
					<td>
						<c:out value="${not empty maMainVO.userTelNo ? util:getDecryptAES256HyPhen(maMainVO.userTelNo) : '-'}"/>
					</td>
				</tr>
				<tr>
					<th><strong>거주지 주소</strong></th>
					<td colspan="3">
						<c:out value="${maMainVO.trgAddr}"/>
					</td>
				</tr>
				<tr>
					<th><strong>생활실태</strong></th>
					<td colspan="3">
						<c:out value="${maMainVO.trgComnt}"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form:form>
</div>
