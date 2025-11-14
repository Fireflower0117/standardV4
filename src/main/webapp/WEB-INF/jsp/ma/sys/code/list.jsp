<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
<%-- 수정 중 체크 변수 --%>
var upChk="N";
$(document).ready(function(){
	<%-- 1차코드 셋팅 --%>
	fncCdSel('<c:out value="${searchVO.cdUppoVal}"/>','1');

	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<%-- 코드 수정버튼 클릭 --%>
		$(document).on('click', '.code_rewrite', function () {
			<%-- 드래그 앤 드롭 비활성화 --%>
			$(".cd_tblBody").sortable("disable");
			<%-- 수정함수 --%>
			fncRewrite($(this).data('id'));
		});

		<%-- 코드 추가버튼 클릭 --%>
		$(document).on('click', '.cdAdd', function () {
			let type = $(this).data('type');
			let cdUppoVal = $(this).closest('td').closest('tr').data('up');
			let cdLvlVal = $(this).closest('td').closest('tr').data('lvl');
			let cdVal = $(this).closest('td').closest('tr').data('cd');

			<%-- 코드 추가 --%>
			fncCdAdd(type, cdUppoVal, cdLvlVal, cdVal);
		});
	</c:if>

	<%-- 클릭 시 하위 코드 조회 --%>
	$(document).on('click', '.cdSel', function () {
		let cdUppoVal = $(this).closest('td').closest('tr').data('up');
		let cdVal = $(this).closest('td').closest('tr').data('cd');
		let cdLvlVal = $(this).closest('td').closest('tr').data('lvl');
		let cdUpChk = $(this).data('upchk');

		if (cdUpChk == "N") {
			upChk = cdUpChk;
			fncCdSel(cdUppoVal, cdLvlVal);
		} else {
			fncCdSel(cdVal, cdLvlVal + 1);
		}
	});
});

<%-- n차 코드 조회  --%>
const fncCdSel = function(code,num){

	if(num>=5){
		return false;
	}
	if(upChk=="Y"){
		alert("수정중인 코드를 완료해 주세요.");
		return false;
	}

	$("#cdLvlVal").val(num);
	$("#cdUppoVal").val(code);

	var defaultHtml  = "<div class=\"cont\">";
		defaultHtml += "	<table class=\"code_tbl\">";
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
	    url: "codeList.do",
	    data : $("#defaultFrm").serialize(),
	    dataType: "html",
	    success: function(data) {
	    	var numChk = Number($("#cdLvlVal").val());
			<%-- 드래그앤 드롭 범위 지정을 위해 클래스명 및 스크립트에 번호 추가 --%>
			var html = data.replace(/cd_tblBody/g, "cd_tblBody"+numChk).replace(/code_box/g, "code_box"+numChk)
	    	$("#codeList_"+numChk).html(html);
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
		$("#cdUppoVal").val(code);

		if (type === 'insert'){
			type = 'post';
		}else if (type === 'update'){
			type = 'patch';
		}else if (type === 'delete'){
			type = 'delete';
		}

		$.ajax({
			type : type,
			url: "/ma/sys/code/proc",
			data : $("#defaultFrm").serialize(),
			dataType: "json",
			success: function(data) {
				if(data.resultCnt == 0){
					alert("중복된 코드가 있습니다.");
					return false;
				}else{
					alert(data.message);

					fncCdSel(data.searchVO.cdUppoVal, data.searchVO.cdLvlVal);
				}
			},error: function (xhr, status, error) {

				if (xhr.status == 401) {
					window.location.reload();
				}
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		});
	}

	<%-- 정렬 --%>
	const fncSort = function(cdSerno, cdNextSerno, cdLvlVal){
		$.ajax({
			method: "POST",
			url: "/ma/sys/code/sort",
			data : {cdSerno:cdSerno, cdNextSerno:cdNextSerno, cdLvlVal:cdLvlVal},
			dataType: "json",
			success: function(data) {
				alert(data.message)
			},error: function (xhr, status, error) {
				if (xhr.status == 401) {
					window.location.reload();
				}
			}
		});
	}

	<%-- 코드 추가 --%>
	const fncCdAdd = function(type, cdUppoVal, cdLvlVal, cdVal){
		<%-- 등록인 경우 --%>
		if(type =="insert"){
			if($.trim($("#cdVal_"+cdLvlVal).val()) == ""){
				alert("코드를 입력해 주세요.");
				$("#cdVal_"+cdLvlVal).focus();
				return false;
			}

			if($.trim($("#cdNm_"+cdLvlVal).val()) == ""){
				alert("코드명을 입력해 주세요.");
				$("#cdNm_"+cdLvlVal).focus();
				return false;
			}

			if($.trim($("#cdVal_"+cdLvlVal).val()).length != cdLvlVal*2){
				alert(cdLvlVal + "레벨의 경우 " + cdLvlVal*2 + "자리를 입력해 주세요.");
				$("#cdVal_"+cdLvlVal).focus();
				return false;
			}

			$("#cdVal").val($("#cdVal_"+cdLvlVal).val());
			$("#cdNm").val($("#cdNm_"+cdLvlVal).val());
			$("#cdDtlsExpl").val($("#cdDtlsExpl_"+cdLvlVal).val());
			formAction(cdUppoVal, cdLvlVal, type);

		<%-- 수정인 경우 --%>
		}else if(type =="update"){
			if($.trim($("#cdNm_"+cdVal+"_up").val()) == ""){
				alert("코드명을 입력해 주세요.");
				$("#cdNm_"+cdVal+"_up").focus();
				return false;
			}
			$("#cdVal").val($("#cdVal_"+cdVal+"_up").val());
			$("#cdNm").val($("#cdNm_"+cdVal+"_up").val());
			$("#cdDtlsExpl").val($("#cdDtlsExpl_"+cdVal+"_up").val());
			if(confirm("수정하시겠습니까?")){
				formAction(cdUppoVal, cdLvlVal, type);
			}

		}else if(type =="delete"){
			$("#cdVal").val($("#cdVal_"+cdVal+"_up").val());
			if(confirm("삭제하시겠습니까?")){
				formAction(cdUppoVal, cdLvlVal, type);
			}
		}
		upChk = "N";
	}

	<%-- 코드 수정 --%>
	const fncRewrite = function(id){

		if(upChk == "Y"){
			alert("수정중인 코드를 완료해 주세요.");
			return false;
		}
		<%-- 수정 폼 --%>
		$("#"+id).parents('tr').find('.code_basic').hide();
		$("#"+id).parents('tr').find('.code_correct').show();

		<%-- 수정 중 --%>
		upChk="Y";
	}

</c:if>

</script>
<div class="tbl_top">
	<div class="tbl_left">
	</div>
	<div class="tbl_right">
	</div>
</div>
<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post">
	<input type="hidden" name="cdUppoVal" id="cdUppoVal" />
	<input type="hidden" name="cdVal" id="cdVal" />
	<input type="hidden" name="cdNm" id="cdNm" />
	<input type="hidden" name="cdLvlVal" id="cdLvlVal" />
	<input type="hidden" name="cdSortSeqo" id="cdSortSeqo" />
	<input type="hidden" name="cdDtlsExpl" id="cdDtlsExpl" />
	<div class="tbl_top">
		<div class="tbl_left"></div>
		<div class="tbl_right"></div>
	</div>
	<div class="code_area">
		<c:forEach begin="1" end="2" step="1" var="index">
			<div class="code_box code_box<c:out value="${index }"/>" style="width: 50%;">
				<h4 class="code_tit"><c:out value="${index }"/>차코드</h4>
				<div class="code_top">
					<table class="code_tbl">
						<caption><c:out value="${index }"/>차 코드목록(코드, 코드명(하위코드), 설명, 관리로 구성)</caption>
						<colgroup>
							<col style="width: 90px;">
							<col style="width: 160px">
							<col style="width: 350px">
							<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
								<col>
							</c:if>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">코드</th>
								<th scope="col">코드명 (하위코드)</th>
								<th scope="col">설명</th>
								<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
									<th scope="col">관리</th>
								</c:if>
							</tr>
						</thead>
					</table>
				</div>
				<div id="codeList_<c:out value="${index }"/>"></div>
			</div>
		</c:forEach>
	</div>
	<!-- mar_t10px -->
	<div class="code_area" style="margin-top:30px">
		<c:forEach begin="3" end="4" step="1" var="index">
			<div class="code_box code_box<c:out value="${index }"/>" style="width: 50%;">
				<h4 class="code_tit"><c:out value="${index }"/>차코드</h4>
				<div class="code_top">
					<table class="code_tbl">
						<caption><c:out value="${index }"/>차 코드목록(코드, 코드명(하위코드), 설명, 관리로 구성)</caption>
						<colgroup>
							<col style="width: 90px;">
							<col style="width: 160px">
							<col style="width: 350px">
							<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
								<col>
							</c:if>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">코드</th>
								<th scope="col">코드명 (하위코드)</th>
								<th scope="col">설명</th>
								<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
									<th scope="col">관리</th>
								</c:if>
							</tr>
						</thead>
					</table>
				</div>
				<div id="codeList_<c:out value="${index }"/>"></div>
			</div>
		</c:forEach>
	</div>
</form:form>