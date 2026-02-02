<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 정규표현식 값 세팅 --%>
const fncSetRegeps = function(obj){
	if($(obj).val()){
		$('#popRegepsInput').attr('pattern',$('#popRegepsSelect').val());
		$('#popRegepsInput').attr('placeholder',$('#popRegepsSelect').find("option:selected").attr("data-placeholdertxt"));
		$('#popRegepsTxt').html($('#popRegepsSelect').find("option:selected").attr("data-regepstxt"));
		$('#popRegepsExm').html($('#popRegepsSelect').find("option:selected").attr("data-regepsexm"));
		$('#popRegepsId').html($('#popRegepsSelect').val());
	} else {
		$('#popRegepsInput').attr('pattern','');
		$('#popRegepsInput').attr('placeholder','');
		$('#popRegepsTxt').html('');
		$('#popRegepsExm').html('');
		$('#popRegepsId').html('');
	}
}
$(document).ready(function(){
		
	<%-- 정규표현식 selectbox 클릭시 --%>
	$('#popRegepsSelect').on('change', function(){
		fncSetRegeps($(this));
	});
	
	<%-- 테스트 --%>
	$('#btn_popTest').on('click', function(){
		if(wrestSubmit(document.defaultFrm_pop)){
			$('#popRegepsInput').parent().append('<p class="blue_txt">테스트에 성공하였습니다</p>');
		}
	});
	
	<%-- 팝업 닫기 --%>
	$('.pop_close, .btn_close').on('click', function(){
		view_hide('1');
	});
});
</script>
<div class="pop_header">
    <h2>정규표현식 테스트</h2>
    <button type="button" class="pop_close"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="max-height: 300px;" data-simplebar data-simplebar-auto-hide="false">
	<form:form modelAttribute="regepsVO" name="defaultFrm_pop" id="defaultFrm_pop" method="post">
		<div class="board_top">
		    <div class="board_right">
		        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
		    </div>
		</div>
		<table class="board_write">
			<colgroup>
				<col class="w15p"/>
				<col/>
				<col class="w15p"/>
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="asterisk">*</span>정규표현식</th>
					<td>
						<select id="popRegepsSelect" class="select w20p">
                    		<option value="" label="선택"/>
                    		<c:forEach var="result" items="${resultList }">
	                    		<option value="<c:out value='${result.regepsId }'/>" label="<c:out value='${result.regepsNm }'/>" data-regepstxt="<c:out value='${result.regepsTxt }'/>" 
	                    				data-regepsexm="<c:out value='${result.regepsExm }'/>" data-placeholdertxt="<c:out value='${result.placeholderTxt }'/>"/>
                    		</c:forEach>
                    	</select>
					</td>
					<th scope="row">정규표현식ID</th>
					<td id="popRegepsId"></td>
				</tr>
				<tr>
					<th scope="row">정규표현식텍스트</th>
					<td id="popRegepsTxt" colspan="3"></td>
				</tr>
				<tr>
					<th scope="row">정규표현식예시</th>
					<td id="popRegepsExm" colspan="3"></td>
				</tr>
				<tr>
					<th scope="row"><span class="asterisk">*</span>입력칸</th>
					<td colspan="3"><input type="text" id="popRegepsInput" class="w100p" title="입력칸" required="required"/></td>
				</tr>
			</tbody>
		</table>
	</form:form>
</div>
<div class="pop_footer">
    <button type="button" id="btn_popTest" class="btn blue">테스트</button>
    <button type="button" class="btn gray btn_close">닫기</button>
</div>