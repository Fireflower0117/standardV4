<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<table class="sch_tbl">
	<caption>캘린더형 목록</caption>
    <colgroup>
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
            <th scope="col">일요일</th>
            <th scope="col">월요일</th>
            <th scope="col">화요일</th>
            <th scope="col">수요일</th>
            <th scope="col">목요일</th>
            <th scope="col">금요일</th>
            <th scope="col">토요일</th>
        </tr>
    </thead>
    <tbody>
    	<c:choose>
    		<%-- 시작일이 일요일이 아닌 경우 --%>
    		<c:when test="${firstWeekdayOfMonth ne 7 }">
    			<tr>
    				<%-- 빈칸 삽입 --%>
					<c:forEach begin="1" end="${firstWeekdayOfMonth}" step="1">
						<td><div><div></div></div></td>
					</c:forEach>
    		</c:when>
    		<c:otherwise>
    			<tr>
    		</c:otherwise>
    	</c:choose>
    	<%-- 시작일부터 마지막 일자까지 달력 생성 --%>
		<c:forEach var="printDay" begin="1" end="${lastDayOfMonth}" step="1" varStatus="status">
			<%-- 헤더 공백포함 총 갯수 --%>
			<c:set var="k" value="${printDay + firstWeekdayOfMonth}" />
	    	<%-- 해당일 00 포맷팅 --%>
			<fmt:formatNumber var="formattedDay" value="${printDay}" pattern="00"/>
	    	<%-- 해당날짜 세팅 ex)2024.02.20 --%>
			<c:set var="printDate" value="${searchVO.schEtc01 }.${searchVO.schEtc02 }.${formattedDay }"/>
			<td <c:out value="${searchVO.schEtc03 eq printDate ? 'class=today' : '' }"/>>
				<div>
					<%-- 한날에 들어갈 개수 카운트용 --%>
					<c:set var="schdCnt" value="0" />
					<%-- 더보기에 담길 html 용 --%>
					<c:set var="schdCtt" value="" />
					<%-- 휴일 정보 출력 --%>
					<c:set var="hdayYn" value="N" />
					<c:forEach var="result" items="${holidayList }">
						<c:if test="${result.hdayDt eq printDate }">
							<c:choose>
								<c:when test="${result.hdayYn eq 'Y' }">
									<c:set var="hdayYn" value="Y"/>
									<span class="red_txt"><c:out value="${result.hdayNm }"/></span>
								</c:when>
								<c:otherwise>
									<span><c:out value="${result.hdayNm }"/></span>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
					<%-- 날짜 출력 --%>
					<em class="<c:out value="${hdayYn eq 'Y' ? 'red_txt' : '' }"/>"><c:out value="${printDay }"/></em>
					<c:forEach var="result" items="${resultList }">
						<%-- 날짜에 해당하는 컨텐츠 있을 경우 --%>
						<c:if test="${result.schdStrtYmd <= printDate and printDate <= result.schdEndYmd}">
							<%-- 카운트 + 1 --%>
							<c:set var="schdCnt" value="${schdCnt + 1 }"/>
							<%-- 더보기값 세팅 --%>
							<c:set var="schdCtt" value="${schdCtt += '<dt><span>' += result.schdStrtHhMn += '</span></dt><dd><p data-serno=\"' += result.schdSerno += '\" data-cl=\"' += result.schdClCd += '\" style=\"cursor:pointer;\">' += result.schdTitlNm += '</p></dd>'}"/>
						</c:if>
						<%-- 날짜에 해당하는 컨텐츠 있을시 3개 이하인 경우에는 출력 --%>
						<c:if test="${schdCnt <= 3 and result.schdStrtYmd <= printDate and printDate <= result.schdEndYmd}">
							<div class="sch_txt" data-serno="<c:out value="${result.schdSerno }"/>">
								<span class="<c:out value="${result.schdClCd }"/>"><c:out value="${result.schdStrtHhMn }"/></span>
								<c:out value="${result.schdTitlNm }"/>
							</div>
						</c:if>
						<%-- 날짜에 해당하는 컨텐츠 4개 이상인 경우 더보기 아이콘 세팅 --%>
						<c:if test="${schdCnt > 3 }">
							<div class="sch-more"><span><i class="xi-ellipsis-h"></i></span></div>
							<div class="sch-floating-detail">
								<button type="button" name="button" class="close" style="right: 15px;top: 7px;"><i class="xi-close-min"></i> </button>
								<div data-scrollbar>
									<dl><c:out value="${schdCtt}" escapeXml="false"/></dl>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</td>
			<c:if test="${k % 7 == 0}">
				</tr>
				<tr>
			</c:if>
		</c:forEach>
		<%-- 마지막날부터 한주 끝까지  빈칸 삽입 시작 --%>
		<c:if test="${k % 7 != 0}">
			<%-- 토요일이 아닐 경우 빈칸 삽입 --%>
			<c:forEach begin="${k % 7}" end="6" step="1">
				<td><div><div></div></div></td>
			</c:forEach>
		</c:if>
		</tr>
    </tbody>
</table>
