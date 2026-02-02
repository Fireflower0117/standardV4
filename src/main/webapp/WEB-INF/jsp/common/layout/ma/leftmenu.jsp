<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
   $(document).ready( () => {

       //  메뉴설정
       on.xhr.ajax({ sid : "leftmenu"
                   , sql : "on.standard.system.menu.selectLeftMenus"
                   , pageUrl : window.location.pathname
                   , successFn : function(sid , rs){
                          displayMenuTrees(rs);
                     }
       });


       // 조회 결과 => 메뉴 display
       function displayMenuTrees(rs){
          for(let menuObj of rs){
                if( menuObj.LEVEL == 1 ){
                    let menuMarkup  = "<li id='li_"+menuObj.MENU_CD+"' class='"+menuObj.MENU_FOCUS+"' data-menunm='"+menuObj.KOR_NM+"'>";
                        menuMarkup += "   <a  href='#' id='li_a_"+menuObj.MENU_CD+"' data-href='"+menuObj.URL_ADDR+"'  target='"+menuObj.MENU_TARGET+"'><span class='gnb_"+menuObj.MENU_CSS+"'></span>"+menuObj.KOR_NM+"</a>";
                        menuMarkup += "   <div class='subwrap js_subwrap'>";
                        menuMarkup += "      <ul class='deps"+(menuObj.LEVEL+1)+"' id='li_parent_"+menuObj.MENU_CD+"'></ul>";
                        menuMarkup += "   </div>";
                        menuMarkup += "</li>";
                    $("#menuTreeRoot").append(menuMarkup)
                }
                else if(menuObj.LEVEL >= 2){
                    let menuMarkup  = "";
                    if(menuObj.IS_LEAF == "Y"){
                            menuMarkup += "<li id='li_"+menuObj.MENU_CD+"' class='"+menuObj.MENU_FOCUS+"'  data-menunm='"+menuObj.KOR_NM+"'>";
                            menuMarkup += "   <a href='#' id='li_a_"+menuObj.MENU_CD+"' data-href='"+menuObj.URL_ADDR+"' data-target='"+menuObj.MENU_TARGET+"'>"+menuObj.KOR_NM+"</a>";
                            menuMarkup += "</li>";
                    }
                    else {
                            menuMarkup += "<li id='li_"+menuObj.MENU_CD+"' class='has_sub "+menuObj.MENU_FOCUS+"' data-menunm='"+menuObj.KOR_NM+"'>";
                            menuMarkup += "   <a href='#' id='li_a_"+menuObj.MENU_CD+"' data-href='"+menuObj.URL_ADDR+"' data-target='"+menuObj.MENU_TARGET+"'>"+menuObj.KOR_NM+"</a>";
                            menuMarkup += "   <ul class='deps"+(menuObj.LEVEL+1)+"' id='li_parent_"+menuObj.MENU_CD+"'></ul>";
                            menuMarkup += "</li>";
                    }
                    $("#li_parent_"+menuObj.UPR_MENU_CD).append(menuMarkup);
                }
          }
       }


       // 메뉴 클릭
       $(document).on("click", "[id^='li_a_']", (evt) => {
           let menuHref = $(evt.target).data("href");
           let menuTraget = $(evt.target).data("target");

           on.msg.consoleLog('leftmenu.jsp => href : '+menuHref+", target : "+menuTraget);

           if(!on.valid.isEmpty(menuHref)){
               on.html.dynaGenHiddenForm({ formDefine : { fid:"leftMenuForm", fTarget:menuTraget , action: menuHref , method : "post" , isSubmit : true   }
               });
           }
       });


   });
</script>
<nav id="gnb" class="leftfix">
    <ul class="gnb js_gnb" id="menuTreeRoot">
<!--
        <li id="li_depth1_us" data-menunm="사용자지원">
            <a href="/ma/us/mem/user/list.do" target=""><span class="gnb_i01"></span>사용자지원</a>
            <div class="subwrap js_subwrap">
                <ul class="deps2">
                    <li id="li_depth2_mem" class="has_sub" data-menunm="회원">
                        <a href="/ma/us/mem/user/list.do" target="">회원</a>
                        <ul class="deps3">
                            <li id="li_depth3_user" data-menunm="사용자">
                                <a href="/ma/us/mem/user/list.do" target="">사용자</a>
                            </li>
                            <li id="li_depth3_lginPlcy" data-menunm="로그인정책">
                                <a href="/ma/us/mem/lginPlcy/form.do" target="">로그인정책</a>
                            </li>
                            <li id="li_depth3_terms" data-menunm="약관관리">
                                <a href="/ma/us/mem/terms/termsScrb/form.do" target="">약관관리</a>
                            </li>
                        </ul>
                    </li>
                    <li id="li_depth2_bltnb" class="has_sub" data-menunm="공통게시판관리">
                        <a href="/ma/us/bltnb/nt01/list.do" target="">공통게시판관리</a>
                        <ul class="deps3">
                            <li id="li_depth3_nt01" data-menunm="공지사항">
                                <a href="/ma/us/bltnb/nt01/list.do" target="">공지사항</a>
                            </li>
                            <li id="li_depth3_nt03" data-menunm="공지사항3">
                                <a href="/ma/us/bltnb/nt03/list.do" target="">공지사항3</a>
                            </li>
                            <li id="li_depth3_qna" data-menunm="Q&amp;A">
                                <a href="/ma/us/bltnb/qna/list.do" target="">Q&amp;A</a>
                            </li>
                            <li id="li_depth3_faq" data-menunm="FAQ">
                                <a href="/ma/us/bltnb/faq/list.do" target="">FAQ</a>
                            </li>
                            <li id="li_depth3_gallery" data-menunm="갤러리">
                                <a href="/ma/us/bltnb/gallery/list.do" target="">갤러리</a>
                            </li>
                            <li id="li_depth3_freeboard" data-menunm="자유게시판">
                                <a href="/ma/us/bltnb/freeboard/list.do" target="">자유게시판</a>
                            </li>
                        </ul>
                    </li>
                    <li id="li_depth2_contTmpl" class="" data-menunm="컨텐츠관리">
                        <a href="/ma/us/contTmpl/list.do" target="">컨텐츠관리</a>
                    </li>
                    <li id="li_depth2_schd" class="" data-menunm="일정관리">
                        <a href="/ma/us/schd/list.do" target="">일정관리</a>
                    </li>
                    <li id="li_depth2_srvy" class="" data-menunm="설문조사">
                        <a href="/ma/us/srvy/list.do" target="">설문조사</a>
                    </li>
                    <li id="li_depth2_hwp" class="" data-menunm="한글(hwp)">
                        <a href="/ma/us/hwp/list.do" target="">한글(hwp)</a>
                    </li>
                    <li id="li_depth2_popup" class="" data-menunm="팝업관리">
                        <a href="/ma/us/popup/list.do" target="">팝업관리</a>
                    </li>
                    <li id="li_depth2_cprgt" class="" data-menunm="copyright관리">
                        <a href="/ma/us/cprgt/form.do" target="">copyright관리</a>
                    </li>
                    <li id="li_depth2_relSite" class="" data-menunm="관련사이트관리">
                        <a href="/ma/us/relSite/form.do" target="">관련사이트관리</a>
                    </li>
                    <li id="li_depth2_std" class="has_sub" data-menunm="용어사전">
                        <a href="/ma/us/std/term/list.do" target="">용어사전</a>
                        <ul class="deps3">
                            <li id="li_depth3_term" data-menunm="용어관리">
                                <a href="/ma/us/std/term/list.do" target="">용어관리</a>
                            </li>
                            <li id="li_depth3_dmn" data-menunm="도메인관리">
                                <a href="/ma/us/std/dmn/list.do" target="">도메인관리</a>
                            </li>
                            <li id="li_depth3_wrd" data-menunm="단어관리">
                                <a href="/ma/us/std/wrd/list.do" target="">단어관리</a>
                            </li>
                        </ul>
                    </li>
                    <li id="li_depth2_dbQlt" class="has_sub" data-menunm="DB품질">
                        <a href="/ma/us/dbQlt/dbData/list.do" target="">DB품질</a>
                        <ul class="deps3">
                            <li id="li_depth3_dbData" data-menunm="DB데이터">
                                <a href="/ma/us/dbQlt/dbData/list.do" target="">DB데이터</a>
                            </li>
                            <li id="li_depth3_tblDgns" data-menunm="테이블진단">
                                <a href="/ma/us/dbQlt/tblDgns/list.do" target="">테이블진단</a>
                            </li>
                            <li id="li_depth3_termDgns" data-menunm="용어진단">
                                <a href="/ma/us/dbQlt/termDgns/list.do" target="">용어진단</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </li>
        <li id="li_depth1_sys" data-menunm="시스템">
            <a href="/ma/sys/menu/list.do" target=""><span class="gnb_i02"></span>시스템</a>
            <div class="subwrap js_subwrap">
                <ul class="deps2">
                    <li id="li_depth2_menu" class="" data-menunm="메뉴관리">
                        <a href="/ma/sys/menu/list.do" target="">메뉴관리</a>
                    </li>
                    <li id="li_depth2_mngr" class="has_sub" data-menunm="관리자">
                        <a href="/ma/sys/mngr/mngrMng/list.do" target="">관리자</a>
                        <ul class="deps3">
                            <li id="li_depth3_mngrMng" data-menunm="관리자관리">
                                <a href="/ma/sys/mngr/mngrMng/list.do" target="">관리자관리</a>
                            </li>
                            <li id="li_depth3_rstMng" data-menunm="제한관리">
                                <a href="/ma/sys/mngr/rstMng/list.do" target="">제한관리</a>
                            </li>
                        </ul>
                    </li>
                    <li id="li_depth2_auth" class="" data-menunm="권한관리">
                        <a href="/ma/sys/auth/list.do" target="">권한관리</a>
                    </li>
                    <li id="li_depth2_code" class="" data-menunm="코드관리">
                        <a href="/ma/sys/code/list.do" target="">코드관리</a>
                    </li>
                    <li id="li_depth2_log" class="has_sub" data-menunm="로그관리">
                        <a href="/ma/sys/log/errlog/list.do" target="">로그관리</a>
                        <ul class="deps3">
                            <li id="li_depth3_errlog" data-menunm="에러로그">
                                <a href="/ma/sys/log/errlog/list.do" target="">에러로그</a>
                            </li>
                            <li id="li_depth3_acs" data-menunm="접속로그">
                                <a href="/ma/sys/log/acs/list.do" target="">접속로그</a>
                            </li>
                        </ul>
                    </li>
                    <li id="li_depth2_logo" class="" data-menunm="로고관리">
                        <a href="/ma/sys/logo/list.do" target="">로고관리</a>
                    </li>
                    <li id="li_depth2_regeps" class="" data-menunm="정규표현식 관리">
                        <a href="/ma/sys/regeps/list.do" target="">정규표현식 관리</a>
                    </li>
                    <li id="li_depth2_mnl" class="" data-menunm="매뉴얼관리">
                        <a href="/ma/sys/mnl/list.do" target="">매뉴얼관리</a>
                    </li>
                    <li id="li_depth2_dm" class="has_sub" data-menunm="데이터관리">
                        <a href="/ma/sys/dm/regCd/list.do" target="">데이터관리</a>
                        <ul class="deps3">
                            <li id="li_depth3_regCd" data-menunm="법정동코드">
                                <a href="/ma/sys/dm/regCd/list.do" target="">법정동코드</a>
                            </li>
                        </ul>
                    </li>
                    <li id="li_depth2_seo" class="" data-menunm="SEO">
                        <a href="/ma/sys/seo/list.do" target="">SEO</a>
                    </li>
                </ul>
            </div>
        </li>
        <li id="li_depth1_stat" data-menunm="통계">
            <a href="/ma/stat/acsStat/list.do" target=""><span class="gnb_i03"></span>통계</a>
            <div class="subwrap js_subwrap">
                <ul class="deps2">
                    <li id="li_depth2_acsStat" class="" data-menunm="접속통계">
                        <a href="/ma/stat/acsStat/list.do" target="">접속통계</a>
                    </li>
                </ul>
            </div>
        </li>
        <li id="li_depth1_board" data-menunm="샘플게시판">
            <a href="/ma/board/list.do" target=""><span class="gnb_i04"></span>샘플게시판</a>
        </li>
        <li id="li_depth1_guide" data-menunm="퍼블가이드">
            <a href="/internal/guide/index.html" target="_blank"><span class="gnb_i05"></span>퍼블가이드</a>
        </li>
        <li id="li_depth1_ocr" data-menunm="ocr">
            <a href="/ma/ocr/ocrJoin/list.do" target=""><span class="gnb_i06"></span>ocr</a>
            <div class="subwrap js_subwrap">
                <ul class="deps2">
                    <li id="li_depth2_ocrJoin" class="" data-menunm="회원가입">
                        <a href="/ma/ocr/ocrJoin/list.do" target="">회원가입</a>
                    </li>
                    <li id="li_depth2_statMng" class="" data-menunm="상태관리">
                        <a href="/ma/ocr/statMng/list.do" target="">상태관리</a>
                    </li>
                    <li id="li_depth2_menuMng" class="" data-menunm="메뉴 및 상품관리">
                        <a href="/ma/ocr/menuMng/list.do" target="">메뉴 및 상품관리</a>
                    </li>
                </ul>
            </div>
        </li>
        <li id="li_depth1_info" data-menunm="정보게시판">
            <a href="/ma/info/phr/list.do" target=""><span class="gnb_i07"></span>정보게시판</a>
            <div class="subwrap js_subwrap">
                <ul class="deps2">
                    <li id="li_depth2_phr" class="" data-menunm="약국게시판">
                        <a href="/ma/info/phr/list.do" target="">약국게시판</a>
                    </li>
                </ul>
            </div>
        </li>
-->
    </ul>
</nav>
<!-- button type="button" class="btn_menu"><span class="sr_only">전체메뉴 열기</span></button --> <!-- 사이트맵열기 -->
