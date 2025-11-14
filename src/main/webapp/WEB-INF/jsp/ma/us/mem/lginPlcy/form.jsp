<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- 탈퇴계정 정보보유기간 selectBox 조회--%>
	fncCodeList('TRPU', 'select', '선택', '<c:out value="${lginPlcyVO.scssAccPssnPrdCd}"/>', '', 'scssAccPssnPrdCd');
	
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<%-- 등록,수정 처리 --%>
		$('#btn_submit').on('click', function(){
			if(wrestSubmit(document.defaultFrm)){
				fncProc("<c:out value='${empty lginPlcyVO.lginPlcySerno ? \'insert\' : \'update\'}'/>");
			}
		});
	</c:if>
});

</script>
<form:form modelAttribute="lginPlcyVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="lginPlcySerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="sidebyside">
    	<div class="left">
			<h4 class="md_tit"><c:out value="${empty lginPlcyVO.lginPlcySerno ? '정책관리등록' : '정책관리'}"/></h4>
		</div>
		<div class="right">
			<div class="board_top">
			    <div class="board_right">
			        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
			    </div>
			</div>
		</div>
	</div>
	<table class="board_write">
		<caption>내용(비밀번호변경주기, 탈퇴계정 정보보유기간, 로그인횟수 제한, 기본권한, 회원기본권한으로 구성)</caption>
		<colgroup>
			<col>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
		</colgroup>
		<tbody>
			<tr>
           		<th scope="col" colspan="2" class="c"><strong>비밀번호변경주기</strong></th>
           		<th scope="col" colspan="1" class="c"><strong>탈퇴계정 정보보유기간</strong></th>
           		<th scope="col" colspan="2" class="c"><strong>로그인횟수 제한(잠금기능)</strong></th>
           		<th scope="col" colspan="1" class="c"><strong>기본권한(비회원 사용자)</strong></th>
           		<th scope="col" colspan="1" class="c"><strong>회원기본권한(회원가입)</strong></th>
           	</tr>
			<tr>
				<td class="c">
	                <form:input path="pwdChgCyclDd" cssClass="w30p numOnly" title="비밀번호변경주기" maxlength="10"/><span>일</span>
	            </td>
	            <td class="c">
	            	<span class="asterisk">*</span>
	            	<form:select path="pwdChgCyclUseYn" cssClass="w30p" title="비밀번호변경주기 사용여부" required="true">
	            		<form:option value="Y" label="사용"/>
	            		<form:option value="N" label="미사용"/>
	            	</form:select>
	            </td>
	            <td class="c">
	            	<span class="asterisk">*</span>
	           		<form:select path="scssAccPssnPrdCd" title="탈퇴계정 정보보유기간" required="true"></form:select>
	            </td>
	            <td class="c">
	                <form:input path="lginLmtCnt" cssClass="w30p numOnly" maxlength="10"/><span>횟수</span>
	            </td>
	            <td class="c">
	            	<span class="asterisk">*</span>
	            	<form:select path="lginLmtUseYn" cssClass="w30p"  title="로그인횟수제한 사용여부" required="true">
	            		<form:option value="Y" label="사용"/>
	            		<form:option value="N" label="미사용"/>
	            	</form:select>
	            </td>
	            <td class="c">
	            	<span class="asterisk">*</span>
	                <form:select path="bascGrpAuthId" cssClass="w30p" title="기본권한">
	                    <c:forEach var="auth" items="${authList}" varStatus="status">
	                        <form:option value="${auth.grpAuthId}" label="${auth.grpAuthNm}"/>
	                    </c:forEach>
	                </form:select>
	            </td>
	            <td class="c">
	            	<span class="asterisk">*</span>
	            	<form:select path="mbrsBascGrpAuthId" cssClass="w30p" title="회원기본권한">
	                    <c:forEach var="auth" items="${authList}" varStatus="status">
	                        <form:option value="${auth.grpAuthId}" label="${auth.grpAuthNm}"/>
	                    </c:forEach>
	                </form:select>
	            </td>
			</tr>
		</tbody>
	</table>
	<h4 class="md_tit mar_t20"><c:out value="${searchVO.procType eq 'insert' ? '회원가입 정규표현식 등록' : '회원가입 정규표현식 관리'}"/></h4>
	<table class="board_write w390px">
		<caption>내용(적용할 항목, 정규표현식명으로 구성)</caption>
		<colgroup>
			<col class="w30p">
            <col>
		</colgroup>
		<tbody>
			<tr>
           		<th scope="col"><strong>적용할 항목</strong></th>
           		<th scope="col"><strong>정규표현식명</strong></th>
           	</tr>
			<tr>
                <th scope="row">아이디</th>
                <td>
                	<form:select path="regepsId" title="아이디 정규표현식">
                   		<form:option value="" label="미사용"/>
                   		<c:forEach items="${regepsList }" var="regeps" varStatus="status">
	                   		<form:option value="${regeps.regepsId }" label="${regeps.regepsId} (${regeps.regepsNm})"/>
                   		</c:forEach>
                   	</form:select>
                </td>
            </tr>
			<tr>
                <th scope="row">비밀번호</th>
                <td>
                	<form:select path="regepsPswd" title="비밀번호 정규표현식">
                   		<form:option value="" label="미사용"/>
                   		<c:forEach items="${regepsList }" var="regeps" varStatus="status">
                   			<form:option value="${regeps.regepsId }" label="${regeps.regepsId} (${regeps.regepsNm})"/>
                   		</c:forEach>
                   	</form:select>
                </td>
            </tr>
			<tr>
                <th scope="row">이메일</th>
                <td>
                	<form:select path="regepsEmail" title="이메일 정규표현식">
                   		<form:option value="" label="미사용"/>
                   		<c:forEach items="${regepsList }" var="regeps" varStatus="status">
                   			<form:option value="${regeps.regepsId }" label="${regeps.regepsId} (${regeps.regepsNm})"/>
                   		</c:forEach>
                   	</form:select>
                </td>
            </tr>
            <tr>
                <th scope="row">핸드폰번호</th>
                <td>
                	<form:select path="regepsPhone" title="핸드폰번호 정규표현식">
                   		<form:option value="" label="미사용"/>
                   		<c:forEach items="${regepsList }" var="regeps" varStatus="status">
                   			<form:option value="${regeps.regepsId }" label="${regeps.regepsId} (${regeps.regepsNm})"/>
                   		</c:forEach>
                   	</form:select>
                </td>
            </tr>
		</tbody>
	</table>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<button type="button" id="btn_submit" class="btn blue"><c:out value="${empty lginPlcyVO.lginPlcySerno ? '등록' : '수정'}"/></button>
	</c:if>
</div>
