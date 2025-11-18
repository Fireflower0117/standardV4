<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>

<!DOCTYPE html>
<html lang="ko">
<style>
    /*메인 팝업*/
    .mainPop {
        position: absolute;
        border: 2px solid #0a4d96;
        background: #fff;
        z-index: 2000;
    }

    .mainPop_tag {
        position: absolute;
        top: 0;
        left: 0;
        z-index: 2;
        width: 86px;
        height: 86px;
        padding-top: 22px;
        color: #fff;
        font-size: 17px;
        line-height: 19px;
        text-align: center;
        background: #0b4789;
        background: -moz-linear-gradient(top, #0b4789 0%, #115bb0 100%);
        background: -webkit-linear-gradient(top, #0b4789 0%, #115bb0 100%);
        background: linear-gradient(to bottom, #0b4789 0%, #115bb0 100%);
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#0b4789',
        endColorstr='#115bb0', GradientType=0);
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#0d529f',
        endColorstr='#0b488b', GradientType=1);
        -webkit-box-shadow: 2px 2px 5px 1px rgba(0, 0, 0, 0.24);
        -moz-box-shadow: 2px 2px 5px 1px rgba(0, 0, 0, 0.24);
        box-shadow: 2px 2px 5px 1px rgba(0, 0, 0, 0.24);
    }

    .mainPop_tit {
        position: relative;
        margin: 0 32px 0 105px;
        padding: 27px 0;
        min-height: 112px;
        font-size: 21px;
        text-align: left;
        color: #3d3e3f;
    }

    .mainPop_tit::after {
        content: '';
        position: absolute;
        left: -78px;
        right: 0;
        bottom: 0;
        height: 1px;
        background: #ccc;
    }

    .mainPop_cont {
        position: relative;
        padding: 30px 47px;
        color: #545454;
        min-height: 200px;
        max-height: 600px;
        overflow: auto;
    }

    .mainPop_cont img {
        display: block;
        max-width: 100%;
        margin: 0 auto;
    }

    .mainPop_foot {
        background: #fff;
    }

    .mainPop_foot:after {
        content: "";
        display: block;
        clear: both;
    }

    .mainPop_foot .no_today {
        display: block;
        float: left;
        padding-left: 12px;
        width: 80%;
        height: 50px;
        line-height: 50px;
        border-top: 1px solid #ccc;
    }

    .mainPop_foot .checkbox {
        vertical-align: 0;
    }

    .mainPop_foot .btn_close {
        float: right;
        width: 20%;
        height: 50px;
        line-height: 50px;
        text-align: center;
        font-size: 13px;
        color: #fff;
        background-color: #0a4d96;
        border-top: 1px solid #0a4d96;
        border-left: 1px solid #0a4d96;
    }

    .btn_itsm  {margin-right: 14px; font-size:15px; display:inline-block; color:#fff;}
    .btn_itsm i{font-size: 16px;margin-right: 4px;vertical-align:-2px;}

    #left_area, .top_area {display: none;}
    #content {background: none;}
    #content .inner {min-height: 100%;padding: 0;background: none;}

    #main .item-04 .tbl_work .state2 {width: 45px;padding: 0 5px;border-radius: 3px;font-size: 13px;font-weight: 600;line-height: 35px;color: #333;text-align: center;}
    #main .item-04 .tbl_work .state2.c04 {background: #d1f7e6;border-color: #b8ead3;}
    #main .item-04 .tbl_work .state2.c05 {background: #e9edff;border-color: #cdd6fd;}
    #main .item-04 .tbl_work .state2.c06 {background: #ececec;border-color: #c1c1c1;}
</style>

<script type="text/javaScript">
$(document).ready(function(){
    <%-- 팝업 --%>
    popUp();

    $(window).resize( function() {
        popUp("resize");
    });

    fncSvcList("select", "", "", "schEtc00");
    fncMainSub();

    $("#schEtc00").on("change",function() {
        fncMainSub();
    })

});

<%-- 팝업 html --%>
function popUp(resize) {
    <%-- window 객체 배열 --%>
    var winList = [];
    <%-- modal 객체 배열 --%>
    var modalList = [];

    var popupCn = "";
    <c:forEach items="${popupList }" var="popup" varStatus="status">
    if( $.cookie("popUpYn${popup.popupSn}") != 'N' ) {

        popupCn = `${popup.popupCn}`

        var popData = {'popupSn' : '${popup.popupSn}',	'popupTtlNm' : '${popup.popupTtlNm}', 'popupCn' : popupCn, 'rprsImgFileId' : '${popup.rprsImgFileId}',
            'fileSeqo' : '${popup.fileSeqo}', 'popupTrgtCd' : '${popup.popupTrgtCd}', 'popupWdthSzVal' : '${popup.popupWdthSzVal}', 'popupHghtSzVal' : '${popup.popupHghtSzVal}',
            'popupLsdMargnVal' : '${popup.popupLsdMargnVal}', 'popupUpndMargnVal' : '${popup.popupUpndMargnVal}'};

        if(popData.popupTrgtCd == 'PT03') {
            modalList.push(popData);
        } else {
            winList.push(popData);
        }
    }
    </c:forEach>

    modalList.forEach( function(el, index) {
        $.ajax({
            method : "get",
            url : "/itsm/main/mainPop.do",
            data : el,
            dataType : "html",
            success : function(data) {
                setModalCss(data, el, resize);
            }
        })
    })

    <%-- resize가 될 경우 --%>
    if(resize == null || resize == "") {
        setWinCss(winList);
    }

}
<%-- 팝업 html --%>

<%-- modal 팝업 css --%>
function setModalCss(html, pop, resize) {

    var displayPop = $("#display_view"+ pop.popupSn);

    <%-- modal이 없을 경우 --%>
    if(displayPop.css("display") == undefined) {
        $("#pcPop").append(html);
        displayPop = $("#display_view"+ pop.popupSn);

        <%-- modal 팝업 class 세팅 --%>
        displayPop.removeClass();
        displayPop.addClass("notice_pop");
        displayPop.addClass("js-popup");
        view_show2(pop.popupSn);
        $("#js-popup-bg").hide();
    }

    <%-- modal 팝업 가로 설정 --%>
    var popWd = fncPopSetSize(pop.popupWdthSzVal, window.innerWidth);
    displayPop.css('width', popWd + 'px');

    <%-- modal 팝업 세로 설정 --%>
    var fixed = $("#header" + pop.popupSn).outerHeight() + $(".pop_footer").height();
    var popHgt = fncPopSetSize(pop.popupHghtSzVal, window.innerHeight);
    $("#cont" + pop.popupSn).css('height', (popHgt - fixed) +'px');

    <%-- modal 팝업 좌우 여백 설정 --%>
    var popX = fncPopSetPosition(parseInt(pop.popupLsdMargnVal), parseInt(popWd), window.innerWidth);
    if( popX < 0 ){
        popX = (( $(window).width() - displayPop.width()) / 2 );
    }
    displayPop.css('left', popX + 'px');

    <%-- modal 팝업 상단 여백 설정 --%>
    var popY = fncPopSetPosition(parseInt(pop.popupUpndMargnVal), parseInt(displayPop.height()), window.innerHeight);
    if( popY < 0 ){
        popY = (( $(window).height() - displayPop.height()) / 2 );
    }
    displayPop.css('top', popY + 'px');

    $( ".js-popup" ).draggable();

    return false;
}

<%-- window 팝업 css --%>
function setWinCss(winList) {

    var length = winList.length;
    var win = new Array(length);

    <%-- window 열려 있는 메인 페이지에서 이동 할 경우 --%>
    window.onbeforeunload = function() {
        if( document.readyState == "complete"){
            try {
                for( let i = 0 ; i < length ; i++ ) {
                    win[i].close();
                }
            }
            catch (e) {
                console.log(e);
            }
        }
    };

    for( let i = 0 ; i < length ; i++ ) {

        <%-- window 팝업이 없을 경우 --%>
        if( !win[i] ) {

            if( winList[i].popupTrgtCd == 'PT01' ){
                win[i] = window.open("/itsm/main/mainPop.do", "");
            } else {
                <%-- window 팝업 가로 설정 --%>
                var winWd = fncPopSetSize(winList[i].popupWdthSzVal, screen.availWidth, 0);

                <%-- window 팝업 세로 설정 --%>
                var winHg = fncPopSetSize(winList[i].popupHghtSzVal, screen.availHeight, 0);

                <%-- window 팝업 좌우 여백 설정 --%>
                var winX = fncPopSetPosition(parseInt(winList[i].popupLsdMargnVal), parseInt(winWd), screen.availWidth);
                winX += window.screenLeft;

                <%-- window 팝업 상단 여백 설정 --%>
                var winY = fncPopSetPosition(parseInt(winList[i].popupUpndMargnVal), parseInt(winHg), screen.availHeight);

                var winCss = 'width='+ winWd +', height='+ winHg +', left='+ winX +', top='+ winY +', status=no, location=no, menubar=no';

                win[i] = window.open("/itsm/main/mainPop.do", "", winCss);
            }

            $.ajax({
                method : "get",
                url : "/itsm/main/mainPop.do",
                data : winList[i],
                dataType : "html",
                success : function(data) {
                    win[i].document.write(data);
                }
            })

        }
    }
    return false;
}

<%-- 팝업 크기 설정 --%>
function fncPopSetSize(popSz, maxSz){
    var resSz = popSz;
    if( popSz == '' || popSz <= 500 ) {
        resSz = 500;
    } else if( popSz >= maxSz ) {
        resSz = maxSz;
    }
    return resSz;
}

<%-- 팝업 위치 설정 --%>
function fncPopSetPosition(popMg, popSz, maxSz) {
    var resCord = -1;
    if( popMg != '' && popMg != '0') {
        if( popSz + popMg < maxSz ) {
            resCord = popMg;
        }
    }
    return resCord;
}

<%-- 팝업 오늘 하루 동안 열지 않음  --%>
function closePopup(num, popDivn) {
    var date = new Date();
    <%-- 쿠키 만료 기간 --%>
    var expDt = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), 14,59,59));
    if( popDivn == 'modal' ) {
        if ($("input:checkbox[name=popUp" +num+ "]").is(":checked") == true) {
            $.cookie("popUpYn"+num, "N", { expires : expDt });
            view_hide2(num);
        }
    } else if ( popDivn == 'window' ) {
        $.cookie(num, "N", { expires : expDt });
    }
};

/** popup **/
// popup
function view_show2(popName) {
    let left = ($(window).width() - $("#display_view" + popName).width()) / 2;
    let top = ($(window).height() - $("#display_view" + popName).height()) / 2;
    $("#js-popup-bg").show();
    $("#display_view" + popName).css({
        'position': 'fixed',
        'left': left,
        'top': top,
        'z-index': 5500
    }).show();
    return false;
}

function view_hide2(popName) {
    $("#display_view" + popName).hide();
    $("#js-popup-bg").hide();
    return false;
}

// 메인 팝업
$(document).ready(function () {
    $(".main_pop").draggable();
    $(".main_pop .close").click(function(){
        $(this).closest(".main_pop").hide();
        return false;
    })
})


// a javascript:void(0);
$(document).ready(function () {
	$('a').each(function () {
		if (!$(this).attr('href')) {
			$(this).attr('href', "javascript:void(0);");
		}
	});
});


<%-- 문서관리 --%>
function fncFilePop(docSn) {
    fncAjax('/itsm/info/doc/filePop.do', {"docSn" : docSn}, 'html', true, '', function(html){
        modal_show('800px', '300px', html);
    });
}

<%-- 질의응답, 문서관리 바로가기 --%>
function fncMainTap(idx){
    if(idx == '1'){
        $("#hrefTap").attr("href", "/itsm/svcReq/qna/list.do")
    }else if(idx == '2'){
        $("#hrefTap").attr("href", "/itsm/info/doc/list.do")
    }
}


<%-- 메인화면 나머지 데이터 불러오기--%>
function fncMainSub() {
    $.ajax({
        type : 'get'
        ,url : "/itsm/main/mainSub.do"
        ,data : $('#defaultFrm').serialize()
        ,dataType : 'HTML'
        ,success : function(data) {
            $("#mainSub").html(data);
        },error : function(xhr, status, error){
            if (xhr.status == 401) {
                window.location.reload();
            }
            alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
        }
    });
}

</script>

<link rel="stylesheet" type="text/css" href="/component/itsm/css/jquery.mCustomScrollbar.css">
<script type="text/javascript" src="/component/itsm/js/jquery.mCustomScrollbar.min.js"></script>
<body>
<!-- main -->
<main id="main">
    <!-- lcont - 1 -->
    <div class="lcont" >
        <div class="item-01">
            <div class="top">
                <h4 class="md_tit">나의 요청내역</h4>
                <form:form modelAttribute="searchVO" id="defaultFrm" name="defaultFrm" method="post" onsubmit="return false;">
                    <!-- fncPageBoard 작동을 위한 hidden 태그 -->
                    <input type="hidden" name="chgSn" id="chgSn"/>
                    <input type="hidden" name="inspSn" id="inspSn"/>
                    <input type="hidden" name="qnaSn" id="qnaSn"/>
                    <input type="hidden" name="docSn" id="docSn"/>
                    <input type="hidden" name="errSn" id="errSn"/>
                    <input type="hidden" name="imprvSn" id="imprvSn"/>
                    <c:choose>
                        <c:when test="${sessionScope.itsm_user_info.userSvcSn eq 0}">
                            <select class="select" id="schEtc00" name="schEtc00">
                            </select>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="schEtc00" value="${sessionScope.itsm_user_info.userSvcSn}"/>
                        </c:otherwise>
                    </c:choose>
                </form:form>
            </div>
            <div class="profile">
                <figure>
                    <img src="/component/itsm/images/main/i_profile.png" alt="">
                </figure>
                <ul class="">
                    <li><span class="tit">ID</span><c:out value="${itsm_user_info.userId}"/><a href="/ma/logout.do" class="btn_logout">logout</a></li>
                    <li><span class="tit">E-mail</span><c:out value="${itsm_user_info.userEmailAddr}"/></li>
                    <li><span class="tit">Log</span><c:out value="${itsm_user_info.lstAcsDt}"/></li>
                </ul>
            </div>
            <div class="mCustomScrollbar">
                <ul class="req_list">
                    <c:choose>
                        <c:when test="${fn:length(myList) gt 0}">
                            <c:forEach var="result" items="${myList}" varStatus="status">
                                <li>
                                    <a href="javascript:void(0);" onclick="fncPageBoard('view', '/itsm/svcReq/impFnc/view.do', '${result.imprvSn}', 'imprvSn')">
                                        <span class="date"><c:out value="${result.month}"/>월<span><em><c:out value="${result.day}"/></em>일</span></span>
                                        <div>
                                            <p class="txt"><c:out value="${result.dmndTtl}"/></p>
                                            <div class="btm">
                                                <dl>
                                                    <dt><span class="tag">처리요청일</span></dt>
                                                    <dd><c:out value="${result.dmndDt}"/></dd>
                                                </dl>
                                                <dl>
                                                    <dt><span class="tag">요청자</span></dt>
                                                    <dd><c:out value="${result.rgtrNm}"/></dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="no_data">데이터가 없습니다.</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
    <!-- // lcont - 1 -->
    
    <!-- mainSub -->
    <div id="mainSub">

    </div>
    <!-- // mainSub -->
</main>
<!-- // main -->


<div id="modal_div"></div>
<div id="pcPop"></div>
<div class="popup_bg itemB" id="js-popup-bg" onclick="modal_hide_all();"></div>
<!-- 전체 페이지 로딩 -->
<div class="loading_wrap" style="display: none;" id="loadingDiv">
    <div class="loading"></div>
</div>
<div class="sm_popup" id="svyInfo" style="width:750px; left: 50%; top: 50%; margin-left:-350px; transform:translateY(-50%); display: none; position:absolute; z-index:9999;">
    <h3>대상자정보<a href="javascript:void(0)" class="pop_close" onclick="$('#svyInfo').hide(); $('.popup_bg').hide();" style="float:right;"><i class="xi-close-thin"></i></a></h3>
    <div class="pop_cont">
        <div id="svyInfoTable">
        </div>
    </div>
</div>
</body>
</html>