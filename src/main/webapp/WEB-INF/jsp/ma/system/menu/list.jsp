<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/ckeditor/ckeditor.js?ver=1"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/html2canvas/html2canvas.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  let resultList = on.xhr.ajax({sid:"menuList", sql : "on.standard.system.menu.selectMenuList" , menuDivCd : "MA" });
  debugger;
});
</script>
<div class="tbl">
    <div class="menu_area">
        <div class="menu_list scr_box w38p" data-simplebar data-simplebar-auto-hide="false">
            <div class="board_top">
                <div class="board_left">
                    <i class="name"></i>메뉴명
                    <span class="btn_allclose btn_open">전체열기</span>
                    <span class="btn_allclose btn_close">전체닫기</span>
                </div>
                <div class="board_right">
                    <button class="btn btn_excel" id="btn_excel">엑셀 다운로드</button>
                    <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
                        <button id="btn_depth0" class="btn blue"><i class="xi-plus"></i></button>
                    </c:if>
                </div>
            </div>
            <ul class="depth1">

                <c:if test="${fn:length(resultList) > 0 }">
                    <c:forEach var="menu" items="${resultList}">


                        <c:if test="${menu.menuLvl eq 0}">
                            <li>
                                <table class="tbl_menulist">
                                    <caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
                                    <colgroup>
                                        <col class="w65p">
                                        <col class="w35p">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <td class="onclick_td dep1 id <c:out value="${menu.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
                                                <i></i> <label><c:out value="${menu.menuNm }" /></label>
                                            </td>
                                            <td class="r <c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
                                                data-menucl="<c:out value='${menu.menuCl}'/>"
                                                data-uprmenucd="<c:out value='${menu.uprMenuCd}'/>"
                                                data-menucd="<c:out value='${menu.menuCd}'/>"
                                                data-menulvl="<c:out value='${menu.menuLvl}'/>"
                                                data-lwrtabyn="<c:out value='${menu.lwrTabYn}'/>"
                                                data-menuseqo="<c:out value='${menu.menuSeqo}'/>"
                                                data-url="/<c:out value="${menu.menuCd}"/>/">
                                                <a href="javascript:void(0)" class="cell-ctrl-bt-add"></a>
                                                <a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a>
                                                <a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a>
                                                <a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table> <c:if test="${menu.isLeaf eq 1}">
                                    <ul class="depth2">
                                        <c:forEach var="menu2" items="${resultList}">
                                            <c:if test="${menu2.uprMenuCd eq menu.menuCd}">
                                                <li>
                                                    <table class="tbl_menulist">
                                                        <caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
                                                        <colgroup>
                                                            <col class="w65p">
                                                            <col class="w35p">
                                                        </colgroup>
                                                        <tbody>
                                                            <tr>
                                                                <td class="onclick_td id <c:out value="${menu2.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu2.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
                                                                    <i></i><label><c:out value="${menu2.menuNm }" /></label>
                                                                </td>
                                                                <td class="r <c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
                                                                    data-menucl="<c:out value='${menu2.menuCl}'/>"
                                                                    data-uprmenucd="<c:out value='${menu2.uprMenuCd}'/>"
                                                                    data-menucd="<c:out value='${menu2.menuCd}'/>"
                                                                    data-menulvl="<c:out value='${menu2.menuLvl}'/>"
                                                                    data-lwrtabyn="<c:out value='${menu2.lwrTabYn}'/>"
                                                                    data-menuseqo="<c:out value='${menu2.menuSeqo}'/>"
                                                                    data-url="/<c:out value='${menu.menuCd}'/>/<c:out value="${menu2.menuCd}"/>/">
                                                                    <a href="javascript:void(0)" class="cell-ctrl-bt-add"></a>
                                                                    <a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a>
                                                                    <a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a>
                                                                    <a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table> <c:if test="${menu2.isLeaf eq 1}">
                                                        <ul class="depth3">
                                                            <c:forEach var="menu3" items="${resultList}">
                                                                <c:if test="${menu3.uprMenuCd eq menu2.menuCd}">
                                                                    <li>
                                                                        <table class="tbl_menulist">
                                                                            <caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
                                                                            <colgroup>
                                                                                <col class="w65p">
                                                                                <col class="w35p">
                                                                            </colgroup>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td class="onclick_td id <c:out value="${menu3.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu3.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
                                                                                        <i></i> <label><c:out value="${menu3.menuNm }" /></label>
                                                                                    </td>
                                                                                    <td class="r <c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
                                                                                        data-menucl="<c:out value='${menu3.menuCl}'/>"
                                                                                        data-uprmenucd="<c:out value='${menu3.uprMenuCd}'/>"
                                                                                        data-menucd="<c:out value='${menu3.menuCd}'/>"
                                                                                        data-menulvl="<c:out value='${menu3.menuLvl}'/>"
                                                                                        data-lwrtabyn="<c:out value='${menu3.lwrTabYn}'/>"
                                                                                        data-menuseqo="<c:out value='${menu3.menuSeqo}'/>"
                                                                                        data-url="/<c:out value='${menu.menuCd}'/>/<c:out value='${menu2.menuCd}'/>/<c:out value='${menu3.menuCd}'/>/">
                                                                                        <a href="javascript:void(0)" class="cell-ctrl-bt-add"></a>
                                                                                        <a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a>
                                                                                        <a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a>
                                                                                        <a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table> <c:if test="${menu3.isLeaf eq 1}">
                                                                            <ul class="depth4">
                                                                                <c:forEach var="menu4" items="${resultList}">
                                                                                    <c:if test="${menu4.uprMenuCd eq menu3.menuCd}">
                                                                                        <li>
                                                                                            <table class="tbl_menulist">
                                                                                                <caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
                                                                                                <colgroup>
                                                                                                    <col class="w65p">
                                                                                                    <col class="w35p">
                                                                                                </colgroup>
                                                                                                <tbody>
                                                                                                    <tr>
                                                                                                        <td class="onclick_td id <c:out value="${menu4.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu4.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
                                                                                                            <i></i> <label><c:out value="${menu4.menuNm }" /></label>
                                                                                                        </td>
                                                                                                        <td class="r <c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
                                                                                                            data-menucl="<c:out value='${menu4.menuCl}'/>"
                                                                                                            data-uprmenucd="<c:out value='${menu4.uprMenuCd}'/>"
                                                                                                            data-menucd="<c:out value='${menu4.menuCd}'/>"
                                                                                                            data-menulvl="<c:out value='${menu4.menuLvl}'/>"
                                                                                                            data-lwrtabyn="<c:out value='${menu4.lwrTabYn}'/>"
                                                                                                            data-menuseqo="<c:out value='${menu4.menuSeqo}'/>"
                                                                                                            data-url="/<c:out value="${menu.menuCd}"/>/<c:out value="${menu2.menuCd}"/>/<c:out value="${menu3.menuCd}"/>/<c:out value='${menu4.menuCd}'/>/">
                                                                                                            <a href="javascript:void(0)" class="cell-ctrl-bt-add"></a>
                                                                                                            <a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a>
                                                                                                            <a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a>
                                                                                                            <a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </tbody>
                                                                                            </table> <c:if test="${menu4.isLeaf eq 1}">
                                                                                                <ul class="depth5">
                                                                                                    <c:forEach var="menu5" items="${resultList}">
                                                                                                        <c:if test="${menu5.uprMenuCd eq menu4.menuCd}">
                                                                                                            <li>
                                                                                                                <table class="tbl_menulist">
                                                                                                                    <caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
                                                                                                                    <colgroup>
                                                                                                                        <col class="w65p">
                                                                                                                        <col class="w35p">
                                                                                                                    </colgroup>
                                                                                                                    <tbody>
                                                                                                                        <tr class="cursor">
                                                                                                                            <td class="onclick_td id" data-menucd="<c:out value='${menu5.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
                                                                                                                                <i></i> <label><c:out value="${menu5.menuNm }" /></label>
                                                                                                                            </td>
                                                                                                                            <td class="r <c:out value="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
                                                                                                                                data-uprmenucd="<c:out value='${menu5.uprMenuCd}'/>"
                                                                                                                                data-menucd="<c:out value='${menu5.menuCd}'/>"
                                                                                                                                data-menuseqo="<c:out value='${menu5.menuSeqo}'/>"
                                                                                                                                data-menulvl="<c:out value='${menu5.menuLvl}'/>">
                                                                                                                                <a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a>
                                                                                                                                <a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a>
                                                                                                                                <a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </tbody>
                                                                                                                </table>
                                                                                                            </li>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                </ul>
                                                                                            </c:if>
                                                                                        </li>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </ul>
                                                                        </c:if>
                                                                    </li>
                                                                </c:if>
                                                            </c:forEach>
                                                        </ul>
                                                    </c:if>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </li>
                        </c:if>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
        <div id="addForm" class="menu_form w60p disinb"></div>
        <div id="addContTmpl" class="w60p display_none">
        </div>
    </div>

</div>

