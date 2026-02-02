<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">	
$(document).ready(function(){
	<%-- menuUrlAddr 스플릿후 URL 고정 text,input 분리--%>
	const fncMenuUrlAddrSplit = function(){
		var menuUrlAddr = $("#menu_url_addr_hidden").val();
		if( menuUrlAddr != null && menuUrlAddr != ""){
			<%-- URL 규칙과 다르게 URL이 입력된 경우 그냥 보여주기--%>		
			if(menuUrlAddr.indexOf("/") == -1){
				$("#menu_url_addr_input").val(menuUrlAddr);
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
				$("#menu_url_addr_span").text(resultUrl);
				$("#menu_url_addr_hiden").val(resultUrl);
				$("#menu_url_addr_input").val(urlCont);
				$("#menu_url_addr_input").attr("style", "width:60%!important;");
			}
		}
	}
	
	<%-- 하위메뉴가 없고, menuUrlAddr이 있고, 유형이 개별일때만 실행 --%>
	<c:if test="${menuVO.isLeaf eq 0 and not empty menuVO.menuUrlAddr and menuVO.menuTpCl eq 'A'}"> 
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
		
		<%-- 컨텐츠 form 불러오기 --%>
		const fncContTmplForm = function(){
			<%-- 이미 불러낸 addContTmpl이 없을때만 실행 --%>
			if(!$.contains(document.body, document.getElementById("defaultFrmTmpl"))){
				$.ajax({ method: "POST",  
					 data : {contSerno : $("#contSerno").val(),menuCd : $("#menuCd").val(), menuTpCl : $("#menuTpCl").val() }, 
					 url: "addContTmpl",  
					 dataType: "HTML", 
					 success : function(data) {
						 <%-- 컨텐츠 작성폼 생성 --%>			  
						 $("#addContTmpl").html(data);
						 <%-- menuForm 가리고 addContForm 보여주기 --%>
						 $("#addForm").css("display","none");
						 $("#addContTmpl").css("display","inline-block");
					 },error : function(xhr, status, error){
						 if (xhr.status == 401) {
							window.location.reload();
						 }
						 alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
					 }
				 });
			}else{
				<%-- menuForm 가리고 addContTmplForm 보여주기 --%>
				$("#addForm").css("display","none");
				$("#addContTmpl").css("display","inline-block");
				
				CKEDITOR.instances.editrCont.setData($("#editrContSave").val());
			}
		}

		<%-- 중복검사나 메뉴유형 변경시 url 세팅 --%>
		const fncUrlSet = function(){
		
			var baseUrl;
			var addUrl = "";
			var menuTpCl = $("#menuTpCl").val();
			<%-- 중복검사가 된 경우에만 메뉴코드 세팅--%>
			var menuCd = menuDuplCheck ? $("#menuCd").val() : '';

			<%-- 메뉴lvl이 0이 아니고 메뉴중복검사가 된 경우에만 상위메뉴값 세팅--%>
			if($("#menuLvl").val() != "0" && menuCd != ""){
				baseUrl = $("#menu_url_addr_hidden").val();
			<%-- 메뉴코드 중복검사한 경우만 세팅--%>
			}else if(menuCd != ""){
				baseUrl = "/";
			}else{
				baseUrl = "";
			}
			<%-- 게시판 유형 게시판인 경우 list.do 세팅--%>
			if(menuTpCl == 'B' ){
				addUrl = "/list.do";
			<%-- 게시판 유형 컨텐츠인 경우 cont.do 세팅--%>
			}else if(menuTpCl == 'C'){
				addUrl = "/cont.do";
			<%-- 메뉴코드 중복검사한 경우만 세팅--%>
			}else if(menuCd != ""){
				addUrl = "/";
			}else{
				addUrl = "";
			}
			
			$("#menu_url_addr_span").text(baseUrl + menuCd + addUrl);
		};

		<%-- 메뉴코드 중복검사--%>
		const fncMenuCdDuplCheck =function(){
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
				<%-- insert 일때 유형이 컨텐츠이고 에디터 내용이 입력 안되면 return false--%>
				if(procType == 'insert' && $("#menuTpCl").val() == 'C' && $("#editrCont").val() == null){
					alert("유형이 컨텐츠일 경우 컨텐츠 등록 버튼을 통해 메뉴 내용을 입력해주세요.")
					$("#btn_conttmpl_modify").focus();
					return false;
				}
				<%--유효성검사 후 submit --%>
				if(wrestSubmit(document.defaultFrm)){
					
					if(procType == "insert"){
						<%-- lvl이 0일때 상위메뉴구분에 자신의 menuCd 넣기 --%>
						if($("#menuLvl").val() == "0"){
							$("#menuCl").val($("#menuCd").val());
						}
					}
					<%-- menuUrlAddr 재조립 --%>
					var menuHead = $("#menu_url_addr_span").text();
					var menuCont = $("#menu_url_addr_input").val();
					<%-- 유형이 개별일때만 input에 입력받는 내용 조립 --%>
					if($("#menuTpCl").val() == "A"){
						$("#menu_url_addr_hidden").val(menuHead + menuCont);
					}else{
						$("#menu_url_addr_hidden").val(menuHead);
					}
					
					fncProc(procType,$('#defaultFrm').serialize(),function(data){
						alert(data.message);			
						<%-- onsubmit 속성 삭제 --%>
						$("#defaultFrm").removeAttr("onsubmit");
						<%-- 폼 속성 설정 및 제출 --%>		
						fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');	
					})
				}
			}else{
				alert("메뉴코드 중복검사를 해주세요.")
				$("#menuCd").focus();
			}
		});
		
		<%-- menu 삭제 --%>
		$('#btn_menu_delete').on('click', function(){
			if(wrestSubmit(document.defaultFrm)){
				fncProc("delete",$('#defaultFrm').serialize(),function(data){
					alert(data.message);			
					<%-- onsubmit 속성 삭제 --%>
					$("#defaultFrm").removeAttr("onsubmit");
					<%-- 폼 속성 설정 및 제출 --%>		
					fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');	
				})
			}
		});
		
		<%-- menuCd 중복검사--%>
		$('#menu_dupl_check').on('click', function(){
			if(!$("#menuCd").val() != ""){
				alert("메뉴코드 입력후 중복검사를 해주세요.")
				$("#menuCd").focus();
			}else{
				fncMenuCdDuplCheck().done(function(data){
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
						$("#menu_url_addr_input").removeClass("w100p");
						$("#menu_url_addr_input").addClass("w60p");
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
	
		<%-- 유형구분 변경시 실행 --%>
		$('#menuTpCl').on('change', function(){
			<%-- 게시판유형선택 초기화--%>
			$("#bltnbCl").val('');
			$("#bltnbCl").prop("disabled", true);
			$("#bltnbCl").attr("required", false);	
			$("#bltnbCl").removeClass("disno");
			<%-- 컨텐츠 등록버튼 숨기기 --%>
			$("#btn_conttmpl_modify").addClass("disno");
			<%-- url 초기화 --%>
			$("#menu_url_addr_input").removeClass("disno");
			<%-- url 세팅 --%>
			fncUrlSet();
			
			if($("#menuTpCl").val() == ""){
				$("#menu_url_addr_input").val("");
			<%-- 유형이 개병일 경우 list.do default --%>
			}else if($("#menuTpCl").val() == 'A'){
				$("#menu_url_addr_input").val("list.do");
			<%-- 유형이 게시판일 경우 게시판 유형 선택 활성화--%>			
			}else if($("#menuTpCl").val() == 'B'){
				$("#menu_url_addr_input").addClass("disno");
				$("#bltnbCl").prop("disabled", false);	
				$("#bltnbCl").attr("required", true);	
			<%-- 유형이 컨텐츠일 경우 addContTmplForm 호출 --%>
			}else if($("#menuTpCl").val() == 'C'){
				$("#menu_url_addr_input").addClass("disno");
				$("#bltnbCl").addClass("disno");
				<%-- 컨텐츠 등록 버튼 노출 --%>
				$("#btn_conttmpl_modify").removeClass("disno");
			}
		});
	
		<%-- 컨텐츠 수정폼 생성--%>
		 $("#btn_conttmpl_modify").on("click", function() {
			fncContTmplForm();
		});
	
		<%-- 메뉴코드는 영문,숫자, _ 만 가능--%>
		$('.menuInputCheck').on('input', function(){
			this.value=this.value.replace(/[^a-zA-Z0-9\\_]/g,'');
		});
	</c:if>
	
	<%-- 메뉴의 하위메뉴가 없을때만 --%>
	<c:if test="${menuVO.isLeaf ne 1}">
		<%-- 메뉴코드 복사 --%>
		$('#menu_url_copy').on('click', function(){
			copyToClipBoard();
		});
		
		<%-- 클립보드 복사 --%>
		const copyToClipBoard = function(text) {
		    var content = "";
		    if($('#menu_url_addr_span').length){
			    content += $('#menu_url_addr_span').text();	    	
		    }
		    if(content.indexOf(".do") == -1 && $('#menu_url_addr_input').length){
		    	content += $('#menu_url_addr_input').val();
		    }
		    console.log(content)
		    if(content.trim() == ""){
		    	alert("복사할수 있는 URL이 없습니다.");
		    	return false;
		    }
			var textArea = document.createElement('textarea');
			document.body.appendChild(textArea);
			textArea.value = content.trim();
			textArea.select();
		    document.execCommand('copy');
		    document.body.removeChild(textArea);
		    
		    alert("URL이 복사되었습니다.")
		}
	</c:if>
	
});
</script>
<form:form modelAttribute="menuVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;"> 
	<form:hidden path="contSerno" />
	<input type="hidden" name="editrCont" id="editrContSave"/>
	<div class="board_top">
		<div class="board_left">
			<i class="ic power"></i>
			<c:out value="${sessionScope.SESSION_WRITE_BTN_KEY ? '등록/수정' : '상세보기'}"/>
		</div>
		<div class="board_right">
			<div class="form_guide"><span class="asterisk">*</span>필수입력</div>
		</div>
	</div>
	<table class="board_write">
		<caption>내용 (상위 메뉴코드, 메뉴코드, 단계, 순서, 메뉴명, 노출여부, 새창열기, 하위탭여부, 유형구분, URL, 설명 등으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/> 
			<col/>
		</colgroup>
		<c:choose>
			<c:when test="${sessionScope.SESSION_WRITE_BTN_KEY}">
				<tbody> 
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
									<form:input path="menuCd" id="menuCd" title="메뉴코드" cssClass="w64p menuInputCheck" maxlength="20" required="true" placeholder="영문, 숫자, '_' 만 입력"/>
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
						<th scope="row"><span class="asterisk">*</span>유형구분</th>
						<td id="menuTpCl_td" colspan="3">
							<c:choose>
								<c:when test="${not empty menuVO.menuTpCl}">
									<form:select path="menuTpCl" title="유형구분"  cssClass="w50p" disabled="true" required="true">
										<form:option value="" label="유형 선택"></form:option>
										<form:option value="A" label="개별"></form:option>
										<form:option value="B" label="게시판"></form:option>
										<form:option value="C" label="컨텐츠"></form:option>
									</form:select>
								</c:when>
								<c:otherwise>
									<form:select path="menuTpCl" title="유형구분"  cssClass="w50p" required="true">
										<form:option value="" label="유형 선택" ></form:option>
										<form:option value="A" label="개별"></form:option>
										<form:option value="B" label="게시판"></form:option>
										<form:option value="C" label="컨텐츠"></form:option>
									</form:select>
									<button type="button" class="btn bd blue disno" id="btn_conttmpl_modify">컨텐츠 등록</button>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${menuVO.menuTpCl eq 'C'}">
									<button type="button" class="btn bd blue" id="btn_conttmpl_modify">컨텐츠 수정</button>
								</c:when>
								<c:when test="${empty menuVO.menuTpCl or menuVO.menuTpCl eq 'B'}">
									<form:select path="bltnbCl" title="게시판 유형" cssClass="w48p mar_l10"  disabled="true">
									  	<form:option value="" label="게시판 유형 선택" ></form:option>
										<form:option value="bd" label="일반"></form:option>
										<form:option value="nt" label="공지사항"></form:option>
										<form:option value="gr" label="갤러리"></form:option>
										<form:option value="qa" label="Q&A"></form:option>
										<form:option value="fa" label="FAQ"></form:option>
									</form:select>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							<c:if test="${not empty menuVO.menuTpCl}">
								<form:hidden path="menuTpCl"  title="유형구분" />
								<form:hidden path="bltnbCl" title="게시판 유형" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">URL</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${menuVO.isLeaf eq 1}">
									-
								</c:when>
								<c:when test="${menuVO.menuTpCl eq 'B' or menuVO.menuTpCl eq 'C'}">
									<span id="menu_url_addr_span">
										<c:out value="${menuVO.menuUrlAddr}"/>
									</span>
									<form:hidden path="menuUrlAddr" id="menu_url_addr_hidden" title="URL"/>
								</c:when>
								<c:otherwise>
									<span id="menu_url_addr_span">
									</span>
									<form:hidden path="menuUrlAddr" id="menu_url_addr_hidden" title="URL"/>
									<input type="text" id="menu_url_addr_input" title="URL" class="w95p mar_l0" maxlength="50" placeholder="<c:out value="${menuVO.menuTpCl ne 'A' ? '유형구분이 게시판은 list.do / 컨텐츠는 cont.do로 URL이 고정됩니다.' : ''}"/>"/>
								</c:otherwise>
							</c:choose>
							<c:if test="${menuVO.isLeaf ne 1}"> 
								<a href="javascript:void(0);" id="menu_url_copy">
									<img alt="clipboard" src="<c:out value='/internal/standard/ma/images/icon/clipboard.svg'/>" class="w26"> 
								</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">설명</th>
						<td colspan="3">
							<form:textarea path="menuExpl" id="menuExpl" title="설명" rows="2" placeholder="메뉴코드와 유형구분은 저장후 변경할 수 없습니다."/>
						</td>
					</tr>
				</tbody>
			</c:when>
			<c:otherwise>
				<tbody> 
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
						<th scope="row"><span class="asterisk">*</span>유형구분</th>
						<td colspan="3">
							<select title="유형구분"  class="w50p" disabled="disabled">
								<option <c:out value="${empty menuVO.menuTpCl ? 'selected=selected' : ''}"/>>유형선택</option>
								<option <c:out value="${menuVO.menuTpCl eq 'A' ? 'selected=selected' : ''}"/>>개별</option>
								<option <c:out value="${menuVO.menuTpCl eq 'B' ? 'selected=selected' : ''}"/>>게시판</option>
								<option <c:out value="${menuVO.menuTpCl eq 'C' ? 'selected=selected' : ''}"/>>컨텐츠</option>
							</select>
							<c:if test="${menuVO.menuTpCl eq 'B'}">
								<select title="게시판 유형" class="w48p mar_l10"  disabled="disabled">
									<option <c:out value="${empty menuVO.bltnbCl ? 'selected=selected' : ''}"/>>게시판 유형선택</option>
									<option <c:out value="${menuVO.bltnbCl eq 'bd' ? 'selected=selected' : ''}"/>>일반</option>
									<option <c:out value="${menuVO.bltnbCl eq 'nt' ? 'selected=selected' : ''}"/>>공지사항</option>
									<option <c:out value="${menuVO.bltnbCl eq 'gr' ? 'selected=selected' : ''}"/>>갤러리</option>
									<option <c:out value="${menuVO.bltnbCl eq 'qa' ? 'selected=selected' : ''}"/>>Q&A</option>
									<option <c:out value="${menuVO.bltnbCl eq 'fa' ? 'selected=selected' : ''}"/>>FAQ</option>
								</select>
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">URL</th>
						<td colspan="3">
							<span id="menu_url_addr_span">
								<c:out value="${menuVO.isLeaf eq 1 ? '-' : menuVO.menuUrlAddr }"/>
							</span>
							<c:if test="${menuVO.isLeaf ne 1 and not empty menuVO.menuUrlAddr}">
								<a href="javascript:void(0); return false;" id="menu_url_copy">
									<img alt="clipboard" src="<c:out value='/internal/standard/ma/images/icon/clipboard.svg'/>" class="w26 mar_l5">
								</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">설명</th>
						<td colspan="3">
							<textarea title="설명" rows="2" disabled="disabled"><c:out value="${not empty menuVO.menuExpl ? menuVO.menuExpl : '-'}"/></textarea>
						</td>
					</tr>
				</tbody>
			</c:otherwise>
		</c:choose>
	</table>
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<div class="btn_area">
			<a href="javascript:void(0)" id="btn_menu_submit" class="btn blue"><c:out value="${empty menuVO.menuCd ? '등록' : '수정'}"/></a> 
			<c:if test="${not empty menuVO.menuCd}">
				<a href="javascript:void(0)" id="btn_menu_delete" class="btn red">삭제</a>
			</c:if>
		</div>	
	</c:if>
</form:form>

