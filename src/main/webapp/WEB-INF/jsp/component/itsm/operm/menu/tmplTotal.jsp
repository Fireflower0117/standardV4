<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 통합 템플릿타입 selectBox 조회--%>
	fncCodeList("TMCL01", "select", "템플릿 타입", "", "", "schEtc01");
	
	<%-- 통합 템플릿 목록조회 --%>
	fncPageBoard("popAddList", "popAddList", 1);
	
	
	
	<%-- 엔터시 검색 --%>
	$("#searchKeyword").keypress(function(){
		if (window.event.keyCode == 13) {
			fncPageBoard("popAddList", "popAddList", 1);
		}
	});
	
	<%-- 검색 구분 변경시 조회--%>
	$("#schEtc01"). not("#schPopCondition").change(function(){
		fncPageBoard("popAddList", "popAddList", 1);
	});

	<%-- 내용 검색 --%>
	$('#btn_search_pop').click(function () {
		fncPageBoard("popAddList", "popAddList", 1);
	});

	<%-- 팝업 닫기 --%>
	$('.btn_pop_close').click(function () {
		$('.js_popup').html("");
		view_hide('1');
	    $("#js_popup_bg").hide();
	});
	
	<%-- 검색 초기화 --%>
	$("#btn_reset_pop").on("click", function(){
		for(var i = 0 ; i < document.defaultFrmPop.elements.length ; i++){
			var el = document.defaultFrmPop.elements[i];
			if($('#'+el.id).attr('type') == "hidden"){
				continue;
			}
			// 체크박스 초기화
			if($('#'+el.id).attr('type') == "checkbox"){
				$('#'+el.id).prop("checked", "");
				continue;
			}
			el.value = "";
		}
	});
});
</script>
<div class="pop_header">
    <h2>통합 템플릿</h2>
     <button type="button" class="btn_pop_close pop_close"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content ht800" style="max-height: 800px">
    <div class="search_box">
    	<form:form modelAttribute="searchVO" name="defaultFrmPop" id="defaultFrmPop"  method="post" onsubmit="return false;">
    		<form:hidden path="currentPageNo"/>
			<form:hidden path="recordCountPerPage"/>
    		<form:hidden path="popDivn"/>
	        <div class="search_basic">
	        	<table>
					<colgroup>
						<col class="w10p">
						<col class="w20p">
						<col class="w20p">
						<col>
					</colgroup>
					<tbody>
						<tr>    
	             			<td><label>검색구분</label></td>
			              	<td>
				                <select id="schEtc01" name="schEtc01" class="w150" >
								</select>
							</td>
							<td>
				                <select id="searchCondition" name="searchCondition">
				                    <option value="">전체</option>
				                    <option value="1">템플릿 설명</option>
				                    <option value="2">에디터 내용</option>
				                </select>
				            </td>
				            <td>
				                <input type="text" id="searchKeyword" name="searchKeyword" class="text">
			                </td>
	                	</tr>
	                </tbody>
	            </table>
	           	<button type="button" class="btn btn_reset" id="btn_reset_pop"><i class="xi-refresh"></i>초기화</button>
    			<button type="button" class="btn btn_search" id="btn_search_pop"><i class="xi-search"></i>검색</button>
	    	</div>
    	</form:form>
    </div>
    <div class="popTbl"></div>
</div>