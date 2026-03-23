<%--@elvariable id="searchVO" type="com.opennote.standard.component.std.term.vo.CmTermVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){

	$("#currentPageNo").val('<c:out value="${searchVO.currentPageNo}"/>');

	<%-- 시도,시군구, 읍면동 설정 --%>
	cmFncRegList('SIDO', 'schSido', '', '전국', '${searchVO.schSido}','','');
	cmFncRegList('CGG', 'schCgg', 'ASC', '시군구', '${searchVO.schCgg}',$('#schSido').val());
	cmFncRegList('UMD', 'schUmd', 'ASC', '읍면동', '${searchVO.schUmd}',$('#schSido').val()+$('#schCgg').val());
	cmFncRegList('RI', 'schRi', 'ASC', '리', '${searchVO.schRi}',$('#schSido').val()+$('#schCgg').val()+$('#schUmd').val());

	$('#schSido').on('change', function() {
		cmFncRegList('CGG', 'schCgg', 'ASC', '시군구', '',$('#schSido').val());
		cmFncRegList('UMD', 'schUmd', 'ASC', '읍면동', '',$('#schSido').val()+$('#schCgg').val());
		cmFncRegList('RI', 'schRi', 'ASC', '리', '',$('#schSido').val()+$('#schCgg').val()+$('#schUmd').val());
	});

	$('#schCgg').on('change', function() {
		cmFncRegList('UMD', 'schUmd', 'ASC', '읍면동', '',$('#schSido').val()+$('#schCgg').val());
		cmFncRegList('RI', 'schRi', 'ASC', '리', '',$('#schSido').val()+$('#schCgg').val()+$('#schUmd').val());
	});

	$('#schUmd').on('change', function() {
		cmFncRegList('RI', 'schRi', 'ASC', '리', '',$('#schSido').val()+$('#schCgg').val()+$('#schUmd').val());
	});


	cmFncAddList();
});

const cmFncAddList = function(){
	$.ajax({
		method: "POST",
		url: "addList.do",
		data: $("#defaultFrm").serialize(),
		dataType: "html",
		success: function(data) {
			$(".tbl").html(data);
		}
	});
}

const cmFncRegList = function(gubun, tagId, sort, def, sel,regCd){
	var html="";
	if(gubun != "SIDO" && (regCd == '' || regCd == null || regCd === undefined || (gubun == 'UMD' && regCd.length != 5) || (gubun == 'RI' && regCd.length != 8))) {
		if(def != '' && def != null) {
			html = "<option value=''>"+def+"</option>";
		}
		$("#" + tagId).html(html);
		return false;
	}

	$.ajax({
		url      : "get"+gubun+"RegData",
		type     : "post",
		data     : {
			def    : def,
			sel    : sel,
			sort   : sort,
			regCd  : regCd,
		},
		dataType : "html",
		async    : false,
		success  : function(data){
			$("#" + tagId).html(data);
		}
	})
}

const cmFncLoadStart = function(){
	$(".loading_wrap").show();
}

/* 로딩 종료 */
const cmFncLoadEnd = function(){
	setTimeout(function(){
		$(".loading_wrap").hide();
	}, 300);
}

</script>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<table>
			<caption>검색</caption>
			<colgroup>
					<col style="width: 10%;">
					<col>
					<col style="width: 10%;">
					<col>
					<col style="width: 10%;">
					<col>
					<col style="width: 10%;">
					<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>시도</label></td>
					<td>
						<form:select path="schSido" title="시도" cssClass="w100p">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
					<td><label>시군구</label></td>
					<td>
						<form:select path="schCgg" title="시군구" cssClass="w100p" required="true">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
					<td><label>읍면동</label></td>
					<td>
						<form:select path="schUmd" title="읍면동" cssClass="w100p" required="true">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
					<td><label>리</label></td>
					<td>
						<form:select path="schRi" title="리" cssClass="w100p" required="true">
							<form:option value="" label="전체"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td><label>레벨</label></td>
					<td>
						<form:select path="schEtc04" title="레벨" cssClass="w100p" required="true">
							<form:option value="" label="전체"/>
							<form:option value="1" label="1레벨"/>
							<form:option value="2" label="2레벨"/>
							<form:option value="3" label="3레벨"/>
							<form:option value="4" label="4레벨"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td><label>검색</label></td>
					<td colspan="7">
						<form:select path="searchCondition" title="검색" cssClass="w120">
							<form:option value="" label="전체"/>
							<form:option value="1" label="법정동코드"/>
						</form:select>
						<form:input path="searchKeyword" id="searchKeyword" cssClass="w88p" maxlength="100"/>
					</td>
				</tr>
			</tbody>
		</table>
		<a href="javascript:void(0);" id="btn_reset" class="btn btn_reset"><i class="xi-refresh"></i>초기화</a>
		<a href="javascript:void(0);" id="btn_search" class="btn btn_search"><i class="xi-search"></i>검색</a>
	</form:form>
</div>
<div class="tbl"></div>
