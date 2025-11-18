<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">

$(document).ready(function(){
	fncCommentList("${itsmDocVO.docSn}");
	<%-- 첨부파일 출력 HTML function --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "byteView"));

	<c:if test="${not empty itsmDocVO.docSn }">
	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
			itsmFncProc('delete');
	});
	</c:if>
})

<%-- 추가요청사항 코멘트 --%>
function fncCommentList(seq){
	$.ajax({
		url      : "getComment.do",
		type     : "post",
		data     : {"docSn" : seq},
		dataType : "html",
		success  : function(data){
			$("#commentList").html(data);
		}
	})

}

</script>
<form:form modelAttribute="itsmDocVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="docSn" id="docSn"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<form:hidden path="docAreaCd" id="docAreaCd"/>
	<form:hidden path="docStepCd" id="docStepCd"/>
	<form:hidden path="docNo" id="docNo"/>
	<form:hidden path="fileNm" id="fileNm"/>
	<input type="hidden" id="comAtchFileId" name="comAtchFileId" title="첨부파일" required="required"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">문서 정보</h4></div>
	</div>
	<div class="tbl_wrap">
	    <table class="board_row_type01">
	        <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
	        <colgroup>
	            <col style="width:20%;">
	            <col style="width:30%;">
	            <col style="width:20%;">
	            <col style="width:30%;">
	        </colgroup>
	        <tbody>
				<tr>
					<th scope="row"><strong>서비스 구분</strong></th>
					<td><c:out value="${itsmDocVO.svcNm }"/></td>
					<th scope="row"><strong>문서 구분</strong></th>
					<td><c:out value="${itsmDocVO.docGbnNm }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>영역</strong></th>
					<td><c:out value="${itsmDocVO.docAreaNm }"/></td>
					<th scope="row"><strong>단계</strong></th>
					<td><c:out value="${itsmDocVO.docStepNm }"/></td>
				</tr>
	        	<tr>
	                <th scope="row"><strong>문서 이름</strong></th>
	                <td colspan="3"><c:out value="${itsmDocVO.docNm }"/></td>
	            </tr>
				<tr>
					<th scope="row"><strong>문서 내용</strong></th>
					<td colspan="3">
						<pre><c:out value="${(itsmDocVO.docCont)}" escapeXml="false" /></pre>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
					<td colspan="3">
						<div id="atchFileUpload"></div>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong>등록자</strong></th>
					<td><c:out value="${itsmDocVO.rgtrNm }"/></td>
					<th scope="row"><strong>등록일시</strong></th>
					<td><c:out value="${itsmDocVO.regDt }"/></td>
				</tr>
	        </tbody>
	    </table>
	</div>
	<div class="btn_area">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<c:if test="${grpAuthId eq 'allAdmin' || grpAuthId eq 'developer' ||  itsmDocVO.rgtrSn eq searchVO.loginSerno}">
			       <a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
			</c:if>
	    </c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
	<%-- 코멘트 --%>
	<div id="commentList" class="reply_area"></div>
</form:form>
