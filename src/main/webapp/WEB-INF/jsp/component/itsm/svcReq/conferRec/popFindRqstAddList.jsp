<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="tbl_top">
	<div class="tbl_left">
		<div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
	</div>
	<div class="tbl_right"></div>
</div>
<div class="tbl_wrap">
	<table class="tbl col link board board_col_type01" id="tblRqst">
		<caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
		<colgroup>
			<col style="width: 5%">
			<col style="width: 8%">
			<col style="width: 10%">
			<col style="width: 15%">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><label class="chkbox2"><input type="checkbox" name="allChk" class="allChk" onclick="fncAllChk(this)"><span></span></label></th>
				<th scope="col">번호</th>
				<th scope="col">요구사항 ID</th>
				<th scope="col">요구사항 항목</th>
				<th scope="col">요구사항 세부내역</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0 }">
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr style="cursor: default;" id="rqst_${result.rqrSn }">
							<td onclick="event.cancelBubble=true">
								<label class="chkbox2">
									<input type="checkbox" class="allSrchChk" value="${result.rqrSn }" id="chkbox_${result.rqrSn }" onclick="fncAddRqst('${result.rqrSn }');">
									<span></span>
								</label>
							</td>
							<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
							<td class="rqrId"><c:out value="${result.rqrId }"/></td>
							<td class="rqrItm"><c:out value="${result.rqrItm }"/></td>
							<td class="rqrDtl ellipsis l"><c:out value="${result.rqrDtl }"/></td>
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
		<a href="javascript:void(0)" class="btn btn_mdl btn_save" onclick="fncSetRqst();">추가</a>
	</div>
</div>
<script>
$(document).ready(function(){
	
	rqstArray.map( function(item) {
		$("#chkbox_"+item.rqrSn).prop("checked", true);
	})

	fncAllChecked()

	$("#tblRqst").on('click', 'tr', function(e) {
		var checkbox;
		var isChecked;

		if ($(e.target).is('input:checkbox')) {
			checkbox = $(e.target);
			isChecked = checkbox.prop('checked');
			checkbox.prop('checked', !isChecked);
			fncAddRqst(checkbox.val());
		} else {
			chkbox = $(this).find('td:first-child :checkbox');
			isChecked = chkbox.prop('checked');
			chkbox.prop('checked', !isChecked);
			fncAddRqst(chkbox.val());
		}
	});
	
});

function fncAllChecked(){
	let chkCnt = 0;
	let boxCnt = 0;
	$(".allSrchChk").each(function(){
		boxCnt++;
		if($(this).is(":checked")){
			chkCnt++;
		}else{
			chkCnt--;
		}
	});

	if(chkCnt == boxCnt && boxCnt > 0) {
		$(".allChk").prop("checked",true);
	}else{
		$(".allChk").prop("checked",false);
	}
}


function fncAddRqst(divnSn) {

	fncAllChecked()

	if( $("#chkbox_"+divnSn).is(":checked") ) {
		var check = true;
		rqstArray.map( function(item) {
			let eDivnSn = item.rqrSn
			if(eDivnSn == divnSn) {
				check = false;
			}
		})
		
		if( check ) {
			var rqst = {
				rqrSn : divnSn,
				rqrId : $("#rqst_"+divnSn).find(".rqrId").text(),
				rqrItm : $("#rqst_"+divnSn).find(".rqrItm").text(),
				rqrDtl : $("#rqst_"+divnSn).find(".rqrDtl").text(),
			};
			
			rqstArray.push(rqst);
		}
	} else {
		rqstArray = rqstArray.filter( function(e) {
			let eDivnSn = e.rqrSn
			return eDivnSn != divnSn;
		});
	}

	console.log(rqstArray)
}
</script>