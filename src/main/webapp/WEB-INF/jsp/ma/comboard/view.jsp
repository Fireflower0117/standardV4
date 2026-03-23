<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
   // const menuFuncCd = "${param.menuFuncCd}";
    //const boardSerno = "${param.boardSerno}";
    let globalBoardConfig = {}; // 게시판 설정 전역 변수

    $(document).ready(() => {
        // 1. 공통 게시판 Meta정보 조회 및 초기화 실행
        initBoardView();

        // 2. 버튼 이벤트 바인딩 (★ 반드시 ready 블록 안에 위치해야 합니다!)
        bindEvents();
    });

    /****************************************************************************************************
     *********************************** 초기화 및 데이터 조회 영역 *************************
     *****************************************************************************************************/

    function initBoardView() {
        on.xhr.ajax({ cmd : "selectOne", sql : "on.standard.system.boardtype.inqBoardTypeDetail"
                    , menuFuncCd: "${param.menuFuncCd}"
                    , successFn : function(rs) {
                        globalBoardConfig = rs;
                        lfnInitBoardViewUI(rs); // 공통 게시판 Meta정보조회후 컴포넌트 먼저 제어
                        getBoardDetail();       // 게시판 상세데이터 조회 실행
                    }
        });
    }

    // 게시판 설정에 따른 View UI 영역 Show/Hide 제어
    function lfnInitBoardViewUI(cfg) {
        // 테이블 행(tr) 단위로 숨김 처리
        if (cfg.contentYn !== 'Y') $("#trContent").hide();
        if (cfg.attchFileYn !== 'Y') $("#trFile").hide();
    }

    // 실제 게시글 상세 데이터 조회 및 바인딩
    function getBoardDetail() {
        if(on.valid.isEmpty("${param.boardSerno}")) {
            on.msg.showMsg({message: "잘못된 접근입니다."});
            goList();
            return;
        }
        on.xhr.ajax({ cmd: "selectOne",  sql: "on.standard.board.comboard.inqBoardView"
                    , data: { menuFuncCd : "${param.menuFuncCd}"
                            , boardSerno : "${param.boardSerno}" }
                    , successFn: function(data) {
                        if (!on.valid.isEmpty(data)) {
                            on.html.setEleVal({ele :"#txtTitl"      , val : data.titl      });
                            on.html.setEleVal({ele :"#txtRegUser"   , val : data.regUserNm });
                            on.html.setEleVal({ele :"#txtRegDate"   , val : data.regDate   });
                            on.html.setEleVal({ele :"#txtRcmdCount" , val : data.rcmdCount , defaultVal : 0 });

                            if(globalBoardConfig.ntiYn === 'Y' && data.ntiYn === 'Y') $("#badgeNti").show();
                            if(globalBoardConfig.secretYn === 'Y' && data.scretYn === 'Y') $("#badgeScret").show();

                            if (globalBoardConfig.contentYn === 'Y') {
                                if (globalBoardConfig.contentEditorYn === 'Y') {
                                    $("#txtContent").html(data.content);
                                } else {
                                    $("#txtContent").html(on.str.nvl(data.content, "").replace(/\n/g, "<br/>"));
                                }
                            }

                            if (globalBoardConfig.attchFileYn === 'Y') {
                                if (!on.valid.isEmpty(data.atchFileId)) {
                                    on.file.setFileList({
                                        displayTarget: "#fileViewArea",
                                        atchFileId: data.atchFileId,
                                        uploadType: "view"
                                    });
                                } else {
                                    $("#fileViewArea").html("<div class='no_data'>첨부파일이 없습니다.</div>");
                                }
                            }
                        } else {
                            on.msg.showMsg({message: "존재하지 않거나 삭제된 게시글입니다."});
                            goList();
                        }
                    }
        });
    }

    /****************************************************************************************************
     *********************************** 이벤트 바인딩 영역 ***************************************
     *****************************************************************************************************/

    function bindEvents() {
        // 목록
        $("#btnList").on("click", () => goList());

        // 수정
        $("#btnEdit").on("click", () => {
            on.html.dynaGenHiddenForm({ formDefine : { fid: "boardEditForm", action: "/ma/comboard/update.do", method: "post", isSubmit: true }
                                      , formAttrs  : [ { name: "searchCondition", value : JSON.stringify(${param.searchCondition}) }
                                                     , { name : "menuFuncCd"    , value : "${param.menuFuncCd}" }
                                                     , { name : "menuFuncDivCd" , value : 'board'               }
                                                     , { name: "boardSerno"     , value : "${param.boardSerno}" }
                                                     ]
            });
        });

        // 삭제
        $("#btnDelete").on("click", () => {
            if(confirm("이 게시글을 삭제하시겠습니까?")) {
                on.xhr.ajax({ cmd: "update",
                    sql: "on.standard.board.comboard.deleteBoardInfo",
                    data: { menuFuncCd : "${param.menuFuncCd}"
                          , boardSerno : "${param.boardSerno}"  },
                    successFn: function(rs) {
                        on.msg.showMsg({message: "삭제되었습니다."});
                        goList();
                    }
                });
            }
        });
    }

    // 목록 페이지 이동
    function goList(){
        on.html.dynaGenHiddenForm({ formDefine: { fid: "boardListForm", action: "/ma/comboard/list.do", method: "post", isSubmit: true },
                                    formAttrs: [ { name: "searchCondition", value: JSON.stringify(${param.searchCondition}) }
                                               , { name : "menuFuncCd"    , value : "${param.menuFuncCd}" }
                                               , { name : "menuFuncDivCd" , value : 'board' }
                                                ]
        });
    }
</script>

<table class="tbl row">
    <caption>게시글 상세</caption>
    <colgroup>
        <col style="width:15%">
        <col style="width:35%">
        <col style="width:15%">
        <col style="width:35%">
    </colgroup>
    <tbody>
        <tr>
            <th scope="row">제목</th>
            <td colspan="3">
                <span id="badgeNti" class="badge bg_red" style="display:none; color:red; font-weight:bold; margin-right:5px;">[공지]</span>
                <span id="badgeScret" class="badge bg_gray" style="display:none; color:gray; font-weight:bold; margin-right:5px;">[비밀글]</span>
                <span id="txtTitl" style="font-weight:bold;"></span>
            </td>
        </tr>
        <tr>
            <th scope="row">작성자</th>
            <td><span id="txtRegUser"></span></td>
            <th scope="row">작성일</th>
            <td><span id="txtRegDate"></span></td>
        </tr>
        <tr>
            <th scope="row">추천수</th>
            <td colspan="3"><span id="txtRcmdCount"></span></td>
        </tr>
       <tr id="trContent">
            <th scope="row" style="vertical-align: top; padding-top: 15px;">내용</th>
            <td colspan="3">
                <div id="txtContent" style="min-height: 200px; padding: 15px 5px;"></div>
            </td>
        </tr>
        <tr id="trFile">
            <th scope="row">첨부파일</th>
            <td colspan="3">
                <div id="fileViewArea"></div>
            </td>
        </tr>
    </tbody>
</table>

<div class="btn_area c mt20">
    <div class="l">
        <button type="button" id="btnList" class="btn bd gray">목록</button>
    </div>
    <div class="r">
        <button type="button" id="btnEdit" class="btn blue">수정</button>
        <button type="button" id="btnDelete" class="btn red">삭제</button>
    </div>
</div>