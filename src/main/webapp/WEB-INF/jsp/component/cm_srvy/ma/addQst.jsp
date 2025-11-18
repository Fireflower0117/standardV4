<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="srvy_entry srvy_qst_itm_<c:out value="${searchVO.srvySctnSerno}"/>" id="qst_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>" class="mar_b30">
	 <table class="board_write">
		<caption>내용(항목제목,필수여부,항목설명,유형,옵션 등으로 구성)</caption>
		<colgroup>
			<col class="w20p">
			<col>
			<col class="w90">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span> 항목제목</th>
				<td>
					<input type="text" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyQstTitl" id="srvyQstTitl_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>"  class="w100p"  maxlength ="100" title="항목제목" required="required">
				</td>
				<td rowspan="5" class="c">
		            <button type="button" class="btn sml red btn_del_qst" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">삭제</button>
				</td>
			</tr>
			<tr>
				 <th scope="row">필수여부</th>
				<td>
					<span class="chk">
		            	<span class="cbx"><input type="checkbox" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyNcsrYn" value="Y" id="srvyNcsrYn_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>" checked="checked"><label for="srvyNcsrYn_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>">필수항목</label></span>
					</span>	
				</td>
			</tr>
			<tr>
				<th scope="row">항목설명</th>
				<td>
					<input type="text" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyQstCtt"  maxlength="250" placeholder="항목에 대한 자세한 설명을 입력해주세요." class="w100p">
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span> 유형</th>
				<td>
					<select name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyAnsCgVal" id="srvyAnsCgVal_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>" class="select_option_change" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>" title="유형" required="required">
						<option value="">선택</option>
						<option value="1">단답형</option>
						<option value="2">장문형</option>
						<option value="3">객관식</option>
						<option value="4">체크박스</option>
						<option value="5">파일</option>
						<option value="6">이미지</option>
						<option value="7">선호도 점수</option>
						<option value="8">날짜/시간</option>
						<option value="9">동영상</option>
					</select>
				</td>
			</tr>
			<tr>
				 <th scope="row">옵션</th>
				<td>
					<div id="srvy_qst_itm_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>"></div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
