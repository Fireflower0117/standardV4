<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>오픈노트 - 표준안</title>
		<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery.min.js"></script>
	</head>
	<body>
	<script type="text/javascript">
		<c:choose>
			<c:when test="${not empty sessionScope.sns_user_info}">
				const fncLoadingStart = function(){
					$(".loading_wrap").show();
				}
			
				/* 로딩 종료 */
				const fncLoadingEnd = function(){
					setTimeout(function(){ 
						$(".loading_wrap").hide();
				    }, 300);
						
				}
				
		   		<%-- sns 로그인 처리 --%>
		   		$.ajax({
		        	url 		: "/ft/snsLoginProc"
		        	,type 		: "post"
		        	,dataType	: "json"
		        	,success 	: function(data){
		        		if(data.result){
		        			location.href = data.returnUrl;
		        		}else{
		   					if(data.returnUrl){
		        				if(confirm(data.message)){
		        					location.href = data.returnUrl;
		        				} else {
		        					location.href = "/ft/login.do";
		        				}
		        			}else {
		        				alert(data.message);
		        				location.href = "/ft/login.do";
		        			}
		        		}
		        	}
		        	,error 		: function(req, msg, err){
		        		alert(+msg+'\n'+err);
		        	}
		        	,beforeSend : function(){
		    			fncLoadingStart();
		    		}
		    	    ,complete 	: function(){
		    	    	fncLoadingEnd();
		    			return false;
		    		}
		        });
			</c:when>
			<c:otherwise>
				location.href = '/ft/login.do';
			</c:otherwise>
		</c:choose>
	</script>
	</body>
</html>