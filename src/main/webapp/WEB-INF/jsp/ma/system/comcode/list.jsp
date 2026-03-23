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
    .treemenu_box .ztree li span.button.bottom_open {
        background-image: url("<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/images/icon/i_tree_minus.png") !important;
    }
    .treemenu_box .ztree li span.button.roots_close,
    .treemenu_box .ztree li span.button.center_close,
    .treemenu_box .ztree li span.button.bottom_close {
        background-image: url("<c:out value='${pageContext.request.contextPath}'/>/internal/standard/ma/images/icon/i_tree_plus.png") !important;
    }

    /* 우측 폼 영역(data_tbl) 내부의 입력창 테두리 복원 및 스타일링 */
    #cdAttrForm .data_tbl input[type="text"],
    #cdAttrForm .data_tbl select {
        border: 1px solid #d1d5db !important; /* 연한 회색 테두리 추가 */
        border-radius: 4px; /* 모서리 살짝 둥글게 */
        padding: 4px 8px;
        height: 30px;
        box-sizing: border-box;
        width: 100%;
        transition: border-color 0.2s; /* 부드러운 전환 효과 */
    }

    /* 입력창 클릭(포커스) 시 파란색 테두리로 강조 */
    #cdAttrForm .data_tbl input[type="text"]:focus,
    #cdAttrForm .data_tbl select:focus {
        border-color: #3b82f6 !important;
        outline: none;
    }

    /* 읽기 전용(비활성화) 항목은 기존처럼 테두리 없이 배경색만 유지 */
    #cdAttrForm .data_tbl input.disabled,
    #cdAttrForm .data_tbl input[readonly] {
        border: none !important;
        background-color: var(--disabled-bg, #f3f4f6) !important;
    }
</style>

<script type="text/javascript">
    $(document).ready(function(){

        /***********************           페이지 세팅            ***********************/
        // 사용여부 SelectBox
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#useYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" , defaultVal : "Y" }
                                     , dataInfo      : [{comCd:"Y", cdNm : "사용"}
                                                       ,{comCd:"N", cdNm : "사용안함"}]
                                     });

        // 폼 내부 입력 앨리먼트 비활성화(PageLoad 시점엔 선택된게 없으므로 막아둠)
        on.html.docFormDisEnable({formId : "#cdAttrForm" , isAbleDiv : true });

        /***********************      좌측 공통코드 트리 관련 이벤트           ***********************/
        // Page Open 시점 공통코드 트리 조회
        lfnComCdTreeDisplay();

        function lfnComCdTreeDisplay(){
             // ※ 실제 운영하시는 공통코드 트리조회 SQL ID로 변경 필요
             let resultList = on.xhr.ajax({sid:"cdList", sql : "on.standard.system.comcode.selectHierarchyComCdList", searchKeyWord : on.html.getEleVal({ele : "#searchKeyWord"})});

             let jsTreeData = resultList.map(function(item) {
                return {
                    id: item.comCd,
                    // 상위코드가 없으면 최상위 루트("#")로 지정
                    parent: (item.uppComCd === null || item.uppComCd === "") ? "#" : item.uppComCd,
                    text: item.cdDesc,
                    data: {
                          uppComCd      : item.uppComCd
                        , comCd         : item.comCd
                        , cdNm          : item.cdNm
                        , sortNo        : item.sortNo
                        , cdComment     : item.cdComment
                        , useYn         : item.useYn || "Y"
                        , filter1       : item.filter1
                        , filter2       : item.filter2
                        , filter3       : item.filter3
                        , filter4       : item.filter4
                        , filter5       : item.filter5
                        , filter6       : item.filter6
                        , filter7       : item.filter7
                        , filter8       : item.filter8
                        , filter9       : item.filter9
                        , filter10      : item.filter10
                        , filterComment : item.filterComment
                        , isNew         : false // 신규 추가 여부 플래그
                    }
                };
            });

            $('#cdTree').jstree("destroy");
            $('#cdTree').jstree({
                'core': {
                    'data': jsTreeData,
                    'check_callback': true, // 노드 생성/수정/삭제 허용
                    'themes': { 'icons': false }
                }
            });

            // 트리 클릭 이벤트 (상세 폼 바인딩)
            $('#cdTree').off("select_node.jstree").on("select_node.jstree", function (e, data) {
                on.html.docFormDisEnable({formId : "#cdAttrForm" , isAbleDiv : false });
                let node = data.node;
                if(node.data) {
                    // 신규 추가된 항목일 경우 '코드(cdVal)' 입력창을 열어주고, 기존 코드면 닫음
                    if(node.data.isNew) {
                        $("#comCd").prop("readonly", false).removeClass("disabled").css("background-color", "#ffffff");
                    } else {
                        $("#comCd").prop("readonly", true).addClass("disabled").css("background-color", "var(--disabled-bg)");
                    }

                    // 상위코드는 언제나 읽기전용 (트리에서 위치가 결정되므로)
                    $("#uppComCd").val(node.parent === "#" ? "" : node.parent);

                    // 속성 바인딩
                    $("#comCd").val(node.data.comCd);
                    $("#cdNm").val(node.data.cdNm);
                    $("#sortNo").val(node.data.sortNo);
                    $("#cdComment").val(node.data.cdComment);
                    $("#useYn").val(node.data.useYn);

                    // 필터 바인딩
                    $("#filter1").val(node.data.filter1);
                    $("#filter2").val(node.data.filter2);
                    $("#filter3").val(node.data.filter3);
                    $("#filter4").val(node.data.filter4);
                    $("#filter5").val(node.data.filter5);
                    $("#filter6").val(node.data.filter6);
                    $("#filter7").val(node.data.filter7);
                    $("#filter8").val(node.data.filter8);
                    $("#filter9").val(node.data.filter9);
                    $("#filter10").val(node.data.filter10);
                    $("#filterComment").val(node.data.filterComment);
                }
            });
        }

        // 전체열기 / 닫기
        $("#btn_open_all").click(function(){ $('#cdTree').jstree('open_all'); });
        $("#btn_close_all").click(function(){ $('#cdTree').jstree('close_all'); });


        /*********************** 콤퍼넌트  이벤트        ***********************/

        // 코드 추가 버튼 클릭
        $("#btnAddCode").on("click" , (evt) => {

            let treeInstance = $('#cdTree').jstree(true);
            let flatTree = treeInstance.get_json('#', { flat: true });
            let hasUnsavedCode = flatTree.some(node => node.data && node.data.isNew === true);

            if (hasUnsavedCode) {
                on.msg.showMsg({ message: "이미 추가 중인 코드가 있습니다.\n먼저 저장한 후 다시 추가해주세요." });
                return;
            }

            // 현재 선택된 노드를 부모로 설정 (없으면 루트)
            let selectedNodes = treeInstance.get_selected(true);
            let parentNode = selectedNodes.length > 0 ? selectedNodes[0] : null;
            let parentCd = parentNode ? parentNode.id : "#";

            let siblingIds = parentNode && parentNode.children ? parentNode.children :
                             (!parentNode && treeInstance.get_node("#").children ? treeInstance.get_node("#").children : []);
            let newSortNo = siblingIds.length + 1;

            // 임시 ID 발급 (저장 시 사용자가 입력한 실제 cdVal로 대체됨)
            let tempNodeId = "NEW_CD_" + new Date().getTime();

            let newNodeData = {
                id: tempNodeId,
                text: "새 코드",
                icon: false,
                data: {
                    isNew: true,
                    comCd: "", // 사용자가 직접 폼에 입력하도록 비워둠
                    uppComCd: parentCd === "#" ? "" : parentCd,
                    cdNm: "",
                    sortNo: newSortNo,
                    cdComment: "",
                    useYn: "Y",
                    filter1: "", filter2: "", filter3: "", filter4: "", filter5: "",
                    filter6: "", filter7: "", filter8: "", filter9: "", filter10: "",
                    filterComment: ""
                }
            };

            // jsTree에 신규 노드 생성
            treeInstance.create_node(parentCd, newNodeData, "last", function(new_node) {
                if(parentNode) treeInstance.open_node(parentNode);

                treeInstance.deselect_all();
                treeInstance.select_node(new_node);

                let msg = parentCd === "#" ? "최상위 코드그룹이 추가되었습니다." : "[" + parentNode.text + "]의 하위 코드가 추가되었습니다.";
                on.msg.showMsg({message : msg + "\n우측 폼에 코드 정보(코드값, 코드명 등)를 직접 입력해 주세요."});

                // 코드 입력창에 포커스
                setTimeout(() => $("#cdVal").focus(), 100);
            });
        });


        // 저장
        $("#btnCdSave").on("click",(evt) => {

             // 필수 유효성 검증
             let cdRegValidateList = [{name : "comCd", label : "코드"  , rule: {"required":true}}
                                     ,{name : "cdNm" , label : "코드명", rule: {"required":true}}
                                     ];

            // 상위코드가 비어있으면 공백 처리
            let uppComCd = on.html.getEleVal({ele : "#uppComCd"});
            if (uppComCd === null || uppComCd === undefined) uppComCd = "";
            on.html.setEleVal({ele : "#uppComCd", val : uppComCd });

            on.xhr.ajax({ cmd: "insert" , sql : "on.standard.system.comcode.mergeInsComCdInfo"
                        , validation : { formId : "#cdAttrForm" , validationList : cdRegValidateList  }
                        , data : $("#cdAttrForm").serializeArray()
                        , successFn : function (rs){
                                if( rs[0].execResult === "success" ){
                                    on.msg.showMsg({message : "정상적으로 저장되었습니다."});
                                    // 저장 완료 후 페이지 새로고침하여 트리 최신화
                                    on.html.dynaGenHiddenForm({ formDefine : { fid : "cdMngForm", action: "/ma/system/comcode/list.do", method: "post", isSubmit : true } });
                                }
                          }
                        , failFn : function (err){
                                on.msg.showMsg({message : err.message});
                          }
            });
        });

        // 좌측 Tree영역 검색
        $("#btnSearchTree").on("click" , (evt) => {
             //  트리 다시 그리기 호출
              lfnComCdTreeDisplay();

              // 검색 시 우측 폼 영역은 깨끗하게 초기화 및 비활성화 처리
              document.getElementById("cdAttrForm").reset();
              on.html.docFormDisEnable({formId : "#cdAttrForm" , isAbleDiv : true });
        });

        // 검색창에서 엔터키 입력 시 바로 검색되도록 이벤트 추가
        $("#searchKeyWord").on("keyup", function(e) {
            if (e.keyCode === 13) {
                $("#btnSearchTree").click();
            }
        });

    });
</script>

<div class="tbl">
    <div class="code_area" style="display: flex; gap: 20px;">

        <div class="code_list scr_box" style="width: 35%;" data-simplebar data-simplebar-auto-hide="false">
             <div class="board_top" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: nowrap;">

                <div class="board_left" style="display: flex; align-items: center; gap: 5px; white-space: nowrap; flex-shrink: 0;">
                    <i class="name"></i>공통코드 트리
                    <span class="btn_allclose btn_open cursor" id="btn_open_all" style="margin-left: 5px;">전체열기</span>
                    <span class="btn_allclose btn_close cursor" id="btn_close_all">전체닫기</span>

                    <div style="display: inline-flex; align-items: center; gap: 4px; margin-left: 8px;">
                        <label for="searchKeyWord" style="font-size: 12px; font-weight: 500;">상위코드/명</label>
                        <input type="text" id="searchKeyWord" placeholder="검색어" style="width: 120px; height: 28px; padding: 0 5px;">
                        <button type="button" id="btnSearchTree" class="btn gray sml" style="height: 28px; line-height: 26px; padding: 0 8px;">검색</button>
                    </div>
                </div>

                <div class="board_right" style="flex-shrink: 0;">
                    <c:if test="${USER_AUTH.WRITE_YN == 'Y'}">
                        <button type="button" id="btnAddCode" class="btn blue" style="width: 28px; height: 28px; padding: 0; display: inline-flex; align-items: center; justify-content: center;">
                            <i class="xi-plus" style="margin: 0; line-height: 1;"></i>
                        </button>
                    </c:if>
                </div>

            </div>
            <div id="cdTree" style="margin-top: 15px;"></div>
        </div>

        <div id="cdAttrArea" class="code_form" style="width: 65%;">
            <div class="board_top">
                <div class="board_left">
                    <i class="name"></i>코드 상세 정보
                </div>
            </div>
            <form id="cdAttrForm" name="cdAttrForm">
                <table class="data_tbl form">
                    <colgroup>
                        <col style="width: 15%;">
                        <col style="width: 35%;">
                        <col style="width: 15%;">
                        <col style="width: 35%;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>상위코드</th>
                            <td><input type="text" id="uppComCd" name="uppComCd" readonly class="disabled" style="background-color: var(--disabled-bg); border: none;" placeholder="최상위 코드입니다."></td>
                            <th>코드 <span class="asterisk">*</span></th>
                            <td><input type="text" id="comCd" name="comCd" readonly class="disabled" style="background-color: var(--disabled-bg); border: none;"></td>
                        </tr>
                        <tr>
                            <th>코드명 <span class="asterisk">*</span></th>
                            <td><input type="text" id="cdNm" name="cdNm" placeholder="코드명"></td>
                            <th>정렬 순서</th>
                            <td><input type="text" id="sortNo" name="sortNo" style="width: 100px;"></td>
                        </tr>
                        <tr>
                            <th>사용 여부</th>
                            <td><select id="useYn" name="useYn"></select></td>
                            <th>코드 설명</th>
                            <td><input type="text" id="cdComment" name="cdComment" placeholder="코드 상세 설명"></td>
                        </tr>

                        <tr>
                            <th>필터 1</th><td><input type="text" id="filter1" name="filter1"></td>
                            <th>필터 2</th><td><input type="text" id="filter2" name="filter2"></td>
                        </tr>
                        <tr>
                            <th>필터 3</th><td><input type="text" id="filter3" name="filter3"></td>
                            <th>필터 4</th><td><input type="text" id="filter4" name="filter4"></td>
                        </tr>
                        <tr>
                            <th>필터 5</th><td><input type="text" id="filter5" name="filter5"></td>
                            <th>필터 6</th><td><input type="text" id="filter6" name="filter6"></td>
                        </tr>
                        <tr>
                            <th>필터 7</th><td><input type="text" id="filter7" name="filter7"></td>
                            <th>필터 8</th><td><input type="text" id="filter8" name="filter8"></td>
                        </tr>
                        <tr>
                            <th>필터 9</th><td><input type="text" id="filter9" name="filter9"></td>
                            <th>필터 10</th><td><input type="text" id="filter10" name="filter10"></td>
                        </tr>
                        <tr>
                            <th>필터 사용설명</th>
                            <td colspan="3"><input type="text" id="filterComment" name="filterComment" placeholder="각 필터가 어떤 용도로 쓰이는지 기록합니다. (예: 필터1=권한, 필터2=메뉴구분 등, 유지보수 혼란방지용)"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <div class="btn_area right">
                <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
                    <button type="button" id="btnCdSave" class="btn btn_save" >저장</button>
                </c:if>
            </div>
        </div>

    </div>
</div>