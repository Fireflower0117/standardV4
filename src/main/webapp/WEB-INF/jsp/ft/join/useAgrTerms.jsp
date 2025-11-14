<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<c:if test="${fn:length(sessionScope.ft_termsList) <= 0}">
	location.href = "<c:out value='${empty sessionScope.sns_user_info ? \"idnttVrfct.do\" : \"snsJoinForm.do\"}'/>";
</c:if>

<%-- 이용약관 동의 후 submit --%>
const fncSubmit = function(){
	if($('#btn_next').hasClass('blue')){
		<%-- Action --%>
		$("#defaultFrm").attr({"action" : "<c:out value='${empty sessionScope.sns_user_info ? \"idnttVrfct.do\" : \"snsJoinForm.do\"}'/>", data : $("#defaultFrm").serialize(),"method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
	} else {
		alert($('.chklist.required input:not(:checked):first').siblings().children('.titlNm').text() + '에 동의해주세요.');
	}
}
$(document).ready(function(){
	
	<%-- 전체 체크박스 클릭시 --%>
	$('.join.agreement .chkall input').on('click', function () {
		let checked = $(this).is(':checked');
		if (checked) {
			$('.chklist').find('input').prop('checked', true);
			$(".join.agreement .btn_join").removeClass("gray").removeClass("light").addClass("blue");
		} else {
			$('.chklist').find('input').prop('checked', false);
			$(".join.agreement .btn_join").removeClass("blue").addClass("light").addClass("gray");
		}
	});
	<%-- 개별 체크박스 클릭시 --%>
	$('.join.agreement .chklist input').on('click', function () {
		
		<%-- 전체 체크리스트 --%>
		let chkGroup = $('.chklist').length;
		let checked_cnt = $('.chklist input:checked').length;
		
		<%-- 필수 체크리스트 --%>
		let reqChkGroup = $('.chklist.required').length;
		let reqChecked_cnt = $('.chklist.required input:checked').length;
		if (checked_cnt < chkGroup && reqChecked_cnt < reqChkGroup) {
			$('.chkall input').prop('checked', false);
			$(".join.agreement .btn_join").removeClass("blue").addClass("light").addClass("gray");
		} else if (checked_cnt == chkGroup) {
			$('.chkall input').prop('checked', true);
			$(".join.agreement .btn_join").removeClass("gray").removeClass("light").addClass("blue");
		} else if (reqChkGroup == reqChecked_cnt){
			$('.chkall input').prop('checked', false);
			$(".join.agreement .btn_join").removeClass("gray").removeClass("light").addClass("blue");
		} 
	});
	
	<%-- 필수약관 더보기 클릭시 --%>
	$('.btn_more').on('click', function(){
		view_show(1);
	});
	
	<%-- 선택약관 더보기 클릭시 --%>
	$(".join.agreement .btn_more2").click(function () {
		if ($(this).hasClass("on")) {
			$(this).removeClass("on");
			$(this).next(".cont").slideUp(100);
		} else {
			$(this).addClass("on");
			$(this).next(".cont").slideDown(100);
		}
		return false;
	});

	<%-- 팝업 닫기 클릭시 --%>
	$('.pop_close').on('click', function(){
		view_hide($(this).attr('data-index'));
	});

	<%-- 확인버튼 클릭시 --%>
	$('#btn_next').on('click', function(){
		fncSubmit();
	});
});
</script>
<ul class="step">
    <li><a href="javascript:void(0);" class="current">약관동의</a></li>
    <c:if test="${empty sessionScope.sns_user_info }"><li><a href="javascript:void(0);">본인인증</a></li></c:if>
    <li><a href="javascript:void(0);">정보입력</a></li>
    <li><a href="javascript:void(0);">가입완료</a></li>
</ul>
<form id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
	<div class="join agreement mar_t3p">
	    <b class="page_tit">
	        약관동의
	        <span>약관 및 정보이용 안내에 동의해주세요.</span>
	    </b>
	    <div class="box">
	        <div class="chk_all">
	            <span class="chk chkall">
	                <span class="cbx"><input type="checkbox" name="agree" id="agree_all"><label for="agree_all">전체 약관동의</label></span>
	            </span>
	        </div>
	        <ul class="list">
	        	<c:if test="${fn:length(sessionScope.ft_termsList) > 0 }">
	        		<c:forEach var="result" items="${sessionScope.ft_termsList }" varStatus="status">
	        			<c:choose>
	        				<c:when test="${result.selTpNm eq '필수' }">
	        					<li>
	        						<input type="hidden" name="termsList[<c:out value="${status.index }"/>].termsSerno" value="<c:out value='${result.termsSerno }'/>"/>
	        						<input type="hidden" name="termsList[<c:out value="${status.index }"/>].prdUnitCd" value="<c:out value='${result.prdUnitCd }'/>"/>
	        						<input type="hidden" name="termsList[<c:out value="${status.index }"/>].rqrdYn" value="Y"/>
					                <span class="chk chklist required">
					                    <span class="cbx">	
					                    	<input type="checkbox" name="termsList[<c:out value="${status.index }"/>].termsAgreeYn" id="termsAgreeYn_<c:out value="${status.count }"/>" value="Y">
					                    	<label for="termsAgreeYn_<c:out value="${status.count }"/>">
					                    		<b>[<c:out value="${result.selTpNm}"/>]</b>
					                    		<span class="titlNm"><c:out value="${result.titlNm }"/></span>
					                    	</label>
				                    	</span>
					                </span>
					                <a href="javascript:void(0);" class="btn_more">더보기</a>
					            </li>
	        				</c:when>
	        				<c:otherwise>
	        					<li>
	        						<input type="hidden" name="termsList[<c:out value="${status.index }"/>].termsSerno" value="<c:out value='${result.termsSerno }'/>"/>
	        						<input type="hidden" name="termsList[<c:out value="${status.index }"/>].prdUnitCd" value="<c:out value='${result.prdUnitCd }'/>"/>
					                <span class="chk chklist">
					                    <span class="cbx">
					                    	<input type="checkbox" name="termsList[<c:out value="${status.index }"/>].termsAgreeYn" id="termsAgreeYn_<c:out value="${status.count }"/>" value="Y">
					                    	<label for="termsAgreeYn_<c:out value="${status.count }"/>">
					                    		<b class="gray">[<c:out value="${result.selTpNm}"/>]</b>
					                    		<c:out value="${result.titlNm }"/>
					                    	</label>
					                    </span>
					                </span>
					                <a href="javascript:void(0);" class="btn_more2">더보기</a>
					                <div class="cont">
					                    <p><c:out value="${result.termsCtt }" escapeXml="false"/></p>
					                </div>
					            </li>
	        				</c:otherwise>
	        			</c:choose>
			            
	        		</c:forEach>
	        	</c:if>
	        </ul>
	    </div>
	    <div class="btn_area">
	        <button type="button" id="btn_next" class="btn gray light btn_join">확인</button>
	    </div>
	</div>
</form>
<!-- 약관 popup -->
<c:forEach var="result" items="${sessionScope.ft_termsList }" varStatus="status">
	<c:if test="${result.selTpNm eq '필수' }">
		<div id="display_view<c:out value="${status.count }"/>" class="layer_pop js_popup w800px">
		    <div class="pop_header">
		        <h2><c:out value="${result.titlNm }"/></h2>
		        <button type="button" class="pop_close" data-index="<c:out value="${status.count }"/>"><i class="xi-close-thin"></i>닫기</button>
		    </div>
		    <div class="pop_content">
		        <div class="term_box">
		        	<c:out value="${result.termsCtt }" escapeXml="false"/>
		        </div>
		    </div>
		</div>
	</c:if>
</c:forEach>