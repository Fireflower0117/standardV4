<%--@elvariable id="searchVO" type="com.opennote.standard.component.std.dmn.vo.CmDmnVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// Date 피커 생성
	fncDate("searchStartDate", "searchEndDate");
	<c:if test="${empty searchVO.searchStartDate && empty searchVO.searchEndDate}">
		fncSetToday("searchStartDate");
		fncSetToday("searchEndDate");
	</c:if>

	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');

	// 탭 클릭
	$('.js_tmenu li a').click(function () {
		$("#schEtc01").val($(this).data('tabcd'));
		$("#currentPageNo").val("1");
		fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
	});

	// 검색
	$('#btn_acs_search').on('click', function(){
		fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
	});
	//검색 엔터 체크
	$("#acsKeyword").keydown(function(e){
		if (e.keyCode == 13) {
			e.preventDefault();
			fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
		}
	});
});
</script>
<div class="tab wide mar_b30">
	<ul class="tab_menu js_tmenu" role="tablist">
		<li id="tab1_01" class="on" role="tab" aria-selected="true"><a href="javascript:void(0);" data-tabcd="01">전체</a></li>
		<li id="tab1_02" role="tab" aria-selected="false"><a href="javascript:void(0);" data-tabcd="02">업무시간 외 접속</a></li>
		<li id="tab1_03" role="tab" aria-selected="false"><a href="javascript:void(0);" data-tabCd="03">과다 접속자관리</a></li>
		<li id="tab1_04" role="tab" aria-selected="false"><a href="javascript:void(0);" data-tabCd="04">접속 지점이상</a></li>
	</ul>
</div>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<form:hidden path="schEtc01"/>
		<input type="hidden" name="acsLogSerno" id="acsLogSerno"/>
		<table>
			<caption>내용(기간, 영역, 검색으로 구성)</caption>
			<colgroup>
				<col class="w10p"/>
				<col class="w25p"/>
				<col class="w10p"/>
				<col class="w10p"/>
				<col class="w10p"/>
				<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>기간</label></td>
					<td>
						<span class="calendar_input"><form:input path="searchStartDate" title="시작일" readonly="true"/></span>
						<span class="gap">~</span>
						<span class="calendar_input"><form:input path="searchEndDate" title="종료일" readonly="true"/></span>
					</td>
					<td><label>영역</label></td>
					<td>
						<form:select path="schEtc00" title="영역" cssClass="w100">
							<form:option value="" label="전체"/>
							<form:option value="MA" label="관리자"/>
							<form:option value="FT" label="사용자"/>
						</form:select>
					</td>
					<td><label>검색</label></td>
					<td>
						<form:select path="searchCondition" title="구분선택" cssClass="w100">
							<form:option value="" label="전체"/>
							<form:option value="1" label="ID"/>
							<form:option value="2" label="성명"/>
						</form:select>
						<form:input path="searchKeyword" id="acsKeyword" cssClass="w300" maxlength="100"/>
					</td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
		<button type="button" class="btn btn_search" id="btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
