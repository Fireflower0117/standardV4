<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$(".btn_list").on('click',function(){
		fncPageBoard("list", "resultPopDetailList.do", '<c:out value="${searchVO.currentPageNo}"/>');
	});
});

</script>
<div style="padding:40px;">
	<div class="page_top">
	    <h2 class="page_title">설문결과 상세보기</h2>
	    <ul class="breadcrumb">
	    	<li class="home"><i class="xi-home"></i></li>
	    	<li>사용자지원</li>
	    	<li>설문조사</li>
	    	<li>설문결과보기</li>
	    	<li class="last">설문결과 상세보기</li>
	    </ul>
	</div>
	<section id="content">
		<form:form modelAttribute="cmSrvyVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false">
			<form:hidden path="srvySerno"/>
			<form:hidden path="srvyQstSerno"/>
			<form:hidden path="srvyAnsCgVal"/>
			<form:hidden path="currentPageNo"/>
			<div class="tbl">
				<div class="tbl_wrap">
					<table class="board_write">
						<caption>내용(등록자, 등록일, 내용 등으로 구성)</caption>
						<colgroup>
							<col class="w20p">
							<col class="w30p">
							<col class="w20p">
							<col class="w30p">
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><strong>등록자</strong></th>
							<td><c:out value="${cmSrvyVO.regrNm}"/></td>
							<th scope="row"><strong>등록일</strong></th>
							<td><c:out value="${cmSrvyVO.regDt}"/></td>
						</tr>
						<tr>
							<th scope="row"><strong>내용</strong></th>
							<td colspan="3" class="ellipsis">
								<c:choose>
									<%--객관식 / 체크박스 --%>
									<c:when test="${cmSrvyVO.srvyAnsCgVal eq 3 || cmSrvyVO.srvyAnsCgVal eq 4}">
										<c:out value="${cmSrvyVO.srvyQstItmCtt eq '기타' and not empty cmSrvyVO.srvyAnsCttEtc ? cmSrvyVO.srvyQstItmCtt += '( '+= cmSrvyVO.srvyAnsCttEtc +=' )' : cmSrvyVO.srvyQstItmCtt}"/>
									</c:when>
									<%-- 이미지 --%>
									<c:when test="${cmSrvyVO.srvyAnsCgVal eq 6}">
										<img src="<c:out value="${pageContext.request.contextPath}"/>/file/getImage.do?atchFileId=<c:out value="${cmSrvyVO.srvyQstItmCtt}"/>&fileSeqo=<c:out value="${cmSrvyVO.fileSeqo}"/>&fileNmPhclFileNm=<c:out value='${cmSrvyVO.fileNmPhclFileNm}'/>" alt="image" style="width: 100%;">
									</c:when>
									<c:otherwise>
										<c:out value="${cmSrvyVO.srvyAnsCtt}"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="btn_area">
				<button type="button" class="btn btn_list">목록</button>
			</div>
		</form:form>
	</section>
</div>