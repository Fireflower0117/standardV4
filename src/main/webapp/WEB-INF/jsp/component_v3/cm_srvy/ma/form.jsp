<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
var itmMap = new Map();
var qstMap = new Map();
var sectionIdx = 0;


<%--유형선택시 옵션값 불러오기 --%>
const fncSelRplyCl = function(srvySctnSerno, srvyQstSerno, selectOption, qstItmList){
	
	var ajaxData = {};
	ajaxData["srvySctnSerno"] = srvySctnSerno;
	ajaxData["srvyQstSerno"] = srvyQstSerno;
	ajaxData["selectOption"] = selectOption;
	if(qstItmList != ''){
		ajaxData["qstItmList"] = qstItmList;
	}
	<%-- 유형값이 있을때만 실행 --%>
	if(selectOption !== null ||  selectOption !== ""){
		$.ajax({
			type : "post",
			url : 'selectOption.do',
			data : ajaxData,
			dataType : 'HTML',
			success : function(data) {
				$("#srvy_qst_itm_" + srvySctnSerno + "_" + srvyQstSerno).html(data);
			},
			error: function (xhr, status, error) {
				if (xhr.status == 401) {
					window.location.reload();
				}
				
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		}).done(function(data) {
			if(selectOption == "3"){ <%--객관식--%>
				ncsrNextSecChk($("input[name='sctnList["+srvySctnSerno+"].qstList[" + srvyQstSerno + "].srvyNcsrYn']"), srvySctnSerno, srvyQstSerno);
			
			} else if(selectOption == "6"){ <%--이미지--%>
				$('#atchFileDiv_' + srvySctnSerno + '_' + srvyQstSerno + '_0').html(setFileList($("#qstFile_" + srvySctnSerno + "_" + srvyQstSerno + "_0").val(), "qstFile_" + srvySctnSerno + "_" + srvyQstSerno + "_0", "image","1"));
		
			} else if(selectOption == "8"){ <%--날짜--%>
				fncDate("qstDate_" + srvySctnSerno + "_" + srvyQstSerno + "_0");
				
			} 
        });
	}else{	
		$("#srvy_qst_itm_" + srvySctnSerno + "_" + srvyQstSerno).html("");
	}	
}

<%--체크박스 선택 시 선택 가능 갯수 조절--%>
const fncChangeRplyOpt = function(srvySctnSerno, srvyQstSerno){ 
	var html = "";
	var check = $("#nextRply_" + srvySctnSerno + "_" + srvyQstSerno).val();
	
	var length = $("input[type=text]input[name^='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList'],input[type=hidden]input[name^='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList']").length;
	for(var i =0; i< length; i++){
		var idx = i + 1;
		if(check == idx){
			html += "<option value='"+idx+"' selected='selected'>"+idx+"</option>";
		}else{
			html += "<option value='"+idx+"'>"+idx+"</option>";
		}		
	}
	$("#nextRply_" + srvySctnSerno + "_" + srvyQstSerno).html(html);
}

<%-- 섹션 추가 --%>
const fncAddSctn = function(){
	
	sectionIdx += 1;
	var sectionLength = $(".srvy_section").length;
    $.ajax({
		type : "post",
		url : 'addSection.do',
		data : { srvySctnSerno : sectionIdx, sectionLength : sectionLength},
		dataType : 'HTML',
		success : function(data) {
            $(".srvy_add_wrap").append(data);
            qstMap.set(sectionIdx, 0);
            setSecTot();
           	setNextSecNo();
		},
		error: function (xhr, status, error) {
			if (xhr.status == 401) {
				window.location.reload();
			}
			
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	})
}

<%-- 필수 체크 : 객관식 답변에 따른 진행 --%>
const ncsrNextSecChk = function(obj,srvySctnSerno, srvyQstSerno){
	
	if($("#srvyAnsCgVal_" + srvySctnSerno + "_" + srvyQstSerno).val() == '3' ){
		if($(obj).is(":checked")) {
			$(".nextSecChk_" + srvySctnSerno + "_" + srvyQstSerno).show();
		} else {
			$("#nextSecChk_" + srvySctnSerno + "_" + srvyQstSerno).prop("checked",false);
			$(".nextSecChk_" + srvySctnSerno + "_" + srvyQstSerno).hide();
			changeNextSctnNo(srvySctnSerno, srvyQstSerno);
		}
	}
}

<%-- 섹션 이동 select --%>
const changeNextSctnNo = function(srvySctnSerno, srvyQstSerno){
	
	if($("#nextSecChk_" + srvySctnSerno + "_" + srvyQstSerno).prop("checked")){
		$(".nextSeNo_" + srvySctnSerno + "_" + srvyQstSerno).removeAttr("disabled");
		$(".nextSeNo_" + srvySctnSerno + "_" + srvyQstSerno).css("display", "inline-block");
		$("#srvy_section_" + srvySctnSerno).find("table .next_sec").attr("disabled", true);
		setAnsNextSecNo(srvySctnSerno, srvyQstSerno);
	}else{
		$("#srvy_section_" + srvySctnSerno).find("table .next_sec").removeAttr("disabled");
		$(".nextSeNo_" + srvySctnSerno + "_" + srvyQstSerno).attr("disabled", true);
		$(".nextSeNo_" + srvySctnSerno + "_" + srvyQstSerno).css("display", "none");
	}	
}

<%-- 섹션 항목 추가 --%>
const fncAddQst = function(srvySctnSerno){
	
	var num = Number(srvySctnSerno);
	if(qstMap.get(num) == null){
		qstMap.set(num, 0);
	} 
	var srvyQstSerno = qstMap.get(num) + 1;
	
    $.ajax({
        type     : "post",
        url      : "addQst.do",
        data     : { srvySctnSerno : srvySctnSerno, srvyQstSerno : srvyQstSerno  },
        dataType : "HTML",
        success  : function(data){
            $("#srvy_section_"+srvySctnSerno).append(data);
            qstMap.set(num, srvyQstSerno);
        }
    })
    
    
    var length = $(".btn_addQst_" + srvySctnSerno).length;
    for(var i = 0; i < length; i++){
    	var idx = i +1;
		if (idx == length) {
			$(this).css("display", "");
	    }else{
	    	$(this).css("display", "none");
	    }
    }
	
}

<%-- 섹션 삭제 --%>
const fncDelSec = function(srvySctnSerno){
	if(confirm("섹션을 삭제 하시겠습니까?")){
		var delSerno;
		$("[id^=srvy_section_]").each(function(i){
			if(i == 0){
				if(srvySctnSerno == $(this).data("srvysctnserno")){
					delSerno = srvySctnSerno;
				}			
			}			
		});
		$(".srvy_section_"+srvySctnSerno).remove();
		setSecTot(delSerno);	
	}
	setNextSecNo();
	
	<%-- 섹션이 하나도 안남으면 기본 섹션 생성 --%>
	if($(".srvy_section").length == 0){
		fncAddSctn();
	}
	
}

<%-- 항목 삭제--%>
const fncDelQst = function(srvySctnSerno, srvyQstSerno){
	
	if(confirm("항목을 삭제 하시겠습니까?")){
		$("#qst_" + srvySctnSerno + "_"+srvyQstSerno).remove();	
	}else{
		return false;
	}
	
	var length = $(".btn_addQst_" + srvySctnSerno).length;
	for(var i = 0; i < length; i++){
		var idx = i + 1;
		if (idx == $(".btn_addQst_" + srvySctnSerno).length - 1) {
			$(this).css("display", "");
	    }else{
	    	$(this).css("display", "none");
	    }
	};
	
	<%-- 항목이 하나도 안남으면 기본 섹션 생성 --%>
	if($(".srvy_qst_itm_"+ srvySctnSerno).length === 0){
		fncAddQst(srvySctnSerno);
	}
	
}


<%-- 섹션별 진행 섹션 설정 --%>
const setNextSecNo = function(){
	
	var nextSecOpt = "";
	
	$(".next_sec").each(function(i){ <%--진행 섹션--%>
		
		var selectValue = $(this).val();
		nextSecOpt = "<option value=''>다음 섹션으로 이동</option>";
		
		if($(".srvy_sec_no").length > 1){  <%--섹션이 한개 이상일 때--%>
			$(".srvy_sec_no").each(function(idx){
				if(idx != i && idx != parseInt(i)+1 ) {
					nextSecOpt += "<option value='";
					nextSecOpt += $(this).val()+ "'";
					
					if(selectValue == $(this).val()){
						nextSecOpt += " selected='selected' ";
					}
					
					nextSecOpt += "'>";
					nextSecOpt += (idx + 1) + " 섹션으로 이동</option>";
				}
			});
		}
		
		$(this).html(nextSecOpt);
	});
}


<%-- 문항 추가시 나오는 항목 추가--%>
const fncAddQstItm = function(srvySctnSerno,srvyQstSerno){
	
	var rplyCl = $("#srvyAnsCgVal_" + srvySctnSerno + "_" + srvyQstSerno).val();
	var qstItm = "";
	
	var qstItmIdx = 1;
	
	var lengthCk = '';
	if(rplyCl == '6'){
		lengthCk = $("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find(".field").length;
	} else if(rplyCl == '8') {
		lengthCk = $("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find(".hasDatepicker").length;
	} else {
		lengthCk = $("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find("input[type=text]").length;
	}
	
	if( lengthCk  > 9 ) {
		alert("항목은 최대 10개까지 추가 가능합니다. ");
		return false;
	}
	
	
	var itmNum = Number(srvyQstSerno);
	if(itmMap.get(itmNum) != null){
		qstItmIdx = Number(itmMap.get(itmNum)) + 1;
		itmMap.set(itmNum, qstItmIdx);
	}else{
		itmMap.set(itmNum, qstItmIdx);
	}
	
	if(rplyCl == '3'){ <%--객관식--%>
		
		qstItm = "<div id='itmList_"+qstItmIdx+"' style='margin-top:5px;'>";
		qstItm += "	<input type='text' name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList[" + qstItmIdx + "].srvyQstItmCtt' style='width:300px;' maxlength = '30' title='옵션' id='option_" + srvySctnSerno + "_" + srvyQstSerno + "_" +  +qstItmIdx + "' required='required'>";
		qstItm += "	<select name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno+ "].qstItmList[" + qstItmIdx + "].srvyNextSctnNo' class='nextSeNo_" + srvySctnSerno + "_" + srvyQstSerno + " ans_next_sec' style='display:none;'>";
		qstItm += "		<option value=''>다음 섹션으로 이동</option>";
		qstItm += "	</select>";
		qstItm += "	<button type='button' style='margin-left:5px;' class='btn sml delete_itm_element' data-qstitmidx=" + qstItmIdx + " data-rplycl=" + rplyCl + " data-srvysctnserno=" + srvySctnSerno + " data-srvyqstserno=" + srvyQstSerno + "><span>삭제</span></button>";
		qstItm += "</div>";

		if( $("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find('.etc').length > 0 ) {
			$("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find('.etc').parent().before(qstItm);
		} else {
			$("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).append(qstItm);
		}
		fncChangeRplyOpt(srvySctnSerno,srvyQstSerno);
		changeNextSctnNo(srvySctnSerno,srvyQstSerno);
		
	} else if(rplyCl == '4'){ <%--체크박스--%>

		qstItm = "<div id='itmList_"+qstItmIdx+"' style='margin-top:5px;'>";
		qstItm += "	<input type='text' name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList[" + qstItmIdx + "].srvyQstItmCtt' style='width:300px;' maxlength = '30' title='옵션' id='option_" + srvySctnSerno + "_" + srvyQstSerno + "_" +  +qstItmIdx + "' required='required'>";
		qstItm += "	<button type='button' style='margin-left:5px;' class='btn sml delete_itm_element' data-qstitmidx=" + qstItmIdx + " data-rplycl=" + rplyCl + " data-srvysctnserno=" + srvySctnSerno + " data-srvyqstserno=" + srvyQstSerno + "><span>삭제</span></button>";
		qstItm += "</div>";

		if( $("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find('.etc').length > 0 ) {
			$("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find('.etc').parent().before(qstItm);
		} else {
			$("#srvy_qst_itm_add_"+ srvySctnSerno + "_" + srvyQstSerno).append(qstItm);
		}
		fncChangeRplyOpt(srvySctnSerno,srvyQstSerno);

	} else if(rplyCl == '6'){ <%--이미지--%>

		qstItm = "<div id='itmList_"+qstItmIdx+"' style='margin-top:5px;'>";
		qstItm += '<div id="atchFileDiv_' + srvySctnSerno + '_' + srvyQstSerno + '_' + qstItmIdx + '" class="field" style="display: inline-block;"></div>';
		qstItm += "<button type='button' style='position: relative; top:-21px;' class='btn sml delete_itm_element' data-qstitmidx=" + qstItmIdx + " data-rplycl=" + rplyCl + " data-srvysctnserno=" + srvySctnSerno + " data-srvyqstserno=" + srvyQstSerno + "><span>삭제</span></button>";
		qstItm += "<input type='hidden' name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList[" + qstItmIdx + "].srvyQstItmCtt' id='qstFile_" + srvySctnSerno + "_" + srvyQstSerno + "_"+ qstItmIdx+"'><br/>";
		qstItm += "</div>";

		$("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).append(qstItm);
		$('#atchFileDiv_' + srvySctnSerno + '_' + srvyQstSerno + '_' + qstItmIdx).html(setFileList($("#qstFile_" +srvySctnSerno + "_" + srvyQstSerno + "_"+ qstItmIdx).val(), "qstFile_" + srvySctnSerno + "_" + srvyQstSerno + "_"+ qstItmIdx, "image","1"));

		fncChangeRplyOpt(srvySctnSerno,srvyQstSerno);
		
	} else if(rplyCl == "8"){ <%--날짜시간--%>
		
		qstItm = "<div id='itmList_"+qstItmIdx+"' style='margin-top:5px;'>";
		qstItm += "	<span class='calendar_input'><input type='text' name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList[" + qstItmIdx + "].srvyItmTpVal1' id='qstDate_" + srvySctnSerno + "_" + srvyQstSerno + "_"+qstItmIdx+"' class='w200' title='옵션' readonly='readonly'required='required'></span> &nbsp; / &nbsp;";
		qstItm += "	<input type='time' name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList[" + qstItmIdx + "].srvyItmTpVal2' id='qstTime_" + srvySctnSerno + "_" + srvyQstSerno + "_"+qstItmIdx+"' style='width:130px;' maxlength = '30' required='required'>";
		qstItm += "<button type='button' style='margin-left:8px;' class='btn sml delete_itm_element' data-qstitmidx=" + qstItmIdx + " data-rplycl=" + rplyCl + " data-srvysctnserno=" + srvySctnSerno + " data-srvyqstserno=" + srvyQstSerno + "><span>삭제</span></button>";
		qstItm += "</div>";

		$("#srvy_qst_itm_add_" + srvySctnSerno + "_"+ srvyQstSerno).append(qstItm);
		fncDate("qstDate_" + srvySctnSerno + "_" + srvyQstSerno + "_"+qstItmIdx);
		fncChangeRplyOpt(srvySctnSerno,srvyQstSerno);
		
	} else if(rplyCl == '9'){ <%--동영상--%>

		qstItm = "<div id='itmList_"+qstItmIdx+"' style='margin-top:5px;'>";
		qstItm += "	<input type='text' name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList[" + qstItmIdx + "].srvyQstItmCtt' maxlength ='200' style='width:500px;' title='옵션' placeHolder='URL을 입력 해 주세요' id='option_" + srvySctnSerno + "_" + srvyQstSerno + "_" +  +qstItmIdx + "' required='required'>";
		qstItm += "	<button type='button' style='margin-left:5px;' class='btn sml delete_itm_element' data-qstitmidx=" + qstItmIdx + " data-rplycl=" + rplyCl + " data-srvysctnserno=" + srvySctnSerno + " data-srvyqstserno=" + srvyQstSerno + "><span>삭제</span></button>";
		qstItm += "</div>"
		$("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).append(qstItm);
		fncChangeRplyOpt(srvySctnSerno,srvyQstSerno);
		
	} else{
		return false;
	}

}

<%--기타 추가시--%>
const fncAddQstItmEtc = function(srvySctnSerno,srvyQstSerno){
	
	var rplyCl = $("#srvyAnsCgVal_" + srvySctnSerno + "_" + srvyQstSerno).val();
	
	if( $("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find('.etc').length > 0 ) {
		alert("이미 추가되어있습니다. ");
		return false;
	}
	
	if($("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).find("input[type=text]").length > 9) {
		alert("항목은 최대 10개까지 추가 가능합니다. ");
		return false;
	}

	var qstItmIdx = 1;
	var	qstItm = "";

	var itmNum = Number(srvyQstSerno);
	if(itmMap.get(itmNum) != null){
		qstItmIdx = itmMap.get(itmNum) + 1;
		itmMap.set(itmNum, qstItmIdx);
	}else{
		itmMap.set(itmNum, qstItmIdx);
	}

	qstItm = "<div id='itmList_"+qstItmIdx+"' style='margin-top: 5px;'>";
	qstItm += "	<input type='text' name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno + "].qstItmList[" + qstItmIdx + "].srvyQstItmCtt' class='etc' value='기타' readonly='readonly' style='width: 300px;'>";
	qstItm += "	<select name='sctnList[" + srvySctnSerno + "].qstList[" + srvyQstSerno+ "].qstItmList[" + qstItmIdx + "].srvyNextSctnNo' class='nextSeNo_" + srvySctnSerno+ "_" + srvyQstSerno + " ans_next_sec' style='display:none;'>";
	qstItm += "		<option value=''>다음 섹션으로 이동</option>";
	qstItm += "	</select>";
	qstItm += "	<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx=" + qstItmIdx + " data-rplycl=" + rplyCl + " style='margin-left: 5px;'><span>삭제</span></button>";
	qstItm += "</div>";

	$("#srvy_qst_itm_add_" + srvySctnSerno + "_" + srvyQstSerno).append(qstItm);
	changeNextSctnNo(srvySctnSerno,srvyQstSerno);
	fncChangeRplyOpt(srvySctnSerno,srvyQstSerno);
}

<%-- (객관식) 답변을 기준으로 섹션이동 중복 방지 --%>
const checkNextSctnYn = function(obj,srvySctnSerno,srvyQstSerno){

	var ckVal = "";
	var ckId = "";
	var length = $("#srvy_section_" + srvySctnSerno).find("input[id^='nextSecChk_" + srvySctnSerno + "']").length;
	for(var i =0; i < length; i++){
		ckId = $(obj).attr("id").replace("nextSecChk_" + srvySctnSerno + "_","");
		ckVal = $(obj).is(":checked");
		
		if(ckVal && srvyQstSerno != ckId) {
			$("#nextSecChk_" + srvySctnSerno + "_" + srvyQstSerno).prop("checked", false);
			$(obj).focus();
			alert("질문 섹션에 중복된 객관식 이동이 존재합니다.");
			return false;
		}
	}
	changeNextSctnNo(srvySctnSerno,srvyQstSerno);
}

<%-- 객관식 문항별 진행 섹션 설정 --%>
const setAnsNextSecNo = function(srvySctnSerno, srvyQstSerno){
	
	var nextSecOpt = "";
	
	$(".next_sec").each(function(i){ <%--진행 섹션--%>
		
		var selectValue = $(this).val();
		nextSecOpt = "<option value='' selected='selected'>다음 섹션으로 이동</option>";
		
		if($(".srvy_sec_no").length > 1){  <%--섹션이 한개 이상일 때--%>
			$(".srvy_sec_no").each(function(idx){
				if(idx != srvySctnSerno && idx != parseInt(srvySctnSerno)+1 ) {
					nextSecOpt += "<option value='";
					nextSecOpt += idx+ "'>";
					nextSecOpt += (idx + 1) + " 섹션으로 이동</option>";
				}
			});
		}
		
	});
	
	$(".nextSeNo_" + srvySctnSerno + "_" + srvyQstSerno).html(nextSecOpt);
}


const setSecTot = function(delSerno){
	var lastIdx = 0;
	var check = true;
	$(".secNo").each(function(idx){
		if(parseInt(delSerno) < parseInt($(this).data("srvysctnserno")) && check === true){
			check = false;
			$(this).parent().parent().parent().remove();
			lastIdx -= 1;
		}		
		if(check === false){
			$(this).html(idx);						
		}else{
			$(this).html(idx+1);
		}
		lastIdx += 1;			
	});
	$(".secTot").html(lastIdx);
}

	
$(document).ready(function(){
	
	
    fncDate('srvyStrtDt','srvyEndDt');
    
    setSecTot(); <%--섹션 갯수 설정--%>
    
    <%--항목 갯수 설정 --%>
	<c:if test="${searchVO.procType eq 'insert'}">
	    qstMap.set(0, 0)
	</c:if>
   	
    <%-- 설문 등록 --%>
   	$("#btn_srvy_submit").on("click", function () {
   		
   		<%--유효성 검사--%>
   		if(wrestSubmit(document.defaultFrm)){
   			
   			<%--파일 검사--%>
	   		var valid = true;
			if($(".totalFileCnt").length>0){
				$(".totalFileCnt").each(function(){
					if($(this).val()=="0"){
						alert("이미지를 첨부해 주세요.");
						valid = false;
						return false;
					}
				});
			}
			if(valid){
				<%--파일 먼저 등록후 insert--%>
				fileFormSubmit("defaultFrm", '<c:out value="${searchVO.procType}"/>', function () {
					fncProc('<c:out value="${searchVO.procType}"/>');
				});	
			}
   		}
   		
	});
    
   	<%--설문 삭제--%>
    $("#btn_srvy_delete").on("click", function () {
    	fncProc("delete");
    });
    
   	
   	<%-- 항목 유형 변경시 --%>
   	$(document).on("change","[id^=srvyAnsCgVal_]", function (e) {
   		e.stopImmediatePropagation()
	   	fncSelRplyCl($(this).data("srvysctnserno"),$(this).data("srvyqstserno"), $(this).val(),'');   		
	});
	
	<%-- 섹션 추가 클릭시 --%>
	$("#add_section_btn").on("click", function () {
		fncAddSctn();
	});
	
	$(document).on("click","[id^=srvyNcsrYn_]",function(e) {
		e.stopImmediatePropagation()
		ncsrNextSecChk($(this),$(this).data("srvysctnserno"),$(this).data("srvyqstserno"));
	});

	$(document).on("click","[id^=btn_addQst_]",function(e) {
		e.stopImmediatePropagation()
		fncAddQst($(this).data("srvysctnserno"));
	});
	
	$(document).on("click",".btn_del_section",function(e) {
		e.stopImmediatePropagation()
		fncDelSec($(this).data("srvysctnserno"));
	});
	
	$(document).on("click",".btn_del_qst",function(e) {
		e.stopImmediatePropagation()
		fncDelQst($(this).data("srvysctnserno"),$(this).data("srvyqstserno"));
	});
	
	
	
	
	
	
	<%--단문형 텍스트 크기조절 --%>
	$(document).on("click","[id^=inputSize_]",function(e) {
		e.stopImmediatePropagation();
		$("#itmType_" + $(this).parent().parent().data("srvysctnserno") + "_" + $(this).parent().parent().data("srvyqstserno")).removeClass();
		var width = "";
		if($(this).val() == '30'){
			width = '150';
		}else if($(this).val() == '50'){
			width = '300';
		}else if($(this).val() == '80'){
			width = '450';
		}
		$("#itmType_" + $(this).parent().parent().data("srvysctnserno") + "_" + $(this).parent().parent().data("srvyqstserno")).css("width",width+"px");
			
		$("#itmType_" + $(this).parent().parent().data("srvysctnserno") + "_" + $(this).parent().parent().data("srvyqstserno")).attr("placeholder",$(this).val()+"자")
	});

	<%-- 문항추가 클릭시 --%>
	$(document).on("click","#add_qst_itm",function(e) {
		e.stopImmediatePropagation(); 
		fncAddQstItm($(this).parent().data("srvysctnserno"),$(this).parent().data("srvyqstserno"));
	});

	<%-- 기타 추가 클릭시 --%>
	$(document).on("click","#add_qst_itm_etc",function(e) {
		e.stopImmediatePropagation();
		fncAddQstItmEtc($(this).parent().data("srvysctnserno"),$(this).parent().data("srvyqstserno"));
	});

	<%-- 답변을 기준으로 다음 섹션 이동 클릭시  --%>
	$(document).on("click","[id^=nextSecChk_]",function(e) {
		e.stopImmediatePropagation();
		checkNextSctnYn($(this),$(this).data("srvysctnserno"),$(this).data("srvyqstserno"));
	});

	<%-- 항목 요소 삭제 클릭시 --%>
	$(document).on("click",".delete_itm_element",function(e) {
		e.stopImmediatePropagation()
		$("#itmList_" + $(this).data("qstitmidx")).remove();
		if($("[id^=itmList_]").length == 0){
			fncAddQstItm($(this).data("srvysctnserno"),$(this).data("srvyqstserno"));
		}
		if($(this).data("rplycl") !== "1" && $(this).data("rplycl") !== "2" && $(this).data("rplycl") !== "5" && $(this).data("rplycl") !== "7"){
			fncChangeRplyOpt($(this).data("srvysctnserno"),$(this).data("srvyqstserno"));		
		};
	});
   	
});
</script>
<section>
	<form:form modelAttribute="cmSrvyVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false">
		<form:hidden path="srvySerno"/>
		<form:hidden path="procType"/>
		<div class="board_top">
		    <div class="board_right">
		        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
		    </div>
		</div>
		<table class="board_write">
			<caption>내용(설문제목,설문기간,게시여부,설문설명 등으로 구성)</caption>
			<colgroup>
				<col class="w20p">
				<col>
				<col class="w20p">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="asterisk">*</span> 설문제목</th>
					<td colspan="3">
						<form:input path="srvyNm" title="설문명" cssClass="w100p"  maxlength="100" required="true"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="asterisk">*</span> 설문기간</th>
					<td>
						 <span class="calendar_input"><form:input path="srvyStrtDt" title="설문시작일자" required="true"/></span>
						<span class="gap">~</span>
						<span class="calendar_input"><form:input path="srvyEndDt" title="설문종료일자" required="true"/></span>
					</td>
					<th scope="row"><span class="asterisk">*</span> 게시여부</th>
					<td>
						<span class="chk">
							 <span class="radio"><form:radiobutton path="srvySts" id="srvyStsN" value="N" checked="true"/><label for="srvyStsN">미게시</label></span>
							 <span class="radio"><form:radiobutton path="srvySts" id="srvyStsY" value="Y"/><label for="srvyStsY">게시</label></span>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="asterisk">*</span> 설문설명</th>
					<td colspan="3">
						<form:textarea path="srvyExpl" cssClass="w100p"  maxlength="500" required="true" title="설문 안내 및 목적" rows="10"/>
					</td>
				</tr>
			</tbody>
		</table>
		<c:choose>
			<c:when test="${searchVO.procType eq 'insert'}">
				<div class="srvy_add_wrap mar_t30">
				    <div class="sidebyside">
				        <div class="left">
				            <h4 class="md_tit"><span class="secTot"></span> 중 <span class="secNo"></span> 섹션</h4>
				        </div>
				        <div class="right">
				            <div class="btn_area">
				                <button type="button" class="btn sml" id="add_section_btn">섹션추가</button>
				                <button type="button" class="btn sml blue" id="btn_addQst_0_0" data-srvysctnserno="0">항목 추가</button>
				            </div>
				        </div>
				    </div>
				    <div class="srvy_section srvy_section_0" id="srvy_section_0" data-srvysctnserno="0">
				        <table class="board_write">
				            <caption>내용(섹션제목,섹션내용,진행섹션 등으로 구성)</caption>
				            <colgroup>
				                <col class="w20p">
				                <col>
				                <col class="w90">
				            </colgroup>
				            <tbody>
				               <tr>
									<th scope="row"><span class="asterisk">*</span> 섹션제목</th>
									<td>
										<input type="text" name="sctnList[0].srvySctnTitl" id="srvySctnTitl_0" class="w100p" maxlength="100" title="섹션제목" required="required"> 
										<input type="hidden" name="sctnList[0].srvySctnSerno" class="srvy_sec_no" value="0">
									</td>
									<td rowspan="3" class="c">
				                        <button type="button" class="btn sml red btn_del_section"  data-srvysctnserno="0">삭제</button>
				                    </td>
								</tr>
								<tr>
									<th scope="row">섹션내용</th>
									<td>
										<textarea name="sctnList[0].srvySctnCtt" id="srvySctnCtt_0" title="섹션내용" maxlength="250"></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row">진행 섹션</th>
									<td>
										<select name="sctnList[0].srvyNextSctnNo" class="next_sec auto">
											<option value="">다음 섹션으로 이동</option>
										</select>
									</td>
							    </tr>
				            </tbody>
				        </table>
				        
				         <div class="srvy_entry srvy_qst_itm_0" id="qst_0_0">
				            <table class="board_write">
				                <caption>내용(항목제목,필수여부,항목설명,유형,옵션 등으로 구성)</caption>
				                <colgroup>
				        			<col class="w20p">
					                <col>
					                <col class="w90">
				                </colgroup>
				                <tbody>
				                    <tr>
				                        <th scope="row"><span class="asterisk">*</span> 항목제목</th>
				                        <td>
				                        	<input type="text" name="sctnList[0].qstList[0].srvyQstTitl"  id="srvyQstTitl_0_0" class="w100p"  maxlength ="100" title="항목제목" required="required">
				                        </td>
				                        <td rowspan="5" class="c">
				                            <button type="button" class="btn sml red btn_del_qst"  data-srvysctnserno="0" data-srvyqstserno="0">삭제</button>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th scope="row">필수여부</th>
				                        <td>
				                            <span class="chk">
				                                <span class="cbx"><input type="checkbox" name="sctnList[0].qstList[0].srvyNcsrYn" value="Y" id="srvyNcsrYn_0_0" data-srvysctnserno="0" data-srvyqstserno="0" checked="checked"><label for="srvyNcsrYn_0_0">필수항목</label></span>
				                            </span>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th scope="row">항목설명</th>
				                        <td>
				                        	<input type="text" name="sctnList[0].qstList[0].srvyQstCtt"  maxlength="250" placeholder="항목에 대한 자세한 설명을 입력해주세요." class="w100p">
				                        </td>
				                    </tr>
				                    <tr>
				                        <th scope="row"><span class="asterisk">*</span> 유형</th>
				                        <td>
				                        <select name="sctnList[0].qstList[0].srvyAnsCgVal" id="srvyAnsCgVal_0_0" class="auto" data-srvysctnserno="0"  data-srvyqstserno="0" title="유형" required="required">
				                                <option value="">선택</option>
				                                <option value="1">단답형</option>
				                                <option value="2">장문형</option>
				                                <option value="3">객관식</option>
				                                <option value="4">체크박스</option>
				                                <option value="5">파일</option>
				                                <option value="6">이미지</option>
				                                <option value="7">선호도 점수</option>
				                                <option value="8">날짜/시간</option>
				                                <option value="9">동영상</option>
				                            </select>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th scope="row">옵션</th>
				                        <td><div id="srvy_qst_itm_0_0"></div></td>
				                    </tr>
				                </tbody>
				            </table>
				        </div>
				    </div>
				</div>
			</c:when>
			<c:otherwise>
				<%-- update --%>
				<div class="srvy_add_wrap mar_t30">
					<div class="sidebyside">
						 <div class="left">
						     <h4 class="md_tit"><span class="secTot"></span> 중 <span class="secNo"></span> 섹션</h4>
						 </div>
						 <div class="right">
						    <div class="btn_area">
						       <button type="button" class="btn sml" id="add_section_btn">섹션추가</button>
						       <button type="button" class="btn sml blue" id="btn_addQst_0_0" data-srvysctnserno="0">항목 추가</button>
						    </div>
						</div>
					</div>
					<c:forEach items="${cmSrvyVO.sctnList }" var="sctn" varStatus="sctnStatus">
					    <c:if test="${sctnStatus.index ne 0}">
							<div class="sidebyside mar_t60 srvy_section_<c:out value="${sctnStatus.index}"/>">
								<div class="left">
									<h4 class="md_tit"><span class="secTot"></span> 중 <span class="secNo" data-srvysctnserno="<c:out value="${sctnStatus.index}"/>"></span> 섹션</h4>
								</div>
									<c:if test="${!sctnStatus.first}">
								<div class="right">
						            	<button type="button" class="btn sml blue" id="btn_addQst_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/>" data-srvysctnserno="<c:out value="${sctnStatus.index}"/>">항목 추가</button>
						        </div>                   	
						            </c:if>
							</div>
						</c:if>
						<div class="srvy_section srvy_section_<c:out value="${sctnStatus.index}"/>" id="srvy_section_<c:out value="${sctnStatus.index}"/>" data-srvysctnserno="<c:out value="${sctnStatus.index}"/>">
							<table class="board_write">
								<caption>내용(섹션제목,섹션내용,진행섹션 등으로 구성)</caption>
								<colgroup>
									<col class="w20p">
									<col>
									<col class="w90">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span class="asterisk">*</span> 섹션제목</th>
										<td>
											<input type="text" name="sctnList[<c:out value="${sctnStatus.index}"/>].srvySctnTitl" class="w100p" title="섹션제목"  maxlength="100" value="<c:out value="${sctn.srvySctnTitl}"/>"> 
											<input type="hidden" name="sctnList[<c:out value="${sctnStatus.index}"/>].srvySctnNo" class="srvy_sec_no" value="<c:out value='${sctn.srvySctnNo }'/>"> 
										</td>
										<td rowspan="3" class="c"> 
											<button type="button" class="btn sml red btn_del_section"  data-srvysctnserno="<c:out value="${sctnStatus.index}"/>">삭제</button>
							            </td>
									</tr>
									<tr>
										<th scope="row">섹션내용</th>
										<td>
											<textarea name="sctnList[<c:out value="${sctnStatus.index}"/>].srvySctnCtt" class="text w100p" maxlength="250" title="섹션내용"><c:out value="${sctn.srvySctnCtt}"/></textarea>
										</td>
									</tr>
									<tr>
										<th scope="row">진행 섹션</th>
										<td>
											<select name="sctnList[<c:out value="${sctnStatus.index}"/>].srvyNextSctnNo" class="next_sec"  <c:out value="${not empty sctn.srvyNextSctnNo and sctn.srvyNextSctnYn eq 'Y' ? 'disabled=disabled' : ''}"/>>
												<option value="">다음 섹션으로 이동</option>
												<c:forEach items="${cmSrvyVO.sctnList }" var="nextSctn" varStatus="nextsctnStatus">
													<c:if test="${sctnStatus.count != nextsctnStatus.count and (sctnStatus.count+1) != nextsctnStatus.count }">
														<option value="<c:out value='${nextsctnStatus.index }'/>" <c:out value="${nextsctnStatus.count  eq sctn.srvyNextSctnNo ? 'selected=selected' : 'aa'}"/>>
															<c:out value="${nextsctnStatus.count }"/>섹션으로 이동
														</option>
													</c:if>
												</c:forEach>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							<c:forEach items="${sctn.qstList}" var="qst" varStatus="qstStatus">
								<div class="srvy_entry srvy_qst_itm_<c:out value="${sctnStatus.index}"/>" id="qst_<c:out value="${sctnStatus.index}"/>_<c:out value='${qstStatus.index }'/>"> 
									<table class="board_write">
										<caption>내용(항목제목,필수여부,항목설명,유형,옵션 등으로 구성)</caption>
										<colgroup>
											<col class="w20p">
				                			<col>
				                			<col class="w90">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span class="asterisk">*</span> 항목제목</th>
												<td>
													<input type="text" name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].srvyQstTitl" maxlength="100" class="w100p" title="항목제목"  value="<c:out value='${qst.srvyQstTitl }'/>">
												</td>
												<td rowspan="5" class="c">
						                           	<button type="button" class="btn sml red btn_del_qst"  data-srvysctnserno="<c:out value="${sctnStatus.index}"/>" data-srvyqstserno="<c:out value="${qstStatus.index }"/>">삭제</button>
						                        </td>	
											</tr>
											<tr>
												 <th scope="row">필수여부</th>
												<td>
													<input type="checkbox" class="checkbox" name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].srvyNcsrYn" value="Y" <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'checked=checked' : ''}"/>> 필수항목	
												</td>
											</tr>
											<tr>
												<th scope="row">항목설명</th>
												<td>
													<input type="text" name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].srvyQstCtt" placeholder="항목에 대한 자세한 설명을 입력해주세요." maxlength="250" class="text w100p" value="<c:out value='${qst.srvyQstCtt }'/>">
												</td>
											</tr>
											<tr>
												<th scope="row"><span class="asterisk">*</span> 유형</th>
												<td>
													<select name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].srvyAnsCgVal" title="유형" id="srvyAnsCgVal_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/>"  data-srvysctnserno="<c:out value="${sctnStatus.index}"/>" data-srvyqstserno="<c:out value="${qstStatus.index }"/>">
														<option value="">선택</option>
														<option value="1" <c:out value="${qst.srvyAnsCgVal eq '1' ? 'selected=selected' : '' }"/>>단답형</option>
														<option value="2" <c:out value="${qst.srvyAnsCgVal eq '2' ? 'selected=selected' : '' }"/>>장문형</option>
														<option value="3" <c:out value="${qst.srvyAnsCgVal eq '3' ? 'selected=selected' : '' }"/>>객관식</option>
														<option value="4" <c:out value="${qst.srvyAnsCgVal eq '4' ? 'selected=selected' : '' }"/>>체크박스</option>
														<option value="5" <c:out value="${qst.srvyAnsCgVal eq '5' ? 'selected=selected' : '' }"/>>파일</option>
														<option value="6" <c:out value="${qst.srvyAnsCgVal eq '6' ? 'selected=selected' : '' }"/>>이미지</option>
														<option value="7" <c:out value="${qst.srvyAnsCgVal eq '7' ? 'selected=selected' : '' }"/>>선호도 점수</option>
														<option value="8" <c:out value="${qst.srvyAnsCgVal eq '8' ? 'selected=selected' : '' }"/>>날짜/시간</option>
														<option value="9" <c:out value="${qst.srvyAnsCgVal eq '9' ? 'selected=selected' : '' }"/>>동영상</option>
													</select>
												</td>
											</tr>
											<tr>
												<th scope="row">옵션</th>
												<td>
													<div id="srvy_qst_itm_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/>">
														<c:choose>
															<c:when test="${qst.srvyAnsCgVal eq '1' }">
																<%-- 단답형 --%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index }"/>_<c:out value='${qstStatus.index}'/>"> 
																	<c:forEach items="${qst.qstItmList }" var="itm" varStatus="itmStatus">
																		<span class="chk" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>">
																			<span class="radio">
																				<input type="radio" name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index}"/>].qstItmList[<c:out value="${itmStatus.index}"/>].srvyItmTpVal1" value="30" <c:out value="${itm.srvyItmTpVal1 eq '30' ? 'checked=checked' : '' }"/> id="inputSize_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_30">
																				<label for="inputSize_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_30"> 작게</label>
																			</span>&nbsp;
																			<span class="radio">
																				<input type="radio" name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index}"/>].qstItmList[<c:out value="${itmStatus.index}"/>].srvyItmTpVal1" value="50" <c:out value="${itm.srvyItmTpVal1 eq '50' ? 'checked=checked' : ''}"/> id="inputSize_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_50">
																				<label for="inputSize_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_50"> 보통</label> 
																			</span>&nbsp;
																			<span class="radio">
																				<input type="radio" name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyItmTpVal1" value="80" <c:out value="${itm.srvyItmTpVal1 eq '80' ? 'checked=checked' : ''}"/> id="inputSize_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_80">
																				<label for="inputSize_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_80"> 크게</label> 
																			</span>
																		</span>
																		<br/>
																		<input type="text" id="itmType_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>" class="w<c:out value="${itm.srvyItmTpVal1 eq '50' ? '300' : itm.srvyItmTpVal1 eq '80' ? '450' : '150' }"/> mar_t5" readonly="readonly" placeholder="<c:out value="${itm.srvyItmTpVal1}"/>자">
																		  
																	</c:forEach>
																</div>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '2' }">
																<%--장문형 --%>
																<textarea class="text w100p" readonly="readonly"></textarea>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '3' }">
																<%-- 객관식 --%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index}"/>_<c:out value='${qstStatus.index}'/>">  
																	<div class="mar_b5" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>">
																		<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
																		<span>또는 </span>
																		<button type="button" class="btn sml" id="add_qst_itm_etc">기타 추가</button>
																	</div>
																	<div class="nextSecChk_<c:out value="${sctnStatus.index }"/>_<c:out value='${qstStatus.index}'/>"> 
																		<input type="checkbox" name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index}"/>].srvyNextSctnYn" value="Y" id="nextSecChk_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>"  <c:out value="${not empty qst.srvyNextSctnYn and qst.srvyNextSctnYn eq 'Y' ? 'checked=checked' : '' }"/> data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" >
																		<label for="nextSecChk_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>">답변을 기준으로 섹션이동</label><br/>
																	</div>
																	<c:forEach items="${qst.qstItmList }" var="itm" varStatus="itmStatus">
																		<div id="itmList_<c:out value="${itmStatus.index}"/>">
																			<input type='text' name='sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyQstItmCtt' class="w300 mar_t5 <c:out value="${itm.srvyQstItmCtt eq '기타' ? 'etc' : '' }"/>" title='옵션' value="<c:out value='${itm.srvyQstItmCtt}'/>" maxlength = '30' <c:if test="${itm.srvyQstItmCtt eq '기타'}">readonly='readonly'</c:if> required="required" id="option_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_<c:out value="${itmStatus.index }"/>"/>
																			<select name='sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyNextSctnNo' class='nextSeNo_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index }"/> ans_next_sec mar_t5' style="<c:out value="${not empty qst.srvyNextSctnYn and qst.srvyNextSctnYn eq 'Y' ? 'display:inline-block' : 'display:none' }"/>">
																				<option value="">다음 섹션으로 이동</option>
																				<c:forEach items="${cmSrvyVO.sctnList}" var="nextSctn" varStatus="nextSctnStatus">
																					<c:if test="${sctnStatus.count != nextSctnStatus.count and (sctnStatus.count+1) != nextSctnStatus.count }">
																						<option value="<c:out value="${nextsctnStatus.index}"/>" <c:out value="${not empty itm.srvyNextSctnNo and itm.srvyNextSctnNo eq nextSctnStatus.index ? 'selected=selected' : ''}"/>>
																							<c:out value="${nextSctnStatus.count }"/> 섹션으로 이동
																						</option>
																					</c:if>
																				</c:forEach>
																			</select>
																			<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="<c:out value="${itmStatus.index}"/>" data-rplycl="3" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" ><span>삭제</span></button>
																			<br/>
																			<c:if test="${itmStatus.last }">
																				<script type="text/javascript">
																					var itmNum = Number('<c:out value="${qstStatus.index}"/>')
																					itmMap.set(itmNum, '<c:out value="${itmStatus.index}"/>');
																				</script>
																			</c:if>
																		</div>
																	</c:forEach>
																</div>
																<script type="text/javascript">
																	fncChangeRplyOpt('<c:out value="${sctnStatus.index}"/>','<c:out value="${qstStatus.index}"/>');
																</script>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '4'}">
																<%-- 체크박스 --%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index }"/>_<c:out value='${qstStatus.index}'/>"> 
																	<div class="mar_b5" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>">  
																		<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
																		<span>또는 </span>
																		<button type="button" class="btn sml" id="add_qst_itm_etc">기타 추가</button>
																	</div>
																	선택 가능 갯수
																	<select name="sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].srvyChcCnt" id="nextRply_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index}"/>"  class="mar_l16" > 
																		<c:forEach var="i" begin="1" end="${qst.srvyChcCnt }"> 
																			<option value="<c:out value="${i }"/>" <c:out value="${qst.srvyChcCnt eq i ? 'selected=selected' : '' }"/>><c:out value="${i}"/></option>
																		</c:forEach>
																	</select>
																	<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>" >
																		<c:forEach items="${qst.qstItmList }" var="itm" varStatus="itmStatus">
																			<div id="itmList_<c:out value="${itmStatus.index }"/>">
																				<input type="text" name="sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyQstItmCtt" class="mar_t5 <c:out value="${itm.srvyQstItmCtt eq '기타' ? 'etc' : '' }"/>" title="옵션" value="<c:out value='${itm.srvyQstItmCtt}'/>" maxlength = '30' <c:if test="${itm.srvyQstItmCtt eq '기타'}">readonly='readonly'</c:if> required="required" id="option_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_<c:out value="${itmStatus.index }"/>"> 
																				<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="<c:out value="${itmStatus.index}"/>" data-rplycl="4" data-srvysctnserno="<c:out value="${sctnStatus.index}"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" ><span>삭제</span></button>
																				<br/>
																				<c:if test="${itemStatus.last }">
																					<script type="text/javascript">
																						var itmNum = Number('<c:out value="${qstStatus.index}"/>')
																						itmMap.set(itmNum, '<c:out value="${itmStatus.index}"/>');
																					</script>
																				</c:if>
																			</div>
																		</c:forEach>
																	</div>
																</div>
																<script type="text/javascript">
																	fncChangeRplyOpt('<c:out value="${sctnStatus.index}"/>','<c:out value="${qstStatus.index}"/>');
																</script>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '5' }">
																<%-- 파일 --%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>" >파일첨부
																</div>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '6' }">
																<%-- 이미지 --%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>">  
																	<div class="mar_b5" data-srvysctnserno="<c:out value="${sctnStatus.index}"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" >
																		<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
																	</div>
																	선택 가능 갯수
																	<select name="sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].srvyChcCnt" id="nextRply_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index}"/>" class="mar_l16">
																		<c:forEach var="i" begin="1" end="${qst.srvyChcCnt }">
																			<option value="<c:out value="${i }"/>" <c:out value="${qst.srvyChcCnt eq i ? 'selected=selected' : '' }"/>><c:out value="${i}"/></option>
																		</c:forEach>
																	</select>
																	<c:forEach items="${qst.qstItmList }" var="itm" varStatus="itmStatus">
																		<div id="itmList_<c:out value="${itmStatus.index }"/>" class="mar_t5">
																			<div id="atchFileDiv_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_<c:out value="${itmStatus.index}"/>" class="field" style="display: inline-block;" ></div>
																			<input type='hidden' name='sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyQstItmCtt' id="qstFile_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index }"/>_<c:out value="${itmStatus.index }"/>" value="<c:out value='${itm.srvyQstItmCtt}'/>">
																			<button type='button' class='btn sml delete_itm_element' data-qstitmidx="<c:out value="${itmStatus.index}"/>" data-rplycl="6" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" style="position: relative; top:-21px;" ><span>삭제</span></button>
																			<br/>
																			<script type="text/javascript">
																				$('#atchFileDiv_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index}"/>_<c:out value="${itmStatus.index}"/>').html(setFileList($('#qstFile_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index }"/>_<c:out value="${itmStatus.index }"/>').val(), 'qstFile_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_<c:out value="${itmStatus.index}"/>', "image","1"));
																			</script>
																			<c:if test="${itmStatus.last }">
																				<script type="text/javascript">
																					var itmNum = Number('<c:out value="${qstStatus.index}"/>')
																					itmMap.set(itmNum, '<c:out value="${itmStatus.index}"/>');
																				</script>
																			</c:if>
																		</div>
																	</c:forEach>
																</div>
																<script type="text/javascript">
																	fncChangeRplyOpt('<c:out value="${sctnStatus.index}"/>','<c:out value="${qstStatus.index}"/>');
																</script>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '7' }">
																<%--  선호도 점수 --%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>" >
																	<c:forEach items="${qst.qstItmList }" var="itm" varStatus="itmStatus">
																		<div class="mar_b5">점수범위 선택</div>
																		<input type='text' required='required' title='옵션' placeholder='예) 싫다' name='sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyItmTpVal1' id="srvyItmTpVal1_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index }"/>_<c:out value="${itmStatus.index }"/>" value="<c:out value='${itm.srvyItmTpVal1 }'/>" maxlength = '30'>
																		<select name='sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyItmTpVal2' id="srvyItmTpVal2_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index }"/>_<c:out value="${itmStatus.index }"/>">
																			<option value='0' <c:out value="${itm.srvyItmTpVal2 eq '0' ? 'selected=selected' : '' }"/>>0</option>
																			<option value='1' <c:out value="${itm.srvyItmTpVal2 eq '1' ? 'selected=selected' : '' }"/>>1</option>
																		</select> ~ 
																		<select name='sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[0].srvyItmTpVal3' id="srvyItmTpVal3_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/>_0" >
																			<option value='3' <c:out value="${itm.srvyItmTpVal3 eq '3' ? 'selected=selected' : '' }"/>>3</option>
																			<option value='4' <c:out value="${itm.srvyItmTpVal3 eq '4' ? 'selected=selected' : '' }"/>>4</option>
																			<option value='5' <c:out value="${itm.srvyItmTpVal3 eq '5' ? 'selected=selected' : '' }"/>>5</option>
																			<option value='6' <c:out value="${itm.srvyItmTpVal3 eq '6' ? 'selected=selected' : '' }"/>>6</option>
																			<option value='7' <c:out value="${itm.srvyItmTpVal3 eq '7' ? 'selected=selected' : '' }"/>>7</option>
																			<option value='8' <c:out value="${itm.srvyItmTpVal3 eq '8' ? 'selected=selected' : '' }"/>>8</option>
																			<option value='9' <c:out value="${itm.srvyItmTpVal3 eq '9' ? 'selected=selected' : '' }"/>>9</option>
																			<option value='10' <c:out value="${itm.srvyItmTpVal3 eq '10' ? 'selected=selected' : '' }"/>>10</option>
																		</select>
																		<input type='text' title='옵션' placeholder='예) 좋다' name='sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index}"/>].qstItmList[<c:out value="${itmStatus.index}"/>].srvyItmTpVal4' id="srvyItmTpVal4_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/>_<c:out value="${itmStatus.index }"/>" value="<c:out value='${itm.srvyItmTpVal4 }'/>"  maxlength = '30' required="required">
																	</c:forEach>
																</div>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '8' }">
																<%-- 날짜 / 시간--%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index}"/>" >
																	<div class="mar_b5" data-srvysctnserno="<c:out value="${sctnStatus.index}"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" >
																		<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
																	</div>
																	선택 가능 갯수
																	<select name="sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index}"/>].srvyChcCnt" id="nextRply_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index}"/>" class="mar_l16" >  
																		<c:forEach var="i" begin="1" end="${qst.srvyChcCnt}">
																			<option value="<c:out value="${i}"/>" <c:out value="${qst.srvyChcCnt eq i ? 'selected=selected' : '' }"/>><c:out value="${i}"/></option>
																		</c:forEach>
																	</select>
																	<c:forEach items="${qst.qstItmList }" var="itm" varStatus="itmStatus">
																		<div id='itmList_<c:out value="${itmStatus.index }"/>' style="margin-top: 5px;" >
																			<span class="calendar_input"><input type='text' name='sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyItmTpVal1' id="qstDate_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/>_<c:out value="${itmStatus.index }"/>" title='옵션' value="<c:out value='${itm.srvyItmTpVal1 }'/>" required="required"></span> &nbsp; / &nbsp;
																			<input type='time' name='sctnList[<c:out value="${sctnStatus.index}"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyItmTpVal2' id='qstTime_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/><c:out value="${itmStatus.index }"/>0' class="w130" value="<c:out value='${itm.srvyItmTpVal2 }'/>">
																			<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="<c:out value="${itmStatus.index}"/>" data-rplycl="8" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" ><span>삭제</span></button>
																			<br/>
																			<script type="text/javascript">
																				fncDate('qstDate_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index }"/>_<c:out value="${itmStatus.index }"/>');
																			</script>
																			<c:if test="${itmStatus.last }">
																				<script type="text/javascript">
																					var itmNum = Number('<c:out value="${qstStatus.index}"/>')
																					itmMap.set(itmNum, '<c:out value="${itmStatus.index}"/>');
																				</script>
																			</c:if>
																		</div>
																	</c:forEach>
																</div>
																<script type="text/javascript">
																	fncChangeRplyOpt('<c:out value="${sctnStatus.index}"/>','<c:out value="${qstStatus.index}"/>');
																</script>
															</c:when>
															<c:when test="${qst.srvyAnsCgVal eq '9' }">
																<%-- 동영상 --%>
																<div id="srvy_qst_itm_add_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>" >
																	<div class="mar_b5" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>">
																		<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
																	</div>
																	선택 가능 갯수
																	<select name="sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].srvyChcCnt" id="nextRply_<c:out value="${sctnStatus.index}"/>_<c:out value="${qstStatus.index}"/>" class="mar_l16" >
																		<c:forEach var="i" begin="1" end="${qst.srvyChcCnt}">
																			<option value="<c:out value="${i}"/>" <c:out value="${qst.srvyChcCnt eq i ? 'selected=selected' : '' }"/>><c:out value="${i }"/></option>
																		</c:forEach>
																	</select>
																	<c:forEach items="${qst.qstItmList }" var="itm" varStatus="itmStatus">
																		<div id='itmList_<c:out value="${itmStatus.index }"/>' >
																			<input type='text' name='sctnList[<c:out value="${sctnStatus.index }"/>].qstList[<c:out value="${qstStatus.index }"/>].qstItmList[<c:out value="${itmStatus.index }"/>].srvyQstItmCtt' placeHolder='URL을 입력 해 주세요' value="<c:out value='${itm.srvyQstItmCtt}'/>" class="w500 mar_t5" title='옵션' maxlength = '200' id="option_<c:out value="${sctnStatus.index }"/>_<c:out value="${qstStatus.index}"/>_<c:out value="${itmStatus.index }"/>" required="required">
																			<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="<c:out value="${itmStatus.index}"/>" data-rplycl="9" data-srvysctnserno="<c:out value="${sctnStatus.index }"/>" data-srvyqstserno="<c:out value="${qstStatus.index}"/>" ><span>삭제</span></button>
																			<br/>
																			<c:if test="${itmStatus.last }">
																				<script type="text/javascript">
																					var itmNum = Number('<c:out value="${qstStatus.index}"/>')
																					itmMap.set(itmNum, '<c:out value="${itmStatus.index}"/>');
																				</script>
																			</c:if>
																		</div>
																	</c:forEach>
																</div>
																<script type="text/javascript">
																	fncChangeRplyOpt('<c:out value="${sctnStatus.index}"/>','<c:out value="${qstStatus.index}"/>');
																</script>
															</c:when>
														</c:choose>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<c:if test="${qstStatus.last }">
									<script type="text/javascript">
										var qstNum = Number('<c:out value="${sctnStatus.index}"/>')
										qstMap.set(qstNum, '<c:out value="${qstStatus.index}"/>')	
									</script>
								</c:if>
							</c:forEach>
						</div>
						<script type="text/javascript">
							sectionIdx += 1;
						</script>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="btn_area">
			<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }">
				<c:choose>
					<c:when test="${searchVO.procType eq 'insert'}">
					    <button type="button" class="btn blue" id="btn_srvy_submit">등록</button>
						<button type="button" class="btn" id="btn_list">취소</button>
					</c:when>
					<c:otherwise>
						<c:if test="${cmSrvyVO.srvyUpdateYn eq 'Y'}">
							<button type="button" class="btn blue" id="btn_srvy_submit">수정</button>
						</c:if>
						<button type="button" class="btn red" id="btn_srvy_delete">삭제</button>
						<button type="button" class="btn" id="btn_list">목록</button>
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
	</form:form>
</section>
