// cmnt
$(document).ready(function () {
    $('.js_reReply').click(function () {
        if ($(this).hasClass("on")) {
            $(this).removeClass("on");
            $(this).parents('.reply_box').siblings('.re_reply').hide();
        } else {
            $(this).addClass("on");
            $(this).parents('.reply_box').siblings('.re_reply').show();
        }
        return false;
    });
});

// accordion (ex faq)
$(document).ready(function () {
    $('.js_accCont').hide();
    if ($('[class*="js_accWrap"]').length) {
        $('.js_accHead').click(function () {
            // if each
            if ($(this).parents('[class*="js_accWrap"]').hasClass('js_accWrap_each')) {
                $(this).parents('.js_accBox').siblings('.js_accBox').removeClass('open');
                $(this).parents('.js_accBox').siblings('.js_accBox').find('.js_accCont').stop().slideUp(200);
            }

            // open
            if ($(this).parents('.js_accBox').hasClass('open')) {
                $(this).parents('.js_accBox').removeClass('open').find('.js_accCont').stop().slideUp(200);
            } else {
                $(this).parents('.js_accBox').addClass('open').find('.js_accCont').stop().slideDown(200);
            }
            return false;
        });
    }
});

// datepicker
var fncDate = function () {
    var setDate = arguments;
    var getId;
    var fmt = "yy.mm.dd";
    switch (setDate.length) {
        case 1:
            getId = "#" + setDate[0]; break;
        case 2:
            if (setDate[1] != '') { getId = "#" + setDate[0] + ", #" + setDate[1]; break; }
            else { getId = "#" + setDate[0]; break; }
        case 3:
            if (setDate[1] != '') { getId = "#" + setDate[0] + ", #" + setDate[1]; fmt = setDate[2]; break; }
            else { getId = "#" + setDate[0]; fmt = setDate[2]; break; }
    }

    var dates = $(getId).datepicker({
        changeMonth: true,
        changeYear: true,
        showOn: "button",
        buttonImage: "images/icon/i_cal.svg",
        buttonImageOnly: true,
        dateFormat: fmt,
        onSelect: function (selectedDate) {
            var option = this.id == setDate[0] ? "minDate" : "maxDate",
                instance = $(this).data("datepicker"),
                date = (fmt == 'yy.mm' ? new Date(instance.selectedYear, instance.selectedMonth, 1) : $.datepicker.parseDate($.datepicker._defaults.dateFormat, selectedDate, instance.settings))
            dates.not(this).datepicker("option", option, date);
            $(this).trigger("change");
        }
    });
}

// tab
$(document).ready(function () {
    if ($('.js_tmenu').length || $('.js_tcont').length) {
        $('.js_tcont').stop().hide();
        $('.js_tcont.on').stop().show();
        $('.js_tmenu li a').click(function () {
            let tabId = $(this).parent().attr('id');
            let selTabId = $('.js_tmenu li[id="' + tabId + '"], .js_tcont[data-tab="' + tabId + '"]');
            $(this).closest('.tab').find('.js_tmenu li, .js_tcont').not('.js_tmenu li.on').removeClass('on');
            selTabId.addClass('on').fadeIn();
            selTabId.siblings('.js_tcont').stop().hide();
            selTabId.siblings().removeClass('on');
            return false;
        });
    }
});


/** popup **/
// popup - layer
function view_show(popName) {
    let top = ($(window).height() - $("#display_view" + popName).height()) / 2;
    $("#js_popup_bg").show();
    $("#display_view" + popName).addClass("on").css({ 'visibility': 'visible', 'position': 'fixed', 'top': top, 'z-index': 5500 });
    return false;
}
function view_hide(popName) {
    $("#display_view" + popName).removeClass("on").css('visibility', 'hidden');
    $("#js_popup_bg").hide();
    return false;
}
$(function () {
    $('#js_popup_bg').click(function () {
        $('.js_popup').removeClass("on").css('visibility', 'hidden');
        $(this).hide();
    });
});

// popup - main
$(document).ready(function () {
    $(".main_pop .close").click(function () {
        $(this).closest(".main_pop").hide();
        return false;
    });
});
/** // popup **/


// startsWith func
String.prototype.startsWith = function (str) {
    if (this.length < str.length) return false;
    return this.indexOf(str) == 0;
}
// endsWith func
String.prototype.endsWith = function (str) {
    if (this.length < str.length) return false;
    return this.lastIndexOf(str) + str.length == this.length;
}
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