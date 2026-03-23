<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
   <h2>
		수동 백업
   </h2>
	<button type="button" class="pop_close" onclick="modal_hide_all();"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="overflow-y:auto;">
	<div class="tbl_wrap">
			<form name="popFrm" id="popFrm" method="post" onsubmit="return false;">
				<input type="hidden" id="autoYn" name="autoYn" value="N"/>
				<table class="board_col_type01">
					<colgroup>
						<col>
					</colgroup>
					<thead>
						<tr >
							<th class="c" scope="col">서비스구분</th>
						</tr>
					</thead> 
					<tbody>
						<tr >
							<td class="c" id="dbTd">
								<select id="dbBackupSvcSn" name="svcSn">
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</form>

	</div>
	<div class="btn_area">
		<a href="javascript:void(0);" class="btn btn_mdl btn_save" onclick="fncDoBackup()">실행</a>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		fncSvcList("select", "선택", "", "dbBackupSvcSn");
	});

	function fncDoBackup() {
		var ajaxData = {};
		ajaxData.autoYn = "N";
		ajaxData.svcSn = $("#dbBackupSvcSn").val();

		fncLoadingStart();

		fncAjax('backupDb.json',ajaxData, 'json', true, '', function(data){
			alert(data.message);
			fncLoadingEnd();
			modal_last_hide();

			if(data.cnt > 0) {
				location.reload();
			}
		});
	}


</script>