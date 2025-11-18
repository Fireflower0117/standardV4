<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}" />

<script type="text/javaScript">

$(document).ready(function(){
	<%-- 댓글 첨부파일 출력 HTML function --%>
	$("#atchFileUploadV2").html(setFileList($("#comAtchFileId").val(), "comAtchFileId", "upload"));
});

function fncComment(type, seq) {
	if (type === "insert") {
		if ( nullCheck($("#comCn").val()) ) {
			alert("댓글 내용을 입력해주세요.");
			$("#comCn").focus();
			return false;
		}
		fncCmntAjax("cmntInsert", type, "등록되었습니다.");
		return false;
	} else if (type === "update") {
		if ( nullCheck($("#comCn_"+seq).val()) ) {
			alert("댓글 내용을 입력해주세요.");
			$("#comCn_"+seq).focus();
			return false;
		}
		onOff = false;
		fncCmntAjax("cmntUpdate", type, "수정되었습니다.", seq); 
		return false;
	} else if (type === "delete") {
		if (confirm("정말 삭제하시겠습니까?")) {
			onOff = false;
			fncCmntAjax("cmntDelete", type, "삭제되었습니다.", seq);
			return false;
		}
	}
}
	
<%-- 수정창 --%>
var beforeSeq;
var onOff = false;
function fncUpdateComment(seq) {
	
	if (onOff === false) {
		$("#btn_view_" + seq).addClass("hidden");
		$("#btn_update_" + seq).removeClass("hidden");
		$("#reply_view_" + seq).addClass("hidden");
		$("#comCn_" + seq).removeClass("hidden");
		$("#atch_"+seq+"_FileUpload").html(setFileList($("#comAtch_"+seq+"_FileId").val(), "comAtch_"+seq+"_FileId", "upload"));
		onOff = true;
		beforeSeq = seq;
		
	} else {
		// 수정폼이 이미 열려있을 때
		$("#btn_view_" + beforeSeq).removeClass("hidden");
		$("#btn_update_" + beforeSeq).addClass("hidden");
		$("#reply_view_" + beforeSeq).removeClass("hidden");
		$("#comCn_" + beforeSeq).addClass("hidden");
		//$("#atchFileUpload_" + beforeSeq).html(setFileList($("#atchFileUpload_" + seq + " .atchFileIdTemp").val(), "comAtchFileId", "view"));
		$("#atch_"+beforeSeq+"_FileUpload").html(setFileList($("#comAtch_"+beforeSeq+"_FileId").val(), "comAtch_"+beforeSeq+"_FileId", "view"));
		
		$("#btn_view_" + seq).addClass("hidden");
		$("#btn_update_" + seq).removeClass("hidden");
		$("#reply_view_" + seq).addClass("hidden");
		$("#comCn_" + seq).removeClass("hidden");
		//$("#atchFileUpload_" + seq).html(setFileList($("#atchFileUpload_" + seq + " .atchFileIdTemp").val(), "comAtchFileId", "upload"));
		$("#atch_"+seq+"_FileUpload").html(setFileList($("#comAtch_"+seq+"_FileId").val(), "comAtch_"+seq+"_FileId", "upload"));
		
		
		onOff = true;
		beforeSeq = seq;
	}
}
	
 	function viewDisplay(obj) {
		if (calByte.getByteLength(obj.value) > 1500) {
			$("#" + obj.id).val(calByte.cutByteLength(obj.value, 1500));
		}
		$(".viewByte").html(calByte.getByteLength(obj.value));
	} 
	
	<%-- 공통 에이젝스 --%>
	function fncCmntAjax(url, type, msg, seq){
		
		<%-- 첨부파일용 submit--%>
		fileFormSubmit("defaultFrm", type, function () {
	   		$("#defaultFrm").removeAttr("enctype");

	   		$.ajax({
	   		    method: "POST",
	   		    url: url+"Proc.json",
	   		    data: (url == 'cmntInsert') ? $("#defaultFrm").serialize() : {"comSn" : seq, "comCn" : $("#comCn_"+seq).val(), "comAtchFileId" : $("#comAtch_"+seq+"_FileId").val()},
	   		    dataType: "JSON",
	   		    success: function(data) {
	   		    	if(data.result == 'Y'){
	   		    		alert(msg);
	   		    		$("#defaultFrm > #comAtchFileId").val('');
	   		    		location.reload();
	   		    	}
	   		    },
	   		    error : function(data){
	   		    	alert("잠시 후 다시 시도해주세요.")
	   		    }
	   		});
	    });
	}

	
</script>

<div class="reply_box">
   <div class="clear">
	   <span class="reply_tit">댓글 <span class="reply_num">(${fn:length(commentList)})</span></span>
	   <span class="reply_bytes"><strong class="viewByte">0</strong>/1500 bytes (한글 500자)</span>
   </div>
	<div>
       <textarea id="comCn" name="comCn" title="댓글 내용을 입력하세요." onkeyup="viewDisplay(this)" maxlength="500" style="resize: none;"></textarea>

       <div id="atchFileUploadV2"></div>
       <button type="button" class="btn btn_reply" onclick="fncComment('insert', '');">등록</button>
	</div>
   </div>
				    
    <ul class="reply_list">
    	<c:choose>
			<c:when test="${fn:length(commentList) gt 0}">
				<c:forEach var="result" items="${commentList}">
			        <li>
			        	<div id="comment_${result.comSn }">
				            <div class="reply_title">
				                <i class="fa fa-user-o"></i>
				                <span class="reply_name">${result.regrNm }</span><span class="date">${result.regDt}</span>
				            </div>
				            <div class="reply_cont re_cont">
				            	<pre id="reply_view_${result.comSn}" style="word-wrap: break-word;">${(result.comCn)}</pre>
				            	<textarea id="comCn_${result.comSn}" class="reply_rewrite hidden" maxlength="500" style="resize:none;"><c:out value="${(result.comCn)}"/></textarea>
					            <input type="hidden" name="comAtch_${result.comSn }_FileId" id="comAtch_${result.comSn }_FileId" value="${result.comAtchFileId }"/>
					            <div id="atch_${result.comSn}_FileUpload"></div>
				             	<c:if test="${not empty result.comAtchFileId && result.delAtchCnt + 0 gt 0 }">
					        		<script>
					        			$("#atch_${result.comSn}_FileUpload").html(setFileList("${result.comAtchFileId}", "comAtch_${result.comSn }_FileId", "view"));
					        			//$("#atchFileUpload_${result.comSn}").find(".atchFileNotExist").remove();
					        		</script>
				        		</c:if>
				        		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
									<c:if test="${result.regrNm eq userNm }">
						            	<div class="reply-content-info">
							                <div id="btn_view_${result.comSn}" class="reply_btns">
							                    <a href="javascript:void(0);" class="btn btn_rewrite" onclick="fncUpdateComment('${result.comSn}');">수정</a>
							                    <a href="javascript:void(0);" class="btn btn_del" onclick="fncComment('delete', '${result.comSn}');">삭제</a>
							                </div>
							                <div id="btn_update_${result.comSn}" class="reply_btns hidden">
							                    <a href="javascript:void(0);" class="btn btn_rewrite" onclick="fncComment('update', '${result.comSn}');">수정</a>
							                    <a href="javascript:void(0);" class="btn btn_del" onclick="fncPageBoard('comment', 'getComment.do'); onOff=false;">취소</a>
							                </div>
						                </div>
					                </c:if>
				                </c:if>
				            </div>
			            </div>
			        </li>
		        </c:forEach>
	        </c:when>
	        <c:otherwise>
				<li class="no-data">등록된 댓글이 없습니다.</li>
			</c:otherwise>
        </c:choose>
    </ul>