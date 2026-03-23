<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
    /* 하위 메뉴(li)가 하나도 없어서 비어있는 ul 태그는 여백을 없애고 강제 숨김 */
    .leftfix .gnb .deps2 .deps3:empty {
        display: none !important;
        padding: 0 !important;
        border: none !important;
    }

    /* GNB 영역에 마우스를 올렸을 때, 호버하지 않은 '선택된 메뉴(visible)'의 서브메뉴는 숨김 처리 */
    .leftfix .gnb:hover > li.visible:not(:hover) .subwrap {
        display: none !important;
    }

    /* 새로 호버한 서브메뉴는 높이를 100%로 강제하고 최상위로 띄워서 완벽하게 덮음 */
    .leftfix .gnb > li:hover .subwrap {
        display: block !important;
        height: 100% !important;
        z-index: 9999 !important;
        background-color: #fff !important;
    }

</style>
<script type="text/javascript">
   $(document).ready( () => {
       //  메뉴설정
       on.xhr.ajax({ sql : "on.standard.system.menu.selectLeftMenus"
                   , pageUrl : window.location.pathname
                   , menuFuncDivCd : '${param.menuFuncDivCd}'
                   , menuFuncCd : '${param.menuFuncCd}'
                   , async : true
                   , successFn : function(rs){
                          displayMenuTrees(rs);
                     }
       });

       // 조회 결과 => 메뉴 display
       function displayMenuTrees(rs){
          for(let menuObj of rs){
                if( menuObj.level === 1 ){
                    let menuMarkup  = "<li id='li_"+menuObj.menuCd+"' class='"+menuObj.menuFocus+"' data-menunm='"+menuObj.korNm+"'>";
                        menuMarkup += "   <a  href='#' id='li_a_"+menuObj.menuCd+"' data-href='"+menuObj.urlAddr+"' data-menufuncdiv='"+menuObj.menuFuncDiv+"' data-menufunccd='"+menuObj.menuFuncCd+"' data-target='"+menuObj.menuTarget+"'><span class='gnb_"+menuObj.menuCss+"'></span>"+menuObj.korNm+"</a>";
                        menuMarkup += "   <div class='subwrap js_subwrap'>";
                        menuMarkup += "      <ul class='deps"+(menuObj.level+1)+"' id='li_parent_"+menuObj.menuCd+"'></ul>";
                        menuMarkup += "   </div>";
                        menuMarkup += "</li>";
                    $("#menuTreeRoot").append(menuMarkup)
                }
                else if(menuObj.level >= 2){
                    let menuMarkup  = "";
                    if(menuObj.isLeaf === "Y"){
                            menuMarkup += "<li id='li_"+menuObj.menuCd+"' class='"+menuObj.menuFocus+"'  data-menunm='"+menuObj.korNm+"'>";
                            menuMarkup += "   <a href='#' id='li_a_"+menuObj.menuCd+"' data-href='"+menuObj.urlAddr+"' data-target='"+menuObj.menuTarget+"'  data-menufuncdiv='"+menuObj.menuFuncDiv+"' data-menufunccd='"+menuObj.menuFuncCd+"' >"+menuObj.korNm+"</a>";
                            menuMarkup += "</li>";
                    }
                    else {
                            menuMarkup += "<li id='li_"+menuObj.menuCd+"' class='has_sub "+menuObj.menuFocus+"' data-menunm='"+menuObj.korNm+"'>";
                            menuMarkup += "   <a href='#' id='li_a_"+menuObj.menuCd+"' data-href='"+menuObj.urlAddr+"' data-target='"+menuObj.menuTarget+"' data-menufuncdiv='"+menuObj.menuFuncDiv+"' data-menufunccd='"+menuObj.menuFuncCd+"' >"+menuObj.korNm+"</a>";
                            menuMarkup += "   <ul class='deps"+(menuObj.level+1)+"' id='li_parent_"+menuObj.menuCd+"'></ul>";
                            menuMarkup += "</li>";
                    }
                    $("#li_parent_"+menuObj.uprMenuCd).append(menuMarkup);
                }
          }

           /** 선택메뉴 항상 고정유지  **/
          // SQL에서 menuFocus='on'을 받아온 1Depth 최상위 메뉴에 'visible' 추가
          $("#menuTreeRoot > li.on").addClass("visible");

          // 'on' 클래스가 있는 모든 하위 메뉴에 'active' 추가 (트리 펼침)
          $("#menuTreeRoot li.on").addClass("active");

          // 현재 브라우저 URL과 일치하는 메뉴가 있다면 보완(Fallback) 처리
          let currentUrl = window.location.pathname;

          // URL로 먼저 찾고, 파라미터에 menuFuncCd가 있다면 그것까지 조건에 추가!
          let selector = "a[data-href='" + currentUrl + "']";
          let pMenuFuncCd = '${param.menuFuncCd}';
          if (!on.valid.isEmpty(pMenuFuncCd)) {
              selector += "[data-menufunccd='" + pMenuFuncCd + "']";
          }
          let $activeLink = $("#menuTreeRoot").find(selector);
          if ($activeLink.length > 0) {
              $activeLink.parents("li[id^='li_']").last().addClass("visible");
              $activeLink.closest("li").addClass("on active");
              $activeLink.parents("li.has_sub").addClass("on active");
          }
       }

       // 메뉴 클릭
       // 메뉴 클릭
       $(document).on("click", "[id^='li_a_']", (evt) => {
           evt.preventDefault();
           let $menuAnchor = $(evt.currentTarget);
           let menuHref = $menuAnchor.data("href");
           let menuTarget = $menuAnchor.data("target") || "_self"; // 2. 오타 수정 완료 (menuTarget)
           let menuFuncDivCd = on.str.nvl($menuAnchor.data("menufuncdiv"), "custom");
           let menuFuncCd = $menuAnchor.data("menufunccd");
           if(!on.valid.isEmpty(menuHref) && menuHref !== "#"){
               if(menuFuncDivCd === "custom"){
                   if (!menuHref.endsWith(".do")) {
                       if (menuTarget === "_blank") {
                           window.open(menuHref, "_blank"); // 새 창 열기
                       } else {
                           window.location.href = menuHref; // 현재 창 이동
                       }
                   }
                   else {
                       on.html.dynaGenHiddenForm({
                           formDefine : { fid:"leftMenuForm", fTarget:menuTarget, action: menuHref, method : "post", isSubmit : true }
                       });
                   }
               } else if(menuFuncDivCd === "template" || menuFuncDivCd === "board"){
                   on.html.dynaGenHiddenForm({
                         formDefine : { fid:"leftMenuForm", fTarget:menuTarget, action: menuHref, method : "post", isSubmit : true }
                       , formAttrs  : [ { name : "menuFuncCd"    , value : menuFuncCd }
                                      , { name : "menuFuncDivCd" , value : menuFuncDivCd  }
                                      ]
                   });
               }
           }
       });
   });
</script>
<nav id="gnb" class="leftfix">
    <ul class="gnb js_gnb" id="menuTreeRoot"></ul>
</nav>
<!-- button type="button" class="btn_menu"><span class="sr_only">전체메뉴 열기</span></button --> <!-- 사이트맵열기 -->
