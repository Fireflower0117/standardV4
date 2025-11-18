<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
   <h2>
		주기설정
   </h2>
	<button type="button" class="pop_close" onclick="modal_hide_all();"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="overflow-y:auto;">
	<div class="tbl_wrap">
			<form name="popFrm" id="popFrm" method="post" onsubmit="return false;">
				<table class="board_col_type01">
					<colgroup>
						<col>
						<col>
						<col>
					</colgroup>
					<thead>
						<tr >
							<th class="c" scope="col">서비스구분</th>
							<th class="c" scope="col">일</th>
							<th class="c" scope="col">시</th>
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
		<a href="javascript:void(0);" class="btn btn_mdl btn_save" onclick="fncDataTimerSet();">설정</a>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		fncSvcList("select", "선택", "", "dbBackupSvcSn");
		fncDataTimer();
		$("#dbBackupSvcSn").on("change", function() {
			fncDataTimer()
		});

	});
	function fncDataTimer() {
		$("#dbTd").nextAll().remove();
		$.ajax({
			method: "POST"
			, url: "popScheduleAddList.do"
			, data : $("#popFrm").serialize()
			, dataType: "html"
			, success: function(data) {
				$("#dbTd").after(data);
			}, error: function (){
				alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
			}
		});
	}
function fncDataTimerSet(){
	var ajaxData = {};
	ajaxData.dbBackupDay = $("#dbBackupDay").val();
	ajaxData.dbBackupHour = $("#dbBackupHour").val();
	ajaxData.svcSn = $("#dbBackupSvcSn").val();

	$.ajax({
		url : "dataTimerSet.do",
		method : "POST",
		data : ajaxData,
		dataType : "JSON",
		success : function(data){
			if(data.cnt > 0){
				alert("저장되었습니다.");
				modal_hide_all();
			}else{
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		},error : function(data){
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	});	
}
</script>