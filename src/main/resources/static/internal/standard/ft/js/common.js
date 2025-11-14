// header
$(document).ready(function () {
    var hGnb = [];
    var hHeader = $('#header .gnb > li').innerHeight();
    $('#header .dp2').each(function () {
        hGnb.push($(this).innerHeight());
    });
    hGnb = Math.max.apply(null, hGnb);
    $('#header .gnb_bg').css({ 'top': $('#header').innerHeight(), 'height': hGnb });
    $('#header .dp2').css('height', hGnb);
    
    $('#header .gnb > li, #header .gnb_bg').on({
        'mouseenter focusin': function () {
            $(this).addClass('on');
            $('#header .gnb_bg').stop().slideDown(350);
            $('#header .gnb_area').stop().animate({ height: hHeader + hGnb }, 350);
        },
        'mouseleave focusout': function () {
            $(this).removeClass('on');
            $('#header .gnb_bg').stop().slideUp(350);
            $('#header .gnb_area').stop().animate({ height: hHeader }, 350);
        }
    });
    
    
    // lnb
	$(document).ready(function () {
	    $("#lnb li.on").children("ul").show();
	    $("#lnb li.has_sub > a").click(function () {
	        if ($(this).parent().hasClass("on")) {
	            $(this).parent().removeClass("on");
	            $("#lnb li ul").stop().slideUp(200);
	        } else {
	            $("#lnb > ul > li").removeClass("on");
	            $("#lnb li ul").stop().slideUp(200);
	            $(this).parent().addClass("on");
	            $(this).next("ul").stop().slideDown(200);
	        }
	        return false;
	    });
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

// footer family_list
$(document).ready(function () {
	$('.footBtn .btn_site').click(function () {
		$(this).toggleClass('on');
		$('.family_list_box').slideToggle();
	});
	$('.family_list_box ul a').click(function () {
		$('.footBtn .btn_site').removeClass('on');
		$('.family_list_box').slideUp();
	});
	$('html').click(function (e) {
		if (!$(e.target).parents().hasClass('footBtn')) {
			$('.footBtn .btn_site').removeClass('on');
			$('.family_list_box').slideUp();
		}
	});
});

