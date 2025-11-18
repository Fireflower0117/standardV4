<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/lib/prism/prism.css">
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/lib/prism/prism.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- 첨부파일 view 세팅 --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "view"));

	<%-- 코드 열기 클릭시 --%>
	$(".btn_code_open").click(function () {
		var code = $(this).parent().next("div");
		if (code.is(":visible")) {
			$(this).removeClass("on");
			code.hide();
		} else {
			$(this).addClass("on");
			code.show();
		}
	});

	<%-- 코드 탭 클릭시 --%>
	if ($('.js_tmenu').length || $('.js_tcont').length) {
		$('.js_tcont').hide();
		$('.js_tcont.on').show();
		$('.js_tmenu li').click(function () {
			let tabId = $(this).attr('id');
			let selTabId = $('.js_tmenu li[id="' + tabId + '"], .js_tcont[data-tab="' + tabId + '"]');
			$(this).closest('.tab').find('.js_tmenu li, .js_tcont').not('.js_tmenu li.on').removeClass('on');
			selTabId.addClass('on').fadeIn();
			selTabId.siblings('.js_tcont').hide();
			selTabId.siblings().removeClass('on');
		});
	}
});
</script>
<form:form modelAttribute="cmMnlVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="mnlSerno"/>
	<form:hidden path="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_write">
		<caption>내용(메뉴구분명, 담당자명, 메뉴설명, 첨부파일, 항목 등으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">메뉴구분명</th>
				<td><c:out value="${cmMnlVO.menuClNm }"/></td>
				<th scope="row">담당자명</th>
				<td><c:out value="${cmMnlVO.tchgrNm }"/></td>
			</tr>
			<tr>
				<th scope="row">메뉴설명</th>
				<td colspan="3"><c:out value="${cmMnlVO.menuExpl }" escapeXml="false"/></td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<div id="atchFileUpload"></div>
				</td>
			</tr>
		</tbody>
	</table>
	<div id="div_item">
		<c:if test="${fn:length(itemList) > 0}">
			<c:forEach var="item" items="${itemList }" varStatus="status">
				<div id="mnlItem_<c:out value="${status.index }"/>" class="mnlItem mar_t30">
					<c:choose>
						<c:when test="${item.mnlItmClCd eq 'title' }">
							<div class="title_type"><c:out value="${item.titlNm }"/></div>
						</c:when>
						<c:when test="${item.mnlItmClCd eq 'subTitle' }">
							<div class="subTitle_type"><c:out value="${item.subTitlNm }"/></div>
						</c:when>
						<c:when test="${item.mnlItmClCd eq 'ctt' }">
							<div class="ctt_type"><c:out value="${item.dtlsCtt }" escapeXml="false"/></div>
						</c:when>
						<c:when test="${item.mnlItmClCd eq 'code' }">
							<c:set var="fstCode"/>
							<h3 class="section_sub_ttl">코드<button class="btn ic btn_code_open">코드 열기</button></h3>
							<div class="ui_code">
								<ul class="js_tmenu">
									<c:if test="${not empty item.htmlSrcdCtt }">
										<c:if test="${empty fstCode }"><c:set var="fstCode" value="html"/></c:if>
										<li id="code0<c:out value="${status.count }"/>_html" <c:out value="${fstCode eq 'html' ? 'class=on' : ''}"/>>HTML</li>
									</c:if>
									<c:if test="${not empty item.cssSrcdCtt }">
										<c:if test="${empty fstCode }"><c:set var="fstCode" value="css"/></c:if>
										<li id="code0<c:out value="${status.count }"/>_css" <c:out value="${fstCode eq 'css' ? 'class=on' : ''}"/>>CSS</li>
									</c:if>
									<c:if test="${not empty item.jsSrcdCtt }">
										<c:if test="${empty fstCode }"><c:set var="fstCode" value="js"/></c:if>
										<li id="code0<c:out value="${status.count }"/>_js" <c:out value="${fstCode eq 'js' ? 'class=on' : ''}"/>>JS</li>
									</c:if>
									<c:if test="${not empty item.javaSrcdCtt }">
										<c:if test="${empty fstCode }"><c:set var="fstCode" value="java"/></c:if>
										<li id="code0<c:out value="${status.count }"/>_java" <c:out value="${fstCode eq 'java' ? 'class=on' : ''}"/>>JAVA</li>
									</c:if>
									<c:if test="${not empty item.xmlSrcdCtt }">
										<c:if test="${empty fstCode }"><c:set var="fstCode" value="xml"/></c:if>
										<li id="code0<c:out value="${status.count }"/>_xml" <c:out value="${fstCode eq 'xml' ? 'class=on' : ''}"/>>XML</li>
									</c:if>
								</ul>
							
								<c:if test="${not empty item.htmlSrcdCtt }">
									<div class="js_tcont<c:out value="${fstCode eq 'html' ? ' on' : ''}"/>" data-tab="code0<c:out value="${status.count }"/>_html">
										<pre><code class="line-numbers language-html"><c:out value="${item.htmlSrcdCtt }"/></code></pre>
									</div>
								</c:if>
								<c:if test="${not empty item.cssSrcdCtt }">
									<div class="js_tcont<c:out value="${fstCode eq 'css' ? ' on' : ''}"/>" data-tab="code0<c:out value="${status.count }"/>_css">
										<pre><code class="line-numbers language-css"><c:out value="${item.cssSrcdCtt }"/></code></pre>
									</div>
								</c:if>
								<c:if test="${not empty item.jsSrcdCtt }">
									<div class="js_tcont<c:out value="${fstCode eq 'js' ? ' on' : ''}"/>" data-tab="code0<c:out value="${status.count }"/>_js">
										<pre><code class="line-numbers language-js"><c:out value="${item.jsSrcdCtt }"/></code></pre>
									</div>
								</c:if>
								<c:if test="${not empty item.javaSrcdCtt }">
									<div class="js_tcont<c:out value="${fstCode eq 'java' ? ' on' : ''}"/>" data-tab="code0<c:out value="${status.count }"/>_java">
										<pre><code class="line-numbers language-java"><c:out value="${item.javaSrcdCtt }"/></code></pre>
									</div>
								</c:if>
								<c:if test="${not empty item.xmlSrcdCtt }">
									<div class="js_tcont<c:out value="${fstCode eq 'xml' ? ' on' : ''}"/>" data-tab="code0<c:out value="${status.count }"/>_xml"><pre><code class="line-numbers language-xml"><c:out value="${item.xmlSrcdCtt }"/></code></pre></div>
								</c:if>
							</div>
						</c:when>
						<c:when test="${item.mnlItmClCd eq 'img' }">
							<div class="file_img">
	                            <c:choose>
	                                <c:when test="${not empty item.imgList }">
	                                    <c:forEach var="img" items="${item.imgList }">
	                                        <img src="/file/getImage.do?atchFileId=<c:out value="${item.atchFileId }"/>&fileSeqo=<c:out value="${img.fileSeqo}"/>&fileNmPhclFileNm=<c:out value="${img.fileNmPhclFileNm}"/>" id="viewImage" alt="항목 이미지" width="100%">
	                                    </c:forEach>
	                                </c:when>
	                                <c:otherwise>
	                                    파일이 없습니다.
	                                </c:otherwise>
	                            </c:choose>
	                        </div>
						</c:when>
						<c:when test="${item.mnlItmClCd eq 'url' }">
							<a href="<c:out value="${item.urlAddr }"/>" class="url_type" target="_blank"><c:out value="${item.urlAddr }"/></a>
						</c:when>
					</c:choose>
				</div>
			</c:forEach>
		</c:if>
	</div>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY || searchVO.loginSerno eq cmMnlVO.regrSerno}">
		<button type="button" id="btn_update" class="btn blue">수정</button>
		<button type="button" id="btn_del" class="btn red">삭제</button>
	</c:if>
	<a href="javascript:void(0)" id="btn_list" class="btn gray">목록</a>
</div>