<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 첨부파일 폼 생성 --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));
});
</script>
<form:form modelAttribute="bltnbVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="bltnbSerno"/>
	<form:hidden path="replSerno"/>
	<form:hidden path="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <ul class="view_top">
	            <li><a href="" class="i_share">공유</a></li>
	            <li><a href="" class="i_print">인쇄</a></li>
	            <li><a href="" class="i_siren">신고</a></li>
	        </ul>
	    </div>
	</div>
	<table class="board_view">
		<colgroup>
			<col class="w20p">
			<col class="w30p">
			<col class="w20p">
			<col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3"><c:out value="${bltnbVO.bltnbTitl}"/></td>
			</tr>
			<tr>
				<th scope="row">등록자</th>
				<td><c:out value="${bltnbVO.regrNm}"/></td>
				<th scope="row">등록일</th>
				<td><c:out value="${bltnbVO.regDt}"/></td>
			</tr>
			<tr>
				<th scope="row">비밀글여부</th>
				<td colspan="3"><c:out value="${bltnbVO.scretYn eq 'Y' ? '비밀' : '공개'}"/></td>
			</tr>
			<tr>
				<td colspan="4">
					<c:out value="${bltnbVO.bltnbCtt}" escapeXml="false"/>
	            <td>
			</tr>
			<tr>
	        	<th scope="row">첨부파일</th>
	            <td colspan="3">
	                <div id="atchFileUpload"></div>
	            </td>
        	</tr>
		</tbody>
	</table>
	<div class="btn_area">
		<c:if test="${sessionScope.ft_user_info.userSerno eq bltnbVO.regrSerno}">
			<button type="button" id="btn_update" class="btn blue">수정</button>
			<button type="button" id="btn_del" class="btn red">삭제</button>
		</c:if>
		<button type="button" id="btn_list" class="btn gray">목록</button>
	</div>
	<table class="board_reply">
		<colgroup>
			<col class="w20p">
			<col class="w30p">
			<col class="w20p">
			<col class="w30p">
		</colgroup>
		<tbody>
			<c:choose>
				<c:when test="${not empty bltnbVO.replCtt}">
					<tr class="repl_ok" >
						<th scope="row">등록자</th>
						<td><c:out value="${bltnbVO.replRegrNm }"/></td>
						<th scope="row">등록일</th>
						<td><c:out value="${bltnbVO.replRegDt}"/></td>
					</tr>
					<tr class="repl_ok">
						<th scope="row">답변</th>
						<td colspan="3">
							<c:out value="${bltnbVO.replCtt}"/>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr class="repl_ok">
						<th scope="row">답변</th>
						<td colspan="3">
							등록된 답변이 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</form:form>


