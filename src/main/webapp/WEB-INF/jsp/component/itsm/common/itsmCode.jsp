<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
    $(document).ready(function(){
        <c:if test="${empty searchVO.selVal and not empty searchVO.defVal and searchVO.codeType ne 'select' }">
        $("input[name=${searchVO.name}]").each(function(){
            if($(this).val() == "${searchVO.defVal}"){
                $(this).prop("checked", true);
            }
        })
        </c:if>
    })
</script>
<c:if test="${searchVO.codeType eq 'select'}">
    <c:if test="${not empty searchVO.defVal}">
        <option value="">${searchVO.defVal}</option>
    </c:if>
    <c:forEach var="result" items="${codeList}" varStatus="status">
        <option value="${result.cdVal}" <c:if test="${searchVO.selVal eq result.cdVal}">selected="selected"</c:if>>${result.cdValNm}</option>
    </c:forEach>
</c:if>
<c:if test="${searchVO.codeType eq 'check'}">
    <c:forEach var="result" items="${codeList}" varStatus="status">
        <c:choose>
            <c:when test="${not empty searchVO.idKey}">
                <c:set var="id" value="check_${result.cdVal}_${searchVO.idKey}"/>
            </c:when>
            <c:otherwise>
                <c:set var="id" value="check_${result.cdVal}"/>
            </c:otherwise>
        </c:choose>
        <label class="chkbox2">
            <input type="checkbox" name="${searchVO.name}" value="${result.cdVal}" id="${id}" 
            	<c:if test="${fn:indexOf(searchVO.selVal,result.cdVal) > -1}">checked="checked"</c:if> 
	            <c:if test="${searchVO.title ne null and searchVO.title ne '' }">title="${searchVO.title }"</c:if>
	            <c:if test="${searchVO.required ne null and searchVO.required ne '' and searchVO.required eq 'true' }">required="required"</c:if>
            >
            <span>${result.cdValNm}</span>
        </label>
    </c:forEach>
</c:if>
<c:if test="${searchVO.codeType eq 'radio'}">
	<c:if test="${not empty searchVO.defVal}">
		<label class="radio">
            <input type="radio" name="${searchVO.name}"  value=""
            	<c:if test="${empty searchVO.selVal or searchVO.selVal eq null or searchVO.selVal eq '' }">checked="checked" </c:if>
            	<c:if test="${searchVO.title ne null and searchVO.title ne '' }">title="${searchVO.title }"</c:if>
	            <c:if test="${searchVO.required ne null and searchVO.required ne '' and searchVO.required eq 'true' }">required="required"</c:if> 
            >
            <span>${searchVO.defVal}</span>
        </label>
	</c:if>
    <c:forEach var="result" items="${codeList}" varStatus="status">
        <c:choose>
            <c:when test="${not empty searchVO.idKey}">
                <c:set var="id" value="check_${result.cdVal}_${searchVO.idKey}"/>&nbsp&nbsp
            </c:when>
            <c:otherwise>
                <c:set var="id" value="check_${result.cdVal}"/>
            </c:otherwise>
        </c:choose>
        <label class="radio">
            <input type="radio" name="${searchVO.name}" value="${result.cdVal}" id="${id}" 
            	<c:if test="${searchVO.selVal eq result.cdVal}">checked="checked"</c:if>
            	<c:if test="${empty searchVO.defVal and (searchVO.selVal eq null or searchVO.selVal eq '') and status.first }">checked="checked"</c:if>
            	<c:if test="${searchVO.title ne null and searchVO.title ne '' }">title="${searchVO.title }"</c:if>
	            <c:if test="${searchVO.required ne null and searchVO.required ne '' and searchVO.required eq 'true' }">required="required"</c:if> 
            >
            <span>${result.cdValNm}</span>
        </label>
    </c:forEach>
</c:if>
