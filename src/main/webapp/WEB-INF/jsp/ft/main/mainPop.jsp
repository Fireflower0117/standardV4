<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
.main_pop img {max-width: 100%;max-height: 100%;}
</style>
<script>
$(document).ready(function () {

	<c:if test="${popupVO.popupTgtCd eq 'PUTG03' }">
	    $(".main_pop").draggable();
	    $(".main_pop .close").click(function () {
	        $(this).closest(".main_pop").hide();
	        return false;
	    });
		$('input[name^="n_pop"]').on('click', function(){
			fncClosePop($(this).attr('id').split('_')[2], 'modal');
		});
	</c:if>
	
});
</script>
<div id="display_view<c:out value="${popupVO.popupSerno }"/>" class="main_pop">
	<div class="pop_header" id="pop_header<c:out value="${popupVO.popupSerno}"/>">
		<h2><c:out value="${popupVO.popupTitlNm}"/></h2>
		<button type="button" class="pop_close <c:out value="${popupVO.popupTgtCd ne 'PUTG03' ? 'win_close' : 'close'}"/>"><i class="xi-close-thin"></i>닫기</button>
	</div>
	<div class="pop_content" id="pop_content<c:out value="${popupVO.popupSerno}"/>" style="min-height: 380px;" data-simplebar data-simplebar-auto-hide="false">
		<div class="pop_txt">
			<c:out value="${popupVO.popupCtt}" escapeXml="false"/>
			<c:if test="${popupVO.fileSeqo gt -1 }">
				<img src="/file/getByteImage.do?atchFileId=<c:out value="${popupVO.repImgId}"/>&fileSeqo=<c:out value="${popupVO.fileSeqo}"/>&fileNmPhclFileNm=<c:out value="${popupVO.phclFileNm}"/>" alt="대표이미지"/>
			</c:if>
		</div>
	</div>
	<div class="pop_footer">
	    <span class="chk"><span class="cbx">
			<c:choose>
			<c:when test="${popupVO.popupTgtCd eq 'PUTG03' }">
	    		<input type="checkbox" name="n_pop<c:out value="${popupVO.popupSerno}"/>" id="no_today_<c:out value="${popupVO.popupSerno}"/>">
	    	</c:when>
	    	<c:otherwise>
	    		<input type="checkbox" name="n_pop<c:out value="{popupVO.popupSerno}"/>" id="no_today_<c:out value="${popupVO.popupSerno}"/>">
	    	</c:otherwise>
	    	</c:choose>
			<label for="no_today_<c:out value="${popupVO.popupSerno}"/>">오늘 하루 동안 열지 않음</label>
		</span></span>
		<button type="button" class="btn <c:out value="${popupVO.popupTgtCd ne 'PUTG03' ? 'win_close' : 'close'}"/>">닫기</button>
	</div>
</div>