<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/member.js"></script>
<script type="text/javascript">
<%-- 인증 타이머용 변수 --%>
let timer = null;
let isRunning = false;

<%-- 찾기/인증하기 버튼 show/hide --%>
const fncSetButton = function(type, frm){
	
	$('#' + frm).find('.btn_area').children().hide();
	
	<%-- 찾기 --%>
	if(type === 'find'){
		$('#' + frm).find('.btn_area').children('.btn_find').show();
	<%-- 인증하기 --%>
	} else {
		$('#' + frm).find('.btn_area').children('.btn_auth').show();
	}
}

<%-- 아이디 찾기 - 이메일 인증코드 display --%>
const fncIdEmailAction = function(type){
	if(type === 'show'){
		$('input[id$="_id"]').prop('readonly', true);
		$('#idEmailKey').prop('disabled', false);
		$('#idEmailChk').show();
		
		<%-- 버튼 세팅(auth : 인증하기) --%>
		fncSetButton('auth', 'findIdFrm');
	} else {
		$('input[id$="_id"]').prop('readonly', false);
		$('#idEmailKey').prop('disabled', true);
		$('#idEmailChk').hide();

		<%-- 버튼 세팅(find : 찾기) --%>
		fncSetButton('find', 'findIdFrm');
	}
}
<%-- 비밀번호 찾기 - 이메일 인증코드 display --%>
const fncPswdEmailAction = function(type){
	if(type === 'show'){
		$('input[id$="_pswd"]').prop('readonly', true);
		$('#pswdEmailKey').prop('disabled', false);
		$('#pswdEmailChk').show();
		
		<%-- 버튼 세팅(auth : 인증하기) --%>
		fncSetButton('auth', 'findPswdFrm');
	} else {
		$('input[id$="_pswd"]').prop('readonly', false);
		$('#pswdEmailKey').prop('disabled', true);
		$('#pswdEmailChk').hide();
		
		<%-- 버튼 세팅(find : 찾기) --%>
		fncSetButton('find', 'findPswdFrm');
	}
}
<%-- 인증번호 타이머 시작 --%>
const fncStartTimer = function(count, $timer, id){
	let minutes, seconds;
    timer = setInterval(function () {
    minutes = parseInt(count / 60, 10);
    seconds = parseInt(count % 60, 10);

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    $timer.html(minutes + ":" + seconds);

    <%-- 타이머 끝 --%>
    if (--count < 0) {
		clearInterval(timer);
		if(id == 'id'){
			fncIdEmailAction('hide');
		} else {
	   		fncPswdEmailAction('hide');
		}
		<%-- 인증키 삭제 --%>
    	fncClearEmail();
		isRunning = false;
		}
	}, 1000);
	isRunning = true;
}

<%-- 인증번호 타이머 세팅 --%>
const fncTimer = function(id){
	let $timer = $('#timer_'+id);
	let leftSec = 180;

	<%-- 이미 타이머가 작동중이면 중지 --%>
	if (isRunning){
		clearInterval(timer);
		$timer.html('');
		fncStartTimer(leftSec, $timer, id);
	}else{
		fncStartTimer(leftSec, $timer, id);
		
	}
}
<%-- 아이디/비밀번호 찾기 동작 --%>
const fncFindInfo = function(type){
	$.ajax({
        url      : type + 'Proc'
       ,type     : 'post'
       ,data     : $('#' + type + 'Frm').serialize()
       ,dataType : "json"
       ,success  : function(data){

        	if(data.result){
        		if(type == 'findId'){
        			fncIdEmailAction('show');
        			fncPswdEmailAction('hide');
        			<%-- 타이머 세팅 --%>
        			fncTimer('id');
        		} else if(type == 'findPswd'){
        			fncPswdEmailAction('show');
        			fncIdEmailAction('hide');
        			<%-- 타이머 세팅 --%>
        			fncTimer('pswd');
        		} 
        	}
        	
        	alert(data.message);
        }
       ,error    : function(xhr, status, error){
            
            $('.error_txt').remove();
			let errors = xhr.responseJSON;
			
            for (let i = 0; i < errors.length; i++) {
			    let e = errors[i];
		    	$('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
			}
        },beforeSend : function(){
            fncLoadingStart();
        }
        ,complete 	: function(){
            fncLoadingEnd();
            return false;
        }
    });
}

<%-- 인증키 삭제 --%>
const fncClearEmail = function(type){
	$.ajax({
        url      : 'clearEmailProc'
       ,type     : 'post'
       ,dataType : 'json'
       ,success  : function(data){
        	alert(data.message);
        }
       ,error    : function(){
            alert('에러가 발생하였습니다.');
        }
       ,beforeSend : function(){
			fncLoadingStart();
		}
	    ,complete 	: function(){
	    	fncLoadingEnd();
			return false;
		}
    });
}
<%-- 이메일 인증 --%>
const fncEmailChk = function(obj){
	let frmId = $(obj).closest('form').attr('id');
	let findType = $(obj).data('type');
	
	if(wrestSubmit(document.getElementById(frmId))){
		
		let $emailKey = $('#' + findType).children('input');

		if($emailKey.val().length != 6) {
			alert('이메일 인증코드를 6자리 입력해주세요.');
			$emailKey.focus();
			return false;
		}
		
		<%-- 이메일 인증 동작 --%>
		fncEmailChkAction(findType, frmId);
	}
}
<%-- 이메일 인증 동작 --%>
const fncEmailChkAction = function(type, frm){
	$.ajax({
        url      : type + 'Proc'
        ,type     : 'post'
        ,data     : $('#' + frm).serialize()
        ,dataType : 'json'
        ,success  : function(data){
        	alert(data.message);
        	if(data.result){
        		if(type === 'idEmailChk'){
        			location.reload();
        		} else if(type == 'pswdEmailChk'){
        			$('#' + frm).attr({"action" : data.returnUrl, data : $('#' + frm).serialize(),"method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
        		} 
        	}
        }
        ,error: function (xhr, status, error) {
     		
     		$('.error_txt').remove();
			let errors = xhr.responseJSON;
			
            for (let i = 0; i < errors.length; i++) {
			    let e = errors[i];
		    	$('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
			}
    	},beforeSend : function(){
            fncLoadingStart();
        }
        ,complete 	: function(){
            fncLoadingEnd();
            return false;
        }
    });
}

$(document).ready(function(){
	
	<%-- 인증번호 영역 hide --%>
	fncIdEmailAction('hide');
	fncPswdEmailAction('hide');
	
	<%-- 아이디, 비밀번호 찾기 --%>
	$('.btn_find').on('click', function(){
		
		let frmId = $(this).closest('form').attr('id');
		let findType = $(this).data('type');
		
		if(wrestSubmit(document.getElementById(frmId))){
			<%-- 아이디/비밀번호 찾기 동작 --%>
			fncFindInfo(findType);	
		}
	});
	
	<%-- 아이디, 비밀번호 인증하기 --%>
	$('.btn_auth').on('click', function(){
		<%-- 이메일 인증 --%>
		fncEmailChk($(this));
	});
	
	<%-- 취소버튼 클릭시 --%>
	$('#btn_cancel').on('click', function(){
		location.href = '/ft/login.do';
	});
});
</script>
<div class="login_wrap">
    <div class="login_box find_box">
        <h1 class="logo"><img src="/ma/images/common/logo.png" alt="로고"></h1>
        <div class="box">
            <b>아이디 찾기</b>
	        <form id="findIdFrm" name="findIdFrm" method="post" onsubmit="return false;">
                <fieldset>
                    <div class="input_box">
                        <ul>
                            <li>
                                <label for="userNm_id">이름</label>
                                <input type="text" id="userNm_id" name="userNm" placeholder="이름을 입력해주세요." title="이름 입력" maxlength="20" required="true">
                            </li>
                            <li>
                                <label for="userTelNo_id">휴대폰번호</label>
                                <input type="text" id="userTelNo_id" name="userTelNo" class="numOnly" placeholder="‘-’를 제외한 숫자만 입력해 주세요." title="휴대폰번호 입력" maxlength="11" required="true">
                            </li>
                            <li>
                                <label for="userEmailAddr_id">이메일</label>
                                <input type="text" id="userEmailAddr_id" name="userEmailAddr" placeholder="이메일을 입력해주세요." title="이메일 입력" maxlength="100" required="true">
                            </li>
                        	<li id="idEmailChk" class="emailChk">
                        		<label for="userNm_id">인증번호</label>
                                <input type="text" id="idEmailKey" name="emailKey" class="numOnly w87p" placeholder="인증번호 입력해주세요." title="인증번호 입력" maxlength="6">
                                <span class="red_txt mar_l10" id="timer_id"></span>
                        	</li>
                        </ul>
                    </div>
                    <div class="btn_area">
                        <button type="button" class="btn blue btn_login btn_find" data-type="findId">아이디 찾기</button>
                        <button type="button" class="btn blue btn_login btn_auth" data-type="idEmailChk" style="display:none;">인증하기</button>
                    </div>
                </fieldset>
            </form>
        </div>
        <div class="box">
            <b>비밀번호 찾기</b>
            <form id="findPswdFrm" name="findPswdFrm" method="post" onsubmit="return false;">
                <fieldset>
                    <div class="input_box">
                        <ul>
                            <li>
                                <label for="userId_pswd">아이디</label>
                                <input type="text" id="userId_pswd" name="userId" placeholder="아이디를 입력해주세요." title="아이디 입력" maxlength="33" required="true">
                            </li>
                            <li>
                                <label for="userNm_pswd">이름</label>
                                <input type="text" id="userNm_pswd" name="userNm" placeholder="이름을 입력해주세요." title="이름 입력" maxlength="20" required="true">
                            </li>
                            <li>
                                <label for="userTelNo_pswd">휴대전화번호</label>
                                <input type="text" id="userTelNo_pswd" name="userTelNo" class="numOnly" placeholder="‘-’를 제외한 숫자만 입력해 주세요." title="휴대전화번호 입력" maxlength="11" required="true">
                            </li>
                            <li>
                                <label for="userEmailAddr_pswd">이메일</label>
                                <input type="text" id="userEmailAddr_pswd" name="userEmailAddr" placeholder="이메일을 입력해주세요." title="이메일 입력" maxlength="100" required="true">
                            </li>
                            <li id="pswdEmailChk" class="emailChk">
                        		<label for="userNm_id">인증번호</label>
                                <input type="text" id="pswdEmailKey" name="emailKey" class="numOnly w87p" placeholder="인증번호 입력해주세요." title="인증번호 입력" maxlength="6">
                                <span class="red_txt mar_l10" id="timer_pswd"></span>
                        	</li>
                        </ul>
                    </div>
                    <div class="btn_area">
                        <button type="button" class="btn blue btn_login btn_find" data-type="findPswd">비밀번호 찾기</button>
                        <button type="button" class="btn blue btn_login btn_auth" data-type="pswdEmailChk" style="display:none;">인증하기</button>
                    </div>
                </fieldset>
            </form>
        </div>
        <div class="btn_area">
			<button type="button" id="btn_cancel" class="btn gray">취소</button>
		</div>
    </div>
</div>