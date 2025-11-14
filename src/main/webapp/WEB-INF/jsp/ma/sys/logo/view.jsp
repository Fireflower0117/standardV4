<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 링크여부에 따른 url, 대상 tr태그 출력 여부 실행--%>
	fnLinkYn(<c:out value="${logoVO.lnkYn eq 'Y'}"/>);

	<%-- 로고 이미지 --%>
	$("#atchFileDiv").html('<div class="file_img"><img src="/file/getByteImage.do?atchFileId=<c:out value='${logoVO.atchFileId}'/>&fileSeqo=<c:out value='${logoVO.fileSeqo}'/>&fileNmPhclFileNm=<c:out value='${logoVO.fileNmPhclFileNm}'/>" alt="로고"/></div>')

});

<%-- 링크여부에 따른 url, 대상 tr태그 출력 여부 --%>
const fnLinkYn = function(chk){
	$('#lnkYnTr').toggle(chk);
	$('#url, #lnkTgtCd').prop('required', chk).attr('required', chk);
}
</script>
<form:form modelAttribute="logoVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="logoSerno"/>
	<form:hidden path="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(항목, 링크여부, 활성화여부, URL, 대상, 로고이미지로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">항목</th>
				<td colspan="3"><c:out value="${logoVO.itmNm}"/></td>
			</tr>
			<tr>
				<th scope="row">링크여부</th>
				<td><c:out value="${logoVO.lnkYn eq 'Y' ? '유' : '무'}"/></td>
				<th scope="row">활성화여부</th>
				<td><c:out value="${logoVO.actvtYn eq 'Y' ? '활성화' : '비활성화'}"/></td>
			</tr>
			<tr id="lnkYnTr">
				<th scope="row">url</th>
				<td><c:out value="${logoVO.url}"/></td>
				<th scope="row">대상</th>
				<td><c:out value="${logoVO.lnkTgtCd eq 'self' ? '현재창' : '새창'}"/></td>
			</tr>
			<tr>
	        	<th scope="row">로고이미지</th>
	            <td colspan="3">
	                <div id="atchFileDiv"></div>
	            </td>
        	</tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY || searchVO.loginSerno eq logoVO.regrSerno}">
		<button type="button" id="btn_update" class="btn blue">수정</button>
		<button type="button" id="btn_del" class="btn red">삭제</button>
	</c:if>
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
