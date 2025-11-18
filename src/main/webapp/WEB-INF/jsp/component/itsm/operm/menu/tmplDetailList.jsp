<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">   
$(document).ready(function(){

	const fncPopChkAction = function(obj){
		
		var tmplSerno = $(obj).data("tmplserno");
		if($(obj).prop("checked")){
			$(obj).siblings(".count_area").find(".count_input").val("1")
	    }else{
	    	$(obj).siblings(".count_area").find(".count_input").val("0")
	    }
		
		var tempObj = {};
		
		tempObj["chkDivn"] = "default";
		tempObj["seqNm"] = "tmplSerno";
		tempObj["dataNm"] = "data-tmplserno";
		tempObj["tmplSerno"] = tmplSerno;
		tempObj["editrCont"] = $(obj).data("editrcont");
		tempObj["tmplExpl"] = $(obj).data("tmplexpl");
		tempObj["tmplCnt"] = 1;
		
		popChkArr = popChkArr.filter(function(val, idx, arr){
			return val["tmplSerno"] != tempObj["tmplSerno"];
		});

		if($(obj).prop("checked")){
			popChkArr.push(tempObj);
		}
	}
	
	var tmplTotalCnt = 0;
	const fncPopSetAciton = function(){
		
		var setTotalCnt = 0;
		if(popChkArr == null || popChkArr.length == 0){
			alert("선택된 템플릿이 없습니다.");
			return false;
		}else{
			for(var i=0; i < popChkArr.length; i++){
				setTotalCnt += Number(popChkArr[i]["tmplCnt"]);
			}
		}
		
		$.ajax({
			method : "POST",
			url : "popSetAciton",
			data : {mapArr : popChkArr, tmplTotalCnt : tmplTotalCnt},
			dataType : "HTML",
			success : function (data){
				$(".setList").append(data);
				tmplTotalCnt += setTotalCnt;
				popChkArr = [];
			},error : function(xhr, status, error){
				 if (xhr.status == 401) {
					window.location.reload();
				 }
				 alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		}).done(function(){
			$("#display_view1 input[type='checkbox']").each(function(){
				$(this).siblings(".count_area").find(".count_input").val("0");
				$(this).prop("checked", false)
			});
		});
	}

	<%-- 즐겨찾기 추가/해제 --%>
	const fncFavoritAction = function(obj){
		
		var tmplSerno = $(obj).siblings("input[type='checkbox']").data("tmplserno");
		var useYn;
		var procType;
		
		if($(obj).hasClass("on")){
			$(obj).removeClass("on");
			useYn = "N";
			procType = 'delete';
		}else{
			$(obj).addClass("on");
			useYn = "Y";
			procType = 'post';
		}
		$.ajax({
			method : procType,
			url : "fvrtProc",
			data : {tmplSerno : tmplSerno,  useYn : useYn},
			error : function(xhr, status, error){
				 if (xhr.status == 401) {
					window.location.reload();
				 }
				 alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		});
	}
	
	<%-- 컨텐츠 선택 수량 제어 --%>
	const fncCountAction = function(obj){
		
		var tmplSerno = $(obj).closest(".count_area").siblings("input[type='checkbox']").attr("data-tmplSerno");
		var calcDivn = $(obj).attr("data-calc");
		var $targetCount = $(obj).siblings(".count_input");
		var currentVal = $targetCount.val();
		
		if(calcDivn == "plus"){
			$targetCount.val(Number(currentVal) + 1);
		}
		
		if(calcDivn == "minus"){
			if (currentVal > 1) {
				$targetCount.val(Number(currentVal) - 1);
		    }else{
		    	alert("최소 수량입니다.");
		    }
		}
		for(var i=0; i< popChkArr.length; i++){
			if(popChkArr[i]["tmplSerno"] == tmplSerno){
				popChkArr[i]["tmplCnt"] = $targetCount.val();
			}
		}
	}
	
	
	

	<%-- 템플릿 체크시 --%>
	$('.cont_tmpl_checkbox').on("click",function () {
		fncPopChkAction(this);
	});

	<%-- 템플릿 설정 추가 --%>
	$('#btn_check_add').on("click",function () {
		fncPopSetAciton();
	});

	<%-- 즐겨찾기 추가/해제--%>
	$('.btn_favorite').on("click",function () {
		fncFavoritAction(this);
	});
	
	<%-- 컨텐츠 선택 수량 증가 --%>
	$('.btn_plus').on("click",function () {
		fncCountAction(this);
	});
	
	<%-- 컨텐츠 선택 수량 감소 --%>
	$('.btn_minus').on("click",function () {
		fncCountAction(this);
	});
});
</script>
<div class="tbl_top mar_b10">
    <div class="tbl_left">
        <i class="i_all"></i>
        <span>
            전체 : <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong> 건(<c:out value="1/${paginationInfo.totalPageCount}"/>  Page)
        </span>
    </div>
    <div class="tbl_right">
    </div>
</div>
<div class="gallery_wrap" style="height: 550px;">
	<ul class="thum_list">
		<c:choose>
			<c:when test="${not empty resultList}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li data-tmplcd="<c:out value='${result.tmplCd}'/>" class="ht260">
						<a href="javascript:void(0);">
							<input type="checkbox" id="chkbox_<c:out value='${result.tmplSerno }'/>" class="cont_tmpl_checkbox" data-tmplSerno="<c:out value='${result.tmplSerno }'/>" data-editrcont="<c:out value='${result.editrCont}'/>" data-tmplexpl="<c:out value="${result.tmplExpl}"/>">
							<button class="btn_favorite ${not empty result.fvrtSerno ? 'on' : '' }" data-fvrtserno="<c:out value='${result.fvrtSerno }'/>">즐겨찾기</button>
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
									<div class="date"><c:out value="${result.regDt}" />
									</div>
								</div>
							</label>
							<div class="count_area">
						    	<button class="btn_minus" data-calc="minus">-</button>
								<input type="number" value="0" class="count_input" readonly="readonly">
								<button class="btn_plus" data-calc="plus">+</button>
							</div>  
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
    <div class="paging">
        <ui:pagination paginationInfo="${paginationInfo}" type="popAdd" jsFunction="fncPageBoard"/>
    </div>
    <div class="btn_right">
    	<a href="javascript:void(0);" class="btn bd blue" id="btn_check_add" >추가</a>
    </div>
</div>  
