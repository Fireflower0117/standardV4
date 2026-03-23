<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp" />
<script type="text/javaScript">
$(document).ready(function(){
	$("#atchFileUpload").html(setFileList("", "atchFileId", "upload", 1));
	
	
	//$("#defaultFrm_excel_pop #atchFileUpload").find(".uploadType").val('excel');
});
</script>
<div class="pop_header">
	<h2>엑셀업로드</h2>
	<a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
	<!-- <a href="javascript:void(0);" class="btn sml excel" onclick="javascript:fncNotExmnExcel('down',1);" style="margin-right: 10px;"><span>항공 미조사 다운로드</span></a>
	<a href="javascript:void(0);" class="btn sml excel" onclick="javascript:fncNotExmnExcel('down',2);" style="margin-right: 10px;"><span>현장 미조사 다운로드</span></a> -->
</div>
<div class="pop_content">
	<form:form modelAttribute="searchVO" id="defaultFrm_excel_pop" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="atchFileId" id="atchFileId" />
		<div class="board_write">
	        <table class="board_row_type01">
	            <colgroup>
	                <col style="width:25%">
	                <col style="width:75%">
	            </colgroup>
	            <tbody>
	                <tr>
	                    <th>
	                    	<strong>엑셀업로드</strong>
	                    </th>
	                    <td colspan="3">
							<div id="atchFileUpload"></div>
	                   	</td>
	                </tr>
	                <tr>
	                    <th><strong>샘플</strong></th>
	                    <td colspan="3">
	                    	<a href="javascript:void(0);" class="btn btn_sml btn_excel" onclick="javascript:fncNotExmnExcel('sample',1);"><span>샘플다운로드</span></a>
	                   	</td>
	                </tr>
	            </tbody>
	        </table>
	    </div>
	</form:form>
</div>
<div class="pop_footer" style="text-align: right">
	<a href="javascript:void(0)" class="btn btn_mdl btn_write" onclick="javascript:fncNotExmnExcel('upload')">등록</a>
	<a href="javascript:void(0)" class="btn btn_mdl btn_cancel"  onclick="modal_hide(this);">취소</a>
</div>