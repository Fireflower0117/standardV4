<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
.sample_screen{ position:relative;outline:2px solid #aaa;padding:1px;white-space: nowrap;}
.sample_screen .sample_box{display: inline-block; cursor: pointer; height: 30%;width: 30%;line-height: 40px;text-align: center;font-weight: bold; margin:1px;}
.sample_screen .sample_box{background-color: #fff; color: #333; border: 1px solid #d5d4d4; background-color: #efefef; max-width: 100%;max-height: 100%;}
</style>
<script src="${pageContext.request.contextPath}/resource/editor/js/HuskyEZCreator.js"></script>
<div class="board_write">
<form:form modelAttribute="itsmPopVO" name="defaultFrm" id="defaultFrm" method="post">
    <form:hidden path="popupSn" id="popupSn"/>
    <form:hidden path="rprsImgFileId" id="rprsImgFileId"/>
    <form:hidden path="imgSrc" id="imgSrc"/>
    <jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
    <div class="tbl_top">
        <div class="tbl_left"><h3 class="md_tit">팝업관리 ${procType eq 'insert' ? '등록' : '수정'}</h3></div>
		<div class="tbl_right"><span class="asterisk">*</span>필수입력</div>
    </div>
    <!-- board -->
    <div class="tbl_wrap">
        <table class="board_row_type01">
            <colgroup>
                <col style="width:10%">
                <col>
                <col style="width:10%">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><strong class="th_tit">제목</strong></th>
                    <td colspan="3">
                        <form:input path="popupTtlNm" id="popupTtlNm" cssClass="text w100p"  maxlength="66" title="제목" required="true"/>
                    </td>
                </tr>
                <tr>
                	<th><strong class="th_tit">게시 여부</strong></th>
					<td>
						<label class="radio">
							<form:radiobutton path="popupYn" id="popupYnY" value="Y"/>
							<span>게시</span>
						</label>
						<label class="radio">
							<form:radiobutton path="popupYn" id="popupYnN" value="N"/>
							<span>미게시</span>
						</label>
					</td>
                	<th><strong class="th_tit">대상</strong></th>
					<td>
						<form:select path="popupTrgtCd" id="popupTrgtCd" cssClass="selec w150px" onchange="setSampleScreen(this.value);" title="대상" required="true">
							<form:option value="">선택</form:option>
						</form:select>
					</td>
                </tr>
                <tr>
					<th><strong class="th_tit">게시 기간</strong></th>
					<td>
						<form:select path="popupPstgPrdYn" id="popupPstgPrdYn" cssClass="selec w150px mar_r10" onchange="dateChk(this.value)">
							<form:option value="N">항상</form:option>
							<form:option value="Y">기간설정</form:option>
						</form:select>
						<span class="calendar_input w120">
							<form:input path="pstgBgngDt" id="pstgBgngDt" readonly="true" cssClass="typeA text" title="게시 시작 날짜"/>
						</span>
						<span class="gap">~</span>
						<span class="calendar_input w120">
							<form:input path="pstgEndDt" id="pstgEndDt" readonly="true" cssClass="typeA text" title="게시 종료 날짜"/>
						</span>
					</td>
					<th><strong class="th_tit">구분</strong></th>
					<td>
						<form:select path="seVal" cssClass="selec w150px" title="구분" required="true">
							<form:option value="">선택</form:option>
						</form:select>
					</td>
				</tr>
                <tr>
                    <th><strong class="th_tit">내용</strong></th>
                    <td colspan="3">
                        <form:textarea path="popupCn" id="popupCn" class="text_area_mdl editor" style="width:100%;" maxlength="4000" title="내용" required="true"/>
                    </td>
                </tr>
                <tr style="height: 227px;">
				    <th><strong>대표이미지파일</strong></th>
				    <td>
				        <div id="rprsImgFileUpload"> </div>
				    </td>
					<th><strong>위치</strong></th>
					<td>
						<form:hidden path="popupLsdMargnVal" id="popupLsdMargnVal"/>
						<form:hidden path="popupUpndMargnVal" id="popupUpndMargnVal"/>
						<div style="display: flex;align-items: flex-end;">
							<div class="sample_screen">
								<div class="sample_box draggable">팝업</div>
								<div class="sample_box notDrag">팝업</div>
							</div>
							<span class="mar_l10">
								left : <span id="sampleX"><c:out value="${itsmPopVO.popupLsdMargnVal }"/></span>px
								<br>
								top : <span id="sampleY"><c:out value="${itsmPopVO.popupUpndMargnVal }"/></span>px
								<br>
								(<span id="screenWd"></span> x <span id="screenHg"></span>)px
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th><strong>팝업 크기</strong></th>
					<td>
						<span>가로 크기 : </span>
						<span><form:input path="popupWdthSzVal" id="popupWdthSzVal" cssClass="text numOnly" maxlength="10" style="text-align:right;" placeholder="숫자를 입력해주세요"/></span><span>&nbsp; px</span>
					</td>
					<td colspan="2">
						<span>세로 크기 : </span>
						<span><form:input path="popupHghtSzVal" id="popupHghtSzVal" cssClass="text numOnly" maxlength="10" style="text-align:right;" placeholder="숫자를 입력해주세요"/></span><span>&nbsp; px</span>
					</td>
				</tr>
            </tbody>
        </table>
    </div>
    <div id="sample_popup"></div>
    <div class="btn_area right">
    	<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
    		<a href="javascript:void(0)" id="popSample" class="btn btn_mdl btn_save">미리보기</a>
	   		<a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl btn_save" >${procType eq 'insert' ? '등록' : '수정'}</a>
	        <a href="javascript:void(0)" id="${procType eq 'insert' ? 'btn_list' : 'btn_view'}" class="btn btn_mdl btn_cancel">취소</a>
		</c:if>
    </div>
</form:form>
</div>
<script>
<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
	var oEditors = [];
	$(document).ready(function(){
		<%-- CKeditr 설정--%>
		CKEDITOR.replace("popupCn",{height : 400, contentsCss: '${pageContext.request.contextPath}/component/itsm/js/ckeditor/contents.css'});

		<%-- 등록 또는 수정 --%>
		$("#btn_submit").click(function(){
			<%-- 에디터 유효성 검사 --%>
			if(!CKEDITOR.instances.popupCn.getData() || !CKEDITOR.instances.popupCn.getData().length){
				alertMsg("popupCn", "red", "내용 : 필수 입력입니다.");
				CKEDITOR.instances.popupCn.focus();
				wrestSubmit(document.defaultFrm)
				return false;
			}else{
				$("#msg_popupCn").remove();
				$("#popupCn").val(CKEDITOR.instances.popupCn.getData());
				if(wrestSubmit(document.defaultFrm)){
					fileFormSubmit("defaultFrm", "${searchVO.procType}", function () {
						itsmFncProc('${searchVO.procType}');
					});
					return false;
				}
			}
		});
		
		<%-- 등록 시 팝업게시여부 체크 --%>
		if( "${procType}" == "insert" ) {
			$("#popupYnY").attr("checked", "checked");
		}
		
		<%-- 팝업 대상 코드 관리 --%>
		fncCodeList("PT", "select", "선택", "${itsmPopVO.popupTrgtCd}", "", "popupTrgtCd", "", "ASC");
		
		<%-- 팝업 구분 코드 관리 --%>
		fncCodeList("MMG", "select", "선택", "${itsmPopVO.seVal}", "", "seVal", "", "ASC");
		
		fncDate("pstgBgngDt", "pstgEndDt");

		$("#rprsImgFileUpload").html(setFileList($("#rprsImgFileId").val(), "rprsImgFileId", "byteImage","1"));
	
		dateChk($('#popupPstgPrdYn').val());
		
		setSampleScreen("${itsmPopVO.popupTrgtCd}");
		
		$("#popupWdthSzVal").on("input", function() {
			if(!nullCheck($("#screenWd").text())) {
				if(parseInt($(this).val()) > parseInt($("#screenWd").text())){
					$(this).val($("#screenWd").text());
				}
				setDragSample($(this).val(), 0, '.draggable');
			}
		});
		
		$("#popupHghtSzVal").on("input", function() {
			if(!nullCheck($("#screenHg").text())) {
				if(parseInt($(this).val()) > parseInt($("#screenHg").text())){
					$(this).val($("#screenHg").text());
				}
				setDragSample($(this).val(), 1, '.draggable');
			}
		})
	});
	
	<%-- 윈도우 리사이즈 할 경우 --%>
	<%-- (모달창) 위치 크기도 줄어들기 --%>
	$(window).resize( function() {
		setSampleScreen($("#popupTrgtCd").val());
	});
	
	$( function() {
		if("${procType}" == "update") {
			$(".sample_box").css("left", $("#popupLsdMargnVal").val()/5);
			$(".sample_box").css("top", $("#popupUpndMargnVal").val()/5);
		}
		
		$(".draggable").draggable({
			containment : "parent",
			opacity : 0.8,
			stop: function(event, ui) {
				var left = $(this).css("left").replace('px','');
				var top = $(this).css("top").replace('px','');
				
				if(left < 0) {
					left = 0;
				}
				if(top < 0) {
					top = 0;
				}
				
				appendPosition("x", left);
				appendPosition("y", top);
			}
		});
		
		$(".notDrag").disableSelection();
	} );
	
	<%-- 팝업 미리보기 --%>
	$("#popSample").click(function(){

		if( nullCheck($("#popupTrgtCd").val()) ) {
			alert('팝업 대상을 선택해주세요.');
			$("#popupTrgtCd").focus();
			return false;
		}

		$('#popupCn').val(CKEDITOR.instances.popupCn.getData());

		<%-- 팝업 이미지 경로 세팅 --%>
		if( $(".totalFileCnt").val() == 1){
			var src = $("#rprsImgFileUpload").find("img").last().attr("src");
			$("#imgSrc").val(src);
		} else {
			$("#imgSrc").val("");
		}
		
		var target = "";
		
		if($("#popupTrgtCd").val() == 'PT03') {
			target = "modal";
		} else {
			target = "window";
		}
		
		$.ajax({
			method : "post"
			,url : target + "Sample.do"
			,data : $("#defaultFrm").serialize()
			,dataType : "html"
			,success : function(data) {
				if($("#popupTrgtCd").val() == 'PT03') {
					modal_sample(data);
				} else {
					window_sample(data,$("#popupTrgtCd").val());
				}
			}
		})
	})
	
	<%-- 위치 : 화면 설정 --%>
	function setSampleScreen(target){
		
		<%-- 팝업 대상 없을 경우 --%>
		if( nullCheck(target) ) {
			$(".sample_screen").hide();
			$("#screenWd").parent().hide();
			appendPosition("hide");
		} else {
		<%-- 팝업 대상 있을 경우 --%>
			var screenWd = screen.availWidth;
			var screenHg = screen.availHeight;
		
			if(target == "PT03") {
				<%-- 모달창일 경우 --%>
				screenWd = window.innerWidth; 
				screenHg = window.innerHeight;
			} 
			
			if(target == "PT01") {
				<%-- 새탭일 경우 --%>
				setDragSample(screenWd,0,".notDrag");
				setDragSample(screenHg,1,".notDrag");
				$(".draggable").hide();
				$(".notDrag").show();
				appendPosition("hide");
			} else {
				$(".draggable").show();
				$(".notDrag").hide();
				appendPosition("show");
			}
			
			<%-- 위치 스크린 크기 표시 --%>
			$("#screenWd").parent().show();
			$("#screenWd").text(screenWd);
			$("#screenHg").text(screenHg);
			
			<%-- 위치 스크린 크기 세팅 --%>
			$(".sample_screen").show();
			$(".sample_screen").css("width", (screenWd/5) + 2); 
			$(".sample_screen").css("height", (screenHg/5) + 2);
			
			<%-- 가로 크기값 유효성 검사 --%>
			if(!nullCheck($("#screenWd").text())) {
				if(parseInt($("#popupWdthSzVal").val()) > parseInt($("#screenWd").text())){
					$("#popupWdthSzVal").val($("#screenWd").text());
				}
				setDragSample($("#popupWdthSzVal").val(), 0, '.draggable');
			}
		
			<%-- 세로 크기값 유효성 검사 --%>
			if(!nullCheck($("#screenHg").text())) {
				if(parseInt($("#popupHghtSzVal").val()) > parseInt($("#screenHg").text())){
					$("#popupHghtSzVal").val($("#screenHg").text());
				}
				setDragSample($("#popupHghtSzVal").val(), 1, '.draggable');
			}
			
			<%-- 위치에서 움직이는 팝업 조정 --%>
			setDragSample($("#popupWdthSzVal").val(),0,".draggable");
			setDragSample($("#popupHghtSzVal").val(),1,".draggable");
		}
		
	}
	
	<%-- 위치 : 팝업 크기 및 위치 설정 --%>
	function setDragSample(size, select, name){
		var sizeVal = 100;
		var posVal = 0;
		
		if(!nullCheck(size) && size > 500) {
			sizeVal = size/5;
		}
		if(select == 0) {
			$(name).css("width", sizeVal+'px');
			posVal = fncPopSetPosition($("#sampleX").text()/5,sizeVal,$("#screenWd").text()/5);
			if(posVal < 0) {
				posVal = Math.floor(($("#screenWd").text()/5 - sizeVal) / 5) * 5;
			}
			$(name).css("left",posVal+'px');
			appendPosition("x", posVal);
		} else {
			$(name).css("height", sizeVal+'px');
			posVal = fncPopSetPosition($("#sampleY").text()/5,sizeVal,$("#screenHg").text()/5);
			if(posVal < 0) {
				posVal = Math.floor(($("#screenHg").text()/5 - sizeVal) / 5) * 5;
			}
			$(name).css("top",posVal+'px');
			appendPosition("y", posVal);
		}
	}
	
	<%-- 위치 : 위치 값 세팅 및 표시 --%>
	function appendPosition(position, posVal) {
		if( !nullCheck(posVal) ) {
			if(position == "x"){
				$("#sampleX").text(posVal*5);
				$("#popupLsdMargnVal").val(posVal*5);
			} else {
				$("#sampleY").text(posVal*5);
				$("#popupUpndMargnVal").val(posVal*5);
			} 
		} else {
			if(position == "hide"){
				$("#sampleX").parent().hide();
				$("#sampleY").parent().hide();
				$("#popupWdthSzVal, #popupHghtSzVal").attr("disabled","true");
			} else {
				$("#sampleX").parent().show();
				$("#sampleY").parent().show();
				$("#popupWdthSzVal, #popupHghtSzVal").removeAttr("disabled");
			}
		}
	}
	
	<%-- modal popup 미리보기 --%>
	function modal_sample(html){
		<%-- ajax에서 받은 sample popup html --%>
		$("#sample_popup").html(html);
		
		var displayPop = $("#display_view_sample");
		
		<%-- 팝업 css 세팅 --%>
		displayPop.removeClass();
		displayPop.addClass('sample_pop');
		displayPop.addClass('js-popup');		
		view_show('_sample');
		
		<%-- 팝업 가로 설정 --%>
		var popWd = fncPopSetSize($("#popupWdthSzVal").val(), window.innerWidth);
		displayPop.css('width', popWd + 'px');
		
		<%-- 팝업 세로 설정 --%>
		var fixed = $("#pop_header").outerHeight() + $(".popup_footer").height();
		var popHgt = fncPopSetSize($("#popupHghtSzVal").val(), window.innerHeight);
		$("#cont").css('height', (popHgt - fixed) +'px');
		
		<%-- 팝업 좌우 여백 설정 --%>
		var popX = fncPopSetPosition(parseInt($("#popupLsdMargnVal").val()), parseInt(popWd), window.innerWidth);
		if( popX < 0 ){
			popX = (( $(window).width() - displayPop.width()) / 2 );
		}
		displayPop.css('left', popX + 'px');
		
		<%-- 팝업 상단 여백 설정 --%>
		var popY = fncPopSetPosition(parseInt($("#popupUpndMargnVal").val()), displayPop.height(), window.innerHeight);
		if( popY < 0 ){
			popY = (( $(window).height() - displayPop.height()) / 2 );
		}
		displayPop.css('top', popY + 'px');
		
		$(".popup_content").css('overflow', 'auto');
		
	}
	
	<%-- window popup 미리보기 --%>
	function window_sample(html, target){

		var winWd = 0;
		var winHg = 0;
		var winX = 0;
		var winY = 0;
		
		<%-- win팝업 가로 설정 --%>
		var winWd = fncPopSetSize($("#popupWdthSzVal").val(), screen.availWidth, 0);

		<%-- win팝업 세로 설정 --%>
		var winHg = fncPopSetSize($("#popupHghtSzVal").val(), screen.availHeight, 0);
		
		<%-- win팝업 좌우 여백 설정 --%>
		var winX = fncPopSetPosition(parseInt($("#popupLsdMargnVal").val()), parseInt(winWd), screen.availWidth);
		winX += window.screenLeft;
		
		<%-- win팝업 상단 여백 설정 --%>
		var winY = fncPopSetPosition(parseInt($("#popupUpndMargnVal").val()), parseInt(winHg), screen.availHeight);
	
		var winCss = 'width='+ winWd +', height='+ winHg +', left='+ winX +', top='+ winY +', status=no, location=no, menubar=no';
		
		var win = "";
		if( target == 'PT01' ){
			win = window.open("/");
		} else {
			win = window.open("/", "", winCss);
		}
		win.document.write(html);
		
	}
	
	<%-- 팝업 배경 클릭시 닫기 --%>
	$(function(){
	    $('#js-popup-bg').click(function(){
	        $('.js-popup').css("display","none");
	        $(this).css("display","none");
	    });
	});
	
	<%-- 팝업 게시 기간 설정 여부 --%>
	var dateChk = function(value) {
		alertMsg("pstgBgngDt");
		alertMsg("pstgEndDt");
		if(value == 'Y' ) {
			$(".calendar_input").show();
			$(".gap").show();
			$("#pstgBgngDt, #pstgEndDt").attr("required", "required");
		} else {
			$(".calendar_input").hide();
			$(".gap").hide();
			$("#pstgBgngDt, #pstgEndDt").val("");
			$("#pstgBgngDt, #pstgEndDt").removeAttr("required");
		}
	}
	
	<%-- 팝업 크기 설정 --%>
	function fncPopSetSize(popSz, maxSz){
		var resSz = 0;
		if( nullCheck(popSz) || popSz <= 500 ) {
			resSz = 500;
		} else if( popSz >= maxSz ) {
			resSz = maxSz;
		} else {
			resSz = popSz;
		}
		return resSz;
	}
	
	<%-- 팝업 위치 설정 --%>
	function fncPopSetPosition(popMg, popSz, maxSz) {
		var resCord = -1;
		if( !nullCheck(popMg) ) {
			if( popSz + popMg < maxSz ) {
				resCord = popMg;
			}
		}
		return resCord;
	}
	
	<%-- 스마트 에디터 유효성검사를 위한 replace --%>
	function fncEditorReplace(value) {
		value = value.replace(/<p><br><\/p>/gi, "");
		value = value.replace(/(<\/p><br>|<p><br>)/gi, "");
		value = value.replace(/(<p>|<\/p>)/gi, "");
		value = value.replace(/&nbsp;/gi, "");
	
		return value;
	}
</c:if>
<%-- popup - layer --%>
function view_show(popName) {
	let left = ($(window).width() - $("#display_view" + popName).width()) / 2;
	let top = ($(window).height() - $("#display_view" + popName).height()) / 2;
	$("#js_popup_bg").show();
	$("#display_view" + popName).addClass("on").css({ 'visibility': 'visible', 'position': 'fixed', 'left': left, 'top': top, 'z-index': 5500 });
	return false;
}
function view_hide(popName) {
	$("#display_view" + popName).removeClass("on").css('visibility', 'hidden');
	$("#js_popup_bg").hide();
	return false;
}
$(function () {
	$('#js_popup_bg').click(function () {
		$('.js_popup').removeClass("on").css('visibility', 'hidden');
		$(this).hide();
	});
});
</script>