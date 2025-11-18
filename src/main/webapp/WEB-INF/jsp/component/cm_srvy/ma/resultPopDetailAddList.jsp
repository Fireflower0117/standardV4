<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">

<%-- no_data 처리 --%>
fncColLength();

$(function(){
	<%-- 상세보기 이동 --%>
	$(".moveView").on("click", function () {
    	fncFormSubmit($(this).data("srvyansserno"),$(this).data("srvyanscgval"));
    });
});
</script>
<div class="board_top">
    <div class="board_left">
    	<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
</div>
<table class="board_list">
    <caption>목록(번호,응답내용,작성자,등록일로 구성)</caption>
    <colgroup>
        <col class="w4p">
        <col>
        <col class="w10p">
        <col class="w15p">
    </colgroup>
    <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">응답내용</th>
            <th scope="col">작성자</th>
            <th scope="col">등록일</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${fn:length(rplyList) > 0}">
                <c:forEach var="result" items="${rplyList}" varStatus="status">
                	<tr class="${result.srvyAnsCgVal ne '5' ? 'moveView' : '' }" data-srvyansserno="<c:out value="${result.srvyAnsSerno}"/>" data-srvyanscgval="<c:out value="${result.srvyAnsCgVal}"/>">
                        <td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.currentPageNo-1) * searchVO.recordCountPerPage + status.count)}"/></td>
                        <td class="ellipsis">
                        	<c:choose>
                    			<c:when test="${result.srvyAnsCgVal eq '3' or result.srvyAnsCgVal eq '4'}">
                    				<c:out value="${result.srvyQstItmCtt eq '기타' and not empty result.srvyAnsCttEtc ? result.srvyQstItmCtt += '( '+= result.srvyAnsCttEtc +=' )' : result.srvyQstItmCtt }"/>
                    			</c:when>
                    			<c:when test="${result.srvyAnsCgVal eq '6'}">
                    				<img src="<c:out value="${pageContext.request.contextPath}"/>/file/getImage.do?atchFileId=<c:out value="${result.srvyQstItmCtt}"/>&fileSeqo=<c:out value="${result.fileSeqo}"/>&fileNmPhclFileNm=<c:out value='${result.fileNmPhclFileNm}'/>" alt="image" style="width: 60%;">
                    			</c:when>
                    			<c:when test="${result.srvyAnsCgVal eq '5'}">
                    				<c:choose>
                                        <c:when test="${not empty result.atchFileList}">
                                            <c:forEach var="file" items="${result.atchFileList}">
                                                <li>
                                                    <a href="${pageContext.request.contextPath}/file/down.do?atchFileId=<c:out value="${file.atchFileId}"/>&fileSeqo=<c:out value="${file.fileSeqo}"/>&fileRlNm=<c:out value="${file.fileRlNm}"/>"><c:out value="${file.fileRlNm}"/></a>
                                                </li>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise><li>파일이 없습니다.</li></c:otherwise>
                                    </c:choose>
                    			</c:when>
                    			<c:otherwise>
                    				<c:out value="${result.srvyAnsCtt}"/>
                    			</c:otherwise>
                    		</c:choose>
                        </td>
                        <td><c:out value="${result.regrNm}"/></td>
                        <td><c:out value="${result.regDt}"/></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td class="no_data">데이터가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
<div class="paging_wrap">
	<div class="paging">
    	<ui:pagination paginationInfo="${paginationInfo}" type="popLayout" jsFunction="fncPageBoard" />
    </div>
</div>