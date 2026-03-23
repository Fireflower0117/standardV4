<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
    $(document).ready(function(){
        let itmSeqo = "";
        let msrmtRslt = 0;
        let evlScor = 0;
        let itmScrng = 0;
        let result1;
        let result2;

        let msrmtCnt;
        let msrmtTrgtCnt;


        <c:choose>
            <c:when test="${fn:length(resultList) > 0}">
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    itmSeqo = "${result.itmSeqo}";
                    itmScrng = "${result.itmScrng}";

                    <c:if test="${status.index < 4}">
                        $("#msrmtCnt_"+"${status.index}").attr({"readonly" : true, "disabled" : true})
                        $("#msrmtTrgtCnt_"+"${status.index}").attr({"readonly" : true, "disabled" : true})
                    </c:if>

                    $("#svrngSubSn_"+itmSeqo).val("${result.svrngSubSn}");
                    $("#itmCn_view_"+itmSeqo).text("${result.itmCn}");
                    $("#itmScrng_view_"+itmSeqo).text(itmScrng);
                    $("#idxiSeCd_view_"+itmSeqo).text("${result.idxiSeNm}");
                    $("#bgngYm_view_"+itmSeqo).text("${result.bgngYm}");

                    msrmtCnt = "${result.msrmtCnt}"
                    msrmtTrgtCnt = "${result.msrmtTrgtCnt}"

                    $("#msrmtCnt_"+itmSeqo).val(msrmtCnt);
                    $("#msrmtTrgtCnt_"+itmSeqo).val(msrmtTrgtCnt);

                        if(msrmtCnt != 0 && msrmtTrgtCnt != 0 && "${result.itmScrng}" && '${result.idxiSeCd ne 'DX03'}') {
                            <c:choose>
                                <%-- 상향지표 --%>
                                <c:when test="${result.idxiSeCd eq 'DX01'}">
                                    msrmtRslt = (msrmtCnt / msrmtTrgtCnt) * 100;
                                </c:when>
                                <%-- 하향지표 --%>
                                <c:when test="${result.idxiSeCd eq 'DX02'}">
                                    msrmtRslt = (msrmtTrgtCnt / msrmtCnt) * 100;
                                </c:when>
                            </c:choose>
                            evlScor = itmScrng * msrmtRslt / 100

                            $("#msrmtRslt_" + itmSeqo).val(Math.round(msrmtRslt * 10) / 10)
                            $("#evlScor_" + itmSeqo).val(Math.round(evlScor * 10) / 10)

                        }else{
                            $("#msrmtRslt_" + itmSeqo).val(100)
                            $("#evlScor_" + itmSeqo).val("${result.itmScrng}")
                        }


                </c:forEach>
            </c:when>
            <c:otherwise>
                if($("#svcSn").val() && $("#searchbgngYm").val()){
                    if(confirm("지표관리가 입력되지 않았습니다.\n지표관리 페이지로 이동하시겠습니까?")){
                        fncPageBoard('view', '/itsm/sla/slaDef/list.do', $("#svcSn").val() + "-_-" + $("searchbgngYm").val(), 'svcSn-_-searchbgngYm');
                    }
                }
            </c:otherwise>
        </c:choose>

        $("#btn_submit").on("click", function () {
            $("[id^='msrmtCnt_']").attr("disabled", false)
            $("[id^='msrmtTrgtCnt_']").attr("disabled", false)

            if(wrestSubmit(document.defaultFrm)){
                fileFormSubmit("defaultFrm", "insertProc.do", function () {fncPageBoard("submit", "insertProc.do")});
                return false;
            }
        });

        $('.numOnly').on('input', function(event) {
            this.value=this.value.replace(/[^0-9]/g,'');
        });
    })

    function fncScore(idx){
        idxiSeNm = $("#idxiSeCd_view_" + idx).text().trim()          // 측정건수
        msrmtCnt = $("#msrmtCnt_" + idx).val()          // 측정건수
        msrmtTrgtCnt = $("#msrmtTrgtCnt_" + idx).val()  // 측정대상건수
        itmScrng = $("#itmScrng_view_" + idx).text()    // 배점

        if(msrmtCnt != 0 && msrmtTrgtCnt != 0 && itmScrng != 0 && idxiSeNm != '별도지표' ){

            if(idxiSeNm == '상향지표'){
                msrmtRslt = (msrmtCnt/msrmtTrgtCnt) * 100;

            }else if(idxiSeNm == '하향지표'){
                msrmtRslt = (msrmtTrgtCnt/msrmtCnt) * 100;

            }
            evlScor = itmScrng * msrmtRslt / 100

            $("#msrmtRslt_"+idx).val(Math.round(msrmtRslt * 10)/10)
            $("#evlScor_"+idx).val(Math.round(evlScor * 10)/10)

        }else{
            $("#msrmtRslt_"+idx).val(100)
            $("#evlScor_"+idx).val(itmScrng)
        }

    }
</script>
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post">
    <form:hidden path="svcSn" id="svcSn"/>
    <form:hidden path="searchbgngYm" id="searchbgngYm"/>
    <div class="tbl_wrap">
        <table class="tbl_col_type02">
            <colgroup>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
            </colgroup>
            <thead>
            <tr>
                <th scope="col" rowspan="2">항목</th>
                <th scope="col" rowspan="2" colspan="3">세부지표</th>
                <th scope="col" rowspan="2">배점</th>
                <th scope="col" rowspan="2">지표구분</th>
                <th scope="col" colspan="2">측정</th>
                <th scope="col" colspan="2">평가결과</th>
            </tr>
            <tr>
                <th>측정건수</th>
                <th>측정대상건수</th>
                <th>측정결과</th>
                <th>평가점수</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="reuslt" begin="0" end="13" varStatus="status">
                    <tr>
                        <c:choose>
                            <c:when test="${status.index eq 0}">
                                <td rowspan="4">
                                    적시성
                                </td>
                            </c:when>
                            <c:when test="${status.index eq 4}">
                                <td rowspan="6">
                                    품질
                                </td>
                            </c:when>
                            <c:when test="${status.index eq 10}">
                                <td>
                                    인력
                                </td>
                            </c:when>
                            <c:when test="${status.index eq 11}">
                                <td>
                                    만족도
                                </td>
                            </c:when>
                            <c:when test="${status.index eq 12}">
                                <td rowspan="2">
                                    보안
                                </td>
                            </c:when>
                        </c:choose>
                        <td colspan="3">
                            <input type="hidden" name="itmList[${status.index}].svrngSubSn" id="svrngSubSn_${status.index}"/>
                            <span id="itmCn_view_${status.index}"></span>
                        </td>
                        <td>
                            <span id="itmScrng_view_${status.index}"></span>
                        </td>
                        <td>
                            <span id="idxiSeCd_view_${status.index}"></span>
                        </td>
                        <td class="c">
                            <input type="text" class="text w50p c numOnly" id="msrmtCnt_${status.index}" name="itmList[${status.index}].msrmtCnt" onkeyup="fncScore('${status.index}');">
                        </td>
                        <td class="c">
                            <input type="text" class="text w50p c numOnly" id="msrmtTrgtCnt_${status.index}" name="itmList[${status.index}].msrmtTrgtCnt" onkeyup="fncScore('${status.index}');">
                        </td>
                        <td><input type="text" class="text w50p c numOnly" readonly="true" id="msrmtRslt_${status.index}" value="0">&nbsp;%</td>
                        <td><input type="text" class="text w50p c numOnly" readonly="true" id="evlScor_${status.index}" value="0"></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</form:form>
<div class="btn_area">
    <a href="javascript:void(0)" class="btn btn_mdl btn_save" id="btn_submit">저장</a>
</div>