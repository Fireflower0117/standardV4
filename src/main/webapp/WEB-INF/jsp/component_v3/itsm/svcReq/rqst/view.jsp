<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
$(document).ready(function(){
	fncCmntList();
	<%-- 첨부파일 출력 HTML function --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));

	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
		itsmFncProc('delete');
	});
});

<%-- 보고서 바로가기 --%>
function fncReport(){
	fncPageBoard('view','/itsm/svcReq/conferRec/view.do','${itsmRqstVO.cofSn}','cofSn')
}

function fncCmntList(){
	$.ajax({  method: "POST",  url: "comment.do",  data : $("#defaultFrm").serialize(), dataType: "html", success: function(data) {$(".cmnt_tbl").html(data);}});
}

</script>
<form:form modelAttribute="itsmRqstVO" name="defaultFrm" id="defaultFrm" method="post">
	<form:hidden path="rqrSn" id="rqrSn"/>
	<form:hidden path="rqrProcSn" id="rqrProcSn"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<form:hidden path="cmntCurrentPageNo" id="cmntCurrentPageNo"/>
	<input type="hidden" id="procAtchFileId" name="procAtchFileId" />
	<input type="hidden" id="fileSn" name="fileSn" />
	<input type="hidden" id="streFileNm" name="streFileNm" />
	<input type="hidden" id="cofSn" name="cofSn" />
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">요청정보</h4></div>
		<div class="tbl_right">
			<c:if test="${not empty itsmRqstVO.cofSn}">
				<a href="javascript:void(0);" class="btn btn_sml btn_confer" onclick="fncReport();"><span>회의록</span></a>
			</c:if>
		</div>
	</div>
	<!-- board -->
	<div class="tbl_wrap">
	    <table class="board_row_type01">
	        <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
	        <colgroup>
				<col style="width:10%">
				<col style="width:40%">
				<col style="width:10%">
				<col style="width:40%">
			</colgroup>
	        <tbody>
				<tr>
					<th><strong>서비스 구분</strong></th>
					<td colspan="3"><c:out value="${itsmRqstVO.svcNm}"/></td>
                </tr>
				<tr>
					<th><strong>요구사항 ID</strong></th>
					<td><c:out value="${itsmRqstVO.rqrId}"/></td>
                   	<th><strong>요구사항 항목</strong></th>
                   	<td><c:out value="${itsmRqstVO.rqrItm }"/></td>
                </tr>
				<tr>
                   	<th><strong>요구사항 상세 ID</strong></th>
                   	<td><c:out value="${itsmRqstVO.rqrDtlId }"/></td>
					<th><strong>세부내역</strong></th>
					<td style="word-break: break-all;" ><c:out value="${itsmRqstVO.rqrDtl }"/></td>
				</tr>
				<tr>
					<th><strong>출처</strong></th>
					<td><c:out value="${empty itsmRqstVO.rqrSrc? '-' : itsmRqstVO.rqrSrc}"/></td>
					<th><strong>분류</strong></th>
					<td><c:out value="${itsmRqstVO.rqrCls}"/></td>
				</tr>
				<tr>
					<th><strong>고객담당자</strong></th>
					<td><c:out value="${empty itsmRqstVO.custMngrNm? '-' : itsmRqstVO.custMngrNm}"/></td>
					<th><strong>개발담당자</strong></th>
					<td><c:out value="${empty itsmRqstVO.dvlpMngrNm? '-' : itsmRqstVO.dvlpMngrNm}"/></td>
				</tr>
				<tr>
					<th><strong>진행현황</strong></th>
					<td colspan="3">
						<c:out value="${itsmRqstVO.rqrProcNm}"/>
					</td>
				</tr>
                <tr>
                    <th><strong>요구정의 진행현황</strong></th>
                    <td colspan="3">
						<pre><c:out value="${itsmRqstVO.rqrCn}" escapeXml="false"/></pre>
                    </td>
                </tr>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
	                <td colspan="3">
	                	 <div id="atchFileUpload"></div>
	                </td>
				</tr>
	        </tbody>
	    </table>
	</div>
    <div class="btn_area">
		<c:if test="${grpAuthId eq 'developer' }">
		    <a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmRqstVO.rqrSn }', 'rqrSn');">수정</a>
		    <a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
	   </c:if>
	    <a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_list">목록</a>
	</div>
    <span></span>
	<div class="cmnt_tbl"></div>
</form:form>
