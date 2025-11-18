<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

	<%-- 컨텐츠 템플릿 체크시 배열에 담기--%>
	const fncPopChkAction = function(obj){
		
		if($(obj).prop("checked")){
	        $(obj).siblings(".count_area").find(".count_input").val("1")
	    }else{
	        $(obj).siblings(".count_area").find(".count_input").val("0")
	    }
		
		var tempObj = {};
		
		tempObj["chkDivn"] = "default";
		tempObj["seqNm"] = "tmplSerno";
		tempObj["dataNm"] = "data-tmplserno";
		tempObj["tmplSerno"] = $(obj).attr("data-tmplserno");
		tempObj["editrCont"] = $(obj).attr("data-editrcont");
		tempObj["tmplExpl"] = $(obj).attr("data-tmplexpl");
		tempObj["tmplCnt"] = 1;
		
		popChkArr = popChkArr.filter(function(val, idx, arr){
			return val["tmplSerno"] != tempObj["tmplSerno"];
		});

		if($(obj).prop("checked")){
			popChkArr.push(tempObj);
		}
	}
	
	<%-- 컨텐츠 템플릿 저장 --%>
	const fncPopSubmit = function(){
		
		if(popChkArr == null || popChkArr.length == 0){
			alert("선택된 템플릿이 없습니다.");
			return false;
		}
		
		var tempHtml = CKEDITOR.instances.editrCont.getData();
		
		for(var i=0; i < popChkArr.length; i++){
			tempHtml += popChkArr[i]["editrCont"];
		};
		
		CKEDITOR.instances.editrCont.setData(tempHtml);
		$('.js_popup').html("");
		view_hide('1');
	    $("#js_popup_bg").hide();
	}
	
	$('#btn_pop_close').click(function () {
		$('.js_popup').html("");
		view_hide('1');
	    $("#js_popup_bg").hide();
	});

	$('#btn_pop_submit').click(function () {
		fncPopSubmit();
	});

	$('.cont_tmpl_checkbox').click(function () {
		fncPopChkAction(this);
	});
});
</script>
<div class="tbl_top mar_b10">
    <div class="tbl_left">
        <i class="i_all"></i>
        <span>
            전체 : <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong> 건(<c:out value="1/${paginationInfo.totalPageCount}"/> Page)
        </span>
    </div>
    <div class="tbl_right">
    </div>
</div>
<div class="gallery_wrap ht580">
	<ul class="thum_list cont_tmpl_box">
		<c:choose>
			<c:when test="${not empty resultList}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li data-tmplcd="<c:out value='${result.tmplCd}'/>">
						<a href="javascript:void(0);">
							<input type="checkbox" id="chkbox_<c:out value='${result.tmplSerno }'/>" class="cont_tmpl_checkbox" data-tmplserno="<c:out value='${result.tmplSerno }'/>" data-editrcont="<c:out value='${result.editrCont }'/>">
				            <label for="chkbox_<c:out value="${result.tmplSerno}"/>">
							<figure class="thum_img">
				               <c:choose>
			                		<c:when test="${empty result.prvwFileSerno }">
			                			<img src="/ma/images/common/no_img.png" alt="image" class="noimage">
			                		</c:when>
			                		<c:otherwise>
			                			<img src="/tmplFile/getFileDown.do?tmplFileSerno=<c:out value='${result.prvwFileSerno}'/>&fileSeqo=0" alt="image" onerror="this.src='/ma/images/common/no_img.png';this.className='noimage';"> 
			                		</c:otherwise> 
			                	</c:choose>
							</figure>
							<div class="thum_txt">
								<div class="state blue mar_b5"><c:out value="${result.tmplCl}" /></div>
								<div class="state gray mar_b5"><c:out value="${result.tmplTp}" /></div>
								<div class="tit" ><c:out value="${result.tmplExpl}" /></div>
								<div class="date"><c:out value="${result.regDt}" /></div>
							</div>
							</label>
						</a>
					</li>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<li class="no-data">데이터가 없습니다.</li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
<div class="paging_wrap">
    <ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="popAdd" jsFunction="fncPageBoard"/>
	</ul>
    <div class="btn_right">
        <a href="javascript:void(0);" class="btn blue" id="btn_pop_submit">확인</a>
     	<a href="javascript:void(0);" class="btn gray" id="btn_pop_close">닫기</a>
    </div>
</div>