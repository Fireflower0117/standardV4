<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	$('.js_accBox .js_accCont').on('click', function(){
		 fncPageBoard('update', 'updateForm.do', String($(this).data('bltnbserno')), 'bltnbSerno');
	});

	<%-- FAQ 박스 조절 --%>
	$('.js_accCont').hide();
	if ($('[class*="js_accWrap"]').length) {
	     $('.js_accHead').click(function () {
	         if ($(this).parents('[class*="js_accWrap"]').hasClass('js_accWrap_each')) {
	             $(this).parents('.js_accBox').siblings('.js_accBox').removeClass('open');
	             $(this).parents('.js_accBox').siblings('.js_accBox').find('.js_accCont').stop().slideUp(200);
	         }
	         if ($(this).parents('.js_accBox').hasClass('open')) {
	             $(this).parents('.js_accBox').removeClass('open').find('.js_accCont').stop().slideUp(200);
	         } else {
	             $(this).parents('.js_accBox').addClass('open').find('.js_accCont').stop().slideDown(200);
	         }
	         return false;
	     });
	}
	
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
<div class="faq_list js_accWrap">
	<dl class="js_accBox">
	    <dt class="js_accHead">
	        <a href="javascript:void(0)">
	            <span>번호</span>
	            제목
	        </a>
	    </dt>
	</dl>
	<c:choose>
		<c:when test="${fn:length(resultList) > 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
			    <dl class="js_accBox">
			        <dt class="js_accHead">
			            <a href="javascript:void(0)">
			                <span><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/> Q.</span>
			                <p><c:out value="${result.bltnbTitl }"/></p>
			                <i class="xi-angle-down-min"></i>
			            </a>
			        </dt>
			        <dd class="js_accCont cusor"  data-bltnbserno="<c:out value='${result.bltnbSerno}'/>">
			            <span>A.</span>
			            <p><c:out value="${result.bltnbCtt }" escapeXml="false"/></p>
			        </dd>
			    </dl>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<dl class="js_accBox">
				<dt class="js_accHead c">
			    	데이터가 없습니다.
			    </dt>
			</dl>
		</c:otherwise>
	</c:choose> 
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
