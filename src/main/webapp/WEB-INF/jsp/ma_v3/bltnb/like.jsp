<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<input type="hidden" name="rcmdSerno" id="rcmdSerno" value="<c:out value='${rcmdVO.rcmdSerno}'/>">
<input type="hidden" id="rcmdYn" value="<c:out value='${rcmdVO.rcmdYn}'/>">    
<span class="like">
    <input type="radio" name="rcmdYn" id="likeit_y" value="Y" ${rcmdVO.rcmdYn eq 'Y' ? 'checked=checked' :'' } disabled="disabled" style="cursor:default!important;"><label for="likeit_y" style="cursor:default!important">추천</label>
    <span class="num"><c:out value="${rcmdVO.rcmdYCnt}"/></span>
</span>
<span class="dislike">
    <input type="radio" name="rcmdYn" id="likeit_n" value="N" ${rcmdVO.rcmdYn eq 'N' ? 'checked=checked' :'' } disabled="disabled" style="cursor:default!important"><label for="likeit_n" style="cursor:default!important">반대</label>
    <span class="num"><c:out value="${rcmdVO.rcmdNCnt}"/></span>
</span>
