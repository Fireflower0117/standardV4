<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
    $(document).ready(function () {
        <c:if test="${searchVO.procType eq 'update'}">
            fncSetPswd();
        </c:if>

        <%-- 드래그앤드롭 --%>
        $("#ip_tblBody").sortable({
            stop : function(){
                setDataNo();
            }
        });

        <%-- 주소 찾기 --%>
        $('#postNo, #btn_findAddr').on('click', function () {
            fncFindAddr();
        });

        <%-- 잠금 해제 --%>
        $('#btn_unlock').on('click', function () {
            $.ajax({
                type: 'patch'
                , url: 'unlockProc'
                , data: {'schEtc11': '<c:out value="${userVO.userSerno}"/>'}
                , dataType: 'json'
                , success: function (data) {
                    if (data.result > 0) {
                        alert('잠금해제가 완료되었습니다.');
                        fncPageBoard('update', 'updateForm.do', '<c:out value="${userVO.userSerno}"/>');
                    }
                }
                , error: function () {
                    alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
                }
            });
        });

        <%-- 등록/수정 --%>
        $('#btn_submit').on('click', function () {
            setDataList();
            if (fncCheckPswd()) {
                if (wrestSubmit(document.defaultFrm)) {
                    if(ovlpChk == 1){
                        alert('ID 중복입니다.');
                        return false;
                    }else if(ovlpChk == 2){
                        alert('사용이 제한된 ID입니다.');
                        return false;
                    }
                    fncProc("${empty userVO.userSerno ? 'insert' : 'update'}");
                }
            }
        });

        <%-- 삭제 --%>
        $('#btn_delete').on('click', function () {
            if (wrestSubmit(document.defaultFrm)) {
                if(ovlpChk == 1){
                    alert('ID 중복입니다.');
                    return false;
                }else if(ovlpChk == 2){
                    alert('사용이 제한된 ID입니다.');
                    return false;
                }
                fncProc('delete');
            }
        });

        <%-- 비밀번호 변경 클릭시 --%>
        $('#cbx_pswd').on('click', function () {
            fncSetPswd();
        });

        $('#i_plus').on('click', function () {
            fncIpAddAction();
        });

        $('#userId').on('input', function(event) {
            // ID중복체크
            var idChk = /^[a-z0-9][a-z0-9_\-]{4,19}$/;

            if (!idChk.test($(this).val())) {
                return false;
            }

            fncIdOvlpChk($(this).val());
        });

        $(document).on('input', '.ipChg', function () {
            fncIpChg(this);
        });

        $(document).on('change', '[id^=ip_bawdYn]', function () {
            let id = $(this).attr('id');
            fncDivChg(id.replace("ip_bawdYn_", ""));
        });

        $(document).on('click', '[id^=ip_del]', function () {
            let id = $(this).attr('id');
            fncDelTbl(id.replace("ip_del_", ""));
        });
    });
    <%-- 비밀번호 변경 여부에 따른 속성변경 --%>
    const fncSetPswd = function () {

        let obj = $('#cbx_pswd');

        if ($(obj).is(':checked')) {
            $('input[id*="userPswd"]').prop({'readonly': false, 'disabled': false, 'required': true});
        } else {
            $('input[id*="userPswd"]').prop({'readonly': true, 'disabled': true, 'required': false}).val('');
        }
    }

    <%-- 비밀번호 일치 여부 --%>
    const fncCheckPswd = function () {
        $('#re_userPswd').siblings('.error_txt').remove();

        if ($('#cbx_pswd').is(':checked')) {
            if ($('#userPswd').val() === $('#re_userPswd').val()) {
                return true;
            } else {
                $('#re_userPswd').after('<p class="error_txt disin">비밀번호가 일치하지 않습니다.</p>');
                return false;
            }
        }

        return true;
    }

    <%-- 주소 API --%>
    const fncFindAddr = function () {
        new daum.Postcode({
            oncomplete: function (data) {
                <%-- 우편번호 --%>
                let post = data.zonecode;
                <%-- 도로명 주소 변수 --%>
                let roadAddr = data.roadAddress;
                <%-- 지번 주소 변수 --%>
                let jibunAddr = data.jibunAddress

                $('#postNo').val(post);
                $('#homeAddr').val(roadAddr);
                $("#homeAddrDtls").focus();
            }
        }).open();
    }

    var ovlpChk = 0;
    const fncIdOvlpChk = function(userId){

        $.ajax({
            method: "POST",
            url: "/ma/sys/mngr/mngrMng/idOvlpChk",
            data: {userId : userId},
            dataType: "json",
            success: function(data) {
                let overCnt = data.ovlpCnt;
                let rstCnt = data.rstCnt;

                if(rstCnt > 0){
                    wrestMsg = "\'" + $("#userId").val() + "\'" + "은(는) 사용이 제한된 아이디입니다.";

                    // 오류메세지를 위한 element 추가
                    var msgHtml = '<strong id="strong_userId"><font color="red">&nbsp;'+wrestMsg+'</font></strong>';

                    $("#userId").parent().append(msgHtml);
                    ovlpChk = 2;

                }else if(overCnt > 0){
                    wrestMsg = "\'" + $("#userId").val() + "\'" + "은(는) 이미 사용 중입니다.";

                    // 오류메세지를 위한 element 추가
                    var msgHtml = '<strong id="strong_userId"><font color="red">&nbsp;'+wrestMsg+'</font></strong>';

                    $("#userId").parent().append(msgHtml);
                    ovlpChk = 1;
                }else{
                    $("#strong_userId").remove();
                    ovlpChk = 0;
                }
            },error: function(xhr, status, error){
                let errors = xhr.responseJSON;
                alert(errors[0].defaultMessage);
            }
        });
    }

</script>
<form:form modelAttribute="userVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
    <form:hidden path="userSerno"/>
    <jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
    <div class="board_top">
        <div class="board_right">
            <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
        </div>
    </div>
    <table class="board_write">
        <colgroup>
            <col class="w10p"/>
            <col/>
            <col class="w10p"/>
            <col/>
        </colgroup>
        <tbody>
        <tr>
            <th scope="row"><span class="asterisk">*</span>아이디</th>
            <td><form:input path="userId" title="아이디" cssClass="w100p" maxlength="30" required="true" pattern="id"/></td>
            <th scope="row"><span class="asterisk">*</span>이름</th>
            <td><form:input path="userNm" title="이름" cssClass="w100p" maxlength="30" required="true"/></td>
        </tr>
        <tr>
            <th scope="row"><span class="asterisk">*</span>비밀번호</th>
            <td>
                <input type="password" id="userPswd" name="userPswd" title="비밀번호" class="w50p" maxlength="30" pattern="pswd" required="true" autocomplete="off"/>
                <c:if test="${searchVO.procType eq 'update'}">
                    <span class="chk">
                        <span class="cbx">
                            <input type="checkbox" id="cbx_pswd"/><label for="cbx_pswd">비밀번호 변경</label>
                        </span>
                     </span>
                </c:if>
            </td>
            <th scope="row"><span class="asterisk">*</span>비밀번호재입력</th>
            <td><input type="password" id="re_userPswd" title="비밀번호재입력" class="w50p" maxlength="30" required="true" pattern="pswd" placeholder="비밀번호를 다시 한번 입력해주세요." autocomplete="off"/></td>
        </tr>
        <tr>
            <th scope="row"><span class="asterisk">*</span>전화번호</th>
            <td><form:input path="userTelNo" value="${util:getDecryptAES256(userVO.userTelNo) }" title="전화번호" pattern="phonNum" cssClass="numOnly" maxlength="11" required="true"/></td>
            <th scope="row"><span class="asterisk">*</span>이메일</th>
            <td><form:input path="userEmailAddr" title="이메일" pattern="email" cssClass="w100p" maxlength="100" required="true"/></td>
        </tr>
        <tr>
            <th scope="row"><span class="asterisk">*</span>우편번호</th>
            <td colspan="3">
                <form:input path="postNo" title="우편번호" maxlength="5" required="true"/>
                <button type="button" id="btn_findAddr" class="btn sml">주소찾기</button>
            </td>
        </tr>
        <tr>
            <th scope="row" rowspan="2"><span class="asterisk">*</span>주소</th>
            <td colspan="3">
                <form:input path="homeAddr" title="주소" cssClass="w100p" maxlength="100" required="true"/>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <form:input path="homeAddrDtls" title="상세주소" cssClass="w100p" maxlength="100" required="true"/>
            </td>
        </tr>
        </tr>
            <th scope="row"><span class="asterisk">*</span>권한</th>
            <td colspan="3">
                <input type="hidden" name="authAreaCd" value="MA"/>
                <form:select path="grpAuthId" title="권한" cssClass="w30p" required="true">
                    <c:forEach var="auth" items="${authList}" varStatus="status">
                        <form:option value="${auth.grpAuthId}">${auth.grpAuthNm}</form:option>
                    </c:forEach>
                </form:select>
            </td>
        </tr>
        <tr>
            <th scope="row"><span class="asterisk">*</span>차단여부</th>
            <td>
                <span class="chk">
                    <span class="radio"><form:radiobutton path="brkYn" id="brkYn_Y" title="차단여부" value="Y" required="true"/><label for="brkYn_Y">차단</label></span>
                    <span class="radio"><form:radiobutton path="brkYn" id="brkYn_N" title="차단여부" value="N" required="true" checked="${empty userVO.brkYn ? true : false}"/><label for="brkYn_N">미차단</label></span>
                </span>
            </td>
            <th scope="row"><span class="asterisk">*</span>사용여부</th>
            <td>
                <span class="chk">
                    <span class="radio"><form:radiobutton path="useYn" id="useYn_Y" title="사용여부" value="Y" required="true" checked="${empty userVO.useYn ? true : false}"/><label for="useYn_Y">사용</label></span>
                    <span class="radio"><form:radiobutton path="useYn" id="useYn_N" title="사용여부" value="N" required="true"/><label for="useYn_N">미사용</label></span>
                </span>
            </td>
        </tr>
        </tbody>
    </table>
    <div class="mar_t30">
        <div class="board_top">
            <div class="board_left">
                <h4 class="md_tit">접근 IP 관리</h4>
            </div>
            <div class="board_right">
                <a href="javascript:void(0)" id="i_plus"><i class="xi-plus-circle"></i></a>
            </div>
        </div>
        <table class="board_write">
            <colgroup>
                <col class="w6p"/>
                <col>
                <col>
                <col class="w15p"/>
                <col class="w5p"/>
            </colgroup>
            <tbody id="ip_tblBody">
                <c:choose>
                    <c:when test="${fn:length(ipList) > 0 }">
                        <c:forEach var="result" items="${ipList }" varStatus="status">
                            <tr id="ip_tr_<c:out value="${status.count  }"/>"/>
                                <td class="ip_td"><c:out value="${status.count  }"/></td>
                                <td colspan="2" class="l">
                                    <input type="text" id="ip_strtIpVal_<c:out value="${status.count  }"/>_1" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.strtIp1 }"/>"/>
                                    <span>.</span>
                                    <input type="text" id="ip_strtIpVal_<c:out value="${status.count  }"/>_2" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.strtIp2 }"/>"/>
                                    <span>.</span>
                                    <input type="text" id="ip_strtIpVal_<c:out value="${status.count  }"/>_3" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.strtIp3 }"/>"/>
                                    <span>.</span>
                                    <input type="text" id="ip_strtIpVal_<c:out value="${status.count  }"/>_4" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.strtIp4 }"/>"/>
                                    <div style="display: ${result.bawdYn eq 'N' ? 'none' : 'inline-block' };" id="div_<c:out value="${status.count  }"/>">
                                        <span class="mar_l5 mar_r5">~</span>
                                        <input type="text" id="ip_endIpVal_<c:out value="${status.count  }"/>_1" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.endIp1 }"/>"/>
                                        <span>.</span>
                                        <input type="text" id="ip_endIpVal_<c:out value="${status.count  }"/>_2" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.endIp2 }"/>"/>
                                        <span>.</span>
                                        <input type="text" id="ip_endIpVal_<c:out value="${status.count  }"/>_3" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.endIp3 }"/>"/>
                                        <span>.</span>
                                        <input type="text" id="ip_endIpVal_<c:out value="${status.count  }"/>_4" class="text w100px ipChg" maxlength="3" value="<c:out value="${result.endIp4 }"/>"/>
                                    </div>
                                    <div>
                                        <%-- 시작IP --%>
                                        <input type="hidden" id="ip_strtIp_<c:out value="${status.count  }"/>" value="<c:out value="${result.strtIp }"/>" title="<c:out value="${result.bawdYn eq 'N' ? '' : '시작' }IP"/>" required="true">
                                        <%-- 종료IP --%>
                                        <input type="hidden" id="ip_endIp_<c:out value="${status.count  }"/>" value="<c:out value="${result.endIp }"/>" title="종료IP" <c:out value="${result.bawdYn eq 'N' ? '' : 'required=\"true\"' }"/>>
                                    </div>
                                </td>
                                <td>
                                    <select id="ip_bawdYn_<c:out value="${status.count  }"/>">
                                        <option value="N" label="단일" <c:out value="${result.bawdYn eq 'N' ? 'selected=\"selected\"' : '' }"/>>
                                        <option value="Y" label="대역폭" <c:out value="${result.bawdYn eq 'Y' ? 'selected=\"selected\"' : '' }"/>>
                                    </select>
                                </td>
                                <td>
                                    <input type="hidden" id="ip_ipSerno_<c:out value="${status.count  }"/>" value="<c:out value="${result.ipSerno }"/>"/>          <%-- 일련번호 --%>
                                    <input type="hidden" id="ip_seqo_<c:out value="${status.count  }"/>" value="<c:out value="${result.seqo }"/>"/>                <%-- 순서 --%>
                                    <a href="javascript:void(0)" id="ip_del_<c:out value="${status.count  }"/>" class="btn sml red"><span>삭제</span></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr class="no_data">
                            <td colspan="5">등록된 IP가 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</form:form>
<div class="btn_area">
    <c:if test="${sessionScope.SESSION_WRITE_BTN_KEY}">
        <button id="btn_submit" class="btn blue"><c:out value="${empty userVO.userSerno ? '등록' : '수정'}"/></button>
        <c:if test="${userVO.userSerno eq loginSerno or sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
            <c:if test="${userVO.lockYn eq 'Y' }"><a href="javascript:void(0)" id="btn_unlock" class="btn red">잠금해제</a></c:if>
            <button id="btn_delete" class="btn red">탈퇴</button>
        </c:if>
    </c:if>
    <button id="btn_list" class="btn gray">취소</button>
</div>
</body>
<script type="text/javascript">
    <%-- 상세흐름 순서 셋 --%>
    function setDataNo(){
        $(".ip_td").each(function(index){
            $(this).text(index + 1);
        });
    }

    <%-- IP 제한 --%>
    function fncIpChg(obj) {

        $(obj).val($(obj).val().replace(/[^0-9]/g,''))

        if(! $(obj).val()) {
            $(obj).val('0')
        }

        var val = $(obj).val();
        var min = 0;
        var max = 255;
        if(Number(val) < Number(min)) {
            $(obj).val(min);
        }
        if(Number(val) > Number(max)) {
            $(obj).val(max);
        }
        $(obj).val(Number($(obj).val()));

        <%-- 범위일경우 --%>
        if($(obj).attr('id').indexOf('ip_strtIpVal_') != -1) {

            var cnt = $(obj).attr('id').replace('ip_strtIpVal_','').substring(0,1);
            var cnt2 = $(obj).attr('id').replace('ip_strtIpVal_','').substring(2,3);

            if($('#ip_bawdYn_'+cnt).val() == 'Y') {

                var ip1 = $('#ip_strtIpVal_'+cnt+'_'+cnt2).val();
                var ip2 = $('#ip_endIpVal_'+cnt+'_'+cnt2).val();

                if(Number(ip1) > Number(ip2) || Number(ip1) == 0) {
                    $('#ip_endIpVal_'+cnt+'_'+cnt2).val(ip1);
                }
            }

        } else if($(obj).attr('id').indexOf('ip_endIpVal_') != -1) {

            var cnt = $(obj).attr('id').replace('ip_endIpVal_','').substring(0,1);
            var cnt2 = $(obj).attr('id').replace('ip_endIpVal_','').substring(2,3);

            if($('#ip_bawdYn_'+cnt).val() == 'Y') {

                var ip1 = $('#ip_strtIpVal_'+cnt+'_'+cnt2).val();
                var ip2 = $('#ip_endIpVal_'+cnt+'_'+cnt2).val();

                if(Number(ip1) > Number(ip2)) {
                    $('#ip_endIpVal_'+cnt+'_'+cnt2).val(ip1);
                }
            }
        }



    }

    function setName(index, name){
        return "ipList[" + index + "]." + name;
    }

    <%-- 데이터 셋팅 --%>
    const setDataList = function () {
        var filter = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;
        <%-- 일련번호 --%>
        $("input[id^=ip_ipSerno_]").each(function(index){
            $(this).attr("name", setName(index, "ipSerno"));
        });
        <%-- 순서 --%>
        $("input[id^=ip_seqo_]").each(function(index){
            $(this).attr("name", setName(index, "seqo"));
            $(this).val(index + 1);
        });
        <%-- 시작IP값 --%>
        $("input[id^=ip_strtIp_]").each(function(index){
            $(this).attr("name", setName(index, "strtIp"));

            var cnt = $(this).attr('id').replace('ip_strtIp_','');
            var ipv4 = $('#ip_strtIpVal_'+cnt+'_1').val() + '.' + $('#ip_strtIpVal_'+cnt+'_2').val() + '.' + $('#ip_strtIpVal_'+cnt+'_3').val() + '.' + $('#ip_strtIpVal_'+cnt+'_4').val()
            if (filter.test(ipv4) == true) {
                $(this).val(ipv4);
            }
        });
        <%-- 종료IP값 --%>
        $("input[id^=ip_endIp_]").each(function(index){
            $(this).attr("name", setName(index, "endIp"));

            var cnt = $(this).attr('id').replace('ip_endIp_','');
            var ipv4 = $('#ip_endIpVal_'+cnt+'_1').val() + '.' + $('#ip_endIpVal_'+cnt+'_2').val() + '.' + $('#ip_endIpVal_'+cnt+'_3').val() + '.' + $('#ip_endIpVal_'+cnt+'_4').val()
            if (filter.test(ipv4) == true) {
                $(this).val(ipv4);
            }
        });
        <%-- 대여폭여부 --%>
        $("select[id^=ip_bawdYn_]").each(function(index){
            $(this).attr("name", setName(index, "bawdYn"));
        });
    }

    <%-- 대역폭에 따른 변화 --%>
    function fncDivChg(num){
        if($('#ip_bawdYn_'+num).val() == 'N') {
            $('#ip_strtIp_'+num).attr('title', 'IP');
            $('#div_'+num).hide();
            $('#ip_endIp_'+num).removeAttr('required');
            $('#ip_endIpVal_'+num+'_1').val('');
            $('#ip_endIpVal_'+num+'_2').val('');
            $('#ip_endIpVal_'+num+'_3').val('');
            $('#ip_endIpVal_'+num+'_4').val('');
        } else {
            $('#ip_strtIp_'+num).attr('title', '시작IP');
            $('#div_'+num).css('display', 'inline-block');
            $('#ip_endIp_'+num).attr('required',true);
        }
    }

    var cnt = ${fn:length(ipList)};
    const fncIpAddAction = function () {
        cnt++;
        $.ajax({
            method: "POST",
            url: "/ma/sys/mngr/mngrMng/addIpForm.do",
            data: {cnt : cnt},
            dataType: "html",
            success: function (data) {
                $('#ip_tblBody').append(data);
            }
        }).done(function(data) {
            setDataNo();
            $('.no_data').remove();
        });
    }

    <%-- 삭제 --%>
    function fncDelTbl(id){
        $('#ip_tr_'+id).remove();

        if($('.ip_td').length == 0){
            let html =  '<tr class="no_data">';
                html += '<td colspan="5">등록된 IP가 존재하지 않습니다.</td>';
                html += '</tr>';
            $("#ip_tblBody").html(html);
        }else{
            setDataNo();
        }
    }
</script>