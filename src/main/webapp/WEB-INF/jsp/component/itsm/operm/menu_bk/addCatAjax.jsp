<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp" />
<script type="text/javaScript">
$(document).ready(function(){

});
</script>
<form:form modelAttribute="searchVO" id="defaultFrm_2" name="defaultFrm" method="post">
	<input type="hidden" name="uppoCdVal" id="uppoCdVal"/>
	<input type="hidden" name="cdLvlVal" id="cdLvlVal" />
	<div class="pop_header">
		<h2>메뉴 카테고리 추가</h2>
		<a href="javascript:void(0);" class="pop_close" onclick="modal_hide(this);"><i class="xi-close-thin"></i></a>
	</div>
	<div class="pop_content">
		<div class="board_write">
	        <table class="board_row_type01">
	            <colgroup>
	                <col style="width:20%">
	                <col style="width:80%">
	            </colgroup>
	            <tbody>
	                <tr>
	                    <th><strong class="th_tit">메뉴코드</strong></th>
	                    <td>
	                    	<input type="text" id="cdVal" name="cdVal" placeholder="ma, ft, my ..." style="width: 100%;">
	                   	</td>
	                </tr>
	                <tr>
	                    <th><strong class="th_tit">메뉴명</strong></th>
	                    <td>
	                    	<input type="text" id="cdValNm" name="cdValNm" placeholder="관리자, 사용자, 마이페이지 ....." style="width: 100%;">
	                   	</td>
	                </tr>
	            </tbody>
	        </table>
	    </div>
	</div>
	<div class="pop_footer">
		<a href="javascript:void(0)" class="btn btn_mdl btn_write" onclick="fncCdAdd('insert','MCMG','3','')">등록</a>
		<a href="javascript:void(0)" class="btn btn_mdl btn_cancel" onclick="modal_hide(this);">취소</a>
	</div>
</form:form>
<script type="text/javaScript">
</script>