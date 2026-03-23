<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 데이터 유무 확인 --%>
var ansCnt = 0;
<c:forEach items="${qstStat.sctnList }" var="section">
	<c:forEach items="${section.qstList }" var="qst">
		ansCnt += Number('<c:out value="${qst.srvyAnsCnt}"/>');
	 </c:forEach>
</c:forEach>

<%-- 답변 보기 --%>
const fncAnsView = function (srvyQstSerno,srvyAnsCgVal) {
    window.open("", "ViewPop", "width=1600, height=800, top=100, left=100");
    $("#srvyQstSerno").val(srvyQstSerno);
    $("#srvyAnsCgVal").val(srvyAnsCgVal);
    $("#defaultFrm").attr({"action": "resultPopDetailList.do", "method": "post", "target": "ViewPop", "onsubmit" : ""}).submit();
    return false;
};

$(document).ready(function(){
	<%-- 답변 보기 --%>
    $(".btn_ans_view").on("click", function () {
    	fncAnsView($(this).parent().data("srvyqstserno"),$(this).parent().data("srvyanscgval"));
    });
});
</script>
    <form:form modelAttribute="cmSrvyVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false">
        <form:hidden path="srvySerno"/>
        <form:hidden path="srvyQstSerno"/>
        <form:hidden path="srvyAnsCgVal"/>
        <div class="board_top mar_t30">
            <div class="board_left">
            	<h3>설문 결과보기</h3>
            </div>
        </div>
            <table class="board_write">
                <colgroup>
                    <col class="w10p">
                    <col>
                </colgroup>
                <tbody>
	                <tr>
	                    <th scope="row">설문명</th>
	                    <td><c:out value="${cmSrvyVO.srvyNm }"/></td>
	                </tr>
	                <tr>
	                    <th scope="row">설문개요</th>
	                    <td><c:out value="${cmSrvyVO.srvyExpl }"/></td>
	                </tr>
	                <tr>
	                    <th scope="row">설문기간</th>
	                    <td><c:out value="${cmSrvyVO.srvyStrtDt }"/> ~ <c:out value="${cmSrvyVO.srvyEndDt }"/></td>
	                </tr>
                </tbody>
            </table>
        <div id="section_wrap">
        	<c:choose>
		        <c:when test="${fn:length(qstStat.sctnList) > 0}">
		            <c:forEach items="${qstStat.sctnList }" var="section" varStatus="secStatus">
		                <div class="board_top mar_t30">
		                	<div class="board_left">
		                        <h4>
		                            <span class="secTot"><c:out value="${fn:length(qstStat.sctnList)}"/></span> 중 <span class="secNo"><c:out value="${secStatus.count}"/></span> 섹션
		                        </h4>
		                    </div>
		                </div>
		                    <table class="board_write">
		                        <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
		                        <colgroup>
		                            <col class="w10p">
		                            <col>
		                        </colgroup>
		                        <tbody>
		                        <tr>
		                            <th scope="row">섹션제목</th>
		                            <td><c:out value="${section.srvySctnTitl }"/></td>
		                        </tr>
		                        <tr>
		                            <th scope="row">섹션내용</th>
		                            <td><c:out value="${section.srvySctnCtt }"/></td>
		                        </tr>
		                        </tbody>
		                    </table>
		                <c:forEach items="${section.qstList }" var="qst" varStatus="qstStatus">
		                    <c:if test="${section.srvySctnSerno eq qst.srvySctnSerno}">
		                            <table class="board_write">
		                                <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
		                                <colgroup>
		                                    <col class="w10p">
		                                    <col>
		                                    <col class="w10p">
		                                    <col>
		                                </colgroup>
		                                <tbody>
			                                <tr>
			                                    <th scope="row">항목제목</th>
			                                    <td colspan="3"><c:out value="${qst.srvyQstTitl}"/></td>
			                                </tr>
			                                <tr>
			                                    <th scope="row">항목설명</th>
			                                    <td colspan="3"><c:out value="${qst.srvyQstCtt}"/></td>
			                                </tr>
			                                <tr>
			                                    <th scope="row">유형</th>
			                                    <td><c:out value="${qst.srvyAnsCgValNm}"/></td>
			                                    <th scope="row">필수여부</th>
			                                    <td><c:out value="${qst.srvyNcsrYn eq 'Y' ? '필수선택' : '-'}"/></td>
			                                </tr>
			                                <tr>
			                                    <th scope="row">결과</th>
			                                    <td colspan="3" data-srvyqstserno="<c:out value='${qst.srvyQstSerno}'/>" data-srvyanscgval="<c:out value='${qst.srvyAnsCgVal}'/>">  
			                                        <c:choose>  
			                                            <c:when test="${qst.srvyAnsCgVal eq '1' || qst.srvyAnsCgVal eq '2'|| qst.srvyAnsCgVal eq '5'}">
			                                                응답자수 : <c:out value="${qst.srvyAnsCnt}"/>(명)
			                                                <c:if test="${not empty qst.srvyAnsCnt and qst.srvyAnsCnt ne 0}">
			                                              	  	<button type="button" class="btn sml mar_l10 btn_ans_view">답변보기</button>
			                                                </c:if>
			                                            </c:when>
			                                            <c:when test="${qst.srvyAnsCgVal eq '3' || qst.srvyAnsCgVal eq '4'|| qst.srvyAnsCgVal eq '6'|| qst.srvyAnsCgVal eq '7' || qst.srvyAnsCgVal eq '8' || qst.srvyAnsCgVal eq '9'}">
			                                                <div id="chart_${qst.srvyQstSerno}" class="survey-content-body"></div>
			                                                <c:if test="${not empty qst.srvyAnsCnt and qst.srvyAnsCnt ne 0}">
						                                    	<button type="button" class="btn sml mar_l10 btn_ans_view">전체 답변보기</button>
						                                    </c:if>
			                                            </c:when>
			                                        </c:choose>
			                                    </td>
			                                </tr>
		                                </tbody>
		                            </table>
		                    </c:if>
		                </c:forEach>
		            </c:forEach>
	            </c:when>
	            <c:otherwise>	
	            	<div>데이터가 없습니다.</div>
	            </c:otherwise>
            </c:choose>
        </div>
    </form:form>
    <div class="btn_area right">
            <button type="button" id="btn_list" class="btn btn_list">목록</button>
        </div>

<script src="${pageContext.request.contextPath}/component/cm_srvy/js/smooth-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/component/cm_srvy/js/highcharts/highcharts.src.js"></script>
<script src="${pageContext.request.contextPath}/component/cm_srvy/js/highcharts/modules/series-label.js"></script>
<script>
    Scrollbar.initAll({
        alwaysShowTracks: true,
    });
    <c:forEach var="sec" items="${qstStat.sctnList}" varStatus="statusSec">
	    <c:forEach var="qstScript" items="${sec.qstList}" varStatus="qstScriptStatus">
		    <c:if test="${qstScript.srvyAnsCgVal eq '3' ||qstScript.srvyAnsCgVal eq '4'||qstScript.srvyAnsCgVal eq '6' || qstScript.srvyAnsCgVal eq '8'|| qstScript.srvyAnsCgVal eq '9' }">
		    Highcharts.chart('chart_${qstScript.srvyQstSerno}', {
		        chart: {
		            type: 'column'
		        },credits: {
		            enabled: false
		        },
		        title: {
		            text: ''
		        },
		        xAxis: {
		            categories: [
		            	<c:if test="${qstScript.srvyAnsCgVal eq '3' ||qstScript.srvyAnsCgVal eq '4'|| qstScript.srvyAnsCgVal eq '6' || qstScript.srvyAnsCgVal eq '9' }">
			                <c:choose>
				        		<c:when test="${qstScript.srvyAnsCgVal eq '6'}">
				        			<c:forEach var="itm" items="${qstScript.qstItmList}" varStatus="itmStat">
					               		'<c:out value="${itmStat.count}"/>'<c:if test="${!itmStat.end}">, </c:if>
					            	</c:forEach>
				        		</c:when>
				        		<c:when test="${qstScript.srvyAnsCgVal eq '8'}">
				        			<c:forEach var="itm" items="${qstScript.qstItmList}" varStatus="itmStat">
			                    		'<c:out value="${itm.srvyItmTpVal1} ${itm.srvyItmTpVal2}"/>'<c:if test="${!itmStat.end}">,</c:if>
			               		 	</c:forEach>	
			        			</c:when>
				        		<c:otherwise>
					                <c:forEach var="itm" items="${qstScript.qstItmList}" varStatus="itmStat">
					                	'<c:out value="${itm.srvyQstItmCtt}"/>'<c:if test="${!itmStat.end}">, </c:if>
					                </c:forEach>
				                </c:otherwise>
				            </c:choose>
			            </c:if>
		            ],
		            crosshair: true
		        },
		        yAxis: {
		            min: 0,
		            title: {
		                text: '응답자수 (명)'
		            }
		        },
		        tooltip: {
		            headerFormat: '<div style="font-size:10px;text-align:center;">{point.key}</div><table style="min-width:60px;">',
		            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		                			'<td style="padding:0"><b>{point.y} 명</b></td></tr>',
		            footerFormat: '</table>',
		            shared: true,
		            useHTML: true
		        },
		        plotOptions: {
		            column: {
		                pointPadding: 0.2,
		                borderWidth: 0
		            }
		        },
		        series: [{
		            name: '응답',
		            data: [
		                <c:forEach var="itm" items="${qstScript.qstItmList}">
			                <c:forEach var="rply" items="${itm.rplyList}" varStatus="RplyStat">
			                	<c:out value="${rply.srvyAnsCnt}"/><c:if test="${!RplyStat.end}">, </c:if>
			                </c:forEach>
		                </c:forEach>
		            ]
		        }]
		    });
		    </c:if>
	    </c:forEach>
    </c:forEach>
</script>