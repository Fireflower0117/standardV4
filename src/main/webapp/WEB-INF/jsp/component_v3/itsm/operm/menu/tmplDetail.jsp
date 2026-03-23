<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

	<%-- addContTmpl에 선택한 tmpl 보내기--%>
	const fncPopDetailSubmit = function(){
		
		if($(".setList li").length == 0){
			alert("선택된 템플릿이 없습니다.");
			return false;
		}
		
		var tempHtml = CKEDITOR.instances.editrCont.getData();
		
		$(".setList li").each(function(){
			tempHtml += $(this).data("editrcont");
		});
		
		CKEDITOR.instances.editrCont.setData(tempHtml);
		$('#display_view1').html("");
		view_hide('1');
	    $("#js_popup_bg").hide();
	}

	<%-- 선택한 tmpl 미리보기 --%>
	const fncPopPreview = function(){
		
		var tempHtml = "";
		if($(".setList li").length == 0){
			alert("선택된 템플릿이 없습니다.");
			return false;
		}else{
			$(".setList li").each(function(){
				tempHtml += $(this).data("editrcont");
			});
		}
		
		var popWidth = 1250;
		var popHeight = 800;
		
		var popTop = (($(window).height() - popHeight) / 2 );
		var popLeft = (($(window).width() - popWidth) / 2 );
		
		window.open('', "popPreview", 'top='+popTop+',left='+popLeft+',titlebar=no,status=no,toolbar=no,resizable=no,scrollbars=yes,width='+popWidth+'px, height='+popHeight+'px');
		$("#previewCont").val(tempHtml);
		$("#defaultFrmTmpl").attr({"action" : "popPreview.do", "method" : "post", "target" : "popPreview", "onsubmit" : ""}).submit();
		$("#defaultFrmTmpl").attr({"action" : "", "target" : "", "onsubmit" : "return false;"});
	}
	
	<%-- 상단 tab 변경 --%>
	const fncPopTabAction = function(obj){
		var tabDivn = $(obj).data("tabdivn");
		
		$("#tabDivn").val(tabDivn);
		
		$("[id^='schEtc']").val("");
		$("#searchCondition").val("");
		
		$(".search_box select[id^='schEtc']").addClass("disno");
		$(".search_box select[data-tabdivn='"+tabDivn+"']").removeClass("disno");
		
		<%-- 체크박스 초기화 --%>
		for(var i = 0 ; i < document.defaultFrmPop.elements.length ; i++){
			var el = document.defaultFrmPop.elements[i];
			if($('#'+el.id).attr('type') == "hidden"){
				continue;
			}
			if($('#'+el.id).attr('type') == "checkbox"){
				$('#'+el.id).prop("checked", "");
				continue;
			}
			el.value = "";
		}
		
		fncPageBoard("popAddList", "popAddList", 1);
	}

	<%-- 즐겨찾기에서 템플릿유형 selectBox 변경시 실행 --%>
	const fncChangeSel = function(obj){
		if($(obj).val() == null || $(obj).val() ==""){
			$("#schEtc04").val("");
			$("#schEtc04").prop("disabled",true)
			return false;
		}else{
			<%-- 통합 템플릿타입 selectBox 조회--%>
			fncCodeList($(obj).val(), "select", "템플릿 타입", "", "", "schEtc04");
			$("#schEtc04").prop("disabled",false)
		}
	}


	<%--템플릿 유형 selectBox 조회--%>
	fncCodeList("TMCL01", "select", "템플릿 타입", "", "", "schEtc01");
	<%-- 통합 템플릿타입 selectBox 조회--%>
	fncCodeList("TMCL02", "select", "템플릿 타입", "", "", "schEtc02");
	
	<%-- 컨텐츠 목록 불러오기 --%>
	fncPageBoard("popAddList", "popAddList", 1);

	<%-- tab 속성 조정 --%>
	if ($('.js_tmenu').length) {
        $('.js_tmenu li a').on("click",function () {
            let tabId = $(this).parent().attr('id');
            let selTabId = $('.js_tmenu li[id="' + tabId + '"]');
            selTabId.addClass('on').fadeIn();
            selTabId.siblings().removeClass('on');
            fncPopTabAction($(this));
            return false;
        });
    }
    
	<%-- 팝업 검색 --%>
	$('#btn_search_pop').on("click",function () {
		fncPageBoard("popAddList", "popAddList", 1);
	});

	<%-- 템플릿 설정 미리보기 --%>
	$('.btn_pop_preview').on("click",function () {
		fncPopPreview('pop');
	});

	<%-- 팝업닫기 --%>
	$('.btn_pop_close').on("click",function () {
		$('#display_view1').html("");
		view_hide('1');
	    $("#js_popup_bg").hide();
	});

	<%-- 템플릿 선택--%>
	$('#btn_pop_submit').on("click",function () {
		fncPopDetailSubmit();
	});
	
	$("#schPopKeyword").on("keypress",function(){
		if (window.event.keyCode == 13) {
			fncPageBoard("popAddList", "popAddList", 1);
		}
	});
	$("select[id^='schEtc']").on("change",function(){
		fncPageBoard("popAddList", "popAddList", 1);
	}); 
	
	$(".setList").sortable({
		axis:"y"
	})

	<%-- 템플릿 선택--%>
	$('#schEtc03').on("change",function () {
		fncChangeSel($(this));
	});
	
	
	
	
	<%-- BGN : tmplDetailSetList --%>
	const fncMoveSet = function(obj){
		
		var moveDivn = $(obj).attr("data-move");
		
		var $targetDom = $(obj).closest("li");
		var idx = $(".setList li").index($targetDom);
		var lastIdx = $(".setList li").length - 1;
		
		if(moveDivn == "up"){
			if(idx == 0){
				alert("첫번째 항목입니다.");
				return false;
			}
			$targetDom.insertBefore($(".setList li").eq(idx-1));
		}
		if(moveDivn == "down"){
			if(idx == lastIdx){
				alert("마지막 항목입니다.");
				return false;
			}
			$targetDom.insertAfter($(".setList li").eq(idx+1));
		}
	}

	<%--테이블 설정 요소 삭제 --%>
	const fncDelSet = function(obj){
		if(!confirm("해당 템플릿을 삭제하시겠습니까?")){
			return false;
		}
		$(obj).closest("li").remove();
	}

	<%--테이블 설정 초기화--%>
	const fncResetTbl = function(tmplSerno, num){
		
		if(!confirm("테이블 설정을 초기화 하시겠습니까?")){
			return false;
		}
		
		$targetDom = $("#temp_tbl_"+tmplSerno+"_"+num).closest("li");
		$targetDom.data("editrcont", $targetDom.data("editrtemp"));
		$targetDom.find(".btn_tbl_set_on").removeClass("on");
		
		$("#dynmTbl_row_"+tmplSerno+"_"+num).val("");
		$("#dynmTbl_col_"+tmplSerno+"_"+num).val("");
		$("#dynmTbd_"+tmplSerno+"_"+num).html("");
	}

	<%--테이블 설정 저장--%>
	const fncSaveTbl = function(tmplSerno, num){
		
		if(!$("#dynmTbd_"+tmplSerno+"_"+num).html()){
			alert("테이블을 생성해주세요.");
			return false;
		}
		
		$tempTbl = $("#temp_tbl_"+tmplSerno+"_"+num);
		var editrCont = $tempTbl.closest("li").data("editrcont");

		$tempTbl.html(editrCont);
		$tempTbl.find(".tbl_temp_wrap").children("table").html($("#dynmTbl_"+tmplSerno+"_"+num).html());
		$customTbl = $tempTbl.find(".tbl_temp_wrap").children("table");
		$customTbl.find("td").removeAttr("id").html("");
		$customTbl.children().removeAttr("id");
		
		$tempTbl.closest("li").data("editrcont", $tempTbl.html());
		$tempTbl.html("");
		
		alert("테이블이 설정이 저장되었습니다.");
		$tempTbl.closest("li").find(".tbl_detail").slideToggle(200);
		$tempTbl.closest("li").find(".btn_tbl_set_on").addClass("on");
	}

	const fncCalColGrp = function(tmplSerno, num){
		var colNo = $("#dynmTbl_col_"+tmplSerno+"_"+num).val();
		
		var colHtml = '';
		var colVal = (Math.floor(100 / colNo * 1000) / 1000).toFixed(3);

		for(var c = 1; c <= colNo; c++){
			colHtml += '<col style="width:'+colVal+'%">';
		}
		$("#colGrp_"+tmplSerno+"_"+num).html(colHtml);
	}

	const fncAddDynmTbl = function(tmplSerno, num){
		var rowNo = $("#dynmTbl_row_"+tmplSerno+"_"+num).val();
		var colNo = $("#dynmTbl_col_"+tmplSerno+"_"+num).val();
		
		if(!rowNo || !colNo){
			alert("행 X 열 정보를 정확히 입력해주세요.");
			return false;
		}

		var tempHtml = '';
		for(var r = 1; r <= rowNo; r++){
			for(var c = 1; c <= colNo; c++){
				if(c == 1){tempHtml += '<tr>';}
				tempHtml +='<td id="dynmTd_'+tmplSerno+"_"+num+'_'+r+'_'+c+'">';
				tempHtml +='<div>';
				tempHtml +='<input type="hidden" id="rowNo_'+tmplSerno+"_"+num+'_'+r+'_'+c+'" value="'+r+'"/>';
				tempHtml +='<input type="hidden" id="colNo_'+tmplSerno+"_"+num+'_'+r+'_'+c+'" value="'+c+'"/>';
				tempHtml +='<input type="hidden" id="mrgRowGrp_'+tmplSerno+"_"+num+'_'+r+'_'+c+'"/>';
				tempHtml +='<input type="hidden" id="mrgColGrp_'+tmplSerno+"_"+num+'_'+r+'_'+c+'"/>';
				tempHtml +='<input type="hidden" id="mrgRowVal_'+tmplSerno+"_"+num+'_'+r+'_'+c+'"/>';
				tempHtml +='<input type="hidden" id="mrgColVal_'+tmplSerno+"_"+num+'_'+r+'_'+c+'"/>';
				tempHtml +='<label for="dynmChk_'+tmplSerno+"_"+num+'_'+r+'_'+c+'">';
				tempHtml +='<input type="checkbox" id="dynmChk_'+tmplSerno+"_"+num+'_'+r+'_'+c+'" data-row="'+r+'" data-col="'+c+'"/>';
				tempHtml +='</label>';
				tempHtml +='</div>';
				tempHtml +='</td>';
				if(c == colNo){tempHtml += '</tr>';}
			}
		}
		$("#dynmTbd_"+tmplSerno+"_"+num).html(tempHtml);
		fncCalColGrp(tmplSerno, num);
	}

	const fncMrgDynmTbl = function(tmplSerno, num){
		
		var $chkTd = $("#dynmTbd_"+tmplSerno+"_"+num).find("input[type='checkbox']:checked"); 
		var chkCnt = $chkTd.length;
		
		if(chkCnt == 0){
			alert("선택된 셀이 없습니다.");
			return false;
		}
		
		var rowArr = [];
		var colArr = [];
		
		$chkTd.each(function(idx){
			rowArr.push($(this).attr("data-row"));
			colArr.push($(this).attr("data-col"));
		});
		
		var rowBgnNo = Math.min.apply(null, rowArr)
		var colBgnNo = Math.min.apply(null, colArr)
		var rowLastNo = Math.max.apply(null, rowArr)
		var colLastNo = Math.max.apply(null, colArr)
		var mgrRowVal = rowLastNo - rowBgnNo + 1;
		var mrgColVal = colLastNo - colBgnNo + 1;
		for(var r = rowBgnNo; r <= rowLastNo; r++){
			for(var c = colBgnNo; c <= colLastNo; c++){
				if(!$("#dynmChk_"+tmplSerno+"_"+num+"_"+r+"_"+c).prop("checked")){
					alert("셀 병합 형태가 적합하지 않습니다.");
					return false;
				}else{
					if($("#mrgRowGrp_"+tmplSerno+"_"+num+"_"+r+"_"+c).val() && $("#mrgColGrp_"+tmplSerno+"_"+num+"_"+r+"_"+c).val()){
						alert("병합 된 셀이 포함되어 있습니다.");
						return false;
					}
				}
			}
		}
		
		$chkTd.each(function(idx){
			var curRow = $(this).attr("id").split("_")[3];
			var curCol = $(this).attr("id").split("_")[4];
			
			$("#mrgRowGrp_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val(rowBgnNo);
			$("#mrgColGrp_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val(colBgnNo);
			
			if(idx == 0){
				$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).addClass("merge");
				$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).attr("rowSpan", mgrRowVal);
				$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).attr("colSpan", mrgColVal);
				$("#mrgRowVal_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val(mgrRowVal);
				$("#mrgColVal_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val(mrgColVal);
			}else{
				$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).hide();
			}
			$(this).prop("checked", false);
		});
	}

	const fncUnmrgDynmTbl = function(tmplSerno, num){
		
		var $chkTd = $("#dynmTbd_"+tmplSerno+"_"+num).find("input[type='checkbox']:checked"); 
		var chkCnt = $chkTd.length;
		
		if(chkCnt == 0){
			alert("선택된 셀이 없습니다.");
			return false;
		}
		
		var mrgChk = true;
		$chkTd.each(function(idx){
			var curRow = $(this).attr("id").split("_")[3];
			var curCol = $(this).attr("id").split("_")[4];
			
			if(!$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).hasClass("merge")){
				mrgChk = false;
			}
		});
		if(!mrgChk){
			alert("병합된 셀만 선택해주세요.");
			return false;
		}
		
		$chkTd.each(function(idx){
			var curRow = $(this).attr("id").split("_")[3];
			var curCol = $(this).attr("id").split("_")[4];
			
			$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).removeClass("merge")
			$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).attr("rowspan", "");
			$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).attr("colspan", "");
			$("#mrgRowGrp_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val("");
			$("#mrgColGrp_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val("");
			$("#mrgRowVal_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val("");
			$("#mrgColVal_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val("");
			
			$("#dynmTbd_"+tmplSerno+"_"+num).find("input[type='checkbox']:not(:checked)").each(function(idx){
				var tempRow = $(this).attr("id").split("_")[3];
				var tempCol = $(this).attr("id").split("_")[4];
				var tempRowGrp = $("#mrgRowGrp_"+tmplSerno+"_"+num+"_"+tempRow+"_"+tempCol).val();
				var tempColGrp = $("#mrgColGrp_"+tmplSerno+"_"+num+"_"+tempRow+"_"+tempCol).val();
				if(tempRowGrp == curRow && tempColGrp == curCol){
					$("#dynmTd_"+tmplSerno+"_"+num+"_"+tempRow+"_"+tempCol).show();
					$("#mrgRowGrp_"+tmplSerno+"_"+num+"_"+tempRow+"_"+tempCol).val("");
					$("#mrgColGrp_"+tmplSerno+"_"+num+"_"+tempRow+"_"+tempCol).val("");
				}
			});
			$(this).prop("checked", false);
		});
	}

	const fncSetTitle = function(tmplSerno, num, divn){
		
		var $chkTd = $("#dynmTbd_"+tmplSerno+"_"+num).find("input[type='checkbox']:checked"); 
		var chkCnt = $chkTd.length;
		
		if(chkCnt == 0){
			alert("선택된 셀이 없습니다.");
			return false;
		}
		
		$chkTd.each(function(idx){
			var curRow = $(this).attr("id").split("_")[3];
			var curCol = $(this).attr("id").split("_")[4];
			
			$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).removeClass("tbl_title tbl_subTitle");
			
			if(divn == "U"){
				$("#ttlVal_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val("");
			}else{
				var tempClass = "";
				if(divn == "M"){
					tempClass = "tbl_title";
				}
				if(divn == "S"){
					tempClass = "tbl_subTitle";
				}
				$("#dynmTd_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).addClass(tempClass);
				$("#ttlVal_"+tmplSerno+"_"+num+"_"+curRow+"_"+curCol).val(divn);
			}
			$(this).prop("checked", false);
		});
	}
	
	<%-- BGN : tmplDetailSetList에 생성되는 버튼들 --%>
	
	<%-- 템플릿 설정 요소 추가--%>
	$(document).on("click",".btn_tbl_set",function(e) {
		e.stopImmediatePropagation()
	    var detail = $(this).parent().siblings(".tbl_detail");
	    $(detail).slideToggle(200);
	});
	<%-- 템플릿 설정 위치변경 --%>
	$(document).on("click",".btn_move_set",function(e) {
		e.stopImmediatePropagation()
		fncMoveSet(this);
	});
	<%-- 템플릿 설정 요소 삭제--%>
	$(document).on("click",".btn_select_delete",function(e) {
		e.stopImmediatePropagation()
		fncDelSet(this);
	});
	<%-- 테이블 상세설정 생성--%>
	$(document).on("click",".btn_ok",function(e) {
		e.stopImmediatePropagation()
		fncAddDynmTbl($(this).data("tmplserno"),$(this).data("num"));
	});
	<%-- 테이블 상세설정 병합 --%>
	$(document).on("click",".btn_mgr_tbl",function(e) {
		e.stopImmediatePropagation()
		fncMrgDynmTbl($(this).data("tmplserno"),$(this).data("num"));
	});
	<%-- 테이블 상세설정 병합 해체--%>
	$(document).on("click",".btn_unmgr_tbl",function(e) {
		e.stopImmediatePropagation()
		fncUnmrgDynmTbl($(this).data("tmplserno"),$(this).data("num"));
	});

	<%-- 테이블 상세설정 타이틀 설정 --%>
	$(document).on("click",".btn_set_title",function(e) {
		e.stopImmediatePropagation()
		fncSetTitle($(this).data("tmplserno"),$(this).data("num"),$(this).data("divn"));
	});

	<%-- 테이블 상세설정 초기화 --%>
	$(document).on("click",".btn_reset_tbl",function(e) {
		e.stopImmediatePropagation()
		fncResetTbl($(this).data("tmplserno"),$(this).data("num"));
	});
	
	<%-- 테이블 상세설정 저장 --%>
	$(document).on("click",".btn_save_tbl",function(e) {
		e.stopImmediatePropagation()
		fncSaveTbl($(this).data("tmplserno"),$(this).data("num"));
	});
	<%-- BGN : tmplDetailSetList에 생성되는 버튼들 --%>
	<%-- END : tmplDetailSetList --%>
	
	
	<%-- 검색 초기화 --%>
	$("#btn_reset_pop").on("click", function(){
		for(var i = 0 ; i < document.defaultFrmPop.elements.length ; i++){
			var el = document.defaultFrmPop.elements[i];
			if($('#'+el.id).attr('type') == "hidden"){
				continue;
			}
			// 체크박스 초기화
			if($('#'+el.id).attr('type') == "checkbox"){
				$('#'+el.id).prop("checked", "");
				continue;
			}
			el.value = "";
		}
	});
});
</script>
<div class="pop_header">
    <h2>상세 템플릿 설정</h2>
     <button type="button" class="btn_pop_close pop_close"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content disflex" style="max-height: 850px;height:850px">
    <div class="tab wide left w70p pad_r15">
	        <ul class="tab_menu js_tmenu">
	        	<c:if test="${fn:length(cateCdList) gt 0 }">
	        		<c:forEach var="item" items="${cateCdList}" varStatus="status">
	        			<li id="tab_0<c:out value="${status.count}"/>" role="tab" aria-selected="<c:out value="${status.first ? 'true' : 'false' }"/>"  class="<c:out value="${status.first ? 'on' : '' }"/>" ><a href="javascript:void(0)"  data-tabdivn="<c:out value="${item.cdVal}"/>"><c:out value="${item.cdNm }"/></a></li>
	        		</c:forEach>
	        	</c:if>
				<li id="tab_03" role="tab" aria-selected="false"><a href="javascript:void(0)" data-tabdivn="favorit">즐겨찾기</a></li>
	        </ul>
	        <div class="search_box">
		    	<form:form modelAttribute="searchVO" name="defaultFrmPop" id="defaultFrmPop" method="post" onsubmit="return false;">
		    		<form:hidden path="currentPageNo"/>
					<form:hidden path="recordCountPerPage"/>
		    		<form:hidden path="tabDivn"/>
		    		<form:hidden path="popDivn"/>
			            <div class="search_basic">
			            	 <table>
						        <colgroup>
						            <col class="w10p">
						            <col class="w20p">
						            <col class="w20p">
						            <col class="w20p">
						            <col>
						        </colgroup>
						        <tbody>
						            <tr>
			                			<td><label>검색구분</label></td>
			                			<td>
							                <select id="schEtc01" name="schEtc01" data-tabdivn="TMCL01">
											</select>
											<select id="schEtc02" name="schEtc02" data-tabdivn="TMCL02" class="disno mar_l0">
											</select>
											<select id="schEtc03" name="schEtc03" data-tabdivn="favorit" class="disno mar_l0">
												<option value="">템플릿 유형</option>
												<c:if test="${fn:length(cateCdList) gt 0 }">
													<c:forEach var="item" items="${cateCdList }">
														<option value="<c:out value="${item.cdVal }"/>" <c:out value="${item.cdVal eq searchVO.schEtc03 ? 'selected=selected' : '' }"/>><c:out value="${item.cdNm }"/></option>
													</c:forEach>
												</c:if>
											</select>
										</td>
										<td>
											<select id="schEtc04" name="schEtc04" data-tabdivn="favorit" class="disno" disabled="disabled">
												<option value="">템플릿 타입</option>
											</select>
										</td>
										<td>
							                <select id="searchCondition" name="searchCondition">
							                    <option value="">전체</option>
							                    <option value="1">템플릿 설명</option>
							                    <option value="2">에디터 내용</option>
							                </select>
							            </td>
							            <td>
							                <input type="text" id="searchKeyword" name="searchKeyword" class="text">
							            </td>
			               			</tr>
			                	</tbody>
			                </table>
			                <button type="button" class="btn btn_reset" id="btn_reset_pop"><i class="xi-refresh"></i>초기화</button>
    						<button type="button" class="btn btn_search" id="btn_search_pop"><i class="xi-search"></i>검색</button>
			            </div>
		    	</form:form>
		    </div>
			<div class="popTbl"></div>
		</div>
	    <div class="right w30p" >
	    	<div style="display: flex;justify-content: space-between;">
	 	       <h4 class="md_tit" style="line-height: 35px; margin-bottom: 12px">
		        	템플릿 설정 
		        </h4>
	        	<button class="btn bd blue btn_pop_preview" ><i class="xi-desktop" style="vertical-align:-1px;"></i> 미리보기</button>
	    	</div>
	        <ul class="setList"></ul>
	        <div class="paging_wrap">
	            <div class="btn_right">
	            	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }">
	                	<a href="javascript:void(0);" class="btn blue" id="btn_pop_submit">확인</a>
	                </c:if>
	            	<a href="javascript:void(0);" class="btn gray btn_pop_close">닫기</a>
	            </div>
	        </div>
	    </div>
</div>