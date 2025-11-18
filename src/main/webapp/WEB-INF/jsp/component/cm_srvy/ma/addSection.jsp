<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:if test="${searchVO.sectionLength ne '0'}">
	<div class="sidebyside mar_t60 srvy_section_<c:out value="${searchVO.srvySctnSerno}"/>">
		<div class="left">
			<h4 class="md_tit"><span class="secTot"></span> 중 <span class="secNo" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>"></span> 섹션</h4>
		</div>
		<div class="right">
			<div class="btn_area">
				<button type="button" class="btn sml blue" id="btn_addQst_0_<c:out value="${searchVO.srvySctnSerno}"/>" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>">항목 추가</button>
			</div>
		</div>
	</div>
</c:if>
	<div class="srvy_section srvy_section_<c:out value="${searchVO.srvySctnSerno}"/>" id="srvy_section_<c:out value="${searchVO.srvySctnSerno}"/>" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>">
		<table class="board_write">
			<caption>내용(섹션제목,섹션내용,진행섹션 등으로 구성)</caption>
			<colgroup>
				<col class="w20p">
			    <col>
			    <col class="w90">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="asterisk">*</span> 섹션제목</th>
					<td>
						<input type="text" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].srvySctnTitl" id="srvySctnTitl_<c:out value="${searchVO.srvySctnSerno}"/>" class="w100p" maxlength="100" title="섹션제목" required="required">
						<input type="hidden" id="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].srvySctnSerno"  class="srvy_sec_no"  value="<c:out value="${searchVO.srvySctnSerno}"/>"/>
					</td>
					<td rowspan="3" class="c">
		            	<button type="button" class="btn sml red btn_del_section"  data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>">삭제</button>
		            </td>
				</tr>
				<tr>
					<th scope="row">섹션내용</th>
					<td>
						<textarea name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].srvySctnCtt" maxlength="250" title="섹션내용"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">진행 섹션</th>
					<td>
						<select name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].srvyNextSctnNo" class="next_sec">
							<option value="">다음 섹션으로 이동</option>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="srvy_entry srvy_qst_itm_<c:out value="${searchVO.srvySctnSerno}"/>" id="qst_<c:out value="${searchVO.srvySctnSerno}"/>_0">
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
							<input type="text" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[0].srvyQstTitl" id="srvyQstTitl_<c:out value="${searchVO.srvySctnSerno}"/>" class="w100p"  maxlength ="100" title="항목제목" required="required">
						</td>
						<td rowspan="5" class="c">
		                    <button type="button" class="btn sml red btn_del_qst" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="0">삭제</button>
		                </td>
					</tr>
					<tr>
						<th scope="row">필수여부</th>
						<td>
							<span class="chk">
		                    	<span class="cbx"><input type="checkbox" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[0].srvyNcsrYn" value="Y" id="srvyNcsrYn_<c:out value="${searchVO.srvySctnSerno}"/>_0" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="0" checked="checked"><label for="srvyNcsrYn_<c:out value="${searchVO.srvySctnSerno}"/>">필수항목</label></span>
		                    </span>	
						</td>
					</tr>
					<tr>
						<th scope="row">항목설명</th>
						<td>
							<input type="text" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[0].srvyQstCtt"  maxlength="250"  placeholder="항목에 대한 자세한 설명을 입력해주세요." class="w100p">
						</td>
					</tr>
					<tr>
						 <th scope="row"><span class="asterisk">*</span> 유형</th>
						<td>
							<select name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[0].srvyAnsCgVal" id="srvyAnsCgVal_<c:out value="${searchVO.srvySctnSerno}"/>_0" class="auto" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>"  data-srvyqstserno="0" title="유형" required="required">
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
							<div id="srvy_qst_itm_<c:out value="${searchVO.srvySctnSerno}"/>_0"></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
