<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:if test="${fn:length(fileList) gt 0 }">
	<ul>
		<li class="tit">
			<label class="chkAll cursor">
				<input type="checkbox" class="cursor mar_r10"><span>전체선택</span>
			</label>
		</li>
		<c:forEach var="item" items="${fileList }" varStatus="status">
			<li>
				<label class="chkList cursor">
					<input type="checkbox" class="cursor mar_r10" data-fileseqo="<c:out value='${item.fileSeqo }'/>"> 
					<p><c:out value="${item.rlFileNm}"/>&nbsp;&nbsp;&nbsp;(<c:out value="${item.fileSzVal}"/>MB)&nbsp;&nbsp;&nbsp;[<c:out value="${item.regDt}"/>]</p> 
				</label>
				<span class="click_clipboard cursor" data-link="/tmplFile/getFileDown.do?tmplFileSerno=<c:out value="${item.tmplFileSerno}"/>&fileSeqo=<c:out value="${item.fileSeqo}"/>">
					<i class="xi-link-insert"></i>
				</span>
			</li>
		</c:forEach>
	</ul>
</c:if>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".chkAll input[type='checkbox']").on("click", function () {
	    var chkAll = $(this).prop("checked");
	    var $targetChk = $(".chkList").find("input[type='checkbox']");
	    if (chkAll) {
	    	$targetChk.prop('checked', true);
	    } else {
	    	$targetChk.prop('checked', false);
	    }
	});
	
	$(".chkList input[type='checkbox']").on("click", function () {
	    var chkCnt = $(".chkList input[type='checkbox']").length;
	    var chkCnt_checked = $(".chkList input[type='checkbox']:checked").length;
	    if(chkCnt == chkCnt_checked && chkCnt){
	    	$(".chkAll input[type='checkbox']").prop("checked", true);
	    }else{
	    	$(".chkAll input[type='checkbox']").prop("checked", false);
	    }
	});
});
</script>
 