<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/basic.css">
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- 일정시간코드 변경시 --%>
	const cm_fncChangeHhCd = function(val){
		if(val === 'all'){
			$("#schdStrtHh").val("00").prop("selected", true);
			$("#schdEndHh").val("00").prop("selected", true);
			$("#schdStrtMi, #schdEndMi").val("00").prop("selected", true);
			$("#schdStrtHh, #schdStrtMi, #schdEndHh, #schdEndMi").prop("disabled", true);
		} else if(val === 'work'){
			$("#schdStrtHh").val("09").prop("selected", true);
			$("#schdEndHh").val("18").prop("selected", true);
			$("#schdStrtMi, #schdEndMi").val("00").prop("selected", true);
			$("#schdStrtHh, #schdStrtMi, #schdEndHh, #schdEndMi").prop("disabled", true);
		} else{
			$("#schdStrtHh, #schdStrtMi, #schdEndHh, #schdEndMi").prop("disabled", false);
		}
	}
	<%-- 일정시간 검사 --%>
	const cm_fncChekTime = function(){
		const startYmd = $("#schdStrtYmd").val().replaceAll(".","");
		const endYmd = $("#schdEndYmd").val().replaceAll(".","");
		let start, end = 0;
		
		start = startYmd + $("#schdStrtHh").val() + $("#schdStrtMi").val();
		end = endYmd + $("#schdEndHh").val() + $("#schdEndMi").val();
		
		if (start > end) {
			alert("시작시간과 종료시간을 확인해주세요.");
			return false;
		}
		
		$('#schdStrtDt').val($("#schdStrtYmd").val() + ' ' + $("#schdStrtHh").val() + ':' + $("#schdStrtMi").val());
		$('#schdEndDt').val($("#schdEndYmd").val() + ' ' + $("#schdEndHh").val() + ':' + $("#schdEndMi").val());
		return true;
	}

	<%-- 일정 등록, 수정, 삭제 처리 --%>
	const cm_fncProc = function(procType){

		if (procType === 'insert'){
			procType = 'post';
		}else if (procType === 'update'){
			procType = 'patch';
		}else if (procType === 'delete'){
			$('#currentPageNo').val('1');
			procType = 'delete';
		}
		
		$.ajax({
			 type 		: procType
			,url 		: 'proc'
			,data 		: $('#popFrm').serialize()
			,dataType 	: 'json'
			,success 	: function(data) {
				alert(data.message);
				view_hide(1);
				<%-- 탭영역 addList --%>
				cm_fncAddList();
			}
			,error		: function (xhr, status, error) {
				<%-- 로그인 세션 없는 경우 --%>
				if (xhr.status == 401) {
			  		window.location.reload();
				}
				
				$('.error_txt').remove();
				let errors = xhr.responseJSON;
				
				<%-- 오류 메세지 출력 --%>
				if(procType === 'delete'){
					alert(errors[0].defaultMessage);
				}else{
					for (let i = 0; i < errors.length; i++) {
					    let e = errors[i];
					    $('#' + e.field).after('<p class="error_txt">' + e.defaultMessage + '</p>');
					}
				}
		    }
		    ,beforeSend : function(){
				fncLoadingStart();
			}
		    ,complete 	: function(){
		    	fncLoadingEnd();
				return false;
			}
		});
	}
	
	<%-- 일정 세팅 : 날짜 --%>
	fncDate("schdStrtYmd", "schdEndYmd");
	
	<%-- 일정구분코드 변경시 --%>
	$("[name='schdClCd']").on('change', function () {
		cm_fncSetMettingTr($(this).val());
	});
	
	<%-- 일정시간코드 변경시 --%>
	$('[name="schdHhCd"]').on('click', function(){
		cm_fncChangeHhCd($(this).val());
	});
	
	<%-- 일정 등록 클릭시 --%>
	$('#btn_submit_pop').on('click', function(){
		<%-- 일정 시간 체크 및 배열 재할당 --%>
		if(cm_fncChekTime()){
			if(wrestSubmit(document.popFrm)){
				fncProc('<c:out value="${searchVO.procType}"/>', $('#popFrm').serialize(), function(data){
					alert(data.message);
					view_hide(1);
					<%-- 탭영역 addList --%>
					cm_fncAddList();
				});
			}
		}
	});
	
	<c:if test="${not empty cmSchdVO.schdSerno}">
		<%-- 일정 삭제 클릭시 --%>
		$('#btn_delete').on('click', function(){
			fncProc('delete', $('#popFrm').serialize(), function(data){
				alert(data.message);
				view_hide(1);
				<%-- 탭영역 addList --%>
				cm_fncAddList();
			});
		});
	</c:if>
	
	$('.schdPop_close').on('click', function(){
		view_hide(2);
		view_hide(1);
	});
});
</script>
<div class="pop_header">
    <h2>일정 <c:out value="${empty cmSchdVO.schdSerno ? '등록' : '수정'}"/></h2>
    <button type="button" class="pop_close schdPop_close"><i class="xi-close-thin"></i>닫기</button>
</div>
<div class="pop_content" style="max-height: 700px;" data-simplebar data-simplebar-auto-hide="false">
	<form:form modelAttribute="cmSchdVO" id="popFrm" name="popFrm" method="post" onsubmit="return false;">
		<form:hidden path="schdSerno"/>
		<div class="board_top">
		    <div class="board_right">
		        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
		    </div>
		</div>
		<table class="board_write">
			<caption>내용(일정구분, 업무연계여부, 일정시간, 일정명, 일정내용으로 구성)</caption>
			<colgroup>
				<col class="w10p"/>
				<col/>
				<col class="w10p"/>
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="asterisk">*</span>일정구분</th>
					<td>
						<form:select path="schdClCd" title="일정구분" required="true">
							<form:option value="" label="선택"/>
							<form:option value="personal_work" label="개인업무"/>
							<form:option value="department_work" label="부서업무"/>
							<form:option value="company_work" label="회사업무"/>
							<form:option value="meeting" label="회의"/>
							<form:option value="director_work" label="경영진일정"/>
						</form:select>
					</td>
					<th scope="row"><span class="asterisk">*</span>업무연계</th>
					<td>
						<span class="chk">
						    <span class="radio"><form:radiobutton path="jobConYn" id="jobConYn_Y" title="업무연계" value="Y" required="true"/><label for="jobConYn_Y">예</label></span>
						    <span class="radio"><form:radiobutton path="jobConYn" id="jobConYn_N" title="업무연계" value="N" required="true" checked="true"/><label for="jobConYn_N">아니오</label></span>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="asterisk">*</span>일정시간</th>
					<td colspan="3">
						<form:hidden path="schdStrtDt" title="일정시작일시" required="true"/>
						<form:hidden path="schdEndDt" title="일정종료일시" required="true"/>
						<span class="calendar_input"><form:input path="schdStrtYmd" title="일정시작일" required="true" readonly="true"/></span>
						<select id="schdStrtHh" >
							<c:forEach begin="0" end="23" var="hh">
								<fmt:formatNumber var="strtHh" value="${hh}" pattern="00"/>
								<option value="<c:out value="${strtHh}"/>" <c:if test="${fn:split(cmSchdVO.schdStrtHhMn, ':')[0] eq strtHh}">selected</c:if>><c:out value="${hh}"/>시</option>
							</c:forEach>
						</select>
						<select id="schdStrtMi" >
							<c:forEach begin="0" end="5" var="mi">
								<fmt:formatNumber var="strtMi" value="${mi * 10}" pattern="00"/>
								<option value="<c:out value="${strtMi}"/>" <c:if test="${fn:split(cmSchdVO.schdStrtHhMn, ':')[1] eq strtMi}">selected</c:if>><c:out value="${strtMi}"/>분</option>
							</c:forEach>
						</select>
						<span class="gap">~</span>
						<span class="calendar_input"><form:input path="schdEndYmd" title="일정종료일" required="true" readonly="true"/></span>
						<select id="schdEndHh" >
							<c:forEach begin="0" end="23" var="hh">
								<fmt:formatNumber var="endHh" value="${hh}" pattern="00"/>
								<option value="<c:out value="${endHh}"/>" <c:if test="${fn:split(cmSchdVO.schdEndHhMn, ':')[0] eq endHh}">selected</c:if>><c:out value="${hh}"/>시</option>
							</c:forEach>
						</select>
						<select id="schdEndMi" >
							<c:forEach begin="0" end="5" var="mi">
								<fmt:formatNumber var="endMi" value="${mi * 10}" pattern="00"/>
								<option value="<c:out value="${endMi}"/>" <c:if test="${fn:split(cmSchdVO.schdEndHhMn, ':')[1] eq endMi}">selected</c:if>><c:out value="${endMi}"/>분</option>
							</c:forEach>
						</select>
						<span class="chk">
						    <span class="radio"><form:radiobutton path="schdHhCd" id="schdHhCd_input" title="일정시간코드" value="input" required="true" checked="true"/><label for="schdHhCd_input">직접입력</label></span>
						    <span class="radio"><form:radiobutton path="schdHhCd" id="schdHhCd_work" title="일정시간코드" value="work" required="true"/><label for="schdHhCd_work">업무시간</label></span>
						    <span class="radio"><form:radiobutton path="schdHhCd" id="schdHhCd_all" title="일정시간코드" value="all" required="true"/><label for="schdHhCd_all">하루종일</label></span>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="asterisk">*</span>일정명</th>
					<td colspan="3">
						<form:input path="schdTitlNm" class="w100p" title="일정명" maxlength="30" required="true"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="asterisk">*</span>일정내용</th>
					<td colspan="3">
						<form:textarea path="schdCtt" title="일정내용" required="true"/>
					</td>
				</tr>
			</tbody>
		</table>
    </form:form>
</div>
<div class="pop_footer">
    <button type="button" id="btn_submit_pop" class="btn blue"><c:out value="${empty cmSchdVO.schdSerno ? '등록' : '수정'}"/></button>
    <c:if test="${not empty cmSchdVO.schdSerno}"><button type="button" id="btn_delete" class="btn red">삭제</button></c:if>
</div>