<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();

	// 첨부파일 등록폼 생성
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "excel"));

	// 상세 페이지 이동
	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr, a.td_view').on('click', function(){
			fncPageBoard('view', 'view.do', String($(this).closest('tr').data('serno')), 'termSerno');
			return false;
		});
	</c:if>

	// 엑셀 다운로드
	$('#cm_btn_excel').on('click', function(){
		fncLoadingStart();
		$.fileDownload("excelDownload.do", {
			httpMethod : "POST",
			data : $("#defaultFrm").serialize(),
			successCallback : function(url){
				fncLoadingEnd();
				return false;
			},
			failCallback : function(responseHtml, url, error){
				alert("엑셀 다운로드가 실패하였습니다");
				fncLoadingEnd();
				return false;
			}
		});
	});

	// 엑셀 업로드 샘플 다운로드
	$("#btn_sample").on('click', function () {
		$("#defaultFrm").attr({"action" : "excelSample.do", "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
	});

	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		// 등록 버튼
		$('#cm_btn_write').on('click', function(){
			fncPageBoard('write', 'insertForm.do');
		});

		// 엑셀 업로드
	$("#cm_btn_excel_up").on('click', function () {
		if (!$("#excelFileInfo").val() || !$("#excelFileTemp").val()) {
			alert('파일을 선택해주세요');
			return;
		}

		fileFormSubmit("defaultFrm", "insert", function () {
			$.ajax({
				type: 'post',
				url: 'excelProc',
				data: {atchFileId : $("#atchFileId").val()},
				success: function (data) {
					alert(data.message);
				},
				error: function (xhr) {
					if (xhr.status == 401) {
						window.location.reload();
					}
					alert(xhr.responseJSON.message);
				},
				beforeSend: function(){
					fncLoadingStart();
				},
				complete: function(){
					fncLoadingEnd();
					return false;
				}
			});
		}, 'NO_DEL');
	});
	</c:if>

	// 엑셀업로드 팝업
	$('#btn_excel_up').on('click', function(){
		view_show(1);
	});
	// 팝업 닫기
	$('#btn_pop_close, .pop_close').on('click', function(){
		view_hide(1);
	});

});

</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
        <button class="btn btn_excel" id="cm_btn_excel">엑셀 다운로드</button>
		<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
			<button type="button" class="btn" id="btn_excel_up">엑셀 업로드</button>
		</c:if>
		<jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
	<caption>내용(용어명, 용어영문명, 도메인명, 도메인그룹, 표준여부, 용어설명, 데이터타입, 길이, 최종변경일로 구성)</caption>
	<colgroup>
		<col class="w5p"/>
		<col/>
		<col/>
		<col class="w10p"/>
		<col class="w10p"/>
		<col class="w5p"/>
		<col/>
		<col class="w5p"/>
		<col class="w5p"/>
		<col class="w7p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">용어명</th>
			<th scope="col">용어영문명</th>
			<th scope="col">도메인명</th>
			<th scope="col">도메인그룹</th>
			<th scope="col">표준여부</th>
			<th scope="col">용어설명</th>
			<th scope="col">데이터타입</th>
			<th scope="col">길이</th>
			<th scope="col">최종변경일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-serno="<c:out value='${result.termSerno}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td class="l ellipsis"><a href="#" class="ellipsis td_view"><c:out value="${result.termNm}"/></a></td>
						<td class="l ellipsis"><c:out value="${result.termEngNm}"/></td>
						<td class="l"><c:out value="${result.dmnNm}"/></td>
						<td><c:out value="${result.dmnGrp}"/></td>
						<td>
							<c:choose>
								<c:when test="${result.stdYn eq 'Y'}">표준</c:when>
								<c:when test="${result.stdYn eq 'N'}">비표준</c:when>
							</c:choose>
						</td>
						<td class="l ellipsis"><c:out value="${result.termExpl}"/></td>
						<td><c:out value="${result.dataTp}"/></td>
						<td>
							<c:out value="${result.dataLen}"/><c:if test="${!empty result.dataLenDcpt}">, <c:out value="${result.dataLenDcpt}"/></c:if>
						</td>
						<td><c:out value="${result.updDt}"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="10">데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
	<div class="btn_right">
		<button type="button" id="cm_btn_write" class="btn blue">등록</button>
	</div>
</c:if>
</div>

<div id="display_view1" class="layer_pop js_popup w700px">
	<div class="pop_header">
		<h2>엑셀 업로드</h2>
		<button type="button" class="pop_close" onclick="view_hide(1);"><i class="xi-close-thin"></i>닫기</button>
	</div>
	<div class="pop_content" style="max-height: 300px;" data-simplebar data-simplebar-auto-hide="false">
		<table class="board_write">
			<colgroup>
				<col style="width: 30%;">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="asterisk">*</span>엑셀업로드</th>
					<td>
						<div id="atchFileUpload"></div>
					</td>
				</tr>
				<tr>
					<th scope="row">엑셀샘플</th>
					<td>
						<button type="button" class="btn" id="btn_sample">샘플 다운로드</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="pop_footer">
		<button type="button" class="btn blue" id="cm_btn_excel_up">업로드</button>
		<button type="button" class="btn" id="btn_pop_close">닫기</button>
	</div>
</div>
<div class="popup_bg" id="js_popup_bg"></div>