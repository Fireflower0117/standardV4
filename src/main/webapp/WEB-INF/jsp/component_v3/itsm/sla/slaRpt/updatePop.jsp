<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
    <h2>월별 보고서 수동생성</h2>
    <a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
</div>
<div class="pop_content">
	<form:form modelAttribute="searchVO" id="popFrm" name="popFrm" method="post" onsubmit="return false;">
		<div class="tbl_wrap">
			<table class="tbl row link board board_row_type01">
				<caption>검색</caption>
				<colgroup>
					<col style="width: 40%">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">서비스구분</th>
						<td>
							<select id="svcGbn_pop" name="svcSn" class="select w150"/>
						</td>
					</tr>
					<tr>
						<th scope="row">생성일</th>
						<td>
							<span class="calendar_input w120">
								<form:input path="bgngYm" id="bgngYm_pop" readonly="true" cssClass="text"/>
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_area c">
			<a href="javascript:void(0);" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncReportMaking();">수동업데이트</a>
			<a href="javascript:void(0);" id="btn_list" class="btn btn_mdl btn_del" onclick="modal_hide(this);">닫기</a>
		</div>
	</form:form>
	<div class="tbl_pic"></div>
</div>
<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "", "${schEtc00}", "svcGbn_pop");
	$("#bgngYm_pop").datepicker({
		buttonImage: "/component/itsm/images/sub/icon_calendar.png",
		buttonImageOnly: true,
		maxDate: 0,
		beforeShowDay:function(date){
			return [date.getDate() === new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate()];
		}		
	});
	
});

function fncReportMaking(){
	
	if($("#bgngYm_pop").val() == null || $("#bgngYm_pop").val() == ''){
		alert("수동업데이트 할 날짜를 선택해주세요.");
	}else if($("#svcGbn_pop").val() == null || $("#svcGbn_pop").val() == ''){
		alert("수동업데이트 할 서비스를 선택해주세요.");
	}else{
		$.ajax({
			type: "patch",
			url: "reportMaking",
			data : $("#popFrm").serialize(), 
			dataType: "json", 
			success  : function(data){
			 	alert(data.message);
			 	fncPageBoard("addList", "addList.do", '1');
			 	modal_hide_all();
	        }
		});
	}
	
}

</script>