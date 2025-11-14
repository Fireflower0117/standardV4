<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 약관 수 --%>
let termIdx = '<c:out value="${fn:length(termsList)}"/>' - 1;

<%-- 약관 내용 에디터 추가 --%>
const fncSetEditor = function(id){
	$('#' + id).siblings().remove();
	CKEDITOR.replace(id, {height : 400, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>/ma/js/ckeditor/contents.css'});
}

<%-- 약관유형, 보유기간 selectbox 세팅 --%>
const fncSetCode = function(idx){

	<%-- 약관유형 selectBox 조회--%>
	fncCodeList("TRTP", "select", "선택", "", "", "selTpCd_" + idx);
	<c:if test="${menuId eq 'termsScrb'}">
		<%-- 회원가입 약관의 경우, 보유기간 selectBox 조회--%>
		fncCodeList("TRPU", "select", "선택", "", "", "prdUnitCd_" + idx);
	</c:if>
	
}
<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
	<%-- 약관 버튼 세팅 --%>
	const fncSetBtnTerms = function() {
		
		let btnAddHtml;
		let btnDelHtml;
		let btnSeqoUpHtml;
		let btnSeqoDownHtml;
		let idx;
		
		let length = $('div[id^="terms_"]').length;
		$('div[id^="terms_"]').each(function(index){
			
			idx = $(this).attr('id').split('_')[1];
			btnAddHtml      = '<button type="button" class="btn ic btn_addTerms"><i class="xi-plus"></i></button>';
			btnDelHtml      = '<button type="button" class="btn ic btn_delTerms"><i class="xi-trash"></i></button>';
			btnSeqoUpHtml   = '<button type="button" class="btn ic btn_sortUp"><i class="xi-caret-up"></i></button>';
	 		btnSeqoDownHtml = '<button type="button" id="' + idx + '" class="btn ic btn_sortDown"><i class="xi-caret-down"></i></button>';
			
	 		<%-- 버튼 초기화 --%>
	 		$('#btn_seqoUp_' + idx).empty();
	 		$('#btn_seqoDown_' + idx).empty();
	 		$('#btn_terms_' + idx).empty();
	 		
			<%-- 순서 ▲ 버튼 --%>
			if(index != 0) {
				$('#btn_seqoUp_' + idx).html(btnSeqoUpHtml);
			}
	
			<%-- 순서 ▼ 버튼 --%>
			if(index != (length - 1)) {
				$('#btn_seqoDown_' + idx).html(btnSeqoDownHtml);
			}
			
			<%-- 추가 버튼 --%>
	 		if(index == (length - 1)) {
				$('#btn_terms_' + idx).html(btnAddHtml);
			}
	 		
	 		<%-- 삭제 버튼 --%>
	 		$('#btn_terms_' + idx).append(btnDelHtml);
	 		
	 		
			<%-- 이용약관 추가 이벤트 트리거 --%>
			$('div#terms_' + idx + ' .btn_addTerms').on('click', function(){
				fncAddTerms();
			});
			
			<%-- 이용약관 삭제 이벤트 트리거 --%>
			$('div#terms_' + idx + ' .btn_delTerms').on('click', function(){
				fncDelTerms($(this).parents('div').attr('id').split('_')[1]);
			});
			
			<%-- 이용약관 순서변경 이벤트 트리거 --%>
	 		$('div#terms_' + idx + ' .btn_sortUp').on('click', function(){
	 			fncSortAction($(this).parents('div').attr('id').split('_')[1], 'up');
	 		});
	 		$('div#terms_' + idx + ' .btn_sortDown').on('click', function(){
	 			fncSortAction($(this).parents('div').attr('id').split('_')[1], 'down');
	 		});
		});
		
	}
	<%-- 순서 세팅 --%>
	const fncSetSortSeqo = function() {
		$('div[id^="terms_"]').each(function(index){
			$(this).children('[id^="seqo"]').val(index + 1);
		});
	}
	<%-- 이용약관 추가 클릭 이벤트 --%>
	const fncAddTerms = function() {
		
		termIdx++;
		
		$.ajax({
			type : 'get'
		   ,url : 'addForm.do'
		   ,dataType : 'html'
		   ,success : function(data){
			   
			   data = data.split('$idx$').join(termIdx);
			   
			   <%-- html append --%>
				$(".tbl").append(data);
				
				<%-- 약관유형, 보유기간 selectbox 세팅 --%>
				fncSetCode(termIdx);
				
				<%-- 출력기간 달력 세팅 --%>
				fncDate("otptStrtDt_" + termIdx, "otptEndDt_" + termIdx);
				
				<%-- 순서 세팅 --%>
				fncSetSortSeqo();
			    
				<%-- 이용약관 버튼 세팅 --%>
				fncSetBtnTerms();
			    
				<%-- 약관내용 에디터 적용 --%>
				fncSetEditor("termsCtt_" + termIdx);
		   }
		   ,error: function (xhr, status, error) {
				
				if (xhr.status == 401) {
			  		window.location.reload();
				}
		   }
		});
	}
	<%-- 이용약관 삭제 클릭 이벤트 --%>
	const fncDelTerms = function(idx) {
		$("#terms_" + idx).remove();
		
		let length = $("div[id^='terms_']").length;
		
		if(length > 0) {
			
			<%-- 순서 세팅 --%>
			fncSetSortSeqo();
			
			<%-- 이용약관 버튼 세팅 --%>
			fncSetBtnTerms();
			
		} else {
			<%-- 이용약관 항목 추가 --%>
			fncAddTerms();
		}
	}
	<%-- 순서 변경 --%>
	const fncSortAction = function(idx, divn){
		let seqo = $('#seqo_' + idx).val();

		<%-- 맨위 --%>
		if(divn == 'up' && seqo == '1'){
			return false;
		}
		<%-- 맨아래 --%>
		if(divn == 'down' && seqo == $("div[id^='terms_']").length){
			return false;
		}
		
		$("#terms_" + idx).find("iframe").remove();
		
		let tempHtml = $('#terms_' + idx).clone();
		let target = '';
		
		if(divn == 'up'){
			target = $('#terms_' + idx).prev();
			$('#terms_' + idx).remove();
			target.before(tempHtml);
		} else if(divn == 'down'){
			target = $('#terms_' + idx).next();
			$('#terms_' + idx).remove();
			target.after(tempHtml);
		}

		<%-- 순서 세팅 --%>
		fncSetSortSeqo();

		<%-- 이용약관 버튼 세팅 --%>
		fncSetBtnTerms();

		<%-- 약관내용 에디터 적용 --%>
		fncSetEditor("termsCtt_"+idx);
	}
	<%-- 배열 name값 재할당 후 submit --%>
	const fncRelocationSubmit = function(callback){
		$("div[id^=terms_]").each(function(index, item){
			let idxCnt = $(this).attr("id").split("_")[1];
			$("#termsSerno_" + idxCnt).attr("name", "termsList["+index+"].termsSerno");
			$("#seqo_" + idxCnt).attr("name", "termsList["+index+"].seqo");
			$('#seqo_' + idxCnt).val(index + 1);
			$("#selTpCd_" + idxCnt).attr("name", "termsList["+index+"].selTpCd");
			$("#prdUnitCd_" + idxCnt).attr("name", "termsList["+index+"].prdUnitCd");
			$("#otptStrtDt_" + idxCnt).attr("name", "termsList["+index+"].otptStrtDt");
			$("#otptEndDt_" + idxCnt).attr("name", "termsList["+index+"].otptEndDt");
			$("#expsrYn_Y_" + idxCnt).attr("name", "termsList["+index+"].expsrYn");
			$("#expsrYn_N_" + idxCnt).attr("name", "termsList["+index+"].expsrYn");
			$("#titlNm_" + idxCnt).attr("name", "termsList["+index+"].titlNm");
			$("#termsCtt_" + idxCnt).attr("name", "termsList["+index+"].termsCtt");
		}); 
		
		return true;
	}
</c:if>
$(document).ready(function(){

	<%-- 약관 건수에 따른 분기 --%>
	<c:choose>
		<c:when test="${fn:length(termsList) > 0 }">
			<%-- 날짜 세팅 --%>
			$('td[id^="calendar_"]').each(function(){
				let idx = $(this).attr('id').split('_')[1];
				fncDate('otptStrtDt_' + idx, 'otptEndDt_' + idx);
			});
			
			<%-- 에디터 세팅 --%>
			$('textarea[id^="termsCtt_"]').each(function(){
				fncSetEditor($(this).attr('id'));
			});
			
			<c:forEach var="result" items="${termsList}" varStatus="status">
				<%-- 약관유형 selectBox 조회--%>
				fncCodeList('TRTP', 'select', '선택', '<c:out value="${result.selTpCd}"/>', '', 'selTpCd_<c:out value="${status.index }"/>');
				<c:if test="${result.termsClCd eq 'termsScrb'}">
					<%-- 보유기간 selectBox 조회--%>
					fncCodeList('TRPU', 'select', '선택', '<c:out value="${result.prdUnitCd}"/>', '', 'prdUnitCd_<c:out value="${status.index }"/>');
				</c:if>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
				fncAddTerms();
			</c:if>
		</c:otherwise>
	</c:choose>
	
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<%-- 약관 버튼 세팅 --%>
		fncSetBtnTerms();
	
		<%-- 저장 클릭 이벤트 --%>
		$("#btn_submit").click(function(){
			$('textarea[id^="termsCtt_"]').each(function(){
				$(this).val(CKEDITOR.instances[$(this).attr('id')].getData());
	 		});
	 		
	 		<%-- name 재할당 → 유효성검사 → submit --%>
 			if(fncRelocationSubmit()){
	 			if(wrestSubmit(document.defaultFrm)){
	 				fncProc('<c:out value="${fn:length(termsList) > 0 ? \'update\' : \'insert\'}"/>');
	 			}
	 		}
		});
	</c:if>
});


</script>
<form name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<div class="sidebyside">
		<div class="right">
			<div class="board_top">
				<div class="board_right">
					<div class="form_guide red_txt">
						<span class="asterisk">*</span>모든 작업을 완료한 후 하단에 저장 버튼을 클릭해 주세요.
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="tbl">
		<c:if test="${fn:length(termsList) > 0 }">
			<c:forEach var="result" items="${termsList }" varStatus="status">
				<div id="terms_<c:out value='${status.index }'/>" class="mar_b30">
					<input type="hidden" id="termsSerno_<c:out value='${status.index }'/>" value="<c:out value='${result.termsSerno}'/>">
					<input type="hidden" id="seqo_<c:out value='${status.index }'/>" value="<c:out value='${result.seqo }'/>">
					<table class="board_write">
						<caption>내용(약관유형 항목, 보유기간, 출력기간, 노출여부, 약관제목, 약관내용으로 구성)</caption>
						<colgroup>
							<col class="w8p">
							<col class="w12p">
							<col class="w8p">
							<col class="w12p">
							<col class="w8p">
							<col>
							<col class="w8p">
							<col class="w12p">
							<col class="w8p">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span class="asterisk">*</span>약관유형</th>
								<td>
									<select id="selTpCd_<c:out value='${status.index }'/>" title="약관유형" required="true"></select> 
								</td>
								<th scope="row"><span class="asterisk">*</span>보유기간</th>
								<td>
									<c:choose>
										<c:when test="${result.termsClCd eq 'termsScrb' }">
											<select id="prdUnitCd_<c:out value='${status.index }'/>" title="보유기간" required="true"></select> 
										</c:when>
										<c:otherwise>
											<input type="hidden" id="prdUnitCd_<c:out value='${status.index }'/>" value="<c:out value="${result.prdUnitCd }"/>"/><c:out value="${result.prdUnitNm }"/>
										</c:otherwise>
									</c:choose>
								</td>
								<th scope="row"><span class="asterisk">*</span>출력기간</th>
								<td id="calendar_<c:out value='${status.index }'/>">
									<span class="calendar_input">
										<input type="text" id="otptStrtDt_<c:out value='${status.index }'/>" value="<c:out value='${result.otptStrtDt }'/>" title="출력시작일" required="true">
									</span>
									<span class="gap">~</span>
									<span class="calendar_input">
										<input type="text" id="otptEndDt_<c:out value='${status.index }'/>" value="<c:out value='${result.otptEndDt }'/>" title="출력종료일" required="true">
									</span>
								</td>
								<th scope="row"><span class="asterisk">*</span>노출여부</th>
								<td>
									<span class="chk">
										<span class="radio">
											<input type="radio" id="expsrYn_Y_<c:out value='${status.index }'/>" title="노출여부" value="Y" <c:out value="${result.expsrYn eq 'Y' ? 'checked=true' : ''}"/> required="true"/>
											<label for="expsrYn_Y_<c:out value='${status.index }'/>">노출</label>
										</span>
										<span class="radio">
											<input type="radio" id="expsrYn_N_<c:out value='${status.index }'/>" title="노출여부" value="N" <c:out value="${result.expsrYn eq 'N' ? 'checked=true' : ''}"/> required="true"/>
											<label for="expsrYn_N_<c:out value='${status.index }'/>">미노출</label>
										</span>
									</span>
								</td>
								<td id="btn_seqoUp_<c:out value='${status.index }'/>" class="c"></td>
							</tr>
							<tr>
								<th scope="row"><span class="asterisk">*</span>약관제목</th>
								<td colspan="7">
									<input type="text" id="titlNm_<c:out value='${status.index }'/>" class="w100p" title="약관제목" required="required" value="<c:out value='${result.titlNm}'/>" maxlength="60">
								</td>
								<td id="btn_seqoDown_<c:out value='${status.index }'/>" class="c"></td>
							</tr>
							<tr>
								<th scope="row"><span class="asterisk">*</span>약관내용</th>
								<td colspan="7">
									<textarea id="termsCtt_<c:out value='${status.index }'/>" class="editor" title="약관내용" required="required">
										<c:out value="${result.termsCtt}"/>
									</textarea>
								</td>
								<td id="btn_terms_<c:out value='${status.index }'/>" class="c"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</c:forEach>
		</c:if>
	</div>
</form>
<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
	<div class="btn_area">
	     <button type="button" id="btn_submit" class="btn blue"><c:out value="${fn:length(termsList) > 0 ? '수정' : '등록'}"/></button>
	</div>
</c:if>