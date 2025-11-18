<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}" />

<script type="text/javaScript">

$(document).ready(function(){
	<%-- 댓글 첨부파일 출력 HTML function --%>
	$("#comAtchFileUpload").html(setFileList($("#comAtchFileId").val(), "comAtchFileId", "upload", 1));

	$('#btn_reply').on('click', function(){
		if(wrestSubmit(document.defaultFrm)) {
			fileFormSubmit("defaultFrm", 'insert', function () {
				fncProcAjax('insert');
			})
		}
	});

});
function fncComment(delSeq) {
	fncProcAjax('delete',delSeq);
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

const fncProcAjax = function(procType, delSeq,  func, errFunc, compFunc){

	if (procType === 'insert'){
		procType = 'post';
		var dataSource =  $('#defaultFrm').serialize();
	}else if (procType === 'delete'){
		$('#currentPageNo').val('1');
		procType = 'delete';
		var dataSource =  {"comSn" : delSeq};
	}

	$.ajax({
		type 		: procType
		,url 		: 'replProc'
		,data 		: dataSource
		,dataType 	: 'json'
		,success 	: function(data) {

			if(func !== undefined && typeof func === "function"){
				func(data);
			} else{
				alert(data.message);

				// 폼 속성 설정 및 제출
				$("#defaultFrm").attr({"action" : data.returnUrl, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
			}

		}
		,error		: function (xhr, status, error) {

			// 로그인 세션 없는 경우
			if (xhr.status == 401) {
				window.location.reload();
			}

			if(errFunc !== undefined && typeof errFunc === "function"){
				errFunc();
			} else{
				$('.error_txt').remove();
				let errors = xhr.responseJSON;

				// 오류 메세지 출력
				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					for (let i = 0; i < errors.length; i++) {
						let e = errors[i];

						// List 오류
						if(e.codes.some(item => item.includes('java.util.List'))){
							alert(e.defaultMessage);

							// 일반 오류
						} else{
							$('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
						}

					}
				}
			}
		}
		,beforeSend : function(){
			fncLoadingStart();
		}
		,complete 	: function(){

			fncLoadingEnd();

			if(compFunc !== undefined && typeof compFunc === "function"){
				compFunc();
			}
			return false;
		}
	});
}
</script>

<div class="reply_box">
       <div class="clear">
           <span class="reply_tit">추가 문서 <span class="reply_num">(${fn:length(commentList)})</span></span>
           <span class="reply_bytes"><strong class="viewByte">0</strong>/1500 bytes (한글 500자)</span>
       </div>
       <textarea id="comCn" name="comCn" title="댓글 내용을 입력하세요." onkeyup="viewDisplay(this)" maxlength="500" style="resize: none;"></textarea>
       
       <div id="comAtchFileUpload"></div>
       <button type="button" id="btn_reply" class="btn btn_reply">등록</button>
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
					        			$("#atch_${result.comSn}_FileUpload").html(setFileList("${result.comAtchFileId}", "comAtch_${result.comSn }_FileId", "cmntByteView"));
					        			//$("#atchFileUpload_${result.comSn}").find(".atchFileNotExist").remove();
					        		</script>
				        		</c:if>
				        		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
									<c:if test="${result.rgtrSn eq sessionScope.itsm_user_info.userSerno }">
						            	<div class="reply-content-info">
							                <div id="btn_view_${result.comSn}" class="reply_btns">
							                    <a href="javascript:void(0);" id="btn_reply_delete" class="btn btn_del" onclick="fncComment('${result.comSn}')">삭제</a>
							                </div>
							                <div id="btn_update_${result.comSn}" class="reply_btns hidden">
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