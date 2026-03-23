<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
    <%-- 달력  --%>
});
function fncList(){
    $("#defaultFrm").attr({
        action : "list.do",
        target : "_self"
    }).submit();
}
</script>
<div class="board_write">
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post">
    <form:hidden path="serno" id="serno"/>
    <div class="tbl_top">
        <div class="tbl_left"><h3 class="md_tit">기본정보</h3></div>
        <div class="tbl_right"></div>
    </div>
    <!-- board -->
    <div class="tbl_wrap">
        <table class="board_row_type01">
            <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
            <colgroup>
                <col style="width:20%;">
                <col style="width:30%;">
                <col style="width:20%;">
                <col style="width:30%;">
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><strong>에러유형</strong></th>
                    <td>
                        <c:out value="${maSysErrorVO.errTpNm}"/>
                    </td>
                    <th scope="row"><strong>에러설명</strong></th>
                    <td>
                        <c:out value="${maSysErrorVO.errExpl}"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><strong>메뉴명</strong></th>
                    <td>
                        <c:out value="${maSysErrorVO.menuCgNm}"/>
                    </td>
                    <th scope="row"><strong>에러페이지URL</strong></th>
                    <td>
                        <c:out value="${maSysErrorVO.errPageUrlAddr}"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><strong>에러발생IP</strong></th>
                    <td>
                        <c:out value="${maSysErrorVO.ipAddr}"/>
                    </td>
                    <th scope="row"><strong>에러발생일시</strong></th>
                    <td>
                        <c:out value="${maSysErrorVO.errOccrDt}"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><strong>에러내용</strong></th>
                    <td colspan="3">
                        <c:out value="${maSysErrorVO.svrErrInfoCtt}"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!-- //board -->
    <div class="btn_area">
        <a href="#" class="btn btn_mdl btn_cancel" id="btn_list">목록</a>
    </div>
</form:form>
</div>
