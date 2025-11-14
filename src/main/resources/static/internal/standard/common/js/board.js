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
		fncPageBoard('search','list.do',1);
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
		fncProc('delete');
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
			e.preventDefault();
			fncPageBoard('search', 'list.do', 1);
		}
	});
	$("#_searchKeyword").keydown(function(e){
		if (e.keyCode == 13) {
			e.preventDefault();
			fncPageBoard('search', 'list.do', 1);
		}
	});
	// 검색초기화
	$("#btn_reset").click(function(){
		for(var i = 0 ; i < document.defaultFrm.elements.length ; i++){
			var el = document.defaultFrm.elements[i];
			if(el.id === "searchStartDate" || el.id === "searchEndDate"){
				continue;
			}
			if($('#'+el.id).attr('type') == "hidden"){
				continue;
			}
			// 체크박스 초기화
			if($('#'+el.id).attr('type') == "checkbox"){
				$('#'+el.id).prop("checked", "");
				continue;
			}
			// 라디오 박스 초기화 (처음 값 선택)
			if($('#'+el.id).attr('type') == "radio"){
				$('input:radio[name='+el.name+']').eq(0).attr("checked", "checked");
				continue;
			}
			el.value = "";
		}
		
		// 페이지별 출력 건수 초기화
		$('#recordCountPerPage_board_right').val('10');
	});
	
});

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
	  case 'addList':  fncSearchInHash(idx); 
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
	  				   if(idx != ''){$("#currentPageNo").val(idx)}
		  			   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();//목록
	              	   break;
	  case 'search' :  if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
	  				   if(idx != ''){$("#currentPageNo").val(idx)};
	  				   fncSearchGet();
		  			   $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();//목록
	              	   break;
	  case 'submit' :  // if(process == "Y"){ alert("처리중입니다. 잠시만 기다려주세요."); return false;}//등록 액션
					   if(wrestSubmit(document.defaultFrm)){
					      process = "Y" 
						  $("#defaultFrm").removeAttr("enctype");
						  $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
					   } // TODO 금동 수정
					   break;
	  case 'fileSubmit' :  if(process == "Y"){ alert("처리중입니다. 잠시만 기다려주세요."); return false;}//등록 액션
						   if(wrestSubmit(document.defaultFrm)){
						      process = "Y" 
							  fileFormSubmit("defaultFrm", idx, function () {
					        	 $("#defaultFrm").removeAttr("enctype");
							 	 $("#defaultFrm").attr({"action" : url, "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
					         });
						   } // TODO 금동 수정
						   break;
	  case 'pop'    :  $("#currentPageNo").val(idx);
					   if(seqNm.length > 0 && seqVal.length > 0){ for (var i = 0; i < seqNm.length; i++) { $("#"+seqNm[i]).val('');$("#"+seqNm[i]).val(seqVal[i]); } }
					   $.ajax({  method: "POST",  url: url,  data : $("#defaultFrm").serialize(), dataType: "html", success: function(data) {$("#popup").html(data);
					   if($("#totCnt").length != 0){$("#totCnt").html($("#totalRecordCount").html());}}});//목록호출
					   break;
	 case 'popAddList':  fncSearchInHash(idx); 
					   fncRecordCountPerPageSet();
					   $.ajax({  method: "POST",  url: url,  data : $("#defaultFrmPop").serialize(), dataType: "html", success: function(data) {$(".popTbl").html(data);
					   }});//목록호출
					   break;
	  default       : alert("유효하지 않은 값입니다.");return false; break;
	}
}

// 액션 처리 (등록, 수정, 삭제)
/*
 * formData 	: 비어있는경우 #defaultFrm
 * func 	: 성공할 경우 실행 함수
 * errFunc  : 실패할 경우 실행 함수
 * compFunc : 성공, 실패 상관 없이 완료될 경우 실행 함수
*/
const fncProc = function(procType, formData, func, errFunc, compFunc){
	
	let httpType = '';
	
	if (procType === 'insert'){
		httpType = 'post';
	}else if (procType === 'update'){
		httpType = 'patch';
	}else if (procType === 'delete'){
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$('#currentPageNo').val('1');
		httpType = 'delete';
	}
	
	$.ajax({
		 type 		: httpType
		,url 		: 'proc'
		,data 		: (!formData ? $('#defaultFrm').serialize() : formData)
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
						    $('#' + e.field).parent().append('<p class="error_txt">' + e.defaultMessage + '</p>');
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

//인쇄 팝업 호출
function fncOpenPrint(){
	window.open('print.do','print_popup', 'width=1050, height=1120, left=500, status=no, resizable=no, scrollbars=yes');return false;
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
		error   : function(xhr, status, error){
			if(errFunc !== undefined && typeof errFunc === "function"){
				errFunc();
			} else {
				if (xhr.status == 401) {
			  		window.location.reload();
				} else{
					alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
				}
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

function fncSetToday(id){
	var today = new Date();
	$("#"+id).val(today.getFullYear() + "." + addZero((today.getMonth()+1),2) + "." + addZero(today.getDate(),2));
}

function addZero(str,len){
	var returnStr = "";
	str = String(str);
	if(str.length < len){
		for(var i = str.length ; i < len ; i++){
			returnStr += "0";
		}
		return returnStr + str;
	}else{
		return str;
	}
}
function fncBytesCheck(name) {
	var strVal = $("#"+name).val();
	
	var strLen = strVal.length;
	
	var maxSize = $("#"+name).attr('maxlength');
	
	var rByte = 0;
	var rLen = 0;
	var oneChar = "";
	
	for(var i=0; i<strLen; i++) {
		oneChar = strVal.charAt(i);
		
		if(escape(oneChar).length > 4) {
			rByte += 2;
		} else {
			rByte++;
		}
		
		if(rByte > maxSize){
			alert("입력 초과입니다.");
			return true;
		}
		
	}
	return false;
}

// 검색창 - 해시값 입력
function fncSearchInHash(idx){
	
	let hash = decodeURI(location.hash).replace("#", "");
	var currentPageNo = idx;

	//페이지 이동시에는 페이지값 변경
	//첫 진입 or 새로고침 할 때 페이지값 동일
	if(idx == $("#currentPageNo").val()){
		currentPageNo = (hash == "" ? idx : hash);
	}
	
	location.hash = currentPageNo;
	$("#currentPageNo").val(currentPageNo);
}

/* noData 자동 colspan처리 */
const fncColLength = function(){
	$("colgroup").each(function(idx){
		$(this).nextAll('tbody:first').find(".no_data").attr("colspan", $(this).children("col").length);
	});
};

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
		var msgHtml = '<span class="text" id="msg_'+mId+'" style="color:'+color+';display:'+display+';margin-left:'+margin+';">'+msg+'</span>';
		$("#"+mId).parent().append(msgHtml);
	}
};

/* 로딩 시작 */
var fncLoadingStart = function(){
	$(".loading_wrap").show();
}

/* 로딩 종료 */
var fncLoadingEnd = function(){
	setTimeout(function(){ 
		$(".loading_wrap").hide();
    }, 300);
		
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

/* 검색조건 SET */
function fncSearchSet(){
	$("INPUT:HIDDEN[ID^=search],INPUT:HIDDEN[ID^=sch]").each(function(){
		let inputType = $(this).attr("data-type");
		let inputId = $(this).prop("id");
		let inputVal = $(this).val();
		if(inputVal != ""){
			if(inputType == "select-one"){
				$("#_"+inputId).val(inputVal).prop("selected",true);
			}else if(inputType == "checkbox"){
				let splVal = inputVal.split(",");
				for (var i = 0, j = splVal.length; i < j; i++) {
					$("[NAME=_"+inputId+"]:CHECKBOX[VALUE="+splVal[i]+"]").prop("checked",true);
				}
			}else if(inputType == "radio"){
				let splVal = inputVal.split(",");
				for (var i = 0, j = splVal.length; i < j; i++) {
					$("[NAME=_"+inputId+"]:RADIO[VALUE="+splVal[i]+"]").prop("checked",true);
				}
			}else{
				$("#_"+inputId).val(inputVal);
			}
		}
	})
}

/*
	20220711 추가 - 구연호
	addList의 recordCountPerPage_tbl_right를 defaultForm 내의 recordCountPerPage에 할당
 */
function fncRecordCountPerPageSet(){
	if($('#recordCountPerPage_board_right').val()) {
		$('#recordCountPerPage').val($('#recordCountPerPage_board_right').val());
   	}
}

// 2024.07.01 단위테스트용 함수 추가
function fncSetTestInput(){
	// 랜덤 한글 문자열 생성 함수
	function getRepeatedHangulString(length) {
		const hangulPattern = "가나다라마바사아자차카타파하";
		let result = '';
		for (let i = 0; i < length; i++) {
			result += hangulPattern.charAt(Math.floor(Math.random() * hangulPattern.length));
		}
		return result;
	}

	// 랜덤 휴대폰 번호 생성 함수
	function getRandomPhoneNumber() {
		const randomDigits = () => Math.floor(Math.random() * 9000 + 1000); // 1000 ~ 9999 랜덤 숫자
		return '010'+randomDigits()+randomDigits();
		//return '010-'+randomDigits()+'-'+randomDigits();
	}

	// 랜덤 이메일 주소 생성 함수
	function getRandomEmail() {
		const domains = ["example.com", "test.com", "email.com"];
		const randomDomain = domains[Math.floor(Math.random() * domains.length)];
		const randomLocalPart = Math.random().toString(36).substring(2, 10); // 랜덤 문자열 생성
		return randomLocalPart+'@'+randomDomain;
	}

	// 랜덤 ID 생성 함수
	function getRandomId() {
		const characters = 'abcdefghijklmnopqrstuvwxyz0123456789_-';
		const length = Math.floor(Math.random() * (20 - 5 + 1)) + 5; // 5 ~ 20 길이의 랜덤 값
		let result = '';
		for (let i = 0; i < length; i++) {
			result += characters.charAt(Math.floor(Math.random() * characters.length));
		}
		return result;
	}

	// 랜덤 숫자 및 영어 문자열 생성 함수
	function getRandomEngNumString(length) {
		const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
		let result = '';
		for (let i = 0; i < length; i++) {
			result += characters.charAt(Math.floor(Math.random() * characters.length));
		}
		return result;
	}

	// 랜덤 숫자 문자열 생성 함수
	function getRandomNumString(length) {
		const characters = '0123456789';
		let result = '';
		for (let i = 0; i < length; i++) {
			result += characters.charAt(Math.floor(Math.random() * characters.length));
		}
		return result;
	}

	// 랜덤 소수 문자열 생성 함수
	function getRandomNumDotString() {
		const integerPart = Math.floor(Math.random() * 1000); // 0 ~ 999 랜덤 정수
		const fractionalPart = Math.floor(Math.random() * 10000); // 0 ~ 9999 랜덤 소수
		return `${integerPart}.${fractionalPart}`;
	}

	//랜덤 날짜 생성 함수
	function getRandomDateString() {
		// 랜덤 연도 생성 (1900 ~ 2024), 월 생성
		const year = Math.floor(Math.random() * 125) + 1900;
		const month = Math.floor(Math.random() * 12) + 1;
		const formattedMonth = month.toString().padStart(2, '0');

		// 랜덤 일 생성 (01 ~ 28, 30, 31)
		// 월에 따라 일의 범위가 다르기 때문에 우선 모든 일의 범위를 포함한 후 나중에 일 수를 제한
		const day = Math.floor(Math.random() * 31) + 1;

		// 생성된 일자가 해당 월의 최대 일자보다 크면 최대 일자로 변경
		const maxDaysInMonth = new Date(year, month, 0).getDate();
		const validDay = Math.min(day, maxDaysInMonth);
		const formattedDay = validDay.toString().padStart(2, '0');

		return `${year}.${formattedMonth}.${formattedDay}`;
	}

	// 첫 번째 체크되지 않은 체크박스와 라디오 버튼을 선택하는 함수
	function selectFirstUnchecked(elements) {
		for (const element of elements) {
			if (!element.checked) {
				element.checked = true;
				break;
			}
		}
	}

	// 모든 input 요소를 찾습니다
	const inputs = document.querySelectorAll('input');

	// 모든 input 요소를 순회합니다
	inputs.forEach(input => {
		// input 타입에 따라 처리 방법을 다르게 설정합니다
		const type = input.getAttribute('type');
		const pattern = input.getAttribute('pattern');
		const classes = input.classList;

		if (type === 'file' || type === 'hidden') {
			// 파일 입력 요소와 숨김 입력 요소는 건너뜁니다
			return;
		} else if (!input.value) {
			if (pattern === 'phonNum') {
				// 패턴이 phoneNum인 경우 랜덤 휴대폰 번호 입력
				input.value = getRandomPhoneNumber();
			} else if (pattern === 'email') {
				// 패턴이 email인 경우 랜덤 이메일 주소 입력
				input.value = getRandomEmail();
			} else if (pattern === 'pswd') {
				// 패턴이 email인 경우 랜덤 이메일 주소 입력
				input.value = 'open1010!';
			} else if (pattern === 'id') {
				// 패턴이 id인 경우 랜덤 ID 입력
				input.value = getRandomId();
			} else if (classes.contains('datepicker')) {
				// 클래스가 datepicker 경우 랜덤 날짜 입력
				input.value = getRandomDateString();
			} else if (classes.contains('engNumOnly')) {
				// 클래스가 engNumOnly인 경우 숫자와 영어로 랜덤 문자열 입력
				input.value = getRandomEngNumString(10); // 기본 길이 10
			} else if (classes.contains('numOnly')) {
				// 클래스가 numOnly인 경우 숫자로 랜덤 문자열 입력
				input.value = getRandomNumString(10); // 기본 길이 10
			} else if (classes.contains('numDotOnly')) {
				// 클래스가 numDotOnly인 경우 랜덤 소수 입력
				input.value = getRandomNumDotString();
			} else if (classes.contains('floatNumOnly')) {
				// 클래스가 floatNumOnly 경우 랜덤 소수 입력
				input.value = getRandomNumDotString();
			} else {
				// 그 외 input 요소는 maxlength 속성을 가져와 반복 문자열로 채웁니다
				const maxLength = input.getAttribute('maxlength');
				if (maxLength) {
					const fillerText = getRepeatedHangulString(maxLength);
					input.value = fillerText;
				} else {
					input.value = getRepeatedHangulString(10); // 기본 길이 10
				}
			}
		}
	});

	// 첫 번째 체크되지 않은 체크박스와 라디오 버튼을 선택합니다
	selectFirstUnchecked(document.querySelectorAll('input[type="checkbox"]'));
	selectFirstUnchecked(document.querySelectorAll('input[type="radio"]'));

	// 텍스트 영역(textarea)도 같은 방식으로 처리
	const textareas = document.querySelectorAll('textarea');

	textareas.forEach(textarea => {
		if (!textarea.value) {
			const maxLength = textarea.getAttribute('maxlength');
			if (maxLength) {
				const fillerText = getRepeatedHangulString(maxLength);
				textarea.value = fillerText;
			} else {
				textarea.value = getRepeatedHangulString(100); // 기본 길이 100
			}
		}
	});

	// 셀렉트 박스(select) 요소 처리
	const selects = document.querySelectorAll('select');

	selects.forEach(select => {
		if (!select.value) {
			const options = Array.from(select.options);
			const firstValueOption = options.find(option => option.value !== "");
			if (firstValueOption) {
				firstValueOption.selected = true;
			}
		}
	});
}