<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
    <h2>주간업무보고 수동생성</h2>
    <a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
</div>
<div class="pop_content"  style="overflow-y:auto;">
	<form:form modelAttribute="searchVO" id="popFrm" name="popFrm" method="post" onsubmit="return false;">
		<div class="tbl_wrap">
			<table class="board_col_type01">
				<caption>검색</caption>
				<colgroup>
					<col style="width: 60%;">
					<col>
				</colgroup>
				<thead>
				<tr>
					<th class="c" scope="col">서비스구분</th>
					<th class="c" scope="col">생성일</th>
				</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<select id="svcSn" name="svcSn">
							</select>
						</td>
						<td>
							<span class="calendar_input w120">
								<form:input path="crtDate" id="crtDate" name="crtDate" readonly="true" cssClass="text"/>
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_area">
			<a href="javascript:void(0);" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="weekJobJsonAction();">수동업데이트</a>
		</div>
	</form:form>
</div>
<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "", "", "svcSn");


	$("#crtDate").datepicker({
		buttonImage: "/component/itsm/images/sub/icon_calendar.png",
		buttonImageOnly: true,
		maxDate: 0,
		beforeShowDay: function(date){	
			console.log(date);
			var day = date.getDay();	
			return [(day != 0 && day != 1 && day != 2 && day != 3 && day != 4 && day != 6)];
		}		
	});
	
});

function weekJobJsonAction(){
	
	if($("#crtDate").val() == null || $("#crtDate").val() == ''){
		alert("수동업데이트 할 날짜를 선택해주세요.");
	}else{
		$.ajax({  
			method: "POST",  
			url: "weekJobJsonAction.json",  
			data : $("#popFrm").serialize(), 
			dataType: "json", 
			success  : function(data){
			 	alert(data.msg);
			 	fncPageBoard("addList", "addList.do", '1');
			 	modal_hide_all();
	        }
		});
	}
	
}

</script>