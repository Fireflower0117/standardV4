<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    const procType = "${searchVO.procType}";
    let overChk = false;
    $(document).ready(function(){
        fncCodeList("JG", "select", "선택", "${itsmUserVO.jbgdCd}", "", "jbgdCd", "", "ASC");
        fncCodeList("UO", "select", "선택", "${itsmUserVO.uoCd}", "", "uoCd", "", "ASC");
        fncSvcList("select", "선택", "${itsmUserVO.svcSn}", "svcSn");
        <%-- ID 중복검사 입력 방지 --%>
        $("#userId").on("change input", function() {
        	$(this).attr("data-chk", "N");
        	$(this).attr("data-over", "N");
        });
        
    	
        <%-- ID 중복검사 --%>
        $("#btn_id_over_chk").click(function(){
        	
           	var color = "red";
           	var msg = "아이디를 입력해주세요.";
        	
        	var idChk = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
        	
            if(nullCheck($("#userId").val())){
                alertMsg('userId', color, msg, 'B');
                return false;
            }
            
            msg = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
            
            if(! idChk.test($("#userId").val())){
            	alertMsg('userId', color, msg, 'B');
                return false;
            }
            
            color = "red";
           	msg = "중복된 아이디입니다.";
        	
            fncAjax("userOverChk.json", {userId : $("#userId").val()}, "json", true, "", function(data){
            	
		        <%-- ID 중복검사 여부 --%>
	             $("#userId").attr("data-chk","Y");
	             
		        <%-- ID 중복검사 통과 여부 --%>
                if(data.result > 0){
                	$("#userId").attr("data-over","N");
                }else{
                	$("#userId").attr("data-over","Y");
                	color = "green";
    				msg = "사용가능한 아이디입니다.";
                }
                
		        <%-- ID 중복검사 통과 메시지 출력 --%>
                alertMsg('userId', color, msg, 'B');
		        
            });
        });

        <%-- 생성/수정 --%>
        $("#btn_submit").click(function(){
        	

        	<%-- 공통 유효성검사 --%>
        	if(wrestSubmit(document.defaultFrm)){
                fncAjax("${searchVO.procType}Proc.json", $("#defaultFrm").serialize(), "json", true, "", function(data){
                    alert(data.message);
                    if(data.result > 0){
                        fncPageBoard("list","list.do");
                    }
                })
            }
        });
        
        <%-- 삭제 --%>
        $("#btn_delete").click(function(){
            if(confirm("삭제하시겠습니까?")){
                fncAjax("deleteProc.json", $("#defaultFrm").serialize(), "json", true, "", function(data){
                    alert(data.message);
                    if(data.result > 0){
                        fncPageBoard("list","list.do");
                    }
                })
            }
        });

        <%-- 비밀번호 체크 --%>
        $("#pwdChg").click(function(){
            if( $(this).is(":checked")){
            	$("#pw_strong").addClass('th_tit')
                $("#pswdVal, #rePwdVal").prop({"readonly" : false, "disabled" : false});
                $("#pswdVal, #rePwdVal").attr("required", true);
                $("#pswdVal").focus();
            } else {
            	$("#pw_strong").removeClass('th_tit')
                $("#pswdVal, #rePwdVal").prop({"readonly" : true, "disabled" : true, "required" : false}).val("");
            }
        });

        if(procType === "update"){
            $("#pswdVal, #rePwdVal").prop({"readonly" : true, "disabled" : true, "required" : false});
        }

    });
    
    <%-- 주소 API --%>
    function findAddr(){
    	new daum.Postcode({
            oncomplete: function(data) {
            	
                
                <%-- 우편번호 --%>
                var post = data.zonecode;
                <%-- 도로명 주소 변수 --%>
                var roadAddr = data.roadAddress;
                <%-- 지번 주소 변수 --%>
                var jibunAddr = data.jibunAddress
                
				$('#zip').val(post);
				$('#homeAddr').val(roadAddr);
				$("#homeDaddr").focus();
            }
        }).open();
    }
</script>
<div class="board_write">
<form:form modelAttribute="itsmUserVO" name="defaultFrm" id="defaultFrm" method="post">
    <jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
    <form:hidden path="userSn"/>
    <form:hidden path="authrtAreaCd"/>
    <div class="tbl_top">
        <div class="tbl_left"><h3 class="sm_tit mar_b10">기본정보</h3></div>
        <div class="tbl_right"><span class="asterisk">*</span>필수입력</div>
    </div>
    <!-- board -->
    <table class="board_row_type01">
        <colgroup>
            <col style="width:10%">
            <col style="width:40%">
            <col style="width:10%">
            <col style="width:40%">
        </colgroup>
        <tbody>
            <tr>
                <th><strong class="${searchVO.procType eq 'insert' ? 'th_tit' : '' }">아이디</strong></th>
                <td>
                    <c:choose>
                        <c:when test="${searchVO.procType eq 'insert'}">
                            <form:input path="userId" id="userId" cssClass="text w80p"  maxlength="20" title="아이디" pattern="id" required="true" data-chk="N" data-over="N"/>
                            <a href="javascript:void(0)" class="btn btn_sml02 btn_code_add" id="btn_id_over_chk">중복검사</a>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${itsmUserVO.userId}"/>
                            <form:hidden path="userId" id="userId"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <th><strong class="th_tit">이름</strong></th>
                <td>
                    <form:input path="userNm" id="userNm" cssClass="text w100p"  maxlength="20" title="이름" required="true"/>
                </td>
            </tr>
            <tr>
                <th><strong id="pw_strong" class="${searchVO.procType eq 'insert' ? 'th_tit' : '' }">비밀번호</strong></th>
                <td>
                    <input type="password" name="pswdVal" id="pswdVal" class="text ${searchVO.procType eq 'insert' ? 'w100p' : 'w70p'}" maxlength="30" 
                    	title="비밀번호" pattern="pswd" required autocomplete="off"/>
                    <c:if test="${searchVO.procType eq 'update'}">
                        <span class="chk mar_l10">
						    <span class="cbx"><input type="checkbox" id="pwdChg"><label for="pwdChg">비밀번호 변경</label></span>
						</span>
                    </c:if>
                </td>
                <th><strong class="th_tit">비밀번호재확인</strong></th>
                <td>
                    <input type="password" id="rePwdVal" class="text w100p" maxlength="30" title="비밀번호재입력" required="true" data-rid="pswdVal" placeholder="비밀번호를 다시 한번 입력해주세요." autocomplete="off"/>
                </td>
            </tr>
            <tr>
                <th><strong>우편번호</strong></th>
                <td colspan="3">
                    <form:input path="zip" id="zip" cssClass="text w20p numOnly"  maxlength="5" title="우편번호" placeholder="우편번호" readonly="true" onclick="findAddr();"/>
                    <a href="javascript:void(0)" class="btn btn_sml02 btn_code_add" onclick="findAddr();">주소찾기</a>
                </td>
            </tr>
            <tr>
                <th rowspan="2"><strong>주소</strong></th>
                <td colspan="3">
                    <form:input path="homeAddr" id="homeAddr" cssClass="text w100p"  maxlength="66" title="주소" placeholder="주소찾기 기능을 이용해주세요." readonly="true" onclick="findAddr();"/>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <form:input path="homeDaddr" id="homeDaddr" cssClass="text w100p"  maxlength="66" title="상세주소" placeholder="상세주소"/>
                </td>
            </tr>
            <tr>
                <th><strong class="th_tit">전화번호</strong></th>
                <td>
                	<input type="text" name="userTelNo" id="userTelNo" class="text w100p numOnly"  maxlength="11" title="전화번호" required="required" pattern="phonNum" value="${util:getDecryptAES256HyPhen(itsmUserVO.userTelNo) }">
                </td>
                <th><strong class="th_tit">이메일주소</strong></th>
                <td>
                    <form:input path="userEmlAddr" id="userEmlAddr" cssClass="text w100p"  maxlength="100" title="이메일" required="true" pattern="email"/>
                </td>
            </tr>
            <tr>
                <th><strong class="th_tit">권한</strong></th>
                <td>
                    <form:select path="grpAuthId" id="grpAuthId" cssClass="select w40p" title="권한" required="true">
                        <form:option value="">선택</form:option>
                        <c:forEach var="auth" items="${authList}" varStatus="status">
                            <form:option value="${auth.authId}">${auth.grpAuthrtNm}</form:option>
                        </c:forEach>
                    </form:select>
                </td>
                <th><strong class="th_tit">사용여부</strong></th>
                <td>
                    <span class="chk">
						<span class="radio"><input type="radio" name="useYn" id="useYn_Y" value="Y" ${itsmUserVO.useYn eq 'Y' || searchVO.procType eq 'insert' ? 'checked="checked"' : '' }><label for="useYn_Y">사용</label></span>
						<span class="radio"><input type="radio" name="useYn" id="useYn_N" value="N" ${itsmUserVO.useYn eq 'N' ? 'checked="checked"' : '' } title="사용여부" required="true"><label for="useYn_N">미사용</label></span>
					</span>
                </td>
            </tr>
            <tr>
                <th scope="row">소속</th>
                <td>
                    <form:select path="uoCd" id="uoCd" title="소속">
                        <form:option value="" label="선택"/>
                    </form:select>
                </td>
                <th scope="row">직급</th>
                <td>
                    <form:select path="jbgdCd" id="jbgdCd" title="직급">
                        <form:option value="" label="선택"/>
                    </form:select>
                </td>

            </tr>
            <tr>
                <th scope="row">담당 업무</th>
                <td colspan="3">
                    <form:input path="job" id="job" title="담당 업무"  cssClass="text w100p"  maxlength="30" />
                </td>

            </tr>
        </tbody>
    </table>
    <div class="btn_area right">
    	<c:if test="${sessionScope.SESSION_ITSM_MANAGER_WRITE_BTN_KEY }">
	        <a href="javascript:void(0)" id="btn_submit" class="btn btn_mdl btn_write" id="btn_submit">${searchVO.procType eq 'insert' ? '등록' : '수정'}</a>
	        <c:if test="${searchVO.procType eq 'update' }">
	            <a href="javascript:void(0)" class="btn btn_mdl btn_del" id="btn_delete">삭제</a>
	        </c:if>
	        <a href="javascript:void(0)" id="btn_list" class="btn btn_mdl btn_list">${searchVO.procType eq 'insert' ? '취소' : '목록' }</a>
		</c:if>
    </div>
</form:form>
</div>
<script type="text/javascript">
</script>
