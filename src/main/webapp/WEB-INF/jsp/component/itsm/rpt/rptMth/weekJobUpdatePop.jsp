<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
    <h2>월간업무보고 수동생성</h2>
    <a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
</div>
<div class="pop_content"  style="overflow-y:auto;">
	<form:form modelAttribute="searchVO" id="popFrm" name="popFrm" method="post" onsubmit="return false;">
		<div class="tbl_wrap">
			<table class="board_col_type01">
				<caption>검색</caption>
				<colgroup>
					<col>
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
							<form:select path="schEtc01" id="schEtc01" title="년도 선택" >
								<form:option value="" label="전체"/>
								<form:option value="2021" label="2021년"/>
								<form:option value="2022" label="2022년"/>
								<form:option value="2023" label="2023년"/>
								<form:option value="2024" label="2024년"/>
							</form:select>
							<form:select path="schEtc02" id="schEtc02" title="월 선택" >
								<form:option value="" label="전체"/>
								<form:option value="01" label="1월"/>
								<form:option value="02" label="2월"/>
								<form:option value="03" label="3월"/>
								<form:option value="04" label="4월"/>
								<form:option value="05" label="5월"/>
								<form:option value="06" label="6월"/>
								<form:option value="07" label="7월"/>
								<form:option value="08" label="8월"/>
								<form:option value="09" label="9월"/>
								<form:option value="10" label="10월"/>
								<form:option value="11" label="11월"/>
								<form:option value="12" label="12월"/>
							</form:select>		
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			<div class="btn_area">
	           	<a href="javascript:void(0);" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="weekJobJsonAction();">수동업데이트</a>
			</div>
	</form:form>
	<div class="tbl_pic"></div>
</div>
<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "", "", "svcSn");
	$("#crtDate").datepicker({
		buttonImage: "/component/itsm/images/sub/icon_calendar.png",
		buttonImageOnly: true,
		maxDate: 0,
		beforeShowDay: function(date){	
			var day = date.getDay();	
			return [(day != 0 && day != 1 && day != 2 && day != 3 && day != 4 && day != 6)];
		}		
	});
	
});

function weekJobJsonAction(){
	
	/* if($("#crtDate").val() == null || $("#crtDate").val() == ''){
		alert("수동업데이트 할 날짜를 선택해주세요.");
	}else{
	} */
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

</script>