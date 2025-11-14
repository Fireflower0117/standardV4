<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	$(function(){
		$('.dep1 > i').on('click',function(){

			if($(this).parent().hasClass('open')){
				$(this).parent().siblings('.id').removeClass('open');
			}else{
				$(this).parent().siblings('.id').addClass('open');
				$(this).parent().closest('.tbl_codelist').siblings('ul').find('.id').removeClass('open');
				$(this).parent().closest('.tbl_codelist').siblings('ul').find('ul').css('display','none');
			}
			$(this).parent().toggleClass('open');
			$(this).parent().parents('.depth1 > li').children('.depth2').slideToggle();
		});

		$('.depth2 .id.more > i').on('click',function(){
			if(!$(this).parent().hasClass('open')){
				$(this).parent().closest('.tbl_codelist').siblings('ul').find('.id').removeClass('open');
				$(this).parent().closest('.tbl_codelist').siblings('ul').find('ul').css('display','none');
			}
			$(this).parent().toggleClass('open');
			$(this).parent().closest('.tbl_codelist').siblings('ul').slideToggle();
		});

		$('.btn_open').on('click',function(){

			<%-- open 클래스 부여 --%>
			$(this).parents("[class^='tbl_codelist']").siblings('ul').find('.dep1').addClass('open');
			$(this).parents("[class^='tbl_codelist']").siblings('ul').find('.more').addClass('open');

			<%-- 토글 열기 --%>
			$(this).parents("[class^='tbl_codelist']").siblings('ul').children('li').children('.depth2').slideDown();
			$(this).parents("[class^='tbl_codelist']").siblings('ul').children('li').children('.depth2').children('li').children('.depth3').slideDown();
			$(this).parents("[class^='tbl_codelist']").siblings('ul').children('li').children('.depth2').children('li').children('.depth3').children('li').children('.depth4').slideDown();

		});

		$('.btn_close').on('click',function(){
			//$(this).parents("[class^='tbl_codelist']").slideUp();
			$(this).parents("[class^='tbl_codelist']").siblings('ul').children('li').children('.depth2').slideUp();
			$(this).parents("[class^='tbl_codelist']").siblings('ul').find('.id').removeClass('open');
			//$('.code_list2 .depth2')
			//$('.id').removeClass('open');
		});

	});


	$(document).ready(function(){

		$(".tab_menu li").click(function(event) {
			$(this).addClass("current");
			$(this).addClass("on");
			$(this).siblings().removeClass("current");
			$(this).siblings().removeClass("on");
		});


		$('.js-tcont').hide();
		$('.js-tcont.on').show();
		$('.js-tmenu li').click(function () {
			let tabId = $(this).attr('id');
			let selTabId = $('.js-tmenu li[id="' + tabId + '"], .js-tcont[data-tab="' + tabId + '"]');
			$(this).closest('.tab').find('.js-tmenu li, .js-tcont').not('.js-tmenu li.on').removeClass('on');
			selTabId.addClass('on').fadeIn();
			selTabId.siblings('.js-tcont').hide();
			selTabId.siblings().removeClass('on');
		});

		$('#btn_submit').on('click', function(){

			fncMenuNameSet("ma");
			fncMenuNameSet("ft");
			fncMenuNameSet("my");

			if(wrestSubmit(document.defaultFrm)){
				if(ovlpChk == 1){
					alert('그룹권한ID 중복입니다.');
					return false;
				}

				fncProc("${empty authVO.grpAuthSerno ? 'insert' : 'update'}");
			}
		});

		$('#btn_delete').on('click', function(){
			if(wrestSubmit(document.defaultFrm)){
				if(ovlpChk == 1){
					alert('그룹권한ID 중복입니다.');
					return false;
				}

				fncProc('delete');
			}
		});

		$('.valChg').on('change', function(event){
			let type = $(this).data("type");

			let menuSe = $(this).closest('td').closest('tr').data('menuse');
			let menuCd = $(this).closest('td').closest('tr').data('menucd');
			let menuLvl = $(this).closest('td').closest('tr').data('menulvl');

			if(type == "SELECT"){
				fncAuthChange(menuSe, menuCd, menuLvl);
			} else{
				fncMenuChange(menuSe, menuCd, menuLvl);
			}


		});

		fncFirstAction('ma');
		fncFirstAction('ft');
		fncFirstAction('my');

	});

	<%-- 최대 레벨 --%>
	var maxLvl = 4;
	<%-- 반영전 - 메뉴 권한 이름 설정 --%>
	const fncMenuNameSet = function(type){

		var cnt = 0;

		for(var i = 1; i <= maxLvl; i++){
			$('input:checkbox[id^='+type+'ArrDepth'+i+'Menu_]').each(function(index){
				if($(this).is(':checked')){

					<%-- 메뉴 --%>
					$(this).attr('name', type+'AuthList['+cnt+'].menuCd');

					<%-- 권한 --%>
					$('#'+$(this).attr('id').replace(i+'Menu_',i+'Wrt_')).attr('name', type+'AuthList['+cnt+'].wrtAuthYn');

					cnt++;
				}
			});
		}
	}


	// ID중복체크
	var ovlpChk = 0;
	const fncIdOvlpChk = function(grpAuthId){
		$.ajax({
			method: "POST",
			url: "/ma/sys/auth/idOvlpChk",
			data: {grpAuthId : grpAuthId},
			dataType: "json",
			success: function(data) {
				let overCnt = data.ovlpCnt;

				if(overCnt > 0){
					wrestMsg = "그룹권한ID 중복입니다.";

					// 오류메세지를 위한 element 추가
					var msgHtml = '<strong id="strong_grpAuthId"><font color="red">&nbsp;'+wrestMsg+'</font></strong>';

					$("#grpAuthId").parent().append(msgHtml);
					ovlpChk = 1;
				}else{
					$("#strong_grpAuthId").remove();
					ovlpChk = 0;
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert("에러");
			}
		});
	}

	<%-- 초기 disabled 변경 --%>
	const fncFirstAction = function(type) {

		for(var i = 1; i <= maxLvl; i++){
			$('input:checkbox[id^='+type+'ArrDepth'+i+'Menu_]').each(function(index){
				if($(this).is(':checked')){
					<%-- 자신 변경 --%>
					$(this).attr("disabled",false);
					$('#'+$(this).attr('id').replace(i+'Menu_',i+'Wrt_')).attr("disabled",false);

					<%-- 하위 레벨 변경 --%>
					if(i < maxLvl){
						$('input:checkbox[id^='+$(this).attr('id').replace(i+'Menu_',(i+1)+'Menu_')+']').attr('disabled',false);
					}
				}
			});
		}
	}

	<%--
         체크박스 클릭 및 초기 설정

         type : id 앞에 붙을 명칭

    --%>
	const fncMenuChange = function(menuSe, menuCd, menuLvl){

		var thisChk = $('#'+menuSe+'ArrDepth'+menuLvl+'Menu_'+menuCd).is(':checked');
		var thisVal = $('#'+menuSe+'ArrDepth'+menuLvl+'Wrt_'+menuCd).val();

		<%-- 자기자신 변경 --%>
		if(thisChk){
			$('#'+menuSe+'ArrDepth'+menuLvl+'Wrt_'+menuCd).attr('disabled',false);
		} else {
			$('#'+menuSe+'ArrDepth'+menuLvl+'Wrt_'+menuCd).attr('disabled',true);
		}

		for(var i = 1, j = (maxLvl-1); i <= j; i++){
			if(menuLvl <= i){
				<%-- disabled 변경 --%>
				if(thisChk){
					$('input:checkbox[id^='+menuSe+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').attr('disabled',false).prop("checked",true);
					$('input:checkbox[id^='+menuSe+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').each(function(){
						$('#'+$(this).attr('id').replace((i+1)+'Menu_',(i+1)+'Wrt_')).attr('disabled',false).val(thisVal);
					});
				} else {
					$('input:checkbox[id^='+menuSe+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').attr('disabled',true).prop("checked",false);
					$('input:checkbox[id^='+menuSe+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').each(function(){
						$('#'+$(this).attr('id').replace((i+1)+'Menu_',(i+1)+'Wrt_')).attr('disabled',true);
					});
				}
			}
		}
	}

	<%-- 권한 변경 --%>
	const fncAuthChange = function(menuSe, menuCd, menuLvl){

		var thisVal = $('#'+menuSe+'ArrDepth'+menuLvl+'Wrt_'+menuCd).val();

		for(var i = 1, j = (maxLvl-1); i <= j; i++){
			if(menuLvl <= i){
				$('select[id^='+menuSe+'ArrDepth'+(i+1)+'Wrt_'+menuCd+']').val(thisVal);
			}
		}
	}

</script>
<form:form modelAttribute="authVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="grpAuthSerno"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="sidebyside">
		<div class="left">
		</div>
		<div class="right">
			<div class="board_top">
				<!-- <div class="board_left"></div> -->
				<div class="board_right">
					<div class="form_guide"><span class="asterisk">*</span>필수입력</div>
				</div>
			</div>
		</div>
	</div>
	<table class="board_write">
		<caption>내용(그룹권한ID, 그룹권한명, 사용여부, 그룹권한설명으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
		<tr>
			<th scope="row"><span class="asterisk">*</span>그룹권한ID</th>
			<c:choose>
				<c:when test="${searchVO.procType eq 'insert'}">
					<td><form:input path="grpAuthId" id="grpAuthId" title="그룹권한ID" cssClass="w100p" maxlength="15" required="true"/></td>
				</c:when>
				<c:otherwise>
					<td class="l">
						<c:out value="${authVO.grpAuthId }"/>
						<form:hidden path="grpAuthId"/>
					</td>
				</c:otherwise>
			</c:choose>
			<th scope="row"><span class="asterisk">*</span>그룹권한명</th>
			<td>
				<form:input path="grpAuthNm" title="그룹권한명" cssClass="w100p" maxlength="30" required="true"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="asterisk">*</span>사용여부</th>
			<td colspan="3">
				<span class="chk">
					<span class="radio"><form:radiobutton path="useYn" id="useYn_Y" title="사용여부" value="Y" required="true" checked="true"/><label for="useYn_Y">사용</label></span>
					<span class="radio"><form:radiobutton path="useYn" id="useYn_N" title="사용여부" value="N" required="true" checked="true"/><label for="useYn_N">미사용</label></span>
				</span>
			</td>
		</tr>
		<tr>
			<th scope="row" colspan="4" class="c">그룹권한설명</th>
		</tr>
		<tr>
			<td colspan="4">
				<form:textarea path="grpAuthExpl" title="내용" style="resize: vertical;height: 50px;" maxlength="900"/>
			</td>
		</tr>
		</tbody>
	</table>
	<h4 class="md_tit mar_t30">메뉴설정</h4>
	<div class="board_top">
		<!-- <div class="board_left"></div> -->
		<div class="board_right">
		</div>
	</div>
	<div class="tab wide">
		<ul class="tab_menu js-tmenu">
			<li id="tab1_01" class="on current"><a href="javascript:void(0)">관리자</a></li>
			<li id="tab1_02"><a href="javascript:void(0)">사용자</a></li>
			<li id="tab1_03"><a href="javascript:void(0)">마이페이지</a></li>
		</ul>
		<div class="tab_cont js-tcont on" data-tab="tab1_01">
			<div class="code_list2" style="margin-bottom:10px;">
				<table class="tbl_codelist">
					<caption>내용(메뉴명, 권한으로 구성)</caption>
					<colgroup>
						<col class="w50p">
						<col class="w50p">
					</colgroup>
					<thead>
					<tr>
						<th scope="col" class="l">
							<i class="name"></i>메뉴명
							<span class="btn_allclose btn_open">전체열기</span>
							<span class="btn_allclose btn_close">전체닫기</span>
						</th>
						<th scope="col" class="l"><i class="func"></i>권한</th>
					</tr>
					</thead>
				</table>
				<ul class="depth1">
					<c:forEach var="menu" items="${maMenuAuthList}">
						<c:set var="idNm" value="ma"/>
						<c:if test="${menu.menuLvl eq 1}">
							<li>
								<table class="tbl_codelist">
									<colgroup>
										<col class="w50p">
										<col class="w50p">
									</colgroup>
									<tbody>
									<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>" data-menulvl="<c:out value="${menu.menuLvl}"/>">
										<td class="dep1 id">
											<i></i>
											<span class="chk">
												<span class="cbx">
													<input type="checkbox" class="valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth1Menu_<c:out value="${menu.menuCd }"/>" value="<c:out value="${menu.menuCd }"/>" <c:out value="${menu.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/>/>
													<label for="<c:out value="${idNm}"/>ArrDepth1Menu_<c:out value="${menu.menuCd }"/>"><c:out value="${menu.menuNm }"/></label>
												</span>
											</span>
										</td><!-- 파일갯수 -->
										<td>
											<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth1Wrt_<c:out value="${menu.menuCd }"/>" disabled="disabled">
												<option value="R" label="읽기" <c:out value="${menu.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
												<option value="W" label="읽기/쓰기" <c:out value="${menu.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
												<option value="M" label="관리자" <c:out value="${menu.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
											</select>
										</td>
									</tr>
									</tbody>
								</table>
								<c:if test="${menu.isleaf eq 1}">
									<ul class="depth2">
										<c:forEach var="menu2" items="${maMenuAuthList}">
											<c:if test="${menu2.uprMenuCd eq menu.menuCd}">
												<li>
													<table class="tbl_codelist">
														<colgroup>
															<col class="w50p"/>
															<col class="w50p"/>
														</colgroup>
														<tbody>
														<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>">
															<td class="id <c:out value="${menu2.isleaf eq 1 ? 'more' : ''}"/>">
																<i></i>
																<span class="chk">
																	<span class="cbx">
																		<input type="checkbox" class="valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth2Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menuSeq="<c:out value="${menu2.menuCd }"/>" value="<c:out value="${menu2.menuCd }"/>" <c:out value="${menu2.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled" data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>"/>
																		<label for="<c:out value="${idNm}"/>ArrDepth2Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>"><c:out value="${menu2.menuNm }"/></label>
																	</span>
																</span>
															</td><!-- 하위 파일 있으면 more클래스 추가 -->
															<td>
																<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth2Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" disabled="disabled" data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>">
																	<option value="R" label="읽기" <c:out value="${menu2.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																	<option value="W" label="읽기/쓰기" <c:out value="${menu2.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																	<option value="M" label="관리자" <c:out value="${menu2.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																</select>
															</td>
														</tr>
														</tbody>
													</table>
													<c:if test="${menu2.isleaf eq 1}">
														<ul class="depth3">
															<c:forEach var="menu3" items="${maMenuAuthList}">
																<c:if test="${menu3.uprMenuCd eq menu2.menuCd}">
																	<li>
																		<table class="tbl_codelist">
																			<colgroup>
																				<col class="w50p"/>
																				<col class="w50p"/>
																			</colgroup>
																			<tbody>
																			<tr  data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" data-menulvl="<c:out value="${menu3.menuLvl}"/>">
																				<td class="id <c:out value="${menu3.isleaf eq 1 ? 'more' : ''}"/>">
																					<i></i>
																					<span class="chk">
																						<span class="cbx">
																							<input type="checkbox" class="check checkbox valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth3Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" value="<c:out value="${menu3.menuCd }"/>" <c:out value="${menu3.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled""/>
																							<label for="<c:out value="${idNm}"/>ArrDepth3Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>"><c:out value="${menu3.menuNm }"/></label>
																						</span>
																					</span>
																				</td><!-- 하위 파일 있으면 more클래스 추가 -->
																				<td>
																					<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth3Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" disabled="disabled">
																						<option value="R" label="읽기" <c:out value="${menu3.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																						<option value="W" label="읽기/쓰기" <c:out value="${menu3.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																						<option value="M" label="관리자" <c:out value="${menu3.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																					</select>
																				</td>
																			</tr>
																			</tbody>
																		</table>
																		<c:if test="${menu3.isleaf eq 1}">
																			<ul class="depth4">
																				<c:forEach var="menu4" items="${maMenuAuthList}">
																					<c:if test="${menu4.uprMenuCd eq menu3.menuCd}">
																						<li>
																							<table class="tbl_codelist">
																								<colgroup>
																									<col class="w50p"/>
																									<col class="w50p"/>
																								</colgroup>
																								<tbody>
																								<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd }"/>_<c:out value="${menu4.menuCd }"/>" data-menulvl="<c:out value="${menu4.menuLvl}"/>">
																									<td class="id">
																										<i></i>
																										<span class="chk">
																											<span class="cbx">
																												<input type="checkbox" class="check checkbox valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth4Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>" value="<c:out value="${menu4.menuCd }"/>" <c:out value="${menu4.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled"/>
																												<label for="<c:out value="${idNm}"/>ArrDepth4Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>"><c:out value="${menu4.menuNm }"/></label>
																											</span>
																										</span>
																									</td><!-- 하위 파일 있으면 more클래스 추가 -->
																									<td>
																										<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth4Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>" disabled="disabled">
																											<option value="R" label="읽기" <c:out value="${menu4.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																											<option value="W" label="읽기/쓰기" <c:out value="${menu4.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																											<option value="M" label="관리자" <c:out value="${menu4.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																										</select>
																									</td>
																								</tr>
																								</tbody>
																							</table>
																						</li>
																					</c:if>
																				</c:forEach>
																			</ul>
																		</c:if>
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</c:if>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="tab_cont js-tcont" data-tab="tab1_02">
			<div class="code_list2" style="margin-bottom:10px;">
				<table class="tbl_codelist">
					<colgroup>
						<col class="w50p"/>
						<col class="w50p"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col" class="l">
							<i class="name"></i>메뉴명
							<span class="btn_allclose btn_open">전체열기</span>
							<span class="btn_allclose btn_close">전체닫기</span>
						</th>
						<th scope="col" class="l"><i class="func"></i>권한</th>
					</tr>
					</thead>
				</table>
				<ul class="depth1">
					<c:forEach var="menu" items="${ftMenuAuthList}">
						<c:set var="idNm" value="ft"/>
						<c:if test="${menu.menuLvl eq 1}">
							<li>
								<table class="tbl_codelist">
									<colgroup>
										<col class="w50p"/>
										<col class="w50p"/>
									</colgroup>
									<tbody>
									<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>" data-menulvl="<c:out value="${menu.menuLvl}"/>">
										<td class="dep1 id">
											<i></i>
											<span class="chk">
												<span class="cbx">
													<input type="checkbox" class="valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth1Menu_<c:out value="${menu.menuCd }"/>" value="<c:out value="${menu.menuCd }"/>" <c:out value="${menu.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/>/>
													<label for="<c:out value="${idNm}"/>ArrDepth1Menu_<c:out value="${menu.menuCd }"/>"><c:out value="${menu.menuNm }"/></label>
												</span>
											</span>
										</td><!-- 파일갯수 -->
										<td>
											<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth1Wrt_<c:out value="${menu.menuCd }"/>" disabled="disabled">
												<option value="R" label="읽기" <c:out value="${menu.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
												<option value="W" label="읽기/쓰기" <c:out value="${menu.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
												<option value="M" label="관리자" <c:out value="${menu.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
											</select>
										</td>
									</tr>
									</tbody>
								</table>
								<c:if test="${menu.isleaf eq 1}">
									<ul class="depth2">
										<c:forEach var="menu2" items="${ftMenuAuthList}">
											<c:if test="${menu2.uprMenuCd eq menu.menuCd}">
												<li>
													<table class="tbl_codelist">
														<colgroup>
															<col class="w50p"/>
															<col class="w50p"/>
														</colgroup>
														<tbody>
														<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>">
															<td class="id <c:out value="${menu2.isleaf eq 1 ? 'more' : ''}"/>">
																<i></i>
																<span class="chk">
																	<span class="cbx">
																		<input type="checkbox" class="valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth2Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menuSeq="<c:out value="${menu2.menuCd }"/>" value="<c:out value="${menu2.menuCd }"/>" <c:out value="${menu2.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled" data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>"/>
																		<label for="<c:out value="${idNm}"/>ArrDepth2Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>"><c:out value="${menu2.menuNm }"/></label>
																	</span>
																</span>
															</td><!-- 하위 파일 있으면 more클래스 추가 -->
															<td>
																<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth2Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" disabled="disabled" data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>">
																	<option value="R" label="읽기" <c:out value="${menu2.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																	<option value="W" label="읽기/쓰기" <c:out value="${menu2.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																	<option value="M" label="관리자" <c:out value="${menu2.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																</select>
															</td>
														</tr>
														</tbody>
													</table>
													<c:if test="${menu2.isleaf eq 1}">
														<ul class="depth3">
															<c:forEach var="menu3" items="${ftMenuAuthList}">
																<c:if test="${menu3.uprMenuCd eq menu2.menuCd}">
																	<li>
																		<table class="tbl_codelist">
																			<colgroup>
																				<col class="w50p"/>
																				<col class="w50p"/>
																			</colgroup>
																			<tbody>
																			<tr  data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" data-menulvl="<c:out value="${menu3.menuLvl}"/>">
																				<td class="id <c:out value="${menu3.isleaf eq 1 ? 'more' : ''}"/>">
																					<i></i>
																					<span class="chk">
																						<span class="cbx">
																							<input type="checkbox" class="check checkbox valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth3Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" value="<c:out value="${menu3.menuCd }"/>" <c:out value="${menu3.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled""/>
																							<label for="<c:out value="${idNm}"/>ArrDepth3Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>"><c:out value="${menu3.menuNm }"/></label>
																						</span>
																					</span>
																				</td><!-- 하위 파일 있으면 more클래스 추가 -->
																				<td>
																					<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth3Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" disabled="disabled">
																						<option value="R" label="읽기" <c:out value="${menu3.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																						<option value="W" label="읽기/쓰기" <c:out value="${menu3.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																						<option value="M" label="관리자" <c:out value="${menu3.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																					</select>
																				</td>
																			</tr>
																			</tbody>
																		</table>
																		<c:if test="${menu3.isleaf eq 1}">
																			<ul class="depth4">
																				<c:forEach var="menu4" items="${ftMenuAuthList}">
																					<c:if test="${menu4.uprMenuCd eq menu3.menuCd}">
																						<li>
																							<table class="tbl_codelist">
																								<colgroup>
																									<col class="w50p"/>
																									<col class="w50p"/>
																								</colgroup>
																								<tbody>
																								<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd }"/>_<c:out value="${menu4.menuCd }"/>" data-menulvl="<c:out value="${menu4.menuLvl}"/>">
																									<td class="id">
																										<i></i>
																										<span class="chk">
																											<span class="cbx">
																												<input type="checkbox" class="check checkbox valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth4Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>" value="<c:out value="${menu4.menuCd }"/>" <c:out value="${menu4.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled"/>
																												<label for="<c:out value="${idNm}"/>ArrDepth4Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>"><c:out value="${menu4.menuNm }"/></label>
																											</span>
																										</span>
																									</td><!-- 하위 파일 있으면 more클래스 추가 -->
																									<td>
																										<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth4Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>" disabled="disabled">
																											<option value="R" label="읽기" <c:out value="${menu4.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																											<option value="W" label="읽기/쓰기" <c:out value="${menu4.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																											<option value="M" label="관리자" <c:out value="${menu4.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																										</select>
																									</td>
																								</tr>
																								</tbody>
																							</table>
																						</li>
																					</c:if>
																				</c:forEach>
																			</ul>
																		</c:if>
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</c:if>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="tab_cont js-tcont" data-tab="tab1_03">
			<div class="code_list2" style="margin-bottom:10px;">
				<table class="tbl_codelist">
					<colgroup>
						<col class="w50p"/>
						<col class="w50p"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col" class="l">
							<i class="name"></i>메뉴명
							<span class="btn_allclose btn_open">전체열기</span>
							<span class="btn_allclose btn_close">전체닫기</span>
						</th>
						<th scope="col" class="l"><i class="func"></i>권한</th>
					</tr>
					</thead>
				</table>
				<ul class="depth1">
					<c:forEach var="menu" items="${myMenuAuthList}">
						<c:set var="idNm" value="my"/>
						<c:if test="${menu.menuLvl eq 1}">
							<li>
								<table class="tbl_codelist">
									<colgroup>
										<col class="w50p"/>
										<col class="w50p"/>
									</colgroup>
									<tbody>
									<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>" data-menulvl="<c:out value="${menu.menuLvl}"/>">
										<td class="dep1 id">
											<i></i>
											<span class="chk">
												<span class="cbx">
													<input type="checkbox" class="valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth1Menu_<c:out value="${menu.menuCd }"/>" value="<c:out value="${menu.menuCd }"/>" <c:out value="${menu.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/>/>
													<label for="<c:out value="${idNm}"/>ArrDepth1Menu_<c:out value="${menu.menuCd }"/>"><c:out value="${menu.menuNm }"/></label>
												</span>
											</span>
										</td><!-- 파일갯수 -->
										<td>
											<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth1Wrt_<c:out value="${menu.menuCd }"/>" disabled="disabled">
												<option value="R" label="읽기" <c:out value="${menu.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
												<option value="W" label="읽기/쓰기" <c:out value="${menu.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
												<option value="M" label="관리자" <c:out value="${menu.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
											</select>
										</td>
									</tr>
									</tbody>
								</table>
								<c:if test="${menu.isleaf eq 1}">
									<ul class="depth2">
										<c:forEach var="menu2" items="${myMenuAuthList}">
											<c:if test="${menu2.uprMenuCd eq menu.menuCd}">
												<li>
													<table class="tbl_codelist">
														<colgroup>
															<col class="w50p"/>
															<col class="w50p"/>
														</colgroup>
														<tbody>
														<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>">
															<td class="id <c:out value="${menu2.isleaf eq 1 ? 'more' : ''}"/>">
																<i></i>
																<span class="chk">
																	<span class="cbx">
																		<input type="checkbox" class="valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth2Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menuSeq="<c:out value="${menu2.menuCd }"/>" value="<c:out value="${menu2.menuCd }"/>" <c:out value="${menu2.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled" data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>"/>
																		<label for="<c:out value="${idNm}"/>ArrDepth2Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>"><c:out value="${menu2.menuNm }"/></label>
																	</span>
																</span>
															</td><!-- 하위 파일 있으면 more클래스 추가 -->
															<td>
																<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth2Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" disabled="disabled" data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>" data-menulvl="<c:out value="${menu2.menuLvl}"/>">
																	<option value="R" label="읽기" <c:out value="${menu2.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																	<option value="W" label="읽기/쓰기" <c:out value="${menu2.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																	<option value="M" label="관리자" <c:out value="${menu2.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																</select>
															</td>
														</tr>
														</tbody>
													</table>
													<c:if test="${menu2.isleaf eq 1}">
														<ul class="depth3">
															<c:forEach var="menu3" items="${myMenuAuthList}">
																<c:if test="${menu3.uprMenuCd eq menu2.menuCd}">
																	<li>
																		<table class="tbl_codelist">
																			<colgroup>
																				<col class="w50p"/>
																				<col class="w50p"/>
																			</colgroup>
																			<tbody>
																			<tr  data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" data-menulvl="<c:out value="${menu3.menuLvl}"/>">
																				<td class="id <c:out value="${menu3.isleaf eq 1 ? 'more' : ''}"/>">
																					<i></i>
																					<span class="chk">
																						<span class="cbx">
																							<input type="checkbox" class="check checkbox valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth3Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" value="<c:out value="${menu3.menuCd }"/>" <c:out value="${menu3.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled""/>
																							<label for="<c:out value="${idNm}"/>ArrDepth3Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>"><c:out value="${menu3.menuNm }"/></label>
																						</span>
																					</span>
																				</td><!-- 하위 파일 있으면 more클래스 추가 -->
																				<td>
																					<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth3Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>" disabled="disabled">
																						<option value="R" label="읽기" <c:out value="${menu3.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																						<option value="W" label="읽기/쓰기" <c:out value="${menu3.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																						<option value="M" label="관리자" <c:out value="${menu3.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																					</select>
																				</td>
																			</tr>
																			</tbody>
																		</table>
																		<c:if test="${menu3.isleaf eq 1}">
																			<ul class="depth4">
																				<c:forEach var="menu4" items="${myMenuAuthList}">
																					<c:if test="${menu4.uprMenuCd eq menu3.menuCd}">
																						<li>
																							<table class="tbl_codelist">
																								<colgroup>
																									<col class="w50p"/>
																									<col class="w50p"/>
																								</colgroup>
																								<tbody>
																								<tr data-menuse="<c:out value="${idNm}"/>" data-menucd="<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd }"/>_<c:out value="${menu4.menuCd }"/>" data-menulvl="<c:out value="${menu4.menuLvl}"/>">
																									<td class="id">
																										<i></i>
																										<span class="chk">
																											<span class="cbx">
																												<input type="checkbox" class="check checkbox valChg" name="arrMenu" id="<c:out value="${idNm}"/>ArrDepth4Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>" value="<c:out value="${menu4.menuCd }"/>" <c:out value="${menu4.authExst eq 'Y' ? 'checked=\"checked\"' : '' }"/> disabled="disabled"/>
																												<label for="<c:out value="${idNm}"/>ArrDepth4Menu_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>"><c:out value="${menu4.menuNm }"/></label>
																											</span>
																										</span>
																									</td><!-- 하위 파일 있으면 more클래스 추가 -->
																									<td>
																										<select class="selec w100px valChg" id="<c:out value="${idNm}"/>ArrDepth4Wrt_<c:out value="${menu.menuCd }"/>_<c:out value="${menu2.menuCd }"/>_<c:out value="${menu3.menuCd}"/>_<c:out value="${menu4.menuCd}"/>" disabled="disabled">
																											<option value="R" label="읽기" <c:out value="${menu4.wrtAuthYn eq 'R' ? 'selected=\"selected\"' : ''}"/>>
																											<option value="W" label="읽기/쓰기" <c:out value="${menu4.wrtAuthYn eq 'W' ? 'selected=\"selected\"' : ''}"/>>
																											<option value="M" label="관리자" <c:out value="${menu4.wrtAuthYn eq 'M' ? 'selected=\"selected\"' : ''}"/>>
																										</select>
																									</td>
																								</tr>
																								</tbody>
																							</table>
																						</li>
																					</c:if>
																				</c:forEach>
																			</ul>
																		</c:if>
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</c:if>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</form:form>
<div class="btn_area">
	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<button id="btn_submit" class="btn blue"><c:out value="${empty authVO.grpAuthSerno ? '등록' : '수정'}"/></button>
		<c:if test="${not empty authVO.grpAuthSerno }">
			<button id="btn_delete" class="btn red">삭제</button>
		</c:if>
		<button id="btn_list" class="btn gray">목록</button>
	</c:if>
</div>
</body>
