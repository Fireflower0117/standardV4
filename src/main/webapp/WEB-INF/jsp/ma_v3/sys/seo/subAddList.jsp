<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<table id="optTable" class="data_tbl" >
	<caption>최적화내용(리스트)</caption>
	<colgroup>
		<col style="width: 25%;" />
		<col style="width: 20%;" />
		<col style="width: 25%;" />
		<col/>
		<col style="width: 5%;" />
	</colgroup>
	<thead>
		<tr>
			<th>태그</th>
			<th>미흡사항</th>
			<th>권장사항</th>
			<th>권장예시</th>
			<th>클립보드 복사</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
		  	<c:when test="${fn:length(subList) > 0}">
		  		<c:forEach items="${subList}" var="result" varStatus="status" >
					<tr>
						<td class="ellipsis l" title="<c:out value="${result.probTag }" />" ><c:out value="${result.probTag }" /></td>
						<td class="ellipsis" title="<c:out value="${result.probCont }" />" ><c:out value="${result.probCont }" /></td>
						<td class="l" ><pre><c:out value="${result.probTips }" /></pre></td>					  					
						<td class="ellipsis l" title="<c:out value="${result.probEx }" />"  id="copyText${status.index}" ><c:out value="${result.probEx }"  /></td>		  					
					    <td><button type="button" class="btn sml copyButton" data-row-index="${status.index}" >복사</button></td>						  					
					</tr>
				</c:forEach>
		  	</c:when>
		  	<c:otherwise>
				<tr><td colspan="5" class="">최적화할 내용이 없습니다.</td></tr>
			</c:otherwise> 
		</c:choose> 	
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="popAdd" jsFunction="customPageBoard"/>
	</ul>
</div>	
<script>
$(function(){
	mergeCells("#optTable",1);
	mergeCells("#optTable",2);
	mergeCells("#optTable",3);
});

</script> 