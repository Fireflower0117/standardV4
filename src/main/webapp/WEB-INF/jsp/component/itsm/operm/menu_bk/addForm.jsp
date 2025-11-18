<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">	
$(document).ready(function(){
	<%-- menuUrlAddr 스플릿후 URL 고정 text,input 분리--%>
	const fncMenuUrlAddrSplit = function(){
		var menuUrlAddr = $("#menuUrlAddrHidden").val();
		if( menuUrlAddr != null && menuUrlAddr != ""){
			<%-- URL 규칙과 다르게 URL이 입력된 경우 그냥 보여주기--%>		
			if(menuUrlAddr.indexOf("/") == -1){
				$("#menuUrlAddrView").val(menuUrlAddr);
				return false;
			}else{
				<%-- URL 규칙에 따라 '/'로 잘라서 text,input에 붙이기--%>	
				var cnt = Number($("#menuLvl").val())+2;
				var urlArr = menuUrlAddr.split("/", cnt);
				var urlCont = menuUrlAddr.split("/")[cnt];
				var createUrl ="";
				for(var i = 1; i < urlArr.length; i++){
					createUrl += "/" + urlArr[i];
					if(i == (urlArr.length - 1)){
						createUrl += "/";  
					}
				}
				var resultUrl = createUrl.trim();
				$("#menuUrlAddr_span").text(resultUrl);
				$("#menuUrlAddrHidden").val(resultUrl);
				$("#menuUrlAddrView").val(urlCont);
				$("#menuUrlAddrView").attr("style", "width:50%!important;");
			}
		}
	}
	
	<%-- 하위메뉴가 없고, menuUrlAddr이 있고, 유형이 개별일때만 실행 --%>
	<c:if test="${menuVO.isLeaf eq 0 and not empty menuVO.menuUrlAddr}">
		<%-- menuUrlAddr 스플릿후 URL 고정 text,input 분리 --%>
		fncMenuUrlAddrSplit();	
	</c:if>
	
	<%-- 쓰기 권한이 있을때만 --%>
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<%-- 중복검사 check변수 설정 --%>
		var menuDuplCheck;
		if("<c:out value='${menuVO.menuCd}'/>" == null || "<c:out value='${menuVO.menuCd}'/>" == ""){
			menuDuplCheck = false;
		}else{
			menuDuplCheck = true;
		};
		
		<%-- 중복검사나 메뉴유형 변경시 url 세팅 --%>
		const fncUrlSet = function(){
		
			var baseUrl;
			var addUrl = "";
			<%-- 중복검사가 된 경우에만 메뉴코드 세팅--%>
			var menuCd = menuDuplCheck ? $("#menuCd").val() : '';

			<%-- 메뉴lvl이 0이 아니고 메뉴중복검사가 된 경우에만 상위메뉴값 세팅--%>
			if($("#menuLvl").val() != "0" && menuCd != ""){
				baseUrl = $("#menuUrlAddrHidden").val();
			<%-- 메뉴코드 중복검사한 경우만 세팅--%>
			}else if(menuCd != ""){
				baseUrl = "/";
			}else{
				baseUrl = "";
			}

			<%-- 메뉴코드 중복검사한 경우만 세팅--%>
			if(menuCd != ""){
				addUrl = "/";
			}else{
				addUrl = "";
			}
			
			$("#menuUrlAddr_span").text(baseUrl + menuCd + addUrl);
		};

		<%-- 메뉴코드 중복검사--%>
		const itsmFncMenuCdDuplCheck =function(){
			return $.ajax({
				 method : "POST"
				,url : 'menuCdDuplCheck'
				,data : $('#defaultFrm').serialize()
				,dataType : 'json'
				,error: function (xhr, status, error) {
					if (xhr.status == 401) {
					  	window.location.reload();
					 }
					 alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			    }
			});
		}
		
		<%-- form 등록 --%>
		$('#btn_menu_submit').on('click', function(){
			if(menuDuplCheck == true){
				var procType = "<c:out value='${empty menuVO.menuCd ? \'insert\' : \'update\'}'/>";

				<%--유효성검사 후 submit --%>
				if(wrestSubmit(document.defaultFrm)){
					fncProcAjax(procType);
				}
			}else{
				alert("메뉴코드 중복검사를 해주세요.")
				$("#menuCd").focus();
			}
		});
		
		<%-- menu 삭제 --%>
		$('#btn_menu_delete').on('click', function(){
			if(confirm("삭제 하시겠습니까?")){
				if(wrestSubmit(document.defaultFrm)){
					fncProcAjax('delete');
				}
			}
		});
		
		<%-- menuCd 중복검사--%>
		$('#menu_dupl_check').on('click', function(){
			if(!$("#menuCd").val() != ""){
				alert("메뉴코드 입력후 중복검사를 해주세요.")
				$("#menuCd").focus();
			}else{
				itsmFncMenuCdDuplCheck().done(function(data){
					<%-- 중복검사 후 일치하면 false--%>
					if(data.check > 0){
						$("#menu_dupl_check").addClass("bd");
						var html = "중복검사"
						$("#menu_dupl_check").html(html)
						menuDuplCheck = false;
						alert("중복된 메뉴코드입니다.")	
						$("#menuCd").focus();
					}else{
						<%-- 중복검사 후 일치하지 않으면 true--%>
						$("#menu_dupl_check").removeClass("bd");
						var html = "확인 &nbsp;<i class='xi-check-circle'></i>"
						$("#menu_dupl_check").html(html)
						menuDuplCheck = true;
						<%-- 입력한 menuCd를 url에 세팅--%>
						fncUrlSet();
						$("#menuUrlAddrView").removeClass("w100p");
						$("#menuUrlAddrView").addClass("w50p");
						var inputUrl = $("#menuUrlAddrView").val();
						if(inputUrl == null || inputUrl == ""){
							$("#menuUrlAddrView").val("list.do");
						}
					}
				});	
			}
		});
	
		<%-- menuCd 입력감지시 중복검사 reset --%>
		$('#menuCd').on('input', function(){
			$("#menu_dupl_check").addClass("bd");
			$("#menu_dupl_check").html("중복검사")
			menuDuplCheck = false;
		});

		<%-- 메뉴코드는 영문,숫자, _ 만 가능--%>
		$('.menuInputCheck').on('input', function(){
			this.value=this.value.replace(/[^a-zA-Z0-9\\_]/g,'');
		});
	</c:if>
	
});
</script>
<form:form modelAttribute="menuVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;"> 
	<input type="hidden" name="editrCont" id="editrContSave"/>
	<div class="board_top">
		<div class="board_left">
			<i class="ic power"></i>
			<c:choose>
				<c:when test="${sessionScope.SESSION_WRITE_BTN_KEY }">
			        등록/수정
				</c:when>
				<c:otherwise>
				     상세보기
				</c:otherwise>
			</c:choose>
		</div>
		<div class="board_right">
			<div class="form_guide"><span class="asterisk">*</span>필수입력</div>
		</div>
	</div>
	<table class="board_write">
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/> 
			<col/>
		</colgroup>
		<tbody style="<c:out value="${sessionScope.SESSION_WRITE_BTN_KEY ? '' : 'display : none'}"/>"> 
			<tr>
				<th scope="row"><span class="asterisk">*</span>상위 메뉴코드</th>
				<td>
					<span id="uprMenuCd_span">
							<c:out value="${not empty menuVO.uprMenuCd ? menuVO.uprMenuCd : '-'}"/>						
					</span>
					<input type="hidden" name="menuCl" id="menuCl" title="메뉴 구분" class="w100p" value="<c:out value="${not empty menuVO.uprMenuCd ? menuVO.uprMenuCd : ''}"/>"/>
					<form:hidden path="uprMenuCd" id="uprMenuCd" title="상위 메뉴코드" cssClass="w100p"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>메뉴코드</th>
				<td>
					<c:choose>
						<c:when test="${not empty menuVO.menuCd}">
							<c:out value="${menuVO.menuCd}"/>
							<form:hidden path="menuCd" id="menuCd" title="메뉴코드" required="true"/>
						</c:when>
						<c:otherwise>
							<form:input path="menuCd" id="menuCd" title="메뉴코드" cssClass="w64p menuInputCheck" maxlength="20" required="true"/>
							<button type="button" class="btn bd blue" id="menu_dupl_check">중복검사</button>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>단계</th>
				<td>
					<c:choose>
						<c:when test="${not empty menuVO.menuLvl}">
							<c:out value="${menuVO.menuLvl}"/>
						</c:when>
						<c:otherwise>
							<span id="menuLvl_span">
								0
							</span>
						</c:otherwise>
					</c:choose>
					<input type="hidden" name="menuLvl" id="menuLvl" title="메뉴레벨" value="<c:out value="${not empty menuVO.menuLvl ? menuVO.menuLvl : '0'}"/>"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>순서</th>
				<td>
					<c:choose>
						<c:when test="${not empty menuVO.menuSeqo}">
							<c:out value="${menuVO.menuSeqo}"/>
						</c:when>
						<c:otherwise>
							<span id="menuSeqo_span">
							0
							</span>
						</c:otherwise>
					</c:choose>
					<input type="hidden" name="menuSeqo" id="menuSeqo" title="순서" value="<c:out value="${not empty menuVO.menuSeqo ? menuVO.menuSeqo : '0'}"/>"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>메뉴명</th>
				<td>
					<form:input path="menuNm" id="menuNm" title="메뉴명" cssClass="w100p" maxlength="30" required="true"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>노출여부</th>
				<td>
					<span class="chk">
						<span class="radio"><form:radiobutton path="expsrYn" id="expsrYn_Y" title="노출여부" value="Y" required="true" checked="true"/><label for="expsrYn_Y">노출</label></span>
				    	<span class="radio"><form:radiobutton path="expsrYn" id="expsrYn_N" title="노출여부" value="N" required="true"/><label for="expsrYn_N">미노출</label></span>
				    </span>
				</td>
			</tr>
			<tr>
				<th scope="row">URL</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${menuVO.isLeaf eq 1}">
							-
						</c:when>
							<c:otherwise>
							<span id="menuUrlAddr_span">
							</span>
							<form:hidden path="menuUrlAddr" id="menuUrlAddrHidden" title="URL"/>
							<input type="text" id="menuUrlAddrView" title="URL" class="w100p mar_l0" maxlength="50"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>새창열기</th>
				<td>
					<span class="chk">
						<span class="radio"><form:radiobutton path="tgtBlankYn" id="tgtBlankYn_A" title="새창열기"  value="A" required="true" checked="true"/><label for="tgtBlankYn_A">현재창</label></span>
						<span class="radio"><form:radiobutton path="tgtBlankYn" id="tgtBlankYn_B" title="새창열기"  value="B" required="true"/><label for="tgtBlankYn_B">새창</label></span>
					</span>
				</td>
				<th scope="row" class="view_yn"><span class="asterisk">*</span>하위탭여부</th>
				<td>
					<span class="chk">
						<span class="radio"><form:radiobutton path="lwrTabYn" id="lwrTabYn_N" title="하위탭여부" value="N" required="true" checked="true"/><label for="lwrTabYn_N">미사용</label></span>
						<span class="radio"><form:radiobutton path="lwrTabYn" id="lwrTabYn_Y" title="하위탭여부" value="Y" required="true"/><label for="lwrTabYn_Y">사용</label></span>
					</span>
				</td>
			</tr>
			<tr>
				<th scope="row">설명</th>
				<td colspan="3">
					<form:textarea path="menuExpl" id="menuExpl" title="설명" rows="2"/>
				</td>
			</tr>
		</tbody>
		<tbody style="<c:out value="${sessionScope.SESSION_WRITE_BTN_KEY ? 'display : none' : ''}"/>"> 
			<tr>
				<th scope="row">상위 메뉴코드</th>
				<td>
					<c:out value="${not empty menuVO.uprMenuCd ? menuVO.uprMenuCd : '-'}"/>						
				</td>
				<th scope="row">메뉴코드</th>
				<td>
					<c:out value="${not empty menuVO.menuCd ? menuVO.menuCd : '-'}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">단계</th>
				<td>
					<c:out value="${not empty menuVO.menuLvl ? menuVO.menuLvl : '0'}"/>
				</td>
				<th scope="row">순서</th>
				<td>
					<c:out value="${not empty menuVO.menuSeqo ? menuVO.menuSeqo : '0'}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">메뉴명</th>
				<td>
					<c:out value="${not empty menuVO.menuNm ? menuVO.menuNm : '-'}"/>
				</td>
				<th scope="row">노출여부</th>
				<td>
					<span class="chk">
						<span class="radio"><input type="radio" title="노출여부" disabled="disabled" <c:out value="${menuVO.expsrYn eq 'Y' ? 'checked=checked' : ''}"/>/><label>노출</label></span>
				    	<span class="radio"><input type="radio" title="노출여부" disabled="disabled" <c:out value="${menuVO.expsrYn eq 'N' ? 'checked=checked' : ''}"/>/><label>미노출</label></span>
				    </span>
				</td>
			</tr>
			<tr>
				<th scope="row">URL</th>
				<td colspan="3">
					<c:out value="${menuVO.isLeaf eq 1 ? '-' : menuVO.menuUrlAddr }"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>새창열기</th>
				<td>
					<span class="chk">
						<span class="radio"><input type="radio" title="새창열기" disabled="disabled" <c:out value="${menuVO.tgtBlankYn eq 'A' ? 'checked=checked' : ''}"/>/><label>현재창</label></span>
						<span class="radio"><input type="radio" title="새창열기" disabled="disabled" <c:out value="${menuVO.tgtBlankYn eq 'B' ? 'checked=checked' : ''}"/>/><label>새창</label></span>
					</span>
				</td>
				<th scope="row" class="view_yn"><span class="asterisk">*</span>하위탭여부</th>
				<td>
					<span class="chk">
						<span class="radio"><input type="radio" title="하위탭여부" disabled="disabled" <c:out value="${menuVO.lwrTabYn eq 'Y' ? 'checked=checked' : ''}"/>/><label>미사용</label></span>
						<span class="radio"><input type="radio" title="하위탭여부" disabled="disabled" <c:out value="${menuVO.lwrTabYn eq 'N' ? 'checked=checked' : ''}"/>/><label>사용</label></span>
					</span>
				</td>
			</tr>
			<tr>
				<th scope="row">설명</th>
				<td colspan="3">
					<textarea title="설명" rows="2"><c:out value="${not empty menuVO.menuExpl ? menuVO.menuExpl : '-'}"/></textarea>
				</td>
			</tr>
		</tbody>
		
		
	</table>
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY }">
		<div class="btn_area">
			<a href="javascript:void(0)" id="btn_menu_submit" class="btn blue"><c:out value="${empty menuVO.menuCd ? '등록' : '수정'}"/></a> 
			<c:if test="${not empty menuVO.menuCd}">
				<a href="javascript:void(0)" id="btn_menu_delete" class="btn red">삭제</a>
			</c:if>
		</div>	
	</c:if>
</form:form>

