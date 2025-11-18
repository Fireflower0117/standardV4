<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp" />
<script>

$(document).ready(function(){
	
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');

	<c:if test="${not empty message}">
		alert("<c:out value='${message}'/>");
	</c:if>
});
</script>

<div class="search_basic">
	<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo" />
		<form:hidden path="recordCountPerPage"/>
		<input type="hidden" name="srvySerno"  id="srvySerno"/>
			<table>
				<caption>검색</caption>
				<colgroup>
					<col class="w10p">
					<col class="w15p">
					<col class="w10p">
					<col class="w15p">
					<col class="w10p">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<td><label>상태</label></td>
						<td>
							<form:select path="schEtc01"  title="진행상태 선택" cssClass="w150">
								<form:option value="" label="전체" />
								<form:option value="1" label="대기" />
								<form:option value="2" label="진행중" />
								<form:option value="3" label="종료" />
							</form:select>
						</td>
						<td><label>게시여부</label></td>
						<td>
							<form:select path="schEtc02"  title="게시 선택" cssClass="w150">
								<form:option value="" label="전체" />
								<form:option value="Y" label="게시" />
								<form:option value="N" label="미게시" />
							</form:select>
						</td>
						<td><label>검색</label></td>
						<td>
							<form:select path="searchCondition" title="구분선택" cssClass="w150">
							<form:option value="" label="전체"/>
							<form:option value="1" label="제목"/>
							<form:option value="2" label="내용"/>
						</form:select>
						<form:input path="searchKeyword"/>
						</td>
					</tr>
				</tbody>
			</table>
			<button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
     		<button type="button" class="btn btn_search" id="btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>