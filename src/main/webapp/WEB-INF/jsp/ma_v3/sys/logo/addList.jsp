<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 데이터 없을때 td colspan 잡기 --%>
	fncColLength();

	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function(){
			fncPageBoard('view', 'view.do', String($(this).closest('tr').data('serno')), 'logoSerno');
			return false;
		});
	</c:if>

	$('#btn_write').on('click', function(){
		fncPageBoard('write', 'insertForm.do');
	});

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

});
</script>
<div class="board_top">
<div class="board_left">
	<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
</div>
<div class="board_right">
	<button type="button" id="btn_excel" class="btn btn_excel">엑셀 다운로드</button>
	<jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
</div>
</div>
<table class="board_list">
	<caption>목록(항목, 이미지, 링크여부, URL, 대상, 활성화여부, 등록일로 구성)</caption>
	<colgroup>
		<col class="w5p">
		<col class="w8p">
		<col class="w10p">
		<col class="w5p">
		<col>
		<col class="w8p">
		<col class="w8p">
		<col class="w10p">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">항목</th>
			<th scope="col">이미지</th>
			<th scope="col">링크여부</th>
			<th scope="col">URL</th>
			<th scope="col">대상</th>
			<th scope="col">활성화여부</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${fn:length(resultList) > 0 }">
			<c:forEach items="${resultList }" var="result" varStatus="status">
				<tr data-serno="<c:out value='${result.logoSerno}'/>">
					<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
					<td class="ellipsis c"><c:out value="${result.itmNm }"/></td>
					<td class="ellipsis l">
						<img src="/file/getByteImage.do?atchFileId=<c:out value='${result.atchFileId}'/>&fileSeqo=<c:out value='${result.fileSeqo}'/>&fileNmPhclFileNm=<c:out value='${result.fileNmPhclFileNm}'/>" alt="로고" width="100%" height="100%">
					</td>
					<td><c:out value="${result.lnkYn eq 'Y'? '유' : '무'}"/></td>
					<td class="ellipsis l"><a href="#" class="ellipsis td_view"><c:out value="${empty result.url ? '-' : result.url}"/></a></td>
					<td><c:out value="${result.lnkTgtCd eq 'self' ? '현재창' : result.lnkTgtCd eq 'blank' ? '새창' : '-'}"/></td>
					<td><c:out value="${result.actvtYn eq 'Y'? '활성화' : '비활성화'  }"/></td>
					<td><c:out value="${result.regDt }"/></td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td class="no_data" colspan="7">등록된 내역이 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
	<div class="btn_right">
		<button type="button" id="btn_write" class="btn blue btn_write">등록</button>
	</div>
</div>
