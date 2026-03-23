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
	<title>오픈노트 - 표준안 Ver.4</title>
	<c:choose>
		<c:when test="${not empty logoInfo.LGFC.atchFileId}">
			<link rel="icon" href="/file/getByteImage.do?atchFileId=<c:out value='${logoInfo.LGFC.atchFileId}'/>&fileSn=<c:out value='${logoInfo.LGFC.fileSn}'/>&fileNmPhclFileNm=<c:out value='${logoInfo.LGFC.fileNmPhclFileNm}'/>" type="image/x-icon">
		</c:when>
		<c:otherwise>
			<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/images/logo.png" type="image/x-icon">
		</c:otherwise>
	</c:choose>

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
		        let loginValidateObj = { formWrapperEle : ".input_box"
								       , validateList  : [ {name : "userId"   , label : "아이디"   ,  rule: {"required":true} }
										     		     , {name : "userPswd" , label : "비밀번호" ,  rule: {"required":true, minlength : 5 } }
												         ]
				} ;

				// Form Validation Check 수행
				let isValidationSuccess = on.valid.cmValidationCheck(loginValidateObj);
				if(isValidationSuccess === false){ return false; }


				// 입력Data수기 생성
				let sendData = [{name:"userId"  , val: on.html.getEleVal({ele : "#userId"}) }
							   ,{name:"userPswd", val: on.html.getEleVal({ele : "#userPswd"}) }
					]


				// Login수행
				on.xhr.ajax({ sid  : "loginProc"
							  , url : "/ma/loginProcess.do"
							  , data : sendData
							  , successFn : function (sid, rs){
										if (rs?.returnUrl) {
                                            on.html.dynaGenHiddenForm({ formDefine : { fid:"mainForm" , action:rs.returnUrl , method : "post" , isSubmit : true  } }); // HiddenForm 생성및 전송
										} else {
											on.msg.showMsg({message : rs.message});
										}
								}
							  , failFn    : function (err){
					                on.msg.showMsg({message : err.message});
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
				<c:choose>
					<c:when test="${empty logoInfo.LGLN.atchFileId}">
						<img src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/images/common/logo.png" alt="로고">
					</c:when>
					<c:otherwise>
						<a style="cursor: ${logoInfo.LGLN.lnkYn eq 'Y' ? 'pointer' : 'default'}" href="${logoInfo.LGLN.lnkYn eq 'Y' ? logoInfo.LGLN.url : 'javascript:void(0)'}" target="${logoInfo.LGLN.lnkTgtCd eq 'blank' ? '_blank' : '' }">
							<img src="/file/getByteImage.do?atchFileId=<c:out value='${logoInfo.LGLN.atchFileId}'/>&fileSn=<c:out value='${logoInfo.LGLN.fileSn}'/>&fileNmPhclFileNm=<c:out value='${logoInfo.LGFC.fileNmPhclFileNm}'/>" alt="로고">
						</a>
					</c:otherwise>
				</c:choose>
			</h1>
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
				<div class="btn_area">
					<button type="button" id="btn_login" class="btn blue btn_login">로그인</button>
				</div>
		</div>
	</div>
</body>
</html>