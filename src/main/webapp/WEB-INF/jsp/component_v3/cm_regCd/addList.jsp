<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	$("colgroup").each(function(idx){
		$(this).nextAll('tbody:first').find(".no_data").attr("colspan", $(this).children("col").length);
	});

	<%-- 페이지당 건수 변경시 --%>
	$('#recordCountPerPage_board_right').on('change', function() {
		if($('#recordCountPerPage_board_right').val()) {
			$('#recordCountPerPage').val($('#recordCountPerPage_board_right').val());
		}
		fncPageBoard('list','list.do',1);
	});

	$('#cm_btn_big_excel').on('click', function(){
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				cmFncLoadStart();
				$.fileDownload("bigExcelDownload.do", {
					httpMethod : "POST",
					data : $("#defaultFrm").serialize(),
					successCallback : function(url){
						cmFncLoadEnd();
						return false;
					},
					failCallback : function(responseHtml, url, error){
						alert("엑셀 다운로드가 실패하였습니다");
						cmFncLoadEnd();
						return false;
					}
				});
			</c:when>
			<c:otherwise>
				alert("데이터가 없습니다");
				return false;
			</c:otherwise>
		</c:choose>
	});

	$('#cm_btn_cd_update').on('click', function(){
		cmFncLoadStart();

		$.ajax({
			method: "POST",
			url: "regUpdate",
			data: $("#defaultFrm").serialize(),
			dataType: "text",
			success: function(data) {
				alert(data);
				cmFncAddList();
			},
			complete : function(){
				cmFncLoadEnd();
			}
		});
	});

});

</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
		<button class="btn" id="cm_btn_cd_update"><i class="xi-renew"></i>&nbsp;법정동코드 갱신</button>
		<button class="btn btn_excel" id="cm_btn_big_excel">대용량 엑셀 다운로드</button>
		<select id="recordCountPerPage_board_right">
			<option value="10" label="10건" ${searchVO.recordCountPerPage eq '10' ? 'selected="selected"' : '' }/>
			<option value="20" label="20건" ${searchVO.recordCountPerPage eq '20' ? 'selected="selected"' : '' }/>
			<option value="30" label="30건" ${searchVO.recordCountPerPage eq '30' ? 'selected="selected"' : '' }/>
			<option value="50" label="50건" ${searchVO.recordCountPerPage eq '50' ? 'selected="selected"' : '' }/>
		</select>
    </div>
</div>
<table class="board_list">
	<caption>목록(번호, 법정동코드, 시도, 시군구, 읍면동, 리, 레벨로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col class="w10p"/>
		<col/>
		<col/>
		<col/>
		<col/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">법정동코드</th>
			<th scope="col">시도</th>
			<th scope="col">시군구</th>
			<th scope="col">읍면동</th>
			<th scope="col">리</th>
			<th scope="col">레벨</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr class="no_cursor">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.regCd}"/></td>
						<td><c:out value="${result.sidoNm}"/></td>
						<td><c:out value="${empty result.cggNm ? '-' : result.cggNm}"/></td>
						<td><c:out value="${empty result.umdNm ? '-' : result.umdNm}"/></td>
						<td><c:out value="${empty result.riNm ? '-' : result.riNm}"/></td>
						<td><c:out value="${result.lvl}"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="no_cursor">
					<td class="no_data" colspan="6">데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
</div>
<div class="popup_bg" id="js_popup_bg"></div>