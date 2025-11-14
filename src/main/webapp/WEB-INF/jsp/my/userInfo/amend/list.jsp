<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<%
	/* sns 연동 해제 api 콜백 후 redirect url 세션에 저장 */
    session.setAttribute("sns_returnUrl", "/my/userInfo/amend/list.do");
%>
<script type="text/javascript">
<c:if test="${not empty sessionScope.ft_user_info.snsSeCd}">
	<%-- sns 연동 해제 처리 --%>
	const fncSnsUnlink = function(){
		$.ajax({
			type : 'patch'
			,url : 'snsUnlinkProc'
			,dataType : 'json'
			,success : function(data) {
				alert(data.message);
				if(data.result){
					location.href = data.returnUrl;
				}
			}
			,error: function (xhr, status, error) {
				
				if (xhr.status == 401) {
			  		window.location.reload();
				}
				
				$('.error_txt').remove();
				let errors = xhr.responseJSON;
				
				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					for (let i = 0; i < errors.length; i++) {
	   				    let e = errors[i];
					    $('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
	   				}
				}
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
</c:if>
$(document).ready(function(){
	<c:choose>
		<c:when test="${empty sessionScope.ft_user_info.snsSeCd}">
			<%
				/* sns 로그인 api 콜백 후 redirect url 세션에 저장 */
			    session.setAttribute("sns_returnUrl", "/my/userInfo/amend/snsConn.do");
			%>
			<%-- SNS 연동 버튼 클릭시 --%>
			$('.sns_linkage > li').on('click', function(){
				location.href = $(this).data('url');
			});
		</c:when>
		<c:otherwise>
			<%-- SNS아이콘 클릭시 연동 해제 --%>
			$('.sns_linkage > li.on').on('click', function(){
				if(confirm('SNS계정 연동해제 하시겠습니까?')){
					fncSnsUnlink();
				} 
			});
		</c:otherwise>
	</c:choose>
	
	<%-- 수정 클릭시 --%>
	$('.btn_write').on('click', function(){
		location.href = 'idnttVrfct.do';
	});
});
</script>
<div class="sidebyside">
   	<div class="left">
		<h4 class="md_tit">개인정보</h4>
	</div>
</div>
<table class="board_view">
	<caption>내용(아이디, 이름, 주소, 휴대전화번호, 이메일, SNS계정 연동여부로 구성)</caption>
    <colgroup>
        <col class="w20p">
        <col class="w30p">
        <col class="w20p">
        <col class="w30p">
    </colgroup>
    <tbody>
        <tr>
            <th scope="row">아이디</th>
            <td><c:out value="${sessionScope.ft_user_info.userId }"/></td>
            <th scope="row">이름</th>
            <td><c:out value="${sessionScope.ft_user_info.userNm }"/></td>
        </tr>
        <tr>
            <th scope="row">주소</th>
            <td colspan="3">
            	<div>우편번호 : <c:out value="${sessionScope.ft_user_info.postNo }"/></div>
            	<div><c:out value="${sessionScope.ft_user_info.homeAddr }"/></div>
            	<div><c:out value="${sessionScope.ft_user_info.homeAddrDtls }"/></div>
            </td>
        </tr>
        <tr>
            <th scope="row">휴대전화번호</th>
            <td><c:out value="${util:getDecryptAES256HyPhen(sessionScope.ft_user_info.userTelNo) }"/></td>
            <th scope="row">이메일</th>
            <td><c:out value="${sessionScope.ft_user_info.userEmailAddr }"/></td>
        </tr>
        <tr>
            <th scope="row">SNS계정 연동여부</th>
            <td colspan="3">
				<ul class="sns_linkage">
					<c:choose>
						<c:when test="${empty sessionScope.ft_user_info.snsSeCd }">
		  		 			<li class="kakao <c:out value="${empty sessionScope.ft_user_info.snsSeCd ? 'cursor' : '' }"/>" data-url="/oauth/kakao">카카오 연동</li>
		  		 			<li class="naver <c:out value="${empty sessionScope.ft_user_info.snsSeCd ? 'cursor' : '' }"/>" data-url="/oauth/naver">네이버 연동</li>
						</c:when>
						<c:otherwise>
		  		 			<li class="kakao <c:out value="${sessionScope.ft_user_info.snsSeCd eq 'K' ? 'on' : '' }"/>">카카오 연동</li>
		  		 			<li class="naver <c:out value="${sessionScope.ft_user_info.snsSeCd eq 'N' ? 'on' : '' }"/>">네이버 연동</li>
						</c:otherwise>
					</c:choose>
				</ul>
            </td>
        </tr>
    </tbody>
</table>
<div class="btn_area">
    <button type="button" class="btn blue btn_write">수정</button>
</div>
<%-- SNS 연동 팝업 --%>
<div id="display_view1" class="layer_pop js-popup w300px"></div>