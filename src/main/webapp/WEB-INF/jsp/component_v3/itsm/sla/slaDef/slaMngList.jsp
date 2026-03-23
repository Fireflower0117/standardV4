<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
	$(document).ready(function(){
		fncSvcList("select", "", "${not empty searchVO.svcSn ? searchVO.svcSn : schEtc00}", "svcSn");
		fncSlaAddList('slaMngAddList.do','slaMngAddList');
		fncMonth('searchbgngYm')
	})



	<%-- 탭이동 --%>
	function fncSlaAddList(url, id){
		if($("#svcSn").val()){
			fncAjax(url, $('#listFrm').serialize(), 'html', true, '', function(data){
				$("#"+id).html(data);
			});
		}

	}

</script>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" name="listFrm" id="listFrm" method="post">
		<form:hidden path="scrngSn" id="scrngSn_list"/>
		<table class="search_tbl">
			<caption>검색</caption>
			<colgroup>
				<col style="width:12%">
				<col>
				<col style="width:12%">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">서비스구분</th>
				<td>
					<select id="svcSn" name="svcSn" class="select" onchange="fncSlaAddList('slaMngAddList.do','slaMngAddList')" style="width: 250px;"/>
				</td>
				<th scope="row">기준년월</th>
				<td>
					<span class="calendar_input w120">
						<form:input id="searchbgngYm" path="searchbgngYm" class="text w120" readonly="readonly" title="기준년월" required="true" onchange="fncSlaAddList('slaMngAddList.do','slaMngAddList')"/>
					</span>
				</td>
			</tr>
			</tbody>
		</table>
	</form:form>
</div>
<div id="slaMngAddList">
</div>