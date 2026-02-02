<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
.sample_screen{position:relative; outline:2px solid #aaa;padding:1px;white-space: nowrap;}
.sample_screen .sample_box{position:absolute; display: inline-block;height: 30%;width: 30%;line-height: 40px;text-align: center;font-weight: bold; margin:1px;}
.sample_screen .sample_box{background-color: #fff; color: #333; border: 1px solid #d5d4d4; background-color: #efefef; max-width: 100%;max-height: 100%;}
</style>
<script type="text/javascript">
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
		posVal = fncSetPopPosition('<c:out value="${popupVO.popupLsdMargnVal}"/>'/5,sizeVal,screen.availWidth/5);
		if(posVal < 0) {
			posVal = Math.floor((screen.availWidth/5 - sizeVal) / 5) * 5;
		}
		$(name).css("left",posVal+'px');
		console.log(posVal)
	<%-- 세로 --%>
	} else {
		$(name).css("height", sizeVal+'px');
		posVal = fncSetPopPosition('<c:out value="${popupVO.popupUpndMargnVal}"/>'/5,sizeVal,screen.availHeight/5);
		if(posVal < 0) {
			posVal = Math.floor((screen.availHeight/5 - sizeVal) / 5) * 5;
		}
		$(name).css("top",posVal+'px');
		console.log(posVal)
	}
}
<%-- 위치 : 화면 설정 --%>
const fncSetSampleScreen = function(target){
	<%-- 팝업 대상 있을 경우 --%>
	if(target) {
		let screenWid = screen.availWidth;
		let screenHt = screen.availHeight;
	
		if(target === "PUTG03") {
			<%-- 모달창일 경우 --%>
			screenHt = screenHt - (window.outerHeight - window.innerHeight);
		} 
		
		if(target === "PUTG01") {
			<%-- 새탭일 경우 --%>
			fncSetDragSample(screenWid,0,".notDrag");
			fncSetDragSample(screenHt,1,".notDrag");
			$(".draggable").hide();
			$(".notDrag").show();
			$(".sample_cords").hide();
		} else {
			$(".draggable").show();
			$(".notDrag").hide();
			$(".sample_cords").show();
		}
		
		<%-- 위치 스크린 크기 세팅 --%>
		$(".sample_screen").css("width", (screenWid/5) + 2); 
		$(".sample_screen").css("height", (screenHt/5) + 2);
		
		<%-- 위치에서 움직이는 팝업 조정 --%>
		if(target !== "PUTG01"){
			fncSetDragSample('${popupVO.popupWdthSizeVal}',0,".draggable");
			fncSetDragSample('${popupVO.popupHghtSizeVal}',1,".draggable");
		}
	}
}
$(document).ready(function(){
	fncSetSampleScreen('<c:out value="${popupVO.popupTgtCd}"/>');
});
</script>
<form:form modelAttribute="popupVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="popupSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(팝업제목, 팝업게시여부, 팝업게시기간, 팝업대상, 팝업구분, 팝업내용 등으로 구성)</caption>
		<colgroup>
			<col class="w10p"/>
			<col/>
			<col class="w10p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">팝업제목</th>
				<td colspan="3"><c:out value="${popupVO.popupTitlNm }"/></td>
			</tr>
			<tr>
				<th scope="row">등록자</th>
				<td><c:out value="${popupVO.regrNm }"/></td>
				<th scope="row">등록일</th>
				<td><c:out value="${popupVO.regDt }"/></td>
			</tr>
			<tr>
				<th scope="row">팝업게시여부</th>
				<td><c:out value="${popupVO.popupPstnYn eq 'Y' ? '게시' : '미게시' }"/></td>
				<th scope="row">팝업대상</th>
				<td><c:out value="${popupVO.popupTgtNm }"/></td>
			</tr>
			<tr>
				<th scope="row">팝업게시기간</th>
				<td>
					<c:choose>
						<c:when test="${popupVO.popupPstnPrdYn eq 'Y' }">
							<c:out value="${popupVO.popupPstnStrtDt += ' ~ ' += popupVO.popupPstnEndDt }"/>
						</c:when>
						<c:otherwise>
							항상
						</c:otherwise>
					</c:choose>
				</td>
				<th scope="row">팝업구분</th>
				<td><c:out value="${popupVO.popupClNm }"/></td>
			</tr>
			<tr>
				<th scope="row">팝업내용</th>
				<td colspan="3">
					<div>
						<c:out value="${popupVO.popupCtt }" escapeXml="false"/>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">대표이미지</th>
				<td>
					<c:choose>
						<c:when test="${not empty popupVO.repImgId and popupVO.fileSeqo > -1}">
							<span class="popup_sample_img">
								<img src="/file/getImage.do?atchFileId=<c:out value="${popupVO.repImgId}"/>&fileSeqo=<c:out value="${popupVO.fileSeqo}"/>&fileNmPhclFileNm=<c:out value="${popupVO.phclFileNm}"/>" alt="대표이미지"/>
							</span>
						</c:when>
						<c:otherwise>
							이미지가 없습니다.
						</c:otherwise>
					</c:choose>
				</td>
				<th scope="row">팝업위치</th>
				<td>
					<div style="display: flex;align-items: flex-end;">
						<div class="sample_screen">
							<div class="sample_box draggable">팝업</div>
							<div class="sample_box notDrag">팝업</div>
						</div>
						<span class="sample_cords mar_l10">
							left : <span id="sampleX"><c:out value="${popupVO.popupLsdMargnVal }"/></span>px
							<br>
							top : <span id="sampleY"><c:out value="${popupVO.popupUpndMargnVal }"/></span>px
							<br>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">팝업크기</th>
				<td colspan="3">
					<div>
						<span>가로크기 : <c:out value="${empty popupVO.popupWdthSizeVal ? '0' : popupVO.popupWdthSizeVal }"/>px</span>
						<br/>
						<span>세로크기 : <c:out value="${empty popupVO.popupHghtSizeVal ? '0' : popupVO.popupHghtSizeVal }"/>px</span>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div id="sample_popup"></div>
<div class="btn_area">
	<button type="button" id="btn_update" class="btn blue">수정</button>
	<button type="button" id="btn_del" class="btn red">삭제</button>
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
