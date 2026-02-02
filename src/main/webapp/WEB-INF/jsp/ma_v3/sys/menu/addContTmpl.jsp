<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
var popChkArr = [];
var tempVal;
var contSave = false;

$(document).ready(function(){
	
	<%-- 콘텐츠 작성 미리보기 창 생성 --%>
	const fncFormPreview = function(){
		
		var tempHtml = CKEDITOR.instances.editrCont.getData();
		if(tempHtml == ""){
			alert("내용을 작성하신 후 미리보기를 눌러주세요.");
			return false;
		}
		
		var popWidth = 1250;
		var popHeight = 800;
		var popTop = (($(window).height() - popHeight) / 2 );
		var popLeft = (($(window).width() - popWidth) / 2 );
		
		window.open('', "popPreview", 'top='+popTop+',left='+popLeft+',titlebar=no,status=no,toolbar=no,resizable=no,scrollbars=yes,width='+popWidth+'px, height='+popHeight+'px');
		$("#previewCont").val(tempHtml);
		$("#defaultFrmTmpl").attr({"action" : "popPreview.do", "method" : "post", "target" : "popPreview", "onsubmit" : ""}).submit();
		$("#defaultFrmTmpl").attr({"action" : "", "target" : "", "onsubmit" : "return false;"});
	}

	<%-- 통합/상세 템플릿 팝업 불러오기 --%>
	const fncPopUpAction = function(popDivn){

		var popUpWidth = 1000;
		if(popDivn == "Detail"){popUpWidth = 1400};
		
		$("#display_view1").css("width", popUpWidth+"px");
		$("#display_view1").css("height", "880px");
		
		$.ajax({
			method : "POST",
			url : "popUpAction",
			data : {popDivn : popDivn},
			dataType : "HTML",
			success : function(data){
				$("#display_view1").html(data);
				popChkArr = [];
				view_show(1);
			},error : function(xhr, status, error){
				 if (xhr.status == 401) {
					window.location.reload();
				 }
				 alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
			}
		});
	}

	const fncMsgActive = function(obj){
		if(tempVal == "N"){
			if(!confirm("활성화하면 기존 활성화 된 컨텐츠는 비활성화 됩니다.\n활성화 하시겠습니까?")){
				$(obj).attr("checked", false);
				$("#activeYn_N").prop("checked", true);
				return false;
			}
		}
	}
	
	<%-- CKeditr가 이미 설정되어 있으면 파괴 --%>
	var editor = CKEDITOR.instances["editrCont"];
	if (editor) { 
		editor.destroy(true); 
	}
	<%-- CKeditr 설정--%>
	CKEDITOR.replace("editrCont",{height : 400, contentsCss: '${pageContext.request.contextPath}/ma/js/ckeditor/contents.css'});

	<%-- 통합템플릿 --%>
	$('#tmpl_total').on('click', function(){
		fncPopUpAction('Total')
	});

	<%-- 상세템플릿 --%>
	$('#tmpl_detail').on('click', function(){
		fncPopUpAction('Detail')
	});

	<%-- 미리보기 --%>
	$('#tmpl_preview').on('click', function(){
		fncFormPreview('form')
	});
	
	<%--컨텐츠 저장 --%>
	$('#btn_tmpl_submit').on('click', function(){
		<%--에디터 유효성 검사--%>		
		if(confirm("컨텐츠 내용이 작성되지 않았습니다.\n저장하시겠습니까?")){
			contSave = true;
			$("#editrContSave").val(CKEDITOR.instances.editrCont.getData());
			$("#addContTmpl").css("display","none");
			$("#addForm").css("display","inline-block");			
		}
	});

	<%-- 저장된 컨텐츠 초기화 --%>
	$('#btn_tmpl_reset').on('click', function(){
		CKEDITOR.instances.editrCont.setData(""); 
	});

	<%--컨텐츠 작성 취소 --%>
	$('#btn_tmpl_cancel').on('click', function(){
		 <%-- 콘텐츠가 저장 안된 경우 실행--%>
		 if(!contSave){
			 $("#addContTmpl").html("");
		 }	 
		 <%-- 취소시 컨텐츠 폼 지우기 --%>		
		 $("#addForm").css("display","inline-block");
		 $("#addContTmpl").css("display","none");
	});
	
	<%-- popup 취소 --%>
	$('#js_popup_bg').click(function () {
	 	$('.js_popup').html("");
	    view_hide('1');
	    $(this).hide();
	});

});
</script>
<form id="defaultFrmTmpl" name="defaultFrm2" method="post" onsubmit="return false;">
    <div class="tbl_top">
		<div class="tbl_left">
			<button id="tmpl_total" class="btn blue" >통합 템플릿</button>
            <button id="tmpl_detail" class="btn blue">상세 템플릿</button>
		</div>
		<div class="tbl_right">
			<button id="tmpl_preview" class="btn bd blue" ><i class="xi-desktop"></i> 미리보기</button>
		</div>
		</div>

    <div class="tbl_wrap">
        <table class="board_write">
            <caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
            <colgroup>
                <col class="w15p">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><strong class="th_tit">에디터 내용</strong></th>
                    <td>
						<textarea name="editrCont" id="editrCont" class="txt_area w100p" rows="23"><c:out value="${editrCont}" escapeXml="false"/></textarea>
						<input type="hidden" name="previewCont" id="previewCont">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="btn_area">
        <a href="javascript:void(0);" class="btn bd gray"  id="btn_tmpl_reset">초기화</a>
	    <c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY }">
    	    <a href="javascript:void(0);" class="btn blue" id="btn_tmpl_submit">저장</a>
	    </c:if>
        <a href="javascript:void(0);" class="btn gray" id="btn_tmpl_cancel">취소</a>
    </div>
</form>

<div id="display_view1" class="layer_pop js_popup">
</div>
<div class="popup_bg" id="js_popup_bg"></div>