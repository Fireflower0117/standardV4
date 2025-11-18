<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<form:form modelAttribute="rptVO" name="defaultFrm" id="defaultFrm" method="post">
	<form:hidden path="rptSn" id="rptSn"/>
	<form:hidden path="weekStartYmd" id="weekStartYmd"/>
	<form:hidden path="weekEndYmd" id="weekEndYmd"/>
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
				                	<c:out value="${rptVO.prjNm }"/>
				                </td>
				                <th scope="row"><strong>계약기간</strong></th>
								<td>
									<c:out value="${rptVO.cntrStartYmd } ~ ${rptVO.cntrEndYmd }"/>
								</td>
				            </tr>
				            <tr>
								<th scope="row"><strong>계약번호</strong></th>
				                <td>
				                	<c:out value="${rptVO.cntrNo }"/>
				                </td>
				                <th scope="row"><strong>업체명</strong></th>
				                <td>
				                	<c:out value="${rptVO.cmpnNm }"/>
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
				            		<c:out value="${rptVO.anlyStartYmd } ~ ${rptVO.anlyEndYmd }"/>
								</th>
								<th class="c pad_l0 pad_r0">	
									<c:out value="${rptVO.dsgnStartYmd } ~ ${rptVO.dsgnEndYmd }"/>
								</th>
								<th class="c pad_l0 pad_r0">
									<c:out value="${rptVO.impStartYmd } ~ ${rptVO.impEndYmd }"/>
								</th>
								<th class="c pad_l0 pad_r0">
									<c:out value="${rptVO.testStartYmd } ~ ${rptVO.testEndYmd }"/>
								</th>
								<th class="c pad_l0 pad_r0">
									<c:out value="${rptVO.pilotStartYmd } ~ ${rptVO.pilotEndYmd }"/>
								</th>
				            </tr>
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>계획</strong></th>	
				                <td class="c">
				                	<c:out value="${rptVO.anlyPlan }%"/>
				                </td>		   
				                <td class="c">
				                	<c:out value="${rptVO.dsgnPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${rptVO.impPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${rptVO.testPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${rptVO.pilotPlan }%"/>
				                </td>	
				                <td class="c">
				                	<c:set var="planTot" value="${rptVO.anlyPlan + rptVO.dsgnPlan + rptVO.impPlan + rptVO.testPlan + rptVO.pilotPlan }" />
				                	<c:out value="${planTot}%"/>
	                			</td>		   
				            </tr> 
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>실적</strong></th>	
				                <td class="c">
				                	<c:out value="${rptVO.anlyPrfr }%"/>
				                </td>		   
				                <td class="c">
				                	<c:out value="${rptVO.dsgnPrfr }%"/>
				                </td>	
				                <td class="c">
									<c:out value="${rptVO.impPrfr }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${rptVO.testPrfr }%"/>
				                </td>	
				                <td class="c">
				                	<c:out value="${rptVO.pilotPrfr }%"/>
				                </td>	
				                <td class="c">
				                	<c:set var="prfrTot" value="${rptVO.anlyPrfr + rptVO.dsgnPrfr + rptVO.impPrfr + rptVO.testPrfr + rptVO.pilotPrfr }" />
				                	<c:out value="${prfrTot }%"/>
				                </td>		                
				            </tr>
				        </tbody>
				    </table>	
				</div>
				<div class="tbl_wrap">
					<h5 class="sm_tit mar_b10 mar_t10">인력 투입 현황</h5>
				    <table class="board_row_type01">
				        <caption>내용(담당 업무, 사업/프로젝트 관리, 기획, 디자인/퍼블리싱, 개발, 투입 총계 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:20%;">
				            <col style="width:30%;">
				            <col style="width:30%;">
				            <col style="width:20%;">
				        </colgroup>
				        <tbody>
				        	<tr>
				                <th scope="row" rowspan="2"><strong>담당 업무</strong></th>
				                <th scope="row" class="c pad_l0"><strong>금주 실적</strong></th>
				                <th scope="row" class="c pad_l0"><strong>차주 계획</strong></th>
				                <th scope="row" rowspan="2" class="c pad_l0"><strong>비고</strong></th>				                
				            </tr>
				            <tr>
				            	<th class="c pad_l0 pad_r0 bdl">
				            		<c:out value="${befWeek.weekStartYmd} ~ ${befWeek.weekEndYmd }"/>
								</th>
								<th class="c pad_l0 pad_r0">
									<c:out value="${befWeek.nextWeekStartYmd} ~ ${befWeek.nextWeekEndYmd }"/>
								</th>
				            </tr>
				            <tr>
				                <th scope="row"><strong>사업/프로젝트 관리</strong></th>	
				                <td class="c">
				                	<c:out value="${rptVO.thisEmpPrj}명"/>
				                </td>
				                <td class="c">
				                	<c:out value="${rptVO.nextEmpPrj}명"/>
				                </td>		   	
				                <td rowspan="5">
				                	<c:out value="${rptVO.rptRmrk}"/>
				                </td>					                            
				            </tr> 
				            <tr>
				                <th scope="row"><strong>기획</strong></th>	
				                <td class="c">
				                	<c:out value="${rptVO.thisEmpPlan}명"/>
				                </td>
				                <td class="c">
				                	<c:out value="${rptVO.nextEmpPlan}명"/>
				                </td>					                	           
				            </tr>
				            <tr>
				                <th scope="row"><strong>디자인/퍼블리싱</strong></th>	
				               	<td class="c">
				               		<c:out value="${rptVO.thisEmpDsgn}명"/>
				                </td>
				                <td class="c">
				                	<c:out value="${rptVO.nextEmpDsgn}명"/>
				                </td>						                	           
				            </tr>
				            <tr>
				                <th scope="row"><strong>개발</strong></th>	
				                <td class="c">
				                	<c:out value="${rptVO.thisEmpDev}명"/>
				                </td>
				                <td class="c">
				                	<c:out value="${rptVO.nextEmpDev}명"/>
				                </td>						                	           
				            </tr>
				            <tr>
				                <th scope="row"><strong>투입 총계</strong></th>	
				                <td class="c">
				                	<c:set var="thisEmpTot" value="${rptVO.thisEmpPrj + rptVO.thisEmpPlan + rptVO.thisEmpDsgn + rptVO.thisEmpDev }" />
				                	<c:out value="${thisEmpTot}명"/>
				                </td>	   
				                <td class="c">
				                	<c:set var="nextEmpTot" value="${rptVO.nextEmpPrj + rptVO.nextEmpPlan + rptVO.nextEmpDsgn + rptVO.nextEmpDev }" />
				                	<c:out value="${nextEmpTot}명"/>
				                </td>						                	           
				            </tr>
				        </tbody>
				    </table>	
				</div>
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
				                	<pre><c:out value="${rptVO.issueCn }"></c:out></pre>
				                </td>		   
				                <td>
				                	<pre><c:out value="${rptVO.actnPlan }"></c:out></pre>
				                </td>						                            
				            </tr> 				            
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">금주 실적 및 익주 계획</h4>
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
				                	<strong class="mar_b10">금주 실적 </strong><br>
				                	<c:out value="${befWeek.weekStartYmd} ~ ${befWeek.weekEndYmd }"/>
								</th>	        
				                <th scope="row" class="c pad_l0">
				                	<strong class="mar_b10">차주 계획</strong><br>
				                	<c:out value="${befWeek.nextWeekStartYmd} ~ ${befWeek.nextWeekEndYmd }"/>
				                </th>	            
				            </tr>
				        </thead>
				        <tbody>				        	
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>내용</strong></th>	
				                <td class="vt">
				                	<pre><c:out value="${rptVO.thisPrfr }"></c:out></pre>
				                </td>		   
				                <td class="vt">
				                	<pre><c:out value="${rptVO.nextPlan }"></c:out></pre>
				                </td>					                            
				            </tr> 				            
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">요청자료 목록</h4>
				<div class="tbl_top">
					<div class="tbl_left">
					<%-- <h4 class="md_tit"><c:out value="${thisYear}년 ${rptVO.monWeek }차 주간보고 (${rptVO.weekJobStartYmd } ~ ${rptVO.weekJobEndYmd })" /></h4> --%>
					</div>
					<div class="tbl_right">
					</div>
				</div>
				
				<div class="tbl_wrap">
				    <table class="board_row_type01">
				        <caption>내용(번호, 구분, 자료, 요청일, 처리, 비고 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:5%;">
				            <col style="width:15%;">
				            <col style="width:30%;">
				            <col style="width:10%;">
				            <col style="width:10%;">
				            <col style="width:30%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>번호</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>구분</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>자료</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>요청일</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>처리</strong></th>     
				                <th scope="row" class="c pad_l0"><strong>비고</strong></th>           
				            </tr>
				        </thead>
				        <tbody id="tbodyMtrl">	
				        <c:choose>
				        	<c:when test="${fn:length(mtrlList) gt 0 }">
				        		<c:forEach var="mtrl" items="${mtrlList }" varStatus="mtrlStatus">
				        			<tr id="mtrlTr_${mtrlStatus.count }">
				        				<input type="hidden" id="rptMtrlSn_${mtrlStatus.count }" value="${mtrl.rptMtrlSn }" />
				        				<th class="c pad_l0 mtrlCnt" >${mtrlStatus.count }</th>	
				        				<td><c:out value="${mtrl.mtrlGbn }"></c:out></td>
				        				<td><c:out value="${mtrl.mtrlCn }"></c:out></td>
				        				<td><c:out value="${mtrl.reqDt }"></c:out></td>
				        				<td><c:out value="${mtrl.procGbn }"></c:out></td>
				        				<td><c:out value="${mtrl.mtrlRmrk }"></c:out></td>
				        			</tr>
				        		</c:forEach>
				        	</c:when>
				        	<c:otherwise>
				        		<tr class="no_data" id="mtrlNodata">
				        			<td colspan="6">등록된 내역이 없습니다.</td>
				        		</tr>
				        	</c:otherwise>
				        </c:choose>			        	
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">지시 및 조치사항</h4>
				<div class="tbl_top">
					<div class="tbl_left">
					<%-- <h4 class="md_tit"><c:out value="${thisYear}년 ${rptVO.monWeek }차 주간보고 (${rptVO.weekJobStartYmd } ~ ${rptVO.weekJobEndYmd })" /></h4> --%>
					</div>
					<div class="tbl_right">
					</div>
				</div>
				<div class="tbl_wrap">
				    <table class="board_row_type01">
				        <caption>내용(번호, 지시내용, 지시일, 처리일, 비고 등으로 구성)</caption>
				        <colgroup>
				            <col style="width:5%;">
				            <col style="width:45%;">
				            <col style="width:10%;">
				            <col style="width:10%;">
				            <col style="width:30%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>번호</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>지시내용</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>지시일</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>처리</strong></th>      
				                <th scope="row" class="c pad_l0"><strong>비고</strong></th>           
				            </tr>
				        </thead>
				        <tbody id="tbodyActn">	
				        <c:choose>
					        <c:when test="${fn:length(actnList) gt 0 }">
					        	<c:forEach var="actn" items="${actnList }" varStatus="actnStatus">
				        			<tr id="actnTr_${actnStatus.count }">
				        				<input type="hidden" id="rptActnSn_${actnStatus.count }" value="${actn.rptActnSn }" />
				        				<th class="c pad_l0 actnCnt">${actnStatus.count }</th>	
				        				<td><c:out value="${actn.instrCn }"></c:out></td>
				        				<td><c:out value="${actn.instrDt }"></c:out></td>
				        				<td><c:out value="${actn.actnGbn }"></c:out></td>
				        				<td><c:out value="${actn.actnRmrk }"></c:out></td>
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
				<div class="btn_area">
					<c:if test="${grpAuthId eq 'developer' }">
						<a href="javascript:void(0)" id="btn_rewrite" class="btn btn_mdl btn_rewrite" onclick="fncPageBoard('update', 'updateForm.do', '${rptVO.rptSn }', 'rptSn');">수정</a>
					    <a href="javascript:void(0)" id="btn_del" class="btn btn_mdl btn_del">삭제</a>
				    </c:if>
				    <a href="#" id="btn_list" class="btn btn_mdl btn_list">목록</a>
				</div>
    <span></span>
</form:form>
