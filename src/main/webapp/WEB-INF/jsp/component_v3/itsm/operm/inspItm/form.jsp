<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	$(document).ready(function(){
		let procType = "${searchVO.procType}";

		fncCodeList('FRM','select','선택','${itsmInspItmVO.itmGbn}','','itmGbn', '','ASC');

		$("#btn_submit").on("click", function(){
			if(wrestSubmit(document.defaultFrm)){	
				itsmFncProc("<c:out value='${searchVO.procType}'/>");				
			}
		});

		$("#autoYn").click(function(){
			if( $(this).is(":checked")){
				$("#autoPath").css("display", "block");
				$("#autoPath").focus();
			} else {
				$("#autoPath").css("display", "none");
			}
		});

		if(${itsmInspItmVO.autoYn eq 'Y'}) {
			$("#autoYn").trigger("click");
		}
	});
</script>
<div class="board_write">
	<form:form modelAttribute="itsmInspItmVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false">
		<form:hidden path="itmSn"/>
		<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
		<div class="tbl_top">
			<div class="tbl_left"><h4 class="md_tit">항목 정보</h4></div>
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
					<th><strong class="th_tit">구분</strong></th>
					<td colspan="3">
						<form:select path="itmGbn" cssClass="select w10p" title="구분" required="true">
						</form:select>
					</td>
				</tr>
				<tr>
					<th style="height: 51px;"><strong>자동점검설정</strong>
						<span class="chk mar_l10">
						    <span class="cbx"><input type="checkbox" id="autoYn" name="autoYn" value="Y" title="자동점검설정"><label for="autoYn"></label></span>
						</span>
					</th>
					<td colspan="3" style="height: 51px;">
						<input type="text" id="autoPath" name="autoPath" class="text w100p"  maxlength="300" style="display: none;" title="자동점검설정 Path" placeholder="path 입력" value="${itsmInspItmVO.autoPath}">
					</td>
				</tr>
				<tr>
					<th><strong class="th_tit">항목 내용</strong></th>
					<td colspan="3">
						<form:input path="itmCn" cssClass="text w100p"  maxlength="100" title="항목 내용" required="true" placeholder="항목 내용" />
					</td>
				</tr>
				</tbody>
			</table>
		</div>

		<div class="btn_area right">
			<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY or not empty itsmInspItmVO.itmSn}">
					<a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl btn_save" id="btn_submit"><c:out value="${empty itsmInspItmVO.itmSn ? '등록' : '수정'}"/></a>
					<c:if test="${not empty itsmInspItmVO.itmSn }">
						<a href="javascript:void(0)" class="btn btn_mdl btn_del" id="btn_del">삭제</a>
					</c:if>
				<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel"><c:out value="${empty itsmInspItmVO.itmSn ? '취소' : '목록'}"/></a>
			</c:if>
		</div>
	</form:form>
</div>