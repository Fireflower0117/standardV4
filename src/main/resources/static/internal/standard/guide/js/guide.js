// uiGStrucTbl link click event
window.onload = function () {
    var tempUrl = decodeURI($(location).attr('origin')) + decodeURI($(location).attr('pathname'));
    var thisUrl = decodeURI($(location).attr('search')).split('&');
    if (thisUrl != '') {
        var urlSlice1 = thisUrl[0].replace('?tab=', '');
        var urlSlice2 = thisUrl[1].replace('tit=', '');
        var urlTab = '';
        var scrtop = 0;
        if ($('.common_tab').length) {
            $('.common_tab').each(function () {
                $(this).children('li').each(function () {
                    if ($(this).text() == urlSlice1) {
                        urlTab = $('.common_tab_content[data-tab="' + $(this).attr('id') + '"]');
                        // tab show/hide
                        if(!$(this).hasClass('on')) {
                            $(this).addClass('on').siblings().removeClass('on');
                            urlTab.addClass('on').show().siblings('.common_tab_content').removeClass('on').hide();
                        }
                        // find title top position
                        scrtop = urlTab.find('.section_main_ttl:contains(' + urlSlice2 + ')').offset().top;
                    }
                });
            });
        }
        // page scroll & url reset
        $(document).scrollTop(scrtop);
        history.pushState(null, null, tempUrl);
        scrtop = 0;
    }
}

/* 기본 script (탭, 간격 등) */
// include html
function includehtml() {
	var allElements = $(".include_wrap");
	Array.prototype.forEach.call(allElements, function (el) {
		var includePath = el.dataset.includePath;
		console.log(includePath);
		if (includePath) {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function () {
				if (this.readyState == 4 && this.status == 200) {
					el.outerHTML = this.responseText;
				}
			};
			xhttp.open('GET', includePath, false);
			xhttp.send();
		}
	});
}
$(document).ready(function () {
	includehtml();
});

// a javascript:void(0);
$(document).ready(function () {
	$('a').each(function () {
		if (!$(this).attr('href')) {
			$(this).attr('href', "javascript:void(0);");
		}
	});
});

// guide 코드 열고 닫기
$(document).ready(function () {
	$(".btn_code_open").click(function () {
		var code = $(this).parent().next("div");
		if (code.is(":visible")) {
			$(this).removeClass("on");
			code.hide();
		} else {
			$(this).addClass("on");
			code.show();
		}
	});
});

// 코드 전체 열고 닫기
$(document).ready(function () {
	$(".btn_code_all_open").click(function () {
		$(".btn_code_open").addClass("on");
		$(".ui_code").show();
	});
	$(".btn_code_all_close").click(function () {
		$(".btn_code_open").removeClass("on");
		$(".ui_code").hide();
	});
});

// 메뉴 위치에 따라 on 효과
$(document).ready(function () {
	var path = window.location.pathname;
	var page = path.split("/").pop();
	console.log(page);
    if (page == 'index.html') {
        $('body > header > nav > ul > li:first-child').addClass("on");
    }
	$("body > header > nav > ul ul li a").each(function () {
		if ($(this).attr("href") == page) {
			$(this).parent().addClass("on");
			$(this).parents('li').addClass("on");
		}
	});
});

// tab
$(document).ready(function () {
	if ($('.js_tmenu').length || $('.js_tcont').length) {
		$('.js_tcont').hide();
		$('.js_tcont.on').show();
		$('.js_tmenu li').click(function () {
			let tabId = $(this).attr('id');
			let selTabId = $('.js_tmenu li[id="' + tabId + '"], .js_tcont[data-tab="' + tabId + '"]');
			$(this).closest('.tab').find('.js_tmenu li, .js_tcont').not('.js_tmenu li.on').removeClass('on');
			selTabId.addClass('on').fadeIn();
			selTabId.siblings('.js_tcont').hide();
			selTabId.siblings().removeClass('on');
		});
	}
});

// btn_sample_counting
$(document).ready(function () {
	$(".btn_sample_counting").click(function () {
		$('.timer').each(count);
		function count(options) {
			var $this = $(this);
			options = $.extend({}, options || {}, $this.data('countToOptions') || {});
			$this.countTo(options);
		}
	});
});

// nav 메뉴 위치에 따라 nav scrolltop 변경
// $(function () {
// 	var winheight = $(window).height();
// 	var navtop = $("body > header > nav > ul ul li.on").offset().top;
// 	console.log((winheight - (winheight - navtop)));
// 	$("body > header > nav").scrollTop((winheight - (winheight - navtop)) / 2 + 10);
// });

// space (margin, padding, width, height, font-size)
$(document).ready(function () {
    let _pat = /[a-zA-Z]/;

    let mar_ = $("[class*='mar_']");
    if (mar_.length) {
        $('body').find(mar_).each(function () {
            let _this = $(this);
            let _mar = _this.attr('class').split(' ');
            for (var i = 0; i < _mar.length; i++) {
                if (_mar[i].startsWith('mar_') == true || _mar[i].startsWith('mar_') && (_mar[i].endsWith('p') || _mar[i].endsWith('rem'))) {
                    let position = '';
                    let arr = _mar[i].split('');
                    let sliceArr = _mar[i].slice(5);
                    let num = sliceArr.replace(/[^0-9,_]/g, '');
                    let underbar = sliceArr.replace(/[^_]/g, '');
                    if ((arr[4] == 't' || arr[4] == 'r' || arr[4] == 'b' || arr[4] == 'l') && _pat.test(_mar[i].substr(5, 1)) == false) {
                        if (underbar) num = sliceArr.replace('_', '.');
                        num = num.replace(/[^0-9,.]/g, '');
                        position = arr[4] === 't' ? 'margin-top' : arr[4] === 'r' ? 'margin-right' : arr[4] === 'b' ? 'margin-bottom' : arr[4] === 'l' ? 'margin-left' : '';
                        let unit = _mar[i].startsWith('mar') === true && _mar[i].endsWith('p') ? '%' : _mar[i].startsWith('mar') === true && _mar[i].endsWith('rem') ? 'rem' : 'px';
                        _this.css(position, num + unit);
                    }
                }
            }
        });
    }

    let pad_ = $("[class*='pad_']");
    if (pad_.length) {
        $('body').find(pad_).each(function () {
            let _this = $(this);
            let _pad = _this.attr('class').split(' ');
            for (var i = 0; i < _pad.length; i++) {
                if (_pad[i].startsWith('pad_') == true || _pad[i].startsWith('pad_') && (_pad[i].endsWith('p') || _pad[i].endsWith('rem'))) {
                    let position = '';
                    let arr = _pad[i].split('');
                    let sliceArr = _pad[i].slice(5);
                    let num = sliceArr.replace(/[^0-9,_]/g, '');
                    let underbar = sliceArr.replace(/[^_]/g, '');
                    if ((arr[4] == 't' || arr[4] == 'r' || arr[4] == 'b' || arr[4] == 'l') && _pat.test(_pad[i].substr(5, 1)) == false) {
                        if (underbar) num = sliceArr.replace('_', '.');
                        num = num.replace(/[^0-9,.]/g, '');
                        position = arr[4] === 't' ? 'padding-top' : arr[4] === 'r' ? 'padding-right' : arr[4] === 'b' ? 'padding-bottom' : arr[4] === 'l' ? 'padding-left' : '';
                        let unit = _pad[i].startsWith('pad') === true && _pad[i].endsWith('p') ? '%' : _pad[i].startsWith('pad') === true && _pad[i].endsWith('rem') ? 'rem' : 'px';
                        _this.css(position, num + unit);
                    }
                }
            }
        });
    }

    let w = $("[class*='w']");
    if (w.length) {
        $('body').find(w).each(function () {
            let _this = $(this);
            let _w = _this.attr('class').split(' ');
            for (var i = 0; i < _w.length; i++) {
                if ((_w[i].startsWith('w') == true || _w[i].startsWith('w') && (_w[i].endsWith('p') || _w[i].endsWith('rem'))) && _pat.test(_w[i].substr(1, 1)) == false) {
                    let num = _w[i].replace(/[^0-9,_]/g, '');
                    let underbar = _w[i].replace(/[^_]/g, '');
                    if (underbar) num = num.replace('_', '.');
                    let unit = _w[i].startsWith('w') === true && _w[i].endsWith('p') ? '%' : _w[i].startsWith('w') === true && _w[i].endsWith('rem') ? 'rem' : 'px';
                    _this.css('width', num + unit);
                }
            }
        });
    }

    let ht = $("[class*='ht']");
    if (ht.length) {
        $('body').find(ht).each(function () {
            let _this = $(this);
            let _ht = _this.attr('class').split(' ');
            for (var i = 0; i < _ht.length; i++) {
                if ((_ht[i].startsWith('ht') == true || _ht[i].startsWith('ht') && (_ht[i].endsWith('p') || _ht[i].endsWith('rem'))) && _pat.test(_ht[i].substr(2, 1)) == false) {
                    let num = _ht[i].replace(/[^0-9,_]/g, '');
                    let underbar = _ht[i].replace(/[^_]/g, '');
                    if (underbar) num = num.replace('_', '.');
                    let unit = _ht[i].startsWith('ht') === true && _ht[i].endsWith('p') ? '%' : _ht[i].startsWith('ht') === true && _ht[i].endsWith('rem') ? 'rem' : 'px';
                    _this.css('height', num + unit);
                }
            }
        });
    }

    let fs = $("[class*='fs']");
    if (fs.length) {
        $('body').find(fs).each(function () {
            let _this = $(this);
            let _fs = _this.attr('class').split(' ');
            for (var i = 0; i < _fs.length; i++) {
                if ((_fs[i].startsWith('fs') == true || _fs[i].startsWith('fs') && (_fs[i].endsWith('p') || _fs[i].endsWith('rem'))) && _pat.test(_fs[i].substr(2, 1)) == false) {
                    let num = _fs[i].replace(/[^0-9,_]/g, '');
                    let underbar = _fs[i].replace(/[^_]/g, '');
                    if (underbar) num = num.replace('_', '.');
                    let unit = _fs[i].startsWith('fs') === true && _fs[i].endsWith('p') ? '%' : _fs[i].startsWith('fs') === true && _fs[i].endsWith('rem') ? 'rem' : 'px';
                    _this.css('font-size', num + unit);
                }
            }
        });
    }
});