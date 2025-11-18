<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncSvcGbn()

	$("#slideUp1").click(function () {
		if($(this).text() == "차트열기"){
			$(this).text("차트닫기");
		} else {
			$(this).text("차트열기");
		}
		$('.stat_chart').slideToggle(300);
		$(this).toggleClass('open');
	});
});

function fncSvcGbn(){
	fncStatFnc01();
	fncStatFnc02();
}

<%-- 서비스처리현황 1 --%>
function fncStatFnc01() {
	fncAjax('statFnc01.do', $("#defaultFrm").serialize(), 'html', true, '#statFnc01');
}

<%-- 서비스처리현황 2 --%>
function fncStatFnc02() {
	fncAjax('statFnc02.do', $("#defaultFrm").serialize(), 'html', true, '#list');
}

</script>
<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
	<div class="tbl_top">
		<div class="tbl_left">
			<div class="sc_tit">
				<form:select path="schEtc00" id="schEtc00" cssClass="select typeA" onchange="fncSvcGbn(this.value)">
				</form:select>
				<form:select path="year" id="year" cssClass="select typeA" onchange="fncSvcGbn(this.value)">
					<c:forEach var="result" items="${yearList}" varStatus="select status">
						<form:option value="${result.regDt}">${result.regDt}</form:option>
					</c:forEach>
				</form:select>
			</div>
		</div>
		<div class="tbl_right">
			<div class="btn_area mar_t0">
				<a href="javascript:void(0)" class="btn btn_sml btn_toggle" id="slideUp1" style="height: 30px;">차트닫기</a>
			</div>
		</div>
	</div>
</form:form>
<div class="stat_chart">
	<dl class="sc_rows row3_7">
		<dd class="sc_item" id="statFnc01">
		</dd>
		<dd class="sc_item" id="statFnc02">
			<div id="chart2"></div>
		</dd>
	</dl>
</div>
<div id="list" class="tbl"></div>