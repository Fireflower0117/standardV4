<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">

$(document).ready(function(){
	fncCommentList("${itsmQnaVO.qnaSn}");
	
	<%-- 첨부파일 출력 HTML function --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));

	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
		itsmFncProc('delete');
	});
})

<%-- 추가요청사항 코멘트 --%>
function fncCommentList(seq){
    $.ajax({
        url      : "getComment.do",
        type     : "post",
        data     : {"qnaSn" : seq},
        dataType : "html",
        success  : function(data){
            $("#commentList").html(data);
        }
    })
    
}

<%-- 요청자 검색 팝업 --%>
function fncPopFindUser(){
 	$.ajax({  
		method   : "POST",  
		url      : "popFindUser.do",   
		dataType : "html", 
		success  : function(data) {
			modal_show('60%','80%', data);
		}
	});  
	
}

<%-- 개발담당자, 처리상태 적용 --%>
function updateProCd() {
	
	var qnaSn = $("#qnaSn").val();
	var mngrSn = $("#mngrSn").val();
	var prcsCd = $("#prcsCd").val();
	
	if( nullCheck(mngrSn) ){
		alert("개발담당자를 선택해주세요.");
		$("#findUser").focus();
		return false;
	} else if ( nullCheck(prcsCd) ){
		alert("처리상태를 선택해주세요.");
		$("#prcsCd").focus();
		return false;
	}
	
	$.ajax({
		  url 	   : "updateProCd.json",
		  type 	   : "POST",
		  data 	   : { "qnaSn" : qnaSn, "mngrSn" : mngrSn, "prcsCd" : prcsCd },
		  async	   : false,
		  dataType : "json",
		  success  : function (data) {
			alert("정상 처리되었습니다.");
			window.location.href = "view.do?qnaSn=" + qnaSn;
		  },
		  error    : function () {
			alert("처리 도중 오류가 발생하였습니다.\n잠시 후 다시 시도해주십시오.");
			return false;
		  }
	});
	
}

<%-- 첨부파일 다운 --%>
function fncFileDown(url, id, sn, stre){
	$("#atchFileId").val(id);
	$("#fileSn").val(sn);
	$("#streFileNm").val(stre);
	$("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
};

</script>
<form:form modelAttribute="itsmQnaVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="qnaSn" id="qnaSn"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<input type="hidden" id="cmntAtchFileId" name="cmntAtchFileId"/>
	<input type="hidden" id="atchFileId" name="atchFileId" />
	<input type="hidden" id="fileSn" name="fileSn"/>
	<input type="hidden" id="streFileNm" name="streFileNm"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">요청정보</h4></div>
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
	                <th scope="row"><strong>서비스구분</strong></th>
	                <td colspan="3"><c:out value="${itsmQnaVO.svcNm }"/></td>
	            </tr>
	        	<tr>
	                <th scope="row"><strong>요청번호</strong></th>
	                <td colspan="3"><c:out value="${itsmQnaVO.qnaSn }"/></td>
	            </tr>
	            <tr>
	            	<th scope="row"><strong>요청제목</strong></th>
	                <td colspan="3"><c:out value="${itsmQnaVO.dmndTtl }"/></td>
	            </tr>
	            <tr>
	            	<th scope="row"><strong>요청자</strong></th>
	                <td><c:out value="${itsmQnaVO.rqstrNm }"/></td>
					<th scope="row"><strong>요청구분</strong></th>
	                <td><c:out value="${itsmQnaVO.dmndCdNm }"/></td>
				</tr>
	            <tr>
	            	<th scope="row"><strong>요청일자</strong></th>
	                <td colspan="3"><c:out value="${itsmQnaVO.regDt }"/></td>
				</tr>
	            <tr>
					<th scope="row"><strong>내용</strong></th>
	                <td colspan="3">
	                	<pre><c:out value="${(itsmQnaVO.dmndCn)}" escapeXml="false" /></pre>
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
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<c:if test="${itsmQnaVO.rgtrSn eq searchVO.loginSerno}">
				<c:if test="${itsmQnaVO.prcsCd ne 'PO03' }">
			       <a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${itsmQnaVO.qnaSn }', 'qnaSn');">수정</a>
			       <a href="javascript:void(0)" id="btn_delete" class="btn btn_mdl btn_del">삭제</a>
		     	</c:if>
			</c:if>
	    </c:if>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
	</div>
    <%-- 추가요청사항 코멘트 --%>
	<div id="commentList" class="reply_area"></div>
</form:form>
