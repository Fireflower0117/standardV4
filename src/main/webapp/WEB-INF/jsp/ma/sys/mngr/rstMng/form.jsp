<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
    $(document).ready(function(){
    	
        $('#userId').on('input', function(event) {
            // ID중복체크
            fncIdOvlpChk($(this).val());
        });

        $('#btn_submit').on('click', function () {
            if (wrestSubmit(document.defaultFrm)) {
                if (!idChk.test($("#userId").val())) {
                    alert("5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
                    return false;
                }
                if (ovlpChk == 1) {
                    alert('이미 등록된 제한 아이디입니다.');
                    return false;
                }

                fncProc('insert');
            }
        });

    });

    var ovlpChk = 0;
    var idChk = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
    const fncIdOvlpChk = function(userId) {


        $(".msg_only").remove();
        if (!idChk.test($("#userId").val())) {
            ovlpChk = 0;
            wrestMsg = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";

            // 오류메세지를 위한 element 추가
            var msgHtml = '<strong id="strong_userId" class= "msg_only"><font color="red">&nbsp;' + wrestMsg + '</font></strong>';

            $("#userId").parent().append(msgHtml);
            return false;
        }

        $.ajax({
            method: "POST",
            url: "/ma/sys/mngr/mngrMng/idOvlpChk",
            data: {userId: userId},
            dataType: "json",
            success: function (data) {
                let rstCnt = data.rstCnt;


                if (rstCnt > 0) {
                    var wrestMsg = "\'" + $("#userId").val() + "\'" + "은(는) 이미 등록된 제한 아이디입니다.";

                    // 오류메세지를 위한 element 추가
                    var msgHtml = '<strong id="strong_userId" class="msg_only"><font color="red">&nbsp;' + wrestMsg + '</font></strong>';

                    $("#userId").parent().append(msgHtml);
                    ovlpChk = 1;
                } else {
                    $("#strong_userId").remove();
                    ovlpChk = 0;
                }
            },error: function (xhr, status, error) {

                if (xhr.status == 401) {
                    window.location.reload();
                }
                alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
            }
        });
    }
</script>
<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post" onsubmit="return false;">
    <jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/>
    <div class="board_top">
        <div class="board_right">
            <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
        </div>
    </div>
    <table class="board_write">
        <caption>내용(아이디, 이름, 비밀번호, 전화번호, 이메일, 권한, 차단여부, 사용여부, 잠금여부로 구성)</caption>
        <colgroup>
            <col class="w10p">
            <col class="w40p">
            <col class="w10p">
            <col class="w40p">
        </colgroup>
        <tbody>
            <tr>
                <th scope="row"><span class="asterisk">*</span>아이디</th>
                <td colspan="3">
                    <form:input path="userId" cssClass="text w100p" maxlength="20" title="아이디" required="true" placeholder="5~20자의 영문 소문자, 숫자와 특수기호(_),(-)"/>
                </td>
            </tr>
        </tbody>
    </table>
    <div class="btn_area">
        <c:if test="${sessionScope.SESSION_MANAGER_WRITE_BTN_KEY}">
            <a href="javascript:void(0)" id="btn_submit" class="btn blue">등록</a>
        </c:if>
        <a href="javascript:void(0)" id="btn_list" class="btn gray">목록</a>
    </div>
</form:form>