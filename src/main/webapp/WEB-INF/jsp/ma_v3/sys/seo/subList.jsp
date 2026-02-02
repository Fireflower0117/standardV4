<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
 <div class="pop_header">
      <h2>최적화 필요 태그</h2>
      <button type="button" class="pop_close" onclick="view_hide(1);"><i class="xi-close-thin"></i>닫기</button>
  </div>
  <div class="pop_content" style="max-height: 730px">
  	<form:form modelAttribute="searchVO" id="defaultFrmPop" name="defaultFrmPop" method="post" onsubmit="return false;">
		<form:hidden path="optType" />
		<form:hidden path="seoSerno" />
		<form:hidden path="currentPageNo" />
		<form:hidden path="recordCountPerPage" />
		<div class="search_basic">
			<table>
				<caption>구분</caption>
				<colgroup>
						<col style="width:10%">
						<col>
						<col style="width:10%">
						<col>
				</colgroup>
				<tbody>
					<tr>
						<td><label>검색</label></td>
						<td colspan="3">
							<form:select path="schEtc01" title="구분선택" cssClass="w150">
								<form:option value="" label="전체"/>
								<form:option value="1" label="태그"/>
								<form:option value="2" label="미흡사항"/> 
							</form:select>
							<form:input path="schEtc02" placeholder="검색" maxlength="100" required="true" />
						</td>
					</tr>
				</tbody>
			</table>
	        <a href="javascript:void(0);" id="btn_sub_srch" class="btn btn_search"><i class="xi-search"></i>검색</a>
		</div>
	</form:form>	
	<div class="popTbl"></div>
  </div>
  <div class="pop_footer">
      <button type="button" class="btn" onclick="view_hide(1);">닫기</button>
  </div>
<script>
$(function(){
	customPageBoard('','','<c:out value="${searchVO.currentPageNo}"/>');
	
	$(document).on("click","#btn_sub_srch",function(){
		customPageBoard('','','1');
	});
	
	$(document).on("keydown","#schEtc02",function(e){
		if (e.keyCode === 13) {
			e.preventDefault();
			customPageBoard('','','1');
		}	
	});
	
});

</script> 