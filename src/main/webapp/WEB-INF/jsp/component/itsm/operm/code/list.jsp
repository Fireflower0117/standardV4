<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
	var upChk="N";
	$(document).ready(function(){
		fncCdSel('${searchVO.uppoCdVal}','1');

		$("#excelFileUpload").html(setFileList("", "", "excel"));

		<%-- 코드 추가버튼 클릭 --%>
		$(document).on('click', '.cdAdd', function () {
			let type = $(this).data('type');
			let cdUppoVal = $(this).closest('td').closest('tr').data('up');
			let cdLvlVal = $(this).closest('td').closest('tr').data('lvl');
			let cdVal = $(this).closest('td').closest('tr').data('cd');

			<%-- 코드 추가 --%>
			fncCdAdd(type, cdUppoVal, cdLvlVal, cdVal);
		});
	});
	<%-- 처음 소분류와 중분류 값들 보여지게하는것  --%>
	const fncCdSel = function(code,num){

		if(num>5){
			return false;
		}
		if(upChk=="Y"){
			alert("수정중인 코드를 완료해 주세요.");
			return false;
		}

		$("#cdLvlVal").val(num);
		$("#uppoCdVal").val(code);

		var defaultHtml  = "<div class=\"cont\">";
			defaultHtml += "	<table class=\"code_tbl\">";
			defaultHtml += "		<caption></caption>";
			defaultHtml += "		<colgroup>";
			defaultHtml += "			<col style=\"width: 100px;\">";
			defaultHtml += "			<col style=\"width: 150px\">";
			defaultHtml += "			<col style=\"width: 150px\">";
			defaultHtml += "			<col>";
			defaultHtml += "		</colgroup>";
			defaultHtml += "		<tbody>";
			defaultHtml += "			<tr class=\"no_code\">";
			defaultHtml += "				<td colspan=\"4\">상위 코드를 선택해주세요</td>";
			defaultHtml += "			</tr>";
			defaultHtml += "		</tbody>";
			defaultHtml += "	</table>";
			defaultHtml += "</div>";

		$("[ID^=code_"+(Number(num)-1)+"_]").removeClass("on");
		$("#code_"+(Number(num)-1)+"_"+code).addClass("on");
		$.ajax({
			method: "POST",
			url: "view.do",
			data : $("#defaultFrm").serialize(),
			dataType: "html",
			success: function(data) {
				var numChk = Number($("#cdLvlVal").val());
				$("#codeList_"+numChk).html(data);
				if(num == '1'){
					$("#codeList_2").html(defaultHtml);
					$("#codeList_3").html(defaultHtml);
					$("#codeList_4").html(defaultHtml);
				}else if(num == '2'){
					$("#codeList_3").html(defaultHtml);
					$("#codeList_4").html(defaultHtml);
				}else if(num == '3'){
					$("#codeList_4").html(defaultHtml);
				}
			}
		});
	}

<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
	<%-- 등록 ,수정, 삭제 처리  --%>
	const formAction = function(code, num, type){
		$("#cdLvlVal").val(num);
		$("#uppoCdVal").val(code);

		if (type === 'insert'){
			type = 'post';
		}else if (type === 'update'){
			type = 'patch';
		}else if (type === 'delete'){
			type = 'delete';
		}

		$.ajax({
			type : type,
			url: "/itsm/operm/code/proc",
			data : $("#defaultFrm").serialize(),
			dataType: "json",
			success: function(data) {
				if(data.resultCnt == 0){
					alert("중복된 코드가 있습니다.");
					return false;
				}else{
					alert(data.message);
					fncCdSel(data.searchVO.uppoCdVal, data.searchVO.cdLvlVal);
				}
			}
		});
	}

	<%-- 위아래 처리 --%>
	const fncSort = function(type, uppoCdVal, cdVal, cdSortSeqo, cdLvlVal){
		$("#cdLvlVal").val(cdLvlVal);
		$("#uppoCdVal").val(uppoCdVal);
		$("#cdVal").val(cdVal);
		$("#cdSortSeqo").val(cdSortSeqo);

		$.ajax({
			method: "POST",
			url: type,
			data : $("#defaultFrm").serialize(),
			dataType: "json",
			success: function(data) {
				if(data.resultCnt == 0){
					alert(data.message);
					return false;
				}else{
					fncCdSel(data.searchVO.uppoCdVal, data.searchVO.cdLvlVal);
				}
			}
		});
	}

	const fncCdAdd = function(type, uppoCdVal, cdLvlVal, cdVal){
		if(type =="insert"){
			if($.trim($("#cdVal_"+cdLvlVal).val()) == ""){
				alert("코드를 입력해 주세요.");
				$("#cdVal_"+cdLvlVal).focus();
				return false;
			}
			if($.trim($("#cdValNm_"+cdLvlVal).val()) == ""){
				alert("코드명을 입력해 주세요.");
				$("#cdValNm_"+cdLvlVal).focus();
				return false;
			}
			$("#cdVal").val($("#cdVal_"+cdLvlVal).val());
			$("#cdValNm").val($("#cdValNm_"+cdLvlVal).val());
			$("#cdDtlsExpl").val($("#cdDtlsExpl_"+cdLvlVal).val());
			formAction(uppoCdVal, cdLvlVal, type);

		}else if(type =="update"){
			if($.trim($("#cdValNm_"+cdVal+"_up").val()) == ""){
				alert("코드명을 입력해 주세요.");
				$("#cdValNm_"+cdVal+"_up").focus();
				return false;
			}
			$("#cdVal").val($("#cdVal_"+cdVal+"_up").val());
			$("#cdValNm").val($("#cdValNm_"+cdVal+"_up").val());
			$("#cdDtlsExpl").val($("#cdDtlsExpl_"+cdVal+"_up").val());
			if(confirm("수정하시겠습니까?")){
				formAction(uppoCdVal, cdLvlVal, type);
			}

		}else if(type =="delete"){
			$("#cdVal").val($("#cdVal_"+cdVal+"_up").val());
			if(confirm("삭제하시겠습니까?")){
				formAction(uppoCdVal, cdLvlVal, type);
			}
		}
		upChk = "N";
	}

	const fncRewrite = function(id){
		if(upChk == "Y"){
			alert("수정중인 코드를 완료해 주세요.");
			return false;
		}
		$("#"+id).parents('tr').find('.code_basic').hide();
		$("#"+id).parents('tr').find('.code_correct').show();

		upChk="Y";

	}
</c:if>

	//tr 선택
	var trActive = $('.code_tbl tbody tr');

	trActive.click(function () {
	  $(this).addClass('active');
	  trActive.not($(this)).removeClass('active');
	});

//엑셀 업로드,다운로드
function fncExcel(clcd){
	
	if(clcd == 'openPop'){
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			modal_cmmn_excel();
		</c:if>
	} else if(clcd == 'up'){

		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			if(document.getElementById("excelFileTemp").files[0] === undefined) {
				alert("업로드할 파일을 선택해 주세요.");
				return false;
			}
			
			var reader = new FileReader();
	        reader.readAsBinaryString(document.getElementById("excelFileTemp").files[0]);
	        reader.onload = function(){
	            var fileData = reader.result;
	            var wb = XLSX.read(fileData, {type : 'binary'});
	            var num = 0;
	            wb.SheetNames.forEach(function(sheetName){
	            	if(num == 0) {
		                var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[sheetName],{header:"A",range:1});
	
		                var parsed = JSON.parse(JSON.stringify(rowObj), function(k, v) {
		                    switch (k){
		                        case "A" : this.uppoCdVal = v; break;		// 상위코드	
		                        case "B" : this.cdVal = v; break;	// 코드
		                        case "C" : this.cdValNm = v; break;	// 코드명
		                        case "D" : this.cdLvlVal = v; break;	// 차수
		                        case "E" : this.cdDtlsExpl = v; break;	// 설명
		                        default  : return v; break;
		                    }
		                });
	
		               $.ajax({
		                    url         : "excelUpload.do",
		                    type        : "POST",
		                    data        : JSON.stringify(parsed),
		                    dataType    : 'json',
		                    contentType : 'application/json; charset=utf-8',
		                    success     : function(data){
		                        if(data.result){
		                            alert(data.message);
		                            fncPageBoard('addList', 'addList.do', '1');
		                            modal_last_hide();
		                            fncCdSel('${searchVO.uppoCdVal}','1');
		                        }else{
		                            alert(data.message);
		                        }
		                    }
		                });
	            	}
	            	num += 1;
	            });
	        };
		</c:if>
		
	} else if (clcd == "sample") {
		fncPageBoard("view", "excelSampleDownload.do");
		$("#defaultFrm").attr("onsubmit","return false;");
	} else if(clcd == "down") {
		fncPageBoard("view", "excelDownload.do");
		$("#defaultFrm").attr("onsubmit","return false;");
	}	
}
</script>
<div class="tbl_top">
	<div class="tbl_left">
	</div>
	<div class="tbl_right">
		<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
			<a href="javascript:void(0);" class="btn btn_upload" onclick="fncExcel('openPop')" ><span>엑셀업로드</span></a>
			<a href="javascript:void(0);" class="btn btn_excel" onclick="fncExcel('down')" ><span>엑셀다운로드</span></a>
		</c:if>
	</div>
</div>
<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post">
	<input type="hidden" name="uppoCdVal" id="uppoCdVal" />
	<input type="hidden" name="cdVal" id="cdVal" />
	<input type="hidden" name="cdValNm" id="cdValNm" />
	<input type="hidden" name="cdLvlVal" id="cdLvlVal" />
	<input type="hidden" name="cdSortSeqo" id="cdSortSeqo" /> 
	<input type="hidden" name="cdDtlsExpl" id="cdDtlsExpl" />
	<div class="code_area">
		<c:forEach begin="1" end="4" step="1" var="index">
			<div class="code_box">
				<h4 class="code_tit">${index }차코드</h4>
				<table class="code_tbl title">
					<caption>${index }차코드</caption>
					<colgroup>
						<col style="width: 75px;">
						<col style="width: 150px;">
						<col style="width: 370px;">
						<col>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">코드</th>
							<th scope="col">코드명 (하위코드)</th>
							<th scope="col">설명</th>
							<th scope="col">관리</th>
						</tr>
					</thead>
				</table>
				<div id="codeList_${index }"></div>
			</div>
		</c:forEach>
	</div>
</form:form>