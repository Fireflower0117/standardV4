<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">

	$(document).ready(function(){
		fncSvcList("select", "", "${schEtc00}", "svcSn");
		fncMonth('searchbgngYm')

		if($("#svcSn").val() && $("#searchbgngYm").val()){
			fncSlaAddList("addList.do")
		}
	})

	function fncSlaAddList(url){
		if($("#svcSn").val() && $("#searchbgngYm").val()){
			fncAjax(url, $('#listFrm').serialize(), 'html', true, '', function(data){
				$(".tbl").html(data);
			});
		}else{
			$(".tbl").html("");
		}


	}
</script>

<div class="search_wrap">
<form:form modelAttribute="searchVO" name="listFrm" id="listFrm" method="post">
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
				<select id="svcSn" name="svcSn" class="select" onchange="fncSlaAddList('addList.do')" style="width: 250px;"/>
			</td>
			<th scope="row">기준년월</th>
			<td>
				<span class="calendar_input w120">
					<form:input id="searchbgngYm" path="searchbgngYm" class="text w120" readonly="readonly" onchange="fncSlaAddList('addList.do')"/>
				</span>
			</td>
		</tr>
		</tbody>
	</table>
</form:form>
</div>
<div class="tbl"></div>