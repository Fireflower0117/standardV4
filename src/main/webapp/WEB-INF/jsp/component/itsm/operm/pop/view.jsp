<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
.sample_screen{position:relative; outline:2px solid #aaa;padding:1px;white-space: nowrap;}
.sample_screen .sample_box{position:absolute; display: inline-block;height: 30%;width: 30%;line-height: 40px;text-align: center;font-weight: bold; margin:1px;}
.sample_screen .sample_box{background-color: #fff; color: #333; border: 1px solid #d5d4d4; background-color: #efefef; max-width: 100%;max-height: 100%;}
</style>
<div class="board_write">
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post">
    <form:hidden path="popupSn" id="popupSn"/>
    <form:hidden path="rprsImgFileId" id="rprsImgFileId"/>
	 <jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
    <div class="tbl_top">
        <div class="tbl_left"><h4 class="md_tit">팝업관리 정보</h4></div>
        <div class="tbl_right"></div>
    </div>
    <div class="tbl_wrap">
        <table class="board_row_type01">
            <colgroup>
                <col style="width:10%">
                <col style="width:40%">
                <col style="width:10%">
                <col style="width:40%">
            </colgroup>
            <tbody>
                <tr>
                    <th><strong>제목</strong></th>
                    <td colspan="3"><c:out value="${itsmPopVO.popupTtlNm }"/></td>
                </tr>
                <tr>
                    <th><strong>등록자</strong></th>
                    <td><c:out value="${itsmPopVO.regrNm }"/></td>
                    <th><strong>등록일</strong></th>
                    <td><c:out value="${itsmPopVO.regDt }"/></td>
                </tr>
                <tr>
					<th><strong>게시 여부</strong>
					<td><c:out value="${itsmPopVO.popupYn eq 'Y' ? '게시' : '미게시'}"/></td>
					<th><strong>대상</strong>
					<td><c:out value="${itsmPopVO.popupTrgtCdNm}"/></td>
				</tr>
				<tr>
					<th><strong>게시 기간</strong>
					<td>
						<c:if test="${itsmPopVO.popupPstgPrdYn eq 'Y' }">
	                    	<c:out value="${itsmPopVO.pstgBgngDt}"/> ~ <c:out value="${itsmPopVO.pstgEndDt}"/>
                    	</c:if>
                    	<c:if test="${itsmPopVO.popupPstgPrdYn eq 'N' }">
                    		항상
                    	</c:if>
					</td>
					<th><strong>구분</strong>
					<td><c:out value="${itsmPopVO.seValNm}"/></td>
				</tr>
                <tr>
					<th><strong>내용</strong></th>
                    <td colspan="3">
                    	<pre><c:out value="${itsmPopVO.popupCn}" escapeXml="false"/></pre>
                    </td>
                </tr>
                <c:if test="${not empty itsmPopVO.rprsImgFileId }">
	                <tr>
	                    <th><strong>대표이미지파일</strong></th>
	                    <td colspan="3">
							<div class="gallery_wrap photo_board">
								<ul class="thum_list">
									<c:if test="${fn:length(fileList) gt 0}">
										<c:forEach var="file" items="${fileList}" varStatus="fileStatus">
											<c:if test="${fn:contains(file.fileTpNm, 'image') }">
												<li>
													<a href="#" onclick="fncPreviewShow('${file.atchFileId}', '${file.fileSeqo}','${file.fileRlNm}');return false;">
														<figure class="thum_img">
															<img src='/itsm/file/getByteImage.do?atchFileId=${file.atchFileId}&fileSeqo=${file.fileSeqo}' alt="image">
															<div class="thum_img_info right_btm" style="max-width: 90%">
																<span class="ellipsis l" style="font-size: 12px;"><c:out value="${file.fileRlNm}"/></span>
															</div>
														</figure>
													</a>
												</li>
											</c:if>
										</c:forEach>
									</c:if>
								</ul>
							</div>
	                    </td>
					</tr>
                </c:if>
                <tr>
					<th rowspan="2"><strong>위치</strong></th>
					<td rowspan="2">
						<div style="display: flex;align-items: flex-end;">
							<div class="sample_screen">
								<div class="sample_box draggable">팝업</div>
								<div class="sample_box notDrag">팝업</div>
							</div>
							<span class="sample_cords">
							<span class="mar_l10">left : <span id="sampleX"><c:out value="${itsmPopVO.popupLsdMargnVal }"/></span> px</span>
							<br>
							<span class="mar_l10">top : <span id="sampleY"><c:out value="${itsmPopVO.popupUpndMargnVal }"/></span> px</span>
							</span>
						</div>
					</td>
					<th rowspan="2"><strong>팝업 크기</strong></th>
					<td>
						<span>가로 크기 : </span>
						<c:out value="${empty itsmPopVO.popupWdthSzVal ? '0' : itsmPopVO.popupWdthSzVal} px"/>
					</td>
                </tr>
				<tr>
					<td>
						<span>세로 크기 : </span>
						<c:out value="${empty itsmPopVO.popupHghtSzVal ? '0' : itsmPopVO.popupHghtSzVal} px"/>
					</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="display_view_image" class="layer_popup js-popup w1400px"></div>
    <div class="popup_bg itemB" id="js-popup-bg" onclick="view_hide('_image');"></div>
    <div class="btn_area right">
    	<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY }">
	       <a href="javascript:void(0)" class="btn btn_mdl btn_rewrite" id="btn_update">수정</a>
	       <a href="javascript:void(0)" class="btn btn_mdl btn_del" id="btn_del">삭제</a>
	    </c:if>
    	<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel">목록</a>
    </div>
</form:form>
</div>
<script type="text/javascript">
$(document).ready(function(){
	setSampleScreen("${itsmPopVO.popupTrgtCd}");

	<%-- 삭제 클릭시 --%>
	$('#btn_delete').on('click', function(){
		itsmFncProc('delete');
	});
});

function setSampleScreen(target){
	
	if( !nullCheck(target) ) {
		var screenWd = screen.availWidth;
		var screenHg = screen.availHeight;
		
		<%-- 모달창일 경우 --%>
		if(target == "PT03") { 
			screenHg = screenHg - (window.outerHeight - window.innerHeight);
		} 
	
		if(target == "PT01") {
			<%-- 새탭일 경우 --%>
			setDragSample(screenWd,0,".notDrag");
			setDragSample(screenHg,1,".notDrag");
			$(".draggable").hide();
			$(".notDrag").show();
			$(".sample_cords").hide();
		} else {
			$(".draggable").show();
			$(".notDrag").hide();
			$(".sample_cords").show();
		}
		
		<%-- 위치 스크린 크기 세팅 --%>
		$(".sample_screen").css("width", (screenWd/5) + 2); 
		$(".sample_screen").css("height", (screenHg/5) + 2);
		
		if(target != "PT01") {
		<%-- 위치에서 움직이는 팝업 조정 --%>
			setDragSample("${itsmPopVO.popupWdthSzVal}",0,".draggable");
			setDragSample("${itsmPopVO.popupHghtSzVal}",1,".draggable");
		}
	}
}

function setDragSample(size, select, name){
	var sizeVal = 100;
	var posVal = 0;
	
	if(!nullCheck(size) && size > 500) {
		sizeVal = size/5;
	}
	if(select == 0) {
		$(name).css("width", sizeVal+'px');
		posVal = fncPopSetPosition("${itsmPopVO.popupLsdMargnVal}"/5,sizeVal,screen.availWidth/5);
		if(posVal < 0) {
			posVal = Math.floor((screen.availWidth/5 - sizeVal) / 5) * 5;
		}
		$(name).css("left",posVal+'px');
	} else {
		$(name).css("height", sizeVal+'px');
		posVal = fncPopSetPosition("${itsmPopVO.popupUpndMargnVal}"/5,sizeVal,screen.availHeight/5);
		if(posVal < 0) {
			posVal = Math.floor((screen.availHeight/5 - sizeVal) / 5) * 5;
		}
		$(name).css("top",posVal+'px');
	}
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
</script>