<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">

$(document).ready(function(){
	fncCommentList("${itsmBakupVO.bakSn}");
	<%-- 첨부파일 출력 HTML function --%>
	/*$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));*/
})

<%-- 추가요청사항 코멘트 --%>
function fncCommentList(seq){
	$.ajax({
		url      : "getComment.do",
		type     : "post",
		data     : {"bakSn" : seq},
		dataType : "html",
		success  : function(data){
			$("#commentList").html(data);
		}
	})

}
</script>
<form:form modelAttribute="itsmBakupVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="bakSn" id="bakSn"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<input type="hidden" id="comAtchFileId" name="comAtchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">백업 정보</h4></div>
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
					<td><c:out value="${itsmBakupVO.svcNm }"/></td>
					<th scope="row"><strong>처리 여부</strong></th>
					<td><c:out value="${itsmBakupVO.bakYn eq 'Y' ? '완료' : itsmBakupVO.bakYn eq 'F' ?  '실패' : itsmBakupVO.bakYn eq 'N' ? '처리중' : '-'} "/></td>
				</tr>
				<tr>
					<th scope="row"><strong>백업 경로</strong></th>
					<td colspan="3"><c:out value="${itsmBakupVO.bakPath }"/></td>

				</tr>
				<tr>
					<th scope="row"><strong>백업 용량</strong></th>
					<td><c:out value="${itsmBakupVO.bakVol }MB"/></td>
					<th scope="row"><strong>백업 구분</strong></th>
					<td><c:out value="${itsmBakupVO.autoYn eq 'Y' ? '자동백업' : '수동백업' }"/></td>
				</tr>
	        	<%--<tr>
	                <th scope="row"><strong>백업 이름</strong></th>
	                <td colspan="3"><c:out value="${itsmBakupVO.bakNm }"/></td>
	            </tr>
				<tr>
					<th scope="row"><strong>백업 내용</strong></th>
					<td colspan="3">
						<pre><c:out value="${(itsmBakupVO.bakCont)}" escapeXml="false" /></pre>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
					<td colspan="3">
						<div id="atchFileUpload"></div>
					</td>
				</tr>--%>
				<tr>
					<th scope="row"><strong>소요시간</strong></th>
					<td><c:out value="${itsmBakupVO.bakTime }초"/></td>
					<th scope="row"><strong>등록일시</strong></th>
					<td><c:out value="${itsmBakupVO.regDt }"/></td>

				</tr>
	        </tbody>
	    </table>
	</div>

	<div class="btn_area">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<c:if test="${itsmBakupVO.rgtrSn eq searchVO.loginSerno}">
			       <a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmBakupVO.bakSn }', 'bakSn');">수정</a>
			       <a href="javascript:void(0)" id="btn_del" class="btn btn_mdl btn_del">삭제</a>
			</c:if>
	    </c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
	<%-- 코멘트 --%>
	<div id="commentList" class="reply_area"></div>
</form:form>
