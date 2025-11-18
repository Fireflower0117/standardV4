<%--@elvariable id="searchVO" type="com.opennote.standard.ma.cmmn.domain.CmmnDefaultVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// 표준미준수 검색조건
	if ('<c:out value="${searchVO.schEtc01}"/>' == '02') {
		$(".std").show();
	} else {
		$(".std").hide();
	}
	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');

	// 탭 클릭
	$('.js_tmenu li a').click(function () {
		const tabCd = $(this).data('tabcd');
		$("#schEtc01").val(tabCd);
		$("#currentPageNo").val("1");
		if (tabCd == '02') {
			$(".std").show();
		} else {
			$(".std").hide();
		}

		fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
	});

	// 검색
	$('#btn_term_search').on('click', function(){
		fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
	});
	//검색 엔터 체크
	$("#termKeyword").keydown(function(e){
		if (e.keyCode == 13) {
			e.preventDefault();
			fncPageBoard('addList','addList.do', '<c:out value="${searchVO.currentPageNo}"/>');
		}
	});

});
</script>
<div class="tab wide mar_b30">
	<ul class="tab_menu js_tmenu" role="tablist">
		<li id="tab1_01" class="<c:out value="${searchVO.schEtc01 eq '01' ? 'on' : ''}"/>" role="tab" aria-selected="true"><a href="javascript:void(0);" data-tabcd="01">코멘트미표시</a></li>
		<li id="tab1_02" class="<c:out value="${searchVO.schEtc01 eq '02' ? 'on' : ''}"/>" role="tab" aria-selected="false"><a href="javascript:void(0);" data-tabcd="02">표준미준수</a></li>
	</ul>
</div>
<div class="search_basic">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage"/>
		<form:hidden path="schEtc01"/>
		<input type="hidden" name="tableName" id="tableName">
		<input type="hidden" name="columnName" id="columnName">
		<input type="hidden" name="stdCd" id="stdCd">
		<table>
			<caption>내용(검색, 상태로 구성)</caption>
			<colgroup>
				<col class="w7p">
				<col>
				<col class="w7p std">
				<col class="w15p std">
			</colgroup>
			<tbody>
				<tr>
					<td><label>검색</label></td>
					<td>
						<form:select path="searchCondition" id="searchCondition" class="w150">
							<form:option value="" label="전체"/>
							<form:option value="1" label="테이블영문명"/>
							<form:option value="2" label="컬럼영문명"/>
						</form:select>
						<form:input path="searchKeyword" id="termKeyword" cssClass="w70p" maxlength="100" placeholder="검색어를 입력하세요."/>
					</td>
					<td class="std"><label>상태</label></td>
					<td class="std">
						<form:select path="schEtc00" class="w150">
							<form:option value="" label="전체"/>
							<form:option value="ST01" label="미등록데이터"/>
							<form:option value="ST02" label="컬럼한글명불일치"/>
						</form:select>
					</td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn_reset" id="btn_reset"><i class="xi-refresh"></i>초기화</button>
		<button type="button" class="btn btn_search" id="btn_term_search"><i class="xi-search"></i>검색</button>
	</form:form>
</div>
<div class="tbl"></div>
