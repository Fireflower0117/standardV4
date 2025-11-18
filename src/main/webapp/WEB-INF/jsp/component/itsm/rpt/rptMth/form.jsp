<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
$(document).ready(function(){
	 $('.numOnly').on('input', function(event) {
        this.value=this.value.replace(/[^0-9]/g,'');
        if(this.value == '' || this.value == null || this.value === undefined ) {
        	this.value=0;
        } else {
	        this.value=parseInt(this.value);
        }
    });

	$('.planNum').on('input', function(event) {
		var numeric = Number($(this).val());
		var maxNum = Number($(this).data('limit'));
		if(numeric > maxNum){
			$(this).val(maxNum);
		}
	});

	$('.prfrNum').on('input', function(event) {
		var numeric = Number($(this).val());
		var maxNum = Number($(this).data('limit'));
		if(numeric > maxNum){
			$(this).val(maxNum);
		}
	});
	

	autoCal('prfr');
	autoCal('plan');
	autoCal('emp1');
	autoCal('emp2');
	autoCal('emp3');
	autoCal('emp4');
	autoCal('emp5');
	
	<%-- 첨부파일 출력 HTML function --%>
	$("#atchFileUpload").html(setFileList($("#reqAtchFileId").val(), "reqAtchFileId", "view"));

	$("#btn_updateProc").click(function(){
		setDataList();
 		fncPageBoard('update', 'updateProc.do', '${monthRptVO.rptMonthSn }', 'rptMonthSn');
	})
	
	
});

/* 보고서 다운로드 */
function siteReportPop(){
	
	var childWindow;
	
	childWindow = window.open("", "childForm", "width=620, height=1000, resizable = no, scrollbars = no");
	
	var defaultFrm = document.defaultFrm;

	defaultFrm.action = "/itsm/report/rpt/weekReport.do";
	defaultFrm.method = "post";
	defaultFrm.target = "childForm";
	defaultFrm.submit();

	defaultFrm.target = "";
	
	return false;
	
}

let dscsCnt = ${fn:length(dscsList) gt 0 ? fn:length(dscsList) : 1};

/* 요청자료/조치사항 tr삭제 */
function fnctrDel(idx){
	$("#dscsTr_"+idx).remove();
	$(".dscsCnt").each(function(idx){
		$(this).text(idx+1);
	})
	
	if($("#tbodyDscs tr").length == 0){
		let noHtml = '<tr class="no_data" id="dscsNodata">';
			noHtml += '<td colspan="7">등록된 내역이 없습니다.</td>';
			noHtml += '</tr>';
		$("#tbodyDscs").html(noHtml);
	}

};

/* 요청자료/지시사항 tr추가 */
function fncTrAdd(){
	console.log(dscsCnt);
	$("#dscsNodata").remove();
	
	++dscsCnt;
	let newTrHtml = '';
		newTrHtml += '<tr id="dscsTr_' + dscsCnt+ '">';
		newTrHtml += '<th class="c pad_l0 dscsCnt no_bdl">' + dscsCnt + '</th>';
		newTrHtml += '<input type="hidden" id="rptDscsSn_' + dscsCnt + '"/>'; 	
        newTrHtml += '<td><input type="text" id="dscsGbn_' + dscsCnt + '"  style="width:100% ;" maxlength="15"/></td>'; 	
        newTrHtml += '<td><input type="text" id="dscsItem_' + dscsCnt + '" style="width:100% ;" maxlength="15"/></td>'; 	
        newTrHtml += '<td class="c"><input type="text" id="dscsCn_' + dscsCnt + '"  style="width:100% ;" maxlength="50"/></td>'; 	
        newTrHtml += '<td><input type="text" id="dscsRmrk_' + dscsCnt + '" style="width:100% ;" maxlength="80"/></td>'; 	
        newTrHtml += '<td><a href="javascript:void(0);" class="btn btn_i_del" onclick="fnctrDel(' + dscsCnt + ')" ><span></span></a></td>'; 	
        newTrHtml += '</tr>';     		   
	
	$("#tbodyDscs").append(newTrHtml);
	
	$(".dscsCnt").each(function(idx){
		$(this).text(idx+1);
	})
		
};

function setDataList(){
	// 주요 눈의 및 협조사항
	$("input:hidden[id^=rptDscsSn_]").each(function(idx){
		var endNum = $(this).attr("id").replace("rptDscsSn_", "");
		$("#rptDscsSn_" + endNum).attr("name", "dscsList[" + idx + "].rptDscsSn"); 	// 일련번호
		$("#dscsGbn_" + endNum).attr("name", "dscsList[" + idx + "].dscsGbn"); 		// 구분
		$("#dscsItem_" + endNum).attr("name", "dscsList[" + idx + "].dscsItem"); 	// 항목
		$("#dscsCn_" + endNum).attr("name", "dscsList[" + idx + "].dscsCn"); 		// 내용
		$("#dscsRmrk_" + endNum).attr("name", "dscsList[" + idx + "].dscsRmrk"); 	// 비고
	});
};



function autoCal(gbn){
	let total = 0;
	if(gbn == 'prfr'){
		$(".prfrNum").each(function(){
			total +=  Number($(this).val());
		});
		$("#prfrTot").val(total);
	}else if(gbn == 'plan'){
		$(".planNum").each(function(){
			total +=  Number($(this).val());
		});
		$("#planTot").val(total);
	}else if(gbn == 'emp1'){
		$(".emp1").each(function(){
			total +=  Number($(this).val());
		});
		$("#empTot1").val(total);
	}else if(gbn == 'emp2'){
		$(".emp2").each(function(){
			total +=  Number($(this).val());
		});
		$("#empTot2").val(total);
	}else if(gbn == 'emp3'){
		$(".emp3").each(function(){
			total +=  Number($(this).val());
		});
		$("#empTot3").val(total);
	}else if(gbn == 'emp4'){
		$(".emp4").each(function(){
			total +=  Number($(this).val());
		});
		$("#empTot4").val(total);
	}else if(gbn == 'emp5'){
		$(".emp5").each(function(){
			total +=  Number($(this).val());
		});
		$("#empTot5").val(total);
	}
};

</script>
<form:form modelAttribute="monthRptVO" name="defaultFrm" id="defaultFrm" method="post">
	<form:hidden path="rptMonthSn" id="rptMonthSn"/>
	<form:hidden path="thisMonthStartYmd" id="thisMonthStartYmd"/>
	<form:hidden path="thisMonthEndYmd" id="thisMonthEndYmd"/>
	<form:hidden path="nextMonthStartYmd" id="nextMonthStartYmd"/>
	<form:hidden path="nextMonthEndYmd" id="nextMonthEndYmd"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
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
				                	<form:input path="anlyPlan" id="anlyPlan" class="planNum numOnly" style="width:60px;"  maxLength="2" data-limit="14" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>		   
				                <td class="c">
				                	<form:input path="dsgnPlan" id="dsgnPlan" class="planNum numOnly" style="width:60px;"  maxLength="2" data-limit="23" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="impPlan" id="impPlan" class="planNum numOnly" style="width:60px;"  maxLength="2" data-limit="38" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="testPlan" id="testPlan" class="planNum numOnly" style="width:60px;"  maxLength="2" data-limit="10" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="pilotPlan" id="pilotPlan" class="planNum numOnly" style="width:60px;"  maxLength="2" data-limit="15" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="planTot" id="planTot" style="width:60px;"  readonly="true" />&nbsp;%
	                			</td>		   
				            </tr> 
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>실적</strong></th>	
				                <td class="c">
				                	<form:input path="anlyPrfr" id="anlyPrfr" class=" prfrNum numOnly " style="width:60px;"  maxLength="2" data-limit="14" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>		   
				                <td class="c">
				                	<form:input path="dsgnPrfr" id="dsgnPrfr" class=" prfrNum numOnly"  style="width:60px;" maxLength="2" data-limit="23" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="impPrfr" id="impPrfr" class=" prfrNum numOnly"  style="width:60px;" maxLength="2" data-limit="38" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="testPrfr" id="testPrfr" class=" prfrNum numOnly" style="width:60px;"  maxLength="2" data-limit="10" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="pilotPrfr" id="pilotPrfr" class=" prfrNum numOnly" style="width:60px;"  maxLength="2" data-limit="15" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="prfrTot" id="prfrTot" style="width:60px;"  readonly="true" />&nbsp;%
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
					            </tr>
					            <tr>
					                <th scope="row"><strong>사업/프로젝트 관리</strong></th>	
					                <td class="c">
					                	<form:input path="empPrj1" id="empPrj1" class="emp1 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPrj2" id="empPrj2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');"/>&nbsp;명
					                </td>		   	
					                <td class="c">
					                	<form:input path="empPrj3" id="empPrj3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPrj4" id="empPrj4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');"/>&nbsp;명
					                </td>		   	
					            </tr> 
					            <tr>
					                <th scope="row"><strong>기획</strong></th>	
					                <td class="c">
					                	<form:input path="empPlan1" id="empPlan1" class="emp1 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPlan2" id="empPlan2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');" />&nbsp;명
					                </td>					                	           
					                <td class="c">
					                	<form:input path="empPlan3" id="empPlan3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPlan4" id="empPlan4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');" />&nbsp;명
					                </td>					                	           
					            </tr>
					            <tr>
					                <th scope="row"><strong>디자인/퍼블리싱</strong></th>	
					               	<td class="c">
					                	<form:input path="empDsgn1" id="empDsgn1" class="emp1 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empDsgn2" id="empDsgn2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDsgn3" id="empDsgn3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDsgn4" id="empDsgn4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');" />&nbsp;명
					                </td>						                	           
					            </tr>
					            <tr>
					                <th scope="row"><strong>개발</strong></th>	
					                <td class="c">
					                	<form:input path="empDev1" id="empDev1" class="emp1 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empDev2" id="empDev2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDev3" id="empDev3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDev4" id="empDev4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');" />&nbsp;명
					                </td>						                	           
					            </tr>
					            <tr>
					                <th scope="row"><strong>투입 총계</strong></th>	
					                <td class="c">
					                	<form:input path="empTot1" id="empTot1" style="width:60px;"  readonly="true"/>&nbsp;명
					                </td>	   
					                <td class="c">
					                	<form:input path="empTot2" id="empTot2" style="width:60px;" readonly="true"/>&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empTot3" id="empTot3" style="width:60px;"  readonly="true"/>&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empTot4" id="empTot4" style="width:60px;"  readonly="true"/>&nbsp;명
					                </td>						                	           
					            </tr>
					        </tbody>
					    </table>	
					</div>
				</c:if>
				<c:if test="${not empty monthRptVO.monWeek5}">
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
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek1}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek2}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek3}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek4}</strong></th>
					                <th scope="row" class="c pad_l0"><strong>${monthRptVO.monWeek5}</strong></th>
					            </tr>
					            <tr>
					                <th scope="row"><strong>사업/프로젝트 관리</strong></th>	
					                <td class="c">
					                	<form:input path="empPrj1" id="empPrj1" class="emp1 numOnly" style="width:60px;" maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPrj2" id="empPrj2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');"/>&nbsp;명
					                </td>		   	
					                <td class="c">
					                	<form:input path="empPrj3" id="empPrj3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPrj4" id="empPrj4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');"/>&nbsp;명
					                </td>		   	
					                <td class="c">
					                	<form:input path="empPrj5" id="empPrj5" class="emp5 numOnly" style="width:60px;"   maxLength="2" onkeyup="autoCal('emp5');"/>&nbsp;명
					                </td>		   	
					            </tr> 
					            <tr>
					                <th scope="row"><strong>기획</strong></th>	
					                <td class="c">
					                	<form:input path="empPlan1" id="empPlan1" class="emp1 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPlan2" id="empPlan2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');" />&nbsp;명
					                </td>					                	           
					                <td class="c">
					                	<form:input path="empPlan3" id="empPlan3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empPlan4" id="empPlan4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');" />&nbsp;명
					                </td>					                	           
					                <td class="c">
					                	<form:input path="empPlan5" id="empPlan5" class="emp5 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp5');" />&nbsp;명
					                </td>					                	           
					            </tr>
					            <tr>
					                <th scope="row"><strong>디자인/퍼블리싱</strong></th>	
					               	<td class="c">
					                	<form:input path="empDsgn1" id="empDsgn1" class="emp1 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empDsgn2" id="empDsgn2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDsgn3" id="empDsgn3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDsgn4" id="empDsgn4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDsgn5" id="empDsgn5" class="emp5 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp5');" />&nbsp;명
					                </td>						                	           
					            </tr>
					            <tr>
					                <th scope="row"><strong>개발</strong></th>	
					                <td class="c">
					                	<form:input path="empDev1" id="empDev1" class="emp1 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp1');"/>&nbsp;명
					                </td>
					                <td class="c">
					                	<form:input path="empDev2" id="empDev2" class="emp2 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp2');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDev3" id="empDev3" class="emp3 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp3');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDev4" id="empDev4" class="emp4 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp4');" />&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empDev5" id="empDev5" class="emp5 numOnly" style="width:60px;"  maxLength="2" onkeyup="autoCal('emp5');" />&nbsp;명
					                </td>						                	           
					            </tr>
					            <tr>
					                <th scope="row"><strong>투입 총계</strong></th>	
					                <td class="c">
					                	<form:input path="empTot1" id="empTot1" style="width:60px;"  readonly="true"/>&nbsp;명
					                </td>	   
					                <td class="c">
					                	<form:input path="empTot2" id="empTot2" style="width:60px;"  readonly="true"/>&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empTot3" id="empTot3" style="width:60px;"   readonly="true"/>&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empTot4" id="empTot4" style="width:60px;"  readonly="true"/>&nbsp;명
					                </td>						                	           
					                <td class="c">
					                	<form:input path="empTot5" id="empTot5" style="width:60px;" readonly="true"/>&nbsp;명
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
				                	<form:textarea path="issueCn" id="issueCn" class="text_area_big"/>
				                </td>		   
				                <td>
				                	<form:textarea path="actnPlan" id="actnPlan" class="text_area_big"/>
				                </td>						                            
				            </tr> 				            
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">금월 실적 및 차월 계획</h4>
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
				                <td>
				                	<form:textarea path="thisPrfr" id="thisPrfr" class="text_area_big"/>
				                </td>		   
				                <td>
				                	<form:textarea path="nextPlan" id="nextPlan" class="text_area_big"/>
				                </td>					                            
				            </tr> 				            
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">주요 논의 및 협조사항</h4>
				<div class="tbl_top prtv">
					<div class="tbl_left">
					<%-- <h4 class="md_tit"><c:out value="${thisYear}년 ${monthRptVO.monWeek }차 주간보고 (${monthRptVO.weekJobStartYmd } ~ ${monthRptVO.weekJobEndYmd })" /></h4> --%>
					</div>
					<div class="tbl_right">
						<div class="btn_area">
				   			<a href="javascript:void(0);" class="btn sml blue add_btn pt5" id="btn_actn" onclick="fncTrAdd();" >추가<i class="xi-plus-circle-o"></i></a>
				    	</div>
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
				            <col style="width:5%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>번호</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>구분</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>항목</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>내용</strong></th>      
				                <th scope="row" class="c pad_l0"><strong>비고</strong></th>           
				                <th scope="row" class="c pad_l0"></th>                
				            </tr>
				        </thead>
				        <tbody id="tbodyDscs">	
				        <c:choose>
					        <c:when test="${fn:length(dscsList) gt 0 }">
					        	<c:forEach var="dscs" items="${dscsList }" varStatus="dscsStatus">
				        			<tr id="dscsTr_${dscsStatus.count }">
				        				<input type="hidden" id="rptDscsSn_${dscsStatus.count }" value="${dscs.rptDscsSn }" />
				        				<th class="c pad_l0 dscsCnt no_bdl">${dscsStatus.count }</th>		
				        				<td><input type="text" id="dscsGbn_${dscsStatus.count }" value="${dscs.dscsGbn}" class="text" style="width:100% ;" maxlength="15"/></td>
				        				<td><input type="text" id="dscsItem_${dscsStatus.count }" value="${dscs.dscsItem}" class="text" style="width:100% ;" maxlength="15"/></td>
				        				<td class="c"><input type="text" id="dscsCn_${dscsStatus.count }" value="${dscs.dscsCn}" class="text" style="width:100% ;" maxlength="50"/></td>
				        				<td><input type="text" id="dscsRmrk_${dscsStatus.count }" value="${dscs.dscsRmrk}" class="text" style="width:100% ;" maxlength="80"/></td>
				        				<td><a href="javascript:void(0);" class="btn btn_i_del"  onclick="fnctrDel('${dscsStatus.count }');" ><span></span></a></td>
				        			</tr>
				        		</c:forEach>
				        	</c:when>
				        	<c:otherwise>
				        		<tr class="no_data" id="dscsNodata">
				        			<td colspan="6">등록된 내역이 없습니다.</td>
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
				                	<form:textarea path="rptMonthRmrk" id="rptMonthRmrk" class="text_area_big"/>
				                </td>		   
				            </tr> 				            
				        </tbody>
				    </table>		
				</div>
				<div class="btn_area">
					<c:if test="${grpAuthId eq 'developer' }">
						<a href="javascript:void(0)" id="btn_updateProc" class="btn btn_mdl btn_rewrite" >저장</a>
				    </c:if>
				    <a href="#" id="btn_list" class="btn btn_mdl btn_list">취소</a>
				</div>
    <span></span>
</form:form>
