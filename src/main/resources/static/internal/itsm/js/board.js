/* jshint esversion: 6 */
$(document).ready(function(){
	
	//등록폼
	$("#btn_write").click(function(){
		fncPageBoard('write','insertForm.do');
		return false;
	});
	
	//검색
	$("#btn_search").click(function(){
		fncRecordCountPerPageSet();
		fncAddList(1);
		return false;
	});
	
	//수정폼
	$("#btn_update").click(function(){
		fncPageBoard('update','updateForm.do');
		return false;
	});
	
	//목록
	$("#btn_list").click(function(){
		fncPageBoard('list','list.do');
		return false;
	});
	
	//삭제 액션
	$("#btn_del").click(function(){
		itsmFncProc('delete');
		return false;
	});
	
	//상세
	$("#btn_view").click(function(){
		fncPageBoard('view','view.do');
		return false;
	});
	
	//검색 엔터 체크
	$("#searchKeyword").keydown(function(e){
		if (e.keyCode == 13) {
			fncAddList(1);
			return false;
		}
	});
	
	//inputBox enter키 방지
	$('input[type="text"]').keydown(function() {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	});

});
/* 목록 호출 */
function fncAddList(pageIdx) {
	fncPageBoard('addList','addList.do',pageIdx);
}



var process = "N";
/* 구분,url,(currentPageNo && 일련번호),일련번호명 */
var fncPageBoard = function(){
	var getBoard = arguments;
	var gubun="";
	var url="";
	var idx= "";
	var seqVal= [];
	var seqNm=[];
	var wth="800";
	var het="600";
	if(getBoard.length > 1){
		switch (getBoard.length) {
	 		case 2: gubun = getBoard[0]; url = getBoard[1];break;
	 		case 3: gubun = getBoard[0]; url = getBoard[1]; idx = getBoard[2];break;
	 		case 4: gubun = getBoard[0]; url = getBoard[1]; seqVal = getBoard[2].split(','); seqNm = getBoard[3].split(',');break;
	 		case 5: gubun = getBoard[0]; url = getBoard[1]; seqVal = getBoard[2].split(','); seqNm = getBoard[3].split(','); wth = getBoard[4]; break;
	 		case 6: gubun = getBoard[0]; url = getBoard[1]; seqVal = getBoard[2].split(','); seqNm = getBoard[3].split(','); wth = getBoard[4]; het = getBoard[5]; break;
	 	}
	}
	switch (gubun) {
	
	  case 'write'  :  if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
		  			   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self" , "onsubmit" : ""}).submit(); //등록폼
					   break;
					   
	  case 'addList':  $("#currentPageNo").val(idx);
	  				   fncRecordCountPerPageSet();
					   $.ajax({  method: "POST",  url: url,  data : $("#defaultFrm").serialize(), dataType: "html", success: function(data) {$(".tbl").html(data);
					   }});//목록호출
					   break;
					   
	  case 'view'   :  if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
					   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();//상세
		  			   break;
		  			   
	  case 'update' :  if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
	  				   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();//수정폼
	                   break;
	                   
	  case 'del'    :  if(confirm("삭제하시겠습니까?")){
		  			   if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
					   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();//삭제
	  				   }
		  			   break;
		  			   
	  case 'list'   :  if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
					   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();//목록
			      	   break;
	  
	 case 'search'  :  if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
	  				   if(idx != ''){$("#currentPageNo").val(idx)};
	  				   fncSearchGet();
		  			   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();//목록
	              	   break;
	              	               	   
	  case 'submit' :  if(process == "Y"){ alert("처리중입니다. 잠시만 기다려주세요."); return false;}//등록 액션
					   //if(wrestSubmit(document.defaultFrm)){ 
					      process = "Y" 
						  $("#defaultFrm").removeAttr("enctype");
						  $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
					   //}
					   break;
	  case 'submit2' : $.ajax({method: "POST", url: url, data : $("#defaultFrm").serialize(), dataType: "json", success: function(data) { alert(data.type+"되었습니다.");fncPageBoard('comment', 'getComment.do'); }});
					   break;				   
	  case 'pop':  	   $("#currentPageNo").val(idx);
					   if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
					   $.ajax({  method: "POST",  url: url,  data : $("#defaultFrm").serialize(), dataType: "html", success: function(data) {$("#popup").html(data);
					   if($("#totCnt").length != 0){$("#totCnt").html($("#totalRecordCount").html());}}});//목록호출
					   break;	
	  case 'comment' : $.ajax({method: "POST", url: url, data : $("#defaultFrm").serialize(), dataType: "html", success: function(data) { $(".reply_area").html(data); }});
					   break;	   
	
	  default       : alert("유효하지 않은 값입니다.");return false; break;
	}
	
}


var calByte = {
	getByteLength : function(s) {

		if (s == null || s.length == 0) {
			return 0;
		}
		var size = 0;

		for ( var i = 0; i < s.length; i++) {
			size += this.charByteSize(s.charAt(i));
		}

		return size;
	},
		
	cutByteLength : function(s, len) {

		if (s == null || s.length == 0) {
			return 0;
		}
		var size = 0;
		var rIndex = s.length;

		for ( var i = 0; i < s.length; i++) {
			size += this.charByteSize(s.charAt(i));
			if( size == len ) {
				rIndex = i + 1;
				break;
			} else if( size > len ) {
				rIndex = i;
				break;
			}
		}

		return s.substring(0, rIndex);
	},

	charByteSize : function(ch) {

		if (ch == null || ch.length == 0) {
			return 0;
		}

		var charCode = ch.charCodeAt(0);

		if (charCode <= 0x00007F) {
			return 1;
		} else if (charCode <= 0x0007FF) {
			return 2;
		} else if (charCode <= 0x00FFFF) {
			return 3;
		} else {
			return 4;
		}
	}
};

// ROW병합
$.fn.rowspan = function(colIdx) {
	 return this.each(function(){
		 console.log(colIdx);
  var that;
  $('tr', this).each(function(row) {
  $('td:eq('+colIdx+')', this).each(function(col) {
      if ($(this).html() == $(that).html()) {
        rowspan = $(that).attr("rowSpan");
        if (rowspan == undefined) {
  
          $(that).attr("rowSpan",1);
          rowspan = $(that).attr("rowSpan");
        }
        rowspan = Number(rowspan)+1;
        $(that).attr("rowSpan",rowspan); 
        $(this).hide(); 
      } else {
        that = this;
      }
      that = (that == null) ? this : that; 
  });
 });

 });
}

// 유효성 null검사
function nullCheck(val){
	val = $.trim(val);
    if(val === "" || val === null || val === undefined){
        return true;
    }else{
        return false;
    }
}


/*
func 	 : 성공할 경우 실행 함수
errFunc  : 실패할 경우 실행 함수
compFunc : 성공, 실패 상관 없이 완료될 경우 실행 함수
*/
function fncAjax(url, data, dataType, async, querySelector, func, errFunc, compFunc){
	$.ajax({
		url      : url,
		type     : "post",
		data     : data,
		dataType : dataType,
		async    : (async === false ? false : true),
		success  : function(data){
			if(dataType.toLowerCase() === "html"){
				$(querySelector).html(data);
			}
			if(func !== undefined && typeof func === "function"){
				func(data);
			}
		},
		error   : function(){
			if(errFunc !== undefined && typeof errFunc === "function"){
				errFunc();
			} else {
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		},
		complete : function(){
			if(compFunc !== undefined && typeof compFunc === "function"){
				compFunc();
			}
			return false;
		}
	})
}

/* 로딩 시작 - 파라미터 id가 없을시 default로 전체 화면 로딩바로 변경*/
function fncLoadingStart(id){
	let divId = id || "loadingDiv";
	setTimeout(function(){
		$("#"+divId).css("display","block");
	},1)
}

/* 로딩 종료 - 파라미터 id가 없을시 default로 전체 화면 로딩바로 변경*/
function fncLoadingEnd(id){
	let divId = id || "loadingDiv";
	$("#"+divId).hide();
	$("#"+divId).css("display","none");
}

/*
	20220711 추가 - 구연호
	addList의 recordCountPerPage_tbl_right를 defaultForm 내의 recordCountPerPage에 할당
 */
function fncRecordCountPerPageSet(){
	if($('#recordCountPerPage_tbl_right').val()) {
		$('#recordCountPerPage').val($('#recordCountPerPage_tbl_right').val());
   	}
   	if(! $('#currentPageNo').val()) {
   		$('#currentPageNo').val('1')
   	}
   	
}

/* 검색조건 GET */
function fncSearchGet(){
	$("INPUT:TEXT,SELECT[ID^=_]").each(function(){
		let inputId = $(this).prop("id").replace("_","");
		let inputValue = $(this).val();
		$("#"+inputId).val(inputValue);
	});
	
	fncArrSearchGet("CHECKBOX");
	fncArrSearchGet("RADIO");
	
	function fncArrSearchGet(gubun){
		let chkArr = [];
		let chkSet = [];
		$("INPUT:"+gubun+"[ID^=_]:CHECKED").each(function(){
			let inputName = $(this).prop("name");
			chkArr.push(inputName);
			chkSet = [...new Set(chkArr)];
		});
		
		for (let i = 0, j = chkSet.length;  i < j; i++) {
			let chkId = chkSet[i];
			let chkVal = "";
			$("INPUT:"+gubun+"[NAME="+chkId+"]:CHECKED").each(function(){
				chkVal += ","+$(this).val();
			});
			if(chkVal != ""){
				chkVal = chkVal.substring(1);
				$("#"+chkId.replace("_","")).val(chkVal);
			}
		}
	}
	
}

/* 유효성 메시지 */
const alertMsg = function(mId, color, msg, dis){
	var display = "inline";
	var margin = "5px;";
	if(dis != null){
		if(dis == "B"){
			display = "block";
			margin = "";
		}
		if(dis == "IB"){
			display = "inline-block";
		}
	}

	$("#msg_"+mId).remove();
	if(color!=""&&color!=null&&msg!=""&&msg!=null){
		var msgHtml = '<span class="text" id="msg_'+mId+'" style="color:'+color+';display:'+display+';margin-left:'+margin+';font-weight: bold;">'+msg+'</span>';
		$("#"+mId).parent().append(msgHtml);
	}
};



/* 엑셀 다운로드 통합*/
function fncExcel(length){

	if(nullCheck(length) || length == 0 ) {
		alert("조회된 목록이 없습니다.");
		return false;
	} else {
		fncLoadingStart();
		$.fileDownload("downExcel.json", {
			httpMethod : "POST",
			data : $("#defaultFrm").serialize(),
			successCallback : function(url){
				fncLoadingEnd();
				return false;
			},
			failCallback : function(responseHtml, url, error){
				alert("엑셀 다운로드가 실패하였습니다");
				fncLoadingEnd();
				return false;
			}
		});
	}

}



/* 표준안 ajax 공통 함수 */
// 액션 처리 (등록, 수정, 삭제)
const itsmFncProc= function(procType,url, func, errFunc, compFunc){
	$(".msg_only").remove();
	let procTypeV = ""
	if (procType === 'insert'){
		procTypeV = 'post';
	}else if (procType === 'update'){
		procTypeV = 'patch';
	}else if (procType === 'delete'){
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$('#currentPageNo').val('1');
		procTypeV = 'delete';
	}
	let urlurl = 'proc'
	if(url != null) {
		urlurl = url;
	}
	$.ajax({
		type 		: procTypeV
		,url 		: urlurl
		,data 		: $('#defaultFrm').serialize()
		,dataType 	: 'json'
		,success 	: function(data) {

			if(func !== undefined && typeof func === "function"){
				func(data);
			} else{
				alert(data.message);

				// 폼 속성 설정 및 제출
				$("#defaultFrm").attr({"action" : data.returnUrl, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
			}

		}
		,error		: function (xhr, status, error) {

			// 로그인 세션 없는 경우
			if (xhr.status == 401) {
				window.location.reload();
			}

			if(errFunc !== undefined && typeof errFunc === "function"){
				errFunc();
			} else{
				$('.error_txt').remove();
				let errors = xhr.responseJSON;

				// 오류 메세지 출력
				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					for (let i = 0; i < errors.length; i++) {
						let e = errors[i];

						// List 오류
						if(e.codes.some(item => item.includes('java.util.List'))){
							alert(e.defaultMessage);

							// 일반 오류
						} else{
							let html = ''
							html += '<strong id="msg_'+e.field+'" class="msg_only"><font color="red">&nbsp;'+e.defaultMessage+'</font></strong>';
							$('#' + e.field).after(html);
						}

					}
				}
			}
		}
		,beforeSend : function(){
			fncLoadingStart();
		}
		,complete 	: function(){

			fncLoadingEnd();

			if(compFunc !== undefined && typeof compFunc === "function"){
				compFunc();
			}
			return false;
		}
	});
}

/* noData 자동 colspan처리 */
const itsmFncColLength = function(){
	$("colgroup").each(function(idx){
		$(this).nextAll('tbody:first').find(".no_data").attr("colspan", $(this).children("col").length);
	});
};