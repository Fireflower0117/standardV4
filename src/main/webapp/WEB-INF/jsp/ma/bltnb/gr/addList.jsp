<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<c:if test="${fn:length(resultList) > 0 }">
		$('.gallery_wrap .thum_list li a').on('click', function(){
			 fncPageBoard('view', 'view.do', String($(this).data('bltnbserno')), 'bltnbSerno');
		});
	</c:if>
	
	<%-- 등록버튼 클릭시 --%>
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		$('#btn_write').on('click', function(){
			fncPageBoard('write', 'insertForm.do');
		});
	</c:if>
	
	<%-- 엑셀 다운로드 --%>
	$('#btn_excel').on('click', function(){
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				fncPageBoard("view", "excelDownload.do");
				$("#defaultFrm").attr("onsubmit","return false;");
			</c:when>
			<c:otherwise>
				alert("데이터가 없습니다");
				return false;
			</c:otherwise>
		</c:choose>	
	});
})
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
    	<button class="btn btn_excel" id="btn_excel">엑셀 다운로드</button>
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="gallery_wrap">
	<ul class="thum_list">
		<c:choose>
			<c:when test="${not empty resultList}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li>
					 	<a href="javascript:void(0)" data-bltnbserno="<c:out value='${result.bltnbSerno}'/>">
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
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<div class="btn_right">
			<button type="button" id="btn_write" class="btn blue">등록</button>
		</div>
	</c:if>
</div>
