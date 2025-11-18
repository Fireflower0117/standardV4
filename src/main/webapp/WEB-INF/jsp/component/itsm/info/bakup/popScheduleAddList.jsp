<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<td class="c">
	<select id="dbBackupDay">
		<c:forEach var="i" step="1" begin="1" end="31">
			<c:set var="formattedValue">
				<c:choose>
					<c:when test="${i < 10}">
						<c:set var="leadingZero">0</c:set>
						<c:out value="${leadingZero}${i}"/>
					</c:when>
					<c:otherwise>
						<c:out value="${i}"/>
					</c:otherwise>
				</c:choose>
			</c:set>
			<option value="${formattedValue}" ${dataTimerVO.dbBackupDay eq formattedValue ? 'selected="selected"' : '' }>
				<c:out value="${formattedValue}일"/>
			</option>
		</c:forEach>
		<option value="32" ${dataTimerVO.dbBackupDay eq '32' ? 'selected="selected"' : '' }>마지막날</option>
	</select>
</td>
<td class="c">
	<select id="dbBackupHour">
		<c:forEach var="i" step="1" begin="0" end="23">
			<c:set var="formattedValue">
				<c:choose>
					<c:when test="${i < 10}">
						<c:set var="leadingZero">0</c:set>
						<c:out value="${leadingZero}${i}"/>
					</c:when>
					<c:otherwise>
						<c:out value="${i}"/>
					</c:otherwise>
				</c:choose>
			</c:set>
			<option value="${formattedValue}" ${dataTimerVO.dbBackupHour eq formattedValue ? 'selected="selected"' : '' }>
				<c:out value="${formattedValue}시"/>
			</option>
		</c:forEach>
	</select>
</td>