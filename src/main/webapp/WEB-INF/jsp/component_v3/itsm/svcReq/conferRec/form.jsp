<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 스마트에디터 설정 --%>
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "cofCn",
		sSkinURI : "${pageContext.request.contextPath}/resource/editor/SmartEditor2Skin.html",
		fCreator : "createSEditor2"
	});
	
	fncDate('cofDt');
	fncDate('cofDtInsert');
	fncDate('regDt');
	fncSvcList("select", "선택", "${itsmConferRecVO.svcSn}", "svcSn",${sessionScope.itsm_user_info.userSvcSn});

	$("#slideUp1").click(function () {
		if($(this).text() == "목록열기"){
			$(this).text("목록닫기");
		} else {
			$(this).text("목록열기");
		}
		$('.js-srchDet1').slideToggle(300);
		$(this).toggleClass('open');
	});

	<c:choose>
		<c:when test="${fn:length(mngList) gt 0 }">
			<c:forEach var="result" items="${mngList }" varStatus="status">
				fncCodeList("SK02", "select", "선택", "${result.attDeptCd}", "", "attDeptCd_mng_"+'${status.index}', "", "ASC");
			</c:forEach>
		</c:when>
		<c:otherwise>
			fncCodeList("SK02", "select", "선택", "", "", "attDeptCd_mng_0", "", "ASC");
		</c:otherwise>
	</c:choose>

	<c:if test="${fn:length(impFncList) > 0 }">
		<c:forEach var="result" items="${impFncList }">
			var user = {
				imprvSn : '${result.imprvSn}',
				dmndCdNm : '${result.dmndCdNm}',
				dmndTtl : '${result.dmndTtl}'
			};
			impFncArray.push(user);
		</c:forEach>
			fncSetImpFnc();
	</c:if>

	<c:if test="${fn:length(rqstList) > 0 }">
		<c:forEach var="result" items="${rqstList }">
			var user = {
				rqrSn : "${result.rqrSn}",
				rqrId : "${result.rqrId}",
				rqrItm : "${result.rqrItm}",
				rqrDtl : "${result.rqrDtl}"
			};
			rqstArray.push(user);
		</c:forEach>
			fncSetRqst();
	</c:if>


	var date = "${today}";
	$("#cofDtInsert").val(date);
	
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload"));
	
	$("#btn_submit").on("click", function () {
		setDataList();
		setDmndDataList();

		oEditors.getById["cofCn"].exec("UPDATE_CONTENTS_FIELD", []);
		if(wrestSubmit(document.defaultFrm)){
			fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {fncPageBoard("submit", "${searchVO.procType}Proc.do")});
			return false;
		}
	});
	
	<%-- 수정시 회의시간 유효성검사 --%>
	$("#timeChk2").val('Y');
	
});
var oEditors = [];

let dmndCnt = 0;
var impFncArray = [];
var rqstArray = [];

<%-- 서비스요청(기능개선요청, 요구사항관리) --%>
function fncGetDmnd(divn){
	$("#svcDivn").val(divn);

	if(!$("#svcSn").val()){
		alert("서비스구분을 선택해주세요.")
		return false
	}

	if($("#svcDivn").val()){
		fncAjax('popFindPrcs.do', $('#defaultFrm').serialize(), 'html', true, '', function(data){
			modal_show('60%','80%', data);
		});
	}
}


let mngCnt = ${fn:length(mngList) gt 0 ? fn:length(mngList) : 0};
let openCnt = ${fn:length(openList) gt 0 ? fn:length(openList) : 0};

<%-- 참석자 추가 --%>
function fncAttAdd(gbn){

	var attHtml = "";
	let openText = "";

	if(gbn == 'mng'){

		$(".no_data_mng").remove()

		attHtml = '<tr id="tr_mng_'+mngCnt+'">';
		attHtml += '<td><select id="attDeptCd_mng_'+mngCnt+'" style="width: 100%"></td>';
 		attHtml += '<td><input type="text" id="attOftlNm_mng_'+mngCnt+'" title="직급" class="text required" maxlength="10"/></td>';
 		attHtml += '<td><input type="text" id="attNm_mng_'+mngCnt+'" title="이름" class="text required" maxlength="10" required="required"/></td>';
 		attHtml += '<td><a href="javascript:void(0)" class="btn btn_i_del" id="btn_dmnCd_del_mng_'+mngCnt+'" onclick="fncDelAtt('+mngCnt+', \''+gbn+'\');"><span></span></a></td>';

		$("#tbody_mng").append(attHtml);
		fncCodeList("SK02", "select", "선택", "", "", "attDeptCd_mng_"+mngCnt, "", "ASC");
		++mngCnt;

	}else if(gbn == 'open'){

		$(".no_data_open").remove()

		if($("[id^=attDeptCd_open_]").length == 0){
			openText = "(주)오픈노트";
		}
		attHtml = '<tr id="tr_open_'+openCnt+'">';
		attHtml += '<td>'+openText+'<input type="hidden" id="attDeptCd_open_'+openCnt+'" value="SK0101"/></td>';
 		attHtml += '<td><input type="text" id="attOftlNm_open_'+openCnt+'" title="직급" class="text required" maxlength="10"/></td>';
 		attHtml += '<td><input type="text" id="attNm_open_'+openCnt+'" title="이름" class="text required" maxlength="10" required="required"/></td>';
 		attHtml += '<td><a href="javascript:void(0)" class="btn btn_i_del" id="btn_dmnCd_del_open_'+openCnt+'" onclick="fncDelAtt('+openCnt+', \''+gbn+'\');"><span></span></a></td>';

		$("#tbody_open").append(attHtml);
		++openCnt;

	}
}

function setDataList(){
	$("[id^=attDeptCd_]").each(function(idx){
		var endNum = $(this).attr("id").replace("attDeptCd_", "");
		$("#attSn_" + endNum).attr("name", "attList[" + idx + "].attSn"); 			// 참석자 일련번호
		$("#attDeptCd_" + endNum).attr("name", "attList[" + idx + "].attDeptCd"); 	// 소속구분
		$("#attNm_" + endNum).attr("name", "attList[" + idx + "].attNm"); 			// 이름
		$("#attOftlNm_" + endNum).attr("name", "attList[" + idx + "].attOftlNm"); 	// 직급
	});

}

<%-- 참석자 삭제 --%>
function fncDelAtt(cnt, gbn){
    if(confirm("정말 삭제하시겠습니까?")){

    	if(gbn == 'mng'){
	        $("#tr_mng_"+cnt).remove();
			if($("[id^='tr_mng_']").length == 0){
				$("#tbody_mng").html('<tr class="no_data_mng"><td class="c" colspan="4">참석자를 추가해주세요.</td></tr>')
			}

    	}else if(gbn == 'open'){
    		$("#tr_open_"+cnt).remove();
			if($("[id^='tr_open_']").length == 0){
				$("#tbody_open").html('<tr class="no_data_open"><td class="c" colspan="4">참석자를 추가해주세요.</td></tr>')
			}
    	}

		setDataList();
    }

}

<%-- 시작시작 - 종료시간 확인(insert)--%>
function fncTimeAuto(obj){
	
	$("#timeChk").val("");
	
	var staTimeStr = $("#cofDtInsert").val()+" "+$("#cofStaHh").val()+":"+$("#cofStaMi").val()+":00";
	var staTime = new Date(staTimeStr);
	var endTimeStr = $("#cofDtInsert").val()+" "+$("#cofEndHh").val()+":"+$("#cofEndMi").val()+":00";
	var endTime = new Date(endTimeStr);
	var totalTime = Number((endTime.getTime() - staTime.getTime())/(1000*60));
	
	if($("#cofDtInsert").val() && $("#cofStaHh").val() && $("#cofStaMi").val() && $("#cofEndHh").val() && $("#cofEndMi").val()){
		if(totalTime <= 0){
			alert("회의종료 시간을 다시 설정해주세요.");
			$("#cofEndHh").val("");
			$("#cofEndMi").val("");
			$("#timeChk").val("");
			return false;
		}
		
		$("#timeChk").val('Y');

	}

}

<%-- 시작시작 - 종료시간 확인(update) --%>
function fncTimeAuto2(obj){
	
	$("#timeChk2").val("");
	
	var staTimeStr = $("#cofDt").val()+" "+$("#cofStaHh_2").val()+":"+$("#cofStaMi_2").val()+":00";
	var staTime = new Date(staTimeStr);
	var endTimeStr = $("#cofDt").val()+" "+$("#cofEndHh_2").val()+":"+$("#cofEndMi_2").val()+":00";
	var endTime = new Date(endTimeStr);
	var totalTime = Number((endTime.getTime() - staTime.getTime())/(1000*60));
	
	if($("#cofDt").val() && $("#cofStaHh_2").val() && $("#cofStaMi_2").val() && $("#cofEndHh_2").val() && $("#cofEndMi_2").val()){
		if(totalTime <= 0){
			alert("회의종료 시간을 다시 설정해주세요.");
			$("#cofEndHh_2").val("");
			$("#cofEndMi_2").val("");
			$("#timeChk2").val("");
			return false;
		}
		
		$("#timeChk2").val('Y');
	}
}

<%-- 기능개선요청 --%>
function fncSetImpFnc() {

	let classNm;
	var listHtml = "";

	impFncArray.map( function(item, idx) {
		classNm = item.dmndCdNm.trim() == '일반' ? 'gnr ' : item.dmndCdNm.trim() == '긴급' ? 'emg ' : item.dmndCdNm.trim() == '중요' ? 'imp ' : '-';

		listHtml += "<tr id='impFnc_"+item.imprvSn+"'>";
		listHtml += "	<td class='c'><p class='" + classNm + "rq_dv'>"+item.dmndCdNm+"</p><input type='hidden' id='serno_impFnc_"+dmndCnt+"' value='"+item.imprvSn+"'/>";
		listHtml += ""
		listHtml += "	<input type='hidden' id='menuCd_impFnc_"+dmndCnt+"' value='impFnc'/></td>";

		listHtml += "	<td>"+item.dmndTtl+"</td>";
		listHtml += "	<td class='c'><a href='javascript:void(0)' class='btn btn_sml btn_del' onclick='fncDelImpFnc(\""+item.imprvSn+"\");'>삭제</a></td>";
		listHtml += "</tr>";
		++dmndCnt;
	});

	$("#impFncList").html(listHtml)

	modal_hide_all();
}


function fncDelImpFnc(divnSn) {
	$("#impFnc_"+divnSn).remove();

	impFncArray = impFncArray.filter( function(e) {
		let eDivnSn = e.dmndCnSn
		return eDivnSn != divnSn;
	});

	if(impFncArray.length == 0){
		$("#impFncList").html('<tr><td class="c" colspan="3">기능개선요청 항목이 없습니다.</td></tr>')
	}

}


<%-- 요구사항 관리 --%>
function fncSetRqst() {

	var listHtml = "";


	rqstArray.map( function(item, idx) {
		listHtml += "<tr id='rqst_"+item.rqrSn+"'>";
		listHtml += "	<td class='c'>"+item.rqrId+"<input type='hidden' id='serno_rqst_"+dmndCnt+"' value='"+item.rqrSn+"'/><input type='hidden' id='menuCd_rqst_"+dmndCnt+"' value='rqst'/></td>";
		listHtml += "	<td class='c'>"+item.rqrItm+"</td>";
		listHtml += "	<td>"+item.rqrDtl+"</td>";
		listHtml += "	<td class='c'><a href='javascript:void(0)' class='btn btn_sml btn_del' onclick='fncDelRqst(\""+item.rqrSn+"\");'>삭제</a></td>";
		listHtml += "</tr>";
		++dmndCnt;
	});

	$("#rqstList").html(listHtml)

	modal_hide_all();
}


function fncDelRqst(divnSn) {
	$("#rqst_"+divnSn).remove();

	rqstArray = rqstArray.filter( function(e) {
		let eDivnSn = e.rqrSn
		return eDivnSn != divnSn;
	});

	if(rqstArray.length == 0){
		$("#rqstList").html('<tr><td class="c" colspan="4">요구사항 항목이 없습니다.</td></tr>')
	}

}

function setDmndDataList(){
	$("[id^=serno_]").each(function(idx){
		var endNum = $(this).attr("id").replace("serno_", "");
		$("#serno_" + endNum).attr("name", "dmndList[" + idx + "].dmndSn"); 	// 일련번호
		$("#menuCd_" + endNum).attr("name", "dmndList[" + idx + "].menuCd"); 	// 메뉴ID
	});

}

</script>

<form:form modelAttribute="itsmConferRecVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="cofSn" id="cofSn"/>
	<form:hidden path="cofTime" id="cofTime" value="1"/>
	<form:hidden path="atchFileId" id="atchFileId"/>
	<input type="hidden" id="svcDivn" name="svcDivn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="tbl_top">
		<div class="tbl_right"><span class="essential_txt"><span>*</span>는 필수입력</span></div>
	</div>
	<div class="tbl_wrap">
		<h4 class="md_tit">사업개요</h4>
		<table class="board_row_type01">
			<caption>내용(사업명, 계약기간, 계약번호, 업체명 등으로 구성)</caption>
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 30%;">
				<col style="width: 20%;">
				<col style="width: 30%;">
			</colgroup>
			<tbody>
				<c:choose>
					<c:when test="${searchVO.procType eq 'insert' }">
						<tr>
							<th scope="row"><strong class="th_tit">서비스구분</strong></th>
							<td colspan="3"><form:select path="svcSn" id="svcSn" title="서비스구분" required="true" style="width: 35%;"/></td>
						</tr>
						<tr>
							<th scope="row"><strong>ACTIVITY</strong></th>
							<td>운영/관리</td>
							<th scope="row"><strong>표준 산출물</strong></th>
							<td>회의록</td>
						</tr>
						<tr>
							<th scope="row"><strong>작성자</strong></th>
							<td><form:input path="regNm" id="regNm" title="작성자" class="text required" maxlength="10" /></td>
							<th scope="row"><strong>작성일자</strong></th>
							<td>${today }</td>
						</tr>
						<tr>
							<th scope="row"><strong>승인자</strong></th>
							<td></td>
							<th scope="row"><strong>Version</strong></th>
							<td>1.0</td>
						</tr>
						<tr>
							<th scope="row"><strong class="th_tit">회의일시</strong></th>
							<td colspan="3">
								<span class="calendar_input w120"><input type="text" name="cofDt" id="cofDtInsert" title="회의일시" readonly class="text w120" /></span>&nbsp;
	                        	<select name="cofStaHh" id="cofStaHh" onchange="fncTimeAuto(this);">
									<option value="">선택</option>
									<c:forEach begin="9" end="21" var="hh">
										<c:set var="strtHh" value="${hh.toString().startsWith('0') ? hh.toString().substring(1) : hh}"/>
										<option value="${strtHh}">${hh}시</option>
									</c:forEach>
	                        	</select>
								<select name="cofStaMi" id="cofStaMi" onchange="fncTimeAuto(this);">
									<option value="">선택</option>
									<c:forEach begin="0" end="50" step="10" var="mi" >
										<c:set var="strtMi" value="${mi.toString().startsWith('0') ? mi.toString().substring(1) : mi}"/>
										<option value="${strtMi}">${strtMi}분</option>
									</c:forEach>
								</select>
								<span class="gap">&nbsp;~&nbsp;</span>
	                        	<select name="cofEndHh" id="cofEndHh" onchange="fncTimeAuto(this);">
	                        		<option value="">선택</option>
									<c:forEach begin="9" end="21" var="hh">
										<c:set var="endHh" value="${hh.toString().startsWith('0') ? hh.toString().substring(1) : hh}"/>
										<option value="${endHh}">${hh}시</option>
									</c:forEach>
	                        	</select>
								&nbsp;
								<select name="cofEndMi" id="cofEndMi" onchange="fncTimeAuto(this);">
									<option value="">선택</option>
									<c:forEach begin="0" end="50" step="10" var="mi" >
										<c:set var="endMi" value="${mi.toString().startsWith('0') ? mi.toString().substring(1) : mi}"/>
										<option value="${endMi}">${endMi}분</option>
									</c:forEach>
								</select>
								<input type="hidden" id="timeChk" title="회의시간" required="required"/>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th scope="row"><strong class="th_tit">서비스구분</strong></th>
							<td colspan="3"><form:select path="svcSn" id="svcSn" title="서비스구분" required="true" style="width: 35%;"/></td>
						</tr>
						<tr>
							<th scope="row"><strong>ACTIVITY</strong></th>
							<td><form:input path="cofInfo" id="cofInfo" title="ACTIVITY" class="text required" maxlength="20" /></td>
							<th scope="row"><strong>표준 산출물</strong></th>
							<td><form:input path="cofKind" id="cofKind" title="표준 산출물" class="text required" maxlength="20" /></td>
						</tr>
						<tr>
							<th scope="row"><strong>작성자</strong></th>
							<td><form:input path="regNm" id="regNm" title="작성자" class="text required" maxlength="10" /></td>
							<th scope="row"><strong>작성일자</strong></th>
							<td><span class="calendar_input w120"><form:input path="regDt" id="regDt" readonly="true" class="text w120" /></span></td>
						</tr>
						<tr>
							<th scope="row"><strong>승인자</strong></th>
							<td><form:input path="apvrNm" id="apvrNm" title="승인자" class="text required" maxlength="10" /></td>
							<th scope="row"><strong>Version</strong></th>
							<td><form:input path="version" id="version" title="버전" class="text required" maxlength="10" /></td>
						</tr>
						<tr>
							<th scope="row"><strong class="th_tit">회의일시</strong></th>
							<td colspan="3"><span class="calendar_input w120"><form:input path="cofDt" id="cofDt" title="회의일시" readonly="true" class="text w120" /></span>&nbsp;
								<select name="cofStaHh" id="cofStaHh_2" onchange="fncTimeAuto2(this);">
									<option value="">선택</option>
									<c:forEach begin="9" end="21" var="hh">
										<c:set var="strtHh" value="${hh.toString().startsWith('0') ? hh.toString().substring(1) : hh}"/>
										<option ${itsmConferRecVO.cofStaHh eq strtHh ? 'selected' : ''} value="${strtHh}" <c:if test="${conferRecVO.cofStaHh eq strtHh}">selected</c:if>>${hh}시</option>
									</c:forEach>
	                        	</select>
								&nbsp;
								<select name="cofStaMi" id="cofStaMi_2" onchange="fncTimeAuto2(this);">
									<option value="">선택</option>
									<c:forEach begin="0" end="50" step="10" var="mi" >
										<c:set var="strtMi" value="${mi.toString().startsWith('0') ? mi.toString().substring(1) : mi}"/>
										<option ${itsmConferRecVO.cofStaMi eq strtMi ? 'selected' : ''} value="${strtMi}" <c:if test="${conferRecVO.cofStaMi eq strtMi}">selected</c:if>>${strtMi}분</option>
									</c:forEach>
								</select>
								<span class="gap">&nbsp;~&nbsp;</span>
	                        	<select name="cofEndHh" id="cofEndHh_2" onchange="fncTimeAuto2(this);">
	                        		<option value="">선택</option>
									<c:forEach begin="9" end="21" var="hh">
										<c:set var="endHh" value="${hh.toString().startsWith('0') ? hh.toString().substring(1) : hh}"/>
										<option ${itsmConferRecVO.cofEndHh eq endHh ? 'selected' : ''} value="${endHh}" <c:if test="${conferRecVO.cofEndHh eq endHh}">selected</c:if>>${hh}시</option>
									</c:forEach>
	                        	</select>
								&nbsp;
								<select name="cofEndMi" id="cofEndMi_2" onchange="fncTimeAuto2(this);">
									<option value="">선택</option>
									<c:forEach begin="0" end="50" step="10" var="mi" >
										<c:set var="endMi" value="${mi.toString().startsWith('0') ? mi.toString().substring(1) : mi}"/>
										<option ${itsmConferRecVO.cofEndMi eq endMi ? 'selected' : ''} value="${endMi}" <c:if test="${conferRecVO.cofEndMi eq endMi}">selected</c:if>>${endMi}분</option>
									</c:forEach>
								</select>
								<input type="hidden" id="timeChk2" title="회의시간" required="required"/>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr>
					<th scope="row"><strong class="th_tit">회의제목</strong></th>
					<td colspan="3"><form:input path="cofTtl" id="cofTtl" title="회의제목" class="text required" maxlength="90" required="true" /></td>
				</tr>
			</tbody>
		</table>
		<h4 class="md_tit mar_t30">참석자</h4>
		<div class="tbl_wrap02">			
			<div class="tbl_half_wrap mar_r20">	
				<button type="button" class="btn sml blue add_btn" onclick="fncAttAdd('mng');">추가<i class="xi-plus-circle-o"></i>
				</button>
				<table id="mng_table" class="board_row_type01 mar_b40">
					<colgroup>
						<col style="width: 35%">
						<col style="width: 30%">
						<col style="width: 30%">
						<col style="width: 5%">
					</colgroup>
					<thead>
						<tr>
							<th><strong>소속</strong></th>
							<th><strong>직급</strong></th>
							<th><strong class="th_tit">이름</strong></th>
							<th><strong></strong></th>
						</tr>
					</thead>
					<tbody id="tbody_mng">
						<c:choose>
							<c:when test="${fn:length(mngList) gt 0 }">
								<c:forEach var="mng" items="${mngList }" varStatus="status">
									<tr id="tr_mng_${status.index }">
										<td><select id="attDeptCd_mng_${status.index }" style="width: 100%"/><input type="hidden" id="attSn_mng_${status.index}" value="${mng.attSn}"/></td>
										<td><input type="text" id="attOftlNm_mng_${status.index }" value="${mng.attOftlNm}" title="직급" class="text required" maxlength="10"/></td>
										<td><input type="text" id="attNm_mng_${status.index }" value="${mng.attNm}" title="이름" class="text required" maxlength="10" required="required"/></td>
										<td><a href="javascript:void(0)" class="btn btn_i_del" id="btn_dmnCd_del_mng_0_${status.index }" onclick="fncDelAtt('${status.index }', 'mng');"><span></span></a></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="no_data_mng">
									<td class="c" colspan="4">
										참석자를 추가해주세요.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="tbl_half_wrap">			
				<button type="button" class="btn sml blue add_btn" onclick="fncAttAdd('open');">추가<i class="xi-plus-circle-o"></i></button>
				<table id="open_table" class="board_row_type01 mar_b40">
					<colgroup>
						<col style="width: 35%">
						<col style="width: 30%">
						<col style="width: 30%">
						<col style="width: 5%">
					</colgroup>
					<thead>
						<tr>
							<th><strong>소속</strong></th>
							<th><strong>직급</strong></th>
							<th><strong class="th_tit">이름</strong></th>
							<th><strong></strong></th>
						</tr>
					</thead>
					<tbody id="tbody_open">
						<c:choose>
							<c:when test="${fn:length(openList) gt 0 }">
								<c:forEach var="open" items="${openList }" varStatus="status">
									<tr id="tr_open_${status.index }">
										<td><c:if test="${status.first }">(주)오픈노트</c:if><input type="hidden" id="attSn_open_${status.index}" value="${open.attSn}"/></td>
										<input type="hidden" id="attDeptCd_open_${status.index }" value="SK0101"/>
										<td><input type="text" id="attOftlNm_open_${status.index }" value="${open.attOftlNm}" title="직급" class="text required" maxlength="10"/></td>
										<td><input type="text" id="attNm_open_${status.index }" value="${open.attNm}" title="이름" class="text required" maxlength="10" required="required"/></td>
										<td><a href="javascript:void(0)" class="btn btn_i_del" id="btn_dmnCd_del_open_0_${status.index }" onclick="fncDelAtt('${status.index }','open');"><span></span></a></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="no_data_open">
									<td class="c" colspan="4">
										참석자를 추가해주세요.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
		<h4 class="md_tit">요구사항 추가</h4>
		<a href="javascript:void(0)" class="btn btn_sml btn_toggle" id="slideUp1">${fn:length(impFncList) gt 0 or fn:length(rqstList) gt 0 ? '목록닫기' : '목록열기'}</a>
		<div class="js-srchDet1" style="display: ${fn:length(impFncList) gt 0 or fn:length(rqstList) gt 0 ? '' : 'none'};">
			<h4 class="sm_tit mar_t30">기능개선요청</h4>
			<button type="button" class="btn sml add_btn" onclick="fncGetDmnd('ImpFnc');" style="position: static;margin-top: 25px;">추가<i class="xi-plus-circle-o"></i></button>
			<table class="board_row_type01 mar_b40 mar_t10">
				<colgroup>
					<col style="width: 10%">
					<col>
					<col style="width: 7%">
				</colgroup>
				<thead>
					<tr>
						<th class="c" style="padding: 8px 25px 8px 25px;"><strong>구분</strong></th>
						<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요청내용</strong></th>
						<th class="c" style="padding: 8px 25px 8px 25px;"><strong>삭제</strong></th>
					</tr>
				</thead>
				<tbody id="impFncList">
					<tr>
						<td class="c" colspan="3">기능개선요청 항목이 없습니다.</td>
					</tr>
				</tbody>
			</table>
			<h4 class="sm_tit mar_t30">요구사항관리</h4>
			<button type="button" class="btn sml add_btn" onclick="fncGetDmnd('Rqst');" style="position: static;margin-top: 25px;">추가<i class="xi-plus-circle-o"></i></button>
			<table class="board_row_type01 mar_b40 mar_t10">
				<colgroup>
					<col style="width: 20%">
					<col style="width: 20%">
					<col>
					<col style="width: 7%">
				</colgroup>
				<thead>
				<tr>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요구사항 ID</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요구사항 항목</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요구사항 세부내역</strong></th>
					<th class="c" style="padding: 8px 25px 8px 25px;"><strong>삭제</strong></th>
				</tr>
				</thead>
				<tbody id="rqstList">
					<tr>
						<td class="c" colspan="4">요구사항 항목이 없습니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
		<br>
		<h4 class="md_tit mar_t30">회의내용</h4>
		<table class="board_row_type01 mar_b40">
			<colgroup>
				<col style="width: 100%">
			</colgroup>
			<thead>
				<tr>
					<td class="no_bdl"><form:textarea path="cofCn" id="cofCn" class="text_area_big" title="회의내용" style="resize: none;height: 400px;" required="true"/></td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<h4 class="md_tit mar_t30">첨부파일</h4>
		<table class="board_row_type01 mar_b40">
			<colgroup>
				<col style="width: 20%">
			</colgroup>
			<tbody>
				<tr>
					<th><p>첨부파일</p></th>
                    <td>
                        <div id="atchFileUpload"></div>
                    </td>
				</tr>
			</tbody>
		</table>
	</div>
</form:form>
<div class="btn_area">
	<c:choose>
		<c:when test="${searchVO.procType eq 'update' }">
				<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
		</c:when>
		<c:otherwise>
			<a href="javascript:void(0)" id="btn_submit" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_save">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
		</c:otherwise>
	</c:choose>
	<a href="javascript:void(0)" id="${searchVO.procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_cancel">취소</a>
</div>