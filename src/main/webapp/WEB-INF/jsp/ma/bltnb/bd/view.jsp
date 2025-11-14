<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 댓글 리스트 불러오기 --%>
const fncCallReplList = function(){
	$.ajax({
		type : 'post'
		,url : 'replList.do'
		,data : $('#defaultFrm').serialize()
		,dataType : 'HTML'
		,success : function(data) {
			$(".cmnt_area").html(data);
		},error : function(xhr, status, error){
			if (xhr.status == 401) {
				window.location.reload();
			}
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	});
}

<%-- 좋아요 불러오기 --%>
const fncCallLike = function(){
	$.ajax({
		type : 'post'
		,url : 'like'
		,data : $('#defaultFrm').serialize()
		,dataType : 'HTML'
		,success : function(data) {
			$(".likeit").html(data);
		},error : function(xhr, status, error){
			if (xhr.status == 401) {
				window.location.reload();
			}
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	});
}

$(document).ready(function(){
	<%-- 첨부파일 폼 생성 --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));
	<%-- 댓글 리스트 불러오기 --%>
	fncCallReplList();
	
	<%-- 좋아요 불러오기 --%>
	fncCallLike();
});
</script>
<form:form modelAttribute="bltnbVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="bltnbSerno"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
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
				<td colspan="4">
					<c:out value="${bltnbVO.bltnbCtt}" escapeXml="false"/>
					<div class="likeit">
	                </div>
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
		<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY or searchVO.loginSerno eq bltnbVO.regrSerno}">
			<button type="button" id="btn_update" class="btn blue">수정</button>
			<button type="button" id="btn_del" class="btn red">삭제</button>
		</c:if>
		<button type="button" id="btn_list" class="btn gray">목록</button>
	</div>
	<div class="cmnt_area">
	</div>
</form:form>
