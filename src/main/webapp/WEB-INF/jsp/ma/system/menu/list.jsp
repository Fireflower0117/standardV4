<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/zTree.v3/3.5.33/css/zTreeStyle/zTreeStyle.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/zTree.v3/3.5.33/js/jquery.ztree.all.min.js"></script>
<style>
    /* 1. 깨진 기본 점선 이미지(zTreeStandard.png)만 골라서 제거 */
    .ztree li span.button.roots_docu,
    .ztree li span.button.center_docu,
    .ztree li span.button.bottom_docu { background-image: none !important; }

    /* 2. common.css에 있는 가짜 선(-) 숨김 */
    .treemenu_box .ztree li span.button.center_docu::after,
    .treemenu_box .ztree li span.button.bottom_docu::after { display: none !important; }

    /* 3. + / - 버튼은 프로젝트 경로의 아이콘으로 강제 고정 */
    .treemenu_box .ztree li span.button.roots_open,
    .treemenu_box .ztree li span.button.center_open,
    .treemenu_box .ztree li span.button.bottom_open { background-image: url("<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/images/icon/i_tree_minus.png") !important; }
    .treemenu_box .ztree li span.button.roots_close,
    .treemenu_box .ztree li span.button.center_close,
    .treemenu_box .ztree li span.button.bottom_close { background-image: url("<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/images/icon/i_tree_plus.png") !important; }
</style>
<script type="text/javascript">

     function lfnFuncFindCallBack ( callBackObj ){
           if(!on.valid.isEmpty( callBackObj )) {
               // 팝업에서 선택한 기본 정보 세팅
               on.html.setEleVal({ ele : "#menuFuncCd" , val : callBackObj.boardCd }).prop("readonly", true).addClass("disabled");
               on.html.setEleVal({ ele : "#menuFuncNm" , val : callBackObj.boardNm }).prop("readonly", true).addClass("disabled");

               // 메뉴 기능 구분에 따라 기본 URL 자동 맵핑 (게시판일 경우)
               let funcDiv = $("#menuFuncDiv").val();
               if(funcDiv === "board") {
                   on.html.setEleVal({ ele : "#urlAddr" , val : "/ma/comboard/list.do" }).prop("readonly", true).addClass("disabled");
                   on.html.setEleVal({ ele : "#rtnUrl"  , val : "/ma/comboard/list" }).prop("readonly", true).addClass("disabled");

                   // ※ 게시판의 경우 두번째 SelectBox(목록/등록 등) 변경 이벤트에서 URL을 동적으로 다시 세팅하도록 설계되었습니다.
                   $("#menuFuncType").trigger("change");
               }
           }
     }

    $(document).ready(function(){

        let ftMaDivList = [{comCd : "MA", cdNm : "관리자" , layoutNm:"관리자(.mLayout:)" , layoutCd:".mLayout:"}
                          ,{comCd : "FT", cdNm : "사용자" , layoutNm:"사용자(.fLayout:)" , layoutCd:".fLayout:"}];

        /*********************** 페이지 세팅            ***********************/
        // 1. 메뉴Tree 구분(SelectBox)
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#menuDivType" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" , defaultVal : "MA" }
                                     , dataInfo      : ftMaDivList
                                     });

        // 2. 메뉴 레이아웃
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#menuLayout" }
                                     , addOption     : [{txt : "팝업(.popLayout:)"  , val :".popLayout:/" , position : "bottom" }]
                                     , optionValInfo : { optId : "layoutCd" , optTxt : "layoutNm" }
                                     , dataInfo      : ftMaDivList
                                     });

         // 3. 메뉴 Target
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#menuTarget" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                     , dataInfo      : [{comCd:"_self" , cdNm : "현재창 (_self)"}
                                                       ,{comCd:"_blank", cdNm : "새창 (_blank)"}]
                                     });

         // 4. 메뉴 구분
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#menuCl" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                     , dataInfo      : [{comCd:"MAIN"  , cdNm : "메인"}
                                                       ,{comCd:"SUB"   , cdNm : "서브"}
                                                       ,{comCd:"POPUP" , cdNm : "팝업"}]
                                     });

         // 5. 사용 여부
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#useYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" , defaultVal : "Y" }
                                     , dataInfo      : [{comCd:"Y", cdNm : "사용"}
                                                       ,{comCd:"N", cdNm : "사용안함"}]
                                     });

        // 6. [NEW] 메뉴 기능 1뎁스 (커스텀/템플릿/게시판)
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#menuFuncDiv" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" , defaultVal : "custom" }
                                     , dataInfo      : [{comCd:"custom"   , cdNm : "커스텀"}
                                                       ,{comCd:"template" , cdNm : "템플릿"}
                                                       ,{comCd:"board"    , cdNm : "게시판"}]
                                     });

        // 7. [NEW] 메뉴 기능 2뎁스 (목록/등록/상세/수정 - 게시판 전용 옵션)
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#menuFuncType" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" , defaultVal : "list" }
                                     , dataInfo      : [{comCd:"list" , cdNm : "목록"}
                                                       ,{comCd:"reg"  , cdNm : "등록"}
                                                       ,{comCd:"dtl"  , cdNm : "상세"}
                                                       ,{comCd:"mod"  , cdNm : "수정"}]
                                     });

        // menuAttrForm 폼내부 입력 앨리먼트 비활성화(PageLoad)
        on.html.docFormDisEnable({formId : "#menuAttrForm" , isAbleDiv : true });


      /*********************** 좌측 메뉴트리 관련 이벤트        ***********************/
        // 메뉴Tree 구분 Select Box 변경
        $("#menuDivType").on("change", (evt) => {
              lfnMenuTreeDisplay({menuDiv : $(evt.target).val() })
        });

        // PageOpen시점 기본( 관리자 메뉴 Display )
        lfnMenuTreeDisplay({menuDiv : "MA" })

        // tree Menu 조회 / Display
        function lfnMenuTreeDisplay( treeInfo ){
             let resultList = on.xhr.ajax({sid:"menuList", sql : "on.standard.system.menu.selectMenuList" , menuDivCd : treeInfo.menuDiv });
             let jsTreeData = resultList.map(function(item) {
                return {
                    id: item.menuCd,
                    parent: (item.uprMenuCd === null || item.uprMenuCd === "") ? "#" : item.uprMenuCd,
                    text: item.korNm,
                    data: item // 원본 데이터를 통째로 넣는 것이 관리하기 편리합니다.
                };
            });

            $('#menuTree').jstree("destroy");
            $('#menuTree').jstree({
                'core': {
                    'data': jsTreeData,
                    'check_callback': true,
                    'themes': { 'icons': false }
                }
            });

            // 메뉴Tree클릭시 Data 앨리먼트 바인딩
            $('#menuTree').off("select_node.jstree").on("select_node.jstree", function (e, data) {
                // menuAttrForm 폼내부 입력 앨리먼트 활성화
                on.html.docFormDisEnable({formId : "#menuAttrForm" , isAbleDiv : false });

                let node = data.node;
                $("#uprMenuCd").val(node.parent === "#" ? "" : node.parent);
                $("#menuCd").val(node.id);

                if(node.data) {
                   on.html.setEleVal({ ele : "#korNm"   , val : node.data.korNm });
                   on.html.setEleVal({ ele : "#engNm"   , val : node.data.engNm });
                   on.html.setEleVal({ ele : "#menuCl"  , val : node.data.menuCl });


                    // [NEW] 메뉴기능 1뎁스 / 2뎁스 콤보박스 바인딩 및 이벤트 트리거
                    let menuFuncDiv  = on.str.nvl(node.data.menuFuncDiv, "custom");
                    let menuFuncType = on.str.nvl(node.data.menuFuncType, "list"); // 새로 추가된 DB 컬럼이라 가정 (없으면 기본 list)

                    on.html.setEleVal({ ele : "#menuFuncDiv"  , val : menuFuncDiv });
                    on.html.setEleVal({ ele : "#menuFuncType" , val : menuFuncType });
                    on.html.setEleVal({ ele : "#menuFuncCd" , val : node.data.menuFuncCd });

                    // UI 동기화를 위해 change 강제 실행
                    $("#menuFuncDiv").trigger("change");
                    on.html.setEleVal({ ele : "#urlAddr" , val : node.data.urlAddr });
                    on.html.setEleVal({ ele : "#rtnUrl"  , val : node.data.rtnUrl });

                    if(menuFuncDiv === "board"){
                       on.html.setEleVal({ ele : "#menuFuncNm" , val : node.data.boardFuncNM }).prop("readonly", true).addClass("disabled");
                       $("#urlAddr").prop("readonly", true).addClass("disabled");
                       $("#rtnUrl").prop("readonly", true).addClass("disabled");
                    }
                    else if(menuFuncDiv === "template"){
                       on.html.setEleVal({ ele : "#menuFuncNm" , val : node.data.templateFuncNM }).prop("readonly", true).addClass("disabled");
                       $("#urlAddr").prop("readonly", true).addClass("disabled");
                       $("#rtnUrl").prop("readonly", true).addClass("disabled");
                    }


                    on.html.setEleVal({ ele : "#menuParam"  , val : node.data.menuParam  , defaultVal :  "{}" });
                    on.html.setEleVal({ ele : "#menuTarget" , val : node.data.menuTarget , defaultVal :  "_self" });
                    on.html.setEleVal({ ele : "#layOut"     , val : node.data.layOut });
                    on.html.setEleVal({ ele : "#menuCss"    , val : node.data.menuCss });
                    on.html.setEleVal({ ele : "#useYn"      , val : node.data.useYn , defaultVal :  "Y" });
                    on.html.setEleVal({ ele : "#sortNo"     , val : node.data.sortNo });
                    on.html.setEleVal({ ele : "#menuComment", val : node.data.menuComment });
                    on.html.setEleVal({ ele : "#menuPath"   , val : node.data.menuPath });
                    on.html.setEleVal({ ele : "#menuCdPath" , val : node.data.menuCdPath });
                }
            });
        }

        // 메뉴 전체열기 / 닫기
        $("#btn_open_all").click(function(){ $('#menuTree').jstree('open_all'); });
        $("#btn_close_all").click(function(){ $('#menuTree').jstree('close_all'); });

        // 신규 메뉴 코드 자동 채번 함수 (생략... 기존 코드 동일)
        function lfnGenerateMenuCd(parentCd, siblingIds) {
            // ... 기존 코드 유지 ...
            let targetDepthIdx = 0; let baseParts = ["00", "00", "00", "00"];
            if (parentCd && parentCd !== "#") {
                if (parentCd.length !== 8) return null;
                for (let i = 0; i < 4; i++) baseParts[i] = parentCd.substring(i * 2, i * 2 + 2);
                targetDepthIdx = baseParts.indexOf("00");
                if (targetDepthIdx === -1) return null;
            }
            let maxNum = 0;
            if (siblingIds && siblingIds.length > 0) {
                siblingIds.forEach(id => {
                    if (typeof id === 'object' && id.id) id = id.id;
                    if (id && id.length === 8) {
                        let isValidSibling = true;
                        for (let i = 0; i < targetDepthIdx; i++) {
                            if (id.substring(i * 2, i * 2 + 2) !== baseParts[i]) { isValidSibling = false; break; }
                        }
                        if (isValidSibling) {
                            let num = parseInt(id.substring(targetDepthIdx * 2, targetDepthIdx * 2 + 2), 10);
                            if (!isNaN(num) && num > maxNum) maxNum = num;
                        }
                    }
                });
            }
            let newNum = maxNum + 1;
            let menuDivCd = $("#menuDivType").val();
            if (targetDepthIdx === 0) {
                if (menuDivCd === "FT") { if (newNum > 69) return null; }
                else if (menuDivCd === "MA") { if (maxNum < 71) newNum = 71; if (newNum > 99) return null; }
            } else {
                if (newNum > 99) return null;
            }
            baseParts[targetDepthIdx] = String(newNum).padStart(2, '0');
            return baseParts.join('');
        }

        /*********************** 콤퍼넌트  이벤트        ***********************/
        // 1. [NEW] 첫 번째 SelectBox (메뉴 기능 1뎁스) 변경 이벤트
        $("#menuFuncDiv").on("change", function() {
            let funcDiv = $(this).val();

            if(funcDiv === 'custom') {
                // 커스텀: 2뎁스 Select 숨김, 프로그램 찾기 영역 숨김, 입력창 초기화 및 수동 입력 허용
                $("#menuFuncType").hide();
                $("#funcNmArea").hide();

                $("#menuFuncCd").val("").prop("readonly", false).removeClass("disabled");
                $("#menuFuncNm").val("").prop("readonly", false).removeClass("disabled");
                $("#urlAddr").val("").prop("readonly", false).removeClass("disabled");
                $("#rtnUrl").val("").prop("readonly", false).removeClass("disabled");
            }
            else if (funcDiv === 'template') {
                // 템플릿: 2뎁스 Select 숨김, 프로그램 찾기 영역 노출, 입력창 초기화
                $("#menuFuncType").hide();
                $("#funcNmArea").css("display", "inline-flex");

                $("#menuFuncCd").val("").prop("readonly", false).removeClass("disabled");
                $("#menuFuncNm").val("").prop("readonly", false).removeClass("disabled");
                $("#urlAddr").val("").prop("readonly", false).removeClass("disabled");
                $("#rtnUrl").val("").prop("readonly", false).removeClass("disabled");
            }
            else if(funcDiv === 'board'){
                // 게시판: 2뎁스 Select(목록/등록 등) 노출, 프로그램 찾기 영역 노출
                $("#menuFuncType").show();
                $("#funcNmArea").css("display", "inline-flex");
            }
        });

        // 2. [NEW] 두 번째 SelectBox (게시판 상세 페이지 타입) 변경 이벤트
        $("#menuFuncType").on("change", function() {
            // 게시판(board)이 선택된 상태에서만 작동하도록 방어 로직
            if($("#menuFuncDiv").val() === "board") {
                let funcType = $(this).val();
                let baseAction = "/ma/comboard/";
                let jspPath    = "/ma/comboard/";

                // 선택한 타입에 따라 URL 자동 변경 (예시)
                if(funcType === "list") { baseAction += "list.do"; jspPath += "list"; }
                else if(funcType === "reg") { baseAction += "regist.do"; jspPath += "regist"; }
                else if(funcType === "dtl") { baseAction += "view.do"; jspPath += "view"; }
                else if(funcType === "mod") { baseAction += "update.do"; jspPath += "update"; }

                on.html.setEleVal({ ele : "#urlAddr", val : baseAction }).prop("readonly", true).addClass("disabled");
                on.html.setEleVal({ ele : "#rtnUrl", val : jspPath }).prop("readonly", true).addClass("disabled");
            }
        });


        // 메뉴 기능찾기 버튼 (템플릿 or 게시판 팝업 호출)
        $("#btnMenuFuncFind").on("click", (evt) => {

             let selectedNodes = $('#menuTree').jstree("get_selected");
             if (selectedNodes.length === 0) {
                 on.msg.showMsg({message : "좌측메뉴 트리에서 메뉴를 먼저 선택해 주세요."});
                 return;
             }

             let menuFuncVal = on.html.getEleVal({ ele : "#menuFuncDiv"});
             if (menuFuncVal !== "template" && menuFuncVal !== "board" ) {
                on.msg.showMsg({message : "템플릿 또는 게시판 기능일 때만 찾기가 가능합니다."});
                return;
            }

             let openPopInfo = { popWinName  : "menuFuncSearchPopup"
                               , popUrlAddr  : "/ma/system/menu/boardFuncPopup.do"
                               , popWinStyle : "width=1200, height=700, top=200, left=200, scrollbars=yes, resizable=yes"
                               , callBackFn  : "lfnFuncFindCallBack"
                               , params      : []
                               }
             on.html.dynaGenOpenPostPopup(openPopInfo);
        });


        // 메뉴 추가 버튼 클릭 (생략... 기존 코드 동일하되 menuFuncDiv 맵핑 부분만 수정)
        $("#btnAddMenu").on("click" , (evt) => {
                let treeInstance = $('#menuTree').jstree(true);
                let flatTree = treeInstance.get_json('#', { flat: true });

                // 1. 작성 중인 새 메뉴가 이미 존재하는지 검사
                let hasUnsavedMenu = flatTree.some(node => node.data && node.data.isNew === true);
                if (hasUnsavedMenu) {
                    on.msg.showMsg({ message: "이미 추가 중인 새 메뉴가 있습니다.\n먼저 저장한 후 다시 추가해주세요." });
                    return;
                }

                // 2. 부모 노드 및 형제 노드(siblingIds) 탐색 로직 보완
                let selectedNodes = treeInstance.get_selected(true);
                let parentNode = selectedNodes.length > 0 ? selectedNodes[0] : null;

                let parentCd = parentNode ? parentNode.id : "#";
                let siblingIds = [];

                if (parentNode && parentNode.children) {
                    siblingIds = parentNode.children;
                } else if (!parentNode) {
                    // 선택된 노드가 없으면 최상위(1Depth) 형제 노드들을 모두 가져옵니다.
                    let rootChildren = treeInstance.get_children_dom("#");
                    if(rootChildren && rootChildren.length > 0) {
                        rootChildren.each(function() {
                            siblingIds.push($(this).attr("id"));
                        });
                    }
                }

                // 3. 정렬 번호 및 메뉴 코드 자동 채번
                let maxSortNo = 0;
                if (siblingIds && siblingIds.length > 0) {
                    siblingIds.forEach(id => {
                        let sibNode = treeInstance.get_node(id);
                        if (sibNode && sibNode.data && sibNode.data.sortNo) {
                            let curSortNo = parseInt(sibNode.data.sortNo, 10);
                            if (!isNaN(curSortNo) && curSortNo > maxSortNo) {
                                maxSortNo = curSortNo; // 가장 큰 값 갱신
                            }
                        }
                    });
                }

                // 가장 큰 값에 10을 더합니다. (처음 만드는 거라면 0 + 10 = 10이 됩니다.)
                let newSortNo = maxSortNo + 10;

                let newMenuCd = lfnGenerateMenuCd(parentCd, siblingIds);

                // ※ 채번 함수에서 유효하지 않은 Depth나 최대치를 초과하여 null을 반환한 경우 중단
                if(!newMenuCd) return;

                // 4. 레벨(Depth) 계산: 최상위는 1, 하위는 부모 레벨 + 1
                let newLevel = 1;
                if (parentNode && parentCd !== "#") {
                    let parentLevel = (parentNode.data && parentNode.data.level != null)
                                      ? parseInt(parentNode.data.level, 10)
                                      : parentNode.parents.length;
                    newLevel = parentLevel + 1;
                }

                // 5. 트리에 렌더링할 신규 노드 데이터 구조 세팅
                let newNodeData = {
                    id: newMenuCd,
                    text: "새 메뉴",
                    icon: false,
                    data: {
                        isNew: true,
                        level: newLevel,
                        menuDivCd: "MAIN",
                        menuCd: newMenuCd,
                        uprMenuCd: parentCd === "#" ? "" : parentCd,
                        menuCl: "MAIN",
                        korNm: "",
                        engNm: "",
                        menuFuncDiv: "custom",  // 1뎁스 기본값
                        menuFuncType: "",
                        menuParam: "{}",
                        menuTarget: "_self",
                        layOut: ".fLayout:",
                        menuCss: "",
                        urlAddr: "",
                        rtnUrl: "",
                        useYn: "Y",
                        sortNo: newSortNo,
                        menuPath: "",
                        menuCdPath: ""
                    }
                };

                // 6. jsTree에 신규 노드 생성
                treeInstance.create_node(parentCd, newNodeData, "last", function(new_node) {
                    if(parentNode) {
                        treeInstance.open_node(parentNode);
                    }

                    // 새로 생성된 노드 강제 선택 (우측 폼에 메뉴코드 세팅 등 트리거)
                    treeInstance.deselect_all();
                    treeInstance.select_node(new_node);

                    let msg = parentCd === "#" ? "최상위 메뉴가 추가되었습니다." : "[" + parentNode.text + "]의 하위 메뉴가 추가되었습니다.";
                    on.msg.showMsg({message : msg + "\n자동 생성된 메뉴코드[" + newMenuCd + "], 레벨[" + newLevel + "]을(를) 확인하고 폼을 완성해주세요."});
                });
        });

        // 저장
        $("#btnMenuSave").on("click",(evt) => {
             // 메뉴등록 유효성 검증 대상 속성
             let menuRegValidateList = [{name : "uprMenuCd"    , label : "상위메뉴코드"   , rule: {"required":true} }
                                       ,{name : "menuCd"       , label : "메뉴코드"      , rule: {"required":true} }
                                       ,{name : "korNm"        , label : "메뉴명(한글)"   , rule: {"required":true} }
                                       ,{name : "menuParam"    , label : "메뉴 파라미터"  , rule: {"required":true} }
                                       ];

            let uprMenuCd = on.html.getEleVal({ele : "#uprMenuCd"});
                uprMenuCd = uprMenuCd === "" || uprMenuCd === null ? "00000000" : uprMenuCd;
                on.html.setEleVal({ele : "#uprMenuCd", val : uprMenuCd });

            on.xhr.ajax({ cmd: "insert" , sql : "on.standard.system.menu.mergeInsMenuInfo"
                        , validation : { formId : "#menuAttrForm" , validationList : menuRegValidateList  }
                        , data : $("#menuAttrForm").serializeArray()
                        , menuDivCd :on.html.getEleVal({ele : "#menuDivType"})
                        , successFn : function (rs){
                                  if( rs[0].execResult === "success" ){
                                      on.msg.showMsg({message : "정상적으로 반영되었습니다. "});
                                      on.html.dynaGenHiddenForm({ formDefine : { fid : "menuMngForm", action: "/ma/system/menu/list.do", method: "post", isSubmit : true } });
                                  }
                          }
                        , failFn    : function (err){ on.msg.showMsg({message : err.message}); }
            });
        });

        // 삭제 (생략... 기존 코드 동일)
        $("#btnMenuDel").on("click",(evt) => {
            if( on.msg.confirm({message : "삭제 하시겠습니까?"}) == true ){
                on.xhr.ajax({ cmd: "delete" , sql : "on.standard.system.menu.delMenuInfo"
                            , menuCd : on.html.getEleVal({ele : "#menuCd"})
                            , successFn : function (rs){
                                  if( rs[0].execResult === "success" ){
                                      on.msg.showMsg({message : "정상적으로 삭제되었습니다. "});
                                      on.html.dynaGenHiddenForm({ formDefine : { fid : "menuMngForm", action: "/ma/system/menu/list.do", method: "post", isSubmit : true } });
                                  }
                              }
                            , failFn    : function (err){
                                on.msg.showMsg({message : err.message});
                            }
                });
            }
        });
    });
</script>

<div class="tbl">
    <div class="menu_area" style="display: flex; gap: 20px;">
        <div class="menu_list scr_box" style="width: 38%;" data-simplebar data-simplebar-auto-hide="false">
            <div class="board_top">
                <div class="board_left">
                    <i class="name"></i>메뉴명
                    <span class="btn_allclose btn_open cursor" id="btn_open_all">전체열기</span>
                    <span class="btn_allclose btn_close cursor" id="btn_close_all">전체닫기</span>
                </div>
                <div class="board_right">
                    <div style="display: inline-flex; align-items: center; gap: 5px;">
                        <select id="menuDivType" name="menuDivType"></select>
                        <c:if test="${USER_AUTH.WRITE_YN == 'Y'}">
                            <button id="btnAddMenu" class="btn blue"><i class="xi-plus"></i></button>
                        </c:if>
                    </div>
                </div>
            </div>
            <div id="menuTree" style="margin-top: 15px;"></div>
        </div>
        <div id="menuAttrArea" class="menu_form" style="width: 60%;">
            <div class="board_top">
                <div class="board_left">
                    <i class="name"></i>메뉴 상세 정보
                </div>
            </div>
            <form id="menuAttrForm" name="menuAttrForm">
                <table class="data_tbl form">
                    <colgroup>
                        <col style="width: 15%;">
                        <col style="width: 35%;">
                        <col style="width: 15%;">
                        <col style="width: 35%;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>상위메뉴코드</th>
                            <td><input type="text" id="uprMenuCd" name="uprMenuCd" readonly class="disabled" style="background-color: var(--disabled-bg); border: none;"></td>
                            <th>메뉴코드</th>
                            <td><input type="text" id="menuCd" name="menuCd" readonly class="disabled" style="background-color: var(--disabled-bg); border: none;"></td>
                        </tr>
                        <tr>
                            <th>메뉴 한글명 <span class="asterisk">*</span></th>
                            <td><input type="text" id="korNm" name="korNm" placeholder="메뉴 한글명"></td>
                            <th>메뉴 영문명</th>
                            <td><input type="text" id="engNm" name="engNm" placeholder="메뉴 영문명"></td>
                        </tr>
                         <tr>
                            <th>메뉴구분</th>
                            <td><select id="menuCl" name="menuCl"></select></td>
                            <th></th>
                            <td></td>
                        </tr>
                        <tr>
                            <th>메뉴 기능</th>
                            <td>
                                <div style="display: flex; align-items: center; gap: 5px; width: 100%;">
                                    <select id="menuFuncDiv" name="menuFuncDiv" style="flex: 1; min-width: 0;"></select>
                                    <select id="menuFuncType" name="menuFuncType" style="flex: 1; min-width: 0; display: none;"></select>
                                </div>
                            </td>
                            <th>프로그램</th>
                            <td>
                                <div id="funcNmArea" style="display: none; align-items: center; gap: 5px;">
                                    <input type="hidden" id="menuFuncCd" name="menuFuncCd"/>
                                    <input type="text" id="menuFuncNm" name="menuFuncNm" readonly style="width: calc(100% - 60px); background-color: var(--disabled-bg);" placeholder="프로그램 선택">
                                    <button type="button" id="btnMenuFuncFind" class="btn gray sml" style="min-width: 50px;">찾기</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>메뉴 파라미터</th>
                            <td><input type="text" id="menuParam" name="menuParam"></td>
                            <th>메뉴 Target</th>
                            <td><select id="menuTarget" name="menuTarget"></select></td>
                        </tr>
                        <tr>
                            <th>기본 레이아웃</th>
                            <td><select id="menuLayout" name="menuLayout"></select></td>
                            <th>메뉴 CSS</th>
                            <td><input type="text" id="menuCss" name="menuCss" readonly placeholder="프로그램 CSS"></td>
                        </tr>
                        <tr>
                            <th>메뉴 URL</th>
                            <td><input type="text" id="urlAddr" name="urlAddr"></td>
                            <th>메뉴 페이지 주소</th>
                            <td><input type="text" id="rtnUrl" name="rtnUrl"></td>
                        </tr>
                        <tr>
                            <th>사용 여부</th>
                            <td><select id="useYn" name="useYn"></select></td>
                            <th>정렬 번호</th>
                            <td><input type="text" id="sortNo" name="sortNo" ></td>
                        </tr>
                        <tr>
                            <th>메뉴 설명</th>
                            <td colspan="3"><input type="text" id="menuComment" name="menuComment"></td>
                        </tr>
                        <tr>
                            <th>메뉴 네비 경로</th>
                            <td colspan="3"><span id="menuPath" style="font-weight: 500; color: var(--blue);"></span></td>
                        </tr>
                        <tr>
                            <th>메뉴 코드 경로</th>
                            <td colspan="3"><span id="menuCdPath"></span></td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <div class="btn_area right">
                <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
                    <button type="button" id="btnMenuSave" class="btn btn_save" >저장</button>
                </c:if>
                <c:if test="${USER_AUTH.DELETE_YN== 'Y'}">
                    <button type="button" id="btnMenuDel" class="btn btn_del">삭제</button>
                </c:if>
            </div>
        </div>
    </div>
</div>