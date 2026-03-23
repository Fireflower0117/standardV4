<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<c:choose>
	<c:when test="${searchVO.selectOption eq '1'}">
		<%--단문형--%>
		<span class="chk" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">
			<span class="radio">
				<input type="radio" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal1" value="30" checked="checked" id="inputSize_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_30">
				<label for="inputSize_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_30"> 30자</label>
			</span>&nbsp;
			<span class="radio">
				<input type="radio" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal1" value="50" id="inputSize_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_50">
				<label for="inputSize_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_50"> 50자</label>
			</span>&nbsp;
			<span class="radio">
				<input type="radio" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal1" value="80" id="inputSize_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_80">
				<label for="inputSize_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_80"> 80자</label>
			</span>
		</span><br/>
		<input type="text" id="itmType_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>" style="width: 150px;" readonly="readonly" placeholder="30자">
	</c:when>
	<c:when test="${searchVO.selectOption eq '2'}">
		<%--장문형--%>
		<textarea class="text w100p" readonly="readonly"></textarea>
	</c:when>
	<c:when test="${searchVO.selectOption eq '3'}">
		<%--객관식--%>
				
		<div class="mar_b5" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">
			<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
			<span>또는 </span>
			<button type="button" class="btn sml"  id="add_qst_itm_etc">기타 추가</button>
		</div>
		<div class="nextSecChk_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>">
			<input type="checkbox" name="sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyNextSctnYn" value="Y"  id="nextSecChk_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">
			<label for="nextSecChk_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>">답변을 기준으로 섹션이동</label>
			<br/>
		</div>
		<div class='mar_t5' id='srvy_qst_itm_add_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>'>
			<div id='itmList_0'>
				<input type='text' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyQstItmCtt' maxlength = '30' style="width: 300px;" title='옵션' id="option_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0" required="required">
				<select name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyNextSctnNo' class='nextSeNo_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/> ans_next_sec' style='display:none;'>
					<option value=''>다음 섹션으로 이동</option>
				</select>
				<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="0" data-rplycl="3" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>"><span>삭제</span></button>
				<br/>
			</div>
		</div>
	</c:when>
	<c:when test="${searchVO.selectOption eq '4'}">
		 <%--체크박스--%>
		<div class="mar_b5" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">
			<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
			<span>또는</span>
			<button type="button" class="btn sml" id="add_qst_itm_etc">기타 추가</button>
		</div>
		선택 가능 갯수
		<select name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyChcCnt' id="nextRply_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>" class="mar_l16">
			<option value='1' selected='selected'>1</option>
		</select>
		<div id='srvy_qst_itm_add_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>' class='mar_t5'>
			<div id='itmList_0'>
				<input type='text' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyQstItmCtt' style="width: 300px;" maxlength = '30' title='옵션' id="option_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0" required="required">
				<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="0" data-rplycl="4" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>"><span>삭제</span></button>
				<br/>
			</div>
		</div>
	</c:when>
	<c:when test="${searchVO.selectOption eq '5'}">
		<%--파일--%>
		<span>파일첨부</span>
	</c:when>
	<c:when test="${searchVO.selectOption eq '6'}">
		<%--이미지--%>				
		<div class="mar_b5" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">
			<button type="button" class="btn sml"  id="add_qst_itm">문항 추가</button>
		</div>
		선택 가능 갯수
		<select name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyChcCnt' id="nextRply_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>" class="mar_l16">
			<option value='1' selected='selected'>1</option>
		</select>
		<div id='srvy_qst_itm_add_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>' class='mar_t5'>
			<div id='itmList_0'>
				<div id="atchFileDiv_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0" class="field" style="display: inline-block;"></div>
				<input type='hidden' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyQstItmCtt' id='qstFile_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0'>
				<button type='button' class='btn sml delete_itm_element' data-qstitmidx="0" data-rplycl="6" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>" style="position: relative; top:-21px;"><span>삭제</span></button>
			</div>
		</div>
	</c:when>
	<c:when test="${searchVO.selectOption eq '7'}">
		<%--선호도--%>					
		<div class="mar_b5">점수범위 선택</div>
		<input type='text' title='옵션' placeholder='예) 싫다' maxlength = '30' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal1' id='srvyItmTpVal1_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0' id="option1_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0" required="required"> 
		<select name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal2' id='srvyItmTpVal2_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0'>
			<option value='0'>0</option>
			<option value='1' selected='selected'>1</option>
		</select> ~ 
		<select name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal3' id='srvyItmTpVal3_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0'>
			<option value='3'>3</option>
			<option value='4'>4</option>
			<option value='5' selected='selected'>5</option>
			<option value='6'>6</option>
			<option value='7'>7</option>
			<option value='8'>8</option>
			<option value='9'>9</option>
			<option value='10'>10</option>
		</select>
		<input type='text' title='옵션' placeholder='예) 좋다' maxlength = '30' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal4' id='srvyItmTpVal4_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0' id="option2_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0" required="required">				
	</c:when>
	<c:when test="${searchVO.selectOption eq '8'}">
		<%--날짜--%>
		<div class="mar_b5" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">
			<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
		</div>
		선택 가능 갯수
		<select name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyChcCnt' id="nextRply_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>"  class="mar_l16">
			<option value='1' selected='selected'>1</option>
		</select>
		<div id='srvy_qst_itm_add_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>' class='mar_t5'>
			<div id='itmList_0'>
				<span class="calendar_input"><input type='text' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal1' id='qstDate_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0'  readonly='readonly' title='옵션' required="required"></span>
				&nbsp; / &nbsp;
				<input type='time' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyItmTpVal2' id='qstTime_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0' maxlength = '30' style="width: 130px;" required="required">
				<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="0" data-rplycl="8" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>"><span>삭제</span></button>
				<br/>
			</div>
		</div>
	</c:when>
	<c:when test="${searchVO.selectOption eq '9'}">
		<%--동영상--%>				
		<div class="mar_b5" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>">
			<button type="button" class="btn sml" id="add_qst_itm">문항 추가</button>
		</div>
		선택 가능 갯수
		<select name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].srvyChcCnt' id="nextRply_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>"  class="mar_l16">
			<option value='1' selected='selected'>1</option>
		</select>
		<div id='srvy_qst_itm_add_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>' class='mar_t5'>
			<div id='itmList_0'>
				<input type='text' name='sctnList[<c:out value="${searchVO.srvySctnSerno}"/>].qstList[<c:out value="${searchVO.srvyQstSerno}"/>].qstItmList[0].srvyQstItmCtt' maxlength = '200' placeHolder='URL을 입력 해 주세요' style="width: 500px;" title='옵션' id="option_<c:out value="${searchVO.srvySctnSerno}"/>_<c:out value="${searchVO.srvyQstSerno}"/>_0" required="required">
				<button type='button' class='btn sml mar_l5 delete_itm_element' data-qstitmidx="0" data-rplycl="9" data-srvysctnserno="<c:out value="${searchVO.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${searchVO.srvyQstSerno}"/>"><span>삭제</span></button>
				<br/>
			</div>
		</div>
	</c:when>
</c:choose>
		
		
		
		
		
		

		


