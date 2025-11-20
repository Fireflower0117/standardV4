// uiGuide structure table
$(document).ready(function () {
    var uiGCnt = 1;
    var uiGStrucHtml = '';
    var uiGDp1UrlCnt = 0, uiGTtlTempCnt = 0;
    var uiGStrucTbl = [], uiGDp1Url = [], uiGType = [], uiGDp1 = [], uiGDp2 = [], uiGTtl = [], uiGTtlTemp = [];

    // page url
    $('body > header > nav > ul > li').each(function () {
        if ($(this).children('ul').length) {
            $(this).children('ul').each(function () {
                $(this).children('li').each(function () {
                    // uiGType
                    uiGType.push($(this).parent('ul').siblings('a').text());
                    // uiGDp1Url
                    uiGDp1Url.push($(this).find('a').attr('href'));
                });
            });
            uiGDp1UrlCnt = uiGDp1Url.length;
        } else {
            // uiGType
            uiGType.push($(this).children('a').text());
            // uiGDp1Url
            uiGDp1Url.push($(this).children('a').attr('href'));
        }
    });

    // set ajax url
    for (var sau = 0; sau < uiGDp1UrlCnt; sau++) {
        fncUiGStruc(uiGDp1Url[sau]);
        // data push
        uiGStrucTbl.push({
            uiGType: uiGType[sau],
            uiGDp1: uiGDp1,
            uiGDp2: uiGDp2,
            uiGTtl: uiGTtl
        });
    }

    // fnc ajax
    function fncUiGStruc(url) {
        $.ajax({
            type: "GET",
            url: url,
            dataType: "html",
            async: false,
            success: function (result) {
                // uiGDp1
                uiGDp1 = [];
                $(result).find('.guide_tit').each(function () {
                    uiGDp1.push($(this).text());
                });

                // uiGDp2
                uiGDp2 = [];
                if ($(result).find('.common_tab').length) {
                    $(result).find('.common_tab').each(function () {
                        $(this).children('li').each(function () {
                            uiGDp2.push($(this).text());
                        });
                    });
                } else {
                    uiGDp2.push(['']);
                }

                // uiGTtl
                uiGTtl = [];
                if ($(result).find('.common_tab_content').length) {
                    $(result).find('.common_tab_content').each(function () {
                        uiGTtlTemp = [];
                        if ($(this).find('.section_main_ttl').length) {
                            $(this).find('.section_main_ttl').each(function () {
                                uiGTtlTemp.push($(this).text());
                            });
                            uiGTtl.push(uiGTtlTemp);
                        } else {
                            uiGTtl.push(['']);
                        }
                    });
                } else {
                    uiGTtlTemp = [];
                    if ($(result).find('.section_main_ttl').length) {
                        $(result).find('.section_main_ttl').each(function () {
                            uiGTtlTemp.push($(this).text());
                        });
                        uiGTtl.push(uiGTtlTemp);
                    } else {
                        uiGTtl.push(['']);
                    }
                }
                uiGTtlTempCnt++;
            }
        });
        return { uiGDp1: uiGDp1, uiGDp2: uiGDp2, uiGTtl: uiGTtl };
    }

    // add html
    for (i in uiGStrucTbl) {
        var uiGTtlNum = 0;
        for (j in uiGStrucTbl[i].uiGTtl) {
            uiGTtlNum += uiGStrucTbl[i].uiGTtl[j].length;
            for (var k = 0; k < uiGTtlNum; k++) {
                uiGStrucHtml += '<tr>';
                uiGStrucHtml += '<td>' + uiGCnt++ + '</td>';
                uiGStrucHtml += '<td>' + uiGStrucTbl[i].uiGType + '</td>';
                uiGStrucHtml += '<td>' + uiGStrucTbl[i].uiGDp1 + '</td>';
                uiGStrucHtml += '<td>' + uiGStrucTbl[i].uiGDp2[j] + '</td>';
                if (uiGStrucTbl[i].uiGTtl[j][k]) {
                    var testurl = uiGDp1Url[i] + '?tab=' + uiGStrucTbl[i].uiGDp2[j] + '&tit=' + uiGStrucTbl[i].uiGTtl[j][k];
                    uiGStrucHtml += '<td><a href="' + testurl + '">' + uiGStrucTbl[i].uiGTtl[j][k] + '</a></td>';
                } else {
                    uiGStrucHtml += '<td>' + uiGStrucTbl[i].uiGTtl[j][k] + '</td>';
                }
                uiGStrucHtml += '</tr>';
            }
            uiGTtlNum = 0;
        }
    }
    $('#uiGStrucTbl > tbody').empty().append(uiGStrucHtml);

    // rowspan
    $.fn.mergeClassRowspan = function (colIdx) {
        return this.each(function () {
            var that;
            $('tr', this).each(function (row) {
                $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
                    if (($(this).text() == $(that).text()) && ($(this).text() != '' || $(that).text() != '')) {
                        rowspan = Number($(that).attr("rowspan") || 1) + 1;
                        $(that).attr("rowspan", rowspan);
                        $(this).hide();
                    } else {
                        that = this;
                    }
                    that = (that == null) ? this : that;
                });
            });
        });
    };
    if (!$('#uiGStrucTbl').parent('.common_tab_content').hasClass('on')) {
        $('#uiGStrucTbl').parent('.common_tab_content').show();
    }
    $('#uiGStrucTbl').mergeClassRowspan(1);
    $('#uiGStrucTbl').mergeClassRowspan(2);
    $('#uiGStrucTbl').mergeClassRowspan(3);
    if (!$('#uiGStrucTbl').parent('.common_tab_content').hasClass('on')) {
        $('#uiGStrucTbl').parent('.common_tab_content').hide();
    }
});

// uiGuide edit & sample list table
$(document).ready(function () {
    var sheetUrl = 'https://docs.google.com/spreadsheets/d/1VeJnao4S9Jaa-IICXFZOZO27R8EV-dlmZBMxXXCfFxQ/edit#gid=';
    var vcSheet = sheetUrl + '1764419485';
    var guideSheet = sheetUrl + '1223484669';
    var editSheet = sheetUrl + '905515608';
    var smplSheet = sheetUrl + '432879536';
    var refSheet = sheetUrl + '2085446379';
    var lang_kr = {
        "decimal": "",
        "emptyTable": "데이터가 없습니다.",
        "info": "_START_ / _END_ (전체 _TOTAL_건)",
        "infoEmpty": "0건",
        "infoFiltered": "(전체 _MAX_건 중 검색결과)",
        "infoPostFix": "",
        "thousands": ",",
        "lengthMenu": "_MENU_ 개씩 보기",
        "loadingRecords": "로딩중...",
        "processing": "처리중...",
        "search": "검색 ",
        "zeroRecords": "검색된 데이터가 없습니다.",
        "paginate": {
            "first": "첫 페이지",
            "last": "마지막 페이지",
            "next": "다음",
            "previous": "이전"
        },
        "aria": {
            "sortAscending": " 오름차순 정렬",
            "sortDescending": " 내림차순 정렬"
        }
    };

    // version control list table
    var VCTemplate = Handlebars.compile($('#uiGVCTbl-template').html());
    $('#uiGVCTbl').sheetrock({
        url: vcSheet,
        rowTemplate: VCTemplate,
    }).on('sheetrock:loaded', function () {
        $('#uiGVCTbl').after('<div class="btn_area"><a href="' + vcSheet + '" class="btn blue" target="_blank">등록</a></div>');
    });

    // edit list table
    var EditTemplate = Handlebars.compile($('#uiGEditTbl-template').html());
    $('#uiGEditTbl').sheetrock({
        url: editSheet,
        rowTemplate: EditTemplate,
        query: 'SELECT B,C,D,E,F,G,H,I WHERE B IS NOT NULL'
    }).on('sheetrock:loaded', function () {
        $(this).DataTable({
            language: lang_kr,
            "order": [[0, 'desc']],
            pagingType: 'full_numbers',
            fnDrawCallback: function () {
                fncUgetType();
                fncAutoLink('#uiGEditTbl', 'tbody td.uget_note span');
            }
        });
        $('#uiGEditTbl_filter input[type="search"]').attr('type', 'text');
        $('#uiGEditTbl_wrapper .dt-table + .row').addClass('paging_wrap');
        $('#uiGEditTbl_wrapper .dt-table + .row').append('<div class="btn_right"><a href="' + editSheet + '" class="btn blue" target="_blank">등록</a></div>');
        fncUgetType();
        fncAutoLink('#uiGEditTbl', 'tbody td.uget_note span');
    });
    function fncUgetType() {
        $('#uiGEditTbl tbody').find('.uget_type').each(function () {
            if ($(this).data('ugettype') == '제안') {
                $(this).children().addClass('state c05');
            } else if ($(this).data('ugettype') == '수정') {
                $(this).children().addClass('state c02');
            } else if ($(this).data('ugettype') == '추가') {
                $(this).children().addClass('state c06');
            } else if ($(this).data('ugettype') == '보류') {
                $(this).children().addClass('state c01');
            }
        });
    }

    // ui sample list
    var SmplTemplate = Handlebars.compile($('#uiGSmpl-template').html());
    $('#uiGSmpl').sheetrock({
        url: smplSheet,
        query: 'SELECT A,C,D,E,F,G,H,I,J WHERE A IS NOT NULL',
        rowTemplate: SmplTemplate,
    }).on('sheetrock:loaded', function () {
        $(this).DataTable({
            language: lang_kr,
            "lengthMenu": [8, 16, 24, 32],
            pagingType: 'full_numbers'
        });
        $('#uiGSmpl_filter input[type="search"]').attr('type', 'text');
        $('#uiGSmpl_wrapper .dt-table + .row').addClass('paging_wrap');
        $('#uiGSmpl_wrapper .dt-table + .row').append('<div class="btn_right"><a href="' + guideSheet + '" class="btn blue" target="_blank">등록</a></div>');
        fncUigsView();
    });
    function fncUigsView() {
        $('#uiGSmpl tbody tr').click(function () {
            $('#smplTypeV').text($(this).find('.smpl_type').text());
            if ($(this).find('.smpl_detype').text() != '') {
                $('#smplDetypeV').text(' - ' + $(this).find('.smpl_detype').text());
            } else {
                $('#smplDetypeV').text($(this).find('.smpl_detype').text());
            }
            $('#smplWkV').text($(this).find('.smpl_worker').text());
            $('#smplPjV').text($(this).find('.smpl_pj').text());
            $('#smplPathV').val($(this).find('.smpl_path').text());
            $('#smplDetpV').text($(this).find('.smpl_detpath').text());
            $('#smplThumV').attr('src', $(this).find('.smpl_thum img').attr('src'));
            view_show('_uiGSmpl');
            $('#smplPathV').select();
        });
    }

    // useful site list
    var RefTemplate = Handlebars.compile($('#uiGRefTbl-template').html());
    $('#uiGRefTbl').sheetrock({
        url: refSheet,
        query: 'SELECT * WHERE A IS NOT NULL',
        rowTemplate: RefTemplate,
    }).on('sheetrock:loaded', function () {
        $(this).DataTable({
            language: lang_kr,
            pagingType: 'full_numbers',
            fnDrawCallback: function () {
                fncRefType();
                fncAutoLink('#uiGRefTbl', 'tbody td.ref_link span');
            }
        });
        $('#uiGRefTbl_filter input[type="search"]').attr('type', 'text');
        $('#uiGRefTbl_wrapper .dt-table + .row').addClass('paging_wrap');
        $('#uiGRefTbl_wrapper .dt-table + .row').append('<div class="btn_right"><a href="' + refSheet + '" class="btn blue" target="_blank">등록</a></div>');
        fncRefType();
        fncAutoLink('#uiGRefTbl', 'tbody td.ref_link span');
    });
    function fncRefType() {
        $('#uiGRefTbl tbody').find('.ref_type').each(function () {
            if ($(this).data('reftype') == '플러그인') {
                $(this).children().addClass('state c06');
            } else if ($(this).data('reftype') == 'css') {
                $(this).children().addClass('state c05');
            } else if ($(this).data('reftype') == 'html') {
                $(this).children().addClass('state c04');
            } else if ($(this).data('reftype') == 'font & icon') {
                $(this).children().addClass('state c08');
            } else if ($(this).data('reftype') == '접근성') {
                $(this).children().addClass('state c02');
            } else if ($(this).data('reftype') == '공부') {
                $(this).children().addClass('state c07');
            } else if ($(this).data('reftype') == '기타') {
                $(this).children().addClass('state c01');
            }
        });
    }

    // auto link in td
    function fncAutoLink(tbl, td) {
        $(tbl).find(td).each(function () {
            if ($(this).text()) {
                var ugetLink = $(this).text().split(' ');
                for (i in ugetLink) {
                    if (ugetLink[i].indexOf('http') == 0) {
                        ugetLink[i] = '<a href="' + ugetLink[i] + '" target="_blank">' + ugetLink[i] + '</a>';
                    }
                }
                $(this).html(ugetLink.join(' '));
            }
        });
    }
});