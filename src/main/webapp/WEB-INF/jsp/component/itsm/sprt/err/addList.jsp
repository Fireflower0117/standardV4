<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
$(document).ready(function(){
    <%--전체 선택/해제 처리--%>
    $("#chkAll").on('change',function(){
        $("[id^=chkBox_]").each(function (index,item){
            if($("#chkAll").prop("checked") == true){
                $(this).prop("checked",true);
            }else{
                $(this).prop("checked",false);
            }
        });
    });

    <%--전체 선택/해제 처리--%>
    $("[id^=chkBox_]").on('change',function (){
        if($("[id^=chkBox_]").length == $("[id^=chkBox_]:checked").length){
            $("#chkAll").prop("checked",true);
        }else{
            $("#chkAll").prop("checked",false);
        }
    });
})
</script>

<div class="tbl_top">
    <div class="tbl_left">
    	<span class="i_all">전체</span> <span><strong><c:out value="${paginationInfo.totalRecordCount }"/></strong> 건</span>
    </div>
    <div class="tbl_right">
    	<a href="javascript:void(0);" class="btn btn_sml btn_save" onclick="fncOpenPop();"><span>일괄 처리</span></a>&nbsp;
    	<a href="javascript:void(0);" class="btn btn_sml btn_excel" id="btn_excel"  onclick="fncExcel('${paginationInfo.totalRecordCount }')"><span>엑셀 다운로드</span></a>&nbsp;
    	<jsp:directive.include file="/WEB-INF/jsp/component/itsm/common/inRecordPage.jsp"/>
    </div>
</div>
<div class="tbl_wrap">
	<table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:3%;">
            <col style="width:5%;">
            <col style="width:13%;">
            <col style="width:6%;">
            <col style="width:6%;">
            <col>
            <col style="width:5%;">
            <col style="width:8%;">
            <col style="width:10%;">
            <col style="width:6%;">
            <col style="width:8%;">
            <col style="width:10%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col"><input type="checkbox" id="chkAll"></th>
                <th scope="col">번호</th>
                <th scope="col">서비스 구분</th>
                <th scope="col">진행단계</th>
                <th scope="col">에러 유형</th>
                <th scope="col">에러페이지 URL</th>
                <th scope="col">에러 구분</th>
                <th scope="col">메뉴 구분</th>
                <th scope="col">발생일시</th>
                <th scope="col">소요일</th>
                <th scope="col">담당자</th>
                <th scope="col">처리일시</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
			<c:when test="${fn:length(resultList) gt 0 }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr onclick="javascript:fncPageBoard('view', 'view.do', '${result.errSn}', 'errSn');" style="cursor:pointer">
	                <td onclick="event.cancelBubble=true; ">
                        <input type="checkbox" id="${not empty result.errResDt ? 'disabled' : 'chkBox_'}${status.index} " value="${result.errSn}" ${not empty result.errResDt ? 'disabled' : ''}/>
	                <td><c:out value="${paginationInfo.totalRecordCount + 1 -((searchVO.currentPageNo - 1) * searchVO.recordCountPerPage + status.count)}"/></td>
	                <td><c:out value="${result.svcNm }"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${empty result.errResDt}">
                                <p class="c rqu stt_dv">미해결</p>
                            </c:when>
                            <c:otherwise>
                                <p class="c prc stt_dv">처리완료</p>
                            </c:otherwise>
                        </c:choose>
                    </td>
	                <td><c:out value="${result.errTpNm }"/></td>
	                <td><c:out value="${result.errPageUrlAddr }"/></td>
	                <td><c:out value="${empty result.errResDt ? '-' :  result.errGbnNm }"/></td>
	                <td><c:out value="${empty result.errResDt ? '-' :  result.menuNm }"/></td>
	                <td><c:out value="${result.errOccrDt }"/></td>
	                <td><c:out value="${empty result.errResDt ? '-' : result.reqDd }${empty result.errResDt ? '' :  '일'}"/></td>
	                <td><c:out value="${empty result.errResDt ? '-' :  result.mngrNm }"/></td>
	                <td><c:out value="${empty result.errResDt ? '-' :  result.errResDt }"/></td>
	            </tr>
            </c:forEach>
            </c:when>
            <c:otherwise>
            <tr class="no_data">
                <td colspan="12">데이터가 없습니다.</td>
            </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<div class="paging_wrap">
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard"/>
	</div>
</div>
