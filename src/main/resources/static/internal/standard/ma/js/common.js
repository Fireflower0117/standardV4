//gnb left 고정
$(document).ready(function () {
	gnb();
	
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

function gnb(){
	if ($("#gnb.leftfix").hasClass("main_type")) {
        $(".js_subwrap").hide();
    }
    $(".gnb > li").on("mouseenter", function () {
        if ($(this).hasClass("visible")) {
            $(".subwrap").removeClass("on");
            $(this).addClass("on").children(".subwrap").addClass("on");
        } else {
            $(".subwrap").removeClass("on");
            $(this).addClass("on").children(".subwrap").addClass("on");
            $(".gnb > li.visible").addClass("off");
        }
    });
    $(".gnb > li").on("mouseleave", function () {
        $(this).removeClass("on");
        $(".gnb > li.visible").removeClass("off");
        $(".subwrap").removeClass("on");
    });

    // 2뎁스 클릭 이벤트
    $('.deps2 > li > a').on('click', function () {
        if ($(this).parent().hasClass("has_sub")) {
            if ($(this).parent().hasClass("on")) {
                $(this).parent().removeClass("on");
                return false;
            } else {
                $('.deps2 > li').removeClass("on");
                $(this).parent().addClass("on");
                return false;
            }
        }
    });
}

//tab
function tab(){
	$(".tab_content").hide();
	$(".tab_content:first").show();
	$(".tab a").click(function(event) {
		event.preventDefault();
		$(this).parent().addClass("on");
		$(this).parent().siblings().removeClass("on");
		var tab = $(this).attr("href");
		$(".tab_content").not(tab).css("display", "none");
		$(tab).fadeIn();
	});
}

/* 
	20220519 추가 구연호
	공통 액셀 업로드 jsp 호출 
*/
function modal_cmmn_excel(){
	fncAjax('/cmmn/excelAjax.do', $('#defaultFrm').serialize(), 'html', true, '', function(data){
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
	
	divHtml += `<div id="display_view_`+createNum+`" class="layer_popup js-popup" style="width: `+width+`; height: `+height+`; z-index: `+ (Number(5000)+ Number(createNum))+`;"></div>`;
	
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

/*
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
*/


$(document).ready(function(){
    $(".js-tab-content01").hide();
    $(".js-tab-content01:first").show();
    $(".js-tab01 a").click(function (event) {
        event.preventDefault(); //주소에 #숨김
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".js-tab-content01").not(tab).css("display", "none");
        $(tab).fadeIn();
    });
	// 빈 A 채우기 ES.KIM
	$('a').each(function() {
		if (!$(this).attr('href')) {
			$(this).attr('href',"javascript:void(0);");
		}
	});

	// File upload
	$('.file__input--file').on('change',function(event){
		var files = event.target.files;
		for (var i = 0; i < files.length; i++) {
			var file = files[i];
			$("<div class='file__value'><div class='file__value--text'>" + file.name + "</div><div class='file__value--remove' data-id='" + file.name + "' ></div></div>").insertAfter('#file__input');
		}
	});

	//Click to remove item
	$('body').on('click', '.file__value', function() {
		$(this).remove();
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
function fncCodeList(cdUppoVal, codeType, defVal, selVal, name, tagId, idKey, sort, title, required){
    $.ajax({
        url      : "/cmmn/getCode.do",
        type     : "post",
        data     : {
            cdUppoVal : cdUppoVal,
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


function selectBatch2Depth(selector, actWork){
    let data = {actWork : actWork};
    fncAjax("/cmmn/selectBatch2Depth.json", data, "json", false, selector, function(data){
        let resultList = data.resultList;
        let optionStr = '<option value="">선택</option>';
        for(let i = 0; i < resultList.length; i++){
            optionStr += '<option value="' + resultList[i].svcId + '">' + resultList[i].svcNm + '[' + resultList[i].svcId + ']' + '</option>';
        }
        $(selector).html(optionStr);
    })
}

/* 일정관리 */
function fncDateTab(){
	$('.js-tab-date tr td a').click(function (event) {
		event.preventDefault(); //주소에 #숨김
		$('.js-tab-date tr td a.today_list_opt01').removeClass('today_list_opt01');
		$(this).addClass('today_list_opt01');
		var tab = $(this).attr('href');
		$('.tab_date_list').not(tab).css('display', 'none');
		$(tab).fadeIn();
	});
}

/* 정확한 소수점 반올림 */
function fncMathRound(num, scale) {
	if(!scale){scale = "0";}
    return +(Math.round(num+"e+"+scale)+"e-"+scale);
}