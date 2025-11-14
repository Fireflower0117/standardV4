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
				<%-- sns 본인인증 여부 체크 --%>
		   		$.ajax({
		        	url 		: "snsVrfctProc"
		        	,type 		: "post"
		        	,dataType	: "json"
		        	,success 	: function(data){
		        		if(!data.result){
	      					alert(data.message);
		        		}
	        			location.href = data.returnUrl;
		        	}
		        	,error 		: function(req, msg, err){
						if (req.status == 401) {
							window.location.reload();
						}
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