<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="grpAuthId" value="${sessionScope.itsm_user_info.grpAuthId }"/>
<script type="text/javascript">
	$(document).ready(function(){
		prcsAll();
	})

	<%-- 처리상태 --%>
	function prcsAll(){
		let prcsLeng = "${fn:length(resultList)}"
		let prcsCnt = 0;
		let txt = "-";

		<c:if test="${fn:length(resultList) gt 0}">
			<c:forEach var="result" items="${resultList }" varStatus="status">
				<c:if test="${result.prcsCd eq 'PO03'}">
					prcsCnt += 1;
				</c:if>
			</c:forEach>
		</c:if>

		if(prcsLeng == prcsCnt){
			txt = "처리완료";

		}else if(prcsLeng > prcsCnt){
			if(prcsCnt > 0){
				txt = "처리중";
			}else{
				txt = "요청";
			}
		}

		$("#prcsAll").text(txt)
	}

	<%-- 회의록 바로가기 --%>
	function fncReport(serno){
		fncAjax("goReport.json", {"dmndSn" : serno, "menuCd" : "impFnc"}, "json", true, "", function(data){
			if(!data.serno){
				alert(data.msg);
			}else{
				fncPageBoard('view', '/itsm/svcReq/conferRec/view.do', data.serno, 'cofSn');
			}
		})
	}
</script>

<%--요청내용--%>
<div class="tbl_top">
	<div class="tbl_left"><h4 class="md_tit">요청내용</h4></div>
</div>
<input type="hidden" id="mngrTemp">
<div class="tbl_wrap">
	<table id="mng_table" class="board_row_type01">
		<caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
		<colgroup>
			<col style="width: 20%;">
			<col style="width: 8%;">
			<col>
			<col>
			<col style="width: 10%;">
		</colgroup>
		<thead>
		<tr>
			<th class="c" style="padding: 8px 25px 8px 25px;"><strong>메뉴</strong></th>
			<th class="c" style="padding: 8px 25px 8px 25px;"><strong>처리상태</strong></th>
			<th class="c" style="padding: 8px 25px 8px 25px;"><strong>요청내용</strong></th>
			<th class="c" style="padding: 8px 25px 8px 25px;"><strong>처리내용</strong></th>
			<th class="c" style="padding: 8px 25px 8px 25px;"><strong>회의록</strong></th>
		</tr>
		</thead>
		<tbody id="tbody_cnList">
			<c:choose>
				<c:when test="${fn:length(resultList) gt 0 }">
					<c:forEach var="result" items="${resultList }" varStatus="status">
						<tr id="tr_dmndCn_${status.index }">
							<td class="c" id="td_menuCd_${status.index }">
								<input type="hidden" id="dmndCnSn_${status.index}" value="${result.dmndCnSn}"/>
								<span><c:out value="${result.upMenuNm}"/><c:if test="${not empty result.upMenuNm}"> > </c:if><c:out value="${result.menuNm}"/></span>
							</td>
							<td class="c">
								<p class="${result.prcsCd eq 'PO01' ? 'rqu stt_dv' : result.prcsCd eq 'PO02' ? 'prg stt_dv' : result.prcsCd eq 'PO03' ? 'prc stt_dv' : '-' }">
									<c:out value="${empty result.prcsCdNm ? '-' : result.prcsCdNm }"/>
								</p>
							</td>
							<td class="l">
								<c:out value="${result.dmndCn}"/>
							</td>
							<%--처리내용--%>
							<td class="l">
								<c:choose>
									<c:when test="${not empty result.prcsCn}">
										<c:out value="${result.prcsCn}"/>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${grpAuthId eq 'developer'}">
												<c:choose>
													<c:when test="${empty searchVO.mngrSn}">
														<span style="color: lightgray;">개발 담당자를 먼저 배정해야 합니다.</span>
													</c:when>
													<c:otherwise>
														<input type="text" id="prcsCn_${status.index}" name="prcsCn" title="처리내용" class="text required" maxlength="1000" style="width:90%;"/>
														<a href="javascript:void(0)" class="btn btn_i_rewrite" title="등록" id="prcsCn_submit_${status.index}" onclick="fncPrcsSubmit('${status.index}');"><span></span></a>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<span style="color: lightgray;">처리대기 중인 요청건입니다.</span>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="c">
								<a href="javascript:void(0);" class="btn btn_sml btn_reply" onclick="fncReport('${result.dmndCnSn}')">${itsmImpFncVO.svcGbnNm}회의록</a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no_data">
						<td colspan="5">요청내용이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
