<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- 상세 일정 세팅 --%>
	cm_fncChangeDate();
	
	<%--  호출되면 선택되어있는 달_일로 보여주기 선택된 일이 마지막일보다 클 경우 마지막일로 --%>
	$("#date${searchVO.schEtc01}_${searchVO.schEtc00 >= lastDayOfMonth ? lastDayOfMonth : searchVO.schEtc00}").fadeIn();

	<%-- 달력 날짜 변경시 --%>
	$('.sch_sm td a:empty').css('cursor', 'default');
	$('.sch_sm td a:not(:empty)').click(function () {
		$('.sch_sm td a').removeClass('on');
	    $(this).addClass('on');
		
		<%-- 상세 일정 세팅 --%>
		cm_fncChangeDate();
	});
});
</script>

<div class="sch_sm_wrap">
    <div class="sch_box">
        <table class="sch_sm">
			<caption>축약형 목록</caption>
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
                    <th scope="col">일</th>
                    <th scope="col">월</th>
                    <th scope="col">화</th>
                    <th scope="col">수</th>
                    <th scope="col">목</th>
                    <th scope="col">금</th>
                    <th scope="col">토</th>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
		    		<%-- 시작일이 일요일이 아닌 경우 --%>
		    		<c:when test="${firstWeekdayOfMonth ne 7 }">
		    			<tr>
		    				<%-- 빈칸 삽입 --%>
							<c:forEach begin="1" end="${firstWeekdayOfMonth}" step="1">
								<td><a href="javascript:void(0);"></a></td>
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
						<a href="javascript:void(0);" data-id="#date${searchVO.schEtc02 }_${formattedDay}" <c:out value="${searchVO.schEtc00 eq formattedDay ? 'class=on' : '' }"/>><c:out value="${printDay }"/></a>
						<div class="points">
							<c:set var="personalCnt" value="0" />
							<c:set var="departmentCnt" value="0" />
							<c:set var="companyCnt" value="0" />
							<c:set var="meetingCnt" value="0" />
							<c:set var="directorCnt" value="0" />
							<c:forEach var="result" items="${resultList }">
								<%-- 날짜에 해당하는 컨텐츠 있을 경우 --%>
								<c:if test="${result.schdStrtYmd <= printDate and printDate <= result.schdEndYmd}">
									<c:if test="${result.schdClCd eq 'personal_work' and personalCnt < 1}">
										<c:set var="personalCnt" value="${personalCnt + 1 }"/>
										<span class="personal_work"></span>
									</c:if>
									<c:if test="${result.schdClCd eq 'department_work' and departmentCnt < 1}">
										<c:set var="departmentCnt" value="${departmentCnt + 1 }"/>
										<span class="department_work"></span>
									</c:if>
									<c:if test="${result.schdClCd eq 'company_work' and companyCnt < 1}">
										<c:set var="companyCnt" value="${companyCnt + 1 }"/>
										<span class="company_work"></span>
									</c:if>
									<c:if test="${result.schdClCd eq 'meeting' and meetingCnt < 1}">
										<c:set var="meetingCnt" value="${meetingCnt + 1 }"/>
										<span class="meeting"></span>
									</c:if>
									<c:if test="${result.schdClCd eq 'director_work' and directorCnt < 1}">
										<c:set var="directorCnt" value="${directorCnt + 1 }"/>
										<span class="director_work"></span>
									</c:if>
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
						<td><a href="javascript:void(0);"></a></td>
					</c:forEach>
				</c:if>
				</tr>
            </tbody>
        </table>
        <%-- 오늘 일정 --%>
	    <div class="sch_today">
	         <div class="date">Today<br><strong><c:out value="${fn:substring(searchVO.schEtc03, 5, 7) += '월 ' += fn:substring(searchVO.schEtc03, 8, 10) += '일'}"/> (금)</strong></div>
	         <div class="list_wrap">
	             <div class="tit">일정안내</div>
	             <div class="list" style="max-height: 88px;" data-simplebar data-simplebar-auto-hide="false">
	                 <ul>
	                 	<c:choose>
	                 		<c:when test="${fn:length(resultList) > 0 }">
			                 	<c:forEach var="result" items="${resultList }">
			                 		<c:if test="${searchVO.schEtc03 eq result.schdStrtYmd }">
				                 		<li><span class="<c:out value="${result.schdClCd }"/>"><c:out value="${result.schdStrtHhMn }"/></span><c:out value="${result.schdTitlNm }"/></li>
			                 		</c:if>
			                 	</c:forEach>
	                 		</c:when>
	                 		<c:otherwise>
			                     <li class="no_data">일정이 없습니다.</li>
	                 		</c:otherwise>
	                 	</c:choose>
	                 </ul>
	             </div>
	         </div>
	     </div>
	</div>
	<%-- 상세 일정 --%>
	<c:forEach var="printDay" begin="1" end="${lastDayOfMonth}" step="1" varStatus="status">
		<%-- 해당일 00 포맷팅 --%>
		<fmt:formatNumber var="formattedDay" value="${printDay}" pattern="00"/>
	   	<%-- 해당날짜 세팅 ex)2024.02.20 --%>
		<c:set var="printDate" value="${searchVO.schEtc01 }.${searchVO.schEtc02 }.${formattedDay }"/>
		<div class="sch_list display_none" id="date<c:out value="${searchVO.schEtc02 }"/>_<c:out value="${formattedDay}"/>" style="max-height: 490px;" data-simplebar data-simplebar-auto-hide="false">
			<c:set var="schdCnt" value="0" />
	        <ul>
				<c:forEach var="result" items="${resultList }">
					<c:if test="${result.schdStrtYmd <= printDate and printDate <= result.schdEndYmd}">
						<c:set var="schdCnt" value="${schdCnt + 1}" />
					    <li>
					        <span <c:out value="${result.schdEndYn eq 'Y' ? 'class=end' : ''}"/>><i class="xi-time-o"></i><c:out value="${result.schdStrtHhMn += ' ~ ' += result.schdEndHhMn }"/></span>
					        <div class="sch_detail cursor" data-serno="<c:out value="${result.schdSerno }"/>">
					            <strong class="no01"><c:out value="${result.schdTitlNm }"/></strong>
					            <p><c:out value="${result.schdCtt }"/></p>
					        </div>
					    </li>
					</c:if>
				</c:forEach>
				<c:if test="${fn:length(resultList) <= 0 or schdCnt eq 0}">
					<li class="no_data">일정이 없습니다.</li>
				</c:if>
			</ul>
		</div>
	</c:forEach>
</div>
