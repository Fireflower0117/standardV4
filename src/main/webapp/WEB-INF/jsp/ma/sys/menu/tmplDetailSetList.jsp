<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:if test="${fn:length(setList) > 0 }">
	<c:set var="num" value="${tmplTotalCnt }"/>
	<c:forEach var="item" items="${setList }" varStatus="status">
		<c:choose>
			<c:when test="${fn:contains(item.editrCont, 'tbl_temp_wrap') }">
				<c:forEach begin="1" end="${item.tmplCnt}">
					<c:set var="num" value="${num + 1 }"/>
					<li class="tbl_li cursor" data-num="<c:out value="${num}"/>" data-tmplserno="<c:out value="${item.tmplSerno}"/>" data-editrcont="<c:out value="${item.editrCont}"/>" data-tmplexpl="<c:out value="${item.tmplExpl}"/>" data-editrtemp="<c:out value="${item.editrCont }"/>">
						<div id="temp_tbl_<c:out value="${item.tmplSerno}"/>_<c:out value="${num}"/>" class="disno"></div>
						<p class="text_over ellipsis">
							<button class="btn_select_delete" title="삭제" style="margin-bottom: 2px;"></button><span><c:out value="${item.tmplExpl}"/></span>
							<button class="state blue btn_tbl_set" title="상세설정" style="line-height: 0px;">상세설정</button>
							<img src="/ma/images/icon/i_okay.png" alt="설정완료" class="btn_tbl_set_on">
						</p>
						<div class="btns">
							<button class="cell-ctrl-bt-up btn_move_set" title="위로" data-move="up">순서 위로</button>
							<button class=" cell-ctrl-bt-down btn_move_set" title="아래로" data-move="down">순서 아래로</button>
						</div>
						<div class="tbl_detail">
							<dl>
								<dt>생성 (행 x 열)</dt>
								<dd>
									<input type="text" id="dynmTbl_row_<c:out value="${item.tmplSerno}_${num}"/>" class="w30p numOnly" maxlength="2" value="">
									&nbsp;&nbsp;X&nbsp;&nbsp;
									<input type="text" id="dynmTbl_col_<c:out value="${item.tmplSerno}_${num}"/>" class="w30p numOnly" maxlength="2" value="">
									&nbsp;&nbsp;
									<a href="javascript:void(0);" class="btn sml btn_ok" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>">확인</a>
								</dd>
							</dl>
							<dl>
						        <dt>병합</dt>
							        <dd>
							            <a href="javascript:void(0);" class="btn sml btn_mgr_tbl" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>">설정</a>
							            &nbsp;
							            <a href="javascript:void(0);" class="btn sml btn_unmgr_tbl" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>">해제</a>
							        </dd>
							    </dl>
							    <dl>
							        <dt>타이틀</dt>
							        <dd>
							            <a href="javascript:void(0);" class="btn sml btn_set_title" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>" data-divn="M">메인</a>
							            &nbsp;
							            <a href="javascript:void(0);" class="btn sml btn_set_title" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>" data-divn="S">서브</a>
							            &nbsp;
							            <a href="javascript:void(0);" class="btn sml btn_set_title" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>" data-divn="U">해제</a>
							            </dd>
					        </dl>
							<div class="tbl_view">
								<table id="dynmTbl_<c:out value='${item.tmplSerno}'/>_<c:out value="${num}"/>">
									<colgroup id="colGrp_<c:out value="${item.tmplSerno}"/>_<c:out value="${num}"/>"></colgroup>
									<tbody id="dynmTbd_<c:out value="${item.tmplSerno}"/>_<c:out value="${num}"/>"></tbody>
								</table>
					    	</div>
					        <div class="btn_area">
					            <a href="javascript:void(0);" class="btn sml btn_reset_tbl" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>">초기화</a>
					            &nbsp;
					            <a href="javascript:void(0);" class="btn sml blue  btn_save_tbl" data-tmplSerno="<c:out value="${item.tmplSerno}"/>" data-num="<c:out value="${num}"/>">저장</a>
					        </div>
					    </div>
					</li>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach begin="1" end="${item.tmplCnt }">
					<c:set var="num" value="${num + 1 }"/>
					<li class="cursor" data-num="<c:out value='${num}'/>" data-tmplserno="<c:out value="${item.tmplSerno}"/>" data-editrcont="<c:out value="${item.editrCont}"/>" data-tmplexpl="<c:out value="${item.tmplExpl}"/>">
						<p class="text_over ellipsis">
							<button class="btn_select_delete" title="삭제" style="margin-bottom: 2px;"></button><span><c:out value="${item.tmplExpl}"/></span>
						</p>
						<div class="btns">
							<button class="cell-ctrl-bt-up btn_move_set" title="위로" data-move="up">순서 위로</button>
							<button class="cell-ctrl-bt-down btn_move_set" title="아래로" data-move="down">순서 아래로</button>
						</div>
			        </li>	
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:if>