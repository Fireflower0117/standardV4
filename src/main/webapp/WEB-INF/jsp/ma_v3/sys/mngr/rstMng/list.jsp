<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
	$(document).ready(function(){
		fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
	});

	<%--제한 일괄 처리 --%>
	const fncAll = function(type){
		if(type == 'BLK') {
			// 유효성검사
			if($("[NAME=schEtc12]").length == 0) {
				alert('일괄제한 항목이 없습니다.');
				return false;
			}
			// 유효성검사
			if(confirm($("[NAME=schEtc12]").length + "건에 대하여 아이디를 제한하시겠습니까?.")){
				// 처리
				fncAjax('allBlk', $('#defaultFrm').serialize(), 'json', true, '', function(data){
					alert(data.message);
					if(data.result) {
						// 목록갱신
						fncPageBoard('addList','addList.do',$('#currentPageNo').val());
						$("[NAME=schEtc12]").remove();
					}
				});
			}
			return false;
		} else if (type == 'Clear') {
		<%--제한 해제 일괄 처리 --%>
			// 유효성검사
			if($("[NAME=schEtc11]").length == 0) {
				alert('선택된 항목이 없습니다.');
				return false;
			}
			// 유효성검사
			if(confirm($("[NAME=schEtc11]").length + "건에 대하여 아이디 제한을 해제합니다.")){
				// 처리
				fncAjax('allClear', $('#defaultFrm').serialize(), 'json', true, '', function(data){
					alert(data.message);
					if(data.result) {
						// 목록갱신
						fncPageBoard('addList','addList.do',$('#currentPageNo').val());
						$("[NAME=schEtc11]").remove();
					}
				});
			}
			return false;
		}
	}

	<%--여기서부터는 제한하기 작동--%>
	<%--전체 선택--%>
	const fncAllChkBlk = function(obj){
		if($(obj).is(":checked")){
			$(".allChkBlk").prop("checked",true).change();
		}else{
			$(".allChkBlk").prop("checked",false).change();
		}
	}
	<%--선택된 값들 선택 유지--%>
	const fncChkReLoadBlk = function(obj){
		$("[NAME=schEtc12]").each(function(){
			$("[CLASS=allChkBlk][VALUE="+$(this).val()+"]").prop("checked",true);
		});
		fncAllCheckAutoBlk();
	}
	<%--선택에 따른 변화 셋팅--%>
	const fncCheckActionSetBlk = function(){
		$(".allChkBlk").on("change",function(){
			if($(this).is(":checked")){
				var newChkHtmlBlk = '<input type="hidden" name="schEtc12" value="'+$(this).val()+'" />';
				$("[NAME=schEtc12][VALUE="+$(this).val()+"]").remove();
				$("#chkDataDiv").append(newChkHtmlBlk);
			}else{
				$("[NAME=schEtc12][VALUE="+$(this).val()+"]").remove();
			}
			fncAllCheckAutoBlk();
		});
	}
	<%--선택에 따른 전체 선택 변화--%>
	const fncAllCheckAutoBlk = function(){
		if($("input[class=allChkBlk]:not(':checked')").length == 0 && $("input[class=allChkBlk]:checked").length > 0) {
			$('.allChkB').prop("checked",true).change();
		} else {
			$('.allChkB').prop("checked",false).change();
		}
	}


	<%--여기서부터는 제한 해제하기 작동--%>
	<%--전체 선택--%>
	const fncAllChkClear = function(obj){
		if($(obj).is(":checked")){
			$(".allChkClear").prop("checked",true).change();
		}else{
			$(".allChkClear").prop("checked",false).change();
		}
	}
	<%--선택된 값들 선택 유지--%>
	const fncChkReLoadClear = function(){
		$("[NAME=schEtc11]").each(function(){
			$("[CLASS=allChkClear][VALUE="+$(this).val()+"]").prop("checked",true);
		});
		fncAllCheckAutoClear();
	}
	<%--선택에 따른 변화 셋팅--%>
	const fncCheckActionSetClear = function(){
		$(".allChkClear").on("change",function(){
			if($(this).is(":checked")){
				var newChkHtmlClear = '<input type="hidden" name="schEtc11" value="'+$(this).val()+'" />';
				$("[NAME=schEtc11][VALUE="+$(this).val()+"]").remove();
				$("#chkDataDiv").append(newChkHtmlClear);
			}else{
				$("[NAME=schEtc11][VALUE="+$(this).val()+"]").remove();
			}
			fncAllCheckAutoClear();
		});
	}
	<%--선택에 따른 전체 선택 변화--%>
		const fncAllCheckAutoClear = function(){
		if($('input[class=allChkClear]:not(":checked")').length == 0 && $("input[class=allChkClear]:checked").length > 0) {
			$('.allChkC').prop("checked",true).change();
		} else {
			$('.allChkC').prop("checked",false).change();
		}
	}

	<%-- 삭제 --%>
	const fncDel = function(serno,id){
		$("#userSerno").val(serno);
		if(confirm("아이디 ["+id+"]를 제한 목록에서 삭제합니다.")){
			fncProc('delete');
		}
	}

</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<input type="hidden" id=userSerno name="userSerno"/>
		<table>
			<caption>검색</caption>
			<colgroup>
				<col style="width:10%">
				<col style="width:10%">
				<col style="width:10%">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<td>제한여부</td>
				<td>
					<form:select path="schEtc01" title="구분선택" cssClass="w150">
						<form:option value="" label="전체"/>
						<form:option value="Y" label="제한"/>
						<form:option value="N" label="해제"/>
					</form:select>
				</td>
				<td><label>검색</label></td>
				<td>
					<form:select path="searchCondition" title="구분선택" cssClass="w150">
						<form:option value="" label="전체"/>
						<form:option value="1" label="아이디"/>
					</form:select>
					<form:input path="searchKeyword"/>
				</td>
			</tr>
			</tbody>
		</table>
		<button id="btn_reset" class="btn btn_reset"><i class="xi-refresh"></i>초기화</button>
		<button id="btn_search" class="btn btn_search"><i class="xi-search"></i>검색</button>
		<div style="display: none;" id="chkDataDiv"></div>
	</form:form>
</div>
<div class="tbl"></div>