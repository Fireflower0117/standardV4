<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
	#rqrProcStts {
		position: absolute;
		top: 10px;
		left: 160px;
	}
	.reply_txt .reply_box {
		padding: 5px 15px;
	}
</style>
	<div class="reply_box">
		<div class="clear mar_b0">
           <span class="reply_tit">요구정의 진행현황 <span class="reply_num">(${fn:length(resultList)})</span></span>
           <span class="reply_bytes mar_t0"><strong class="viewByte">0</strong>/3000 bytes</span>
        </div>
        <span>
	        <select name="rqrProcStts" id="rqrProcStts" class="sel w95px mar_r5" title="진행상태">
				<option value="" label="진행상태 선택"/>
				<option value="PR01" label="수용"/>
				<option value="PR02" label="변경"/>
				<option value="PR03" label="제외"/>
				<option value="PR04" label="추가"/>
				<option value="PR05" label="완료"/>
				<option value="PR06" label="협의"/>
			</select>
		</span>
		<textarea id="rqrProcCn" name="rqrProcCn" title="상세현황을 입력하세요" onkeyup="viewDisplay(this)" maxlength="3000" style="resize: none;"></textarea>
		<div id="atchFileUploadV2" class="mar_t10"></div>
		<button type="button" class="btn btn_reply btn_req" onclick="itsmFncComment('insert', '')">등록</button>
	</div>     
<%-- </c:if> --%>
<div class="reply_list">
	<c:choose>
		<c:when test="${fn:length(resultList) gt 0 }">
			<ul class="list cmnt_li">
				<c:forEach var="result" items="${resultList }" varStatus="status">
			        <li>
	        			<div class="reply_title">
	               			 <i class="fa fa-user-o"></i>
	        				<span class="reply_name"><c:out value="${result.rgtrNm}" /></span><span class="date"><c:out value="${result.regDt}" /></span>
	        			</div>
	        			<div class="reply_cont re_cont" style="word-wrap: break-word;">
			        	<div id="cmntDiv_${result.rqrProcSn }">
			        		<div class="reply_txt">
				                <pre id="reply_view_${result.rqrProcSn}" style="white-space: break-spaces; padding: 10px 0;"><span class="state"><c:out value="${result.rqrProcSttsNm}"/></span> <c:out value="${result.rqrProcCn }"/></pre>
				                <div class="reply_box">
									<select id="rqrProcStts_${result.rqrProcSn}" class="sel w10p hidden" title="진행상태" style="display:inline-block;margin-bottom: 5px;" >
										<option value="" label="진행상태 선택"/>
										<option value="PR01" label="수용" ${result.rqrProcStts eq 'PR01' ? "selected='selected'" : ""} />
										<option value="PR02" label="변경" ${result.rqrProcStts eq 'PR02' ? "selected='selected'" : ""}/>
										<option value="PR03" label="제외" ${result.rqrProcStts eq 'PR03' ? "selected='selected'" : ""}/>
										<option value="PR04" label="추가" ${result.rqrProcStts eq 'PR04' ? "selected='selected'" : ""}/>
										<option value="PR05" label="완료" ${result.rqrProcStts eq 'PR05' ? "selected='selected'" : ""}/>
										<option value="PR06" label="협의" ${result.rqrProcStts eq 'PR06' ? "selected='selected'" : ""}/>
									</select>
									<textarea id="rqrProcCn_${result.rqrProcSn}" class="hidden" title="상세현황을 입력하세요"  maxlength="500" resize="none;"><c:out value="${result.rqrProcCn}"></c:out></textarea>
				                </div>
			        		</div>
		        			<input type="hidden" id="procAtchFileId_${result.rqrProcSn }" value="${result.procAtchFileId }">
							<div id="cmnt_msg_area_${result.rqrProcSn}"></div>
			        		<div id="atchFileUpload_${result.rqrProcSn }">
			        		</div>
			        		<script>
			        			$("#atchFileUpload_${result.rqrProcSn}").html(setFileList('${result.procAtchFileId}', "procAtchFileId", "cmntByteView"));
			        			$("#atchFileUpload_${result.rqrProcSn}").find(".atchFileNotExist").remove();
			        		</script>
				   		</div>
			        	<c:if test="${(result.rgtrSn eq searchVO.loginSerno || sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY) }">
			        	<div class="reply-content-info">
							<div id="btn_update_${result.rqrProcSn}" class="reply_btns hidden">
								<a href="javascript:void(0);" id="update_${result.rqrProcSn }" class="btn btn_sml btn_rewrite" onclick="itsmFncComment('update', '${result.rqrProcSn}')">수정</a>
								<a href="javascript:void(0);" id="cancel_${result.rqrProcSn }" class="btn btn_sml btn_del" onclick="fncCmntList();onOff=false;">취소</a>
							</div>
			                <div id="btn_view_${result.rqrProcSn}" class="reply_btns">
								<a href="javascript:void(0);" id="input_${result.rqrProcSn }" class="btn btn_sml btn_rewrite" onclick="fncUpdateComment('${result.rqrProcSn }')">수정</a>
								<a href="javascript:void(0);" id="del_${result.rqrProcSn }" class="btn btn_sml btn_del" onclick="itsmFncComment('delete','${result.rqrProcSn }')">삭제</a>
							</div>
						</div>
						</c:if>
						</div> 
			        </li>
		        </c:forEach>
		    </ul>
		</c:when>
		<c:otherwise>
			<ul class="reply_box no_data">
				<li class="no_data">등록된 댓글이 없습니다.</li>
			</ul>
		</c:otherwise>
	</c:choose>
</div>
<div class="paging_wrap">
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncCmntBoard"/>
	</div>
	<script>
		$(document).ready(function(){
			<%-- 댓글 첨부파일 출력 HTML function --%>
			$("#atchFileUploadV2").html(setFileList($("#procAtchFileId").val(), "procAtchFileId", "upload"));


		});


		function viewDisplay(obj) {
			if (calByte.getByteLength(obj.value) > 3000) {
				$("#" + obj.id).val(calByte.cutByteLength(obj.value, 3000));
			}
			$(".viewByte").html(calByte.getByteLength(obj.value));
		}

		function fncIptVal(id, color ,msg){
			$("#msg_" + id).remove();
			if(color && msg){
				var msgHtml = '<strong id="msg_' + id + '" ><font color=' + color + '>&nbsp;' + msg + '</font></strong>';
				$("#"+id).parent().append(msgHtml);
			}
		};

		<%-- 페이징 --%>
		function fncCmntBoard(gubun,url,idx){
			$("#cmntCurrentPageNo").val(idx)
			fncCmntList();
		}
		<%-- 등록, 수정, 삭제 --%>
		function itsmFncComment(proc, cmntSn) {
			fileFormSubmit("defaultFrm", proc, function () {
				itsmFncProcCustom(proc, cmntSn)
			});
		}

		const itsmFncProcCustom = function(procType, cmntSn,  func, errFunc, compFunc){
			let proc;

			if (procType === 'insert'){
				if(!$("#rqrProcStts").val()) {
					fncIptVal('rqrProcStts','red','진행상태를 선택해주세요');
					$("#rqrProcStts").focus();
					return false;
				}else{
					$("#msg_rqrProcStts").remove();
				}

				if(!$("#rqrProcCn").val()) {
					fncIptVal('rqrProcCn','red','상세현황을 입력해주세요');
					$("#rqrProcCn").focus();
					return false;
				}else{
					$("#msg_rqrProcCn").remove();
				}

				if(!$("#rqrProcCn").val() || !$("#rqrProcStts").val()){
					var msgHtml = '';
					if($("#rqrProcCn").val()){
						msgHtml = '<strong id="cmnt_msg" class="msg_only"><font color="red">&nbsp;진행현황 : 필수 선택입니다.</font></strong>'
					}else if($("#rqrProcStts").val()){
						msgHtml = '<strong id="cmnt_msg" class="msg_only"><font color="red">&nbsp;상세현황 : 필수 입력입니다.</font></strong>'
					}else{
						msgHtml = '<strong id="cmnt_msg" class="msg_only"><font color="red">&nbsp;진행현황 : 필수 선택입니다.&nbsp;상세현황 : 필수 입력입니다.</font></strong>';
					}
					$(".msg_only").remove();
					$(".msg_area").append(msgHtml);
					return false
				}

				proc = 'post';
				var dataSource =  $('#defaultFrm').serialize();
			}else {
				if(procType === 'update') {
					if(!$("#rqrProcCn_"+cmntSn).val() || !$("#rqrProcStts_"+cmntSn).val()){
						var msgHtml = '';
						if($("#rqrProcCn_"+cmntSn).val()){
							msgHtml = '<strong id="cmnt_msg" class="msg_only"><font color="red">&nbsp;진행현황 : 필수 선택입니다.</font></strong>'
						}else if($("#rqrProcStts_"+cmntSn).val()){
							msgHtml = '<strong id="cmnt_msg" class="msg_only"><font color="red">&nbsp;상세현황 : 필수 입력입니다.</font></strong>'
						}else{
							msgHtml = '<strong id="cmnt_msg" class="msg_only"><font color="red">&nbsp;진행현황 : 필수 선택입니다.&nbsp;상세현황 : 필수 입력입니다.</font></strong>';
						}
						$(".msg_only").remove();
						$("#cmnt_msg_area_"+cmntSn).append(msgHtml);
						return false
					}

					proc = 'patch';
				} else if(procType === 'delete') {
					if(!confirm("삭제하시겠습니까?")){
						return false;
					}else{
						proc = 'delete';
					}
				}

				var dataSource =  {"rqrProcSn" : cmntSn, "rqrProcCn" : $("#rqrProcCn_"+cmntSn).val(), "rqrProcStts" : $("#rqrProcStts_"+cmntSn).val(),
					"rqrSn" : $("#rqrSn_"+cmntSn).val(), "procAtchFileId" : $("#procAtchFileId_"+cmntSn).val()};
			}

			$.ajax({
				type 		: proc
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
		<%-- 수정창 --%>
		var beforeSeq;
		var onOff = false;
		function fncUpdateComment(seq) {
			if (onOff === false) {
				$("#btn_view_" + seq).addClass("hidden");
				$("#btn_update_" + seq).removeClass("hidden");
				$("#reply_view_" + seq).addClass("hidden");
				$("#rqrProcCn_" + seq).removeClass("hidden");
				$("#rqrProcStts_" + seq).removeClass("hidden");
				$("#atchFileUpload_" + seq).html(setFileList($("#procAtchFileId_" + seq ).val(), "procAtchFileId_" + seq, "upload"));
				onOff = true;
				beforeSeq = seq;

			} else {
				// 수정폼이 이미 열려있을 때
				$("#btn_view_" + beforeSeq).removeClass("hidden");
				$("#btn_update_" + beforeSeq).addClass("hidden");
				$("#reply_view_" + beforeSeq).removeClass("hidden");
				$("#rqrProcCn_" + beforeSeq).addClass("hidden");
				$("#rqrProcStts_" + beforeSeq).addClass("hidden");
				$("#atchFileUpload_" + beforeSeq).html(setFileList($("#procAtchFileId_" + beforeSeq).val(), "procAtchFileId_"+ beforeSeq , "view"));

				$("#btn_view_" + seq).addClass("hidden");
				$("#btn_update_" + seq).removeClass("hidden");
				$("#reply_view_" + seq).addClass("hidden");
				$("#rqrProcCn_" + seq).removeClass("hidden");
				$("#rqrProcStts_" + seq).removeClass("hidden");
				$("#atchFileUpload_" + seq).html(setFileList($("#procAtchFileId_" + seq).val(), "procAtchFileId_" + seq, "upload"));
				onOff = true;
				beforeSeq = seq;
			}
		}

	</script>
</div>
