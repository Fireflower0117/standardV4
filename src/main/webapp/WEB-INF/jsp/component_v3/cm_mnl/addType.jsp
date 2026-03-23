<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:choose>
	<c:when test="${mnlItmClCd eq 'code' }">
		<tr>
			<th scope="row">HTML</th>
			<td colspan="3">
				<textarea id="htmlSrcdCtt_$idx$" title="HTML 소스코드"></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row">CSS</th>
			<td colspan="3">
				<textarea id="cssSrcdCtt_$idx$" title="CSS 소스코드"></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row">JS</th>
			<td colspan="3">
				<textarea id="jsSrcdCtt_$idx$" title="JS 소스코드"></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row">JAVA</th>
			<td colspan="3">
				<textarea id="javaSrcdCtt_$idx$" title="JAVA 소스코드"></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row">XML</th>
			<td colspan="3">
				<textarea id="xmlSrcdCtt_$idx$" title="XML 소스코드"></textarea>
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<tr>
			<th scope="row"><span class="asterisk">*</span>옵션</th>
			<td colspan="3">
				<c:choose>
					<c:when test="${mnlItmClCd eq 'title' }">
						<input type="text" id="titlNm_$idx$" class="w100p" title="제목" maxlength="30" required="true"/>
					</c:when>
					<c:when test="${mnlItmClCd eq 'subTitle' }">
						<input type="text" id="subTitlNm_$idx$" class="w100p" title="부제목" maxlength="30" required="true"/>
					</c:when>
					<c:when test="${mnlItmClCd eq 'ctt' }">
						<textarea id="dtlsCtt_$idx$" title="상세내용" required="true">
						</textarea>
					</c:when>
					<c:when test="${mnlItmClCd eq 'img' }">
						<div id="imgAtchFileUpload_$idx$"></div>
						<input type="hidden" id="atchFileId_$idx$"/>
					</c:when>
					<c:when test="${mnlItmClCd eq 'url' }">
						<input type="text" id="urlAddr_$idx$" class="w100p" title="URL주소" maxlength="300" required="true"/>
					</c:when>
				</c:choose>
			</td>
		</tr>
	</c:otherwise>
</c:choose>
