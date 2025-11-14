<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">

const fncProcAjax = function(type){
	var procType;
	if(type == 'replInsert'){
		procType = 'post';
	}else if(type == 'replUpdate'){
		procType = 'patch';
	}else if(type == 'replDelete'){
		procType = 'delete';
	}
	
	$.ajax({
		type : procType
		,url : 'replProc'
		,data : $('#defaultFrm').serialize()
		,dataType : 'json'
		,success : function(data) {
			alert(data.message);
			<%-- 댓글 리스트 불러오기 --%>
			fncCallReplList();
		},error: function (xhr, status, error) {
			$('.error_txt').remove();
			let errors = xhr.responseJSON;
			
			if(procType === 'delete'){
				alert(errors[0].defaultMessage);
			}else{
				for (let i = 0; i < errors.length; i++) {
				    let e = errors[i];
					
				    if(e.codes.some(item => item.includes('java.util.List'))){
				    	alert(e.defaultMessage);
				    	
				    } else{
					    $('#' + e.field).parent().append('<p class="error_txt">' + e.defaultMessage + '</p>');
				    }
				    
				}
			}
	    }
	});
}

<%-- 댓글 리스트 불러오기 --%>
const fncCallReplList = function(){
	$.ajax({
		type : 'post'
		,url : 'replList.do'
		,data : $('#defaultFrm').serialize()
		,dataType : 'HTML'
		,success : function(data) {
			$(".cmnt_area").html(data);
		},error: function (xhr, status, error) {
			if (xhr.status == 401) {
				window.location.reload();
			}
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
	    },beforeSend : function(req){
			fncLoadingStart();
		},complete : function(){
			fncLoadingEnd();
		}
	});
}
<%-- 댓글 수정 폼 변경 --%>
const fncReplModifyForm = function(index,replSerno){
	var html = '<textarea name="replCtt" rows="3" placeholder="0자 이내" id="replCtt_'+index+'">' + $("#repl_ctt_"+index).text() + '</textarea>'
	         + '<button type="button" class="btn blue btn_repl_modify">수정</button>'
	         + '<button type="button" class="btn gray btn_repl_cancle">취소</button>';
	$("#repl_btn_box_"+index).addClass("disno");
	$("#repl_ctt_"+index).addClass("disno");
	$("#repl_write_box_"+index).append(html);		
}

<%-- 좋아요 불러오기 --%>
const fncCallLike = function(){
	$.ajax({
		type : 'post'
		,url : 'like'
		,data : $('#defaultFrm').serialize()
		,dataType : 'HTML'
		,success : function(data) {
			$(".likeit").html(data);
		},error : function(xhr, status, error){
			if (xhr.status == 401) {
				window.location.reload();
			}
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	});
}

<%-- 좋아요 등록/수정/삭제 --%>
const fncLikeProc = function(type,value){
	
	if(type == "insert"){
		procType = "post"
	}else if(type == "update"){
		procType = "patch"
	}else if(type == "delete"){
		procType = "delete"
	}
	$.ajax({
		type : procType
		,url : 'likeProc'
		,data : $('#defaultFrm').serialize()
		,dataType : 'HTML'
		,success : function(data) {
			fncCallLike();
		},error : function(xhr, status, error){
			if (xhr.status == 401) {
				window.location.reload();
			}
			alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
		}
	});
}

$(document).ready(function(){

	<%-- 첨부파일 등록폼 생성 --%>
	$("#atchFileUpload").html(setFileList($("#atchFileId").val(), "atchFileId", "imageView", '10' ));

	<%-- 댓글 리스트 불러오기 --%>
	fncCallReplList();
	
	<%-- 좋아요 불러오기 --%>
	fncCallLike();

	<%-- 이미지 크게보기창 닫기 --%>
	$(".btn_pop_close").on('click',function(){
		view_hide('image');
	});
	
	<%-- 이전글/다음글 이동 --%>
	$(".btn_move").on("click", function(){
		fncPageBoard('view', 'view.do', String($(this).data('serno')), 'bltnbSerno');
	});
	
	<%-- 글 추천/반대 --%>
	$(document).on("click","#likeit_y, #likeit_n" ,function(){
		if("${sessionScope.ft_user_info}"){
			if(Number($("#rcmdSerno").val()) > 0){
				if($(this).val() == $("#rcmdYn").val()){
					fncLikeProc("delete", $(this).val())
				}else{
					fncLikeProc("update", $(this).val())					
				}
			}else{
				fncLikeProc("insert", $(this).val())
			}
		}else{
			if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
				location.href = "/ft/login.do";
			}else{
				$(this).prop("checked",false);
			}
		}
	});
	
});

$(function () {
    $('#js_popup_bg').on('click',function () {
        $('.js_popup').removeClass("on").css('visibility', 'hidden');
        $(this).hide();
    });
});
</script>
<form:form modelAttribute="bltnbVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
	<form:hidden path="bltnbSerno"/>
	<form:hidden path="atchFileId"/>
	<jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
	<div class="board_top">
	    <div class="board_right">
	        <ul class="view_top">
	            <li><a href="" class="i_share">공유</a></li>
	            <li><a href="" class="i_print">인쇄</a></li>
	            <li><a href="" class="i_siren">신고</a></li>
	        </ul>
	    </div>
	</div>
	<table class="board_view">
		<colgroup>
			<col class="w20p">
			<col class="w30p">
			<col class="w20p">
			<col class="w30p">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3"><c:out value="${bltnbVO.bltnbTitl}"/></td>
			</tr>
			<tr>
				<th scope="row">등록자</th>
				<td><c:out value="${bltnbVO.regrNm}"/></td>
				<th scope="row">등록일</th>
				<td><c:out value="${bltnbVO.regDt}"/></td>
			</tr>
			<tr>
				<td colspan="4">
					<c:out value="${bltnbVO.bltnbCtt}" escapeXml="false"/>
					<div class="likeit">
	                </div>
	            <td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<div id="atchFileUpload"></div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="btn_area">
		<a href="javascript:void(0)" id="btn_list" class="btn gray">목록</a>
	</div>
	<div class="cmnt_area">
	</div>
	<table class="oth_post">
	    <colgroup>
	        <col class="w20p">
	        <col>
	    </colgroup>
	    <tbody>
	    	<c:choose>
	           	<c:when test="${fn:length(sernoList) > 0 }">
					<c:forEach var="result" items="${sernoList}" varStatus="status">
				        <tr>
				            <th scope="row"><c:out value="${result.divn}"/><i class="xi-angle-up-thin"></i></th>
				            <td>
						     	<a href="javascript:void(0);" class="ellipsis btn_move" data-serno="<c:out value="${result.serno}"/>"><c:out value="${result.titl}"/></a>
				            </td>
				        </tr>
		            </c:forEach>
	           	</c:when>
	           	<c:otherwise>
	           		<tr>
						<th scope="row">이전글<i class="xi-angle-up-thin"></i></th>
				        <td>
						    이전글이 없습니다.
				        </td>
				    </tr>
				    <tr>
						<th scope="row">다음글<i class="xi-angle-up-thin"></i></th>
				        <td>
						    다음글이 없습니다.
				        </td>
				    </tr>
	           	</c:otherwise>
	    	</c:choose>
	    </tbody>
	</table>
</form:form>
<div id="display_viewimage" class="layer_pop js_popup w1000px">
    <div class="pop_header">
        <h2 id="pop_title">이미지 크게보기</h2>
        <button type="button" class="pop_close btn_pop_close"><i class="xi-close-thin"></i>닫기</button>
    </div>
    <div class="pop_content" style="max-height: 800px;" data-simplebar data-simplebar-auto-hide="false">
        pop_content
    </div>
    <div class="pop_footer">
        <button type="button" class="btn gray btn_pop_close" id="btn_pop_close" >닫기</button>
    </div>
</div>
<div class="popup_bg" id="js_popup_bg"></div>
