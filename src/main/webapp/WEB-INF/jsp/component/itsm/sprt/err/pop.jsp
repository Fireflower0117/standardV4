<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
	var snList = [];
	$(document).ready(function(){
		fncManagerList("select", "선택", "${userSn}", "mngrSn");
		fncMenuList("", "select", "선택", "", "", "menuCd", "", "ASC");
		fncCodeList("ERGB", "select", "선택", "","", "errGbn", "", "ASC");

		$("#pop_submit").click(function(){
			snList = [];
			$("[id^=chkBox_]:checked").each(function(index, item){
				snList.push($(this).val())
			});
			$("#snList").val(snList);
			if(wrestSubmit(document.popFrm)){
				$("#popFrm").attr({"action" : "popSubmitProc.do", "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
				return false;
			}
		});
	});

</script>
<div class="pop_header">
	<h2>일괄 처리</h2>
	<button type="button" class="pop_close" onclick="modal_hide_all();"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="padding: 30px;">
<form:form modelAttribute="searchVO" id="popFrm" name="popFrm" method="post" onsubmit="return false;">
	<input type="hidden" id="snList" name="snList">
	<div class="search_area">
	<div class="tbl_wrap">
		<table class="search_tbl">

			<caption>내용(첨부파일 목록)</caption>
			<colgroup>
				<col style="width: 20%;">
				<col>
				<col style="width: 20%;">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<th><strong class="th_tit">담당자</strong></th>
				<td colspan="3">
					<select id="mngrSn" name="mngrSn" class="select w30p"  title="담당자" required="true" >
					</select>
				</td>
			</tr>
			<tr>
				<th><strong class="th_tit">메뉴 구분</strong></th>
				<td>
					<select id="menuCd" name="menuCd" class="select w100p"  title="메뉴명" required="true" >
					</select>
				</td>
				<th><strong class="th_tit">에러 구분</strong></th>
				<td>
					<select id="errGbn" name="errGbn" class="select w100p"  title="에러 구분" required="true" >
					</select>
				</td>
			</tr>
			<tr>
				<th>처리 내용</th>
				<td colspan="3">
					<textarea name="errResCn" id="errResCn" class="text_area_mdl" title="처리 내용"  style="resize:none;" maxlength="900"/>
				</td>
			</tr>
			</tbody>
		</table>
	</div>
	</div>
	<div class="btn_area">
		<a href="javascript:void(0)" id="pop_submit" class="btn btn_mdl btn_rewrite">등록</a>
	</div>
</form:form>
</div>
