<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
	$(document).ready(function(){

		fncMenuCdSel('itsm','1');

		console.log('${catList[0].cdVal}');

		$(".tab_menu li").click(function(){
			$(this).addClass("on");
			$(this).siblings().removeClass("on");
		});


		<%-- 임시 메인 팝업 // --%>
	});
	<%-- 처음 소분류와 중분류 값들 보여지게하는것  --%>
	var fncMenuCdSel = function(uprMenuCd, menuLvl){

		if(menuLvl == 1){
			$("#menuSeCd").val(uprMenuCd);
		}

		if(menuLvl>4){
			return false;
		}

		$("#menuLvl").val(menuLvl);
		$("#uprMenuCd").val(uprMenuCd);

		var defaultHtml  = "<div class=\"cont\">";
		defaultHtml += "	<table class=\"code_tbl\">";
		defaultHtml += "		<caption></caption>";
		defaultHtml += "		<colgroup>";
		defaultHtml += "			<col >";
		defaultHtml += "			<col style=\"width: 23%\">";
		defaultHtml += "			<col>";
		defaultHtml += "		</colgroup>";
		defaultHtml += "		<tbody>";
		defaultHtml += "			<tr class=\"no_code\">";
		defaultHtml += "				<td colspan=\"3\">상위메뉴를 선택해 주세요.</td>";
		defaultHtml += "			</tr>";
		defaultHtml += "		</tbody>";
		defaultHtml += "	</table>";
		defaultHtml += "</div>";

		$("[ID^=menu_"+(Number(menuLvl)-1)+"_]").removeClass("on");
		$("#menu_"+(Number(menuLvl)-1)+"_"+uprMenuCd).addClass("on");
		$.ajax({
			method: "POST",
			url: "addList.do",
			data : $("#defaultFrm").serialize(),
			dataType: "html",
			success: function(data) {
				var numChk = Number($("#menuLvl").val());
				$("#menuList_"+numChk).html(data);
				if(menuLvl == '1'){
					$("#menuList_2").html(defaultHtml);
					$("#menuList_3").html(defaultHtml);
					$("#menuList_4").html(defaultHtml);
				} else if(menuLvl == '2'){
					$("#menuList_3").html(defaultHtml);
					$("#menuList_4").html(defaultHtml);
				} else if(menuLvl == '3'){
					$("#menuList_4").html(defaultHtml);
				}
			}
		});
	}

	<%-- 등록 ,수정, 삭제 처리  --%>
	var formAction = function(uprMenuCd, menuLvl, type){
		$("#menuLvl").val(menuLvl);
		$("#uprMenuCd").val(uprMenuCd);
		$.ajax({
			method: "POST",
			url: type+"Proc.json",
			data : $("#defaultFrm").serialize(),
			dataType: "json",
			success: function(data) {
				var callType= data.type;
				alert(callType+"되었습니다.");
				fncMenuCdSel(data.searchVO.uprMenuCd,data.searchVO.menuLvl);
			}
		});
	}

	<%-- 위아래 처리 --%>
	var fncSort = function(type, uprMenuCd, menuCd, menuSeqo, menuLvl){
		$("#menuLvl").val(menuLvl);
		$("#uprMenuCd").val(uprMenuCd);
		$("#menuCd").val(menuCd);
		$("#menuSeqo").val(menuSeqo);
		$.ajax({
			method: "POST",
			url: type+"Proc.json",

			data : $("#defaultFrm").serialize(),
			dataType: "json",
			success: function(data) {
				fncMenuCdSel(data.searchVO.uprMenuCd,data.searchVO.menuLvl);
			}
		});
	}

	var fncDeleteMenu = function(uprMenuCd, menuLvl, menuSerno){
		$("#menuSerno").val(menuSerno);
		if(confirm("삭제하시겠습니까?")){
			formAction(uprMenuCd, menuLvl, 'delete');
		}

	}

	var fncMenuCdAdd = function(menuLvl, uprMenuCd){
		if($.trim($("#menuCd_"+menuLvl).val()) == ""){
			alert("메뉴코드를 입력해 주세요.");
			$("#menuCd_"+menuLvl).focus();
			return false;
		}
		if($.trim($("#menuNm_"+menuLvl).val()) == ""){
			alert("메뉴명을 입력해 주세요.");
			$("#menuNm_"+menuLvl).focus();
			return false;
		}
		if($("#addUrl_"+menuLvl).val() == "N" && $("#targetBlankYn_"+menuLvl).val() == "Y") {
			alert("[새창에서 열기] 옵션은 [URL생성] 일때만 가능합니다.");
			$("#targetBlankYn_"+menuLvl).focus();
			return false;
		}
		$("#menuCd").val($("#menuCd_"+menuLvl).val());
		$("#menuNm").val($("#menuNm_"+menuLvl).val());
		$("#addUrl").val($("#addUrl_"+menuLvl).val());
		$("#targetBlankYn").val($("#targetBlankYn_"+menuLvl).val());

		//메뉴코드 중복검사
		$.ajax({
			method : "POST",
			url : "menuCdOvlpChk.do",
			data : $("#defaultFrm").serialize(),
			dataType : "JSON",
			success : function(data){
				if(data.cnt > 0){
					alert("이미 사용중인 메뉴코드입니다.");
					return false;
				} else {
					formAction(uprMenuCd, menuLvl, 'insert');
				}
			},error : function(){
				alert("오류가 발생하였습니다. 잠시후에 다시 시도해 주세요.");
				return false;
			}
		});
	}

	function fncExcel(clcd){
		if(clcd == "down") {
			fncPageBoard("view", "excelDownload.do");
			$("#defaultFrm").attr("onsubmit","return false;");
		}
	}

	var fncCdAdd = function(type,uppoCdVal, cdLvlVal, cdVal){
		if($("#cdVal").val() == ""){
			alert("메뉴코드를 입력해 주세요.");
			$("#cdVal").focus();
			return false;
		}
		if($("#cdValNm").val() == ""){
			alert("메뉴명을 입력해 주세요.");
			$("#cdValNm").focus();
			return false;
		}
		formActionV2(uppoCdVal, cdLvlVal, type);
		upChk = "N";
	}

	var formActionV2 = function(code, num, type){
		$("#cdLvlVal").val(num);
		$("#uppoCdVal").val(code);
		$.ajax({
			method: "POST",
			url: "/ma/sys/code/"+type+"Proc.do",
			data : $("#defaultFrm_2").serialize(),
			dataType: "json",
			success: function(data) {
				var callType= data.type;
				if(callType == "OVER"){
					alert("중복된 메뉴코드입니다.");
					$("#cdVal").focus();
					return false;
				}else{

					if (callType == "순서") {

						if (data.result > 1) {
							alert(callType+"에 성공하였습니다.");
						} else {
							alert(callType+"에 실패하였습니다.");
						}

					} else {
						if (data.result > 0) {
							alert(callType+"에 성공하였습니다.");
						} else {
							alert(callType+"에 실패하였습니다.");
						}
					}
					modal_hide($("#defaultFrm_2"))
					fncPageBoard('list', 'list.do');
				}
			}
		});
	}
</script>
<style>
</style>
<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post">
	<input type="hidden" name="menuSerno" id="menuSerno" />
	<input type="hidden" name="uprMenuCd" id="uprMenuCd" />
	<input type="hidden" name="menuCd" id="menuCd" />
	<input type="hidden" name="menuNm" id="menuNm" />
	<input type="hidden" name="menuLvl" id="menuLvl" />
	<input type="hidden" name="menuSeqo" id="menuSeqo" />
	<input type="hidden" name="menuExpl" id="menuExpl" />
	<input type="hidden" name="menuUrlAddr" id="menuUrlAddr" />
	<input type="hidden" name="addUrl" id="addUrl" />
	<input type="hidden" name="bltnSeVal" id="bltnSeVal" />
	<input type="hidden" name="expsrYn" id="expsrYn" />
	<input type="hidden" name="subDivn" id="subDivn" />
	<input type="hidden" name="menuSeCd" id="menuSeCd" />
	<input type="hidden" name="targetBlankYn" id="targetBlankYn" />
	<div class="tbl_top">
		<div class="tbl_right">
			<%--<a class="btn blue" onclick="fncAddCat()"><span>+ 카테고리추가</span></a>--%>
			<button type="button" class="btn btn_excel" onclick="fncExcel('down')"><span>엑셀다운로드</span></button>
		</div>
	</div>

	<div class="code_area">
		<c:forEach begin="1" end="2" step="1" var="index">
			<div class="code_box">
				<h4 class="code_tit"><c:out value="${index }"/>차메뉴</h4>
				<table class="code_tbl title">
					<caption><c:out value="${index }"/>차메뉴</caption>
					<colgroup>
						<col style="width: 400px;">
						<col>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">메뉴명 (하위메뉴)</th>
						<th scope="col">관리</th>
					</tr>
					</thead>
				</table>
				<div id="menuList_${index }"></div>
			</div>
		</c:forEach>
		<c:forEach begin="3" end="4" step="1" var="index">
			<div class="code_box">
				<h4 class="code_tit"><c:out value="${index }"/>차메뉴</h4>
				<table class="code_tbl title">
					<caption><c:out value="${index }"/>차메뉴</caption>
					<colgroup>
						<col style="width: 400px;">
						<col>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">메뉴명</th>
						<th scope="col">관리</th>
					</tr>
					</thead>
				</table>
				<div id="menuList_${index }"></div>
			</div>
		</c:forEach>
	</div>
</form:form>