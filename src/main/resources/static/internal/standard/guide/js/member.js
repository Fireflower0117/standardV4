/**** 멤버십 요소 js ****/

// 로그인 - login input clear
$(document).ready(function () {
	$('.login_box .input_box input').focusout(function () {
		$(".login_box .input_box .btn_del").removeClass("on");
	});
	$(".login_box .input_box .btn_del").click(function () {
		$(this).prev('input').val('');
		$(this).removeClass("on");
		return false;
	});
	$('.login_box .input_box input').on('focus keyup', function (e) {
		e.preventDefault();
		if ($(this).val().length) {
			$(this).next(".btn_del").addClass("on");
		} else {
			$(this).next(".btn_del").removeClass("on");
		}
	});
});

// 약관동의
$(document).ready(function () {
	// 더보기2
	$(".join.agreement .btn_more2").click(function () {
		if ($(this).hasClass("on")) {
			$(this).removeClass("on");
			$(this).next(".cont").slideUp(100);
		} else {
			$(this).addClass("on");
			$(this).next(".cont").slideDown(100);
		}
		return false;
	});
	
	// 체크박스
	$('.join.agreement .chkall input').on('click', function () {
		var checked = $(this).is(':checked');
		if (checked) {
			$('.chklist').find('input').prop('checked', true);
			$(".join.agreement .btn_join").removeClass("gray").removeClass("light").addClass("blue");
		} else {
			$('.chklist').find('input').prop('checked', false);
			$(".join.agreement .btn_join").removeClass("blue").addClass("light").addClass("gray");
		}
	});
	$('.join.agreement .chklist input').on('click', function () {
		var chkGroup = $('.chklist').length;
		var checked_cnt = $('.chklist input:checked').length;
		if (checked_cnt < chkGroup) {
			$('.chkall input').prop('checked', false);
			$(".join.agreement .btn_join").removeClass("blue").addClass("light").addClass("gray");
		} else if (checked_cnt == chkGroup) {
			$('.chkall input').prop('checked', true);
			$(".join.agreement .btn_join").removeClass("gray").removeClass("light").addClass("blue");
		}
	});
});