<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/ckeditor/ckeditor.js?ver=1"></script>
<style>
.sample_screen{ position:relative;outline:2px solid #aaa;padding:1px;white-space: nowrap;}
.sample_screen .sample_box{display: inline-block; cursor: pointer; height: 30%;width: 30%;line-height: 40px;text-align: center;font-weight: bold; margin:1px;}
.sample_screen .sample_box{background-color: #fff; color: #333; border: 1px solid #d5d4d4; background-color: #efefef; max-width: 100%;max-height: 100%;}
</style>
<script type="text/javascript">
<%-- 에디터 세팅 --%>
const fncSetEditor = function(id){
	CKEDITOR.replace(id, {height : 400, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>/ma/js/ckeditor/contents.css'});
}
<%-- 팝업 크기 설정 --%>
const fncSetPopSize = function(popSz, maxSz){
	let resSz = 0;
	if( nullCheck(popSz) || popSz <= 500 ) {
		resSz = 500;
	} else if( popSz >= maxSz ) {
		resSz = maxSz;
	} else {
		resSz = popSz;
	}
	return resSz;
}
<%-- 팝업게시기간에 따른 날짜 세팅 --%>
const fncSetPeriod = function(){
	<%-- 기간설정 --%>
	if($('#popupPstnPrdYn').val() === 'Y'){
		$('#popupPstnPrdYn_Y').show();		 
		$('#popupPstnStrtDt, #popupPstnEndDt').attr('required', true);
	<%-- 항상 --%>
	} else {
		$('#popupPstnPrdYn_Y').hide();		 
		$('#popupPstnStrtDt, #popupPstnEndDt').attr('required', false).val('');
	}
}
<%-- 팝업 위치 설정 --%>
const fncSetPopPosition = function(popMg, popSz, maxSz){
	let resCord = -1;
	if(!nullCheck(popMg)) {
		if( popSz + popMg < maxSz ) {
			resCord = popMg;
		}
	}
	return resCord;
}
<%-- 위치 : 위치 값 세팅 및 표시 --%>
const fncAppendPosition = function(position, posVal){
	if(!nullCheck(posVal)) {
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
			$("#popupWdthSizeVal, #popupHghtSizeVal").attr("disabled","true");
		} else {
			$("#sampleX").parent().show();
			$("#sampleY").parent().show();
			$("#popupWdthSizeVal, #popupHghtSizeVal").removeAttr("disabled");
		}
	}
}
<%-- 위치 : 팝업 크기 및 위치 설정 --%>
const fncSetDragSample = function(size, select ,name){
	let sizeVal = 100;
	let posVal = 0;

	if(!nullCheck(size) && size > 500) {
		sizeVal = size/5;
	}
	
	<%-- 가로 --%>
	if(select == 0) {
		$(name).css("width", sizeVal+'px');
		posVal = fncSetPopPosition($("#sampleX").text()/5,sizeVal,$("#screenWid").text()/5);
		if(posVal < 0) {
			posVal = Math.floor(($("#screenWid").text()/5 - sizeVal) / 5) * 5;
		}
		$(name).css("left",posVal+'px');
		fncAppendPosition("x", posVal);
	<%-- 세로 --%>
	} else {
		$(name).css("height", sizeVal+'px');
		posVal = fncSetPopPosition($("#sampleY").text()/5,sizeVal,$("#screenHt").text()/5);
		if(posVal < 0) {
			posVal = Math.floor(($("#screenHt").text()/5 - sizeVal) / 5) * 5;
		}
		$(name).css("top",posVal+'px');
		fncAppendPosition("y", posVal);
	}
}
<%-- 위치 : 화면 설정 --%>
const fncSetSampleScreen = function(target){
	<%-- 팝업 대상 없을 경우 --%>
	if(!target) {
		$(".sample_screen").hide();
		$("#screenWid").parent().hide();
	} else {
	<%-- 팝업 대상 있을 경우 --%>
		let screenWid = screen.availWidth;
		let screenHt = screen.availHeight;
	
		if(target == "PUTG03") {
			<%-- 모달창일 경우 --%>
			screenWid = window.innerWidth; 
			screenHt = window.innerHeight;
		} 
		
		if(target == "PUTG01") {
			<%-- 새탭일 경우 --%>
			fncSetDragSample(screenWid,0,".notDrag");
			fncSetDragSample(screenHt,1,".notDrag");
			$(".draggable").hide();
			$(".notDrag").show();
			fncAppendPosition("hide");
		} else {
			$(".draggable").show();
			$(".notDrag").hide();
			fncAppendPosition("show");
		}
		
		<%-- 위치 스크린 크기 표시 --%>
		$("#screenWid").parent().show();
		$("#screenWid").text(screenWid);
		$("#screenHt").text(screenHt);
		
		<%-- 위치 스크린 크기 세팅 --%>
		$(".sample_screen").show();
		$(".sample_screen").css("width", (screenWid/5) + 2); 
		$(".sample_screen").css("height", (screenHt/5) + 2);
		
		<%-- 가로 크기값 유효성 검사 --%>
		if(!nullCheck($("#screenWid").text())) {
			if(parseInt($("#popupWdthSizeVal").val()) > parseInt($("#screenWid").text())){
				$("#popupWdthSizeVal").val($("#screenWid").text());
			}
			fncSetDragSample($("#popupWdthSizeVal").val(), 0, '.draggable');
		}
	
		<%-- 세로 크기값 유효성 검사 --%>
		if(!nullCheck($("#screenHt").text())) {
			if(parseInt($("#popupHghtSizeVal").val()) > parseInt($("#screenHt").text())){
				$("#popupHghtSizeVal").val($("#screenHt").text());
			}
			fncSetDragSample($("#popupHghtSizeVal").val(), 1, '.draggable');
		}
		
		<%-- 위치에서 움직이는 팝업 조정 --%>
// 		fncSetDragSample($("#popupWdthSizeVal").val(),0,".draggable");
// 		fncSetDragSample($("#popupHghtSizeVal").val(),1,".draggable");
	}
}
const fncModalSample = function(html){
	<%-- ajax에서 받은 sample popup html --%>
	$("#sample_popup").html(html);
	let displayPop = $("#display_view1");
	
	view_show(1);
	
	<%-- 팝업 가로 설정 --%>
	let popWd = fncSetPopSize($("#popupWdthSizeVal").val(), window.innerWidth);
	displayPop.css('width', popWd + 'px');
	
	<%-- 팝업 세로 설정 --%>
	let fixed = $("#pop_header").outerHeight() + $(".pop_footer").outerHeight();
	let popHgt = fncSetPopSize($("#popupHghtSizeVal").val(), window.innerHeight);
	$("#pop_content").css('height', (popHgt - fixed) +'px');
	
	<%-- 팝업 좌우 여백 설정 --%>
	let popX = fncSetPopPosition(parseInt($("#popupLsdMargnVal").val()), parseInt(popWd), window.innerWidth);
	if( popX < 0 ){
		popX = (( $(window).width() - displayPop.width()) / 2 );
	}
	displayPop.css('left', popX + 'px');
	
	<%-- 팝업 상단 여백 설정 --%>
	let popY = fncSetPopPosition(parseInt($("#popupUpndMargnVal").val()), parseInt(popHgt), window.innerHeight);
	if( popY < 0 ){
		popY = (( $(window).height() - displayPop.height()) / 2 );
	}
	displayPop.css('top', popY + 'px');
	
	$(".pop_content").css('overflow', 'auto');
}
const fncWindowSample = function(html, target){
	let winWd = 0;
	let winHg = 0;
	let winX = 0;
	let winY = 0;
	
	<%-- win팝업 가로 설정 --%>
	winWd = fncSetPopSize($("#popupWdthSizeVal").val(), screen.availWidth, 0);
	
	<%-- win팝업 세로 설정 --%>
	winHg = fncSetPopSize($("#popupHghtSizeVal").val(), screen.availHeight, 0);
	
	<%-- win팝업 좌우 여백 설정 --%>
	winX = fncSetPopPosition(parseInt($("#popupLsdMargnVal").val()), parseInt(winWd), screen.availWidth);
	winX += window.screenLeft;
	
	<%-- win팝업 상단 여백 설정 --%>
	winY = fncSetPopPosition(parseInt($("#popupUpndMargnVal").val()), parseInt(winHg), screen.availHeight);

	let winCss = 'width='+ winWd +', height='+ winHg +', left='+ winX +', top='+ winY +', status=no, location=no, menubar=no';
	
	let win = "";
	if( target == 'PUTG01' ){
		win = window.open("/");
	} else {
		win = window.open("/", "", winCss);
	}
	win.document.write(html);
	
	$(win.document).ready(function () {
		console.log($(".win_close", win.document))
	    $(".win_close", win.document).on('click', function () {
	        win.close();
	    });
	});
	
}

<%-- 팝업 미리보기 --%>
const fncPopSample = function(){
	
	let target;
	
	if(nullCheck($("#popupTgtCd").val())) {
		alert('팝업대상을 선택해주세요.');
		$("#popupTgtCd").focus();
		return false;
	}
	
	<%-- 팝업 내용 세팅 --%>
	$('#popupCtt').val(CKEDITOR.instances.popupCtt.getData());
	
	<%-- 팝업 이미지 경로 세팅 --%>
	if( $('.totalFileCnt').val() == 1){
		let src = $('#repImgUpload').find('img').last().attr('src');
		$('#repImgSrc').val(src);
	} else {
		$('#repImgSrc').val('');
	}
	
	<%-- 팝업 대상 세팅 --%>
	if($("#popupTgtCd").val() == 'PUTG03') {
		target = 'modal';
	} else {
		target = 'window';
	}
	
	<%-- 팝업 미리보기 호출 --%>
	fncAjax(target + 'Sample.do', $('#defaultFrm').serialize(), 'html', true, '', function(data){
		if(target === 'modal'){
			fncModalSample(data);
		} else {
			fncWindowSample(data, $("#popupTgtCd").val());
		}
	});
	
}
<%-- 윈도우 리사이즈 할 경우 --%>
$(window).resize( function() {
	<%-- (모달창) 위치 크기도 줄어들기 --%>
	fncSetSampleScreen($("#popupTgtCd").val());
});
$( function() {
	if("<c:out value="${procType}"/>" == "update") {
		$(".sample_box").css("left", $("#popupLsdMargnVal").val()/5);
		$(".sample_box").css("top", $("#popupUpndMargnVal").val()/5);
	}
	
	$(".draggable").draggable({
		containment : "parent",
		opacity : 0.8,
		stop: function(event, ui) {
			let left = $(this).css("left").replace('px','');
			let top = $(this).css("top").replace('px','');
			
			if(left < 0) {
				left = 0;
			}
			if(top < 0) {
				top = 0;
			}
			
			fncAppendPosition("x", left);
			fncAppendPosition("y", top);
		}
	});
	
	$(".notDrag").disableSelection();
});

$(document).ready(function(){
	
	<%-- 팝업 대상 코드 관리 --%>
	fncCodeList('PUTG', 'select', '선택', '<c:out value="${popupVO.popupTgtCd}"/>', '', 'popupTgtCd', '', 'ASC');
	
	<%-- 팝업 구분 코드 관리 --%>
	fncCodeList('AU', 'select', '선택', '<c:out value="${popupVO.popupClCd}"/>', '', 'popupClCd', '', 'ASC');
	
	<%-- 팝업 대상 변경시 --%>
	$('#popupTgtCd').on('change', function(){
		fncSetSampleScreen($(this).val());
	});
	
	<%-- 팝업게시기간 변경시 --%>
	$('#popupPstnPrdYn').on('change', function(){
		fncSetPeriod();
	});
	
	<%-- 팝업게시기간 --%>
	fncDate("popupPstnStrtDt", "popupPstnEndDt");

	<%-- 에디터 세팅 --%>
	fncSetEditor('popupCtt');
	
	<%-- 이미지 등록폼 생성 --%>
	$('#repImgUpload').html(setFileList($('#repImgId').val(), 'repImgId', 'image' ,'1'));
	
	<%-- 팝업 화면 설정 --%>
	fncSetSampleScreen('<c:out value="${popupVO.popupTgtCd}"/>');
	
	<%-- 팝업 가로,세로 크기 변경시 --%>
	$('#popupWdthSizeVal').on('input', function(){
		if(!nullCheck($("#screenWid").text())) {
			if(parseInt($(this).val()) > parseInt($("#screenWid").text())){
				$(this).val($("#screenWid").text());
			}
			fncSetDragSample($(this).val(), 0, '.draggable');
		}
	});
	$('#popupHghtSizeVal').on('input', function(){
		if(!nullCheck($("#screenHt").text())) {
			if(parseInt($(this).val()) > parseInt($("#screenHt").text())){
				$(this).val($("#screenHt").text());
			}
			fncSetDragSample($(this).val(), 1, '.draggable');
		}
	});
	
	<%-- 미리보기 --%>
	$('#btn_sample').on('click', function(){
		fncPopSample();
	});
	
	<%-- 등록,수정 --%>
	$('#btn_submit').on('click', function(){
		$('#popupCtt').val(CKEDITOR.instances.popupCtt.getData());
		
		<%-- 유효성 체크 --%>
		if(wrestSubmit(document.defaultFrm)){
			<%-- 파일 업로드--%>
			fileFormSubmit("defaultFrm", "<c:out value='${searchVO.procType}'/>", function () {
				fncProc("<c:out value='${searchVO.procType}'/>");
			}, 'NO_DEL');
		}
		return false;
	});
});
</script>
<form:form modelAttribute="popupVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="popupSerno"/>
	<form:hidden path="repImgId"/>
	<form:hidden path="repImgSrc"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(팝업제목, 팝업게시여부, 팝업게시기간, 팝업대상, 팝업구분, 팝업내용 등으로 구성)</caption>
		<colgroup>
			<col class="w10p"/>
			<col/>
			<col class="w10p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>팝업제목</th>
				<td colspan="3">
					<form:input path="popupTitlNm" cssClass="w100p" maxlength="33" title="팝업제목" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>팝업게시여부</th>
				<td>
					<span class="chk">
					    <span class="radio"><form:radiobutton path="popupPstnYn" id="popupPstnYn_Y" title="팝업게시여부" value="Y" required="true" checked="true"/><label for="popupPstnYn_Y">게시</label></span>
					    <span class="radio"><form:radiobutton path="popupPstnYn" id="popupPstnYn_N" title="팝업게시여부" value="N" required="true"/><label for="popupPstnYn_N">미게시</label></span>
					</span>
				</td>
				<th scope="row"><span class="asterisk">*</span>팝업대상</th>
				<td>
					<form:select path="popupTgtCd" cssClass="w30p" title="팝업대상" required="true"></form:select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>팝업게시기간</th>
				<td>
					<form:select path="popupPstnPrdYn" title="팝업게시기간">
						<form:option value="N">항상</form:option>
						<form:option value="Y">기간설정</form:option>
					</form:select>
					<span id="popupPstnPrdYn_Y" class="display_none">
						<span class="calendar_input"><form:input path="popupPstnStrtDt" title="팝업게시시작일시" readonly="true"/></span>
						<span class="gap">~</span>
						<span class="calendar_input"><form:input path="popupPstnEndDt" title="팝업게시종료일시" readonly="true"/></span>
					</span>
				</td>
				<th scope="row"><span class="asterisk">*</span>팝업구분</th>
				<td>
					<form:select path="popupClCd" cssClass="w30p" title="팝업구분" required="true"></form:select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>팝업내용</th>
				<td colspan="3">
					<form:textarea path="popupCtt" cssClass="editor" title="팝업내용" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row">대표이미지</th>
				<td><div id="repImgUpload"></div></td>
				<th scope="row">팝업위치</th>
				<td>
					<form:hidden path="popupLsdMargnVal"/>
					<form:hidden path="popupUpndMargnVal"/>
					<div style="display: flex;align-items: flex-end;">
						<div class="sample_screen">
							<div class="sample_box draggable">팝업</div>
							<div class="sample_box notDrag">팝업</div>
						</div>
						<span class="mar_l10">
							left : <span id="sampleX"><c:out value="${popupVO.popupLsdMargnVal }"/></span>px
							<br>
							top : <span id="sampleY"><c:out value="${popupVO.popupUpndMargnVal }"/></span>px
							<br>
							(<span id="screenWid"></span> x <span id="screenHt"></span>)px
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">팝업크기</th>
				<td colspan="3">
					<span>가로크기 : <form:input path="popupWdthSizeVal" cssClass="numOnly" title="팝업가로크기" maxlength="10" placeholder="숫자를 입력해주세요."/></span>
					<span>세로크기 : <form:input path="popupHghtSizeVal" cssClass="numOnly" title="팝업세로크기" maxlength="10" placeholder="숫자를 입력해주세요."/></span>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div id="sample_popup"></div>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY }">
		<button id="btn_sample" class="btn">미리보기</button>
		<button type="button" id="btn_submit" class="btn blue"><c:out value="${empty popupVO.popupSerno ? '등록' : '수정'}"/></button>
		<c:if test="${not empty popupVO.popupSerno }">
		    <button type="button" id="btn_del" class="btn red">삭제</button>
		</c:if>
	</c:if>	
	<button type="button" id="<c:out value="${not empty popupVO.popupSerno ? 'btn_view' : 'btn_list'}"/>" class="btn gray">취소</button>
</div>
