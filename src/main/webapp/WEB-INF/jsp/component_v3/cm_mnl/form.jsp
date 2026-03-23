<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/ckeditor/ckeditor.js?ver=1"></script>
<script type="text/javascript">
<%-- 항목 수 --%>
let itemIdx = '<c:out value="${fn:length(itemList)}"/>' - 1;

<%-- 에디터 세팅 --%>
const cm_fncSetEditor = function(id){
	CKEDITOR.replace(id, {height : 400, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>/ma/js/ckeditor/contents.css'});
}
<%-- 유형 구분에 따른 tr 추가 --%>
const cm_fncSelType = function(obj){
	
	let mnlItmClCd = $(obj).val();
	let idx = $(obj).attr('id').split('_')[1];
	
	<%-- 기존 tr 삭제 --%>
  	$('#mnlItem_' + idx).find('.tr_type_' + idx).nextAll().remove();
	
  	<%-- tr 추가 --%>
	$.ajax({
        url       : 'addType.do'
        ,type     : 'get'
        ,data	  : {'mnlItmClCd' : mnlItmClCd}
        ,dataType : 'html'
        ,success  : function(data){
        	data = data.split('$idx$').join(idx);
        	$('#mnlItem_' + idx).find('.tr_type_' + idx).after(data);
        },error	  : function (xhr, status, error) {
			// 로그인 세션 없는 경우
			if (xhr.status == 401) {
				window.location.reload();
			}
		}
    }).done(function(){
    	if(mnlItmClCd === 'ctt'){
    		cm_fncSetEditor('dtlsCtt_' + idx);
    	} else if(mnlItmClCd === 'img'){
    		$('#imgAtchFileUpload_' + idx).html(setFileList($('#atchFileId_' + idx).val(), 'atchFileId_' + idx, 'image', '5'));
    	}
    });
}
<%-- 버튼 세팅 --%>
const cm_fncSetBtn = function(){
	<%-- 버튼 추가 --%>
	$('.btn_addItem').remove();
	$('[id^="mnlItem_"]:last').find('.btn_delItem').before('<button type="button" class="btn ic btn_addItem"><i class="xi-plus"></i></button>');
	
	<%-- 추가 클릭 트리거 --%>
	$('.btn_addItem').on('click', function(){
		cm_fncAddItem();
	});
	
	<%-- 삭제 클릭 트리거 --%>
	$('.btn_delItem:last').off().on('click', function(){
    	cm_fncDelItem(this);
    });
}
<%-- 항목 추가 --%>
const cm_fncAddItem = function(){
	
	itemIdx++;
	
	<%-- 항목폼 추가 --%>
	$.ajax({
        url       : 'addItem.do'
        ,type     : 'get'
        ,dataType : 'html'
        ,success  : function(data){
        	data = data.split('$idx$').join(itemIdx);
        	data = data.split('$itmIdx$').join($('#item_wrap [id^="mnlItem_"]').length + 1);
        	$('#item_wrap').append(data);
        },error	  : function (xhr, status, error) {
			// 로그인 세션 없는 경우
			if (xhr.status == 401) {
				window.location.reload();
			}
		}
    }).done(function(){
    	
    	<%-- 버튼 세팅 --%>
    	cm_fncSetBtn();
    	
    	<%-- 유형 변경 트리거 --%>
    	$('#mnlItem_' + itemIdx).find('#mnlItmClCd_' + itemIdx).off().on('change', function(){
    		cm_fncSelType(this);
    	});
    });
	
	
}
<%-- 항목 삭제 --%>
const cm_fncDelItem = function(obj){
	if($('#item_wrap [id^="mnlItem_"]').length > 1){
		if(confirm('정말 삭제하시겠습니까?')){
	
			<%-- 항목 삭제 --%>
			$(obj).closest('div[id^="mnlItem_"]').remove();
			<%-- 항목번호 재정렬 --%>
	    	cm_fncSetItemNo();
	    	<%-- 버튼 세팅 --%>
	    	cm_fncSetBtn();
		}
	} else {
		alert('항목은 한 개 이상 입력해야합니다.');
	}
}
<%-- 항목번호 재졍렬 --%>
const cm_fncSetItemNo = function(){
	$('#item_wrap [id^="mnlItem_"]').each(function(index){
		$(this).find('.board_left').children('.md_tit').html('항목' + (index + 1));
	});
}
<%-- 배열 name값 재할당 --%>
const cm_fncRelocation = function(){
	$("div[id^=mnlItem_]").each(function(index, item){
		let idxCnt = $(this).attr("id").split("_")[1];
		$("#mnlItmSerno_" + idxCnt).attr("name", "itemList["+index+"].mnlItmSerno");
		$("#mnlItmSeqo_" + idxCnt).attr("name", "itemList["+index+"].mnlItmSeqo");
		$("#mnlItmSeqo_" + idxCnt).val(index);
		$("#mnlItmClCd_" + idxCnt).attr("name", "itemList["+index+"].mnlItmClCd");
		$("#htmlSrcdCtt_" + idxCnt).attr("name", "itemList["+index+"].htmlSrcdCtt");
		$("#cssSrcdCtt_" + idxCnt).attr("name", "itemList["+index+"].cssSrcdCtt");
		$("#jsSrcdCtt_" + idxCnt).attr("name", "itemList["+index+"].jsSrcdCtt");
		$("#javaSrcdCtt_" + idxCnt).attr("name", "itemList["+index+"].javaSrcdCtt");
		$("#xmlSrcdCtt_" + idxCnt).attr("name", "itemList["+index+"].xmlSrcdCtt");
		$("#titlNm_" + idxCnt).attr("name", "itemList["+index+"].titlNm");
		$("#subTitlNm_" + idxCnt).attr("name", "itemList["+index+"].subTitlNm");
		$("#dtlsCtt_" + idxCnt).attr("name", "itemList["+index+"].dtlsCtt");
		$("#atchFileId_" + idxCnt).attr("name", "itemList["+index+"].atchFileId");
		$("#urlAddr_" + idxCnt).attr("name", "itemList["+index+"].urlAddr");
	}); 
	
	return true;
}
$(document).ready(function(){

	<%-- 첨부파일 등록폼 생성 --%>
	$('#atchFileUpload').html(setFileList($('#atchFileId').val(), 'atchFileId', 'upload'));
	
	<c:choose>
		<c:when test="${fn:length(itemList) > 0}">
			<%-- 이미지 등록폼 생성 --%>
			$('[id^="imgAtchFileUpload_"]').each(function(){
				$(this).html(setFileList($('#atchFileId_' + $(this).attr('id').split('_')[1]).val(), 'atchFileId_' + $(this).attr('id').split('_')[1], 'image', '5'));
			});
			
			<%-- 에디터 세팅 --%>
			$('textarea[id^="dtlsCtt_"]').each(function(){
				cm_fncSetEditor($(this).attr('id'));
			});
		</c:when>
		<c:otherwise>
			<%-- 항목 폼 생성 --%>
			cm_fncAddItem();
		</c:otherwise>
	</c:choose>
	
	<%-- 항목 드래그앤드롭 --%>
    $("#item_wrap").sortable({
        stop : function(){
        	<%-- 항목번호 재정렬 --%>
        	cm_fncSetItemNo();
        	<%-- 버튼 세팅 --%>
        	cm_fncSetBtn();
        }
    });  
	
	<%-- 항목 추가 클릭시 --%>
    $('.btn_addItem').on('click', function(){
    	cm_fncAddItem();
    });
    
	<%-- 항목 삭제 클릭시 --%>
    $('.btn_delItem').off().on('click', function(){
    	cm_fncDelItem(this);
    });
    
	<%-- 등록, 수정 클릭시 --%>
	$('#btn_submit').on('click', function(){
		
		$('textarea[id^="dtlsCtt_"]').each(function(){
			$(this).val(CKEDITOR.instances[$(this).attr('id')].getData());
 		});
		
		<%-- 유효성 체크 --%>
		if(wrestSubmit(document.defaultFrm)){
			<%-- 파일 업로드--%>
			fileFormSubmit("defaultFrm", "<c:out value='${searchVO.procType}'/>", function () {
				<%-- 배열 name값 재할당 --%>
				if(cm_fncRelocation()){
					fncProc('<c:out value="${searchVO.procType}"/>');	
				}
			});
		}
	});
	
});

</script>
<form:form modelAttribute="cmMnlVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="mnlSerno"/>
	<form:hidden path="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<caption>내용(메뉴구분명, 담당자명, 메뉴설명, 첨부파일, 항목 등으로 구성)</caption>
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>메뉴구분명</th>
				<td>
					<form:input path="menuClNm" id="menuClNm" cssClass="w100p" title="메뉴구분명" maxlength="20" required="true"/>
				</td>
				<th scope="row"><span class="asterisk">*</span>담당자명</th>
				<td>
					<form:input path="tchgrNm" id="tchgrNm" cssClass="w100p" title="담당자명" maxlength="20" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>메뉴설명</th>
				<td colspan="3">
					<form:input path="menuExpl" id="menuExpl" cssClass="w100p" title="메뉴설명" maxlength="100" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<div id="atchFileUpload"></div>
				</td>
			</tr>
		</tbody>
	</table>
	<div id="item_wrap">
		<c:if test="${fn:length(itemList) > 0}">
			<c:forEach var="item" items="${itemList }" varStatus="status">
				<div id="mnlItem_<c:out value="${status.index }"/>" class="mnlItem mar_t30">
					<div class="board_top">
					    <div class="board_left">
					        <h4 class="md_tit">항목<span id="itemCnt_<c:out value="${status.index}"/>"><c:out value="${status.count }"/></span></h4>
					    </div>
					    <div class="board_right">
						    <c:if test="${status.last }">
						       	<button type="button" class="btn ic btn_addItem"><i class="xi-plus"></i></button>
						    </c:if>
					       	<button type="button" class="btn ic btn_delItem"><i class="xi-trash"></i></button>
					    </div>
					</div>
					<table id="item_<c:out value="${status.index }"/>" class="board_write">
						<caption>내용(항목구분, 옵션으로 구성)</caption>
						<colgroup>
							<col class="w20p"/>
							<col/>
							<col class="w20p"/>
							<col/>
						</colgroup>
						<tbody>
							<tr class="tr_type_<c:out value="${status.index }"/>">
								<th scope="row"><span class="asterisk">*</span>항목구분</th>
								<td colspan="3">
									<input type="hidden" id="mnlItmSerno_<c:out value="${status.index }"/>" value="<c:out value="${item.mnlItmSerno }"/>"/>
									<input type="hidden" id="mnlItmSeqo_<c:out value="${status.index }"/>" value="<c:out value="${item.mnlItmSeqo }"/>"/>
									<select id="mnlItmClCd_<c:out value="${status.index }"/>" title="항목구분" required="required">
										<option value="">선택</option>
										<option value="title" <c:out value="${item.mnlItmClCd eq 'title' ? 'selected=selected' : '' }"/>>제목</option>
										<option value="subTitle" <c:out value="${item.mnlItmClCd eq 'subTitle' ? 'selected=selected' : '' }"/>>부제목</option>
										<option value="ctt" <c:out value="${item.mnlItmClCd eq 'ctt' ? 'selected=selected' : '' }"/>>상세내용</option>
										<option value="code" <c:out value="${item.mnlItmClCd eq 'code' ? 'selected=selected' : '' }"/>>소스코드</option>
										<option value="img" <c:out value="${item.mnlItmClCd eq 'img' ? 'selected=selected' : '' }"/>>이미지</option>
										<option value="url" <c:out value="${item.mnlItmClCd eq 'url' ? 'selected=selected' : '' }"/>>URL주소</option>
									</select>
								</td>
							</tr>
							<c:choose>
								<c:when test="${item.mnlItmClCd eq 'code' }">
									<tr>
										<th scope="row">HTML</th>
										<td colspan="3">
											<textarea id="htmlSrcdCtt_<c:out value="${status.index }"/>" title="HTML 소스코드"><c:out value="${item.htmlSrcdCtt }"/></textarea>
										</td>
									</tr>
									<tr>
										<th scope="row">CSS</th>
										<td colspan="3">
											<textarea id="cssSrcdCtt_<c:out value="${status.index }"/>" title="CSS 소스코드"><c:out value="${item.cssSrcdCtt }"/></textarea>
										</td>
									</tr>
									<tr>
										<th scope="row">JS</th>
										<td colspan="3">
											<textarea id="jsSrcdCtt_<c:out value="${status.index }"/>" title="JS 소스코드"><c:out value="${item.jsSrcdCtt }"/></textarea>
										</td>
									</tr>
									<tr>
										<th scope="row">JAVA</th>
										<td colspan="3">
											<textarea id="javaSrcdCtt_<c:out value="${status.index }"/>" title="JAVA 소스코드"><c:out value="${item.javaSrcdCtt }"/></textarea>
										</td>
									</tr>
									<tr>
										<th scope="row">XML</th>
										<td colspan="3">
											<textarea id="xmlSrcdCtt_<c:out value="${status.index }"/>" title="XML 소스코드"><c:out value="${item.xmlSrcdCtt }"/></textarea>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<th scope="row"><span class="asterisk">*</span>옵션</th>
										<td colspan="3">
											<c:choose>
												<c:when test="${item.mnlItmClCd eq 'title' }">
													<input type="text" id="titlNm_<c:out value="${status.index }"/>" class="w100p" value="<c:out value="${item.titlNm }"/>" title="제목" maxlength="30" required="true"/>
												</c:when>
												<c:when test="${item.mnlItmClCd eq 'subTitle' }">
													<input type="text" id="subTitlNm_<c:out value="${status.index }"/>" class="w100p" value="<c:out value="${item.subTitlNm }"/>" title="부제목" maxlength="30" required="true"/>
												</c:when>
												<c:when test="${item.mnlItmClCd eq 'ctt' }">
													<textarea id="dtlsCtt_<c:out value="${status.index }"/>" title="상세내용" required="true">
														<c:out value="${item.dtlsCtt}"/>
													</textarea>
												</c:when>
												<c:when test="${item.mnlItmClCd eq 'img' }">
													<div id="imgAtchFileUpload_<c:out value="${status.index }"/>"></div>
													<input type="hidden" id="atchFileId_<c:out value="${status.index }"/>" value="<c:out value="${item.atchFileId }"/>" required="true"/>
												</c:when>
												<c:when test="${item.mnlItmClCd eq 'url' }">
													<input type="text" id="urlAddr_<c:out value="${status.index }"/>" class="w100p" value="<c:out value="${item.urlAddr }"/>" title="URL주소" maxlength="300" required="true"/>
												</c:when>
											</c:choose>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</c:forEach>
		</c:if>
	</div>
</form:form>
<div class="btn_area">
	<button type="button" id="btn_submit" class="btn blue"><c:out value="${empty cmMnlVO.mnlSerno ? '등록' : '수정'}"/></button>
	<c:if test="${not empty cmMnlVO.mnlSerno }"><a href="javascript:void(0)" id="btn_del" class="btn red">삭제</a></c:if>
	<button type="button" id="btn_<c:out value="${empty cmMnlVO.mnlSerno ? 'list' : 'view'}"/>" class="btn gray">취소</button>
</div>