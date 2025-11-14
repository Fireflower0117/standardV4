$(document).ready(function(){
	
	/*
		20220517 추가 구연호
		placeholder 바인딩
	*/
	wrestSetPlaceHoder(document.defaultFrm);

});

var wrestMsg = "";
var wrestFld = null;
var wrestFldDefaultColor = "";
//var wrestFldBackColor = "#ff3061";
var req_chk = 0;


/*
	20220517 추가 구연호
	placeholder 바인딩
*/
function wrestSetPlaceHoder(form)
{
	if(form){
		for (var i=0; i<form.elements.length; i++) {
	        var el = form.elements[i];
			
			if((el.type=="text" || el.type=="hidden" || el.type=="password" || el.type=="textarea") && el.getAttribute("required") != null && el.getAttribute("pattern") != null ){
				var placeMsg = "";
				let max = new Map();
				
				max = wrestGetRegex(el.getAttribute("pattern"));
				if(max.get('placeMsg') != '' && max.get('placeMsg') != null) {
					placeMsg = max.get('placeMsg');
					if(placeMsg){$('#'+el.getAttribute("id")).attr('placeholder', placeMsg);}
				}
				
			}
		}
	}
	
}

/*
	20220517 추가 구연호
	입력된 값에따라 정규표현식과 placeholder 문자열 맵의 형태로 반환
	
*/
function wrestGetRegex(regepsId)
{
	let max = new Map();
	
	var placeMsg = '';
	let regex;
	var errMsg = '';
	
	/*
	switch (patternVal) {
		case 'id'		:	placeMsg 	= '5~20자의 영문 소문자, 숫자와 특수기호(_),(-)';
							regex 		= /^[a-z0-9][a-z0-9_\-]{4,19}$/;
							errMsg 		= '5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.';
							break;
		case 'pswd'		:	placeMsg 	= '영문자,숫자,특수문자 포함 8 ~ 30이하';
							regex 		= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[`\-_\\,.\/?;:\[\]{}~!@#$%^&*()+|=\'\"])[A-Za-z\d`\-_\\,.\/?;:\[\]{}~!@#$%^&*()+|=\'\"]{8,30}$/i;
							errMsg 		= '숫자 또는 영문 대소문자 8자이상 30자 이하(특수문자사용가능)로 입력해주세요.';
							break;
		case 'email'	:	placeMsg 	= '이메일';
							regex 		= /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
							errMsg 		= '형식이 일치하지 않습니다.';
							break;
		case 'phonNum'	:	placeMsg 	= '\'-\' 제외 전화번호 숫자 11자리를 입력해주세요.';
							regex 		= /^[0-9]{3}[0-9]{4}[0-9]{4}$/;
							errMsg 		= '\'-\' 제외 전화번호 11자리를 입력해주세요.';
							break;
		case 'url'		:	placeMsg 	= 'URL 주소';
							regex 		= /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
							errMsg 		= 'URL 주소 형식으로 입력해주세요.';
							break;
		case 'ipv4'		:	placeMsg 	= 'IPv4';
							regex 		= /^([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$/i;
							errMsg 		= 'IP를 형식에 맞게 입력해주세요.';
							break;
		default : break;
	}
	
	*/
	
	fncAjax('/cmmn/getRegeps.do', {regepsId : regepsId}, 'json', false, '', function(data){
		if(data.chk) {
			placeMsg = data.placeMsg;
			regex = data.regex;
			errMsg = data.errMsg;
		}
	});
	
	
	if(errMsg == '') {
		errMsg = '형식이 일치하지 않습니다.';
	}
	
	max.set('placeMsg', placeMsg);
	max.set('regex', regex);
	max.set('errMsg', errMsg);
	return max;
}

// subject 속성값을 얻어 return, 없으면 tag의 name을 넘김
function wrestItemname(fld)
{
    //return fld.getAttribute("title") ? fld.getAttribute("title") : ( fld.getAttribute("alt") ? fld.getAttribute("alt") : fld.name );
    var id = fld.getAttribute("id");
    var labels = document.getElementsByTagName("label");
    var el = null;

    for(i=0; i<labels.length; i++) {
        if(id == labels[i].htmlFor) {
            el = labels[i];
            break;
        }
    }

    if(el != null) {
        var text =  el.innerHTML.replace(/[<].*[>].*[<]\/+.*[>]/gi, "");

        if(text == '') {
            return fld.getAttribute("title") ? fld.getAttribute("title") : ( fld.getAttribute("placeholder") ? fld.getAttribute("placeholder") : fld.name );
        } else {
            return text;
        }
    } else {
        return fld.getAttribute("title") ? fld.getAttribute("title") : ( fld.getAttribute("placeholder") ? fld.getAttribute("placeholder") : fld.name );
    }
}

// 양쪽 공백 없애기
function wrestTrim(fld)
{
    var pattern = /(^\s+)|(\s+$)/g; // \s 공백 문자
	/* 20220516 수정 - 구연호 */
	if(fld.type=="textarea"){
		return wrestEditorReplace(fld).replace(pattern, "");
	} else {
	    return fld.value.replace(pattern, "");
	}
}

// 필수 입력 검사
function wrestRequired(fld)
{	
	var id = fld.getAttribute("id");
	var errMsg = "";
	
	//console.log(fld.name+"//"+fld.type+"///"+wrestTrim(fld));
	if(fld.type == "radio" || fld.type == "checkbox"){
			//console.log($("[NAME="+fld.name+"]:CHECKED").length)
		if($("[NAME='"+fld.name+"']:CHECKED").length < 1){
			wrestMsg = wrestItemname(fld) + " : 필수 선택입니다.";
			req_chk += 1;
			if (fld.style.display != "none") {
				
				
				// 오류메세지를 위한 element 추가
				var msgHtml = '<p id="msg_'+id+'" data-name="'+fld.name+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
				
				$("[data-name="+fld.name+"]").remove();
				$("#"+id).parent().append(msgHtml);
			}
		}
	}else{
		/* 20220517 추가 구연호 */
		// 파일
		if(fld.getAttribute("id").indexOf('FileId') != -1){
			
			if(fld.getAttribute("data-totalCnt") == 0){
				wrestMsg = wrestItemname(fld) + " : 필수 "+(fld.type=="select-one"?"선택":"입력")+"입니다.";
				req_chk += 1;
				
				// 오류메세지를 위한 element 추가
				var msgHtml = '<p id="msg_'+id+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
				
				$("#msg_"+id).remove();
				
				var fId = id.replace('FileId', 'FileUpload');
				$("#"+fId).parent().append(msgHtml);
			}
			
		// 빈값 체크
		} else if (wrestTrim(fld) == "" & (fld.getAttribute("required") != null && fld.getAttribute("required") != '')) {
			// 셀렉트박스일 경우에도 필수 선택 검사합니다.
			wrestMsg = wrestItemname(fld) + " : 필수 "+(fld.type=="select-one"?"선택":"입력")+"입니다.";
			req_chk += 1;
			/* 20220516 수정 구연호 */
			if (fld.style.display != "none" || $('#'+fld.id).hasClass('editor')) {
				
				// 오류메세지를 위한 element 추가
				var msgHtml = '<p id="msg_'+id+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
				
				$("#msg_"+id).remove();
				
				$("#"+id).parent().append(msgHtml);
				
				/* if (typeof(fld.select) != "undefined"){
            	fld.select();
	            fld.focus();}*/

			}

		// 패턴체크
		} else if (fld.getAttribute("pattern") != null) {
			
			var ChkTf = true;
			
			/*
				20220517 추가 구연호
				패턴 체크
			*/
			if (fld.getAttribute("pattern") != null && wrestTrim(fld) != ""){
				let regex;
				let map = new Map();
				map = wrestGetRegex(fld.getAttribute("pattern"));
				
				regex = new RegExp(map.get('regex'));
				errMsg = map.get('errMsg');
				// wrestItemname(fld) + " : " +
				
				if(map.get('regex') == null || map.get('regex') == '') {
					 
					req_chk += 1;
					ChkTf = false;
					
					wrestMsg = '존재하지 않는 정규표현식입니다.';
					
					// 오류메세지를 위한 element 추가
					var msgHtml = '<p id="msg_'+id+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
					$("#msg_"+id).remove();
					$("#"+id).parent().append(msgHtml);
				
				} else if(!regex.test(fld.value)){
					req_chk += 1;
					ChkTf = false;
						
					wrestMsg = errMsg;
						
					// 오류메세지를 위한 element 추가
					var msgHtml = '<p id="msg_'+id+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
					$("#msg_"+id).remove();
					$("#"+id).parent().append(msgHtml);
						
						
				}
				
			}// 패턴 체크 END
				
			/*
				20220531 추가 구연호
				중복체크 - 속성값
				data-chk  : 해당값이 'Y' 이면 중복체크가 완료된걸로 취급
				data-over : 중복체크 되지 않았다고 판단되었을때 출력할 메시지
				
				1. 중복체크여부
				2. 중복 미허가
				3. 중복 허가
				
			 */
			if (ChkTf && fld.getAttribute("data-chk") != null && fld.getAttribute("data-over") != null) {
				
				var dataChk = fld.getAttribute("data-chk");
				var dataOver= fld.getAttribute("data-over");
				
				// 중복체크
				if(dataChk != 'Y'){
					errMsg = "중복체크를 해주세요.";
				// 중복 미허가
				} else if (dataOver != 'Y') {
					errMsg = "중복된 값입니다.";
				}
				
				if(dataChk != 'Y' || dataOver != 'Y'){
					
					// 중복허가
					if(dataChk == 'Y' && dataOver == 'N' && fld.getAttribute("data-etcMsg") != null){
						var etcMsg = fld.getAttribute("data-etcMsg");
						errMsg = etcMsg == 'Y' ? '' : etcMsg;
						
					// 중복 미허가
					} else {
						req_chk += 1;
						ChkTf = false;
					}
					
					wrestMsg = errMsg;
					
					if(wrestMsg){
						// 오류메세지를 위한 element 추가
						var msgHtml = '<p id="msg_'+id+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
						$("#msg_"+id).remove();
						$("#"+id).parent().append(msgHtml);
					}
				} 
			}
		
		// 다른 값과 동일한지 체크 2022-07-15 구연호 추가	
		} else {
		
			if(fld.getAttribute("data-rid") != null) {
				var rval = $('#'+fld.getAttribute("data-rid")).val();
				var val  = $('#'+fld.getAttribute("id")).val();
				
				wrestMsg = $('#'+fld.getAttribute("data-rid")).attr('title') + '이(가) 일치하지 않습니다.';
				
				if(rval != val) {
					
					req_chk += 1;
					var msgHtml = '<p id="msg_'+id+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
					$("#msg_"+id).remove();
					$("#"+id).parent().append(msgHtml);
				}
				
			}
			
		}// ELSE END
			
	}// IF-ELSE END
}// 함수 END

// 김선용 2006.3 - 전화번호(휴대폰) 형식 검사 : 123-123(4)-5678
function wrestTelNum(fld)
{
    if (!wrestTrim(fld)) return;

    var pattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
    if(!pattern.test(fld.value)){
        if(wrestFld == null){
            wrestMsg = wrestItemname(fld)+" : 전화번호 형식이 올바르지 않습니다.\n\n하이픈(-)을 포함하여 입력하세요.\n";
            wrestFld = fld;
            fld.select();
        }
    }
}

// 이메일주소 형식 검사
function wrestEmail(fld)
{
    if (!wrestTrim(fld)) return;

    //var pattern = /(\S+)@(\S+)\.(\S+)/; 이메일주소에 한글 사용시
    var pattern = /([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)\.([0-9a-zA-Z_-]+)/;
    if (!pattern.test(fld.value)) {
        if (wrestFld == null) {
            wrestMsg = wrestItemname(fld) + " : 이메일주소 형식이 아닙니다.\n";
            wrestFld = fld;
        }
    }
}

// 한글인지 검사 (자음, 모음 조합된 한글만 가능)
function wrestHangul(fld)
{
    if (!wrestTrim(fld)) return;

    //var pattern = /([^가-힣\x20])/i;
    var pattern = /([^가-힣\x20])/;

    if (pattern.test(fld.value)) {
        if (wrestFld == null) {
            wrestMsg = wrestItemname(fld) + ' : 한글이 아닙니다. (자음, 모음 조합된 한글만 가능)\n';
            wrestFld = fld;
        }
    }
}

// 한글인지 검사2 (자음, 모음만 있는 한글도 가능)
function wrestHangul2(fld)
{
    if (!wrestTrim(fld)) return;

    var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
    //var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/;

    if (pattern.test(fld.value)) {
        if (wrestFld == null) {
            wrestMsg = wrestItemname(fld) + ' : 한글이 아닙니다.\n';
            wrestFld = fld;
        }
    }
}

// 한글,영문,숫자인지 검사3
function wrestHangulAlNum(fld)
{
    if (!wrestTrim(fld)) return;

    var pattern = /([^가-힣\x20^a-z^A-Z^0-9])/i;

    if (pattern.test(fld.value)) {
        if (wrestFld == null) {
            wrestMsg = wrestItemname(fld) + ' : 한글, 영문, 숫자가 아닙니다.\n';
            wrestFld = fld;
        }
    }
}

// 한글,영문 인지 검사
function wrestHangulAlpha(fld)
{
    if (!wrestTrim(fld)) return;

    var pattern = /([^가-힣\x20^a-z^A-Z])/i;

    if (pattern.test(fld.value)) {
        if (wrestFld == null) {
            wrestMsg = wrestItemname(fld) + ' : 한글, 영문이 아닙니다.\n';
            wrestFld = fld;
        }
    }
}

// 숫자인지검사
// 배부른꿀꿀이님 추가 (http://dasir.com) 2003-06-24
function wrestNumeric(fld)
{
    if (fld.value.length > 0) {
        for (i = 0; i < fld.value.length; i++) {
            if (fld.value.charAt(i) < '0' || fld.value.charAt(i) > '9') {
                wrestMsg = wrestItemname(fld) + " : 숫자가 아닙니다.\n";
                wrestFld = fld;
            }
        }
    }
}

// 영문자 검사
function wrestAlpha(fld)
{
    if (!wrestTrim(fld)) return;

    var pattern = /(^[a-zA-Z]+$)/;

    if (!pattern.test(fld.value)) {
        if (wrestFld == null) {
            wrestMsg = wrestItemname(fld) + " : 영문이 아닙니다.\n";
            wrestFld = fld;
        }
    }
}

// 영문자와 숫자 검사
function wrestAlNum(fld)
{
   if (!wrestTrim(fld)) return;

   var pattern = /(^[a-zA-Z0-9]+$)/;

   if (!pattern.test(fld.value)) {
       if (wrestFld == null) {
           wrestMsg = wrestItemname(fld) + " : 영문 또는 숫자가 아닙니다.\n";
           wrestFld = fld;
       }
   }
}

// 영문자와 숫자 그리고 _ 검사
function wrestAlNum_(fld)
{
   if (!wrestTrim(fld)) return;

   var pattern = /(^[a-zA-Z0-9\_]+$)/;

   if (!pattern.test(fld.value)) {
       if (wrestFld == null) {
           wrestMsg = wrestItemname(fld) + " : 영문, 숫자, _ 가 아닙니다.\n";
           wrestFld = fld;
       }
   }
}

// 최소 길이 검사
function wrestMinLength(fld)
{
    if (!wrestTrim(fld)) return;

    var minlength = fld.getAttribute("minlength");

    if (wrestFld == null) {
        if (fld.value.length < parseInt(minlength)) {
			req_chk += 1;
            wrestMsg = wrestItemname(fld) + " : 최소 "+minlength+"글자 이상 입력하세요.\n";
            wrestFld = fld;

			var id = fld.getAttribute("id");
			
			// 오류메세지를 위한 element 추가
			var msgHtml = '<p id="msg_'+id+'" data-name="'+fld.name+'" class="msg_only error_txt">&nbsp;'+wrestMsg+'</p>';
			$("#msg_"+id).remove();
			$("#"+id).parent().append(msgHtml);
        }
    }
}

// 이미지 확장자
function wrestImgExt(fld)
{
    if (!wrestTrim(fld)) return;

    var pattern = /\.(gif|jpg|png)$/i; // jpeg 는 제외
    if(!pattern.test(fld.value)){
        if(wrestFld == null){
            wrestMsg = wrestItemname(fld)+" : 이미지 파일이 아닙니다.\n.gif .jpg .png 파일만 가능합니다.\n";
            wrestFld = fld;
            fld.select();
        }
    }
}

// 확장자
function wrestExtension(fld, css)
{
    if (!wrestTrim(fld)) return;

    var str = css.split("="); // ext=?? <-- str[1]
    var src = fld.value.split(".");
    var ext = src[src.length - 1];

    if (wrestFld == null) {
        if (ext.toLowerCase() < str[1].toLowerCase()) {
            wrestMsg = wrestItemname(fld) + " : ."+str[1]+" 파일만 가능합니다.\n";
            wrestFld = fld;
        }
    }
}

// 공백 검사후 공백을 "" 로 변환
function wrestNospace(fld)
{
    var pattern = /(\s)/g; // \s 공백 문자

    if (pattern.test(fld.value)) {
        if (wrestFld == null) {
            wrestMsg = wrestItemname(fld) + " : 공백이 없어야 합니다.\n";
            wrestFld = fld;
        }
    }
}

// 스마트 에디터 유효성검사를 위한 replace - 20220516 추가 구연호
function wrestEditorReplace(fld) {
	
	value = fld.value;
	value = value.replace(/<p><br><\/p>/gi, "");
	value = value.replace(/(<\/p><br>|<p><br>)/gi, "");
	value = value.replace(/(<p>|<\/p>)/gi, "");
	value = value.replace(/&nbsp;/gi, "");

	return value;
}


// submit 할 때 속성을 검사한다.
function wrestSubmit(form)
{
    wrestMsg = "";
    wrestFld = null;
    req_chk = 0;
    var attr = null;
    // 해당폼에 대한 요소의 개수만큼 돌려라
    $(".msg_only").remove();
    for (var i=0; i<form.elements.length; i++) {
        var el = form.elements[i];
        // Input tag 의 type 이 text, file, password 일때만
        // 셀렉트 박스일때도 필수 선택 검사합니다. select-one
       // console.log(el.type);
        if (el.type=="text" || el.type=="hidden" || el.type=="file" || el.type=="password" || el.type=="select-one" || el.type=="textarea" || el.type=="radio" ||  el.type=="checkbox") {
        	if ((el.getAttribute("required") != null && el.getAttribute("required") != '') || (el.getAttribute("pattern") != null && el.getAttribute("pattern") != ''))  {
                wrestRequired(el);
            }

        	if (el.getAttribute("minlength") != null) {
                wrestMinLength(el);
            }
            
            // 필드가 null 이 아니라면 오류메세지 출력후 포커스를 해당 오류 필드로 옮김
            // 오류 필드는 배경색상을 바꾼다.

            /*var array_css = el.className.split(" "); // class 를 공백으로 나눔

            el.style.backgroundColor = wrestFldDefaultColor;

            // 배열의 길이만큼 돌려라
            for (var k=0; k<array_css.length; k++) {
                var css = array_css[k];
                switch (css) {
                    case "required"     : wrestRequired(el); break;
                    case "trim"         : wrestTrim(el); break;
                    case "email"        : wrestEmail(el); break;
                    case "hangul"       : wrestHangul(el); break;
                    case "hangul2"      : wrestHangul2(el); break;
                    case "hangulalpha"  : wrestHangulAlpha(el); break;
                    case "hangulalnum"  : wrestHangulAlNum(el); break;
                    case "nospace"      : wrestNospace(el); break;
                    case "numeric"      : wrestNumeric(el); break;
                    case "alpha"        : wrestAlpha(el); break;
                    case "alnum"        : wrestAlNum(el); break;
                    case "alnum_"       : wrestAlNum_(el); break;
                    case "telnum"       : wrestTelNum(el); break; // 김선용 2006.3 - 전화번호 형식 검사
                    case "imgext"       : wrestImgExt(el); break;
                    default :
                        if (/^extension\=/.test(css)) {
                            wrestExtension(el, css); break;
                        }
                } // switch (css)
            } // for (k)
*/        } // if (el)
    } // for (i)

    //console.log(req_chk);
    if(req_chk > 0 ){
		// 유효성 검사 input focus
		var chkList = $(".msg_only");
		var id = chkList[0].getAttribute("id").replace("msg_","");
		
		var idOffSet = $("#"+id).offset().top;
		
		if($("#"+id).hasClass("editor")){
			oEditors.getById[id].exec("FOCUS");
			idOffSet = oEditors.offset().top;
		} else if (id.indexOf('FileId') != -1) {
			idOffSet = $("#"+id.replace('FileId', 'FileUpload')).offset().top;
		} else {
			$("#"+id).focus();
		}
	   $("html, body").animate({scrollTop : idOffSet - 120}, 0);
		
    	return false;
    }

    if (form.oldsubmit && form.oldsubmit() == false)
        return false;

    return true;
}