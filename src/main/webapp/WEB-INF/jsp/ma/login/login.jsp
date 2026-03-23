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
	<meta name="_csrf" content="${_csrf}" />
    <meta name="_csrf_header" content="X-CSRF-TOKEN" />
	<title>오픈노트 - 표준안 Ver.4</title>
	<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/images/logo.png" type="image/x-icon">

	<!--  External Libs -->
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.css">
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/bootstrap/4_1_0/css/bootstrap.min.css">
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.js"></script>
    <script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-validate/1_19_5/dist/jquery.validate.js"></script>

	<!--  Internal Standard Libs -->
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/css/basic.css">
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/css/member.css">  
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/js/cm.validate.js" charset="utf-8"></script>

	<jsp:include  page="/WEB-INF/jsp/common/clientlib.jsp" />

	<!--  Internal Project Libs -->
	<style>.login_wrap{position: absolute;top: 20%;}</style>

	<script type="module">
		window.ctx = "${pageContext.request.contextPath}";
	</script>
</head>
<body>
	<script type="text/javascript">
         window.ctx = "${pageContext.request.contextPath}";

		$(document).ready(function(){
			$('.login_box .input_box input').focusout(function () {
		        $(".login_box .input_box .btn_del").removeClass("on");
		    });
		    $(".login_box .input_box .btn_del").click(function () {
		        $(this).prev('input').val('');
		        $(this).removeClass("on");
		        return false;
		    });
		    $('.login_box .input_box input').on('focus keyup', function (e) {
		        e.preventDefault();
		        if ($(this).val().length) {
		            $(this).next(".btn_del").addClass("on");
		        } else {
		            $(this).next(".btn_del").removeClass("on");
		        }
		    });
		    
			/* 로그인 클릭시 */
			$("#btn_login").on('click', function(){
				fncLogin();
				return false;
			});

			/* ID나 PassWord 엔터키 press */
			$("#userId,#userPswd").on("keyup", (evt) => {
				if (evt.key === "Enter" || evt.keyCode === 13) {
					fncLogin();
					return false;
				}
			});


			/* Login Process 수행 */
			const fncLogin = function () {

				// Validation List (유효성 검증 대상 )
		        let  loginValidateList =  [ {name : "userId"   , label : "아이디"   ,  rule: {"required":true} }
									      , {name : "userPswd" , label : "비밀번호" ,  rule: {"required":true, minlength : 5 } }
									      ];

				// 입력Data수기 생성
				let sendData = [{name:"userId"  , value: on.html.getEleVal({ele : "#userId"   }) }
							   ,{name:"userPswd", value: on.html.getEleVal({ele : "#userPswd" }) }
							   ];


				// Login수행
				on.xhr.ajax({ url : "/ma/loginProcess.do"
							, data : sendData
							, validation : { formId : "#loginForm" , validationList : loginValidateList  }  // 유효성검증 관련
							, successFn : function ( rs ){
										// 현재 주소창 URL에서 returnUrl 파라미터 추출 , 이동 URL결정
										const urlParams = new URLSearchParams(window.location.search);
										const returnUrl = urlParams.get('returnUrl');
										const targetUrl = returnUrl ? returnUrl : rs?.returnUrl;

										if (targetUrl) {

											// meta 태그에 있는 CSRF 토큰을 가져옴
                                            let csrfToken = $("meta[name='_csrf']").attr("content");

											on.html.dynaGenHiddenForm({ formDefine : { fid:"redirectForm" , action:targetUrl , method : "post" , isSubmit : true  }
											                          , formAttrs  : [ { name: "_csrf", value: csrfToken }  ]
											});
										}
										else {
           									on.msg.showMsg({message : rs.message || "로그인에 실패했습니다."});
										}
								}
							  , failFn    : function (err){
									on.msg.showMsg({message : err.message });
								}
				});
			};

			<%-- 아이디찾기, 비밀번호찾기 클릭시 --%>
			$('.btn_find').on('click', function(){
				// $("#defaultFrm").attr({"action" : "/ma/findInfoForm.do", data : {},"method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
			});
			
			<%-- 사용자화면 클릭시 --%>
			$('#btn_user').on('click', function(){
				// location.href = '/ft/main.do';
			});
		});
	</script>
	<div class="login_wrap">
		<div class="login_box">
			<h1 class="logo">
				<img src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/images/common/logo.png" alt="로고">
			</h1>
			<form id="loginForm" name="loginForm">
				<div class="input_box">
					 <ul>
						<li>
							<label for="userId">아이디</label>
							<input type="text" id="userId" name="userId"  tabindex="1" title="아이디" placeholder="아이디를 입력해주세요." class="text form-control"  value="standard_ms"  />
						</li>
						<li>
							<label for="userPswd">비밀번호</label>
							<input type="password" id="userPswd" name="userPswd" tabindex="2" title="비밀번호" placeholder="비밀번호를 입력해주세요." class="text form-control"  value="open1010!" autocomplete="off"  />
						</li>
					</ul>
				</div>
			</form>
			<div class="btn_area">
				<button type="button" id="btn_login" class="btn blue btn_login">로그인</button>
			</div>
		</div>
	</div>
</body>
</html>