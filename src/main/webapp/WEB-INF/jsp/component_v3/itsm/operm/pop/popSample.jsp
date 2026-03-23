<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:choose>
<%-- 팝업 대상 새탭 css --%>
<c:when test="${sampleVO.popupTrgtCd eq 'PT01' }">
	<style>
	.sample_pop {position: absolute;left: 0;top: 0;border: 2px solid #1185C0;background: #fff;z-index: 9999;height:100%;width: 100%;display: flex;flex-direction: column;}
	.popup_content .pop_txt img {max-width:800px; display:block; margin:0 auto;}
	</style>
</c:when>
<%-- 팝업 대상 새창 css --%>
<c:when test="${sampleVO.popupTrgtCd eq 'PT02' }">
	<style>
	.sample_pop {position: absolute;left: 0;top: 0;border: 2px solid #1185C0;background: #fff;z-index: 9999;height:100%;width: 100%;display: flex;flex-direction: column;}
	.popup_content .pop_txt img {max-width:100%; }
	</style>
</c:when>
<%-- 팝업 대상 모달창 css --%>
<c:otherwise>
	<style>
	.sample_pop {position: absolute;left: 0;top: 0;border: 2px solid #1185C0;background: #fff;z-index: 9999;}
	.popup_content .pop_txt img {max-width:100%; }
	</style>
</c:otherwise>
</c:choose>
<style>
.sample_pop .popup_header {position: relative;min-height: 112px;margin: 0 30px 0 105px;padding: 27px 0;}
.sample_pop .popup_header h2 {font-size: 21px;font-weight: 700;color: #3d3e3f;}
.sample_pop .popup_tag {display: flex;justify-content: center;align-items: center;position: absolute;left: -2px;top: -2px;width: 86px;height: 86px;font-size: 17px;font-weight: 700;line-height: 19px;color: #fff;background: linear-gradient(180deg, #0e75cf, #1395b1);}
.sample_pop .popup_content {margin: 0 30px;padding: 30px 15px;border-top: 1px solid #ccc;font-size: 14px;color: #545454;flex-grow: 1; overflow: auto;}
.sample_pop .popup_footer {display: flex;}
.sample_pop .popup_footer::after {content: '';display: block;clear: both;}
.sample_pop .popup_footer .chk {width: calc(100% - 90px);padding-left: 10px;border-top: 1px solid #ccc;font-size: 14px;line-height: 39px;}
.sample_pop .popup_footer .chk .cbx {margin: 0;}
.sample_pop .popup_footer .chk .cbx label::before {top: 2px;}
.sample_pop .btn_close {min-width: 90px;height: 40px;margin: 0;padding: 0 10px;border: 1px solid #1185C0;border-width: 1px 0 0 1px;font-size: 14px;line-height: normal;color: #3d3d3d;text-align: center;background: #fff;}
.popup_content .pop_txt {line-height: 22px;letter-spacing: -0.5px;}
</style>
<div id="display_view_sample" class="sample_pop js-popup">
	<h1 class="popup_tag">공지<br>사항</h1>
	<div class="popup_header" id="pop_header" style="word-break:break-all;">
		<h2><c:out value="${empty sampleVO.popupTtlNm ? 'Sample' : sampleVO.popupTtlNm }"/></h2>
	</div>
	<div class="popup_content" id="cont">
		<div class="pop_txt">
			<pre><c:out value="${empty sampleVO.popupCn ? 'Sample Content' : sampleVO.popupCn }" escapeXml="false"/></pre>
			<c:if test="${not empty sampleVO.imgSrc }">
				<img src="${sampleVO.imgSrc }" alt="샘플이미지" style="width:400px;">
			</c:if>
		</div>
	</div>
	<div class="popup_footer">
	    <span class="chk"><span class="cbx">
	    	<input type="checkbox" name="popUp" id="no_today">
			<label for="no_today">오늘 하루 동안 열지 않음</label>
		</span></span>
		<c:choose>
			<c:when test="${sampleVO.popupTrgtCd eq 'PT03' }">
				<button type="button" class="btn_close" onclick="view_hide('_sample');">닫기</button>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn_close" onclick="window.close();">닫기</button>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<c:if test="${sampleVO.popupTrgtCd eq 'PT03' }">
	<div class="popup_bg itemB" id="js-popup-bg" onclick="view_hide('_sample');"></div>
</c:if>