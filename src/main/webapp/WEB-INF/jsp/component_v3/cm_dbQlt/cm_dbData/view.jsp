<%--@elvariable id="cmDbDataVO" type="com.opennote.standard.component.dbQlt.dbData.vo.CmDbDataVO"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	// no_data 처리
	fncColLength();
	// DB 테이블 데이터 조회
	cmDataList('', '', 1);

});

// DB 테이블 데이터 조회
const cmDataList = function (a, b, currentPageNo) {
	let data = {
		tableName : $("#tableName").val(),
		tableRows : $("#tableRows").val(),
		currentPageNo : currentPageNo
	};
	fncAjax("dataList.do", data, "html", true, "#dataList");
}

</script>
<form:form modelAttribute="cmDbDataVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="tableName"/>
	<form:hidden path="tableRows"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<table class="board_view">
		<caption>내용(테이블영문명, 데이터한글명, 컬럼개수, 데이터개수로 구성)</caption>
		<colgroup>
			<col class="w20p">
	        <col class="w30p">
	        <col class="w20p">
	        <col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">테이블영문명</th>
				<td><c:out value="${cmDbDataVO.tableName}"/></td>
				<th scope="row">테이블한글명</th>
				<td><c:out value="${cmDbDataVO.tableComment}"/></td>
			</tr>
			<tr>
				<th scope="row">컬럼개수</th>
				<td><fmt:formatNumber value="${cmDbDataVO.columnCnt}" pattern="#,###"/></td>
				<th scope="row">데이터개수</th>
				<td><fmt:formatNumber value="${cmDbDataVO.tableRows}" pattern="#,###"/></td>
			</tr>
		</tbody>
	</table>
	<!-- 탭 목록 -->
	<div class="tab box mar_t30">
		<ul class="tab_menu js_tmenu" role="tablist">
			<li id="tab1_01" class="on" role="tab" aria-selected="true"><a href="javascript:void(0);">컬럼목록</a></li>
			<li id="tab1_02" role="tab" aria-selected="false"><a href="javascript:void(0);">데이터목록</a></li>
		</ul>
		<div class="tab_cont js_tcont on" data-tab="tab1_01" role="tabpanel" aria-labelledby="tab1_01">
			<table class="board_list">
				<caption>내용(컬럼영문명, 컬럼한글명, 데이터타입(길이), NULL여부, KEY, 기본값으로 구성)</caption>
				<colgroup>
					<col class="w20p"/>
					<col/>
					<col class="w15p"/>
					<col class="w10p"/>
					<col class="w10p"/>
					<col class="w15p"/>
				</colgroup>
				<thead>
				<tr>
					<th scope="col">컬럼영문명</th>
					<th scope="col">컬럼한글명</th>
					<th scope="col">데이터타입(길이)</th>
					<th scope="col">NULL여부</th>
					<th scope="col">KEY</th>
					<th scope="col">기본값</th>
				</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${fn:length(colList) > 0 }">
						<c:forEach var="result" items="${colList}" varStatus="status">
							<tr>
								<td class="l"><c:out value="${result.columnName}"/></td>
								<td class="l"><c:out value="${result.columnComment}"/></td>
								<td><c:out value="${result.columnType}"/></td>
								<td><c:out value="${result.isNullable}"/></td>
								<td><c:out value="${result.columnKey}"/></td>
								<td><c:out value="${result.columnDefault}"/></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td class="no_data">데이터가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<div class="tab_cont js_tcont" data-tab="tab1_02" role="tabpanel" aria-labelledby="tab1_02">
			<div id="dataList"></div>
		</div>
	</div>
	<!-- //탭 목록 -->
</form:form>
<div class="btn_area">
	<button type="button" id="btn_list" class="btn gray">목록</button>
</div>
