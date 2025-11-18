<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
	<h2>첨부파일</h2>
	<button type="button" class="pop_close" onclick="modal_hide_all();"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="overflow-y:auto;">
	<div class="tbl_wrap">
		<table class="board_col_type01">
			<caption>내용(첨부파일 목록)</caption>
			<colgroup>
				<col style="width: 10%;">
				<col>
				<col style="width: 20%;">
				<col style="width: 10%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">파일명</th>
					<th scope="col">등록일</th>
					<th scope="col">다운로드</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) gt 0 }">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td style="cursor: default;"><c:out value="${status.count}"/></td>
							<td class="l" style="cursor: default;">
								<a  style="cursor: pointer;" onclick="fileByteDown('${result.atchFileId}','${result.fileSeqo}','${result.fileNm}');">
									<img src="/component/itsm/images/sub/file_img.png"><c:out value="${result.fileNm}"/>
								</a>
							</td>
							<td style="cursor: default;"><c:out value="${result.regDt}"/></td>
							<td><a href="javascript:void(0)" class="btn btn_down" onclick="fileByteDown('${result.atchFileId}','${result.fileSeqo}','${result.fileNm}');"><span></span></a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="4">파일이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
</div>
<script type="text/javaScript">
$(document).ready(function(){

});

</script>