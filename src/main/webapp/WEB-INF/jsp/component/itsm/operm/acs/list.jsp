<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/ma/css/board.css">--%>
<script type="text/javascript">
$(document).ready(function(){
	
	fncCodeList("AU", "select", "전체", "${searchVO.schEtc02}", "", "schEtc02", "", "ASC");
    fncDate('searchStartDate','searchEndDate');
    //fncSetToday("searchStartDate");
    //fncSetToday("searchEndDate");
    searchLog(${empty searchVO.schEtc03 ? '0' : searchVO.schEtc03});
    $(".tab_menu li").click(function(event) {
    	$(this).addClass("current");
		$(this).siblings().removeClass("current");
    });
    
  //검색 엔터 체크
    $("#acsKeyword").keydown(function(e){
    	if (e.keyCode == 13) {
    		e.preventDefault();
    		fncAddList('','','1');
    	}
    });
})

function fncAddList(a,b,pageNo){
    $("#currentPageNo").val(pageNo);
    $.ajax({
        url      : "addList.do",
        type     : "post",
        data     : $("#defaultFrm").serialize(),
        dataType : "html",
        success  : function(data){
            $("#tbl").html(data);
        }
    })
}
function searchLog(val){
    $(".hideBtn2").show();
    $(".hideBtn3").hide();
    $("#currentPageNo").val("1");
    if(val == 0){
        <%-- 전체탭 클릭시 --%>
        $("#schEtc03").val("");
        fncAddList('','','1');
        return false;
    }else {
        <%-- 전체탭 이외 클릭시 --%>
        $("#schEtc03").val(val);
        if(val == 4){
            $(".hideBtn2").hide();
            $(".hideBtn3").show();
        }
        fncAddList('','','1');
        return false;
    }

}
function fncSearchReSet() {
	fncSetToday("searchStartDate");
    fncSetToday("searchEndDate");
    fncAddList('','','1');
}

function fncExcel(clcd) {
	var depth = $("#schEtc03").val();
	
	if (clcd == "NULL") {
		alert("조회된 데이터가 없습니다.");
		return false;
	} else {
		if(depth == null || depth == ""){
			depth = 0;
		}
		$("#defaultFrm").attr({"action" : "excelDownload"+ depth + ".do", "method" : "post", "target" : "_self", "onsubmit" : ""}).submit();
		$("#defaultFrm").attr("onsubmit","return false;");
	}
}


</script>
<div class="tmenu">
	<!-- 	<ul class="tab_menu tab_menu1 js-tmenu"> -->
	<ul class="tab_menu">
       <li onclick="searchLog(0)" class="${empty searchVO.schEtc03 ? 'current' : ''}"><a href="javascript:void(0)">전체</a></li>
       <li onclick="searchLog(1)" class="${searchVO.schEtc03 eq '1' ? 'current' : ''}"><a href="javascript:void(0)">업무시간 외 접속</a></li>
       <li onclick="searchLog(2)" class="${searchVO.schEtc03 eq '2' ? 'current' : ''}"><a href="javascript:void(0)">과다 접속자관리</a></li>
       <li onclick="searchLog(3)" class="${searchVO.schEtc03 eq '3' ? 'current' : ''}"><a href="javascript:void(0)">접속 지점이상</a></li>
   </ul>
</div>
<%-- search  --%>
<div class="search_wrap">
	<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post">
		<form:hidden path="currentPageNo" id="currentPageNo" />
		<form:hidden path="recordCountPerPage" id="recordCountPerPage"/>
		<input type="hidden" id="logSerno" name="logSerno" />
		<input type="hidden" name="schEtc03" id="schEtc03" value="${searchVO.schEtc03 }"/>
		<table class="search_tbl">
			<caption>검색</caption>
			<colgroup>
				<col style="width:10%">
				<col>
				<col style="width:10%">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<th><label>기간</label></th>
				<td>
					<span class="calendar_input w120">
						<form:input path="searchStartDate" id="searchStartDate" class="selec w120" readonly="true"/>
					</span>
					<span class="gap">~</span>
					<span class="calendar_input w120">
						<form:input path="searchEndDate" id="searchEndDate" class="selec w120" readonly="true"/>
					</span>
				</td>
				<th><label>영역</label></th>
				<td>
					<form:select path="schEtc02" id="schEtc02" cssClass="typeA w200" title="영역">
					</form:select>
				</td>
			</tr>
			<tr>
				<th><label>검색</label></th>
				<td colspan="3">
					<form:select path="schEtc09" id="schEtc09" cssClass="typeA w120">
						<form:option value="" label="전체"/>
						<form:option value="1" label="ID"/>
						<form:option value="2" label="성명"/>
					</form:select>
					<form:input path="searchKeyword" id="acsKeyword" cssClass="text typeA w80p" placeholder="검색어를 입력하세요."/>
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
<%-- //search --%>
<div id="tbl">
</div>
