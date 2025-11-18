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
        <option value=""><c:out value="${searchVO.defVal}"/></option>
    </c:if>
    <c:forEach var="result" items="${codeList}" varStatus="status">
        <option value="<c:out value="${result.cdVal}"/>" <c:if test="${searchVO.selVal eq result.cdVal}">selected="selected"</c:if>><c:out value="${result.cdNm}"/></option>
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
        <span class="cbx">
            <input type="checkbox" name="<c:out value="${searchVO.name}"/>" value="<c:out value="${result.cdVal}"/>" id="<c:out value="${id}"/>" 
            	<c:if test="${fn:indexOf(searchVO.selVal,result.cdVal) > -1}">checked="checked"</c:if> 
	            <c:if test="${searchVO.title ne null and searchVO.title ne '' }">title="<c:out value="${searchVO.title}"/>"</c:if>
	            <c:if test="${searchVO.required ne null and searchVO.required ne '' and searchVO.required eq 'true' }">required="required"</c:if>
            ><label for="<c:out value='${id}'/>"><c:out value="${result.cdNm}"/></label>
        </span>
    </c:forEach>
</c:if>

<c:if test="${searchVO.codeType eq 'radio'}">
	<c:if test="${not empty searchVO.defVal}">
		<span class="radio">
            <input type="radio" name="<c:out value="${searchVO.name}"/>"  value=""
            	<c:if test="${empty searchVO.selVal or searchVO.selVal eq null or searchVO.selVal eq '' }">checked="checked" </c:if>
            	<c:if test="${searchVO.title ne null and searchVO.title ne '' }">title="<c:out value="${searchVO.title }"/>"</c:if>
	            <c:if test="${searchVO.required ne null and searchVO.required ne '' and searchVO.required eq 'true' }">required="required"</c:if> 
            ><label><c:out value="${searchVO.defVal}"/></label>
        </span>
	</c:if>
    <c:forEach var="result" items="${codeList}" varStatus="status">
        <c:choose>
            <c:when test="${not empty searchVO.idKey}">
                <c:set var="id" value="radio_${result.cdVal}_${searchVO.idKey}"/>
            </c:when>
            <c:otherwise>
                <c:set var="id" value="radio_${result.cdVal}"/>
            </c:otherwise>
        </c:choose>
        <span class="radio">
            <input type="radio" name="<c:out value="${searchVO.name}"/>" value="<c:out value="${result.cdVal}"/>" id="<c:out value="${id}"/>" 
            	<c:if test="${searchVO.selVal eq result.cdVal}">checked="checked"</c:if>
            	<c:if test="${empty searchVO.defVal and (searchVO.selVal eq null or searchVO.selVal eq '') and status.first }">checked="checked"</c:if>
            	<c:if test="${searchVO.title ne null and searchVO.title ne '' }">title="<c:out value="${searchVO.title }"/>"</c:if>
	            <c:if test="${searchVO.required ne null and searchVO.required ne '' and searchVO.required eq 'true' }">required="required"</c:if> 
            ><label  for="<c:out value='${id}'/>"><c:out value="${result.cdNm}"/></label> 
        </span>
    </c:forEach>
</c:if>
