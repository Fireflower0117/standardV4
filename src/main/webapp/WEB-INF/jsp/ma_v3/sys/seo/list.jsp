<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/highcharts.js"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/clipboard.min.js"></script>
<style>
	<%--셀병합일때 호버효과 없애는 css --%>
	.data_tbl:not(.form) > tbody > tr:hover > td[rowspan]{background: transparent;}

	.faq_list dl:first-child dt a {
		justify-content: left;
	}
	<%--동그라미 --%>
	.radius {width: 17px;height: 17px;display: inline-block;border-radius: 100%;}

	.itagInit{position:initial !important;transform: initial !important;}
	.greenBk{border:3px solid #a4ebc1; background-color: #3bae6c;}
	.redBk{border:3px solid #ffcdcd; background-color: #ff4556;}
	.yellowBk{border:3px solid #ffe8ab; background-color: #fbbe19;}
	.legend_label{position:relative;margin-right:10px; padding-right:15px; margin-left:5px; color:#444; font-size:15px; letter-spacing: -0.2px; vertical-align: text-top;}
	.legend_label::after{position: absolute; right: 0; top: 50%; transform: translateY(-50%); width: 1px; height: 10px; background-color: #ccc; content: '';}
	.legend_label:last-child{margin-right: 0;padding-right: 0}
	.legend_label:last-child::after{display: none}

	<%--테이블안에 있는 상태 아이콘만 앵커효과 --%>
	td .redBk{cursor:pointer;}
	td .yellowBk{cursor:pointer;}
	
	<%-- 아이콘 --%>
	.msg_box i{vertical-align: top; margin-right:5px; font-size:17px;}

	.faq_list dl dt a > .txt{display: flex; width:100%;}
	.faq_list dl dt a > .txt > p{width:23%}
	.faq_list dl dt a > .txt > span{width: 20%}


	<%-- basic & board 수정 --%>
	<%-- 상태 --%>
	.faq_list dl dt span.states,
	.faq_list dl dt span.state{position: relative; top: unset; left: unset;display: inline-block; margin-left:5px; color: #fff;font-weight: 400;font-size: 15px;}
	.faq_list dl dt span.state{min-width: 30px;}
	.faq_list dl dt span.state.red{background: #f05f5f}
	.faq_list dl dt span.state.yellow{background:#f1c01a}

	.msg_box{width: 50%; margin: 0 auto; padding: 25px 45px 25px 90px;}
	.msg_box::before{position: absolute; left:25px; top: 15px; font-family:'Xeicon'; font-size:40px; color:#828282; content:'\e9ab';}
	.msg_box p{padding-top:0; font-size:15px; word-wrap:break-word; word-break: keep-all;}

	.board_top{display: flex; justify-content: space-between; align-items: flex-end;}

	.lg_tit{padding-top:0; font-size:20px; color:#2185d0;}
	.lg_tit::before,
	.lg_tit::after {display:none;}
	.md_tit{margin-top:30px; margin-bottom: 0; padding-left:20px; font-size:18px; color:#575757;}
	.md_tit::before{position: absolute; left:0; top:4px; width:10px;height:10px;border:3px solid #21ab5e; content:'';background: #fff;}

	.faq_list dl dt{border-color:#848484;}
	.faq_list dl dt.danger{background: #fee6e8}
	.faq_list dl dt.danger a,
	.faq_list dl dt.danger i{color:#fa495d;}
	.faq_list dl dt.warning{background: #fdface}
	.faq_list dl dt.warning a{color:#dba000;}
	.faq_list dl dt.warning i{color:#fbbe19;}
	.faq_list dl dt.success{background:#d8f8e5}
	.faq_list dl dt.success a,
	.faq_list dl dt.success i{color:#21ab5e;}
	.faq_list dl dt span{top: 15px;}
	.faq_list dl dt i{top:14px;}
	.faq_list dl dd .msg{margin-bottom:6px; color:#424242; font-size:17px}
	.faq_list dl dd .msg:last-child{margin-bottom:0}

	<%-- 차트 & 데이터 --%>
   .score_area{display: flex; align-items: center; justify-content: center;}
   .chart_data{display: flex; gap: 20px; position: relative; width: 37%; margin-left:60px; padding-left:60px}
   .chart_data::before{position: absolute;left:0;top:50%; transform: translateY(-50%); width:1px; height:150px; background: #ddd; content:'';}
   .chart_data .data{flex:1; position:relative; height:155px; padding: 60px 65px 0 25px;border-radius: 5px 15px 5px 15px; color:#fff; line-height: 1.2}
   .chart_data .data .txt{font-size:18px; font-weight: 500; letter-spacing: -0.2px;}
   .chart_data .data .num{font-size:28px; font-weight: 700; letter-spacing: 0.4px; vertical-align: bottom;}
   .chart_data .data .eng{display: block; margin-bottom:7px; opacity: 0.8; font-size:14px;}
   .chart_data .data .ic{position: absolute; left: 25px; top: 10px; font-size:35px;}
   .chart_data .data.success{background: #23c19b;}
   .chart_data .data.warning{background: #ffa800;}
   .chart_data .data.danger{background: #ff5249;}

</style>
<script type="text/javascript">
<%--url 패턴 처리--%>
const validUrl = function(url){
	const pattern = /^(https?:\/\/)?((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|((\d{1,3}\.){3}\d{1,3}))(\/[-a-z\d%_.~+]*)*(\?[;&a-z\d%_.~+=-]*)?(#[-a-z\d_]*)?$/i;
	const lengthLimit = /^.{0,39}$/;
	return pattern.test(url) && lengthLimit.test(url);
}
//차트 초기화용 변수
let chart1 =null;
//클립보드 함수 중복실행 방지 변수
let clipboardHandlerAttached = false;

$(function(){
	
	<%--상세화면 리스트--%>
	$(document).on("click",".optSubList",function(){
		if($(this).hasClass("greenBk")){
			return;
		}
		let optType = $(this).attr("data-tableId");
		
		$(".loading_wrap").show();
		
		$("#optType").val(optType);
		$("#seoSerno").val($("#seoSernoTemp").val());
		
		$(".display_view1").html("");
		$.ajax({
			method: "POST",
			url: "subList.do",
			data: $("#defaultFrm").serialize(),
			dataType: "html",
			success: function(data) {
				if (!clipboardHandlerAttached) {
			        attachClipboardHandlerToPopup();
			        clipboardHandlerAttached = true;
			    }
				
				$("#display_view1").html(data);
				$(".loading_wrap").hide();
			    let top = ($(window).height() - $("#display_view1").height()) / 2;
			    $("#js_popup_bg").show();
			    $("#display_view1").addClass("on").css({'width' : '1600px', 'visibility': 'visible', 'position': 'fixed', 'top': top,'left' : '10%' ,'z-index': 5500 });
			}
		});
	});
	
	<%--상세화면 단건--%>
	$(document).on("click",".optView",function(){
		if($(this).hasClass("greenBk")){
			return;
		}
		let optType = $(this).attr("data-tableId");
		
		$(".loading_wrap").show();
		
		$("#optType").val(optType);
		$("#seoSerno").val($("#seoSernoTemp").val());
		
		$(".display_view1").html("");
		$.ajax({
			method: "POST",
			url: "view.do",
			data: $("#defaultFrm").serialize(),
			dataType: "html",
			success: function(data) {
				
				if (!clipboardHandlerAttached) {
			        attachClipboardHandlerToPopup();
			        clipboardHandlerAttached = true;
			    }

				$("#display_view1").html(data);
				$(".loading_wrap").hide();
			    let top = ($(window).height() - $("#display_view1").height()) / 2;
			    $("#js_popup_bg").show();
			    $("#display_view1").addClass("on").css({'visibility': 'visible', 'position': 'fixed', 'top': top,'left' : '12%' ,'z-index': 5500 });
			}
		});
		
	});
	
	<%--레이어 팝업 배경 클릭시 팝업닫기 기능--%>
	 $('#js_popup_bg').click(function () {
        $('.js_popup').removeClass("on").css('visibility', 'hidden');
        $(this).hide();
    });
	
	<%--검색--%>
	$("#btn_srch").on("click", function(){
		if(wrestSubmit(document.defaultFrm)){
			if(validUrl($("#defaultFrm #srchKeyword").val())){
				$(".loading_wrap").show();

				if(chart1 != null){
					chart1.destroy();
				}

				$(".tbl").empty();
				$.ajax({
					method: "POST",
					url: "addList.do",
					data: $("#defaultFrm").serialize(),
					dataType: "html",
					success: function(data) {
						//fncLoadingEd();
						$(".tbl").html(data);
						$(".loading_wrap").hide();
					}
				});
			}else{
				alert("정상적인 URL주소가 아닙니다.");
				return false;
			}
		}
	});

	<%--검색 엔터--%>
	$("#srchKeyword").keydown(function(e){
		
		if(wrestSubmit(document.defaultFrm)){
			if (e.keyCode === 13) {
				e.preventDefault();
				if(wrestSubmit(document.defaultFrm)){
					if(validUrl($("#defaultFrm #srchKeyword").val())){
						$(".loading_wrap").show();

						if(chart1 != null){
							chart1.destroy();
						}

						$(".tbl").empty();
						e.preventDefault();
						$.ajax({
							method: "POST",
							url: "addList.do",
							data: $("#defaultFrm").serialize(),
							dataType: "html",
							success: function(data) {
								$(".tbl").html(data);
								$(".loading_wrap").hide();
							}
						});
					}else{
						alert("정상적인 URL주소가 아닙니다.");
						return false;
					}
				}
			}
		}
	});
});

let useYn = 'Y';
<%-- 기존 다운로드 --%>
const fncExcelDown = function(){
	
	if(useYn === "Y"){
		useYn = 'N';
		fncPageBoard("view", "excelDownload.do");
	    $("#defaultFrm").attr("onsubmit","return false;");
		setTimeout(function() { // Code here 
			useYn = 'Y';
		}, 3000);
	}else{
		alert("이미실행중입니다");
	}
	
}	

<%-- 레이어팝업 닫기 함수  --%>
function view_hide(popName) {
    $("#display_view" + popName).removeClass("on").css('visibility', 'hidden');
    $("#js_popup_bg").hide();
    return false;
}

<%-- 열병합 함수  --%>
function mergeCells(tableId,tdIndex) {
  var $rows = $(tableId + " tbody tr");
  var lastValue = null;
  var rowspan = 1;
  var firsrtTd = null;
  
  $rows.each(function(index) {
    var $td = $(this).find("td:eq("+tdIndex+")");
    var currentValue = $td.text();
    
    
    if (lastValue === currentValue) {
      $(this).find("td:eq("+tdIndex+")").hide();
      rowspan++;
    } else {
	  if (rowspan > 1 && index !== 0) {
	      firsrtTd.attr("rowspan", rowspan);
	  }
      firsrtTd = $td;
      rowspan = 1;
    }
    
    if(index === ($rows.length-1) ){
	    if (rowspan > 1) {
	    	firsrtTd.attr("rowspan", rowspan);
	    }
    }

    lastValue = currentValue;
  });
}

<%--클립보드 복사 함수--%>
function attachClipboardHandlerToPopup() {
	// 팝업 내용에 대한 클립보드 핸들러 연결
    var clipboard = new ClipboardJS('.copyButton', {
        text: function(trigger) {
            var rowIndex = $(trigger).data('row-index');
            var copyText = $('#copyText' + rowIndex).text().trim();
            return copyText;
        }
    });

    clipboard.on('success', function(e) {
        alert('텍스트가 클립보드에 복사되었습니다.');
        e.clearSelection();
    });
}

//상세화면 페이징 이동 함수  custom type으로 가면 쓸때없는 변수 설정안해도 되는데 문제는 css가 없어서 따로 css잡아줘야되서 일부러 popAdd type 사용
const customPageBoard = function(a,b,page){
	
	$("#defaultFrmPop #currentPageNo").val(page);
	
	$.ajax({
		method : "POST",
		url : "subAddList.do",
		data : $("#defaultFrmPop").serialize(),
		dataType : "html",
		success : function(data) {
			$(".popTbl").html(data);
			
			let top = ($(window).height() - $("#display_view1").height()) / 2;
		    $("#display_view1").addClass("on").css({ 'top': top, });
			
		}
	});
}
</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<input type="hidden" name="domainUrl" id="domainUrl" value="" />
		<input type="hidden" name="seoSerno" id="seoSerno" value="" />
		<input type="hidden" name="optType" id="optType" value="" />
		<table>
			<caption>구분</caption>
			<colgroup>
					<col style="width:10%">
					<col>
					<col style="width:10%">
					<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>URL</label></td>
					<td colspan="3">
						<form:select path="searchCondition" title="구분선택" cssClass="w150">
							<form:option value="1" label="구글SEO"/>
							<form:option value="2" label="네이버SEO"/> 
						</form:select>
						<form:input path="searchKeyword" id="srchKeyword" placeholder="url를 입력해주세요." maxlength="100" required="true" value="https://www.kps.co.kr/index.do"/>
					</td>
				</tr>
			</tbody>
		</table>
          	<a href="javascript:void(0);" id="btn_srch" class="btn btn_search"><i class="xi-search"></i>검증</a>
	</form:form>
</div>
<div class="tbl"></div>
<!--팝업영역  -->
<div id="display_view1" class="layer_pop js_popup" style="width: 1500px;"></div>
<div class="popup_bg" id="js_popup_bg"></div>
