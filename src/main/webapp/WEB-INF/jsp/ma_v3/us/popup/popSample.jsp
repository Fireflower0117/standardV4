<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
.main_pop img {max-width: 100%;max-height: 100%;}
</style>
<script type="text/javascript">
<c:if test="${sampleVO.popupTgtCd eq 'PUTG03' }">
	$(function () {
	    $('#js_popup_bg').click(function () {
	        $('.js_popup').removeClass("on").css('visibility', 'hidden');
	        $(this).hide();
		    $(".main_pop").hide();
	    });
	});
</c:if>
$(document).ready(function () {
    <c:if test="${sampleVO.popupTgtCd eq 'PUTG03' }">
	    $(".main_pop .close").click(function () {
	        $(this).closest(".main_pop").hide();
	        $('#js_popup_bg').hide();
	        return false;
	    });
	    $(".main_pop").draggable();
    </c:if>
    
});
</script>
<div id="display_view1" class="main_pop">
    <div id="pop_header" class="pop_header">
        <h2><c:out value="${empty sampleVO.popupTitlNm ? 'Sample' : sampleVO.popupTitlNm }"/></h2>
        <button type="button" class="pop_close close <c:out value="${sampleVO.popupTgtCd ne 'PUTG03' ? 'win_close' : ''}"/>"><i class="xi-close-thin"></i>닫기</button>
    </div>
    <div id="pop_content" class="pop_content" style="min-height: 380px;" data-simplebar data-simplebar-auto-hide="false">
        <div><c:out value="${empty sampleVO.popupCtt ? 'Sample Content' : sampleVO.popupCtt }" escapeXml="false"/></div>
        <c:if test="${not empty sampleVO.repImgSrc }"><img src="<c:out value="${sampleVO.repImgSrc }"/>" alt="샘플이미지"/></c:if>
    </div>
    <div class="pop_footer">
        <span class="chk">
            <span class="cbx"><input type="checkbox" name="n_pop" id="no_today"><label for="no_today">오늘 하루 동안 열지 않음</label></span>
        </span>
		<button type="button" class="btn close <c:out value="${sampleVO.popupTgtCd ne 'PUTG03' ? 'win_close' : ''}"/>">닫기</button>
    </div>
</div>
<c:if test="${sampleVO.popupTgtCd eq 'PUTG03' }">
	<div class="popup_bg" id="js_popup_bg"></div>
</c:if>