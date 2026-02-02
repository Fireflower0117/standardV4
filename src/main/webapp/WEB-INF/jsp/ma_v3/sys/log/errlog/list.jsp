<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

	<%-- Date 피커 생성 --%>
	fncDate("searchStartDate", "searchEndDate");

	<c:if test="${empty searchVO.searchStartDate and empty searchVO.searchEndDate}">
		fncSetToday("searchStartDate");
		fncSetToday("searchEndDate");
	</c:if>

	<%-- 체크박스 검색조건 유지 --%>
	fnMltiSelect();

	fncPageBoard('addList', 'addList.do', '<c:out value="${searchVO.currentPageNo}"/>');

	var multiSelect = $(".multiSelect .multi_show");
	var html = '';
	var firstVal = $(".multiSelect .multi_option").find(".default").text();
	$(".multiSelect .multi_default").text(firstVal); // select의 초기값을 default값으로

	$(".multiSelect .multi_text").click(function () {
		$(".multiSelect .multi_option").slideToggle(150);
		$(".multiSelect").toggleClass("on");
	});

	$('.multiSelect input[type="checkbox"]').click(function () {
		if ($(this).is(':checked')) {
			$(".multi_default").hide();
			html = "<span class='multi_" + $(this).val() + "'>" + $(this).val()+ "</span>";
			multiSelect.append(html); // 클릭한 checkbox의 값을 select에 출력
		} else {
			$("span.multi_" + $(this).val()).remove();
		}

		if ($('.multi_show').children().length === 0) { // check된 것이 없다면 기본 텍스트로 변경
			$(".multi_default").show();
		}
	});

	// 검색초기화
	$("#btn_reset").click(function(){
		for(var i = 0 ; i < document.defaultFrm.elements.length ; i++){
			var el = document.defaultFrm.elements[i];

			if(el.id === "searchStartDate" || el.id === "searchEndDate"){
				fncSetToday("searchStartDate");
				fncSetToday("searchEndDate");
				continue;
			}
			if($('#'+el.id).attr('type') == "hidden"){
				continue;
			}
			// 체크박스 초기화
			if($('#'+el.id).attr('type') == "checkbox"){
				$('#'+el.id).prop("checked", "");
				continue;
			}
			// 라디오 박스 초기화 (처음 값 선택)
			if($('#'+el.id).attr('type') == "radio"){
				$('input:radio[name='+el.name+']').eq(0).attr("checked", "checked");
				continue;
			}
			el.value = "";
		}

		// multiSelect 초기화
		$(".multi_show").empty();
		$(".multi_default").show();

		// 페이지별 출력 건수 초기화
		$('#recordCountPerPage_board_right').val('10');
	});
});

const fnMltiSelect = function () {
	var multiSelect = $(".multiSelect .multi_show");
	var html = '';
	var firstVal = $(".multiSelect .multi_option").find(".default").text();
	$('.multiSelect input[type="checkbox"]').each(function () {
		if ($(this).is(':checked')) {
			$(".multi_default").hide();
			html = "<span class='multi_" + $(this).val() + "'>" + $(this).val()+ "</span>";
			multiSelect.append(html); // 클릭한 checkbox의 값을 select에 출력
		}
		else {
			$("span.multi_" + $(this).val()).remove();
		}

		if ($('.multi_show').children().length === 0) { // check된 것이 없다면 기본 텍스트로 변경
			$(".multi_default").show();
		}
 		$("[name='_schEtc11']").remove();
	});
}
</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<input type="hidden" name="errLogSerno" id="errLogSerno"/>
		<table>
			<caption>검색</caption>
			<colgroup>
					<col style="width: 8%;">
					<col style="width: 13%;">
					<col style="width: 10%;">
					<col style="width: 30%;">
					<col style="width: 8%;">
					<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>에러유형</label></td>
					<td>
						<div class="multiSelect w130">
							<span class="multi_text w130">
								<span class="multi_default"></span>
								<span class="multi_show"></span>
							</span>
							<ul class="multi_option">
								<li class="default">
									<c:out value="전체"/>
								</li>
								<c:forEach items="${errTpList}" var="errTp" varStatus="status">
									<li>
										<input:checkbox path="schEtc11" id="errTpNm_${status.index}" value="${errTp.errTpNm}"/>
										<label for="errTpNm_<c:out value='${status.index}'/>" class="grouplist_id"><c:out value='${errTp.errTpNm}'/></label>
									</li>
								</c:forEach>
							</ul>
						</div>
					</td>
					<td><label>발생기간</label></td>
					<td>
						<span class="calendar_input"><form:input path="searchStartDate" title="발생기간" id="searchStartDate" autocomplete='off' readonly="true"/></span>
						<span class="gap">~</span>
						<span class="calendar_input"><form:input path="searchEndDate" title="발생기간"  id="searchEndDate" autocomplete='off' readonly="true"/></span>
					</td>
					<td><label>검색</label></td>
					<td>
						<form:select path="searchCondition" title="검색" cssClass="w120">
							<form:option value="" label="전체"/>
							<form:option value="menuCgNm" label="메뉴명"/>
							<form:option value="menuNm" label="메뉴 한글명"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="w250" maxlength="100"/>
					</td>
				</tr>
			</tbody>
		</table>
			<button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
			<button type="button" id="btn_search" class="btn btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
