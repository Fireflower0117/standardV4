<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
		<form:hidden path="currentPageNo"/>
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<form:hidden path="ideaSn"/>
	  <table class="search_tbl">
		  <colgroup>
			  <col style="width:10%">
			  <col>
			  <col style="width:10%">
			  <col>
		</colgroup>
		  <tbody>
			 <tr>
				 <th scope="row">서비스 구분</th>
				 <td colspan="3">
					 <form:select path="schEtc00" id="schEtc00"  cssClass="select">
					 </form:select>
				 </td>


			 </tr>
		  <tr>
			  <th scope="row">처리상황</th>
			  <td>
				  <form:select path="schEtc01" id="schEtc01" cssClass="select w25p">
					  <form:option value="" label="전체"/>
					  <form:option value="1" label="접수완료"/>
					  <form:option value="2" label="처리중"/>
					  <form:option value="3" label="처리완료"/>
				  </form:select>
			  </td>
			  <th scope="row">검색</th>
			  <td >
				  <form:select path="searchCondition" id="searchCondition" cssClass="select w25p">
					  <form:option value="" label="전체"/>
					  <form:option value="1" label="제목"/>
					  <form:option value="2" label="내용"/>
				  </form:select>
				  <form:input path="searchKeyword" id="searchKeyword" cssClass="text w70p " placeholder="검색어를 입력해주세요"/>
			  </td>
		  </tr>
		  </tbody>
	  </table>
		<div class="btn_area">
			<a href="javascript:void(0);" id="btn_search" class="btn btn_search">검색</a>
			<a href="javascript:void(0);" id="btn_reset" class="btn btn_reset">초기화</a>
		</div>
	</form:form>
</div>
<div class="tbl"></div>

<script type="text/javaScript">
$(document).ready(function(){
	fncSvcList("select", "전체", "${schEtc00}", "schEtc00");
	fncAddList('${searchVO.currentPageNo}');
});


</script>