<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div id="terms_$idx$" class="mar_b30">
	<input type="hidden" id="termsSerno_$idx$">
   	<input type="hidden" id="seqo_$idx$">
	<table class="board_write">
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
					<select id="selTpCd_$idx$" title="약관유형" required="true">
			        </select>
				</td>
				<th scope="row"><span class="asterisk">*</span>보유기간</th>
				<td>
					<c:choose>
						<c:when test="${menuId eq 'termsScrb' }">
							<select id="prdUnitCd_$idx$" title="보유기간" required="true">
						    </select>
						</c:when>
						<c:otherwise>
							<input type="hidden" id="prdUnitCd_$idx$" value="<c:out value="${sessionScope.lginPlcy_info.scssAccPssnPrdCd }"/>"/><c:out value="${sessionScope.lginPlcy_info.scssAccPssnPrdNm }"/>
						</c:otherwise>
					</c:choose>
			    <th scope="row"><span class="asterisk">*</span>출력기간</th>
				<td>
					<div id="calendar_$idx$">
						<span class="calendar_input">
							<input type="text" id="otptStrtDt_$idx$" title="출력기간" required="true" readonly>
						</span>
						<span class="gap">~</span>
						<span class="calendar_input" style="flex: 1;">
							<input type="text" id="otptEndDt_$idx$" title="출력기간" required="true" readonly>
						</span>
					</div>
				</td>
				<th scope="row"><span class="asterisk">*</span>노출여부</th>
				<td>
					<span class="chk">
						<span class="radio"><input type="radio" id="expsrYn_Y_$idx$" title="노출여부" value="Y" checked="true" required="true"/><label for="expsrYn_Y_$idx$">노출</label></span>
						<span class="radio"><input type="radio" id="expsrYn_N_$idx$" title="노출여부" value="N" required="true"/><label for="expsrYn_N_$idx$">미노출</label></span>
					</span>
				</td>
				<td id="btn_seqoUp_$idx$" class="c"></td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>약관제목</th>
				<td colspan="7">
					<input type="text" id="titlNm_$idx$" class="w100p" title="약관제목" required="true" maxlength="60" >
				</td>
				<td id="btn_seqoDown_$idx$" class="c"></td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>약관내용</th>
				<td colspan="7">
					<textarea id="termsCtt_$idx$" class="editor" title="약관내용" required="true"></textarea>
				</td>
				<td id="btn_terms_$idx$" class="c"></td>
			</tr>
		</tbody>
	</table>
</div>