<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- no_data colspan 자동 셋팅 --%>
	fncColLength();
	
	<%-- 비밀글 여부 체크 --%>
	<c:if test="${fn:length(resultList) > 0 }">
		$('.board_list tbody tr').on('click', function(){
			if($(this).data('scretyn') == "비밀"){
				view_show('1');
				$("#pswd_serno").val($(this).closest('tr').data('bltnbserno'));
			}else{
				fncPageBoard('view', 'view.do', String($(this).closest('tr').data('bltnbserno')), 'bltnbSerno');
				return false;
			}
		});
	</c:if>

	$('#btn_bltnb_write').on('click', function(){
		fncPageBoard('write', 'insertForm.do');
	});

	<%--비밀번호 확인창 닫기--%>
	$(".btn_pop_close").on('click', function(){
		view_hide('1');
	});
	
	$('#js_popup_bg').click(function () {
		view_hide('1');
	});

	<%--비밀번호 확인--%>
	$("#btn_pop_pswd_check").on('click', function(){
		$.ajax({
			type : 'post'
			,url : 'pswdCheck'
			,data : $('#defaultFrmPswd').serialize()
			,dataType : 'json'
			,success : function(data) {
				if(data.check == true){
					fncPageBoard('view', 'view.do', $("#pswd_serno").val(), 'bltnbSerno');
				}else{
					alert("비밀번호가 일치하지 않습니다.")
					$("#bltnb_pswd").val("");
					$("#bltnb_pswd").focus();
					return false;
				}
			},error: function (xhr, status, error) {
				if (xhr.status == 401) {
					window.location.reload();
				}
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			},beforeSend : function(req){
				fncLoadingStart();
			},complete : function(){
				fncLoadingEnd();
			}
		});
	});

})
</script>
<div class="board_top">
    <div class="board_left">
        <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num"><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
    </div>
    <div class="board_right">
	    <jsp:directive.include file="/WEB-INF/jsp/common/inRecordPage.jsp"/>
    </div>
</div>
<table class="board_list">
	<colgroup>
		<col class="w5p"/>
		<col class="w8p"/>
		<col class="w8p"/>
		<col/>
		<col class="w10p"/>
		<col class="w10p"/>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">비밀글여부</th>
			<th scope="col">답변여부</th>
			<th scope="col">제목</th>
			<th scope="col">등록자</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr data-bltnbserno="<c:out value='${result.bltnbSerno}'/>" data-scretyn="<c:out value='${result.scretYn}'/>">
						<td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
						<td>
							<c:choose>
								<c:when test="${result.scretYn eq '비밀'}"> 							
									<i class="xi-lock"></i>						
								</c:when>
								<c:otherwise>
									<c:out value="${result.scretYn}"/>
								</c:otherwise>
							</c:choose>
						</td>
						<td><c:out value="${result.replCtt}"/></td>
						<td class="l ellipsis">
			                <a href="#" class="ellipsis td_view"><c:out value="${result.bltnbTitl }"/></a>
			            </td>
			            <td><c:out value="${result.regrNm }"/></td>
						<td><c:out value="${result.regDt }"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="no_data" colspan="6">데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="paging_wrap">
	<ul class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</ul>
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<div class="btn_right">
			<button type="button" id="btn_bltnb_write" class="btn blue">등록</button>
		</div>
	</c:if>
</div>
<div id="display_view1" class="layer_pop js_popup">
	 <div class="pop_header">
        <h2>비밀번호입력</h2>
        <button type="button" class="pop_close btn_pop_close"><i class="xi-close-thin"></i>닫기</button>
    </div>
    <div class="pop_content" style="max-height: 300px;" data-simplebar data-simplebar-auto-hide="false">
    	<form name="defaultFrmPswd" id="defaultFrmPswd" method="post" onsubmit="return false;">
        	<input type="password" name="bltnbPswd" id="bltnb_pswd" maxlength="10"/>
        	<input type="hidden" name="bltnbSerno" id="pswd_serno"/>
        </form>
    </div>
    <div class="pop_footer">
    	<button type="button" class="btn bd blue" id="btn_pop_pswd_check">확인</button>
        <button type="button" class="btn gray btn_pop_close">닫기</button>
    </div>
</div>
<div class="popup_bg" id="js_popup_bg"></div>