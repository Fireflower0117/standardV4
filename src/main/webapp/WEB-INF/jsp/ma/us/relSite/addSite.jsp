<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div id="relSite_$idx$" class="mar_t30">
	<div class="board_top">
	    <div class="board_right">
	       	<button type="button" class="btn ic btn_addSite"><i class="xi-plus"></i></button>
	       	<button type="button" class="btn ic btn_delSite"><i class="xi-trash"></i></button>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(URL주소, 사이트명으로 구성)</caption>
		<colgroup>
			<col class="w20p">
	           <col>
	           <col class="w20p">
	           <col>
		</colgroup>
		<tbody>
			<tr>
			    <th scope="row"><span class="asterisk">*</span>URL주소</th>
			    <td>
			    	<input type="hidden" id="relSiteSerno_$idx$"/>
			    	<input type="hidden" id="seqo_$idx$"/>
			    	<input type="text" id="relSiteUrlAddr_$idx$" class="w100p" title="URL주소" maxlength="300" required="true"/>
			    </td>
			    <th scope="row" rowspan="2">사이트 이미지</th>
			    <td rowspan="2">
			    	<input type="hidden" id="atflSerno_$idx$"/>
			    	<div id="atchFileUpload_$idx$"></div>
			    </td>
			</tr>
			<tr>
			    <th scope="row"><span class="asterisk">*</span>사이트명</th>
			    <td>
			    	<input type="text" id="relSiteNm_$idx$" class="w100p" title="사이트명" maxlength="30" required="true"/>
			    </td>
			</tr>
		</tbody>
	</table>
</div>