<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Pragma" content="no-store"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<title>오픈노트 - 표준안</title>
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/jquery-ui-1.12.1.custom.css">
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/basic.css">
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/member.css">
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery-ui-1.12.1.custom.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/common.js"></script>
	<style>.btn_confirm {height:48px;}</style>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#btn_cancel').on('click', function(){
				location.href = '/ma/login.do';
			})
		})
	</script>
	<div class="login_wrap">
	    <div class="login_box find_box">
	        <h1 class="logo"><img src="<c:out value='${pageContext.request.contextPath}'/>/ma/images/common/logo.png" alt="로고"></h1>
	        <div class="box">
	            <b>아이디 찾기</b>
	            <form name="defaultFrm" id="findIdFrm" method="post" onsubmit="return false">
	                <fieldset>
	                    <div class="input_box">
	                        <ul>
	                            <li>
	                                <label for="userNm_id">이름</label>
	                                <input type="text" id="userNm_id" name="userNm" placeholder="이름" title="이름을 입력해주세요." maxlength="20">
	                            </li>
	                            <li>
	                                <label for="userTelNo">휴대폰번호</label>
	                                <input type="text" id="userTelNo_id" name="userTelNo" class="numOnly" placeholder="‘-’를 제외한 숫자만 입력해 주세요." title="휴대폰번호를 입력해주세요." maxlength="11">
	                            </li>
	                            <li>
	                                <label for="userEmailAddr_id">이메일</label>
	                                <input type="text" id="userEmailAddr_id" name="userEmailAddr" placeholder="이메일" title="이메일을 입력해주세요." maxlength="100">
	                            </li>
	                        </ul>
	                        <ul id="idEmailCheck" class="mar_t20">
	                        	<li>
	                                <label for="idEmailKey">이메일</label>
	                                <input type="text" id="idEmailKey" name="idEmailKey" class="numOnly w345px" placeholder="인증코드" title="인증코드를 입력해주세요." maxlength="6">
			                        <button type="button" id="btn_confirm" class="btn blue btn_confirm fs15px">인증하기</button>
	                            </li>
	                        </ul>
	                    </div>
	                    <div class="btn_area">
	                        <button type="button" id="btn_idFind" class="btn blue btn_login">아이디 찾기</button>
	                    </div>
	                </fieldset>
	            </form>
	        </div>
	        <div class="box">
	            <b>비밀번호 찾기</b>
	            <form name="defaultFrm" id="findPswdFrm" method="post" onsubmit="return false">
	                <fieldset>
	                    <div class="input_box">
	                        <ul>
	                            <li>
	                                <label for="userId_pswd">아이디</label>
	                                <input type="text" id="userId_pswd" name="userId" placeholder="아이디" title="아이디를 입력해주세요." maxlength="30">
	                            </li>
	                            <li>
	                                <label for="userNm_pswd">이름</label>
	                                <input type="text" id="userNm_pswd" name="userNm" placeholder="이름" title="이름을 입력해주세요." maxlength="20">
	                            </li>
	                            <li>
	                                <label for="">휴대폰번호</label>
	                                <input type="text" id="userTelNo_pswd" name="userTelNo" placeholder="‘-’를 제외한 숫자만 입력해 주세요." title="휴대폰번호를 입력해주세요." maxlength="11" class="numOnly">
	                            </li>
	                            <li>
	                                <label for="userEmailAddr_pswd">이메일</label>
	                                <input type="text" id="userEmailAddr_pswd" name="userEmailAddr" placeholder="이메일" title="이메일을 입력해주세요." maxlength="100">
	                            </li>
	                        </ul>
	                        <ul id="pswdEmailCheck">
	                        </ul>
	                    </div>
	                    <div class="btn_area">
	                        <button type="button" id="btn_pswdFind"  class="btn blue btn_login">비밀번호 찾기</button>
	                    </div>
	                </fieldset>
	            </form>
	        </div>
	        <div class="btn_area">
            	<a href="javascript:void(0);" id="btn_cancel" class="btn gray">취소</a>
           	</div>
	    </div>
	</div>
</body>
</html>