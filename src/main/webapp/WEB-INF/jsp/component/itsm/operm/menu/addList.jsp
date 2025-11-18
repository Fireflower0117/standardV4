<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
	
	<%-- 해당 메뉴 정보 불러와서 form에 뿌려주기 --%>
	const fncCalladdForm = function(menuCd){
		return $.ajax({ method: "POST",  
			url: "addForm.do",  
			data : {menuCd : menuCd}, 
			dataType: "HTML", 
			success : function(data) { 
				$("#addForm").html(data);
			},error : function(){
				if (xhr.status == 401) {
					window.location.reload();
				}
				alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		});
	}

	<%-- 데이터 불러올때 lvl에 따라 값 정리 --%>
	const fncModifyForm = function( menuCd, menuLvl, menuSeqo, lwrTabYn,url){
		$("#uprMenuCd").val(menuCd);
		$("#uprMenuCd_span").text(menuCd);
		$("#menuLvl").val(menuLvl);
		$("#menuLvl_span").text(menuLvl);
		$("#menuSeqo").val(menuSeqo);
		$("#menuSeqo_span").text(menuSeqo);
		$("#menu_url_addr_span").text(url);
		$("#menu_url_addr_hidden").val(url);
		$("#menu_url_addr_input").attr("class", "w60p");
	}
	
	<%-- addform 생성후 depth0 메뉴 순서 지정 --%>
	fncCalladdForm().done(function(data){
		var menuSeqo = Number($("td[data-menulvl='0']").length) +1
		$("#menuSeqo").val(menuSeqo);
		$("#menuSeqo_span").text(menuSeqo);
	});


	$('.dep1 > i').on('click',function(){
		
		if($(this).parent().hasClass('open')){
			$(this).parent().siblings('.id').removeClass('open');
		}else{
			$(this).parent().siblings('.id').addClass('open');
			$(this).parent().closest('.tbl_menulist').siblings('ul').find('.id').removeClass('open');
			$(this).parent().closest('.tbl_menulist').siblings('ul').find('ul').css('display','none');
		}
		$(this).parent().toggleClass('open');
		$(this).parent().parents('.depth1 > li').children('.depth2').slideToggle();
	});
	
	$('.depth2 .id.more > i').on('click',function(){
		if(!$(this).parent().hasClass('open')){
			$(this).parent().closest('.tbl_menulist').siblings('ul').find('.id').removeClass('open');
			$(this).parent().closest('.tbl_menulist').siblings('ul').find('ul').css('display','none');	
		}
		$(this).parent().toggleClass('open');
		$(this).parent().closest('.tbl_menulist').siblings('ul').slideToggle();
	});
	
	<%-- 전체열기 클릭시 --%>
	$('.btn_open').on('click',function(){
		
		<%-- open 클래스 부여 --%>
		$(this).parents("[class^='board_top']").siblings('ul').find('.dep1').addClass('open');
		$(this).parents("[class^='board_top']").siblings('ul').find('.more').addClass('open');
		
		<%-- 토글 열기 --%>
		$(this).parents("[class^='board_top']").siblings('ul').children('li').children('.depth2').slideDown();
		$(this).parents("[class^='board_top']").siblings('ul').children('li').children('.depth2').children('li').children('.depth3').slideDown();
		$(this).parents("[class^='board_top']").siblings('ul').children('li').children('.depth2').children('li').children('.depth3').children('li').children('.depth4').slideDown();
		$(this).parents("[class^='board_top']").siblings('ul').children('li').children('.depth2').children('li').children('.depth3').children('li').children('.depth4').children('li').children('.depth5').slideDown();
		
	});
	
	<%-- 전체닫기 클릭시 --%>
	$('.btn_close').on('click',function(){
		$(this).parents("[class^='board_top']").siblings('ul').children('li').children('.depth2').slideUp();
		$(this).parents("[class^='board_top']").siblings('ul').find('.id').removeClass('open');;
	});

	<%-- 메뉴 클릭시 ajax 함수호출 --%>
	$('.onclick_td').on('click',function(){

		<%-- 콘텐츠 form을 불러와 작성 중이일때 실행 다시 form 바꾸기--%>
		if($.contains(document.body, document.getElementById("defaultFrmTmpl"))){
			$("#addContTmpl").html("");
			$("#addContTmpl").css("display","none");
			$("#addForm").css("display","inline-block");
		}
		 
		$('.onclick_point').removeClass('onclick_point');
		$(this).parent().addClass("onclick_point");
		var menuCd = $(this).data("menucd");
		<%--메뉴 form 새로 생성 --%>
		fncCalladdForm(menuCd)
		<%-- 콘텐츠 form 지우기 --%>
		$("#addContTmpl").html("");
	});

	<%--  + 클릭시 form 초기화후 uprMenuCd에 데이터 입력 --%>
	$('.cell-ctrl-bt-add').on('click',function(){
		var menuCd = $(this).parent().data("menucd");
		var menuLvl = Number($(this).parent().data("menulvl"))+1;	
		var menuSeqo = Number($("td[data-menulvl='"+menuLvl+"'][data-uprmenucd='"+menuCd+"']").length) +1;
		var lwrTabYn = $(this).parent().data("lwrtabyn");
		var url = $(this).parent().data("url");
		fncCalladdForm().done(function(data){
			fncModifyForm( menuCd, menuLvl, menuSeqo, lwrTabYn, url);
		});		
	});

	<%-- 쓰기 권한이 있을때만 --%>
	<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY}">
		<%-- 위아래 처리 --%>
		const fncSort = function(type, uprMenuCd, menuCd, menuSeqo, menuLvl){
			$("#menuLvl").val(menuLvl);
			$("#uprMenuCd").val(uprMenuCd);
			$("#menuCd").val(menuCd);
			$("#menuSeqo").val(menuSeqo);
			$.ajax({
			    method: "POST",
			    url: type+"Proc",
			    data : $("#defaultFrm").serialize(),
			    dataType: "json",
			    success: function(data) {
			    	fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');
			    },error : function(xhr, status, error){
					 if (xhr.status == 401) {
						window.location.reload();
					 }
					 alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
				}
			});
		}
	
		<%--  메뉴삭제 --%>
		$('.cell-ctrl-bt-trash').on('click',function(){
			$("#menuCd").val($(this).parent().data("menucd"));
			fncProc("delete",$('#defaultFrm').serialize(),function(data){
				alert(data.message);			
				<%-- onsubmit 속성 삭제 --%>
				$("#defaultFrm").removeAttr("onsubmit");
				<%-- 폼 속성 설정 및 제출 --%>		
				fncPageBoard('addList','addList.do','<c:out value="${searchVO.currentPageNo}"/>');	
			})
		});
	
		<%-- depth0 등록 +버튼 클릭시 --%>
		$('#btn_depth0').on('click', function(){
			$('.onclick_point').removeClass('onclick_point');
			fncCalladdForm().done(function(data){
				var menuSeqo = Number($("td[data-menulvl='0']").length) +1
				$("#menuSeqo").val(menuSeqo);
				$("#menuSeqo_span").text(menuSeqo);
			});
		});	
	
		<%-- 메뉴 순서 변경 --%>
		$('.sort').on('click', function () {
			var type = $(this).data('type');
			var uprMenuCd = $(this).parent().data('uprmenucd');
			var menuLvl = $(this).parent().data('menulvl');
			var menuCd = $(this).parent().data('menucd');
			var menuSeqo = $(this).parent().data('menuseqo');
			<%--같은 부모의 자식갯수 찾기 --%>
			var length = Number($("td[data-uprmenucd='"+uprMenuCd+"']").length);
	
			if(type == 'up'){
				if(menuSeqo == '1'){
					alert("첫번째 항목입니다.")
					return false;
				}
			}else if(type == 'down'){
				if(menuSeqo == length){
					alert("마지막 항목입니다.")
					return false;
				}
			}
			<%-- 순서 정렬 실행--%>
			fncSort(type, uprMenuCd, menuCd, menuSeqo, menuLvl);
		});
	</c:if>
	
	<%-- 엑셀 다운로드 --%>
	$('#btn_excel').on('click', function(){
		<c:choose>
			<c:when test="${fn:length(resultList) > 0 }">
				fncPageBoard("view", "excelDownload.do");
				$("#defaultFrm").attr("onsubmit","return false;");
			</c:when>
			<c:otherwise>
				alert("데이터가 없습니다");
				return false;
			</c:otherwise>
		</c:choose>	
	});
});
</script>
<div class="menu_area">
	<div class="menu_list scr_box w38p" data-simplebar data-simplebar-auto-hide="false">
		<div class="board_top">
			<div class="board_left">
				<i class="name"></i>메뉴명 
				<span class="btn_allclose btn_open">전체열기</span>
				<span class="btn_allclose btn_close">전체닫기</span>
			</div>
			<div class="board_right">
				<button class="btn btn_excel" id="btn_excel">엑셀 다운로드</button>
				<c:if test="${sessionScope.SESSION_ITSM_WRITE_BTN_KEY}">
					<button id="btn_depth0" class="btn blue"><i class="xi-plus"></i></button>
				</c:if>
			</div>
		</div>
		<ul class="depth1">
			<c:if test="${fn:length(resultList) > 0 }">
				<c:forEach var="menu" items="${resultList}">
					<c:if test="${menu.menuLvl eq 1}">
						<li>
							<table class="tbl_menulist">
								<caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
								<colgroup>
									<col class="w65p">
									<col class="w35p">
								</colgroup>
								<tbody>
									<tr>
										<td class="onclick_td dep1 id <c:out value="${menu.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
											<i></i> <label><c:out value="${menu.menuNm }" /></label>
										</td> 
										<td class="r <c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
											data-uprmenucd="<c:out value='${menu.uprMenuCd}'/>"
											data-menucd="<c:out value='${menu.menuCd}'/>"
											data-menulvl="<c:out value='${menu.menuLvl}'/>"
											data-lwrtabyn="<c:out value='${menu.lwrTabYn}'/>"
											data-menuseqo="<c:out value='${menu.menuSeqo}'/>"
											data-url="/<c:out value="${menu.menuCd}"/>/">
											<a href="javascript:void(0)" class="cell-ctrl-bt-add"></a> 
											<a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a> 
											<a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a> 
											<a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
										</td>
									</tr>
								</tbody>
							</table> <c:if test="${menu.isLeaf eq 1}">
								<ul class="depth2">
									<c:forEach var="menu2" items="${resultList}">
										<c:if test="${menu2.uprMenuCd eq menu.menuCd}">
											<li>
												<table class="tbl_menulist">
													<caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
													<colgroup>
														<col class="w65p">
														<col class="w35p">
													</colgroup>
													<tbody>
														<tr>
															<td class="onclick_td id <c:out value="${menu2.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu2.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
																<i></i><label><c:out value="${menu2.menuNm }" /></label>
															</td>
															<td class="r <c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
																data-uprmenucd="<c:out value='${menu2.uprMenuCd}'/>"
																data-menucd="<c:out value='${menu2.menuCd}'/>"
																data-menulvl="<c:out value='${menu2.menuLvl}'/>"
																data-lwrtabyn="<c:out value='${menu2.lwrTabYn}'/>"
																data-menuseqo="<c:out value='${menu2.menuSeqo}'/>"
																data-url="/<c:out value='${menu.menuCd}'/>/<c:out value="${menu2.menuCd}"/>/">
																<a href="javascript:void(0)" class="cell-ctrl-bt-add"></a>
																<a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a> 
																<a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a> 
																<a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
															</td>
														</tr>
													</tbody>
												</table> <c:if test="${menu2.isLeaf eq 1}">
													<ul class="depth3">
														<c:forEach var="menu3" items="${resultList}">
															<c:if test="${menu3.uprMenuCd eq menu2.menuCd}">
																<li>
																	<table class="tbl_menulist">
																		<caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
																		<colgroup>
																			<col class="w65p">
																			<col class="w35p">
																		</colgroup>
																		<tbody>
																			<tr>
																				<td class="onclick_td id <c:out value="${menu3.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu3.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
																					<i></i> <label><c:out value="${menu3.menuNm }" /></label>
																				</td>
																				<td class="r <c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>"
																					data-uprmenucd="<c:out value='${menu3.uprMenuCd}'/>"
																					data-menucd="<c:out value='${menu3.menuCd}'/>"
																					data-menulvl="<c:out value='${menu3.menuLvl}'/>"
																					data-lwrtabyn="<c:out value='${menu3.lwrTabYn}'/>"
																					data-menuseqo="<c:out value='${menu3.menuSeqo}'/>"
																					data-url="/<c:out value='${menu.menuCd}'/>/<c:out value='${menu2.menuCd}'/>/<c:out value='${menu3.menuCd}'/>/">
																					<a href="javascript:void(0)" class="cell-ctrl-bt-add"></a> 
																					<a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a> 
																					<a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a>
																					<a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
																				</td>
																			</tr>
																		</tbody>
																	</table> <c:if test="${menu3.isLeaf eq 1}">
																		<ul class="depth4">
																			<c:forEach var="menu4" items="${resultList}">
																				<c:if test="${menu4.uprMenuCd eq menu3.menuCd}">
																					<li>
																						<table class="tbl_menulist">
																							<caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
																							<colgroup>
																								<col class="w65p">
																								<col class="w35p">
																							</colgroup>
																							<tbody>
																								<tr>
																									<td class="onclick_td id <c:out value="${menu4.isLeaf eq 1 ? 'more' : ''}"/>" data-menucd="<c:out value='${menu4.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
																										<i></i> <label><c:out value="${menu4.menuNm }" /></label>
																									</td>
																									<td class="r <c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>" 
																										data-uprmenucd="<c:out value='${menu4.uprMenuCd}'/>"
																										data-menucd="<c:out value='${menu4.menuCd}'/>"
																										data-menulvl="<c:out value='${menu4.menuLvl}'/>"
																										data-lwrtabyn="<c:out value='${menu4.lwrTabYn}'/>"
																										data-menuseqo="<c:out value='${menu4.menuSeqo}'/>"
																										data-url="/<c:out value="${menu.menuCd}"/>/<c:out value="${menu2.menuCd}"/>/<c:out value="${menu3.menuCd}"/>/<c:out value='${menu4.menuCd}'/>/">
																										<a href="javascript:void(0)" class="cell-ctrl-bt-add"></a> 
																										<a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a>
																										<a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a> 
																										<a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
																									</td>
																								</tr>
																							</tbody>
																						</table> <c:if test="${menu4.isLeaf eq 1}">
																							<ul class="depth5">
																								<c:forEach var="menu5" items="${resultList}">
																									<c:if test="${menu5.uprMenuCd eq menu4.menuCd}">
																										<li>
																											<table class="tbl_menulist">
																												<caption>목록(폴더,메뉴명, 추가, 순서변겅, 삭제 등으로 구성)</caption>
																												<colgroup>
																													<col class="w65p">
																													<col class="w35p">
																												</colgroup>
																												<tbody>
																													<tr class="cursor">
																														<td class="onclick_td id" data-menucd="<c:out value='${menu5.menuCd}'/>" colspan="<c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : '2'}"/>">
																															<i></i> <label><c:out value="${menu5.menuNm }" /></label>
																														</td>
																														<td class="r <c:out value="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY ? '' : 'disno'}"/>" 
																															data-uprmenucd="<c:out value='${menu5.uprMenuCd}'/>"
																															data-menucd="<c:out value='${menu5.menuCd}'/>"
																															data-menuseqo="<c:out value='${menu5.menuSeqo}'/>"
																															data-menulvl="<c:out value='${menu5.menuLvl}'/>">
																															<a href="javascript:void(0)" class="cell-ctrl-bt-up sort" data-type="up"></a>
																															<a href="javascript:void(0)" class="cell-ctrl-bt-down sort" data-type="down"></a>
																															<a href="javascript:void(0)" class="cell-ctrl-bt-trash"></a>
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
							</c:if>
						</li>
					</c:if>
				</c:forEach>
			</c:if>
		</ul>
	</div>
	<div id="addForm" class="menu_form w60p disinb"></div>
	<div id="addContTmpl" class="w60p display_none">
	</div>
</div>
