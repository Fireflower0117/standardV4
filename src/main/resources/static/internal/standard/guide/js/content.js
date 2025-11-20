/**** ui요소 js ****/

// breadcrumb
$(document).ready(function () {
	var locTop = $('#js_fixLoc').offset().top;
	$(document).scroll(function () {
		if (locTop < $(document).scrollTop()) {
			$('#js_fixLoc').css({ 'position': 'fixed', 'top': '0', 'bottom': 'auto' });
		} else {
			$('#js_fixLoc').css({ 'position': 'absolute', 'top': 'auto', 'bottom': '0' });
		}
	});
});

// visual slider typeA
$(document).ready(function () {
	var interleaveOffset = 0.5;
	var visualslider = new Swiper('.visual_slider.typeA .swiper-container', {
		slidesPerView: 1,
		initialSlide: 0,
		loop: true,
		speed: 1000,
		grabCursor: true,
		watchSlidesProgress: true,
		mousewheelControl: true,
		keyboardControl: true,
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.btn_visual_next',
			prevEl: '.btn_visual_prev'
		},
		pagination: {
			el: ".pagination_fraction",
			type: 'fraction'
		},
		on: {
			init: function () {
				let idx = this.realIndex + 1;
				$('.visual_slider.typeA .swiper-slide').eq(idx).addClass('active first');
			},
		},
		observer: true,
		observeParents: true
	});
	visualslider.on('slideChange', function () {
		let idx = visualslider.activeIndex;
		$('.visual_slider.typeA .swiper-slide').removeClass('active first');
		if (!$('.visual_slider.typeA .btn_play_control').hasClass('play')) {
			$('.visual_slider.typeA .btn_play_control').removeClass('play active');
		}
		$('.visual_slider.typeA .swiper-slide').eq(idx).addClass('active');
		setTimeout(function () {
			if (!$('.visual_slider.typeA .btn_play_control').hasClass('play')) {
				$('.visual_slider.typeA .btn_play_control').addClass('active');
			}
		}, 100);
	});
	$('.visual_slider.typeA .btn_play_control').click(function () {
		if ($(this).hasClass('active')) {
			visualslider.autoplay.stop();
			$(this).removeClass('active').addClass('play');
		} else {
			visualslider.autoplay.start();
			$(this).addClass('active').removeClass('play');
		}
	});
});

// visual slider typeB
$(document).ready(function () {
	var visualslider2 = new Swiper('.visual_slider.typeB .swiper-container', {
		slidesPerView: 1,
		initialSlide: 0,
		loop: true,
		speed: 1000,
		grabCursor: true,
		watchSlidesProgress: true,
		mousewheelControl: true,
		keyboardControl: true,
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.btn_visual_next2',
			prevEl: '.btn_visual_prev2'
		},
		pagination: {
			el: ".pagination",
			clickable: true
		},
		on: {
			init: function () {
				let idx = this.realIndex + 1;
				$('.visual_slider.typeB .swiper-slide').eq(idx).addClass('active first');
			},
		},
		observer: true,
		observeParents: true
	});
	visualslider2.on('slideChange', function () {
		let idx = visualslider2.activeIndex;
		$('.visual_slider.typeB .swiper-slide').removeClass('active first');
		$('.visual_slider.typeB .swiper-slide').eq(idx).addClass('active');
	});
});

// banner slider
$(document).ready(function () {
	var bnslider = new Swiper('.banner_slider .swiper-container', {
		slidesPerView: 1,
		loop: true,
		speed: 500,
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.btn_banner_next',
			prevEl: '.btn_banner_prev'
		},
		pagination: {
			el: ".pagination_fraction2",
			type: 'fraction'
		},
		observer: true,
		observeParents: true
	});
	$('.banner_slider .btn_play_control2').click(function () {
		if ($(this).hasClass('active')) {
			bnslider.autoplay.stop();
			$(this).removeClass('active').addClass('play');
		} else {
			bnslider.autoplay.start();
			$(this).addClass('active').removeClass('play');
		}
	});
});

// recent slider
$(document).ready(function () {
	function slider() {
		var swiperArr = [];
		var slideInx = [];
		var slideNum = [];
		$(".recent_slider").each(function (index) {
			var $this = $(this);
			$this.addClass("slider-" + index);
			swiperArr.push(undefined);
			slideInx.push(0);
			slideNum.push($this.find('.swiper-slide').length);
		});
		function sliderAct() {
			$(".recent_slider").each(function (index) {
				if (swiperArr[index] != undefined) {
					swiperArr[index].destroy();
					swiperArr[index] = undefined;
				}
				swiperArr[index] = new Swiper('.slider-' + index + ' .swiper-container', {
					slidesPerView: 'auto',
					loop: true,
					speed: 500,
					observer: true,
					observeParents: true,
					navigation: {
						nextEl: $('.slider-' + index).find('.btn_recent_next'),
						prevEl: $('.slider-' + index).find('.btn_recent_prev')
					},
					on: {
						activeIndexChange: function () {
							if ($('.slider-' + index).parent('.tab_cont').css('display') != 'none') {
								slideInx[index] = this.realIndex;
							}
						}
					},
				});
				if (swiperArr[index] == undefined) {
					swiperArr[index] = swiper;
				}
			});
		}
		sliderAct();
	}
	slider();
});


/** header **/
// header type01 - slide all
$(document).ready(function () {
	var hGnb01 = [];
	var hHeader01 = $('#header01 .gnb > li').innerHeight();
	$('#header01 .dp2').each(function () {
		hGnb01.push($(this).innerHeight());
	});
	hGnb01 = Math.max.apply(null, hGnb01);
	$('#header01 .gnb_bg').css({ 'top': $('#header01').innerHeight(), 'height': hGnb01 });
	$('#header01 .dp2').css('height', hGnb01);
	
	$('#header01 .gnb > li, #header01 .gnb_bg').on({
		'mouseenter focusin': function () {
			$(this).addClass('on');
			$('#header01 .gnb_bg').stop().slideDown(350);
			$('#header01 .gnb_area').stop().animate({ height: hHeader01 + hGnb01 }, 350);
		},
		'mouseleave focusout': function () {
			$(this).removeClass('on');
			$('#header01 .gnb_bg').stop().slideUp(350);
			$('#header01 .gnb_area').stop().animate({ height: hHeader01 }, 350);
		}
	});
});

// header type02 - slide all + change txt
$(document).ready(function () {
	var wGnb02 = parseInt($('#header02 .gnb_area .logo').css('width'));
	var hGnb02 = [];
	var hHeader02 = $('#header02 .gnb > li').innerHeight();
	$('#header02 .gnb > li').each(function () {
		hGnb02.push($(this).children('.gnb_txt').innerHeight());
		hGnb02.push($(this).children('.dp2').innerHeight());
	});
	hGnb02 = Math.max.apply(null, hGnb02);
	$('#header02 .gnb_bg').css({ 'top': $('#header02').innerHeight(), 'height': hGnb02 });
	$('#header02 .dp2').css('height', hGnb02);
	$('#header02 .gnb_txt').css({ 'left': -wGnb02, 'width': wGnb02, 'height': hGnb02 });
	
	$('#header02 .gnb > li').on({
		'mouseenter focusin': function () {
			$(this).addClass('on');
			$('#header02 .gnb_bg').stop().slideDown(350);
			$('#header02 .gnb_area').stop().animate({ height: hHeader02 + hGnb02 }, 350);
		},
		'mouseleave focusout': function () {
			$(this).removeClass('on');
			$('#header02 .gnb_bg').stop().slideUp(350);
			$('#header02 .gnb_area').stop().animate({ height: hHeader02 }, 350);
		}
	});
});

// header type03 - slide
$(document).ready(function () {
	$('#header03 .gnb > li:first-child').addClass('this');
	$('#header03 .gnb > li').on({
		'mouseenter focusin': function () {
			$(this).addClass('on');
			if (!$(this).hasClass('this')) {
				$('#header03 .gnb > li.this').removeClass('this');
			}
		},
		'mouseleave focusout': function () {
			$(this).removeClass('on');
			$('#header03 .gnb > li:first-child').addClass('this');
		}
	});
});

// header type04 - slide each
$(document).ready(function () {
	var hHeader04 = $('#header04 .hd_top').outerHeight() + $('#header04 .gnb > li').innerHeight();
	$('#header04 .gnb > li').on({
		'mouseenter focusin': function () {
			var hGnb04 = hHeader04 + $(this).children('.gnb_bg').innerHeight();
			$(this).addClass('on').children('.gnb_bg').show();
			$('#header04').stop().animate({ height: hGnb04 }, 350);
			$('#header04 .gnb > li').not(this).children('.gnb_bg').hide();
		},
		'mouseleave focusout': function () {
			$(this).removeClass('on');
			$('#header04').stop().animate({ height: hHeader04 }, 350);
		}
	});
});

// header type05 - slide each responsive
$(document).ready(function () {
	if ($(window).width() > 1023) {
		pheader05();
	} else {
		mheader05();
	}
});
function pheader05() {
	var hHeader05 = $('#header05:not(.mo) .hd_top').outerHeight() + $('#header05:not(.mo) .gnb > li').innerHeight();
	$('#header05:not(.mo) .gnb > li').on({
		'mouseenter focusin': function () {
			var hGnb05 = hHeader05 + $(this).children('.gnb_bg').innerHeight();
			$(this).addClass('on').children('.gnb_bg').show();
			$('#header05:not(.mo)').stop().animate({ height: hGnb05 }, 350);
			$('#header05:not(.mo) .gnb > li').not(this).children('.gnb_bg').hide();
		},
		'mouseleave focusout': function () {
			$(this).removeClass('on');
			$('#header05:not(.mo)').stop().animate({ height: hHeader05 }, 350);
		}
	});

	// only guide
	$('#header05.mo .gnb_open').click(function () {
		$('#header05.mo').addClass('open');
	});
	$('#header05.mo .gnb_close').click(function () {
		$('#header05.mo').removeClass('open');
	});
	$('#header05.mo .dp2 > li').each(function () {
		if ($(this).children('.dp3').length > 0) {
			$(this).addClass('has_dp3');
		}
	});
	$('#header05.mo .gnb > li:first-child').addClass('on');
	$('#header05.mo .gnb > li').click(function () {
		$(this).addClass('on').siblings().removeClass('on');
	});
	$('#header05.mo .dp2 > li.has_dp3 > a').click(function () {
		$(this).parent().toggleClass('open').siblings().removeClass('open');
		$('#header05.mo .dp3').stop().slideUp(300);
		$(this).siblings('.dp3').stop().slideToggle(300);
	});
}
function mheader05() {
	$('#header05 .gnb_open').click(function () {
		$('#header05').addClass('open');
	});
	$('#header05 .gnb_close').click(function () {
		$('#header05').removeClass('open');
	});

	$('#header05 .dp2 > li').each(function () {
		if ($(this).children('.dp3').length > 0) {
			$(this).addClass('has_dp3');
		}
	});
	$('#header05 .gnb > li:first-child').addClass('on');
	$('#header05 .gnb > li').click(function () {
		$(this).addClass('on').siblings().removeClass('on');
	});
	$('#header05 .dp2 > li.has_dp3 > a').click(function () {
		$(this).parent().toggleClass('open').siblings().removeClass('open');
		$('#header05 .dp3').stop().slideUp(300);
		$(this).siblings('.dp3').stop().slideToggle(300);
	});
}

// header type06 - slide each
$(document).ready(function () {
	$('#header06 .gnb > li').on({
		'mouseenter focusin': function () {
			$(this).addClass('on');
			$(this).children('#header06 .dp2').stop().slideDown(200);
		},
		'mouseleave focusout': function () {
			$(this).removeClass('on');
			$(this).children('#header06 .dp2').stop().slideUp(200);
		}
	});
});
/** // header **/


// gnb left 고정
$(document).ready(function () {
	if ($("#gnb.leftfix").hasClass("main_type")) {
		$(".js_subwrap").hide();
	}
	$(".gnb > li").on("mouseenter", function () {
		if ($(this).hasClass("visible")) {
			$(this).addClass("on").children(".subwrap").addClass("on");
			$(".subwrap").removeClass("on");
		} else {
			$(this).addClass("on").children(".subwrap").addClass("on");
			$(".subwrap").removeClass("on");
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

// breadcrumb 반응형
$(document).ready(function () {
	function selectbox() {
		$(".breadcrumb.pc .selbox").each(function () {
			var $this = $(this);
			var firstVal = $this.find(".option.on").text();
			$this.find(".selected").text(firstVal);
			$this.find(".selected").click(function () {
				$(".selectoptions").slideUp(100);
				$(".selbox").removeClass("on");
				if (!$this.find(".selectoptions").is(":visible")) {
					$(this).parent().addClass("on");
					$this.find(".selectoptions").slideDown(100);
				} else {
					$(this).parent().removeClass("on");
					$this.find(".selectoptions").slideUp(100);
				}
				return false;
			});
		});
	}
	var vwidth = $(window).width();
	if (vwidth > 1023) {
		selectbox();
	}
});