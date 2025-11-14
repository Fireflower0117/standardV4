<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	<c:if test="${fn:length(resultList) > 0 }">
		$('.gallery_wrap .thum_list li a').on('click', function(){
			fncPageBoard('update', 'updateForm.do', String($(this).data('serno')), 'tmplSerno');
			return false;
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
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li>
						<a href="javascript:void(0)" data-serno="<c:out value='${result.tmplSerno}'/>" >
							<figure class="thum_img">
			                	<c:choose>
			                		<c:when test="${empty result.prvwFileSerno }">
			                			<img src="/ma/images/common/no_img.png" alt="image" class="noimage">
			                		</c:when>
			                		<c:otherwise>
			                			<img src="/tmplFile/getFileDown.do?tmplFileSerno=<c:out value='${result.prvwFileSerno}'/>&fileSeqo=0" alt="image" onerror="this.src='/ma/images/common/no_img.png';this.className='noimage';">
			                		</c:otherwise> 
			                	</c:choose>
							</figure>
							<div class="thum_txt">
							 <div class="mar_b5">
                        		<span class="state red"><c:out value="${result.tmplCl}" /></span>
                        		<span class="state blue"><c:out value="${result.tmplTp}" /></span>
                    		</div>
								<div class="tit" ><c:out value="${result.tmplExpl}" /></div>
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
