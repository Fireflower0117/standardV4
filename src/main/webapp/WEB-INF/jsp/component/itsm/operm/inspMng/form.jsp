<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	$(document).ready(function(){
		
		itsmFncColLength();
				
		fncCodeList("INGB", "select", "선택", "${itsmInspMngVO.inspGbn}", "inspGbn", "inspGbn", "", "ASC");

		let procType = "${searchVO.procType}";

		<%-- 드래그앤드롭 --%>
		$("#frmContainer").sortable({
			stop : function(){
				<%-- 상세흐름 순서 셋 --%>
				setDataNo();
				<%-- 유형 데이터세팅
                setInfoList() --%>;
			}
		});

		$("#btn_submit").click(function(){
			if($("[id^=itmSeqo_]").length == 0){
				alert("점검 항목을 추가하세요.");
				return false;
			}
			if(wrestSubmit(document.defaultFrm)){				
				itsmFncProc("<c:out value='${searchVO.procType}'/>");
			}
		});
	});
	let leng = '${not empty resultList ? fn:length(resultList) + 0 :0}'
	let leng2 = Number(leng) + 1;

	<%-- 상세흐름 순서 셋 --%>
	function setDataNo(){
		$(".numTd").each(function(index){
			$(this).find('span').text(index + 1)
			$(this).find('input').val(index + 1)
		});
	}

	<%-- 항목 삭제 --%>
	function fncInfoDel(id){
		if(confirm("항목을 삭제하시겠습니까?")){
			$('#'+id).remove();
			setDataNo();
			/*let arr = $("#itmSnList").val();
			for(var i = 0; i < arr.length ; i++) {
				arr.splice
			}*/
		}

		let rlf = $('input[ID^="ip_ipSn_"]').length;
		<%-- 최대 숫자구하기 --%>
		if(rlf < 1) {
			let newTypeHtml = '<tr class="no-data">';
			newTypeHtml +='		<td colspan="6">항목을 추가하세요.</td>';
			newTypeHtml +='</tr>';
			$("#frmContainer").append(newTypeHtml);
		}
		leng2 --;
	}

	function fncAddItm(arry){
		$("#itmSnList").val(arry);
		$.ajax({
			method: "POST"
			, url: "itmList.do"
			, data : $("#defaultFrm").serialize()
			, success: function(itmList) {
				//$("#frmContainer").empty();
				let html = "";
				if(itmList.length > 0){
					//leng += itmList.length ;
					//leng2 += itmList.length ;
					$.each(itmList, function (idx, result){
						let autoYn = '-';
						if(result.autoYn == 'Y') {
							autoYn = '시스템 자동 점검'
						}


						html += '       <tr id="itmTr_'+leng+'">';
						html += '           <td class="numTd"><span>'+leng2+'</span>';
						html += '				<input type="hidden" id="itmSeqo_'+leng+'" name="itmList['+leng+'].itmSeqo" value="'+leng2+'"/></td>';
						html += '           <td class="l">';
						html += result.itmCn;
						html += '				<input type="hidden" id="itmCn_'+leng+'" name="itmList['+leng+'].itmCn" value="'+result.itmCn+'"/>';
						html += '				<input type="hidden" id="itmSn_'+leng+'" name="itmList['+leng+'].itmSn" value="'+result.itmSn+'"/>';
						html += '           </td>';
						html += '           <td>';
						html += '           	<span class="radios">';
						html += '           		<label><input type="radio"  class="radio" disabled/> 정상</label>';
						html += '           		<label><input type="radio" class="radio" disabled/> 비정상</label>';
						html += '           	</span>';
						html += '           </td>';
						html += '           <td>';
						html += '           <span class="chk mar_l10">';
						html += '				 <span class="cbx"><input type="checkbox" name="itmList['+leng+'].esntlYn" id="esntlYn_'+leng+'" value="Y"/><label for="esntlYn_'+leng+'"></label></span>'
						html += '           </span>';
						html += '           </td>';
						html += '           <td>';
						html +=  autoYn;
						html += '           </td>';
						html += '           <td>';
						html += '               <a href="javascript:void(0)"  class="btn btn_sml btn_del" onclick="fncInfoDel(\'itmTr_'+leng+'\')"><span>삭제</span></a>';
						html +='			<input type="hidden" id="ip_ipSn_'+leng+'" value="" />';
						html +='			<input type="hidden" id="ip_seqo_'+leng+'" value="" />';
						html += '           </td>';
						html += '       </tr>';
						leng ++;
						leng2 ++;
						$(".no-data").remove();

					});
				}else{
					html += "<tr class='no-data'>";
					html += "	<td colspan='6'>항목을 추가하세요.</td>";
					html += "</tr>";
				}
				$("#frmContainer").append(html);
			}, error: function (){
				alert("오류가 발생했습니다. 잠시후 다시 시도해주세요.");
			}
		});
		return false;
	}
	function window_show(id, url, wth, het){
		let popupX = (window.screen.width / 2) - (200 / 2);
		let popupY= (window.screen.height / 2) - (300 / 2);
		window.open('', url.replace(".do","") , 'left='+popupX+',top='+popupY+',titlebar=no,status=no,toolbar=no,resizable=yes,scrollbars=yes,width='+wth+'px, height='+het+'px');
		$("#"+id).attr({"action" : url, "method" : "post", "target" : url.replace(".do","") , "onsubmit" : ""}).submit();
	}


	function fncItmAdd() {
		window_show('defaultFrm','popView.do', 1200, 600);
		return false;
	}
</script>
<div class="board_write">
	<form:form modelAttribute="itsmInspMngVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
		<form:hidden path="frmSn"/>
		<form:hidden path="itmSnList"/>
		<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
		<div class="tbl_top">
			<div class="tbl_left"><h4 class="md_tit">양식 정보</h4></div>
			<div class="tbl_right"><span class="essential_txt"><span>*</span>는 필수입력</span></div>
		</div>
		<div class="tbl_wrap">
			<table class="board_row_type01">
				<colgroup>
					<col style="width:10%">
					<col>
					<col style="width:10%">
					<col>
				</colgroup>
				<tbody>
				<tr>
					<th><strong class="th_tit">점검 구분</strong></th>
					<td colspan="3">
						<form:select path="inspGbn" cssClass="select" title="점검 구분" required="true">
							<form:option value="" label="선택"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<th><strong class="th_tit">양식 명</strong></th>
					<td colspan="3">
						<form:input path="frmNm" cssClass="text w100p"  maxlength="100" title="양식 명" required="true" placeholder="양식 명" />
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="tbl_top">
			<div class="tbl_left"><h4 class="md_tit">양식 항목</h4></div>
			<div class="tbl_right">
				<a href="javascript:void(0);" class="btn btn_sml btn_save" onclick="fncItmAdd();">항목 추가</a>
			</div>
		</div>
		<div class="tbl_wrap" >
			<table class="board_col_type01">
				<colgroup>
					<col style="width:5%">
					<col>
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
				</colgroup>
				<thead>
				<tr>
					<th scope="row">순서</th>
					<th scope="row">점검 항목</th>
					<th scope="row">점검결과</th>
					<th scope="row">필수 여부</th>
					<th scope="row">비고</th>
					<th scope="row">관리</th>
				</tr>
				</thead>
				<tbody id="frmContainer">
				<c:choose>
					<c:when test="${fn:length(resultList) gt 0}">
						<c:forEach var="result"  items="${resultList }" varStatus="status">
							<tr id="itmTr_${status.index}">
								<td class="numTd">
									<span><c:out value="${status.count }"/></span>
									<input type="hidden" id="itmSeqo_${status.index }" name="itmList[${status.index}].itmSeqo" value="${status.index}" />
								</td>
								<td class="l">
									<c:out  value="${result.itmCn}"/>
									<input type="hidden" id="itmCn_${status.index}" name="itmList[${status.index}].itmCn" value="${result.itmCn}"/>
									<input type="hidden" id="itmSn_${status.index}" name="itmList[${status.index}].itmSn" value="${result.itmSn}"/>
									<input type="hidden" id="frmItmSn_${status.index}" name="itmList[${status.index}].frmItmSn" value="${result.frmItmSn}"/>
								</td>
								<td>
									<span class="radios">
										정상 / 비정상
										<!-- <label><input type="radio"  class="radio" disabled/> 정상</label>
										<label><input type="radio" class="radio" disabled/> 비정상</label> -->
									</span>
								</td>
								<td>
									<span class="chk mar_l10">
										<span class="cbx"><input type="checkbox" name="itmList[${status.index}].esntlYn" id="esntlYn_${status.index}" value="Y" ${result.esntlYn eq 'Y' ? 'checked' : '' }/><label for="esntlYn_${status.index}"></label></span>
									</span>
								</td>
								<td>
									<c:out  value="${result.autoYn eq 'Y' ? '시스템 자동 점검' : '-'}"/>
								</td>
								<td>
									<a href="javascript:void(0)"  class="btn btn_sml btn_del" onclick="fncInfoDel('itmTr_${status.index }')"><span>삭제</span></a>
									<input type="hidden" id="ip_ipSn_${status.index  }" value="${result.frmItmSn }" />
									<input type="hidden" id="ip_seqo_${status.index  }" value="${status.index  }" />
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="no-data">
							<td class="no_data">항목을 추가하세요.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>

		<div class="btn_area right">
			<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY or not empty itsmInspMngVO.frmSn}">
					<a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl btn_save" id="btn_submit"><c:out value="${empty itsmInspMngVO.frmSn ? '등록' : '수정'}"/></a>
					<c:if test="${not empty itsmInspMngVO.frmSn}">
						<a href="javascript:void(0)" class="btn btn_mdl btn_del" id="btn_del">삭제</a>
					</c:if>
				<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel"><c:out value="${empty itsmInspMngVO.frmSn ? '취소' : '목록'}"/></a>
			</c:if>
		</div>
	</form:form>
</div>