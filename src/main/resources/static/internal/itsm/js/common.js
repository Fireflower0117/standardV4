$(function(){
	lnb();
    lnb_onOff();
    infoShow();
    searchShow();
    $('#js-popup-bg').click(function(){
		$('.js-popup').css("display","none");
		$(this).css("display","none");
	});

    $('.numOnly').on('input', function(event) {
        this.value=this.value.replace(/[^0-9]/g,'');
    });
    $('.numDotOnly').on('input', function(){
        this.value=this.value.replace(/^([^.]*\.)|\.+/g, '$1').replace(/[^\d.]+/g, '');
    });
    $('.floatNumOnly').keydown(function(event) {
        this.value=this.value.replace(/^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/,'$1$2$3$5');
    });
    $('.floatNumOnly').keyup(function(event) {
        this.value=this.value.replace(/^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/,'$1$2$3$5');
    });
});
// upperCode - 부모코드
// codeType - select, check, radio
// defVal - 기본값 SELECT박스 전체, 선택 등등
// selVal - 선택할값(검색값유지) checkbox는 콤마로 구분해서 넣으면 됩니다.
// name - name속성 값 checkbox랑 radio만 넣어주면됩니다.
// tagId - 태그 ID select는 select 태그의 id, 나머지는 부모태그의 id값 넣어주면 됩니다.
// idKey - checkbox, radio 동적으로 추가할일 있을때 사용 기본 check_코드, radio_코드지만 값을 주면 check_코드_값, radio_코드_값
// sort - 정렬 - ASC, DESC 입력
// title - (유효성 검사를 위한) radio, checkbox의 유효성 메세지
// required - (유효성 검사를 위한) radio, checkbox의 필수조건 설정
function fncCodeList(upperCode, codeType, defVal, selVal, name, tagId, idKey, sort, title, required){
    $.ajax({
        url      : "/common/getItsmCode.do",
        type     : "post",
        data     : {
            uppoCdVal : upperCode,
            codeType  : codeType,
            defVal    : defVal,
            selVal    : selVal,
            name      : name,
            idKey     : idKey,
            sort	  : sort,
            title     : title,
            required  : required,
        },
        dataType : "html",
        async    : false,
        success  : function(data){
            $("#" + tagId).html(data);
        }
    })
}


// ITSM 시스템의 메뉴가 아닌 본 서비스의 메뉴 목록을 불러와야한다
function fncMenuList(upperCode, codeType, defVal, selVal, name, tagId, idKey, sort, title, required){
    $.ajax({
        url      : "/common/getItsmMenuCode.do",
        type     : "post",
        data     : {
            uppoCdVal : upperCode,
            codeType  : codeType,
            defVal    : defVal,
            selVal    : selVal,
            name      : name,
            idKey     : idKey,
            sort	  : sort,
            title     : title,
            required  : required,
        },
        dataType : "html",
        async    : false,
        success  : function(data){
            $("#" + tagId).html(data);
        }
    })
}

function lnb(){
    // 3뎁스 클릭 이벤트
    $('.deps1 li.has_sub > a').on('click', function(){
        $(this).removeAttr('href');
        var element = $(this).parent('li');
        if (element.hasClass('open')) {
            element.removeClass('open');
            element.find('li').removeClass('open');
            element.find('.deps2').slideUp(200);
        }
        else {
            element.addClass('open');
            element.children('.deps2').slideDown(200);
            element.siblings('li').children('.deps2').slideUp(200);
            element.siblings('li').removeClass('open');
        }
    });
}
function lnb_onOff(){
    $(".lnb_close").click(function(event){
		event.preventDefault();
		$("#left_area").addClass("left_close");
	});
    $(".lnb_open").click(function(event){
		event.preventDefault();
		$("#left_area").removeClass("left_close");
	});
}
function searchShow(){
    $(".search_detail").css("display","none");
    $(".btn_onoff").on("click",function() {
        if($(this).hasClass("active")){
            $(this).removeClass("active");
            $(".search_detail").css("display","none");
        }else{
            $(this).addClass("active");
            $(".search_detail").css("display","");
        }
        return false;
    });
}

//tab
function tab(){
	$(".tab_content").hide();
	$(".tab_content:first").show();
	$(".js-tab a").click(function(event) {
		event.preventDefault();
		$(this).parent().addClass("current");
		$(this).parent().siblings().removeClass("current");
		var tab = $(this).attr("href");
		$(".tab_content").not(tab).css("display", "none");
		$(tab).fadeIn();
	});
}
//popup
function view_show(num) {
    var left = (( $(window).width() - $("#dispay_view"+num).width()) / 2 );
    var top = (( $(window).height() - $("#dispay_view"+num).height()) / 2 );
    $("#dispay_view"+num).css({'left':left,'top':top, 'position':'fixed'});
    document.getElementById("js-popup-bg").style.display = "block";
    document.getElementById("dispay_view"+num).style.display = "block";
    return false;
 }
function view_hide(num) {
	document.getElementById("display_view_"+num).style.display = "none";
	document.getElementById("js-popup-bg").style.display = "none";
	return false;
}

function infoShow(){
    $("#js-infoBox").hide();
    $(".info_onoff").click(function(event) {
		event.preventDefault();
        var infoBox = $("#js-infoBox");
        if($(this).hasClass("on")){
            $(this).removeClass("on");
            $(infoBox).slideUp(200);
        }else{
            $(this).addClass("on");
    		$(infoBox).fadeIn();
        }
	});
}

var fncDate = function(){
	var setDate = arguments;
	var getId;
	var fmt = "yy.mm.dd";
	switch (setDate.length) {
		case 1: getId ="#"+setDate[0];break;
		case 2: if(setDate[1] != ''){getId ="#"+setDate[0]+", #"+setDate[1];break;}else{getId ="#"+setDate[0];break;}
		case 3: if(setDate[1] != ''){getId ="#"+setDate[0]+", #"+setDate[1];fmt=setDate[2];break;}else{getId ="#"+setDate[0];fmt=setDate[2];break;}
	}
	
	var dates = $( getId ).datepicker({
        changeMonth: true,
        changeYear: true,
        showOn: "button",
        buttonImage: "/component/itsm/images/sub/icon_calendar.png",
        buttonImageOnly: true,
        dateFormat : fmt,
        onSelect: function( selectedDate ) {
            var option = this.id == setDate[0] ? "minDate" : "maxDate",
            instance = $( this ).data( "datepicker" ),
            date = (fmt == 'yy.mm' ? new Date(instance.selectedYear, instance.selectedMonth, 1) : $.datepicker.parseDate( $.datepicker._defaults.dateFormat, selectedDate, instance.settings ))
      	    dates.not( this ).datepicker( "option", option, date );
      	    $(this).trigger("change");
        }
  	});

	$(getId).removeAttr('readonly');
	$(getId).attr('maxlength', '10');
	$(getId).addClass('numDotOnly');

	$('.numDotOnly').on('input', function(){
		this.value=this.value.replace(/^([^.]*\.)|\+/g, '$1').replace(/[^\d.]+/g, '');
		if(this.value.length > 0 && this.value.substr(this.value.length-1,1) == '.' && ! (this.value.length == 5 || this.value.length == 8)) {
			this.value=this.value.substr(0,this.value.length-1);
		}
		
	});
}

function fncMonth(id){
    $("#"+id).monthpicker({
        monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        showOn : "button",
        buttonImage : "/component/itsm/images/sub/icon_calendar.png",
        buttonImageImageOnly : true,
        changeYear : false,
        yearRange : 'c-2:c+2',
        dateFormat : 'yy.mm'
    });
}

/*
	20220519 추가 구연호
	공통 액셀 업로드 jsp 호출
*/
function modal_cmmn_excel(){
    fncAjax('/common/excelAjax.do', $('#defaultFrm').serialize(), 'html', true, '', function(data){
        modal_show('1400px','250px',data);
    });
}

/*
	20220516 추가 구연호

	현재 존재하는 모든 모달을 백그라운드 뒤로 이동시킨다. z-index변경
	modalType = "B";

	현재 존재하는 모든 모달을 숨기기
	modalType = "I";

*/
var modalType = "B";
/*
	var width = '1400px';
	var height = '700px';

	모달 출력 : modal_show(width, height, html);

	모달 닫기 : modal_hide(this);


	ex : modal_show('1400px', '700px', html);
	ex : modal_show('50%', '50%', html);
*/
function modal_show(width, height, html){

    if(modalType == "B"){
        // 현재 존재하는 모든 모달을 백그라운드 뒤로 이동시킨다. z-index변경
        modal_back_move_action();
    } else if (modalType == "I") {

        // 현재 존재하는 모든 모달을 숨기기
        modal_all_invisible_action();
    }


    let divHtml = "";
    var maxNum = modal_max_num();
    const modalDiv = $('#modal_div');

    var createNum = (maxNum == 0 ? 1 : Number(maxNum) + Number(1));

    divHtml += `<div id="display_view_`+createNum+`" class="layer_pop js-popup" style="width: `+width+`; height: `+height+`; z-index: `+ (Number(5000)+ Number(createNum))+`;"></div>`;

    modalDiv.append(divHtml);
    $('#display_view_'+createNum).html(html);

    var contHeight = 0;

    // 높이 설정
    // px : 픽셀
    if(height.indexOf('px') != -1) {
        contHeight = Number(height.replace(/[^0-9]/g, ""));
        // % : 퍼센트
    } else if(height.indexOf('%') != -1) {
        contHeight = (Math.floor(($(window).height()/100) * Number(height.replace(/[^0-9]/g, ""))));
        $('#display_view_'+createNum).css({'height': contHeight});
    }

    var header = $('#display_view_'+createNum).children('.pop_header').outerHeight(true);
    var footer = $('#display_view_'+createNum).children('.pop_footer').outerHeight(true);

    if(header){contHeight = contHeight - header}
    if(footer){contHeight = contHeight - footer}

    $('#display_view_'+createNum).children('.pop_content').css({'height': contHeight+'px'});


    var left = (( $(window).width() - $("#display_view_"+createNum).width()) / 2 );
    var top = (( $(window).height() - $("#display_view_"+createNum).height()) / 2 );
    $("#display_view_"+createNum).css({'left':left,'top':top, 'position':'fixed'});
    document.getElementById("display_view_"+createNum).style.display = "block";
    document.getElementById("js-popup-bg").style.display = "block";

    return false;
}

// 모달 상단 X버튼, 하단 닫기 버튼
// 사용법 : modal_hide(this);
function modal_hide(obj){

    $('#'+$(obj).parents("[id^='display_view_']").attr('id')).remove();

    if(modalType == "B"){
        // 현재 존재하는 모든 모달을 백그라운드 뒤로 이동시킨다. z-index변경
        modal_back_div_show();
    } else if (modalType == "I") {

        // 현재 존재하는 모든 모달을 숨기기
        modal_invisible_show_action();
    }

    var maxNum = modal_max_num();

    if(maxNum == 0){document.getElementById("js-popup-bg").style.display = "none";}

}
/*
	== 번외 ==

	모달 전체 닫기 : modal_hide_all();

	현재 출력된 modal ID 취득 : modal_get_id();

	다음 모달 modal ID 취득 : modal_new_id();

	== 백그라운드 뒤로 옮기기
	modal_back_move_action();  - modal_show
	modal_back_div_show();    - modal_hide

	== 숨기기
	modal_all_invisible_action();   - modal_show
	modal_invisible_show_action();       - modal_hide

	== 백그라운드를 클릭했을 경우 상호동작 X - 설정변경
	modal_back_fnc_off();

	== 백그라운드를 클릭했을 경우 모든창 제거 - 설정변경
	modal_back_fnc_on();

	== 백그라운드를 클릭했을 경우 현재창 제거 - 설정변경
	modal_back_fnc_del();

	== 백그라운드를 클릭했을 경우 특정 function 실행 - 설정변경
	modal_back_fnc_set(fnc);
	ex) modal_back_fnc_set('test();');

	function test(){
		console.log('실행');
	}

*/
// 현재 제일 맨위에 있는 창을 제거
function modal_last_hide(){
    var modalId = modal_get_id();

    $('#'+modalId).remove();

    // 현재 모달을 제거한 후 맨위에 있는 모달의 z-index를 상승시켜서 상단에 노출시킨다.
    modal_back_div_show();

    // 닫기 버튼 연계 - 현재 모달을 제거한 후 맨위에 있는 모달을 보이게 변경
    //modal_invisible_show_action();

    var maxNum = modal_max_num();

    if(maxNum == 0){document.getElementById("js-popup-bg").style.display = "none";}
}

// 모달 전체 닫기
function modal_hide_all(){
    $('#modal_div').html('');
    document.getElementById("js-popup-bg").style.display = "none";
    return false;
}


// 맨위에 출력된 모달 ID 취득
function modal_get_id(){

    var modalIdNm = "display_view_";
    var maxNum = modal_max_num();

    return (maxNum == 0 ? null : modalIdNm + maxNum)
}

// 모달 신규 ID 발급
function modal_new_id(){

    var modalIdNm = "display_view_";
    var maxNum = modal_max_num();

    return (maxNum == 0 ? null : modalIdNm + Number(maxNum) + Number(1))
}

// modal_show 연계 - 현재 존재하는 모든 모달을 백그라운드 뒤로 이동시킨다. z-index변경
function modal_back_move_action(){

    const modalDiv = $('#modal_div');

    var modalIdArr = new Array();

    modalDiv.children('div[ID^="display_view_"]').each(function(index){
        modalIdArr.push($(this).attr('id'));
    });

    for(let i=modalIdArr.length-1 , j = 1; i >= 0; i--, j++) {
        $('#'+modalIdArr[i]).css({'z-index' : (Number(5000) - j)});
    }

}

// 닫기 버튼 연계 - 현재 모달을 제거한 후 맨위에 있는 모달의 z-index를 상승시켜서 상단에 노출시킨다.
function modal_back_div_show(){
    var modalId = modal_get_id();
    if(modalId){
        $('#'+modalId).css({'z-index' : 5001});
    }
}

// modal_show 연계 - 현재 존재하는 모든 모달을 숨기기
function modal_all_invisible_action(){

    const modalDiv = $('#modal_div');
    modalDiv.children('div[ID^="display_view_"]').each(function(index){
        document.getElementById($(this).attr('id')).style.display = "none";
    });
}

// 닫기 버튼 연계 - 현재 모달을 제거한 후 맨위에 있는 모달을 보이게 변경
function modal_invisible_show_action(){
    var modalId = modal_get_id();
    if(modalId){
        document.getElementById(modalId).style.display = "block";
    }
}

// 백그라운드를 클릭했을 경우 상호동작 X - 설정변경
function modal_back_fnc_off(){
    $('#js-popup-bg').attr('onclick', '');
}

// 백그라운드를 클릭했을 경우 모든창 제거 - 설정변경
function modal_back_fnc_on(){
    $('#js-popup-bg').attr('onclick', 'modal_hide_all();');
}

// 백그라운드를 클릭했을 경우 현재창 제거 - 설정변경
function modal_back_fnc_del(){
    $('#js-popup-bg').attr('onclick', 'modal_last_hide();');
}

// 백그라운드를 클릭했을 경우 특정 function 실행
function modal_back_fnc_set(fnc){
    $('#js-popup-bg').attr('onclick', fnc);
}

// 모달 뒤로 이동 설정
function modal_back_move_set(){
    modalType = "B";
}

// 모달 숨기기 설정
function modal_invisible_set(){
    modalType = "I";
}

// 출력되어있는 모달중 최상위 모달의 값을 가져온다.
function modal_max_num(){

    var maxNum = 0;
    const modalDiv = $('#modal_div');

    modalDiv.children('div[ID^="display_view_"]').each(function(){
        if(maxNum < $(this).attr('id').replace('display_view_','')){maxNum = $(this).attr('id').replace('display_view_','')}
    });

    return maxNum
}

// 엑셀업로드 popup 창 띄우는 함수
function fncNotExmnExcelForm(size){
    fncAjax('excelForm.do', $('#defaultFrm').serialize(), 'html', true, '', function(html){
        modal_show('1200px', '300px', html);
    });
}

// 항공/현장 미조사 액셀 다운로드 및 일반다운로드
function fncNotExmnExcel(clcd, length){

    // 미조사 다운로드
    if(clcd == "down") {

        if(nullCheck(length) || length == 0 ) {
            alert("조회된 목록이 없습니다.");
            return false;
        } else if(nullCheck(length) || length > 1000000 ) {
            alert("100만건 이상의 데이터는 다운받을 수 없습니다.");
            return false;
        } else {

            fncLoadingStart();

            $.fileDownload("excelNotExmnListDownload.do", {
                httpMethod : "POST",
                data : $("#defaultFrm").serialize(),
                successCallback : function(url){
                    fncLoadingEnd();
                    return false;
                },
                failCallback : function(responseHtml, url, error){
                    alert("엑셀 다운로드가 실패하였습니다");
                    fncLoadingEnd();
                    return false;
                }
            });
        }



        //fncPageBoard("view", "excelNotExmnListDownload.do");
        //$("#defaultFrm").attr("onsubmit","return false;");

        // 샘플 다운로드
    } else if(clcd == "sample") {
        fncPageBoard("view", "excelSampleDownload.do");
        $("#defaultFrm").attr("onsubmit","return false;");

        // 액셀 업로드
    } else if(clcd == "upload") {

        // 유효성검사
        if($("#defaultFrm_excel_pop #atchFileUpload").find(".totalFileCnt").val() == 0){
            alert("파일을 첨부해주세요");
            return false;
        }

        // 첨부파일명 유효성검사
        if($("#defaultFrm_excel_pop #atchFileUpload").find('table').find('.file_tit label').text() == ''
            || $("#defaultFrm_excel_pop #atchFileUpload").find('table').find('.file_tit label').text() == null
            || $("#defaultFrm_excel_pop #atchFileUpload").find('table').find('.file_tit label').text() === undefined
        ) {

            alert('비정상적인 첨부파일입니다.');
            return false;
        }

        fncLoadingStart();

        //$('#defaultFrm_excel_pop ')
        fileFormSubmit("defaultFrm_excel_pop", 'insert', function () {
            fncAjax('excelUpload.json', $("#defaultFrm_excel_pop").serialize(), 'json', true, '', function(data){
                alert(data.message);
                fncLoadingEnd();
                modal_last_hide();

                 if(data.result) {
                    if($('.btn_search').length > 0) {
                        $('.btn_search').trigger("click");
                    }
                }

                //fncNotExmnExcelForm();
            });
        });

        // 일반 다운로드
    } else if(clcd == "nomalDown") {
        if(nullCheck(length) || length == 0 ) {
            alert("조회된 목록이 없습니다.");
            return false;
        } else if(nullCheck(length) || parseInt(length) > 1000000 ) {
            alert("100만건 이상의 데이터는 다운받을 수 없습니다.");
            return false;
        } else {
            fncLoadingStart();
            $.fileDownload("downExcel.json", {
                httpMethod : "POST",
                data : $("#defaultFrm").serialize(),
                successCallback : function(url){
                    fncLoadingEnd();
                    return false;
                },
                failCallback : function(responseHtml, url, error){
                    alert("엑셀 다운로드가 실패하였습니다");
                    fncLoadingEnd();
                    return false;
                }
            });
        }

    }
}



/** 서비스 목록 불러오는 함수
 *  svcSn : form 화면에서만 사용하는 변수 (loginController 에서 session 에 담은 서비스정보 일련번호)
 * */
function fncSvcList(codeType, defVal, selVal,tagId,svcSn){
    $.ajax({
        url      : "/common/getSvcList.do",
        type     : "post",
        data     : {
            codeType  : codeType,
            defVal    : defVal,
            selVal    : selVal,
        },
        dataType : "html",
        async    : false,
        success  : function(data){
            $("#" + tagId).html(data);
            $("#"+tagId+" option[value="+svcSn+"]").prop("selected",true);
        }
    })
}

/** 담당자 목록 불러오는 함수 */
function fncManagerList(codeType, defVal, selVal,tagId, svcSn){
    $.ajax({
        url      : "/common/getManagerList.do",
        type     : "post",
        data     : {
            codeType  : codeType,
            defVal    : defVal,
            selVal    : selVal,
            svcSn     : svcSn,
        },
        dataType : "html",
        async    : false,
        success  : function(data){
            $("#" + tagId).html(data);
        }
    })
}

