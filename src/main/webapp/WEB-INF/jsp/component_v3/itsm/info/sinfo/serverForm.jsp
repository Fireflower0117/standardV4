<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "upload"));
});


</script>
<div class="tbl_top">
	<div class="tbl_left"><h4 class="sm_tit">${searchVO.serverGbn eq 'dev' ? '개발 서버 정보' : searchVO.serverGbn eq 'web' ? 'WEB 서버 정보' : searchVO.serverGbn eq 'was' ? 'WAS 서버 정보' :  searchVO.serverGbn eq 'db' ? 'DB 서버 정보' : '네트워크 정보' }</h4></div>
</div>
<div class="tbl_wrap">
	<table class="board_row_type01">
		<caption></caption>
		<colgroup>
			<col style="width:20%;">
			<col style="width:30%;">
			<col style="width:20%;">
			<col style="width:30%;">
		</colgroup>
		<tbody>
		<input type="hidden" name="svcServerSn" value="${serverVO.svcServerSn}"/>
		<c:choose>
			<c:when test="${searchVO.serverGbn eq 'net'}">
				<input type="hidden" name="atchFileId" id="atchFileId" value="${serverVO.atchFileId}">
				<tr>
					<th scope="row"><strong>출발지 IP</strong></th>
					<td><input placeholder="127.0.0.1" type="text" name="startIp" id="startIp" class="text" value="${serverVO.startIp}" maxlength="30"/> </td>
					<th scope="row"><strong>출발지 PORT</strong></th>
					<td><input placeholder="8080" type="text" name="startPort" id="startPort" class="text"  value="${serverVO.startPort}" maxlength="10"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>목적지 IP</strong></th>
					<td><input placeholder="127.0.0.1" type="text" name="endIp" id="endIp" class="text" value="${serverVO.endIp}" maxlength="30"/> </td>
					<th scope="row"><strong>목적지 PORT</strong></th>
					<td><input placeholder="8080" type="text" name="endPort" id="endPort" class="text"  value="${serverVO.endPort}" maxlength="10"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>서브넷 마스크</strong></th>
					<td colspan="3"><input placeholder="255.255.255.0" type="text" name="subnetMask" id="subnetMask" class="text" value="${serverVO.subnetMask}" maxlength="30"/> </td>
				</tr>
				<tr>
					<th scope="row"><strong>브로드 캐스트 주소</strong></th>
					<td colspan="3"><input placeholder="192.168.1.0" type="text" name="broadCast" id="broadCast" class="text" value="${serverVO.broadCast}" maxlength="30"/> </td>
				</tr>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
					<td colspan="3">
						<div id="atchFileUpload"></div>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<th scope="row"><strong>IP</strong></th>
					<td><input placeholder="127.0.0.1" type="text" name="serverIp" id="serverIp" class="text" value="${serverVO.serverIp}" maxlength="30"/> </td>
					<th scope="row"><strong>PORT</strong></th>
					<td><input placeholder="80" type="text" name="serverPort" id="serverPort" class="text"  value="${serverVO.serverPort}" maxlength="10"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>서버 디렉토리 경로</strong></th>
					<td colspan="3"><input placeholder="C:\folder\dlr\" type="text" name="serverPath" id="serverPath" class="text" value="${serverVO.serverPath}" maxlength="200"/> </td>
				</tr>
				<c:if test="${searchVO.serverGbn eq 'was' or searchVO.serverGbn eq 'web'}">
					<tr>
						<th scope="row"><strong>로그 경로</strong></th>
						<td colspan="3"><input placeholder="C:\folder\dlr\" type="text" name="serverLogPath" id="serverLogPath" class="text" value="${serverVO.serverLogPath}" maxlength="200"/> </td>
					</tr>
				</c:if>
				<tr>
					<th scope="row"><strong>OS</strong></th>
					<td colspan="3"><input pattern="WINDOWS 10 PRO" type="text" name="serverOs" id="serverOs" class="text" value="${serverVO.serverOs}" maxlength="30"/> </td>
				</tr>
				<tr>
					<th scope="row"><strong>RAM 용량</strong></th>
					<td><input type="text" name="serverRamVol" id="serverRamVol" class="text" value="${serverVO.serverRamVol}" maxlength="30"/> </td>
					<th scope="row"><strong>스토리지 용량</strong></th>
					<td ><input type="text" name="serverStrgVol" id="serverStrgVol" class="text" value="${serverVO.serverStrgVol}" maxlength="30"/> </td>
				</tr>
				<tr>
					<th scope="row"><strong>종류</strong></th>
					<td><input placeholder="${searchVO.serverGbn eq 'web' ? 'Apache' : searchVO.serverGbn eq 'was' ? 'JDK' : searchVO.serverGbn eq 'dev' ? 'JDK' : 'Oracle'}" type="text" name="serverType" id="serverType" class="text" value="${serverVO.serverType}" maxlength="30"/> </td>
					<th scope="row"><strong>버전</strong></th>
					<td><input placeholder="${searchVO.serverGbn eq 'web' ? 'Apache2 2.4' : searchVO.serverGbn eq 'was' ? '1.8' : '11g XE'}" type="text" name="serverVersion" id="serverVersion" class="text" value="${serverVO.serverVersion}" maxlength="30"/> </td>
				</tr>
				<c:if test="${searchVO.serverGbn eq 'db'}">
					<tr>
						<th scope="row"><strong>SID</strong></th>
						<td colspan="3"><input placeholder="orcl" type="text" name="serverSid" id="serverSid" class="text" value="${serverVO.serverSid}" maxlength="30"/> </td>
					</tr>
				</c:if>
				<c:if test="${searchVO.serverGbn eq 'dev'}">
					<tr>
						<th scope="row"><strong>IDE</strong></th>
						<td colspan="3"><input placeholder="sts-4.9.0.RELEASE" type="text" name="serverIde" id="serverIde" class="text" value="${serverVO.serverIde}" maxlength="30"/> </td>
					</tr>
				</c:if>
			</c:otherwise>
		</c:choose>

		</tbody>
	</table>
</div>
<div class="btn_area">
	<a href="javascript:void(0);" id="" class="btn btn_sml btn_save" onclick="serverSubmit()">수정</a>
</div>

