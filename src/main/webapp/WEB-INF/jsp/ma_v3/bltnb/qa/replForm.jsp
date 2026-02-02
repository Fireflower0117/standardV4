<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	const fncProcAjax = function(type){
		var procType;
		if(type == 'replInsert'){
			procType = 'post';
		}else if(type == 'replUpdate'){
			procType = 'patch';
		}else if(type == 'replDelete'){
			procType = 'delete';
		}
		
		$.ajax({
			type : procType
			,url : 'replProc'
			,data : $('#defaultFrm').serialize()
			,dataType : 'json'
			,success : function(data) {
				alert(data.message);
				fncCallRepl();
			},error: function (xhr, status, error) {
				$('.error_txt').remove();
				let errors = xhr.responseJSON;
				
				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					for (let i = 0; i < errors.length; i++) {
					    let e = errors[i];
						
					    if(e.codes.some(item => item.includes('java.util.List'))){
					    	alert(e.defaultMessage);
					    	
					    } else{
						    $('#' + e.field).parent().append('<p class="error_txt">' + e.defaultMessage + '</p>');
					    }
					    
					}
				}
		    },beforeSend : function(req){
				fncLoadingStart();
			},complete : function(){
				fncLoadingEnd();
			}
		});
	}
	
	<%-- 답변 등록 /수정 --%>
	$('#btn_repl_submit').on('click', function(){
		
		if("${replVO.replSerno}" != null && "${replVO.replSerno}" != ''){
			$(".repl_no").removeClass("disno");
			$("#btn_repl_rewrite").removeClass("disno");
			$("#btn_repl_cancel").removeClass("disno");
			$(".repl_ok").addClass("disno");
			$("#btn_repl_submit").addClass("disno");
			$("#btn_repl_delete").addClass("disno");	
		}else{
			if(wrestSubmit(document.defaultFrm)){
				fncProcAjax('replInsert');
			}
		}
	});

	<%-- 답변 수정 취소시 dispaly 변경 --%>
	$('#btn_repl_cancel').on('click', function(){
		$(".repl_no").addClass("disno");
		$("#btn_repl_rewrite").addClass("disno");
		$("#btn_repl_cancel").addClass("disno");
		$(".repl_ok").removeClass("disno");
		$("#btn_repl_submit").removeClass("disno");
		$("#btn_repl_delete").removeClass("disno");
		$("#replCtt").val("${replVO.replCtt}")
		$(".error").remove();
	});

	<%-- 답변 수정등록 --%>
	$('#btn_repl_rewrite').on('click', function(){
		if(wrestSubmit(document.defaultFrm)){
			fncProcAjax('replUpdate');
		}
	});

	<%-- 답변 삭제 --%>
	$('#btn_repl_delete').on('click', function(){
		if(confirm("답변을 삭제하시겠습니까?")){
			fncProcAjax('replDelete');
		}
	});
	
	
});
</script>		
<table class="board_reply">
	<colgroup>
		<col class="w20p">
		<col class="w30p">
		<col class="w20p">
		<col class="w30p">
	</colgroup>
	<tbody>
		<tr class="repl_no <c:out value="${not empty replVO.replSerno ? 'disno' :''}"/>"> 
			<th scope="row">답변</th>
			<td colspan="3">
				<input type="hidden" name="replSerno" id="replSerno" value="${replVO.replSerno}"/>
				<textarea name="replCtt" id="replCtt" title="답변" style="resize: none;" maxlength="1000" rows="5" placeholder="1000자 이내"><c:out value="${replVO.replCtt}"/></textarea>
			</td>
		</tr>
		<tr class="repl_ok <c:out value="${empty replVO.replSerno ? 'disno' :''}"/>">
			<th scope="row">등록자</th>
			<td><c:out value="${replVO.replRegrNm}"/></td>
			<th scope="row">등록일</th>
			<td><c:out value="${replVO.replRegDt}"/></td>
		</tr>
		<tr class="repl_ok <c:out value="${empty replVO.replSerno ? 'disno' :''}"/>">
			<th scope="row">답변</th>
			<td colspan="3">
				<c:out value="${replVO.replCtt}"/>
			</td>
		</tr>
	</tbody>
</table>
<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
	<div class="btn_area">
		<button type="button" id="btn_repl_submit" class="btn blue"><c:out value="${empty replVO.replSerno ? '답변저장' : '답변수정'}"/></button>
		<c:if test="${not empty replVO.replSerno}">
			<button type="button" class="btn red"  id="btn_repl_delete">답변삭제</button> 
			<button type="button" class="btn blue disno" id="btn_repl_rewrite">수정</button>
			<button type="button" class="btn gray disno" id="btn_repl_cancel">취소</button>
		</c:if>
	</div>
</c:if>