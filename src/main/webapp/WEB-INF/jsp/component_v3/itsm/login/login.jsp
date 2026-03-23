<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javaScript">
    const itsmLogin = function () {
        <%-- 로그인 처리 --%>
        $.ajax({
            url: "login.do",
            type: "post",
            data: "",
            dataType: "json",
            success: function(data){
                if (data.result) {
                    location.href = data.returnUrl;
                } else {
                    alert(data.message);
                    window.close();
                }
            },
            error: function (xhr, status, error) {
                alert("비정상적인 접근입니다.");
                window.close();
            }
        });
    }
    $(document).ready(function(){
        itsmLogin();
    });
</script>