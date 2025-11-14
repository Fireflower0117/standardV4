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
			<link rel="icon" href="/file/getByteImage.do?atchFileId=<c:out value='${logoInfo.LGFC.atchFileId}'/>&fileSeqo=<c:out value='${logoInfo.LGFC.fileSeqo}'/>&fileNmPhclFileNm=<c:out value='${logoInfo.LGFC.fileNmPhclFileNm}'/>" type="image/x-icon">
		</c:when>
		<c:otherwise>
			<!--  Internal Project Libs -->
			<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/common/images/logo.png" type="image/x-icon"> 
		</c:otherwise>
	</c:choose> 
	
	<!--  External Libs -->
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery/jquery.min.js"></script>
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.css">
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.js"></script>
	
	
	
	<!--  Internal Standard Libs -->
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/css/basic.css">
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/css/member.css">  
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/js/cm.validate.js" charset="utf-8"></script>
	
	<!--  Internal Project Libs -->
	<style>.login_wrap{position: absolute;top: 20%;}</style>
</head>
<body>
	<script type="text/javascript">
		const fncLoadingStart = function(){
			$(".loading_wrap").show();
		}
	
		/* 로딩 종료 */
		const fncLoadingEnd = function(){
			setTimeout(function(){ 
				$(".loading_wrap").hide();
		    }, 300);
				
		}
		const fncLogin = function () {
		   if(wrestSubmit(document.defaultFrm)){
				<%-- 로그인 처리 --%>
		        $.ajax({
		            url: "/ma/login.do",
		            type: "post",
		            data: $("#defaultFrm").serialize(),
		            dataType: "json",
		            success: function(data){
						
		            	if (data.result) {
<!--		                    location.href = data.returnUrl;-->
							location.href = "/ma/sys/menu/list.do";
							
		                } else {
		                    alert(data.message);
		                }
		            },
		            error: function (xhr, status, error) {
		    			$('.error_txt').text('');
		    			let errors = xhr.responseJSON;
		    			errors.forEach(function(e){
		    				$("[data-name="+ e.field+"]").text(e.defaultMessage);
				        });
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
			
	    };
	    function enterkey() {
            if (window.event.keyCode == 13) {
            	fncLogin();
            }
        }
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
		    
			<%-- 로그인 클릭시 --%>
			$('#btn_login').on('click', function(){
				fncLogin(); 
				return false;
			});
			
			<%-- 아이디찾기, 비밀번호찾기 클릭시 --%>
			$('.btn_find').on('click', function(){
				$("#defaultFrm").attr({"action" : "/ma/findInfoForm.do", data : {},"method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
			});
			
			<%-- 사용자화면 클릭시 --%>
			$('#btn_user').on('click', function(){
				location.href = '/ft/main.do';
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
							<img src="/file/getByteImage.do?atchFileId=<c:out value='${logoInfo.LGLN.atchFileId}'/>&fileSeqo=<c:out value='${logoInfo.LGLN.fileSeqo}'/>&fileNmPhclFileNm=<c:out value='${logoInfo.LGFC.fileNmPhclFileNm}'/>" alt="로고">
						</a>
					</c:otherwise>
				</c:choose>
			</h1>
			<form id="defaultFrm" name="defaultFrm" onsubmit="return false;" onkeydown="enterkey();">
				<fieldset>
					<div class="input_box">
						<ul>
							<li>
								<label for="userId">아이디</label> 
								<input type="text" id="userId" name="userId" tabindex="1" title="아이디" placeholder="아이디를 입력해주세요." class="text" maxlength="30" value="standard_ms" required="true" />
							</li>
							<li>
								<label for="userPswd">비밀번호</label> 
								<input type="password" id="userPswd" name="userPswd" tabindex="2" title="비밀번호" placeholder="비밀번호를 입력해주세요." class="text" maxlength="20" value="open1010!" autocomplete="off" required="true" />
							</li>
						</ul>
					</div>
					<div class="btn_area">
						<button type="button" id="btn_login" class="btn blue btn_login">로그인</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>