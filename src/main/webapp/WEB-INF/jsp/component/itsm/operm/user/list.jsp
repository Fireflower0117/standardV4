<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
$(document).ready(function(){
	fncAddList('${searchVO.currentPageNo}');
});

</script>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false" onkeydown="enterkey();">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<form:hidden path="userSn"/>
		<table class="search_tbl">
			<caption>검색</caption>
			<colgroup>
				<col style="width: 10%;">
				<col >
				<col style="width: 10%;">
				<col >
			</colgroup>
			<tbody>
				<tr>
					<th><label>권한</label></th>
					<td colspan="3">
						<form:select path="schEtc01" cssClass="typeA w150px">
							<form:option value="">전체</form:option>
							<c:forEach var="auth" items="${authList}" varStatus="status">
								<form:option value="${auth.authId}">${auth.grpAuthrtNm}</form:option>
							</c:forEach>
						</form:select>
					</td>
				</tr>
				<tr>
					<th><label>검색</label></th>
					<td colspan="3">
						<form:select path="searchCondition" id="searchCondition" title="구분 선택" cssClass="select w10p">
							<form:option value="" label="전체"/>
							<form:option value="1" label="아이디"/>
							<form:option value="2" label="이름"/>
							<form:option value="3" label="이메일"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="text w85p"/>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_area">
			<a href="javascript:void(0);" id="btn_search" class="btn btn_search">검색</a>
			<a href="javascript:void(0);" id="btn_reset" class="btn btn_reset">초기화</a>
		</div>
		<div style="display: none;" id="chkDataDiv">
	  	</div>
	</form:form>
</div>
<div class="tbl"></div>