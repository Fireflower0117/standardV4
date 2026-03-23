<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<div class="pop_header">
	<h2><c:out value="${searchVO.rptdTtl}"/></h2>
	<button type="button" class="pop_close" onclick="view_hide(1);"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="overflow-y: auto;max-height: 800px;">
	<h3 class="rpt_tit"><span>서비스 수준 평가표</span></h3>

	<h4 class="md_tit">대상기간</h4>
	<div class="rpt_date"><c:out value="${resultList[0].schEtc01} ~ ${resultList[0].schEtc02}"/></div>

	<h4 class="md_tit" style="margin-top: 40px;">종합평가</h4>
	<div class="tbl_wrap">
		<table class="tbl_col_type02">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">평가등급</th>
				<th scope="col" class="total90">A(우수)</th>
				<th scope="col" class="total80">B(양호)</th>
				<th scope="col" class="total70">C(보통)</th>
				<th scope="col" class="total60">D(미흡)</th>
				<th scope="col" class="total59">F(매우 미흡)</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>종합평가점수</td>
				<td class="total90">90~100</td>
				<td class="total80">80~89</td>
				<td class="total70">70~79</td>
				<td class="total60">60~69</td>
				<td class="total59">59점 이하</td>
			</tr>
			</tbody>
		</table>
	</div>


	<div class="tbl_top">
		<div class="tbl_left"><h4 class="md_tit">SLA 항목별 평가</h4></div>
		<div class="tbl_right">(측정기준: 월)</div>
	</div>
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
			</colgroup>
			<thead>
			<tr>
				<th scope="col" rowspan="2">항목</th>
				<th scope="col" colspan="3" rowspan="2">세부지표</th>
				<th scope="col" rowspan="2">배점</th>
				<th scope="col" rowspan="2">지표구분</th>
				<th scope="col" colspan="2">평가결과</th>
			</tr>
			<tr>
				<th scope="col">측정결과</th>
				<th scope="col">평가점수</th>
			</tr>
			</thead>
			<tbody>
				<c:set var="total" value="0"/>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:choose>
						<c:when test="${result.msrmtCnt ne 0 and result.msrmtTrgtCnt ne 0}">
							<c:set var="msrmtRslt" value="${(result.msrmtCnt/result.msrmtTrgtCnt)*100}"/>
							<c:set var="evlScor" value="${result.itmScrng * msrmtRslt / 100}"/>
						</c:when>
						<c:otherwise>
							<c:set var="msrmtRslt" value="100"/>
							<c:set var="evlScor" value="${result.itmScrng}"/>
						</c:otherwise>
					</c:choose>
					<c:set var="total" value="${total + evlScor}"/>
					<c:if test="${status.last}">
						<script>
							let total = Number('${total}')
							if(total >= 90){
								$(".total90").addClass('rpt_on')
							}else if(total >= 80){
								$(".total80").addClass('rpt_on')
							}else if(total >= 70){
								$(".total70").addClass('rpt_on')
							}else if(total >= 60){
								$(".total60").addClass('rpt_on')
							}else if(total < 60){
								$(".total50").addClass('rpt_on')
							}
						</script>
					</c:if>
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
							<c:out value="${result.itmCn}"/>
						</td>
						<td>
							<c:out value="${result.itmScrng}"/>
						</td>
						<td>
							<c:out value="${result.idxiSeNm}"/>
						</td>
						<td>
							<fmt:formatNumber value="${msrmtRslt }" pattern="#,###.#" />%
						</td>
						<td>
							<fmt:formatNumber value="${evlScor }" pattern="#,###.#" />
						</td>
					</tr>
				</c:forEach>
				<tr class="point">
					<th scope="row" colspan="7">계</th>
					<td style="font-weight: 900;">
						<fmt:formatNumber value="${total }" pattern="#,###.#" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</div>
<script type="text/javaScript">
$(document).ready(function(){
	
});
</script>