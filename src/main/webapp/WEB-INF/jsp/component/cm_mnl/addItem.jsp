<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div id="mnlItem_$idx$" class="mnlItem mar_t30">
	<div class="board_top">
	    <div class="board_left">
	        <h4 class="md_tit">항목<span id="itemCnt_$idx$">$itmIdx$</span></h4>
	    </div>
	    <div class="board_right">
	       	<button type="button" class="btn ic btn_addItem"><i class="xi-plus"></i></button>
	       	<button type="button" class="btn ic btn_delItem"><i class="xi-trash"></i></button>
	    </div>
	</div>
	<table id="item_$idx$" class="board_write">
		<caption>내용(항목구분, 옵션으로 구성)</caption>
		<colgroup>
			<col style="width:20%;"/>
			<col/>
			<col style="width:20%;"/>
			<col/>
		</colgroup>
		<tbody>
			<tr class="tr_type_$idx$">
				<th scope="row"><span class="asterisk">*</span>항목구분</th>
				<td colspan="3">
					<input type="hidden" id="mnlItmSerno_$idx$"/>
					<input type="hidden" id="mnlItmSeqo_$idx$"/>
					<select id="mnlItmClCd_$idx$" title="항목구분" required="required">
						<option value="">선택</option>
						<option value="title">제목</option>
						<option value="subTitle">부제목</option>
						<option value="ctt">상세내용</option>
						<option value="code">소스코드</option>
						<option value="img">이미지</option>
						<option value="url">URL주소</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</div>