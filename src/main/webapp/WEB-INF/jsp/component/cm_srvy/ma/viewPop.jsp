<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath}'/>/component/cm_srvy/css/cm_srvy.css?var=2">
<script type="text/javascript">

const fncTextAreaLimit = function(obj, limit){
    var text = obj.val();
	
    if(text.length > limit){
        alert(limit + "자 까지만 작성 가능합니다.");
        text = text.substr(0, limit);
        obj.val(text);
        obj.focus();
    }
	
    $("#chk_" + obj.attr("id")).text(text.length);
}
	
<%-- 다음 페이지 이동 --%>
const fncGetNextSctnPage = function(hide, show, srvySctnSerno, srvyNextSctnNo) {
	var submitChk = true;
	
	$("[ID^=msg_]").remove();
	var focusCheck = 0;
	<%-- 선호도 조사 유효성 값 변경--%>
	for (var i = 0; i < document.srvyFrm.elements.length; i++) {
		var el = document.srvyFrm.elements[i];
		if($("#" + el.getAttribute("id")).attr('type') == 'radio' && $("#" + el.getAttribute("id")).data("srvyanscgval") == '7'){
        	if($("#" + el.getAttribute("id")).prop("checked")){
	        	var srvyqstserno = $("#" + el.getAttribute("id")).data("srvyqstserno");
	        	var no = $("#" + el.getAttribute("id")).data("no");
        		$("#rply_" + srvyqstserno + "_" + no).val($("#" + el.getAttribute("id")).val());
        	}
        }
	}
	<%-- 유효성 검사--%>
    for (var i = 0; i < document.srvyFrm.elements.length; i++) {
        var el = document.srvyFrm.elements[i];
        if (el.getAttribute("required") != null && $("#" + el.getAttribute("id")).val() == '' && $("#" + el.getAttribute("id")).attr("data-srvysctnserno") == srvySctnSerno) {
        	if($("#" + el.getAttribute("id")).attr("data-fileYn") == "Y"){
       	    	if($("#atchFileDiv_"+el.getAttribute("data-srvyqstserno")+"_"+el.getAttribute("data-fileNo")+" .totalFileCnt").val() < 1){
	       	    	if(focusCheck == 0){
	       	    	 	$("#" + el.getAttribute("id")).focus();
	       	    		focusCheck ++;
	       	    	}
	       	    	fncRedMsg("itmMsg_" + el.getAttribute("data-srvyqstserno"), "필수 답변 항목입니다.");
	                submitChk = false;
       	    	}
       	    }else{
       	    	if(focusCheck == 0){
	       	    	$("#" + el.getAttribute("id")).focus();
       	    		focusCheck ++;
       	    	}
                fncRedMsg("itmMsg_" + el.getAttribute("data-srvyqstserno"), "필수 답변 항목입니다.");
                submitChk = false;
       	    }
        }
    }
    if (submitChk) {
    	if(srvyNextSctnNo != ''){ 
    		show = parseInt(srvyNextSctnNo) + 1;
    	}
    	$("#prev").val(hide);
        $("#sctn_" + show).show();
        $("#sctn_" + hide).hide();
        return false;
    }
}
	
<%-- 이전 이동 --%>
const fncGetPrevSctnPage = function(hide,show){
	
	if($("#prev").val() == null || $("#prev").val() == "") {
	    show = $("#prev").val();
	}
    $("#sctn_"+show).show();
    $("#sctn_"+hide).hide();
    $("#prev").val('');
};

<%-- 설문조사 제출 --%>
const srvySubmit = function (url,srvySctnSerno) {
    if (url === "list.do") {
        location.href = "list.do";
        return false;
    }
    var submitChk = true;
	submitChk = valid(srvySctnSerno);
    if(submitChk) {
        alert('설문 테스트를 완료했습니다. 제출된 답변은 실제 데이터에 반영되지 않습니다.');
        window.close();
    }
    return false;
};

<%-- 제출전 유효성 검사 --%>
const valid  = function(srvySctnSerno){
	var submitChk = true;
	
	$("[ID^=msg_]").remove();
	var focusCheck = 0;
	<%-- 선호도 조사 유효성 값 변경--%>
	for (var i = 0; i < document.srvyFrm.elements.length; i++) {
		var el = document.srvyFrm.elements[i];
		if($("#" + el.getAttribute("id")).attr('type') == 'radio' && $("#" + el.getAttribute("id")).data("srvyanscgval") == '7'){
        	if($("#" + el.getAttribute("id")).prop("checked")){
	        	var srvyqstserno = $("#" + el.getAttribute("id")).data("srvyqstserno");
	        	var no = $("#" + el.getAttribute("id")).data("no");
        		$("#rply_" + srvyqstserno + "_" + no).val($("#" + el.getAttribute("id")).val());
        	}
        }
	}
	<%-- 유효성 검사 --%>
    for (var i = 0; i < document.srvyFrm.elements.length; i++) {
        var el = document.srvyFrm.elements[i];
        if (el.getAttribute("required") != null && $("#" + el.getAttribute("id")).val() == '' && $("#" + el.getAttribute("id")).attr("data-srvysctnserno") == srvySctnSerno) {
        	if($("#" + el.getAttribute("id")).attr("data-fileYn") == "Y"){
       	    	if($("#atchFileDiv_"+el.getAttribute("data-srvyqstserno")+"_"+el.getAttribute("data-fileNo")+" .totalFileCnt").val() < 1){
       	    		if(focusCheck == 0){
	       	    		$("#" + el.getAttribute("id")).focus();
	       	    		focusCheck ++;		
       	    		}
       	    	 	fncRedMsg("itmMsg_" + el.getAttribute("data-srvyqstserno"), "필수 답변 항목입니다.");
                  	submitChk = false;
       	    	}
       	    }else{
       	    	if(focusCheck == 0){
	       	    	$("#" + el.getAttribute("id")).focus();
       	    		focusCheck ++;		
   	    		}
                fncRedMsg("itmMsg_" + el.getAttribute("data-srvyqstserno"), "필수 답변 항목입니다.");
                submitChk = false;
       	    }
        }
    }
    
    return submitChk;
};
	
const fncRedMsg  = function(id, msg){
    var msgHtml = '<strong id="msg_'+id+'" ><font color="red">&nbsp;'+msg+'</font></strong>';
    $("#"+id).html(msgHtml);
};
	
<%-- 기타 선택시 변경 --%>
const fncTypeChkEtc = function(num, val, qst, ctt) {
    if (ctt == '기타') {
        $(".rply_" + qst + "_" + num + "_etc").show();
    } else {
        $(".rply_" + qst + "_" + num + "_etc").hide();
    }
    $("#rply_" + qst + "_" + num).val(val);
};
	
const fncTypeChkMulti = function(num, val, qst, limit) {
    var typeContText = "";
    if($("input:checkbox[name=check_" + qst + "]:checked").length>limit){
        alert('선택가능한 갯수는 '+limit+'개 이하입니다.');
        $("#check_" + val).prop("checked", false);
        return false;
    }
    
    $("input:checkbox[name=check_" + qst + "]:checked").change(function(){
    	if (this.getAttribute('data-srvyqstitmctt') == '기타' && !this.checked) {
    		 $(".rply_" + qst + "_" + num + "_etc").hide();
        }
    });
    
    $("input:checkbox[name=check_" + qst + "]:checked").each(function (idx) {
        if (this.getAttribute('data-srvyqstitmctt') == '기타') {
            $(".rply_" + qst + "_" + num + "_etc").show();
        } else {
            $(".rply_" + qst + "_" + num + "_etc").hide();
        }
        if (idx == 0) {
            typeContText = $(this).val();
        } else {
            typeContText += '$SPLIT$' + $(this).val();
        }
    });
    $("#rply_" + qst + "_" + num).val(typeContText);
};
$(document).ready(function(){
	
	<c:choose>
        <c:when test="${not empty procMsg}">
			alert("<c:out value='${procMsg}'/>");
			window.close();
		</c:when>
		<c:otherwise>
	        $.ajax({
	            method: "POST"
	            , url: "srvy.do"
	            , data: $("#defaultFrm").serialize()
	            , dataType: "HTML"
	            , success: function (data) {
	                $("#srvy").html(data);
	            }
	        });
		</c:otherwise>
	</c:choose>
    
	
	<%-- 이전 클릭시 --%>
	$(document).on("click",".btn_prev_page",function(e) {
		e.stopImmediatePropagation();
		fncGetPrevSctnPage($(this).data("hide"), $(this).data("show"));
	});
	
	<%-- 다음 클릭시 --%>
	$(document).on("click",".btn_next_page",function(e) {
		e.stopImmediatePropagation();
		fncGetNextSctnPage($(this).data("hide"), $(this).data("show"), $(this).data("srvysctnserno"), $(this).data("srvynextsctnno"));
	});
	
	<%-- 이전 클릭시 --%>
	$(document).on("click",".btn_srvy_submit",function(e) {
		e.stopImmediatePropagation();
		srvySubmit("ansProc",$(this).data("srvysctnserno"));
	});
});
</script>
<div class="srvy_popup ma_srvy">
	<div id="contents" class="survey survey-view pad_t35 pad_r35 pad_l35 pad_b35">
	    <form:form modelAttribute="cmSrvyVO" id="defaultFrm" name="defaultFrm" onsubmit="return false">
	        <form:hidden path="currentPageNo"/>
	        <form:hidden path="srvySerno"/>
	    </form:form>
	    <section class="survey-view-head">
            <h3 class="ttl wrap-break-word"><c:out value="${cmSrvyVO.srvyNm}"/></h3>
            <h4 class="lead wrap-break-word"><c:out value="${cmSrvyVO.srvyExpl }"/></h4>
            <div class="survey_name">
                <ul>
                    <li class="info date">
                        <span class="label red">참여기간</span>
                        <span><c:out value="${cmSrvyVO.srvyStrtDt} ~ ${cmSrvyVO.srvyEndDt}"/></span>
                    </li>
                </ul>
            </div>
        </section>
        <div id="srvy"></div>
   	</div>
</div>
