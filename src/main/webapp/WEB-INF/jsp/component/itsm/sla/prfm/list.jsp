<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
    <%--url 패턴 처리--%>
    const validUrl = function(url){
        const pattern = /^(https?:\/\/)?((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|((\d{1,3}\.){3}\d{1,3}))(\/[-a-z\d%_.~+]*)*(\?[;&a-z\d%_.~+=-]*)?(#[-a-z\d_]*)?$/i;
        /*const lengthLimit = /^.{0,80}$/;*/
        return pattern.test(url)/* && lengthLimit.test(url)*/;
    }
    $(document).ready(function(){
        <%--검색--%>
        $("#btn_srch").on("click", function(){
           /* if(validUrl($("#defaultFrm #srchKeyword").val())){*/
                $(".loading_wrap").show();

                $(".tbl").empty();

                $("#domainUrl").val($("#srchKeyword").val());
                $.ajax({
                    method: "POST",
                    url: "addList.do",
                    data: $("#defaultFrm").serialize(),
                    dataType: "html",
                    success: function(data) {
                        //fncLoadingEd();
                        $(".tbl").html(data);
                        $(".loading_wrap").hide();
                    }
                });
           /* }else{
                alert("정상적인 URL주소가 아닙니다.");
                return false;
            }*/
        });
    })


</script>
<div class="search_basic">
    <form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
        <input type="hidden" name="domainUrl" id="domainUrl" value="" />
        <table>
            <caption>구분</caption>
            <colgroup>
                <col style="width:10%">
                <col>
                <col style="width:10%">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <td><label>URL</label></td>
                <td colspan="3">
                    <form:input path="searchKeyword" id="srchKeyword" placeholder="url를 입력해주세요." maxlength="1000"/>
                </td>
            </tr>
            </tbody>
        </table>
        <button type="button" id="btn_srch" class="btn btn_mdl btn_write"><i class="xi-search"></i>검사</button>
    </form:form>
</div>
<div class="tbl"></div>
<!--팝업영역  -->
<div id="display_view1" class="layer_pop js_popup" style="width: 1500px;"></div>
<div class="popup_bg" id="js_popup_bg"></div>
