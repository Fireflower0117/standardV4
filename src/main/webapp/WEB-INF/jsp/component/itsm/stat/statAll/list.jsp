<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
<input type="hidden" id="menuCd" name="menuCd"/>
<div class="stat_count">
	<div class="sc_tit">
		<h4 class="md_tit">서비스 처리현황</h4>
		<form:select path="schEtc00" id="schEtc00" cssClass="select typeA" onchange="fncSvcGbn(this.value)">
		</form:select>
		<form:select path="year" id="year" cssClass="select typeA" onchange="fncSvcGbn(this.value)">
			<c:forEach var="result" items="${yearList}" varStatus="select status">
				<form:option value="${result.regDt}">${result.regDt}</form:option>
			</c:forEach>
		</form:select>
	</div>
	<ul>
		<li>전체건수<span><em id="all">-</em>건</span></li>
		<li>긴급<span><em id="cnt1">-</em>건</span></li>
		<li>일반<span><em id="cnt2">-</em>건</span></li>
		<li>중요<span><em id="cnt3">-</em>건</span></li>
	</ul>
</div>
</form:form>
<div class="stat_chart">
	<dl class="sc_rows">
		<dt class="sc_tit"><h4 class="md_tit">서비스 변경현황</h4></dt>
		<dd class="sc_item" id="statChg01"></dd>
		<dd class="sc_item" id="statChg02"></dd>
	</dl>
	<dl>
		<dt class="sc_tit"><h4 class="md_tit">점검현황</h4></dt>
		<dd class="sc_item">
			<div id="statInsp02"></div>
		</dd>
	</dl>
	<dl>
		<dt class="sc_tit"><h4 class="md_tit">장애현황</h4></dt>
		<dd class="sc_item">
			<div id="statErr02"></div>
		</dd>
	</dl>
</div>
<script type="text/javaScript">
	$(document).ready(function(){
		fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
		<%-- 서비스 처리현황 --%>
		fncSvcGbn()

	});

	<%-- 서비스 처리현황 --%>
	function fncSvcGbn(){
		$("#menuCd").val('statAll')

		fncStatChg01();
		fncStatChg02();
		fncStatInsp02();
		fncStatErr01();

		$.ajax({
			type     : "patch",
			url      : "svcPrcs",
			data     : $("#defaultFrm").serialize(),
			dataType : "json",
			success  : function(data){
				$("#all").text(!data.vo.all1 ? '-' : data.vo.all1)
				$("#cnt1").text(!data.vo.cnt1 ? '-' : data.vo.cnt1)
				$("#cnt2").text(!data.vo.cnt2 ? '-' : data.vo.cnt2)
				$("#cnt3").text(!data.vo.cnt3 ? '-' : data.vo.cnt3)
			}
		})

	}

	// 서비스 변경현황 1
	function fncStatChg01() {
		fncAjax('statChg01.do', $("#defaultFrm").serialize(), 'html', true, '#statChg01');
	}

	// 서비스 변경현황 2
	function fncStatChg02() {
		fncAjax('statChg02.do', $("#defaultFrm").serialize(), 'html', true, '#statChg02');
	}

	// 점검현황
	function fncStatInsp02() {
		fncAjax('/itsm/stat/statInsp/statInsp01.do', $("#defaultFrm").serialize(), 'html', true, '#statInsp02');
	}

	// 장애현황
	function fncStatErr01() {
		fncAjax('/itsm/stat/statErr/statErr01.do', $("#defaultFrm").serialize(), 'html', true, '#statErr02');
	}
</script>