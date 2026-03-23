<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){	
	<c:if test ="${not empty procMsg}">
		alert("<c:out value='${procMsg}'/>");
	</c:if>

	$("#btn_submit").click(function(){
		$("#bltnbSeVal").removeAttr("disabled"); 
		fncPageBoard('submit','updateProc.do');
	});
	
});
</script>
<h3 class="md_tit">메뉴설정</h3>
<form:form modelAttribute="itsmMenuVO" id="defaultFrm" name="defaultFrm" method="post">
	<form:hidden path="menuSerno" id="menuSerno"/>
	<form:hidden path="menuCd" id="menuCd"/>
	<form:hidden path="menuSeCd" id="menuSeCd"/>
	<form:hidden path="menuLvl" id="menuLvl"/>
	<form:hidden path="menuUrlAddr" id="menuUrlAddr"/>
	<div class="board_write">
		<table class="board_row_type01">
			<colgroup>
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:20%;">
				<col style="width:30%;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><strong class="th_tit">메뉴명</strong></th>
					<td>
						<form:input path="menuNm"/>
					</td>
					<th scope="row"><strong class="th_tit">부모메뉴코드</strong></th>
					<td><c:out value="${itsmMenuVO.uprMenuCd }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong class="th_tit">순서</strong></th>
					<td><c:out value="${itsmMenuVO.menuSeqo }"/></td>
					<th scope="row"><strong class="th_tit">메뉴코드</strong></th>
					<td><c:out value="${itsmMenuVO.menuCd }"/></td>
				</tr>
				<tr>
					<th scope="row"><strong class="th_tit">단계</strong></th>
					<td><c:out value="${itsmMenuVO.menuLvl }차메뉴"/></td>
					<th scope="row"><strong class="th_tit">노출여부</strong></th>
					<td>
						<span class="chk">
							<span class="radio"><form:radiobutton path="expsrYn" id="expsrYn_Y" cssClass="radio" value="Y" checked="true"/><label for="expsrYn_Y">노출</label></span>
							<span class="radio"><form:radiobutton path="expsrYn" id="expsrYn_N" cssClass="radio" value="N" /><label for="expsrYn_N">비노출</label></span>
						</span>
					</td>
				</tr>
				<c:if test="${itsmMenuVO.menuLvl eq '2' }">
					<tr>
						<th scope="row"><strong class="th_tit">메뉴하부탭여부</strong></th>
						<td colspan="3">
							<form:select path="lwrTabYn" disabled="${itsmMenuVO.tabUseYn eq 'N' ? 'true' : 'false' }">
								<form:option value="N" label="미해당"/>
								<form:option value="Y" label="해당"/>
							</form:select>
							<c:if test="${itsmMenuVO.tabUseYn eq 'N' }"><span style="color: red; font-size: 13px; position: relative;">※해당 메뉴 하부에 4차 메뉴가 존재합니다.</span></c:if>
						</td>
					</tr>
				</c:if>
				<tr>
					<th scope="row">URL</th>
					<td>
						<c:out value="${itsmMenuVO.menuUrlAddr }"/>
					</td>
					<th scope="row">새창에서 열기 여부</th>
					<td>
						<span class="chk">
							<span class="radio"><form:radiobutton path="targetBlankYn" id="targetBlankYn_N" cssClass="radio" value="N" checked="${ itsmMenuVO.targetBlankYn == 'N' ? 'checked' : '' }"/><label for="targetBlankYn_N">현재창</label></span>
							<span class="radio"><form:radiobutton path="targetBlankYn" id="targetBlankYn_Y" cssClass="radio" value="Y" checked="${ itsmMenuVO.targetBlankYn == 'Y' ? 'checked' : '' }" /><label for="targetBlankYn_Y">새창</label></span>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong class="">메뉴설명</strong></th>
					<td colspan="3">
						<form:input path="menuExpl" class="text w100p"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>   
	<div class="btn_area">
		<a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl btn_save">저장</a>
		<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel" >취소</a>
	</div>	
</form:form>