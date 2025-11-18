<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
	$(function(){
		$('body').css('min-width','auto');
	    $('.img-trigger').click(function(e){
	    	<%--팝업 이미지 처리 --%> 
	        var atachId = $(this).children("input").val();
			$("#pop_img").attr("src", atachId);
			       	
	        $('.img-view').show();
	        e.stopPropagation();
	
	        $('body').click(function(e) {
	            if(!$('.img-view').has(e.target).length) {
	                $('.img-view').hide();
	            }
	        });
	    });
	
	    $('.img-view .close').click(function(){
	        $('.img-view').hide();
	    });
	    
	    $("[id^=rply_]").keyup(function(){
	        fncTextAreaLimit($(this), $(this).attr("maxlength"));
	    })
	});
$(document).ready(function(){
	
	$("[id^=radio_]").on("click",function (){
		fncTypeChkEtc($(this).data("no"),$(this).data("srvyqstitmserno"),$(this).data("srvyqstserno"),$(this).data("srvyqstitmctt"));
	})
	
	$("[id^=check_]").on("click",function (){
		fncTypeChkMulti($(this).data("no"),$(this).data("srvyqstitmserno"),$(this).data("srvyqstserno"),$(this).data("srvychccnt"));
	})
});
</script>
<form:form modelAttribute="searchVO" id="srvyFrm" name="srvyFrm" onsubmit="return false">
    <div class="form-guide"><span class="asterisk">*</span>는 필수입력</div>
    <input type="hidden" id="prev"/>
    <c:forEach var="sctn" items="${sctnList}" varStatus="sctnStatus">
        <c:set var="qstno" value="0"/>
        <div id="sctn_<c:out value="${sctnStatus.index+1}"/>" <c:out value="${sctnStatus.first ? '':'style=display:none'}"/>>
	        <div class="srvy-ttl wrap-break-word" >
	            <strong><c:out value="${sctn.srvySctnTitl}"/></strong>
	            <div class="desc wrap-break-word"><p><c:out value="${sctn.srvySctnCtt}"/></p></div>
	        </div>
            <ul class="survey_question">
                <c:forEach var="qst" items="${qstList}" varStatus="qstStatus">
                    <c:if test="${sctn.srvySctnSerno eq qst.srvySctnSerno}">
                        <c:set var="qstno" value="${qstno + 1}"/>
                        <c:set var="no" value="${no + 1}"/>
                        <li class="
                        	<c:choose>
	                        	<c:when test="${qst.srvyAnsCgVal eq '3'}">
	                        		survey_chk type-radio
	                        	</c:when>
	                        	<c:when test="${qst.srvyAnsCgVal eq '4'}">
	                        		survey_chk type-checkbox
	                        	</c:when>
	                        	<c:when test="${qst.srvyAnsCgVal eq '6'}">
	                        		survey_chk type-img
	                        	</c:when>
	                        	<c:when test="${qst.srvyAnsCgVal eq '7'}">
	                        		survey_chk type-satisfaction
	                        	</c:when>
	                        	<c:when test="${qst.srvyAnsCgVal eq '8'}">
	                        		survey_chk type-radio
	                        	</c:when>
	                        	<c:when test="${qst.srvyAnsCgVal eq '9'}">
	                        		survey_chk type-img
	                        	</c:when>
                        	</c:choose>
                        ">
                            <strong class="wrap-break-word">
                            	<c:if test="${qst.srvyNcsrYn eq 'Y'}">
                            		<span class="asterisk"></span>
                            	</c:if><c:out value="${qstno}. ${qst.srvyQstTitl}"/>
                            </strong>
                            <div class="desc">
                            	<p class="wrap-break-word">
                            		<c:out value="${qst.srvyQstCtt}"/>
                            		<c:if test="${not empty qst.srvyChcCnt}">
		                            	(선택가능한 갯수는 <c:out value="${qst.srvyChcCnt}"/>개 이하입니다.)
    	                        	</c:if>
                            	</p>
                            	
                            </div>
                            <input type="hidden" name="rplyList[<c:out value="${no-1}"/>].srvySerno" value="<c:out value="${searchVO.srvySerno}"/>"/>
                            <input type="hidden" name="rplyList[<c:out value="${no-1}"/>].srvySctnSerno" value="<c:out value="${qst.srvySctnSerno}"/>"/>
                            <input type="hidden" name="rplyList[<c:out value="${no-1}"/>].srvyQstSerno" value="<c:out value="${qst.srvyQstSerno}"/>"/>
                            <c:choose>
                             	<%-- 단문형 --%>
                                <c:when test="${qst.srvyAnsCgVal eq '1'}">
	                                <c:forEach var="itm" items="${qstItmList}" varStatus="qstItmStatus">
	                                    <c:if test="${qst.srvyQstSerno eq itm.srvyQstSerno}">
	                                    	<input type="text" class="w100p" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" class="w100p" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${qst.srvyQstSerno}"/>" <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/> maxlength="<c:out value="${itm.srvyItmTpVal1}"/>">
	                                    	<span class="txt-count"> <span class="block"><span id="chk_rply_<c:out value='${qst.srvyQstSerno}_${no-1}'/>">0</span>/<span><c:out value="${itm.srvyItmTpVal1}"/></span>자</span></span>
	                                    	<span id="itmMsg_<c:out value="${qst.srvyQstSerno}"/>"></span>
	                                	</c:if>
	                                </c:forEach>
                                </c:when>
                                <%-- 장문형 --%>
                                <c:when test="${qst.srvyAnsCgVal eq '2'}">
                                    <textarea id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${qst.srvyQstSerno}"/>" <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/> maxlength="1000" rows="12"></textarea>
                                    <span class="txt-count"><span class="block"><span id="chk_rply_<c:out value='${qst.srvyQstSerno}_${no-1}'/>">0</span>/<span>1000</span>자</span></span>
                                    <span id="itmMsg_<c:out value="${qst.srvyQstSerno}"/>"></span> 
                                </c:when>
                                <%-- 객관식 --%>
                                <c:when test="${qst.srvyAnsCgVal eq '3'}">
                                    <input type="hidden" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${qst.srvyQstSerno}"/>" <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/>/>
                                    <c:forEach var="itm" items="${qstItmList}" varStatus="qstItmStatus">
                                        <c:if test="${qst.srvyQstSerno eq itm.srvyQstSerno}">
                                            <label for="radio_<c:out value='${itm.srvyQstItmSerno}'/>">
                                                <input type="radio" id="radio_<c:out value="${itm.srvyQstItmSerno}"/>" name="radio_<c:out value="${qst.srvyQstSerno}"/>" data-no="<c:out value="${no -1}"/>" data-srvyqstitmserno="<c:out value="${itm.srvyQstItmSerno}"/>"  data-srvyqstserno="<c:out value="${itm.srvyQstSerno}"/>" data-srvyqstitmctt="<c:out value="${itm.srvyQstItmCtt}"/>" data-srvynextsctnno="<c:out value="${itm.srvyNextSctnNo}"/>" data-srvysecserno="<c:out value='${sctn.srvySctnSerno}'/>"> 
                                                <span class="dot"></span><c:out value="${itm.srvyQstItmCtt}"/> 
                                            </label> 
                                        </c:if>
                                    </c:forEach>
                                    <input type="text" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>_etc" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCttEtc" class="w100p rply_<c:out value='${qst.srvyQstSerno}_${no-1}'/>_etc" maxlength="20" style="display:none;">  
                                    <span class="txt-count rply_<c:out value='${qst.srvyQstSerno}_${no-1}'/>_etc" style="display:none;"> <span class="block"><span id="chk_rply_<c:out value='${qst.srvyQstSerno}_${no-1}'/>">0</span>/<span>20</span>자</span></span>
                                    <span id="itmMsg_<c:out value="${qst.srvyQstSerno}"/>"></span>
                                </c:when>
                                <%-- 체크박스--%>
                                <c:when test="${qst.srvyAnsCgVal eq '4'}">
                                    <input type="hidden" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstSerno="<c:out value="${qst.srvyQstSerno}"/>" <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/>/>
                                    <c:forEach var="itm" items="${qstItmList}" varStatus="qstItmStatus">
                                        <c:if test="${qst.srvyQstSerno eq itm.srvyQstSerno}">
                                            <label for="check_<c:out value='${itm.srvyQstItmSerno}'/>"> 
                                                <input type="checkbox" id="check_<c:out value="${itm.srvyQstItmSerno}"/>" name="check_<c:out value="${qst.srvyQstSerno}"/>" value="<c:out value="${itm.srvyQstItmSerno}"/>"  data-srvyqstitmctt="<c:out value="${itm.srvyQstItmCtt}"/>" data-srvysctnserno="<c:out value='${sctn.srvySctnSerno}'/>"  data-no="<c:out value="${no -1}"/>" data-srvyqstitmserno="<c:out value="${itm.srvyQstItmSerno}"/>"  data-srvyqstserno="<c:out value="${itm.srvyQstSerno}"/>" data-srvychccnt="<c:out value="${qst.srvyChcCnt}"/>" ><span class="square"></span><c:out value="${itm.srvyQstItmCtt}"/>
                                            </label>
                                        </c:if> 
                                    </c:forEach>
                                    <input type="text" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>_etc" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCttEtc" class="w100p rply_<c:out value='${qst.srvyQstSerno}_${no-1}'/>_etc" maxlength="20" style="display:none;">
                                    <span class="txt-count rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>_etc" style="display:none;"> <span class="block"><span id="chk_rply_<c:out value='${qst.srvyQstSerno}_${no-1}'/>">0</span>/<span>20</span>자</span></span>
                                    <span id="itmMsg_<c:out value='${qst.srvyQstSerno}'/>"></span>
                                </c:when>
                                <%-- 첨부파일 --%>
                                <c:when test="${qst.srvyAnsCgVal eq '5'}">
                                    <table class="board_write">
                                        <caption>첨부파일 업로드 목록</caption>
                                        <colgroup>
                                            <col>
                                        </colgroup>
                                        <tbody>
	                                        <tr>
	                                            <td>
	                                                <div id="atchFileDiv_<c:out value='${qst.srvyQstSerno}_${no-1}'/>" class="field">
	                                                </div>
	                                                <input type="hidden" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" value="" <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/> data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstSerno="<c:out value="${qst.srvyQstSerno}"/>" data-fileYn ="Y" data-fileNo ="${no-1}" />
	                                            </td>
	                                        </tr>
                                        </tbody>
                                    </table>
                                    <span id="itmMsg_<c:out value='${qst.srvyQstSerno}'/>"></span>
                                    <script type="text/javascript">
                                        $("#atchFileDiv_"+'<c:out value="${qst.srvyQstSerno}"/>' + "_" + '<c:out value="${no-1}"/>').html(setFileList($("#rply_"+'<c:out value="${qst.srvyQstSerno}"/>'+"_"+ '<c:out value="${no-1}"/>').val(), "rply_"+'<c:out value="${qst.srvyQstSerno}"/>' + "_" + +'<c:out value="${no-1}"/>', "upload", '5' , '20' ));
                                    </script>
                                </c:when>
                                <%-- 이미지 --%>
                                <c:when test="${qst.srvyAnsCgVal eq '6'}">
                                    <input type="hidden" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstSerno="<c:out value="${qst.srvyQstSerno}"/>"  <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/>/>
                                    <ul>
                                        <c:forEach var="itm" items="${qstItmList}" varStatus="qstItmStatus">
                                            <c:if test="${qst.srvyQstSerno eq itm.srvyQstSerno}">
	                                            <c:set var="img" value="${img+1}"/>
	                                            <c:if test="${img ne 1 && img%2 eq 1}">
	                                                </ul><ul>
	                                            </c:if>
                                                <li>
                                                    <label for="check_<c:out value='${itm.srvyQstItmSerno}'/>">
                                                        <input type="checkbox" id="check_<c:out value="${itm.srvyQstItmSerno}"/>" name="check_<c:out value="${qst.srvyQstSerno}"/>" value="<c:out value="${itm.srvyQstItmSerno}"/>" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-no="<c:out value="${no -1}"/>" data-srvyqstitmserno="<c:out value="${itm.srvyQstItmSerno}"/>"  data-srvyqstserno="<c:out value="${itm.srvyQstSerno}"/>" data-srvychccnt="<c:out value="${qst.srvyChcCnt}"/>" />
                                                        <span class="square"></span>
                                                        <img src="<c:out value="${pageContext.request.contextPath}"/>/file/getImage.do?atchFileId=<c:out value="${itm.srvyQstItmCtt}"/>&fileSeqo=<c:out value="${itm.fileSeqo}"/>&fileNmPhclFileNm=<c:out value='${itm.fileNmPhclFileNm}'/>" alt="image">
                                                    </label>
                                                    <i class="xi-zoom-in img-trigger">
                                                    	<input type="hidden" value="<c:out value="${pageContext.request.contextPath}"/>/file/getImage.do?atchFileId=<c:out value="${itm.srvyQstItmCtt}"/>&fileSeqo=<c:out value="${itm.fileSeqo}"/>&fileNmPhclFileNm=<c:out value='${itm.fileNmPhclFileNm}'/>">
                                                   	</i>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                    <span id="itmMsg_<c:out value='${qst.srvyQstSerno}'/>"></span> 
                                    <div class="img-view">
                                        <%--이미지가 뜨는 영역 --%>
                                        <button type="button" name="button" class="close"><i class="xi-close-thin"></i></button>
                                        <figure>
                                            <img id="pop_img" src="" alt="image">
                                        </figure>
                                    </div>
                                </c:when>
                                <%-- 선호도--%>
                                <c:when test="${qst.srvyAnsCgVal eq '7'}">
                                    <input type="hidden" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstSerno="<c:out value="${qst.srvyQstSerno}"/>"  <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/>/>
                                    <c:forEach var="itm" items="${qstItmList}" varStatus="qstItmStatus">
                                        <c:if test="${qst.srvyQstSerno eq itm.srvyQstSerno}">
                                            <div class="chk-list">
                                                <span><c:out value="${itm.srvyItmTpVal1}"/></span>
                                                <c:forEach begin="${itm.srvyItmTpVal2}" end="${itm.srvyItmTpVal3}" var="x">
                                                    <label for="item_<c:out value='${itm.srvyQstItmSerno}_${x}'/>"> 
                                                    	<input type="radio" id="item_<c:out value="${itm.srvyQstItmSerno}_${x}"/>" name="item_<c:out value="${qst.srvyQstSerno}"/>" value="<c:out value="${x}"/>" data-srvyanscgval="<c:out value="${qst.srvyAnsCgVal}"/>" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>"  data-no="<c:out value="${no -1}"/>"  data-x="<c:out value="${x}"/>"  data-srvyqstserno="<c:out value="${qst.srvyQstSerno}"/>" >
                                                    	<span class="dot"></span><c:out value="${x}"/> 
                                                    </label>
                                                </c:forEach>
                                                <span><c:out value="${itm.srvyItmTpVal4}"/></span>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <span id="itmMsg_<c:out value='${qst.srvyQstSerno}'/>"></span> 
                                </c:when>
                                <%-- 날짜/시간--%>
                                <c:when test="${qst.srvyAnsCgVal eq '8'}">
                                    <input type="hidden" id="rply_${qst.srvyQstSerno}_${no-1}" name="rplyList[${no-1}].srvyAnsCtt" data-srvysctnserno="${sctn.srvySctnSerno}" data-srvyqstSerno="${qst.srvyQstSerno}" ${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}/>
                                    <c:forEach var="itm" items="${qstItmList}" varStatus="qstItmStatus">
                                        <c:if test="${qst.srvyQstSerno eq itm.srvyQstSerno}">
                                            <label for="radio_<c:out value='${itm.srvyQstItmSerno}'/>">
                                                <input type="radio" id="radio_<c:out value="${itm.srvyQstItmSerno}"/>" name="radio_<c:out value="${qst.srvyQstSerno}"/>" data-no="<c:out value="${no -1}"/>" data-srvyqstitmserno="<c:out value="${itm.srvyQstItmSerno}"/>"  data-srvyqstserno="<c:out value="${itm.srvyQstSerno}"/>">
                                                <span class="dot"></span><c:out value="${itm.srvyItmTpVal1}"/> &nbsp;/&nbsp; <c:out value="${itm.srvyItmTpVal2}"/>
                                            </label>
                                        </c:if>
                                    </c:forEach>
                                    <span id="itmMsg_${qst.srvyQstSerno}"></span>
                                </c:when>
                                <%-- 동영상 --%>
                                <c:when test="${qst.srvyAnsCgVal eq '9'}">
                                    <input type="hidden" id="rply_<c:out value="${qst.srvyQstSerno}_${no-1}"/>" name="rplyList[<c:out value="${no-1}"/>].srvyAnsCtt" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvyqstserno="<c:out value="${qst.srvyQstSerno}"/>" <c:out value="${qst.srvyNcsrYn eq 'Y' ? 'required=required' : ''}"/>/>
                                    <ul>
                                        <c:forEach var="itm" items="${qstItmList}" varStatus="qstItmStatus">
                                            <c:if test="${qst.srvyQstSerno eq itm.srvyQstSerno}">
                                                <c:set var="vdo" value="${vdo+1}"/>
                                                <c:if test="${vdo ne 1 && vdo % 2 eq 1}">
                                                    </ul><ul>
                                                </c:if>
                                                <li>
                                                    <label for="check_<c:out value='${itm.srvyQstItmSerno}'/>">
                                                        <input type="checkbox" id="check_<c:out value="${itm.srvyQstItmSerno}"/>" name="check_<c:out value="${qst.srvyQstSerno}"/>" value="<c:out value="${itm.srvyQstItmSerno}"/>" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-no="<c:out value="${no -1}"/>" data-srvyqstitmserno="<c:out value="${itm.srvyQstItmSerno}"/>"  data-srvyqstserno="<c:out value="${itm.srvyQstSerno}"/>" data-srvychccnt="<c:out value="${qst.srvyChcCnt}"/>"  >
                                                        <span class="square"></span>
                                                        <c:choose>
	                                                        <c:when test="${fn:contains(itm.srvyQstItmCtt,'https://youtube.com/watch?v=') }">
		                                                        <c:set var="videoUrl" value="${fn:substringAfter(itm.srvyQstItmCtt,'https://youtube.com/watch?v=')}"/>
	                                                        </c:when>
	                                                        <c:when test="${fn:contains(itm.srvyQstItmCtt,'https://www.youtube.com/watch?v=') }">
		                                                        <c:set var="videoUrl" value="${fn:substringAfter(itm.srvyQstItmCtt,'https://www.youtube.com/watch?v=')}"/>
	                                                        </c:when>
	                                                         <c:when test="${fn:contains(itm.srvyQstItmCtt,'https://youtu.be') }">
		                                                        <c:set var="videoUrl" value="${fn:substringAfter(itm.srvyQstItmCtt,'https://youtu.be')}"/>
	                                                        </c:when>
	                                                        <c:when test="${fn:contains(itm.srvyQstItmCtt,'https://www.youtu.be') }">
		                                                        <c:set var="videoUrl" value="${fn:substringAfter(itm.srvyQstItmCtt,'https://www.youtu.be')}"/>
	                                                        </c:when>
                                                        </c:choose>
	                                                        <iframe width="100" height="100" src="https://www.youtube.com/embed/<c:out value='${videoUrl}'/>" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>   
                                                    </label>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                    <span id="itmMsg_<c:out value='${qst.srvyQstSerno}'/>"></span>
                                </c:when>
                            </c:choose> 
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
            <input type="hidden" name="_don_care">
            <div class="btn_area center mar_t15 mar_b30" id="btn_area_<c:out value='${sctnStatus.index+1}'/>">
                <button type="button" class="btn sml btn_prev_page" <c:out value="${!sctnStatus.first ? '' : 'style=display:none'}"/> data-hide="<c:out value="${sctnStatus.index+1}"/>" data-show="<c:out value="${sctnStatus.index}"/>">이전</button>
                <button type="button" class="btn sml btn_next_page" <c:out value="${!sctnStatus.last ? '' : 'style=display:none'}"/> data-hide="<c:out value="${sctnStatus.index+1}"/>" data-show="<c:out value="${sctnStatus.index+2}"/>" data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>" data-srvynextsctnno="<c:out value="${sctn.srvyNextSctnNo}"/>" >다음</button>
                <button type="button" class="btn sml blue btn_srvy_submit" <c:out value="${sctnStatus.last ? '' : 'style=display:none'}"/> data-srvysctnserno="<c:out value="${sctn.srvySctnSerno}"/>">제출 </button>
            </div>
        </div>
    </c:forEach>
</form:form>