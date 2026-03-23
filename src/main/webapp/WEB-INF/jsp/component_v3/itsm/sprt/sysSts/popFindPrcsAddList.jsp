<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
	<div class="tbl_left">
		<div class="all_num"><i class="i_all"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
	<div class="tbl_right"></div>
</div>
<div class="tbl_wrap">
	<table class="tbl col link board board_col_type01">
		<caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
		<colgroup>
			<col style="width: 5%">
			<col style="width: 10%">
			<col>
			<col style="width: 15%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><label class="chkbox2"><input type="checkbox" name="allChk" class="allChk" onclick="fncAllChk(this)"><span></span></label></th>
				<th scope="col">요청구분</th>
				<th scope="col">내용</th>
				<th scope="col">처리완료일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr style="cursor: default;" id="dmnd_${result.imprvSn }" onclick="fncChkTr('${result.imprvSn }');"
							data-dmndttl="${result.dmndTtl }" data-prcsdt="${result.prcsDt }" data-dmndcdnm="${result.dmndCdNm }">
							<td onclick="event.cancelBubble=true">
								<label class="chkbox2">
									<input type="checkbox" class="allSrchChk" value="${result.imprvSn }" id="chkbox_${result.imprvSn }" onclick="fncAddCn('${result.imprvSn }');">
									<span></span>
								</label>
							</td>
							<td class="dmndCdNm"><c:out value="${result.dmndCdNm }"/></td>
							<td class="dmndTtl ellipsis"><c:out value="${result.dmndTtl }"/></td>
							<td class="prcsDt ellipsis"><c:out value="${result.prcsDt }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="4">조회된 내역이 없습니다.</td>
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
		<a href="javascript:void(0)" class="btn btn_mdl btn_save" onclick="fncSetCn();">추가</a>
	</div>
</div>

<script>

$(document).ready(function(){
	
	userArray.map( function(item) {
		$("#chkbox_"+item.imprvSn).prop("checked", true);
	})
	
	let chkCnt = 0;
	let boxCnt = 0;
	$(".allSrchChk").each(function(){
		boxCnt++;
		if($(this).is(":checked")){
			chkCnt++;
		}
    });

});

function fncSetCn() {
	$("#dmndCn").html("");
	if(userArray.length < 1) {
		fncInsertForm();
	} else {
		$("#dmndCnTable").show();
		var listHtml = "";
		userArray.map( function(item,index) {
			listHtml += "<tr id='tr_dmnd_"+item.imprvSn+"'>";
			listHtml += "	<input class='dmndArr' type='hidden' name='dmndArr["+index+"].imprvSn' value='"+item.imprvSn+"'>";
			listHtml += "	<td class='c ellipsis' style='padding: 8px 25px 8px 25px;'>"+item.dmndCdNm+"</td>";
			listHtml += "	<td class='ellipsis'>"+item.dmndTtl+"</td>";
			listHtml += "	<td class='c' style='padding: 8px 25px 8px 25px;' class='ellipsis'>"+item.prcsDt+"</td>";
			listHtml += "	<td class='c' style='padding: 8px 25px 8px 25px;'><a href='javascript:void(0)' class='btn btn_sml btn_cancel' onclick='fncDelCn(\""+item.imprvSn+"\");'>삭제 </a></td>";
			listHtml += "</tr>";
		});

		$("#dmndCn").html(listHtml);

	}

	modal_hide_all();
}

<%-- tr눌렀을 때 체크박스 체크 --%>
function fncChkTr(divnSn){
	if($('#chkbox_'+divnSn).is(':checked') == false){
		$('#chkbox_'+divnSn).prop('checked', true);
	}else{
		$('#chkbox_'+divnSn).prop('checked', false);
	}
	fncAddCn(divnSn);
}

function fncAddCn(divnSn) {

	if( $("#chkbox_"+divnSn).is(":checked") ) {
		var check = true;
		userArray.map( function(item) {
			let eDivnSn = item.imprvSn
			if(eDivnSn == divnSn) {
				check = false;
			}
		})
		
		if( check ) {
			var dmnd = {
				imprvSn : divnSn,
				dmndCdNm : $("#dmnd_"+divnSn).data('dmndcdnm'),
				dmndTtl : $("#dmnd_"+divnSn).data('dmndttl'),
				prcsDt : $("#dmnd_"+divnSn).data('prcsdt'),
			};
			userArray.push(dmnd);
		}
	} else {
		userArray = userArray.filter( function(e) {
			let eDivnSn = e.imprvSn
			return eDivnSn != divnSn;
		});
	}
}
</script>