<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
(function() {
    let globalBoardConfig = {}; // 게시판 설정 전역 변수

    $(document).ready(() => {
       /***************************************************************************
        ******************** 페이지 기본정보 조회 / 세팅       ********************
        ***************************************************************************/


        let menuFuncCd = '${param.menuFuncCd}';
        if(!on.valid.isEmpty(menuFuncCd)) {
             // 1. 게시판 메타(설정) 정보 가져오기
             on.xhr.ajax({ cmd : "selectOne", sql : "on.standard.system.boardtype.inqBoardTypeDetail"
                         , menuFuncCd : menuFuncCd
                         , successFn : function(rs){
                              globalBoardConfig = rs;
                              lfnInitBoardUI(rs); // UI 제어 함수 호출
                         }
             });
        } else {
             on.msg.showMsg({message: "잘못된 접근입니다. (게시판 코드 누락)"});
             history.back();
        }

        <%-- 첨부파일 등록폼 생성 --%>
		on.file.setFileList({ displayTarget : "#fileUploadArea1"  // 첨부파일 생성영역 (함수호출시 필수입력)
		                    , atchFileIdNm : "atchFileId"  // 파일 전체 저장후 파일그룹 ID  ==>>  on.file.fileFormSubmit(   successFn : function(rs){ rs.atchFileId 파일그룹ID  });
		                 // , mimetype      : ["pdf", "jpg", "png", "jpeg"]  // #fileUploadArea1 영역에 추가할수 있는 파일 형태 (Option) ==>> ex)  동영상 파일만 받고싶을때는  mimetype : ["mp4", "avi", "mov"]
		                    , maxFileCnt    : 5    // #fileUploadArea1 영역에 추가할수있는 최대 파일 갯수(Option)
		                    , maxFileSize   : 20   // #fileUploadArea1 영역에 추가할수있는 파일 전체 최대용량(Option)
		                    , tempcol1:"onF/WFileTest"  // 첨부파일의 부가정보1 저장 ( DB 임시칼럼1에 저장 ) Option
		                    , tempcol2:"FireFlower1"    // 첨부파일의 부가정보1 저장
                            });


       /***************************************************************************
        ******************** 동적 UI 제어 및 이벤트 바인딩     ********************
        ***************************************************************************/
        function lfnInitBoardUI(cfg) {
            let hasNti = (cfg.ntiYn === 'Y');
            let hasSecret = (cfg.secretYn === 'Y');

            // 공지 또는 비밀글 중 하나라도 사용하면 해당 행(TR) 노출
            if (hasNti || hasSecret) {
                $("#trOptions").show();
            }

            // [공지 여부] 설정
            if (hasNti) {
                $("#thNtiYn, #tdNtiYn").show(); // 해당 TH, TD 노출

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

            // [비밀글 여부] 설정
            if (hasSecret) {
                $("#thSecretYn, #tdSecretYn").show(); // 해당 TH, TD 노출

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

            // [첨부파일] 설정
            if (cfg.attchFileYn === 'Y') {
                $(".trFile").show();
            }

            // [내용 및 웹 에디터] 설정
            if (cfg.contentYn === 'Y') {
                $("#trContent").show(); // 내용 폼 노출
                if (cfg.contentEditorYn === 'Y') {
                    // 에디터 적용 Y일 때 CKEditor 로드
                    if(typeof CKEDITOR !== 'undefined') {
                        CKEDITOR.replace('boardContent', { height: 400 });
                    }
                }
                // 에디터 적용이 N이면 쌩 textarea를 그대로 쓰므로 별도 처리 필요 없음
            } else {
                $("#trContent").hide(); // 내용 폼 숨김
            }

        }

       /***************************************************************************
        ******************** 버튼 이벤트 (저장/목록)           ********************
        ***************************************************************************/

        // 1. 목록으로 이동
        $("#btnList").on("click", function() {
           goList();
        });

        // 저장(등록) 버튼 클릭
        $("#btnSave").on("click", function() {
            // 에디터 데이터 동기화 (유효성 검증 전에 가장 먼저 수행하여 값을 채움)
            if (globalBoardConfig.contentYn === 'Y' && globalBoardConfig.contentEditorYn === 'Y' && typeof CKEDITOR !== 'undefined') {
                $("#boardContent").val(CKEDITOR.instances.boardContent.getData());
            }

            //  기본 필수값 유효성 검증 대상 세팅
            let boardValidateList = [
                { name : "titl", label : "제목", rule: { "required": true } }
            ];

            //  조건에 따른 동적 유효성 검증 룰 추가
            // 내용 영역 사용 시
            if (globalBoardConfig.contentYn === 'Y') {
                boardValidateList.push({ name : "boardContent", label : "내용", rule: { "required": true } });
            }

            // 3-2. 공지글 설정 시 (시작일, 종료일 필수 체크)
            if ($("#ntiYn").is(":checked")) {
                boardValidateList.push({ name : "ntiStrtDt", label : "공지 시작일", rule: { "required": true } });
                boardValidateList.push({ name : "ntiEndDt",   label : "공지 종료일", rule: { "required": true } });
            }

            // 3-3. 비밀글 설정 시 (비밀번호 필수 체크 및 일치 검증)
            if ($("#scretYn").is(":checked")) {
                // 필수값 체크는 프레임워크에 위임
                boardValidateList.push({ name : "boardPswd", label : "비밀번호", rule: { "required": true } });

                // 비밀번호 확인(일치 여부)은 값 비교가 필요하므로 별도 체크
                let pswd1 = on.html.getEleVal({ele : "#boardPswd"});
                let pswd2 = on.html.getEleVal({ele : "#boardPswdConfirm"});

                if (pswd1 && pswd1 !== pswd2) {
                    on.msg.showMsg({message: "비밀번호가 일치하지 않습니다.\n다시 확인해주세요."});
                    $("#boardPswdConfirm").focus();
                    return;
                }
            }

            // 4. 등록 AJAX 호출
            on.file.fileFormSubmit({ formIdArr : ["#boardForm"],  procType: "insert"  // formIdArr : ["#boardForm","#boardForm2"]  // 여러개 폼내부 의 File Group 일괄 등록
                                   , successFn : function(rs){  // 일괄등록 결과 반환 (rs)

                                      let formDataArr = $("#boardForm").serializeArray();  // $("#boardForm, #boardForm2").serializeArray();
                                      if (rs && Object.keys(rs).length > 0) {
                                            Object.entries(rs).forEach(([key, val]) => {
                                                formDataArr.push({ name: key, value: val });
                                            });
                                      }
                                      on.xhr.ajax({ sid        : "insertBoardTran" // 비동기 콜백 식별용 ID 추가
                                                  , cmd        : "insert"
                                                  , sql        : "on.standard.board.comboard.mergeBoardInfo"
                                                  , validation : { formId: "#boardForm", validationList: boardValidateList } // 동적 조립된 검증 리스트 매핑
                                                  , data       : formDataArr
                                                  , menuFuncCd : menuFuncCd
                                                  , boardPswd  : $("#scretYn").is(":checked") ? on.html.getEleVal({ ele : "#boardPswd"}) : ""
                                                  , successFn  : function(sid, rs) { // 참고 소스처럼 sid 파라미터 받기
                                                    // rs 배열 처리 방식은 기존 로직 유지
                                                    if (rs[0] && rs[0].execResult === "success") {
                                                        on.msg.showMsg({message : "게시글이 정상적으로 등록되었습니다."});
                                                        goList(); // 목록으로 이동
                                                    } else {
                                                        on.msg.showMsg({message : "게시글 등록에 실패했습니다."});
                                                    }
                                                }
                                                , failFn: function(err) {
                                                    on.msg.showMsg({message : err.message});
                                                }
                                        });
                                   }

            });
        });

        function goList(){
             on.html.dynaGenHiddenForm({
                formDefine : { fid : "moveForm", action: "/ma/comboard/list.do", method: "post", isSubmit : true },
                formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                             , { name : "menuFuncCd"      , value: menuFuncCd }
                             , { name : "menuFuncDivCd"   , value : 'board' }
                              ]
             });
        }

    });
})();
</script>

<section class="content">
    <div class="wrap">
        <div class="tbl" data-aos="fade-up">
            <div class="board_top">
                <div class="board_left">
                     <!-- h3 data-aos="fade-up" id="pageTitle">등록</h3 -->
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
                        <!-- tr id="trFile2" class="trFile" style="display: none;">
                            <th scope="row">첨부파일</th>
                            <td colspan="3">
                                <div id="fileUploadArea2"></div>
                            </td>
                        </tr -->
                    </tbody>
                </table>
            </form>
            <!-- form id="boardForm2" name="boardForm2" onsubmit="return false;">
                <table class="board_write">
                    <colgroup>
                        <col class="w15p">
                        <col class="">
                        <col class="w15p">
                        <col class="">
                    </colgroup>
                    <tbody>
                        <tr id="trFile3" class="trFile" style="display: none;">
                            <th scope="row">첨부파일</th>
                            <td colspan="3">
                                <div id="fileUploadArea3"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form -->

            <div class="btn_area center">
                <button type="button" id="btnSave" class="btn blue">등록</button>
                <button type="button" id="btnList" class="btn gray">목록</button>
            </div>
        </div>
    </div>
</section>