<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
<%-- 관련사이트 수 --%>
let siteIdx = '<c:out value="${fn:length(resultList)}"/>' - 1;

<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
	<%-- 버튼 세팅 --%>
	const fncSetBtn = function(){
		<%-- 버튼 추가 --%>
		$('.btn_addSite').remove();
		$('[id^="relSite_"]:last').find('.btn_delSite').before('<button type="button" class="btn ic btn_addSite"><i class="xi-plus"></i></button>');
		
		<%-- 추가 클릭 트리거 --%>
		$('.btn_addSite').on('click', function(){
			fncAddSite();
		});
		
		<%-- 추가 클릭 트리거 --%>
		$('.btn_delSite:last').off().on('click', function(){
	    	fncDelSite(this);
	    });
	}
	<%-- 항목 추가 --%>
	const fncAddSite = function(){
		
		siteIdx++;
		
		<%-- 항목폼 추가 --%>
		$.ajax({
	        url      : 'addSite.do'
	        ,type     : 'get'
	        ,dataType : 'html'
	        ,success  : function(data){
	        	data = data.split('$idx$').join(siteIdx);
	        	$('#site_wrap').append(data);
	        },error : function (xhr, status, error) {

				// 로그인 세션 없는 경우
				if (xhr.status == 401) {
					window.location.reload();
				}
			}
	    }).done(function(){
	    	
	    	<%-- 첨부파일 세팅 --%>
			$('#atchFileUpload_' + siteIdx).html(setFileList($('#atflSerno_' + siteIdx).val(), 'atflSerno_' + siteIdx, 'image', '1'));
			
	    	<%-- 버튼 세팅 --%>
	    	fncSetBtn();
	    });
		
		
	}
	<%-- 항목 삭제 --%>
	const fncDelSite = function(obj){
		if($('#site_wrap [id^="relSite_"]').length > 1){
			if(confirm('정말 삭제하시겠습니까?')){
		
				<%-- 항목 삭제 --%>
				$(obj).closest('div[id^="relSite_"]').remove();
		    	<%-- 버튼 세팅 --%>
		    	fncSetBtn();
			}
		} else {
			alert('항목은 한 개 이상 입력해야합니다.');
		}
	}
	<%-- 배열 name값 재할당 --%>
	const fncRelocation = function(){
		$("div[id^=relSite_]").each(function(index, item){
			let idxCnt = $(this).attr("id").split("_")[1];
			$("#relSiteSerno_" + idxCnt).attr("name", "relSiteList["+index+"].relSiteSerno");
			$("#seqo_" + idxCnt).attr("name", "relSiteList["+index+"].seqo");
			$("#seqo_" + idxCnt).val(index);
			$("#relSiteUrlAddr_" + idxCnt).attr("name", "relSiteList["+index+"].relSiteUrlAddr");
			$("#atflSerno_" + idxCnt).attr("name", "relSiteList["+index+"].atflSerno");
			$("#relSiteNm_" + idxCnt).attr("name", "relSiteList["+index+"].relSiteNm");
		});

		return true;
	}
</c:if>
$(document).ready(function(){

	<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
		<c:choose>
			<c:when test="${fn:length(resultList) > 0}">
				<%-- 첨부파일 세팅 --%>
				$('[id^="atchFileUpload_"]').each(function(){
					let atflIdx = $(this).attr('id').split('_')[1];
					$(this).html(setFileList($('#atflSerno_' + atflIdx).val(), 'atflSerno_' + atflIdx, 'image', '1'));
				});
			</c:when>
			<c:otherwise>
				<%-- 사이트 폼 생성 --%>
				fncAddSite();
			</c:otherwise>
		</c:choose>
	
		<%-- 항목 드래그앤드롭 --%>
	    $("#site_wrap").sortable({
	        stop : function(){
	        	<%-- 버튼 세팅 --%>
	        	fncSetBtn();
	        }
	    });  
		
		<%-- 항목 추가 클릭시 --%>
	    $('.btn_addSite').on('click', function(){
	    	fncAddSite();
	    });
	    
		<%-- 항목 삭제 클릭시 --%>
	    $('.btn_delSite').off().on('click', function(){
	    	fncDelSite(this);
	    });
	    
		<%-- 등록,수정 처리 --%>
		$('#btn_submit').on('click', function(){
			<%-- 유효성 체크 --%>
			if(wrestSubmit(document.defaultFrm)){
				<%-- 배열 재할당 --%>
				if(fncRelocation()){
					fileFormSubmit("defaultFrm", "<c:out value='${fn:length(resultList) > 0 ? \'update\' : \'insert\'}'/>", function () {
						fncProc("<c:out value='${fn:length(resultList) > 0 ? \'update\' : \'insert\'}'/>");
					}, 'NO_DEL');
				}
			}
		});
	</c:if>
});

</script>
<form name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<div id="site_wrap">
		<c:if test="${fn:length(resultList) > 0}">
			<c:forEach var="result" items="${resultList }" varStatus="status">
				<div id="relSite_<c:out value="${status.index }"/>" <c:out value="${not status.first ? 'class=mar_t30' : '' }"/>>
					<div class="board_top">
					    <div class="board_right">
						    <c:if test="${status.last }">
						       	<button type="button" class="btn ic btn_addSite"><i class="xi-plus"></i></button>
						    </c:if>
					       	<button type="button" class="btn ic btn_delSite"><i class="xi-trash"></i></button>
					    </div>
					</div>
					<table class="board_write">
						<caption>내용(URL주소, 사이트명으로 구성)</caption>
						<colgroup>
							<col class="w20p">
				            <col>
				            <col class="w20p">
				            <col>
						</colgroup>
						<tbody>
							<tr>
				                <th scope="row"><span class="asterisk">*</span>URL주소</th>
				                <td>
				                	<input type="hidden" id="relSiteSerno_<c:out value="${status.index }"/>" value="<c:out value="${result.relSiteSerno }"/>"/>
				                	<input type="hidden" id="seqo_<c:out value="${status.index }"/>" value="<c:out value="${result.seqo }"/>"/>
				                	<input type="text" id="relSiteUrlAddr_<c:out value="${status.index }"/>" class="w100p" value="<c:out value="${result.relSiteUrlAddr }"/>" title="URL주소" maxlength="300" required="true"/>
				                </td>
				                <th scope="row" rowspan="2">사이트 이미지</th>
				                <td rowspan="2">
				                	<input type="hidden" id="atflSerno_<c:out value="${status.index }"/>" value="<c:out value="${result.atflSerno }"/>"/>
				                	<div id="atchFileUpload_<c:out value="${status.index }"/>"></div>
				                </td>
				            </tr>
							<tr>
				                <th scope="row"><span class="asterisk">*</span>사이트명</th>
				                <td>
				                	<input type="text" id="relSiteNm_<c:out value="${status.index }"/>" class="w100p" value="<c:out value="${result.relSiteNm }"/>" title="사이트명" maxlength="30" required="true"/>
				                </td>
				            </tr>
						</tbody>
					</table>
				</div>
			</c:forEach>
		</c:if>
	</div>
</form>
<c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
	<div class="btn_area">
		<button type="button" id="btn_submit" class="btn blue"><c:out value="${fn:length(resultList) > 0 ? '수정' : '등록'}"/></button>
	</div>
</c:if>
