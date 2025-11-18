<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:choose>
<%-- 팝업 대상 새탭 css --%>
<c:when test="${maPopVO.popupTrgtCd eq 'PT01' }">
	<style>
	.notice_pop {position: absolute;left: 0;top: 0;border: 2px solid #1185C0;background: #fff;z-index: 9999;height:100%;width: 100%;display: flex;flex-direction: column;}
	.pop_content .pop_txt img {max-width:800px; display:block; margin:0 auto;}
	</style>
</c:when>
<%-- 팝업 대상 새창 css --%>
<c:when test="${maPopVO.popupTrgtCd eq 'PT02' }">
	<style>
	.notice_pop {position: absolute;left: 0;top: 0;border: 2px solid #1185C0;background: #fff;z-index: 9999;height:100%;width: 100%;display: flex;flex-direction: column;}
	.pop_content .pop_txt img {max-width:100%; }
	</style>
</c:when>
<%-- 팝업 대상 모달창 css --%>
<c:otherwise>
	<style>
	.notice_pop {position: absolute;left: 0;top: 0;border: 2px solid #1185C0;background: #fff;z-index: 9999;}
	.pop_content .pop_txt img {max-width:100%; }
	</style>
</c:otherwise>
</c:choose>
<style>
.notice_pop .pop_header2 {position: relative;min-height: 112px;margin: 0 30px 0 105px;padding: 27px 0;}
.notice_pop .pop_header2 h2 {font-size: 21px;font-weight: 700;color: #3d3e3f;}
.notice_pop .pop_tag {display: flex;justify-content: center;align-items: center;position: absolute;left: -2px;top: -2px;width: 86px;height: 86px;font-size: 17px;font-weight: 700;line-height: 19px;color: #fff;background: linear-gradient(180deg, #0e75cf, #1395b1);}
.notice_pop .pop_content {margin: 0 30px;padding: 30px 15px;border-top: 1px solid #ccc;font-size: 14px;color: #545454;flex-grow: 1; overflow: auto;}
.notice_pop .pop_footer {display: flex;}
.notice_pop .pop_footer::after {content: '';display: block;clear: both;}
.notice_pop .pop_footer .chk {width: calc(100% - 90px);padding-left: 10px;border-top: 1px solid #ccc;font-size: 14px;line-height: 39px;}
.notice_pop .pop_footer .chk .cbx {margin: 0;}
.notice_pop .pop_footer .chk .cbx label::before {top: 10px;}
.notice_pop .btn_close {min-width: 90px;height: 40px;margin: 0;padding: 0 10px;border: 1px solid #1185C0;border-width: 1px 0 0 1px;font-size: 14px;line-height: normal;color: #3d3d3d;text-align: center;background: #fff;}
.pop_content .pop_txt {line-height: 22px;letter-spacing: -0.5px;}
</style>
<div id="display_view${maPopVO.popupSn }" class="notice_pop js-popup w500px" style="touch-action:none">
	<h1 class="pop_tag">공지<br>사항</h1>
	<div class="pop_header2" id="header${maPopVO.popupSn}" style="word-break:break-all;">
		<h2><c:out value="${maPopVO.popupTtlNm}"/></h2>
	</div>
	<div class="pop_content" id="cont${maPopVO.popupSn}" style="overflow-y:auto;">
		<div class="pop_txt">
			<pre><c:out value="${maPopVO.popupCn}" escapeXml="false"/></pre>
			<c:if test="${not empty maPopVO.rprsImgFileId }">
				<img src="/itsm/file/getByteImage.do?atchFileId=${maPopVO.rprsImgFileId }&fileSeqo=${maPopVO.fileSeqo}" alt="샘플이미지">
			</c:if>
		</div>
	</div>
	<div class="pop_footer" style="padding: 0 0px 0px 0px;text-align:left;">
	    <span class="chk"><span class="cbx">
			<c:choose>
			<c:when test="${maPopVO.popupTrgtCd eq 'PT03' }">
	    		<input type="checkbox" name="popUp${maPopVO.popupSn}" id="no_today_${maPopVO.popupSn}" onclick="closePopup('${maPopVO.popupSn}','modal')">
	    	</c:when>
	    	<c:otherwise>
	    		<input type="checkbox" name="popUp${maPopVO.popupSn}" id="no_today_${maPopVO.popupSn}" onclick="closeWinPopup('${maPopVO.popupSn}')">
	    	</c:otherwise>
	    	</c:choose>
			<label for="no_today_${maPopVO.popupSn}">오늘 하루 동안 열지 않음</label>
		</span></span>
		<c:choose>
			<c:when test="${maPopVO.popupTrgtCd eq 'PT03' }">
				<button type="button" class="btn_close" onclick="view_hide2('${maPopVO.popupSn}');">닫기</button>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn_close" onclick="window.close();">닫기</button>
			</c:otherwise>
		</c:choose>
	</div>
</div>