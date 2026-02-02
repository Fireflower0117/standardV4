<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
 <div class="pop_header">
      <h2>최적화 필요 태그</h2>
      <button type="button" class="pop_close" onclick="view_hide(1);"><i class="xi-close-thin"></i>닫기</button>
  </div>
  <div class="pop_content" style="max-height: 530px">
  	<form:form modelAttribute="searchVO" id="defaultFrmPop" name="defaultFrmPop" method="post" onsubmit="return false;">
		<form:hidden path="optType" />
		<form:hidden path="seoSerno" />
	</form:form>	
	<div class="popTbl">
		<table id="optTable" class="data_tbl" >
			<caption>최적화내용(단건)</caption>
			<colgroup>
				<col style="width: 40%;" />
				<col />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th>미흡사항</th>
					<th>권장 예시</th>
					<th>클립보드 복사</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
				  	<c:when test="${fn:length(subList) > 0}">
				  		<c:forEach items="${subList}" var="result" varStatus="status">
							<tr>
								<td class="ellipsis" title="<c:out value="${result.probCont }" />" ><c:out value="${result.probCont }" /></td>
							    <td class="l" id="copyText${status.index}" ><pre><c:out value="${result.probEx }"  /></pre></td>		  					
							    <td><button type="button" class="btn sml copyButton" data-row-index="${status.index}" >복사</button></td>		  					
							</tr>
						</c:forEach>
				  	</c:when>
				  	<c:otherwise>
						<tr><td colspan="3" class="">최적화할 내용이 없습니다.</td></tr>
					</c:otherwise> 
				</c:choose> 	
			</tbody>
		</table>
	</div>
	<div id="copyInfo" style="display: none;">텍스트가 클립보드에 복사되었습니다.</div>
  </div>
  <div class="pop_footer">
      <button type="button" class="btn" onclick="view_hide(1);">닫기</button>
  </div>