<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
(function() {
    let globalBoardConfig = {};
    $(document).ready(() => {
        if(!on.valid.isEmpty('${param.menuFuncCd}') && !on.valid.isEmpty('${param.boardSerno}')) {
             on.xhr.ajax({ cmd : "selectOne", sql : "on.standard.system.boardtype.inqBoardTypeDetail"
                         , data: { menuFuncCd : '${param.menuFuncCd}' }
                         , successFn : function(rs){
                              globalBoardConfig = rs;
                              lfnInitBoardUI(rs);
                              getBoardDetail();
                         }
             });
        } else {
             on.msg.showMsg({message: "잘못된 접근입니다. (필수 파라미터 누락)"});
             history.back();
        }

        function getBoardDetail() {
            on.xhr.ajax({
                cmd: "selectOne",
                sql: "on.standard.board.comboard.inqBoardView",
                data: { menuFuncCd : '${param.menuFuncCd}', boardSerno : '${param.boardSerno}' },
                successFn: function(data) {
                    if (!on.valid.isEmpty(data)) {

                        // 제목
                        on.html.setEleVal({ele : "#titl" , val : data.titl });

                        // Content
                        let contentVal = on.str.nvl(data.content, "");
                        if (globalBoardConfig.contentYn === 'Y') {
                            if (globalBoardConfig.contentEditorYn === 'Y' && typeof CKEDITOR !== 'undefined') {
                                let editor = CKEDITOR.instances.boardContent;
                                if (editor) {
                                    if (editor.status === 'ready') {
                                        // 1. 에디터 렌더링이 이미 끝났다면 즉시 데이터 삽입
                                        editor.setData(contentVal);
                                    } else {
                                        // 2. 에디터 렌더링이 아직 진행 중이라면, 완료되는 순간 삽입하라고 예약(Event)
                                        editor.on('instanceReady', function() {
                                            this.setData(contentVal);
                                        });
                                    }
                                }
                            } else {
                                // 일반 Textarea 처리
                                on.html.setEleVal({ele : "#boardContent" , val : contentVal });
                            }
                        }

                        if (globalBoardConfig.ntiYn === 'Y' && data.ntiYn === 'Y') {
                            $("#ntiYn").prop("checked", true).trigger("change");
                            on.html.setEleVal({ele : "#ntiStrtDt" , val : data.ntiStrtDt });
                            on.html.setEleVal({ele : "#ntiEndDt"  , val : data.ntiEndDt });
                        }


                        if (globalBoardConfig.secretYn === 'Y' && data.scretYn === 'Y') {
                            $("#scretYn").prop("checked", true).trigger("change");
                        }

                        on.file.setFileList({
                                  displayTarget : "#fileUploadArea1"
                                , atchFileIdNm  : "atchFileId"
                                , atchFileId    : data.atchFileId
                                , maxFileCnt    : 5
                                , maxFileSize   : 20
                        });

                    } else {
                        on.msg.showMsg({message: "존재하지 않거나 삭제된 게시글입니다."});
                        $("#btnList").click();
                    }
                }
            });
        }

        function lfnInitBoardUI(cfg) {
            let hasNti = (cfg.ntiYn === 'Y');
            let hasSecret = (cfg.secretYn === 'Y');

            if (hasNti || hasSecret) {
                $("#trOptions").show();
            }

            if (hasNti) {
                $("#thNtiYn, #tdNtiYn").show();
                on.html.setDatePicker({ targets : ["#ntiStrtDt", "#ntiEndDt"], dateFormat : "yy-mm-dd" });

                $("#ntiYn").on("change", function() {
                    if($(this).is(":checked")) {
                        $("#ntiDateArea").css("display", "inline-flex");
                        $("#ntiStrtDt, #ntiEndDt").prop("disabled", false);
                    } else {
                        $("#ntiDateArea").hide();
                        $("#ntiStrtDt, #ntiEndDt").val("").prop("disabled", true);
                    }
                });
            }

            if (hasSecret) {
                $("#thSecretYn, #tdSecretYn").show();
                $("#scretYn").on("change", function() {
                    if($(this).is(":checked")) {
                        $("#scretPswdArea").css("display", "inline-flex");
                        $("#boardPswd, #boardPswdConfirm").prop("disabled", false);
                    } else {
                        $("#scretPswdArea").hide();
                        $("#boardPswd, #boardPswdConfirm").val("").prop("disabled", true);
                    }
                });
            }

            if (cfg.attchFileYn === 'Y') {
                $(".trFile").show();
            }

            if (cfg.contentYn === 'Y') {
                $("#trContent").show();
                if (cfg.contentEditorYn === 'Y') {
                    if(typeof CKEDITOR !== 'undefined') {
                        CKEDITOR.replace('boardContent', { height: 400 });
                    }
                }
            } else {
                $("#trContent").hide();
            }
        }

        $("#btnList").on("click", function() {
            on.html.dynaGenHiddenForm({
                formDefine : { fid : "moveForm", action: "/ma/comboard/list.do", method: "post", isSubmit : true },
                formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                             , { name : "menuFuncCd"      , value: '${param.menuFuncCd}' }
                             , { name : "menuFuncDivCd"   , value : 'board' }
                              ]
            });
        });

        $("#btnSave").on("click", function() {
            if (globalBoardConfig.contentYn === 'Y' && globalBoardConfig.contentEditorYn === 'Y' && typeof CKEDITOR !== 'undefined') {
                $("#boardContent").val(CKEDITOR.instances.boardContent.getData());
            }

            let boardValidateList = [
                { name : "titl", label : "제목", rule: { "required": true } }
            ];

            if (globalBoardConfig.contentYn === 'Y') {
                boardValidateList.push({ name : "boardContent", label : "내용", rule: { "required": true } });
            }

            if ($("#ntiYn").is(":checked")) {
                boardValidateList.push({ name : "ntiStrtDt", label : "공지 시작일", rule: { "required": true } });
                boardValidateList.push({ name : "ntiEndDt",   label : "공지 종료일", rule: { "required": true } });
            }

            if ($("#scretYn").is(":checked")) {
                boardValidateList.push({ name : "boardPswd", label : "비밀번호", rule: { "required": true } });

                let pswd1 = on.html.getEleVal({ele : "#boardPswd"});
                let pswd2 = on.html.getEleVal({ele : "#boardPswdConfirm"});

                if (pswd1 && pswd1 !== pswd2) {
                    on.msg.showMsg({message: "비밀번호가 일치하지 않습니다.\n다시 확인해주세요."});
                    $("#boardPswdConfirm").focus();
                    return;
                }
            }

            on.file.fileFormSubmit({ formIdArr : ["#boardForm"] , procType  : "update"
                                    , successFn : function(rs){

                                        let formDataArr = $("#boardForm").serializeArray();

                                        if (rs && Object.keys(rs).length > 0) {
                                            Object.entries(rs).forEach(([key, val]) => {
                                                formDataArr.push({ name: key, value: val });
                                            });
                                        }

                                        formDataArr.push({ name: "menuFuncCd", value: '${param.menuFuncCd}' });
                                        formDataArr.push({ name: "boardSerno", value: '${param.boardSerno}' });

                                        on.xhr.ajax({ cmd : "update" , sql : "on.standard.board.comboard.mergeBoardInfo"
                                                    , validation : { formId: "#boardForm", validationList: boardValidateList }
                                                    , data       : formDataArr
                                                    , boardPswd  : $("#scretYn").is(":checked") ? on.html.getEleVal({ ele : "#boardPswd"}) : ""
                                                    , successFn  : function( res) {
                                                        if (res[0] && res[0].execResult === "success") {
                                                            on.msg.showMsg({message : "게시글이 수정되었습니다."});

                                                            on.html.dynaGenHiddenForm({
                                                                formDefine : { fid : "viewForm", action: "/ma/comboard/list.do", method: "post", isSubmit : true },
                                                                formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                                             , { name : "menuFuncCd"      , value: '${param.menuFuncCd}' }
                                                                             , { name : "menuFuncDivCd"   , value : 'board' }
                                                                              ]
                                                            });
                                                        } else {
                                                            on.msg.showMsg({message : "수정에 실패했습니다."});
                                                        }
                                                    }
                                        });
                                    }
            });
        });

    });
})();
</script>

<section class="content">
    <div class="wrap">
        <div class="tbl" data-aos="fade-up">
            <div class="board_top">
                <div class="board_left">
                     <h3 id="pageTitle">수정</h3>
                </div>
                <div class="board_right">
                    <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
                </div>
            </div>

            <form id="boardForm" name="boardForm" onsubmit="return false;">
                 <table class="board_write">
                    <colgroup>
                        <col class="w15p">
                        <col class="">
                        <col class="w15p">
                        <col class="">
                    </colgroup>
                    <tbody>
                        <tr id="trOptions" style="display: none;">
                            <th scope="row" id="thNtiYn" style="display: none;">공지 설정</th>
                            <td id="tdNtiYn" style="display: none;">
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <label style="display: inline-flex; align-items: center; gap: 5px; cursor: pointer;">
                                        <input type="checkbox" id="ntiYn" name="ntiYn" value="Y" style="width: 16px; height: 16px; cursor: pointer;">
                                        <span>공지글 설정</span>
                                    </label>
                                    <span id="ntiDateArea" style="display: none; align-items: center; gap: 5px;">
                                        <input type="text" id="ntiStrtDt" name="ntiStrtDt" class="w100" disabled autocomplete="off" placeholder="시작일">
                                        <span>~</span>
                                        <input type="text" id="ntiEndDt" name="ntiEndDt" class="w100" disabled autocomplete="off" placeholder="종료일">
                                    </span>
                                </div>
                            </td>

                            <th scope="row" id="thSecretYn" style="display: none;">비밀글 설정</th>
                            <td id="tdSecretYn" style="display: none;">
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <label style="display: inline-flex; align-items: center; gap: 5px; cursor: pointer;">
                                        <input type="checkbox" id="scretYn" name="scretYn" value="Y" style="width: 16px; height: 16px; cursor: pointer;">
                                        <span>비밀글 설정</span>
                                    </label>
                                    <span id="scretPswdArea" style="display: none; align-items: center; gap: 5px;">
                                        <input type="password" id="boardPswd" name="boardPswd" class="w150" disabled autocomplete="new-password" placeholder="비밀번호 입력">
                                        <input type="password" id="boardPswdConfirm" class="w150" disabled autocomplete="new-password" placeholder="비밀번호 확인">
                                    </span>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <th scope="row"><span class="asterisk">*</span>제목</th>
                            <td colspan="3">
                                <input type="text" id="titl" name="titl" class="w100p" placeholder="제목을 입력하세요." maxlength="200">
                            </td>
                        </tr>

                        <tr id="trContent" style="display: none;">
                            <th scope="row"><span class="asterisk">*</span>내용</th>
                            <td colspan="3">
                                <textarea id="boardContent" name="content" class="w100p" style="height: 300px; resize: none; padding: 10px;" placeholder="내용을 입력하세요."></textarea>
                            </td>
                        </tr>

                        <tr id="trFile1" class="trFile" style="display: none;">
                            <th scope="row">첨부파일</th>
                            <td colspan="3">
                                <div id="fileUploadArea1"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>

            <div class="btn_area center">
                <button type="button" id="btnSave" class="btn blue">저장</button>
                <button type="button" id="btnList" class="btn gray">목록</button>
            </div>
        </div>
    </div>
</section>