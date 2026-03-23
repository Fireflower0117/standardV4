<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
/* 보고서 다운로드 */
function siteReportPop(){
	
	var childWindow;
	childWindow = window.open("", "childForm", "width=1000, height=1000, resizable = no, scrollbars = no");
	var defaultFrm = document.defaultFrm;

	defaultFrm.action = "/itsm/report/rpt/weekReport.do";
	defaultFrm.method = "post";
	defaultFrm.target = "childForm";
	defaultFrm.submit();

	defaultFrm.target = "";
	
	return false;
	
}
</script>
<form:form modelAttribute="monthRptVO" name="defaultFrm" id="defaultFrm" method="post">
	<form:hidden path="rptMonthSn" id="rptMonthSn"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
<%--	<div class="tbl_top">
		<div class="tbl_left">
				&lt;%&ndash; <h4 class="md_tit"><c:out value="${thisYear}년 ${monthRptVO.monWeek }차 주간보고 (${monthRptVO.weekJobStartYmd } ~ ${monthRptVO.weekJobEndYmd })" /></h4> &ndash;%&gt;
		</div>
		<div class="tbl_right">
			<div class="btn_area">
				<a href="#" class="btn btn_sml btn_excel" id="btn_excel" onclick="siteReportPop();" >보고서다운로드</a>
			</div>
		</div>
	</div>
	<span></span>--%>
	<div class="tbl_wrap">
					<h4 class="md_tit">사업개요</h4>
				    <table class="board_row_type01">
				        <caption>내용(사업명, 계약기간, 계약번호, 업체명 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:15%;">
				            <col style="width:35%;">
				            <col style="width:15%;">
				            <col style="width:35%;">
				        </colgroup>
				        <tbody>
				        	<tr>
				                <th scope="row"><strong>사업명</strong></th>
				                <td>
				                	<c:out value="${monthRptVO.prjNm }"/>
				                </td>
				                <th scope="row"><strong>계약기간</strong></th>
								<td>
									<c:out value="${monthRptVO.cntrStartYmd } ~ ${monthRptVO.cntrEndYmd }"/>
								</td>
				            </tr>
				            <tr>
								<th scope="row"><strong>계약번호</strong></th>
				                <td>
				                	<c:out value="${monthRptVO.cntrNo }"/>
				                </td>
				                <th scope="row"><strong>업체명</strong></th>
				                <td>
				                	<c:out value="${monthRptVO.cmpnNm }"/>
				                </td>
							</tr>
				        </tbody>
				    </table>
				</div>
				<h4 class="md_tit">사업진행현황</h4>
				<div class="tbl_wrap">
					<h5 class="sm_tit mar_b10 mar_t10">진척도 관리</h5>
				    <table class="board_row_type01">
				        <caption>내용(구분, 계획, 실적 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:8%;">
				            <col style="width:17%;">
				            <col style="width:17%;">
				            <col style="width:17%;">
				            <col style="width:17%;">
				            <col style="width:17%;">
				            <col style="width:7%;">
				        </colgroup>
				        <tbody>		
				        	<tr>
				                <th scope="row" rowspan="2" class="c pad_l0"><strong>구분</strong></th>
				                <th scope="row" class="c pad_l0"><strong>분석(14%)</strong></th>
				                <th scope="row" class="c pad_l0"><strong>설계(23%)</strong></th>
				                <th scope="row" class="c pad_l0"><strong>구현(38%)</strong></th>
				                <th scope="row" class="c pad_l0"><strong>시험(10%)</strong></th>
				                <th scope="row" class="c pad_l0"><strong>시범운영(15%)</strong></th>
				                <th scope="row" rowspan="2" class="c pad_l0"><strong>계</strong></th>				                
				            </tr>		        	
				            <tr>
				            	<th class="c pad_l0 pad_r0 bdl">
				            		<c:out value="‘${monthRptVO.anlyStartYmd } ~ ‘${monthRptVO.anlyEndYmd }"/>      	
								</th>
								<th class="c pad_l0 pad_r0">	
									<c:out value="‘${monthRptVO.dsgnStartYmd } ~ ‘${monthRptVO.dsgnEndYmd }"/>    
								</th>
								<th class="c pad_l0 pad_r0">
									<c:out value="‘${monthRptVO.impStartYmd } ~ ‘${monthRptVO.impEndYmd }"/>    
								</th>
								<th class="c pad_l0 pad_r0">
									<c:out value="‘${monthRptVO.testStartYmd } ~ ‘${monthRptVO.testEndYmd }"/>  
								</th>
								<th class="c pad_l0 pad_r0">
									<c:out value="‘${monthRptVO.pilotStartYmd } ~ ‘${monthRptVO.pilotEndYmd }"/>  
								</th>
				            </tr>
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>계획</strong></th>	
				                <td class="c">
				                	<c:out value="${monthRptVO.anlyPlan }%"/>
				                </td>		   
				                <td class="c">
				                	<c:out value="${monthRptVO.dsgnPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${monthRptVO.impPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${monthRptVO.testPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${monthRptVO.pilotPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:set var="planTot" value="${monthRptVO.anlyPlan + monthRptVO.dsgnPlan + monthRptVO.impPlan + monthRptVO.testPlan + monthRptVO.pilotPlan }" />
				                	<c:out value="${planTot}%"/>
	                			</td>		   
				            </tr> 
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>실적</strong></th>	
				                <td class="c">
				                	<c:out value="${monthRptVO.anlyPrfr }%"/>
				                </td>		   
				                <td class="c">
				                	<c:out value="${monthRptVO.dsgnPrfr }%"/>
				                </td>	
				                <td class="c">
									<c:out value="${monthRptVO.impPrfr }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${monthRptVO.testPrfr }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${monthRptVO.pilotPrfr }%"/>
				                </td>	
				                <td class="c">
				                	<c:set var="prfrTot" value="${monthRptVO.anlyPrfr + monthRptVO.dsgnPrfr + monthRptVO.impPrfr + monthRptVO.testPrfr + monthRptVO.pilotPrfr }" />
				                	<c:out value="${prfrTot }%"/>
				                </td>		                
				            </tr>
				        </tbody>
				    </table>	
				</div>
				<c:if test="${empty monthRptVO.monWeek5 }">
					<div class="tbl_wrap">
						<h5 class="sm_tit mar_b10 mar_t10">인력 투입 현황</h5>
					    <table class="board_row_type01">
					        <caption>내용(담당 업무, 사업/프로젝트 관리, 기획, 디자인/퍼블리싱, 개발, 투입 총계 등으로 구성)</caption>
					        <colgroup>
								<col style="width:15%;">
							    <col style="width:20%;">
							    <col style="width:20%;">
							    <col style="width:20%;">
							    <col style="width:20%;">
					        </colgroup>
					        <tbody>
					            <tr>
					            	<th scope="row" rowspan="2" colspan="1" ><strong>담당 업무</strong>
									</th>
					            	<th class="c pad_l0 pad_r0 bdl" colspan="6">
					            		<strong>투입실적</strong>
									</th>
					            </tr>
					        	<tr>
					                <th scope="row" class="c pad_l0 bdl"><strong>${monthRptVO.monWeek1}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek2}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek3}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek4}</strong></th>
					            </tr>
					            <tr>
					                <th scope="row"><strong>사업/프로젝트 관리</strong></th>	
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj1}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj2}명"/>
					                </td>		   	
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj3}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj4}명"/>
					                </td>		   	
					            </tr> 
					            <tr>
					                <th scope="row"><strong>기획</strong></th>	
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan1}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan2}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan3}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan4}명"/>
					                </td>
					            </tr>
					            <tr>
					                <th scope="row"><strong>디자인/퍼블리싱</strong></th>	
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn1}명"/>
					                </td>
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn2}명"/>
					                </td>
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn3}명"/>
					                </td>
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn4}명"/>
					                </td>
					            </tr>
					            <tr>
					                <th scope="row"><strong>개발</strong></th>	
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev1}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev2}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev3}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev4}명"/>
					                </td>
					            </tr>
					            <tr>
					                <th scope="row"><strong>투입 총계</strong></th>	
					                <td class="c">
					                	<c:set var="empTot1" value="${monthRptVO.empPrj1 + monthRptVO.empPlan1 + monthRptVO.empDsgn1 + monthRptVO.empDev1}" />
					                	<c:out value="${empTot1}명"/>
					                </td>	   
					                <td class="c">
					                	<c:set var="empTot2" value="${monthRptVO.empPrj2 + monthRptVO.empPlan2 + monthRptVO.empDsgn2 + monthRptVO.empDev2}" />
					                	<c:out value="${empTot2}명"/>
					                </td>						                	           
					                <td class="c">
					                	<c:set var="empTot3" value="${monthRptVO.empPrj3 + monthRptVO.empPlan3 + monthRptVO.empDsgn3 + monthRptVO.empDev3}" />
					                	<c:out value="${empTot3}명"/>
					                </td>						                	           
					                <td class="c">
					                	<c:set var="empTot4" value="${monthRptVO.empPrj4 + monthRptVO.empPlan4 + monthRptVO.empDsgn4 + monthRptVO.empDev4}" />
					                	<c:out value="${empTot4}명"/>
					                </td>						                	           
					            </tr>
					        </tbody>
					    </table>	
					</div>
				</c:if>
				<c:if test="${not empty monthRptVO.monWeek5 }">
					<div class="tbl_wrap">
						<h5 class="sm_tit mar_b10 mar_t10">인력 투입 현황</h5>
					    <table class="board_row_type01">
					        <caption>내용(담당 업무, 사업/프로젝트 관리, 기획, 디자인/퍼블리싱, 개발, 투입 총계 등으로 구성)</caption>
					        <colgroup>
								<col style="width:15%;">
							    <col style="width:15%;">
							    <col style="width:15%;">
							    <col style="width:15%;">
							    <col style="width:15%;">
							    <col style="width:15%;">
					        </colgroup>
					        <tbody>
					            <tr>
					            	<th scope="row" rowspan="2" colspan="1" ><strong>담당 업무</strong>
									</td>
					            	<th class="c pad_l0 pad_r0 bdl" colspan="6">
					            		<strong>투입실적</strong>
									</td>
					            </tr>
					        	<tr>
					                <th scope="row" class="c pad_l0 bdl"><strong>${monthRptVO.monWeek1}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek2}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek3}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek4}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek5}</strong></th>
					            </tr>
					            <tr>
					                <th scope="row"><strong>사업/프로젝트 관리</strong></th>	
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj1}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj2}명"/>
					                </td>		   	
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj3}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj4}명"/>
					                </td>		   	
					                <td class="c">
					                	<c:out value="${monthRptVO.empPrj5}명"/>
					                </td>		   	
					            </tr> 
					            <tr>
					                <th scope="row"><strong>기획</strong></th>	
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan1}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan2}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan3}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan4}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empPlan5}명"/>
					                </td>
					            </tr>
					            <tr>
					                <th scope="row"><strong>디자인/퍼블리싱</strong></th>	
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn1}명"/>
					                </td>
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn2}명"/>
					                </td>
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn3}명"/>
					                </td>
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn4}명"/>
					                </td>
					               	<td class="c">
					               		<c:out value="${monthRptVO.empDsgn5}명"/>
					                </td>
					            </tr>
					            <tr>
					                <th scope="row"><strong>개발</strong></th>	
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev1}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev2}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev3}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev4}명"/>
					                </td>
					                <td class="c">
					                	<c:out value="${monthRptVO.empDev5}명"/>
					                </td>
					            </tr>
					            <tr>
					                <th scope="row"><strong>투입 총계</strong></th>	
					                <td class="c">
					                	<c:set var="empTot1" value="${monthRptVO.empPrj1 + monthRptVO.empPlan1 + monthRptVO.empDsgn1 + monthRptVO.empDev1}" />
					                	<c:out value="${empTot1}명"/>
					                </td>	   
					                <td class="c">
					                	<c:set var="empTot2" value="${monthRptVO.empPrj2 + monthRptVO.empPlan2 + monthRptVO.empDsgn2 + monthRptVO.empDev2}" />
					                	<c:out value="${empTot2}명"/>
					                </td>						                	           
					                <td class="c">
					                	<c:set var="empTot3" value="${monthRptVO.empPrj3 + monthRptVO.empPlan3 + monthRptVO.empDsgn3 + monthRptVO.empDev3}" />
					                	<c:out value="${empTot3}명"/>
					                </td>						                	           
					                <td class="c">
					                	<c:set var="empTot4" value="${monthRptVO.empPrj4 + monthRptVO.empPlan4 + monthRptVO.empDsgn4 + monthRptVO.empDev4}" />
					                	<c:out value="${empTot4}명"/>
					                </td>						                	           
					                <td class="c">
					                	<c:set var="empTot5" value="${monthRptVO.empPrj5 + monthRptVO.empPlan5 + monthRptVO.empDsgn5 + monthRptVO.empDev5}" />
					                	<c:out value="${empTot5}명"/>
					                </td>						                	           
					            </tr>
					        </tbody>
					    </table>	
					</div>
				</c:if>
				<div class="tbl_wrap">
					<h5 class="sm_tit mar_b10 mar_t10">이슈/변경/특이사항 관리</h5>
				    <table class="board_row_type01">
				        <caption>내용(구분, 이슈 및 특이사항 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:10%;">
				            <col style="width:45%;">
				            <col style="width:45%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>구분</strong></th>
				                <th scope="row" class="c pad_l0"><strong>이슈내용</strong></th>	        
				                <th scope="row" class="c pad_l0"><strong>조치계획</strong></th>	            
				            </tr>
				        </thead>
				        <tbody>				        	
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>이슈 및 특이사항</strong></th>	
				                <td>
				                	<pre><c:out value="${monthRptVO.issueCn }"></c:out></pre>
				                </td>		   
				                <td>
				                	<pre><c:out value="${monthRptVO.actnPlan }"></c:out></pre>
				                </td>						                            
				            </tr> 				            
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">금월 실적 및 익월 계획</h4>
				<div class="tbl_wrap">
				    <table class="board_row_type01">
				        <caption>내용(비고, 내용 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:10%;">
				            <col style="width:45%;">
				            <col style="width:45%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>비고</strong></th>
				                <th scope="row" class="c pad_l0">
				                	<strong class="mar_b10">금월 실적 </strong><br>
				                	<c:out value="${monthRptVO.thisMonthStartYmd} ~ ${monthRptVO.thisMonthEndYmd }"/>
								</th>	        
				                <th scope="row" class="c pad_l0">
				                	<strong class="mar_b10">차월 계획</strong><br>
				                	<c:out value="${monthRptVO.nextMonthStartYmd} ~ ${monthRptVO.nextMonthEndYmd }"/>
				                </th>	            
				            </tr>
				        </thead>
				        <tbody>				        	
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>내용</strong></th>	
				                <td class="vt">
				                	<pre><c:out value="${monthRptVO.thisPrfr }"></c:out></pre>
				                </td>		   
				                <td class="vt">
				                	<pre><c:out value="${monthRptVO.nextPlan }"></c:out></pre>
				                </td>					                            
				            </tr> 				            
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">주요 논의 및 협조사항</h4>
				<div class="tbl_top">
					<div class="tbl_left">
					<%-- <h4 class="md_tit"><c:out value="${thisYear}년 ${monthRptVO.monWeek }차 주간보고 (${monthRptVO.weekJobStartYmd } ~ ${monthRptVO.weekJobEndYmd })" /></h4> --%>
					</div>
					<div class="tbl_right">
					</div>
				</div>
				<div class="tbl_wrap">
				    <table class="board_row_type01">
				        <caption>내용(번호, 지시내용, 지시일, 처리일, 비고 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:5%;">
				            <col style="width:10%;">
				            <col style="width:30%;">
				            <col style="width:45%;">
				            <col style="width:10%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>번호</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>구분</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>항목</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>내용</strong></th>      
				                <th scope="row" class="c pad_l0"><strong>비고</strong></th>           
				            </tr>
				        </thead>
				        <tbody id="tbodyActn">	
				        <c:choose>
					        <c:when test="${fn:length(dscsList) gt 0 }">
					        	<c:forEach var="dscs" items="${dscsList }" varStatus="dscsStatus">
				        			<tr id="actnTr_${dscsStatus.count }">
				        				<input type="hidden" id="rptActnSn_${dscsStatus.count }" value="${actn.rptDscsSn }" />
				        				<th class="c pad_l0 actnCnt no_bdl">${dscsStatus.count }</th>	
				        				<td><c:out value="${dscs.dscsGbn }"></c:out></td>
				        				<td><c:out value="${dscs.dscsItem }"></c:out></td>
				        				<td><c:out value="${dscs.dscsCn }"></c:out></td>
				        				<td><c:out value="${dscs.dscsRmrk }"></c:out></td>
				        			</tr>
				        		</c:forEach>
				        	</c:when>
				        	<c:otherwise>
				        		<tr class="no_data" id="actnNodata">
				        			<td colspan="5">등록된 내역이 없습니다.</td>
				        		</tr>
				        	</c:otherwise>
				        </c:choose>			        	
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">비고</h4>
				<div class="tbl_wrap">
				    <table class="board_row_type01">
				        <caption>내용(구분, 이슈 및 특이사항 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:100%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>회의내용</strong></th>
				            </tr>
				        </thead>
				        <tbody>				        	
				            <tr>
				                <td class="no_bdl">
				                	<pre><c:out value="${monthRptVO.rptMonthRmrk }"/></pre>
				                </td>		   
				            </tr> 				            
				        </tbody>
				    </table>		
				</div>
				<div class="btn_area">
					<c:if test="${grpAuthId eq 'developer' }">
						<a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${monthRptVO.rptMonthSn }', 'rptMonthSn');">수정</a>
					    <a href="javascript:void(0)" id="btn_del" class="btn btn_mdl btn_del">삭제</a>
				    </c:if>
				    <a href="#" id="btn_list" class="btn btn_mdl btn_list">목록</a>
				</div>
    <span></span>
</form:form>
