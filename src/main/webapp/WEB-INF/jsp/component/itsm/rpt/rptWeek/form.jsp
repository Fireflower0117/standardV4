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
	autoCal('thisEmp');
	autoCal('nextEmp');
	$('input[id^="reqDt_"]').each(function() {
		fncDate($(this).attr("id"))
	})
	$('input[id^="instrDt_"]').each(function() {
		fncDate($(this).attr("id"))
	})
	<%-- 첨부파일 출력 HTML function --%>
	$("#atchFileUpload").html(setFileList($("#reqAtchFileId").val(), "reqAtchFileId", "view"));

	$("#btn_updateProc").click(function(){
		setDataList();
 		fncPageBoard('update', 'updateProc.do', '${rptVO.rptSn }', 'rptSn');
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

let mtrlCnt = ${fn:length(mtrlList) gt 0 ? fn:length(mtrlList) : 1};
let actnCnt = ${fn:length(actnList) gt 0 ? fn:length(actnList) : 1};

/* 요청자료/조치사항 tr삭제 */
function fnctrDel(idx,gbn){
	console.log(gbn)
	// 구분값으로 요청/조치 tr 삭제해야됨
	if(gbn == 'mtrl'){
		$("#mtrlTr_"+idx).remove();
		$(".mtrlCnt").each(function(idx){
			$(this).text(idx+1);
		})
		if($("#tbodyMtrl tr").length == 0){
			let noHtml = '<tr class="no_data" id="mtrlNodata">';
				noHtml += '<td colspan="7">등록된 내역이 없습니다.</td>';
				noHtml += '</tr>';
			$("#tbodyMtrl").html(noHtml);
		}
		
	}else if(gbn == 'actn'){
		$("#actnTr_"+idx).remove();
		$(".actnCnt").each(function(idx){
			$(this).text(idx+1);
		})
		if($("#tbodyActn tr").length == 0){
			let noHtml = '<tr class="no_data" id="actnNodata">';
				noHtml += '<td colspan="7">등록된 내역이 없습니다.</td>';
				noHtml += '</tr>';
			$("#tbodyActn").html(noHtml);
		}
	}
};

/* 요청자료/지시사항 tr추가 */
function fncTrAdd(gbn){
	
	if(gbn == 'mtrl'){
		$("#mtrlNodata").remove();
		
		++mtrlCnt;
	
		let newTrHtml = '';
			newTrHtml += '<tr id="mtrlTr_' + mtrlCnt+ '">';
			newTrHtml += '<th class="c pad_l0 mtrlCnt">' + mtrlCnt + '</th>';
	        newTrHtml += '<input type="hidden" id="rptMtrlSn_' + mtrlCnt + '"/>'; 	
	        newTrHtml += '<td><input type="text" id="mtrlGbn_' + mtrlCnt + '"  class="text" maxlength="15"/></td>'; 	
	        newTrHtml += '<td><input type="text" id="mtrlCn_' + mtrlCnt + '" class="text"  style="width:100% ;" maxlength="50"/></td>'; 	
	        newTrHtml += '<td class="c"><span class="calendar_input w120"><input type="text" id="reqDt_' + mtrlCnt + '" class="text"/></span></td>';
	        newTrHtml += '<td><input type="text" id="procGbn_' + mtrlCnt + '" class="text" maxlength="18"/></td>'; 	
	        newTrHtml += '<td><input type="text" id="mtrlRmrk_' + mtrlCnt + '" class="text" style="width:100% ;" maxlength="100"/></td>'; 	
	        newTrHtml += '<td class="c"><a href="javascript:void(0);" class="btn btn_i_del" onclick="fnctrDel(\'' + mtrlCnt + '\',\'' + gbn + '\')" ><span></span></a></td>'; 	
	        newTrHtml += '</tr>';     		   
			
		$("#tbodyMtrl").append(newTrHtml);
		fncDate('reqDt_' + mtrlCnt)
		$(".mtrlCnt").each(function(idx){
			$(this).text(idx+1);
		})
		
	}else if(gbn == 'actn'){
		$("#actnNodata").remove();
		
		++actnCnt;
		
		let newTrHtml = '';
			newTrHtml += '<tr id="actnTr_' + actnCnt+ '">';
			newTrHtml += '<th class="c pad_l0 actnCnt">' + actnCnt + '</th>';
			newTrHtml += '<input type="hidden" id="rptActnSn_' + actnCnt + '"/>'; 	
	        newTrHtml += '<td><input type="text" id="instrCn_' + actnCnt + '"  class="text" style="width:100% ;" maxlength="50"/></td>'; 	
	        newTrHtml += '<td><span class="calendar_input w120"><input type="text" id="instrDt_' + actnCnt + '" class="text"/></span></td>';
	        newTrHtml += '<td class="c"><input type="text" id="actnGbn_' + actnCnt + '" class="text" maxlength="15"/></td>';
	        newTrHtml += '<td><input type="text" id="actnRmrk_' + actnCnt + '" class="text" style="width:100% ;" maxlength="80"/></td>'; 	
	        newTrHtml += '<td class="c"><a href="javascript:void(0);" class="btn btn_i_del" onclick="fnctrDel(\'' + actnCnt + '\',\'' + gbn + '\')" ><span></span></a></td>'; 	
	        newTrHtml += '</tr>';     		   
		
		$("#tbodyActn").append(newTrHtml);
		fncDate('instrDt_' + actnCnt);
		$(".actnCnt").each(function(idx){
			$(this).text(idx+1);
		})
		
	}
};

function setDataList(){
	// 요청자료 목록
	$("input:hidden[id^=rptMtrlSn_]").each(function(idx){
		var endNum = $(this).attr("id").replace("rptMtrlSn_", "");
		$("#rptMtrlSn_" + endNum).attr("name", "mtrlList[" + idx + "].rptMtrlSn"); // 일련번호
		$("#mtrlGbn_" + endNum).attr("name", "mtrlList[" + idx + "].mtrlGbn"); // 구분
		$("#mtrlCn_" + endNum).attr("name", "mtrlList[" + idx + "].mtrlCn"); // 자료
		$("#reqDt_" + endNum).attr("name", "mtrlList[" + idx + "].reqDt"); // 요청일
		$("#procGbn_" + endNum).attr("name", "mtrlList[" + idx + "].procGbn"); // 처리
		$("#mtrlRmrk_" + endNum).attr("name", "mtrlList[" + idx + "].mtrlRmrk"); // 비고
	});
	// 지시 및 조치사항 목록
	$("input:hidden[id^=rptActnSn_]").each(function(idx){
		var endNum = $(this).attr("id").replace("rptActnSn_", "");
		$("#rptActnSn_" + endNum).attr("name", "actnList[" + idx + "].rptActnSn"); // 일련번호
		$("#instrCn_" + endNum).attr("name", "actnList[" + idx + "].instrCn"); // 지시내용
		$("#instrDt_" + endNum).attr("name", "actnList[" + idx + "].instrDt"); // 지시일
		$("#actnGbn_" + endNum).attr("name", "actnList[" + idx + "].actnGbn"); // 처리구분
		$("#actnRmrk_" + endNum).attr("name", "actnList[" + idx + "].actnRmrk"); // 비고
	});
};

/* 합계/ 최대입력 값 설정 */
function setNumeric(num){
    var numeric = Number(num.value);
    var maxNum = Number(num.dataset.limit);
    if(numeric > maxNum){
    	 num.value = maxNum;
    }
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
	}else if(gbn == 'nextEmp'){
		$(".nextEmp").each(function(){
			total +=  Number($(this).val());
		});
		$("#nextEmpTot").val(total);
	}else if(gbn == 'thisEmp'){
		$(".thisEmp").each(function(){
			total +=  Number($(this).val());
		});
		$("#thisEmpTot").val(total);
	}
};

</script>
<form:form modelAttribute="rptVO" name="defaultFrm" id="defaultFrm" method="post">
	<form:hidden path="rptSn" id="rptSn"/>
	<form:hidden path="weekStartYmd" id="weekStartYmd"/>
	<form:hidden path="weekEndYmd" id="weekEndYmd"/>
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
				                	<form:input path="anlyPlan" id="anlyPlan" cssClass="text required w60 planNum numOnly" maxLength="2" data-limit="14" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>		   
				                <td class="c">
				                	<form:input path="dsgnPlan" id="dsgnPlan" cssClass="text required w60 planNum numOnly" maxLength="2" data-limit="23" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="impPlan" id="impPlan" cssClass="text required w60 planNum numOnly" maxLength="2" data-limit="38" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="testPlan" id="testPlan" cssClass="text required w60 planNum numOnly" maxLength="2" data-limit="10" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="pilotPlan" id="pilotPlan" cssClass="text required w60 planNum numOnly" maxLength="2" data-limit="15" onkeyup="autoCal('plan');" />&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="planTot" id="planTot" class="text required w60" readonly="true" />&nbsp;%
	                			</td>		   
				            </tr> 
				            <tr>
				                <th scope="row" class="c pad_l0"><strong>실적</strong></th>	
				                <td class="c">
				                	<form:input path="anlyPrfr" id="anlyPrfr" class="text required w60 prfrNum numOnly" maxLength="2" data-limit="14" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>		   
				                <td class="c">
				                	<form:input path="dsgnPrfr" id="dsgnPrfr" class="text required w60 prfrNum numOnly" maxLength="2" data-limit="23" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="impPrfr" id="impPrfr" class="text required w60 prfrNum numOnly" maxLength="2" data-limit="38" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="testPrfr" id="testPrfr" class="text required w60 prfrNum numOnly" maxLength="2" data-limit="10" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="pilotPrfr" id="pilotPrfr" class="text required w60 prfrNum numOnly" maxLength="2" data-limit="15" onkeyup="autoCal('prfr');"/>&nbsp;%
				                </td>	
				                <td class="c">
				                	<form:input path="prfrTot" id="prfrTot" class="text required w60" readonly="true" />&nbsp;%
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
								</td>
								<th class="c pad_l0 pad_r0">
									<c:out value="${befWeek.nextWeekStartYmd} ~ ${befWeek.nextWeekEndYmd }"/>
								</td>								
				            </tr>
				            <tr>
				                <th scope="row"><strong>사업/프로젝트 관리</strong></th>	
				                <td class="c">
				                	<form:input path="thisEmpPrj" id="thisEmpPrj" cssClass="text required w60 thisEmp numOnly"  maxLength="2" onkeyup="autoCal('thisEmp');"/>&nbsp;명
				                </td>
				                <td class="c">
				                	<form:input path="nextEmpPrj" id="nextEmpPrj" cssClass="text required w60 nextEmp numOnly"  maxLength="2" onkeyup="autoCal('nextEmp');"/>&nbsp;명
				                </td>		   	
				                <td rowspan="5">
				                	<form:textarea path="rptRmrk" id="rptRmrk" class="text_area_big"/>
				                </td>					                            
				            </tr> 
				            <tr>
				                <th scope="row"><strong>기획</strong></th>	
				                <td class="c">
				                	<form:input path="thisEmpPlan" id="thisEmpPlan" cssClass="text required w60 thisEmp numOnly"  maxLength="2" onkeyup="autoCal('thisEmp');"/>&nbsp;명
				                </td>
				                <td class="c">
				                	<form:input path="nextEmpPlan" id="nextEmpPlan" cssClass="text required w60 nextEmp numOnly"  maxLength="2" onkeyup="autoCal('nextEmp');" />&nbsp;명
				                </td>					                	           
				            </tr>
				            <tr>
				                <th scope="row"><strong>디자인/퍼블리싱</strong></th>	
				               	<td class="c">
				                	<form:input path="thisEmpDsgn" id="thisEmpDsgn" cssClass="text required w60 thisEmp numOnly"  maxLength="2" onkeyup="autoCal('thisEmp');"/>&nbsp;명
				                </td>
				                <td class="c">
				                	<form:input path="nextEmpDsgn" id="nextEmpDsgn" cssClass="text required w60 nextEmp numOnly"  maxLength="2" onkeyup="autoCal('nextEmp');" />&nbsp;명
				                </td>						                	           
				            </tr>
				            <tr>
				                <th scope="row"><strong>개발</strong></th>	
				                <td class="c">
				                	<form:input path="thisEmpDev" id="thisEmpDev" cssClass="text required w60 thisEmp numOnly"  maxLength="2" onkeyup="autoCal('thisEmp');"/>&nbsp;명
				                </td>
				                <td class="c">
				                	<form:input path="nextEmpDev" id="nextEmpDev" cssClass="text required w60 nextEmp numOnly"  maxLength="2" onkeyup="autoCal('nextEmp');" />&nbsp;명
				                </td>						                	           
				            </tr>
				            <tr>
				                <th scope="row"><strong>투입 총계</strong></th>	
				                <td class="c">
				                	<form:input path="thisEmpTot" id="thisEmpTot" cssClass="text required w60" readonly="true"/>&nbsp;명
				                </td>	   
				                <td class="c">
				                	<form:input path="nextEmpTot" id="nextEmpTot" cssClass="text required w60" readonly="true"/>&nbsp;명
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
				                	<form:textarea path="issueCn" id="issueCn" class="text_area_big"/>
				                </td>		   
				                <td>
				                	<form:textarea path="actnPlan" id="actnPlan" class="text_area_big"/>
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
				<h4 class="md_tit">요청자료 목록</h4>
				<div class="tbl_top">
					<div class="tbl_left">
					<%-- <h4 class="md_tit"><c:out value="${thisYear}년 ${rptVO.monWeek }차 주간보고 (${rptVO.weekJobStartYmd } ~ ${rptVO.weekJobEndYmd })" /></h4> --%>
					</div>
					<div class="tbl_right">
						<div class="btn_area">
				   			<a href="javascript:void(0);" class="btn sml blue add_btn pt5" id="btn_mtrl" onclick="fncTrAdd('mtrl');" >추가<i class="xi-plus-circle-o"></i></a>
				    	</div>
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
				            <col style="width:26%;">
				            <col style="width:9%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>번호</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>구분</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>자료</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>요청일</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>처리</strong></th>     
				                <th scope="row" class="c pad_l0"><strong>비고</strong></th>           
				                <th scope="row" class="c pad_l0"></th>           
				            </tr>
				        </thead>
				        <tbody id="tbodyMtrl">	
				        <c:choose>
				        	<c:when test="${fn:length(mtrlList) gt 0 }">
				        		<c:forEach var="mtrl" items="${mtrlList }" varStatus="mtrlStatus">
				        			<tr id="mtrlTr_${mtrlStatus.count }">
				        				<input type="hidden" id="rptMtrlSn_${mtrlStatus.count }" value="${mtrl.rptMtrlSn }" />
				        				<th class="c pad_l0 mtrlCnt no_bdl" >${mtrlStatus.count }</th>	
				        				<td><input type="text" id="mtrlGbn_${mtrlStatus.count }" value="${mtrl.mtrlGbn}" class="text" style="width:100% ;" maxlength="15"/></td>
				        				<td><input type="text" id="mtrlCn_${mtrlStatus.count }" value="${mtrl.mtrlCn}" class="text" style="width:100% ;" maxlength="50"/></td>
										<td class="c"><span class="calendar_input w120"><input type="text" id="reqDt_${mtrlStatus.count }" value="${mtrl.reqDt}" class="text"/></span></td>
				        				<td><input type="text" id="procGbn_${mtrlStatus.count }" value="${mtrl.procGbn}" class="text" style="width:100% ;" maxlength="18"/></td>
				        				<td><input type="text" id="mtrlRmrk_${mtrlStatus.count }" value="${mtrl.mtrlRmrk}" class="text" style="width:100% ;" maxlength="100"/></td>
				        				<td class="c"><a href="javascript:void(0);" class="btn btn_i_del" id="btn_trDel" onclick="fnctrDel('${mtrlStatus.count }','mtrl');" ><span></span></a></td>
				        			</tr>
				        		</c:forEach>
				        	</c:when>
				        	<c:otherwise>
				        		<tr class="no_data" id="mtrlNodata">
				        			<td colspan="7">등록된 내역이 없습니다.</td>
				        		</tr>
				        	</c:otherwise>
				        </c:choose>			        	
				        </tbody>
				    </table>	
				</div>
				<h4 class="md_tit">지시 및 조치사항</h4>
				<div class="tbl_top prtv">
					<div class="tbl_left">
					<%-- <h4 class="md_tit"><c:out value="${thisYear}년 ${rptVO.monWeek }차 주간보고 (${rptVO.weekJobStartYmd } ~ ${rptVO.weekJobEndYmd })" /></h4> --%>
					</div>
					<div class="tbl_right">
						<div class="btn_area">
				   			<a href="javascript:void(0);" class="btn sml blue add_btn pt5" id="btn_actn" onclick="fncTrAdd('actn');" >추가<i class="xi-plus-circle-o"></i></a>
				    	</div>
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
				            <col style="width:26%;">
				            <col style="width:7%;">
				        </colgroup>
				        <thead>
				        	<tr>
				                <th scope="row" class="c pad_l0"><strong>번호</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>지시내용</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>지시일</strong></th>   
				                <th scope="row" class="c pad_l0"><strong>처리</strong></th>      
				                <th scope="row" class="c pad_l0"><strong>비고</strong></th>           
				                <th scope="row" class="c pad_l0"></th>                
				            </tr>
				        </thead>
				        <tbody id="tbodyActn">	
				        <c:choose>
					        <c:when test="${fn:length(actnList) gt 0 }">
					        	<c:forEach var="actn" items="${actnList }" varStatus="actnStatus">
				        			<tr id="actnTr_${actnStatus.count }">
				        				<input type="hidden" id="rptActnSn_${actnStatus.count }" value="${actn.rptActnSn }" />
				        				<th class="c pad_l0 actnCnt no_bdl">${actnStatus.count }</th>	
				        				<td><input type="text" id="instrCn_${actnStatus.count }" value="${actn.instrCn}" class="text" style="width:100% ;" maxlength="50"/></td>
										<td><span class="calendar_input w120"><input type="text" id="instrDt_${actnStatus.count }" value="${actn.instrDt}" class="text" /></span></td>
				        				<td class="c"><input type="text" id="actnGbn_${actnStatus.count }" value="${actn.actnGbn}" class="text" style="width:100% ;" maxlength="15"/></td>
				        				<td><input type="text" id="actnRmrk_${actnStatus.count }" value="${actn.actnRmrk}" class="text" style="width:100% ;" maxlength="80"/></td>
				        				<td class="c"><a href="javascript:void(0);" class="btn btn_i_del"  onclick="fnctrDel('${actnStatus.count }','actn');" ><span></span></a></td>
				        			</tr>
				        		</c:forEach>
				        	</c:when>
				        	<c:otherwise>
				        		<tr class="no_data" id="actnNodata">
				        			<td colspan="6">등록된 내역이 없습니다.</td>
				        		</tr>
				        	</c:otherwise>
				        </c:choose>			        	
				        </tbody>
				    </table>	
				</div>
				<div class="btn_area">
					<c:if test="${grpAuthId eq 'developer' }">
						<a href="javascript:void(0)" id="btn_updateProc" class="btn btn_mdl btn_rewrite" >저장</a>
				    </c:if>
				    <a href="#" id="btn_list" class="btn btn_mdl btn_list">취소</a>
				</div>
   			<div class="paging_wrap">
		</div>
    <span></span>
</form:form>
