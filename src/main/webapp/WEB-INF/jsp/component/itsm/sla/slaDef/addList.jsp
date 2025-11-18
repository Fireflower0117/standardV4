<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">

    $(function() {
        $(".td_class_item").each(function(){

            var id_rows = $(".td_class_item:contains('" + $(this).text() + "')");

            if (id_rows.length > 1) {
                id_rows.eq(0).attr("rowspan", id_rows.length);
                id_rows.not(":eq(0)").remove();
            }

        });

    });

    var fncUpdateItem = function(type, index) {

        if ($.trim($("#itemCn_up_" + index).val()) == "") {
            alert("항목명을 입력해 주세요.");
            return false;
        }

        if ($.trim($("#dtlIndCn_up_" + index).val()) == "") {
            alert("세부지표를 입력해 주세요.");
            return false;
        }

        if ($.trim($("#points_up_" + index).val()) == "") {
            alert("배점을 입력해 주세요.");
            return false;
        }

        $("#itemCd").val($("#itemCd_up_" + index).val());
        $("#itemCn").val($("#itemCn_up_" + index).val());
        $("#dtlIndCd").val($("#dtlIndCd_up_" + index).val());
        $("#dtlIndCn").val($("#dtlIndCn_up_" + index).val());
        $("#points").val($("#points_up_" + index).val());
        $("#indSeCd").val($("#indSeCd_up_" + index).val());
        $("#useBgnYm").val($("#useBgnYm_up_" + index).val());

        if (confirm("수정하시겠습니까?")) {
            formAction(type);
        }

    }


</script>

<!-- board -->
<!-- tbl -->
<div class="tbl_wrap">
    <table class="board_col_type01">
        <caption>목록(번호,제목,첨부,작성자,작성일,조회 로 구성)</caption>
        <colgroup>
            <col style="width:12%;">
            <col>
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
            <col style="width:10%;">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">항목</th>
            <th scope="col">세부지표</th>
            <th scope="col">배점</th>
            <th scope="col">지표구분</th>
            <th scope="col">시작년월</th>
            <th scope="col"></th>
            <th scope="col">최종수정자</th>
            <th scope="col">변경일자</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${fn:length(resultList) > 0 }">
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td class="td_class_item">${result.itemCn }</td>
                        <td>
                            <span class="code_basic">${result.dtlIndCn }</span>
                            <input type="hidden" class="text code_correct" id="itemCd_up_${status.index }" value="${result.itemCd }" readonly="readonly" />
                            <input type="hidden" class="text code_correct w120" id="itemCn_up_${status.index }" value="${result.itemCn }" />
                            <input type="hidden" class="text code_correct" id="dtlIndCd_up_${status.index }" value="${result.dtlIndCd }" readonly="readonly" />
                            <input type="text" class="text code_correct w80p" id="dtlIndCn_up_${status.index }" value="${result.dtlIndCn }" />
                        </td>
                        <td class="r">
                            <span class="code_basic">${result.points }</span>
                            <input type="text" class="text code_correct w60 r" id="points_up_${status.index }" value="${result.points }" />
                        </td>
                        <td>
                            <span class="code_basic">${result.indSeCdnm }</span>
                            <select class="code_correct" id="indSeCd_up_${status.index }">
                                <option value="1" <c:if test="${result.indSeCd == '1' }">selected="selected"</c:if> >상향지표</option>
                                <option value="2" <c:if test="${result.indSeCd == '2' }">selected="selected"</c:if> >하향지표</option>
                                <option value="3" <c:if test="${result.indSeCd == '3' }">selected="selected"</c:if> >별도지표</option>
                            </select>
                        </td>
                        <td>
                            <span class="code_basic">${result.useBgnYm }</span>
                            <span class="calendar_input code_correct w100"><input type="text" class="text w100" id="useBgnYm_up_${status.index }" value="${result.useBgnYm }" /></span>
                        </td>
                        <td>
                            <div class="code_basic">
                                <button type="button" class="btn code_rewrite"><span>수정</span></button>
                            </div>
                            <div class="code_correct">
                                <button type="button" class="btn code_save" onclick="javascript:fncUpdateItem('update', '${status.index}');">저장</button>
                                <button type="button" class="btn code_cancel">취소</button>
                            </div>
                        </td>
                        <td>${result.updateNm }</td>
                        <td>${result.updateDt }</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr class="no_data">
                    <td colspan="8">등록된 내역이 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<!-- //tbl -->
