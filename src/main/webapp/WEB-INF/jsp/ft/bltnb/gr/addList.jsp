<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	$('.gallery_wrap .thum_list li a').on('click', function(){
		 fncPageBoard('view', 'view.do', String($(this).data('serno')), 'bltnbSerno');
	});
})
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="gallery_wrap">
	<ul class="thum_list">
		<c:choose>
			<c:when test="${not empty resultList}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li>
					 	<a href="javascript:void(0)" data-serno="<c:out value='${result.bltnbSerno}'/>">
							<figure class="thum_img">
								<c:choose>
									<c:when test="${not empty result.atchFileId and not empty result.fileSeqo}">
										<img src="${pageContext.request.contextPath}/file/getImage.do?atchFileId=<c:out value='${result.atchFileId}'/>&fileSeqo=<c:out value='${result.fileSeqo}'/>&fileNmPhclFileNm=<c:out value='${result.fileNmPhclFileNm}'/>" onerror="this.src='${pageContext.request.contextPath}/ma/images/common/no_img.png" alt="image"/>
									</c:when>
									<c:otherwise>
										<img src="${pageContext.request.contextPath}/ma/images/common/no_img.png" alt="image"/>
									</c:otherwise>
								</c:choose>
							</figure>
							<div class="thum_txt">
								<div class="tit" ><c:out value="${result.bltnbTitl}" /></div>
								<div class="date"><c:out value="${result.regDt}" /></div>
							</div>
						</a>
					</li>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<li class="no-data">데이터가 없습니다.</li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
</div>
