<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
let itmList = new Array;
$(document).ready(function(){
	
	itsmFncColLength();

	$('.no_hover tr').on('click', function(){
		fncChkTr($(this).attr('data-index'));
	});

	<%-- 등록 클릭시 --%>
	$('#btn_write').on('click', function(){
		fncItmInsert();
	});

	itmList.push('${searchVO.itmList}');
	
	<%--전체 선택/해제 처리--%>
	$("#chkAll").on('change',function(){
		$("[id^=chkBox_]").each(function (index,item){
			if($("#chkAll").prop("checked") == true){
				$(this).prop("checked",true);
			}else{
				$(this).prop("checked",false);
			}
		});
	});

	<%--전체 선택/해제 처리--%>
	$("[id^=chkBox_]").on('change',function (){
		if($("[id^=chkBox_]").length == $("[id^=chkBox_]:checked").length){
			$("#chkAll").prop("checked",true);
		}else{
			$("#chkAll").prop("checked",false);
		}
	});
});

 function fncItmInsert(){
	if($("[id^=chkBox_]:checked").length == 0){
		alert("체크된 항목이 없습니다");
		return false;
	}itmList = [];

	$("[id^=chkBox_]:checked").each(function(index, item){
		itmList.push($(this).val())
	});
	let tempArr = new Array;
	tempArr.push($("#itmSnList").val());

	opener.fncAddItm(itmList); // form 에 추가 완료

	 tempArr.push(itmList);
	 $("#itmSnList").val(tempArr);
	fncPopAddList(<c:out value="${searchVO.currentPageNo}"/>); <%--팝업 새로고침--%>
 }

</script>

	<div class="tbl_top">
		<div class="tbl_left">
			<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
		</div>
		
	</div>
	<div class="tbl_wrap">
		<table class="board_col_type01 no_hover">
			<caption>목록(번호,제목,등록자,소속,등록일 로 구성)</caption>
			<colgroup>
				<col style="width:6%;">
				<col style="width:6%;">
				<col style="width:6%;">
				<col>
				<col style="width:12%;">
				<col style="width:12%;">
			</colgroup>
			<thead>
			<tr>
				<th scope="col"><input type="checkbox" id="chkAll"></th>
				<th scope="col">번호</th>
				<th scope="col">구분</th>
				<th scope="col">항목 내용</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
			</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${fn:length(resultList) > 0}">
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr data-index="<c:out value='${status.index}'/>" >
								<td onclick="event.cancelBubble=true">
									<input type="checkbox" id="chkBox_${status.index}" value="${result.itmSn}"/>
									<input type="hidden" id="itmSn_${status.index}" value="${result.itmSn}"/>
								</td>
								<td><c:out value="${paginationInfo.totalRecordCount + 1 - ((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
								<td><c:out value="${result.itmGbnNm}"/></td>
								<td class="subject"><c:out value="${result.itmCn}"/></td>
								<td><c:out value="${result.rgtrNm}"/></td>
								<td><c:out value="${result.regDt}"/></td>
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
	<div class="paging_wrap">
		<div class="paging">
			<ui:pagination paginationInfo="${paginationInfo}" type="default" jsFunction="fncPopAddList"/>
		</div>
		<div class="btn_right">
			<a href="javascript:void(0)" id="btn_write" class="btn btn_mdl btn_save">등록</a>
		</div>
	</div>