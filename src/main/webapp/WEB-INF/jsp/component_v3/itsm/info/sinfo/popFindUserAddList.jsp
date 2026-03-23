<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
	<div class="tbl_left">
		<div class="all_num"><i class="i_all"></i>전체 <span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
	<div class="tbl_right"></div>
</div>
<div class="tbl_wrap">
	<table class="tbl col link board board_col_type01">
		<caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
		<colgroup>
			<col style="width: 9%;">
			<col style="width: 20%;">
			<col style="width: 20%;">
			<col style="width: 25%;">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><input type="checkbox" id="chkAll"></th>
				<th scope="col">이름</th>
				<th scope="col">ID</th>
				<th scope="col">전화번호</th>
				<th scope="col">이메일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr onclick="fncChkTr(${status.index})">
							<td onclick="event.cancelBubble=true">
								<input type="checkbox" id="chkBox_${status.index}" value="${result.userSerno}"/>
							</td>
							<td class="ellipsis c"><c:out value="${result.userNm }"/></td>
							<td class="ellipsis c"><c:out value="${result.userId }"/></td>
							<td><c:out value="${util:getDecryptAES256HyPhen(result.userTelNo) }"/></td>
							<td class="ellipsis c"><c:out value="${empty result.userEmailAddr ? '-' : result.userEmailAddr }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="5">조회된 내역이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
 <div class="paging_wrap">
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="default" jsFunction="fncPopBoard"/>
	</div>
	 <div class="btn_right">
		 <a href="javascript:void(0)" class="btn btn_mdl btn_save" onclick="fncAddManager()">등록</a>
	 </div>
</div>

<script>
$(document).ready(function(){

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
})

</script>