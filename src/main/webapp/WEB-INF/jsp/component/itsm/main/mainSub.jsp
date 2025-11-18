<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
    //tab
    $(document).ready(function () {
        if ($('.js_tmenu').length || $('.js_tcont').length) {
            $('.js_tcont').stop().hide();
            $('.js_tcont.on').stop().show();
            $('.js_tmenu li a').click(function () {
                let tabId = $(this).parent().attr('id');
                let selTabId = $('.js_tmenu li[id="' + tabId + '"], .js_tcont[data-tab="' + tabId + '"]');
                $(this).closest('.tab').find('.js_tmenu li, .js_tcont').not('.js_tmenu li.on').removeClass('on');
                selTabId.addClass('on').fadeIn();
                selTabId.siblings('.js_tcont').stop().hide();
                selTabId.siblings().removeClass('on');
                return false;
            });
        }
    });

</script>
<!-- lcont - 2 -->
<div class="lcont">
    <div class="item-02 tab box">
        <ul class="tab_menu js_tmenu" role="tablist">
            <li id="tab1_01" class="on" role="tab" aria-selected="true"><a href="#" onclick="fncMainTap('1');">질의응답</a></li>
            <li id="tab1_02" role="tab" aria-selected="false"><a href="#" onclick="fncMainTap('2');">문서관리</a></li>
        </ul>
        <a href="/component/itsm/svcReq/qna/list.do" class="btn_more" id="hrefTap" title="더보기">더보기</a>
        <div class="item">
            <div class="tab_cont js_tcont on" data-tab="tab1_01" role="tabpanel" aria-labelledby="tab1_01">
                <ul class="recent_list">
                    <c:choose>
                        <c:when test="${fn:length(qnaList) gt 0}">
                            <c:forEach var="result" items="${qnaList}" varStatus="status">
                                <li>
                                    <a href="javascript:void(0);" onclick="fncPageBoard('view', '/itsm/svcReq/qna/view.do', '${result.qnaSn}', 'qnaSn')">
                                        <p class="txt"><c:out value="${result.dmndTtl}"/></p>
                                        <span class="date"><c:out value="${result.regDt}"/></span>
                                    </a>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="no_data">데이터가 없습니다.</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="tab_cont js_tcont" data-tab="tab1_02" role="tabpanel" aria-labelledby="tab1_02">
                <ul class="recent_list">
                    <c:choose>
                        <c:when test="${fn:length(docList) gt 0}">
                            <c:forEach var="result" items="${docList}" varStatus="status">
                                <li>
                                    <a href="javascript:void(0);" onclick="fncPageBoard('view', '/itsm/info/doc/view.do', '${result.docSn}', 'docSn')">
                                        <p class="txt"><c:out value="${result.docNm}"/></p>
                                        <span class="date">
                                                    <img src="/component/itsm/images/sub/file_img.png" onclick="event.cancelBubble=true; fncFilePop('${result.docSn}');">&nbsp;&nbsp;
                                                    <c:out value="${result.regDt}"/>
                                                </span>
                                    </a>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="no_data">데이터가 없습니다.</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- // lcont - 2 -->

<!-- ccont -->
<div class="ccont cols">
    <!-- ccont - 1 -->
    <div class="item-03">
        <div class="top">
            <h4 class="md_tit">금주 처리현황</h4>
            <div class="date"><span><c:out value="${weekVO.month}월 ${weekVO.week}주차 : ${weekVO.weekStartDay} - ${weekVO.weekEndDay}"/></span></div>
            <a href="/component/itsm/svcReq/impFnc/list.do?searchStartDate=${weekVO.weekStartDay}&searchEndDate=${fn:substring(weekVO.weekStartDay,0,4)}.${weekVO.weekEndDay}" class="btn_more" title="더보기">더보기</a>
        </div>
        <div class="status">
            <div class="left">
                <div class="all">
                    <div class="tit">- 전체건수</div>
                    <span class="num"><em><c:out value="${weekVO.all4}"/></em>건</span>
                </div>
                <div class="rate">
                    <div class="tit">- 처리율</div>
                    <span class="num"><em>
                                <c:choose>
                                    <c:when test="${weekVO.all4 eq 0}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${weekVO.all1/weekVO.all4*100}" pattern="#,###.#"/>
                                    </c:otherwise>
                                </c:choose>
                            </em>%</span>
                    <div class="progress_bar"><span style="width: ${weekVO.all1/weekVO.all4*100}%;"></span></div>
                </div>
            </div>
            <ul class="counter">
                <li>
                    <span class="state">완료</span>
                    <div class="all"><strong><c:out value="${weekVO.all1}"/></strong>건</div>
                    <ul class="each">
                        <li><span class="tit">긴급</span><em><c:out value="${weekVO.cnt1}"/></em>건</li>
                        <li><span class="tit">일반</span><em><c:out value="${weekVO.cnt2}"/></em>건</li>
                        <li><span class="tit">중요</span><em><c:out value="${weekVO.cnt3}"/></em>건</li>
                    </ul>
                </li>
                <li class="ing">
                    <span class="state">진행중</span>
                    <div class="all"><strong><c:out value="${weekVO.all2}"/></strong>건</div>
                    <ul class="each">
                        <li><span class="tit">긴급</span><em><c:out value="${weekVO.cnt4}"/></em>건</li>
                        <li><span class="tit">일반</span><em><c:out value="${weekVO.cnt5}"/></em>건</li>
                        <li><span class="tit">중요</span><em><c:out value="${weekVO.cnt6}"/></em>건</li>
                    </ul>
                </li>
                <li>
                    <span class="state">요청</span>
                    <div class="all"><strong><c:out value="${weekVO.all3}"/></strong>건</div>
                    <ul class="each">
                        <li><span class="tit">긴급</span><em><c:out value="${weekVO.cnt7}"/></em>건</li>
                        <li><span class="tit">일반</span><em><c:out value="${weekVO.cnt8}"/></em>건</li>
                        <li><span class="tit">중요</span><em><c:out value="${weekVO.cnt9}"/></em>건</li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="rows">
        <!-- ccont - 2 -->
        <div class="item-04">
            <div class="top">
                <h4 class="md_tit">잔여 작업</h4>
                <a href="/component/itsm/svcReq/impFnc/list.do" class="btn_more" title="더보기">더보기</a>
            </div>
            <table class="tbl_work">
                <colgroup>
                    <col>
                    <col>
                    <col style="width: 50%;">
                    <col style="width: 20%;">
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">중요도</th>
                    <th scope="col">처리상태</th>
                    <th scope="col" class="l">작업내용</th>
                    <th scope="col">요청자</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${fn:length(impFncList) gt 0}">
                        <c:forEach var="result" items="${impFncList}" varStatus="status">
                            <tr onclick="javascript:fncPageBoard('view', '/itsm/svcReq/impFnc/view.do', '${result.imprvSn}', 'imprvSn');" style="cursor:pointer">
                                <td>
                                    <span class="state ${result.dmndCd eq 'RE02' ? 'c02' : result.dmndCd eq 'RE01' ? 'c01' : result.dmndCd eq 'RE03' ? 'c03' : '' }"> <c:out value="${empty result.dmndCdNm ? '-' : result.dmndCdNm }"/></span>
                                </td>
                                <td>
                                    <span class="state2 ${result.prcsCd eq 'PO01' ? 'c04' : result.prcsCd eq 'PO02' ? 'c05' : result.prcsCd eq 'PO03' ? 'c06' : '' }"> <c:out value="${empty result.prcsCdNm ? '-' : result.prcsCdNm }"/></span>
                                </td>
                                <td class="l">
                                    <p class="txt"><c:out value="${result.dmndTtl}"/></p>
                                    <span class="tag">처리요청일</span>
                                    <span class="date"><c:out value="${not empty result.dmndDt ? result.dmndDt : '없음'}"/></span>
                                </td>
                                <td><c:out value="${empty result.rqstrNm ? '-' : result.rqstrNm }"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <td colspan="4" class="no_data">데이터가 없습니다.</td>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <!-- ccont - 3 -->
        <div class="item-05">
            <div class="top">
                <h4 class="md_tit">당월 누적현황</h4>
                <%--<a href="" class="btn_more" title="더보기">더보기</a>--%>
            </div>
            <div id="chartItem05"></div>
            <script>
                Highcharts.chart('chartItem05', {
                    chart: {
                        type: 'column',
                        style: {
                            fontFamily: 'Pretendard',
                        }
                    },
                    navigation: false,
                    credits: {
                        enabled: false
                    },
                    title: false,
                    xAxis: {
                        categories: ['요청', '진행중', '완료'],
                        crosshair: true,
                        labels: {
                            y: 26,
                            style: {
                                fontSize: '13px',
                                fontWeight: 600,
                                color: '#414761'
                            }
                        },
                        lineColor: '#dedede'
                    },
                    yAxis: {
                        title: false,
                        labels: {
                            enabled: false
                        },
                        gridLineColor: '#f5f5f9'
                    },
                    legend: {
                        align: 'right',
                        verticalAlign: 'top',
                        itemStyle: {
                            fontSize: '12px',
                            color: '#414761'
                        },
                        symbolWidth: 8,
                        symbolHeight: 8,
                        symbolRadius: 2
                    },
                    tooltip: {
                        shared: true,
                    },
                    plotOptions: {
                        column: {
                            borderRadius: '3',
                            dataLabels: {
                                enabled: true,
                                y: 22,
                                style: {
                                    fontSize: '12px',
                                    fontWeight: '600',
                                    color: '#fff',
                                    textOutline: false
                                }
                            },
                            groupPadding: 0.1
                        }
                    },
                    series: [
                        {
                            name: '긴급',
                            data: [${chartVO.cnt7}, ${chartVO.cnt4}, ${chartVO.cnt1}],
                            color: '#ff4d78'
                        },
                        {
                            name: '일반',
                            data: [${chartVO.cnt8}, ${chartVO.cnt5}, ${chartVO.cnt2}],
                            color: '#3c4673'
                        },
                        {
                            name: '중요',
                            data: [${chartVO.cnt9}, ${chartVO.cnt6}, ${chartVO.cnt3}],
                            color: '#3fc376'
                        }
                    ]
                });
            </script>
        </div>
    </div>
</div>
<!-- // ccont -->

<!-- rcont -->
<div class="rcont cols">
    <!-- rcont - 1 -->
    <div class="item-06">
        <div class="top">
            <h4 class="md_tit">장애이력</h4>
            <a href="/component/itsm/sprt/err/list.do" class="btn_more" title="더보기">더보기</a>
        </div>
        <ul class="recent_list">
            <c:choose>
                <c:when test="${fn:length(errList) gt 0}">
                    <c:forEach var="result" items="${errList}" varStatus="status">
                        <li>
                            <a href="javascript:void(0);" onclick="fncPageBoard('view', '/itsm/sprt/err/view.do', '${result.errSn}', 'errSn')">
                                <c:choose>
                                    <%-- 처리중일 경우 class에 ing 추가--%>
                                    <c:when test="${empty result.errResDt}">
                                        <span class="state">미해결</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="state end">처리완료</span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="err"><c:out value="${result.errTpNm }"/></span>
                                <p class="txt"><c:out value="${result.errPageUrlAddr }"/></p>
                                <span class="date"><c:out value="${result.errOccrDt }"/></span>
                            </a>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li class="no_data">데이터가 없습니다.</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
    <!-- rcont - 2 -->
    <div class="item-07">
        <div class="top">
            <h4 class="md_tit">점검이력</h4>
            <a href="/component/itsm/sprt/insp/list.do" class="btn_more" title="더보기">더보기</a>
        </div>
        <ul class="recent_list">
            <c:choose>
                <c:when test="${fn:length(inspList) gt 0}">
                    <c:forEach var="result" items="${inspList}" varStatus="status">
                        <li>
                            <a href="javascript:void(0);" onclick="fncPageBoard('view', '/itsm/sprt/insp/view.do', '${result.inspSn}', 'inspSn')">
                                <span class="state ${result.rslt eq 'Y' ? '' : 'type02'}"><c:out value="${result.rslt eq 'Y' ? '정상' : '비정상' }"/></span>
                                <p class="txt"><c:out value="${result.frmNm }"/></p>
                                <span class="name"><c:out value="${result.rgtrNm }"/></span>
                                <span class="date"><c:out value="${result.inspBegnDt }"/></span>
                            </a>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li class="no_data">데이터가 없습니다.</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
    <!-- rcont - 3 -->
    <div class="item-08">
        <div class="top">
            <h4 class="md_tit">서비스 변경 이력</h4>
            <a href="/component/itsm/sprt/sysSts/list.do" class="btn_more" title="더보기">더보기</a>
        </div>
        <ul class="recent_list">
            <c:choose>
                <c:when test="${fn:length(sysStsList) gt 0}">
                    <c:forEach var="result" items="${sysStsList}" varStatus="status">
                        <li>
                            <a href="javascript:void(0);" onclick="fncPageBoard('view', '/itsm/sprt/sysSts/view.do', '${result.chgSn}', 'chgSn')">
                                <p class="txt"><c:out value="${result.chgTtl}"/></p>
                                <span class="date"><c:out value="${result.regDt}"/></span>
                            </a>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li class="no_data">데이터가 없습니다.</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
<!-- // rcont -->