<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- 통합 템플릿 유형 조회 --%>
	fncCodeList("TMCL01", "select", "템플릿 유형", '<c:out value="${searchVO.schEtc01}"/>', "", "schEtc01");
	<%-- 개별 템플릿 유형 조회 --%>
	fncCodeList("TMCL02", "select", "템플릿 유형", '<c:out value="${searchVO.schEtc02}"/>', "", "schEtc02");
	
	if($("#schEtc00").val() == null || $("#schEtc00").val() == ""){
		$("#schEtc00").val("TMCL01");
	}
	
    fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
	
	<%-- tab 속성 조정 --%>
	if ($('.js_tmenu').length) {
        $('.js_tmenu li a').click(function () {
            var cdVal = $(this).data("cdval")
            if(cdVal == "TMCL01"){
	            $("#schEtc01").removeClass("disno");
	            $("#schEtc02").addClass("disno");
	            $("#schEtc02").val("");
            }else if(cdVal == "TMCL02"){
            	$("#schEtc01").addClass("disno");
	            $("#schEtc02").removeClass("disno");
	            $("#schEtc01").val("");
            }
            $("#schEtc00").val(cdVal);
            $("#searchCondition").val("");
            $("#searchKeyword").val("");
            $('#recordCountPerPage_board_right').val("10");
            fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
            return false;
        });
    }
});
</script>
<div class="tab wide">
    <ul class="tab_menu js_tmenu mar_t15" role="tablist">
        <c:forEach var="item" items="${tmplClList}" varStatus="status">
	   		<li id="tab1_<c:out value='${status.count}'/>" role="tab" aria-selected="<c:out value="${searchVO.schEtc00 eq item.cdVal or (empty searchVO.schEtc00 and status.first) ? 'true' : 'false' }"/>" class="<c:out value="${searchVO.schEtc00 eq item.cdVal or (empty searchVO.schEtc00 and status.first) ? 'on' : '' }"/>" ><a href="javascript:void(0)" data-cdval="<c:out value='${item.cdVal}'/>"><c:out value="${item.cdNm}"/></a></li>
	   	</c:forEach> 
    </ul>
</div>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<form:hidden path="schEtc00"/>
		<input type="hidden" id="tmplSerno" name="tmplSerno"/>
		<table>
			<caption>검색</caption>
			<colgroup>
				<col class="w10p">
				<col>
				<col class="w10p">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>검색</label></td>
					<td colspan="3">
						<select id="schEtc01" name="schEtc01" class="w150" title="템플릿 유형선택">
						</select>
						<select id="schEtc02" name="schEtc02" class="w150 disno mar_l0" title="템플릿 유형선택">
						</select>
						<form:select path="searchCondition" title="구분선택" cssClass="w150">
							<form:option value="" label="전체"/>
							<form:option value="1" label="템플릿 설명"/>
							<form:option value="2" label="에디터 내용"/>
						</form:select>
						<form:input path="searchKeyword" cssClass="w750"/>
					</td>
				</tr>
			</tbody>
		</table>
        <button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
     	<button type="button" class="btn btn_search" id="btn_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
