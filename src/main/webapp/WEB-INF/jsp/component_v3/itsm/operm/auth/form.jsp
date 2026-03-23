<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="${pageContext.request.contextPath}/component/itsm/js/board.js"></script>
<script src="${pageContext.request.contextPath}/component/itsm/js/cm.validate.js"></script>
<script type="text/javascript">
	var overChk=${searchVO.procType eq 'insert' ? false : true}

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

		if ("${procMsg}") {
			alert("${procMsg}");
		}

		$(".tab_menu li").click(function(event) {
			$(this).addClass("current");
			$(this).addClass("on");
			$(this).siblings().removeClass("current");
			$(this).siblings().removeClass("on");
		});


	/*	$('.js-tcont').hide();
		$('.js-tcont.on').show();*/
		$('.js-tmenu li').click(function () {
			let tabId = $(this).attr('id');
			let selTabId = $('.js-tmenu li[id="' + tabId + '"], .js-tcont[data-tab="' + tabId + '"]');
			$(this).closest('.tab').find('.js-tmenu li, .js-tcont').not('.js-tmenu li.on').removeClass('on');
			selTabId.addClass('on').fadeIn();
			selTabId.siblings('.js-tcont').hide();
			selTabId.siblings().removeClass('on');
		});

		$("#btn_submit").bind("click", function(){

			<%-- 쓰기 권한 셋팅 --%>
			fncMenuWrtSet('itsm');

			if(wrestSubmit(document.defaultFrm)){
				itsmFncProc("update");
			}
		});

		$('.valChg').on('change', function(event){
			let type = $(this).data("type");

			let menuSe = 'itsm';
			let menuCd = $(this).closest('td').closest('tr').data('menucd');
			let menuLvl = $(this).closest('td').closest('tr').data('menulvl');

			if(type == "SELECT"){
				fncAuthChange(menuSe, menuCd, menuLvl);
			} else{
				fncMenuChange(menuSe, menuCd, menuLvl);
			}


		});

		fncFirstAction('itsm');

	});


	<%-- 최대 레벨 --%>
	var maxLvl = 4;

	<%-- 반영전 - 메뉴 권한 이름 설정 --%>
	function fncMenuWrtSet(type) {

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

	<%-- 초기 disabled 변경 --%>
	var fncFirstAction = function(type) {

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
	var fncMenuChange = function(type, menuCd, lvl){

		var thisChk = $('#'+type+'ArrDepth'+lvl+'Menu_'+menuCd).is(':checked');
		var thisVal = $('#'+type+'ArrDepth'+lvl+'Wrt_'+menuCd).val();

		<%-- 자기자신 변경 --%>
		if(thisChk){
			$('#'+type+'ArrDepth'+lvl+'Wrt_'+menuCd).attr('disabled',false);
		} else {
			$('#'+type+'ArrDepth'+lvl+'Wrt_'+menuCd).attr('disabled',true);
		}

		for(var i = 1, j = (maxLvl-1); i <= j; i++){
			if(lvl <= i){
				<%-- disabled 변경 --%>
				if(thisChk){
					$('input:checkbox[id^='+type+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').attr('disabled',false).prop("checked",true);
					$('input:checkbox[id^='+type+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').each(function(){
						$('#'+$(this).attr('id').replace((i+1)+'Menu_',(i+1)+'Wrt_')).attr('disabled',false).val(thisVal);
					});
				} else {
					$('input:checkbox[id^='+type+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').attr('disabled',true).prop("checked",false);
					$('input:checkbox[id^='+type+'ArrDepth'+(i+1)+'Menu_'+menuCd+']').each(function(){
						$('#'+$(this).attr('id').replace((i+1)+'Menu_',(i+1)+'Wrt_')).attr('disabled',true);
					});
				}
			}
		}
	}

	<%-- 권한 변경 --%>
	var fncAuthChange = function(type, menuCd, lvl){

		var thisVal = $('#'+type+'ArrDepth'+lvl+'Wrt_'+menuCd).val();

		for(var i = 1, j = (maxLvl-1); i <= j; i++){
			if(lvl <= i){
				$('select[id^='+type+'ArrDepth'+(i+1)+'Wrt_'+menuCd+']').val(thisVal);
			}
		}
	}
</script>
<style>
	.code_list2 {border: 1px solid #dbebe2;border-top: 1px solid #888888;}
	.code_list2 .tbl_codelist thead tr th {position:relative;padding: 10px 20px;background: #f4f7fe;border-right: 1px solid #e4e7ee;font-size:14px;color: #444;font-weight:600;border-bottom: 1px solid #e4e7ee;}
	.code_list2 .tbl_codelist thead tr th i {display:inline-block;vertical-align: middle;margin-right: 5px;}
	.code_list2 .tbl_codelist thead tr th:last-child {border-right:0;}
	.legend_wrap span {position:relative;padding-left: 7px;margin-right: 5px;}
	.legend_wrap span::before {content:'';position: absolute;left: 0;top: 50%;width:3px;height:3px;background: #868686;transform: translateY(-50%);}
	.legend_wrap .legend_list > li {display:inline-block;position:relative;vertical-align: middle;padding-left: 11px;margin-left: 5px;}
	.legend_wrap .legend_list > li::before {content:'';position: absolute;left: 0;top: 50%;width:9px;height:9px;border-radius:50%;transform: translateY(-50%);}
	.code_list2 .depth1{margin-top:6px;}
	.code_list2 .tbl_codelist tbody tr td {padding: 3px 20px;font-size: 13px;}
	.code_list2 .tbl_codelist tbody tr td:last-child {border-right:0;}
	.code_list2 .tbl_codelist tbody tr td.id {position: relative;text-align:left;padding: 3px 10px 3px 22px;}
	.code_list2 .depth1 .dep1 {text-align: left;padding: 5px 10px 5px 22px;cursor: pointer;}
	.code_list2 .depth2 .tbl_codelist tbody tr td:first-child {border-top: 0;}
	.code_list2 .depth2 > li > .tbl_codelist td.id {padding-left: 45px;cursor: pointer;}
	.btn_allclose {display: inline-block;border: 1px solid #a8aec0;font-size: 12px;padding: 2px 5px;border-radius: 5px;margin-left: 10px;cursor: pointer;background: #d9deea;font-weight: 400;}
</style>
<form:form modelAttribute="maSysAuthVO" id="defaultFrm" name="defaultFrm" method="post">
	<form:hidden path="currentPageNo"/>
	<form:hidden path="grpAuthSerno"/>
	<div class="tbl_top">
		<div class="tbl_left">
			<h4 class="sm_tit">기본정보</h4>
		</div>
		<div class="tbl_right">
			<span class="essential_txt"><span>*</span>는 필수입력</span>
		</div>
	</div>
	<div class="board_write">
		<!-- 		<table class="board_row_type01"> -->
		<table class="board_row_type01">
			<colgroup>
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:20%;">
				<col style="width:30%;">
			</colgroup>
			<tbody>
			<tr>
				<th scope="row"><strong>권한그룹코드</strong></th>
				<td>
					<form:hidden path="grpAuthId" id="grpAuthId"/>
					<c:out value="${maSysAuthVO.grpAuthId }"/>
				</td>
				<th scope="row"><strong>권한그룹명</strong></th>
				<td><c:out value="${maSysAuthVO.grpAuthNm}"/></td>
			</tr>
			</tbody>
		</table>
		<div class="tbl_top mar_t30">
			<div class="tbl_left">
				<h4 class="sm_tit">메뉴설정</h4>
			</div>
			<div class="tbl_right"></div>
		</div>
		<br>
		<div class="tab box">

			<div class="tab_cont js-tcont" data-tab="tab1_03">
				<div class="code_list2" style="margin-bottom:10px;">
					<table class="tbl_codelist">
						<colgroup>
							<col style="width:50%;">
							<col style="width:50%;">
						</colgroup>
						<thead>
						<tr>
							<th scope="col">
								<i class="name"></i>메뉴명
								<span class="btn_allclose btn_open">전체열기</span>
								<span class="btn_allclose btn_close">전체닫기</span>
							</th>
							<th scope="col"><i class="func"></i>권한</th>
						</tr>
						</thead>
					</table>
					<ul class="depth1">
						<c:forEach var="menu" items="${itsmMenuList}">
							<c:set var="idNm" value="itsm"/>
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
											<c:forEach var="menu2" items="${itsmMenuList}">
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
																<c:forEach var="menu3" items="${itsmMenuList}">
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
																					<c:forEach var="menu4" items="${itsmMenuList}">
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
	</div>
	<div class="btn_area">
			<a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl  btn_save" >수정</a>
			<a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_cancel" >목록</a>
	</div>
</form:form>