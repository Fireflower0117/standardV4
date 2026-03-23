<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<style>
    /* 공통 탭 및 폼 스타일 */
    .tab_menu { display: flex; list-style: none; padding: 0; margin-bottom: 20px; border-bottom: 2px solid #0056b3; }
    .tab_menu li { padding: 12px 25px; cursor: pointer; border: 1px solid #ddd; border-bottom: none; background: #f4f6f9; margin-right: 5px; border-radius: 8px 8px 0 0; font-weight: 500; color: #555; }
    .tab_menu li.active { background: #0056b3; color: #fff; font-weight: bold; border-color: #0056b3; }
    .tab_content { display: none; padding: 20px; border: 1px solid #ddd; border-top: none; background: #fff; border-radius: 0 0 8px 8px; }
    .tab_content.active { display: block; }

    .search_area { background: #eef2f5; padding: 20px; margin-bottom: 20px; border-radius: 8px; border: 1px solid #dce3eb; }
    .section_tit { margin: 30px 0 10px; font-size: 16px; font-weight: bold; color: #333; display: flex; align-items: center; justify-content: space-between; gap: 8px; }
    .section_tit:first-child { margin-top: 0; }
    .section_tit .tit_text::before { content: ''; display: inline-block; width: 4px; height: 16px; background: #0056b3; margin-right: 8px; vertical-align: text-bottom;}

    /* 그리드(리스트) 내 콤퍼넌트 스타일링 */
    .data_tbl.list th, .data_tbl.list td { text-align: center; vertical-align: middle; padding: 8px 5px; }
    .data_tbl.list td.text-left { text-align: left; }
    .data_tbl.list input[type="text"],
    .data_tbl.list input[type="date"],
    .data_tbl.list select { width: 100%; box-sizing: border-box; }
    .grid-radio-group { display: flex; justify-content: center; gap: 10px; }
</style>

<script>
    $(document).ready(function(){


          /*****************************************************************************
         *****************          페이지  기본값 세팅 (상단 공통 )         ***************
         *****************************************************************************/

         /***  페이지 내부 공용 변수   ***/
         let toDay         = on.date.getDate({});  // 오늘
         let rangeFromYmd  = on.date.getDate({dateFormat : "YYYY"}); // 올해
         let rangeToYmd    = on.date.dateCalc({strBaseDate : rangeFromYmd , diffDiv : "Y" , DiffVal : +5 ,  dateFormat : "YYYY" }); // 올해 +5년
         let insptRangeArr = on.html.getYearArrayList({beginYear  : rangeFromYmd , finishYear : rangeToYmd });  //Array[올해 + (+5년) ]
         let insptRangeSelOptionsArr = insptRangeArr.map(year => {
                                            return { code: String(year)
                                                   , text: String(year)
                                            };
                                       });



         // 무선국 분류
         on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#schStationDiv" }
                                      , addOption     : [{ position: "top", txt: "전체", val: "all" }]  // 옵션 항목추가(옵션)
                                      , optionValInfo : { optId: "code", optTxt: "text" }
                                      , dataInfo      : [ { code: "BASE"  , text:"기지국" }        // 수동 코드 적용
                                                       , { code: "MOBILE", text:"이동국" }
                                                       ]
         });

         // 검사일자
         on.html.setDatePicker({ targets : ["#inspctDt"], dateFormat : "yy.mm.dd" });
         on.html.setEleVal({ele : "#inspctDt" , val : toDay   });


         /*****************************************************************************
         *********************          페이지  기본값 세팅         **********************
         *****************************************************************************/

         /***********************************                               상단헤더(공통)           ****************************************/
         // 무선국분류
         on.html.dynaGenSelectOptions({ targetInfo   : { targetId : "#schStationDiv" }
                                      , addOption     : [{ position: "top", txt: "전체", val: "" }]  // 옵션 항목추가(옵션)
                                      , optionValInfo : { optId: "code", optTxt: "text" }
                                      , dataInfo      : [ { code: "BASE" , text:"기지국" }        // 수동 코드 적용
                                                        , { code: "MOBILE" , text:"이동국" }
                                                        ]
         });

         /***********************************                               1. 기본 및 종합정보           ****************************************/
         // 검사신청일(datePicker)
         on.html.setDatePicker({ targets : ["#inspctReqDt"], dateFormat : "yy.mm.dd" });
         on.html.setEleVal({ele : "#inspctReqDt" , val : toDay   });

         // 검사종류
         let inspctCondiList = [ { code: "REG" , text:"정기검사" }        // 수동 코드 적용
                               , { code: "SPE" , text:"수시검사" }
                               , { code: "NEW" , text:"준공검사" }
                               ]
         on.html.dynaGenSelectOptions({ targetInfo     : { targetId : "#inspectType" }
                                    //, addOption     : [{ position: "top", txt: "전체", val: "" }]  // 옵션 항목추가(옵션)
                                      , optionValInfo : { optId: "code", optTxt: "text" }
                                      , dataInfo      : inspctCondiList
         });

         // 종합평가 판정
         on.html.dynaGenRadio({ targetInfo    : { targetId : "#evalResultArea"  }
                              , targetProp    : { eleId  : "idTotalEvalResult"    , eleNm :"totalEvalResult" }
                              , optionWrapper : { useYn    : "Y"  , tagName   : "label"} // input radio  옵션을 감쌀(wrapper) 앨리먼트이다. (옵션이다. 필수입력값아님.)
                              , optionValInfo : { optId    : "code"   , optTxt : "text" , defaultVal : "PASS" }
                              , dataInfo      : [ { code: "PASS" , text:"합격"       }  // 수동 코드 적용
                                                , { code: "FAIL" , text:"불합격"     }
                                                , { code: "PART" , text:"조건부 합격" }
                                                ]
                           });

         // 종합의견
         CKEDITOR.replace("totalRmk",{height : 200, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>'+'/external/ckeditor/contents.css'});

         // 과거 심의 및 검사이력 목록
         let tblInspctHistListObj = {
                     dispTarget : "#tblInsptHist tbody"   // 동적 타겟팅 (예: #tab01의 tbody)
                   , dispDiv    : "tab01_columns"  // 동적 컬럼 매핑 (예: tab01_columns)
                   , resource   : on.xhr.ajax({ sql : "on.standard.board.sampleboard.complexInspHistList" , data : {"key1" : "1"} , addCondi : "addCondi" })        // SQL조회 조건 정보 포함 전달(다유형 입력조건 Test)
                   , displayColInfos : {
                        tab01_columns : [ {id: "chkHist"       , colType: "checkbox"}
                                        , {id: "hisYear"       , colType: "select"
                                                               , optionValInfo: {optId: "code", optTxt: "text"}
                                                               , dataInfo: insptRangeSelOptionsArr
                                          }
                                        , {id: "hisType"       , colType: "select"
                                                               , optionValInfo: {optId: "code", optTxt: "text"}
                                                               , dataInfo: inspctCondiList
                                          }
                                        , {id: "histSummary"   , colType: "text"}
                                        , {id: "hisInspector"  , colType: "td" }
                                        ]
                }
         };
         on.html.tableDisplay(tblInspctHistListObj);

         // 기본서류 파일 첨부 형태
         on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#inspBaseFileTypeSelect" }
                                      , addOption     : [{  val: "ALL", txt: "전체 (문서+이미지)" , position: "top"}]
                                      , optionValInfo : { optId: "code", optTxt: "text" }
                                      , dataInfo      : [{code : "DOC" , text : "일반 문서 (hwp, pdf 등)"}
                                                        ,{code : "IMG" , text : "이미지 파일 (jpg, png 등)"}]
         });

         // 기본서류 파일 첨부 형태 옵션 변경 (파일 첨부 형태 변경)
         $("#inspBaseFileTypeSelect").on("change", function(evt) {
            var fileOptionVal = $(evt.target).val();
            if (fileOptionVal === "DOC") {
                on.file.changeMimeType({
                    displayTarget : "#baseDocumentFilesArea",
                    newMimetypes  : ["doc", "docx", "hwp", "xls", "xlsx", "pdf"],
                    newMaxFileCnt : 5,   newMaxFileSize: 30
                });
            } else if (fileOptionVal === "IMG") {
                on.file.changeMimeType({
                    displayTarget : "#baseDocumentFilesArea",
                    newMimetypes  : ["jpg", "jpeg", "png", "gif", "bmp"],
                    newMaxFileCnt : 10,  newMaxFileSize: 5
                });
            } else {
                on.file.changeMimeType({
                    displayTarget : "#baseDocumentFilesArea",
                    newMimetypes  : ["doc", "docx", "hwp", "xls", "xlsx", "pdf", "jpg", "jpeg", "png", "gif", "bmp"],
                    newMaxFileCnt : 5,   newMaxFileSize: 30
                });
            }

            // 파일 초기화 알림
            on.msg.showMsg({ message: "파일 첨부 기준이 변경되어 기존 목록이 초기화되었습니다." });
         });


         // 기본 서류 첨부 (파일 업로드 영역설정)
         on.file.setFileList({ displayTarget : "#baseDocumentFilesArea", atchFileIdNm : "baseDocumentFilesId", maxFileCnt : 5 , maxFileSize : 30  });


         /***********************************                               2. 검사 및 장치정보           ****************************************/
         let useYnOptionArr = [{code : "Y" , text : "일치" }
                              ,{code : "N" , text : "불일치" }
                              ];

         let devTypeCdArr   = [{code : "TX" , text : "송신기" }
                              ,{code : "RX" , text : "수신기" }
                              ,{code : "TRX" , text : "송수신기" }
                              ];
         let devStatusCdArr = [{code : "Y" , text : "양호" }
                              ,{code : "N" , text : "불량" }
                              ]


         // 대조검사 내역 > 기기제원 일치여부
         on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#specMatchYn" }
                                      , optionValInfo : { optId: "code", optTxt: "text" }
                                      , dataInfo      : useYnOptionArr
         });

          // 대조검사 내역 > 안테나 계통 일치여부
         on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#antMatchYn" }
                                      , optionValInfo : { optId: "code", optTxt: "text" }
                                      , dataInfo      : useYnOptionArr
         });

         // 주사용 전압
         on.html.dynaGenRadio({ targetInfo    : { targetId : "#rdoMainUseBoltArea"  }
                              , targetProp    : { eleId  : "rdoMainUseBolt"    , eleNm :"mainUseBolt" }
                              , optionWrapper : { useYn    : "Y"  , tagName   : "label"} // input radio  옵션을 감쌀(wrapper) 앨리먼트이다. (옵션이다. 필수입력값아님.)
                              , optionValInfo : { optId    : "code"   , optTxt : "text" , defaultVal : "220" }
                              , dataInfo      : [ { code: "220" , text:"AC 220V"       }  // 수동 코드 적용 => (SQL SelectList 형태 규격과 동일 = on.xhr.ajax({cmd:"selectList"})) 사용가능(cmd default : selectList)
                                                , { code: "380" , text:"AC 380V"     }
                                                , { code: "DC"  , text:"DC 전원" }
                                                ]
         });

         // 측정장비 교정일자
         on.html.setDatePicker({ targets : ["#inspEquipCngDt"], dateFormat : "yy.mm.dd" });
         on.html.setEleVal({ele : "#inspEquipCngDt" , val : toDay   });


         // 장치 세부 정보 및 성능 검사 결과
         let tblEquipInsptDetListObj = {
                     dispTarget : "#tblDeviceDetInfoList > tbody"   // 동적 타겟팅
                   , dispDiv    : "tab01_columns"         // 동적 컬럼 매핑 (예: tab01_columns)
                   , resource   : on.xhr.ajax({ sql : "on.standard.board.sampleboard.complexEquipInspDetList" })        // SQL조회 조건 정보 포함 전달(다유형 입력조건 Test)
                   , displayColInfos : {
                        tab01_columns : [ {id: "chkDevice"     , colType: "checkbox" , data_id1 : "devId" , data_id2:"devModelNm"}
                                        , {id: "devType"       , colType: "select"
                                                               , optionValInfo: {optId: "code", optTxt: "text"}
                                                               , dataInfo: devTypeCdArr
                                          }
                                        , {id: "devModelNm"    , colType: "text" }
                                        , {id: "devSerialNo"   , colType: "text"}
                                        , {id: "devInstallDt"  , colType: "datePicker" }
                                        , {id: "devStatus"     , colType: "radio"
                                                               , optionValInfo: {optId: "code", optTxt: "text"}
                                                               , dataInfo: devStatusCdArr
                                          }
                                        , {id:"btnDeviceDel"   , colType: "button" , btnText : "삭제" , data_id1 : "devId" , classNm : "btn gray sml btn-del-row"  }
                                        ]
                }
         };
         on.html.tableDisplay(tblEquipInsptDetListObj);

        // 장비 추가
        $("#btnAddDevice").on("click", () => {
            let tblEquipAddListObj = {
                  dispTarget : "#tblDeviceDetInfoList > tbody"
               ,  resource : {}     // 신규행이더라도 tableRow(tr)값을 기본으로 넣을 수 있다.  => ex) resource: { "devId": "NEW_DEV" })
               ,  addColumns : [
                     { id: "chkDevice", colType: "checkbox" }  // data prop를 추가 안함으로 신규추가 행(row)임을 알수있다.
                   , { id: "devType"  , colType: "select"
                                      , optionValInfo: { optId: "code", optTxt: "text" }
                                      , dataInfo: devTypeCdArr  // 상단에 정의한 배열 재사용
                     }
                   ,{ id: "devModelNm"   , colType: "text", placeholder: "모델명 입력" }
                   ,{ id: "devSerialNo"  , colType: "text", placeholder: "시리얼 입력" }
                   ,{ id: "devInstallDt" , colType: "datePicker" }
                   ,{ id: "devStatus"    , colType: "radio"
                                         , optionValInfo: { optId: "code", optTxt: "text" }
                                         , dataInfo: devStatusCdArr // 상단에 정의한 배열 재사용
                    }
                   ,{ id: "btnDeviceDel", colType: "button", btnText: "삭제", data_id1: "devId", classNm: "btn gray sml btn-del-row" }
                ]
            };
            on.html.tableAddRow(tblEquipAddListObj);
        });

        // 장비 행 전체삭제(체크박스 선택삭제)
        let delDeviceArr = [];
        $("#btnChkAllDelDevice").on("click" , () =>{
            on.html.tableChkbxDelRow({
                  targetTable : "#tblDeviceDetInfoList > tbody" // 삭제대상 테이블 (그리드)
                , chkNm      : "chkDevice"           // 체크박스 id, name 등 (selector)
                , delArr     : delDeviceArr          // 외부 삭제기록(arr)을 추가함으로 기존에 삭제했던 device정보까지 누적해서 담을수있다. (1회용으로 삭제하고 말거면 굳이  delArr 속성을 넘기지 않아도 된다.  재사용으로 삭제 정보를 누적시킴 )
                , callbackFn : function(delCnt , delArr) {  //  (DB에서 가져온 Data는  data-prop key, value가 같다.  data-prop가 없으면 무시된다. // callBack
                        on.msg.showMsg({message : delCnt + "개 삭제 완료!"})
                        delDeviceArr = delArr;
                 }
            });
        });



         /***********************************                               3. 확인 및 부가정보           ****************************************/
         let opCertTypeOptionList = [{safeCode: "C1" , safeCdText:"전파전자통신기사"}
                                    ,{safeCode: "C2" , safeCdText:"무선설비기능사"}]


         // 기타환경및 특기사항 >> 전자파 측정대상
         on.html.dynaGenRadio({ targetInfo    : { targetId : "#emfTargetYnArea"  }
                              , targetProp    : { eleId  : "rdoEmfTargetYn"    , eleNm :"emfTargetYn" }
                              , optionWrapper : { useYn    : "Y"  , tagName   : "label"} // input radio  옵션을 감쌀(wrapper) 앨리먼트이다. (옵션이다. 필수입력값아님.)
                              , optionValInfo : { optId    : "code"   , optTxt : "text" , defaultVal : "Y" }
                              , dataInfo      : [ { code: "Y" , text:"대상"       }  // 수동 코드 적용 => (SQL SelectList 형태 규격과 동일 = on.xhr.ajax({cmd:"selectList"})) 사용가능(cmd default : selectList)
                                                , { code: "N" , text:"비대상"     }
                                                ]
         });

         // 기타환경및 특기사항 >>  안전시설 (radio 그룹과 유사한 체크박스 일괄생성)
         on.html.dynaGenCheckboxes({ targetInfo    : { targetId : "#safeFacilityArea"  }
                                   , targetProp    : { eleId : "safeFacility", eleNm :"safeFacility", style : "cursor:pointer;", classNm : "chk-sml" }
                                   , optionWrapper : { useYn : "Y", tagName : "label", style : "margin-right:15px;", classNm : "wrap-chk" }
                                   , optionValInfo : { optId : "code", optTxt : "text"  }
                                   , dataInfo      : [ { code: "chkFence", text: "보호펜스"    , checkYN : "Y" , data_option1: "001" }
                                                     , { code: "chkSign" , text: "경고표지판"                  , data_option1: "002" }
                                                     , { code: "chkCctv" , text: "CCTV"      , checkYN : "Y" , data_option1: "003" }
                                                    ]
         });

        // 기타환경및 특기사항 >>  특기사항
        CKEDITOR.replace("addNote",{height : 200, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>'+'/external/ckeditor/contents.css'});

         // 무선 종사자 및 안전관리자 현황
         let tblSafeAdminListObj = {
                     dispTarget : "#tblSafeAdminList > tbody"   // 동적 타겟팅
                   , dispDiv    : "tab01_columns"         // 동적 컬럼 매핑 (예: tab01_columns)
                   , resource   : on.xhr.ajax({ sql : "on.standard.board.sampleboard.complexSafeAdminList" })        // SQL조회 조건 정보 포함 전달(다유형 입력조건 Test)
                   , displayColInfos : {
                        tab01_columns : [ {id: "chkSafeUserId" , colType: "checkbox" , data_id1 : "opId"}
                                        , {id: "opNm"          , colType: "text" }
                                        , {id: "opAppointDt"   , colType: "datePicker" }
                                        , {id: "opCertType"    , colType: "select"
                                                               , optionValInfo: {optId: "safeCode", optTxt: "safeCdText"}
                                                               , dataInfo: opCertTypeOptionList
                                          }
                                        , {id: "opCertNo"      , colType: "text"}
                                      //, {id: "safeCertFile"  , colType: "file", align: "left"  }
                                        , {id: "safeCertFile"  , colType: "text", align: "left"  }
                                        ]
                }
         };
         on.html.tableDisplay(tblSafeAdminListObj);

         // 추가 증빙 서류 및 사진 >> 1.현장 안전시설및 전경사진
         on.file.setFileList({ displayTarget : "#fileSafetyImgArea", atchFileIdNm : "fileSafetyImgId", maxFileCnt : 7 , maxFileSize : 40 , mimetype : ["jpg","jpeg","png","bmp"] });

         // 추가 증빙 서류 및 사진 >> 2.전자파강도 / 성능측정결과서
         on.file.setFileList({ displayTarget : "#fileMeasureDocArea", atchFileIdNm : "fileMeasureDocId", maxFileCnt : 5 , maxFileSize : 30 , mimetype : ["hwp","doc","pdf"] });



        /*****************************************************************************
         *********************       공통   콤퍼넌트 이벤트          **********************
         *****************************************************************************/

        //  탭 전환 이벤트
        $(".tab_menu li").on("click", function() {
            var targetId = $(this).data("target");
            $(".tab_menu li").removeClass("active");
            $(this).addClass("active");
            $(".tab_content").removeClass("active");
            $("#" + targetId).addClass("active");
        });

        //  그리드 전체 체크박스 이벤트 (공통)
        $(document).on("click", ".chk-all", function() {
           let targetName = $(this).data("target-name");
           let isChecked = $(this).is(":checked");
           $("input[name^='" + targetName + "']").prop("checked", isChecked);
        });

        $(document).on("click", "input[type='checkbox']", function() {
            let targetName = $(this).attr("name");
            let $headerChk = $(".chk-all[data-target-name='" + targetName + "']");

            if ($headerChk.length > 0) {
                let totalCnt = $("input[name='" + targetName + "']").length;            // 전체 개별 체크박스 개수
                let checkedCnt = $("input[name='" + targetName + "']:checked").length;  // 체크된 개별 체크박스 개수
                $headerChk.prop("checked", totalCnt === checkedCnt);
            }
        });

         // 그리드 행 삭제 공통 이벤트
        $(document).on("click", ".btn-del-row", () => {
            $(this).closest("tr").remove();
        });



         /*****************************************************************************
         *******************           저장/수정관련 이벤트          *********************
         *****************************************************************************/
        //   저장  기능  : 모든탭을 form id 하나로 설정하는경우
        $("#btnSaveReport").on("click", function() {


            // 입력폼 유효성 검증 (권역, 경력레벨 추가)
             let validateOptions = {
                 formId       : "#inspectionReportForm",
                 validateList : [
                    // 1. 기본 및 종합정보 입력 유효성 검증
                     { name : "stationNm"       , label : "무선국명"      , rule: {"required":true} }
                   , { name : "permitNo"        , label : "허가번호"      , rule: {"required":true, numberOnly:true } }
                   , { name : "inspctReqDt"     , label : "검사신청일"    , rule: {"required":true} }
                   , { name : "inspectType"     , label : "검사 종류"     , rule: {"required":true} }
                   , { name : "totalEvalResult" , label : "종합 평가 판정" , rule: {"required":true} }
                   , { name : "totalRmk" , label : "종합 의견" , rule: {"required":true} }
                   , { name : "baseDocumentFilesArea" , label : "기본서류첨부" , rule: {"fileRequired":"baseDocumentFilesId"} }

                   // 2. 검사 및 장치정보
                   , { name : "specMatchYn" , label : "기기제원 일치여부"    , rule: {"required":true}}
                   , { name : "antMatchYn"  , label : "안테나 계통 일치여부"  , rule: {"required":true}}
                   , { name : "mainUseBolt" , label : "주 사용전압"         , rule: {"required":true}}
                   , { name : "inspEquipCngDt" , label : "측정장비 교정일자" , rule: {"required":true}}


                   // 3. 확인 및 부가정보
                   , { name : "emfTargetYn" , label : "기기제원 일치여부"    , rule: {"required":true}}
                   , { name : "safeFacility" , label : "안전 시설"    , rule: {"required":true}}
                   , { name : "addNote" , label : "특기사항"    , rule: {"required":true}}
                   , { name : "fileSafetyImgArea" , label : "현장 안전시설 및 전경사진"    ,  rule: {"fileRequired":"baseDocumentFilesId"}}
                   , { name : "fileMeasureDocArea" , label : "전자파강도/성능측정 결과서"    ,  rule: {"fileRequired":"baseDocumentFilesId"}}

                 ]
             };

           //  let isValid = on.valid.formValidationCheck(validateOptions);
           //  if(!isValid) return;  // Data입력 유효성 검증

           on.file.fileFormSubmit({ procType  : "insert" , formIdArr : ["#inspectionReportForm"] // form 여러개 올수있음. (form내부 FileUpload영역 atchFileIdNm 속성값 중복 주의 )
                                 , successFn : function(rs){

                                      let saveData = { basicVo: {}, inspctVo: {}, confirmVo: {} };

                                      // serializeArray() 결과를 순회하며 일반 Object({ key: value }) 형태로 변환
                                      let tempFormData = {};
                                      $.each($("#inspectionReportForm").serializeArray(), function() {
                                        tempFormData[this.name] = this.value;
                                      });

                                     /***************************                          상단페서 공통                         ***************************/
                                     saveData.inspReportSerno         = tempFormData.inspReportSerno;   // 접수번호
                                     saveData.schStationDiv           = tempFormData.schStationDiv;     // 무선국 분류
                                     saveData.inspctDt                = tempFormData.inspctDt;          // 검사일자
                                     /***************************                          1. 기본 및 종합정보                          ***************************/

                                     saveData.basicVo.stationNm       = tempFormData.stationNm;                                          // 1. 기본 및 종합정보 > 무선국명
                                     saveData.basicVo.permitNo        = tempFormData.permitNo;                                           // 1. 기본 및 종합정보 > 허가번호
                                     saveData.basicVo.inspctReqDt     = tempFormData.inspctReqDt;                                        // 1. 기본 및 종합정보 > 검사신청일
                                     saveData.basicVo.inspectType     = tempFormData.inspectType;                                        // 1. 기본 및 종합정보 > 검사종류
                                     saveData.basicVo.totalEvalResult = tempFormData.totalEvalResult;                                    // 1. 기본 및 종합정보 > 종합평가 판정
                                     $('#totalRmk').val(CKEDITOR.instances.totalRmk.getData());
                                     saveData.basicVo.totalRmk        = CKEDITOR.instances.totalRmk.getData();                           // 1. 기본 및 종합정보 > 종합의견
                                     saveData.basicVo.insptHistList   = on.html.tableData2Array({targetId : "#tblInsptHist" });          // 1. 기본 및 종합정보 > 과거 심의 및 검사이력목록
                                     saveData.basicVo.baseDocFilesId  = rs.baseDocumentFilesId;                                          // 1. 기본 및 종합정보 > 기본서류 첨부

                                      /***************************                          2. 검사 및 장치정보                          ***************************/
                                     saveData.inspctVo.specMatchYn     = tempFormData.specMatchYn;                                       // 2.검사 및 장치정보 > 기기제원 일치여부
                                     saveData.inspctVo.antMatchYn      = tempFormData.antMatchYn;                                        // 2.검사 및 장치정보 > 안테나 계통 일치여부
                                     saveData.inspctVo.mainUseBolt     = tempFormData.mainUseBolt;                                       // 2.검사 및 장치정보 > 주사용 전압
                                     saveData.inspctVo.inspEquipCngDt  = tempFormData.inspEquipCngDt;                                    // 2.검사 및 장치정보 > 측정장비 교정일자
                                     saveData.inspctVo.detDeviceList   = on.html.tableData2Array({targetId : "#tblDeviceDetInfoList" }); // 2.검사 및 장치정보 > 장치세부 정보 성능검사 결과(그리드)


                                      /***************************                          3. 확인 및 부가정보                          ***************************/
                                      saveData.confirmVo.emfTargetYn  = tempFormData.emfTargetYn;                                        // 3. 확인 및 부가정보 > 전자파 측정대상
                                      saveData.confirmVo.chkFence     = tempFormData.chkFence;                                           // 3. 확인 및 부가정보 > 안전시설 > 보호펜스
                                      saveData.confirmVo.chkSign      = tempFormData.chkSign;                                            // 3. 확인 및 부가정보 > 안전시설 > 경고표지판
                                      saveData.confirmVo.chkCctv      = tempFormData.chkCctv;                                            // 3. 확인 및 부가정보 > 안전시설 > CCTV
                                      $('#addNote').val(CKEDITOR.instances.addNote.getData());
                                      saveData.confirmVo.addNote          = CKEDITOR.instances.addNote.getData();                         // 3. 확인 및 부가정보 > 특기사항
                                      saveData.confirmVo.safeAdminList    = on.html.tableData2Array({targetId : "#tblSafeAdminList" });   // 3. 확인 및 부가정보 > 무선 종사자 안전관리자 현황
                                      saveData.confirmVo.fileSafetyImgId  = rs.fileSafetyImgId;                                           // 3. 확인 및 부가정보 > 추가증빙서류 및 사진 >> 현장안전시설 및 전경사진 (파일그룹ID)
                                      saveData.confirmVo.fileMeasureDocId = rs.fileMeasureDocId;                                          // 3. 확인 및 부가정보 > 추가증빙서류 및 사진 >> 전자파강도/성능측정 결과서 (파일그룹ID)


                                      on.xhr.ajax({ url : "/ma/example/insertInspctReportInfo.do"
                                                 , data: saveData
                                                 , contentType: "application/json;charset=UTF-8"
                                                 , successFn : (rs) =>{
                                                       if(rs.resultCode === "SUCCESS"){
                                                           on.msg.showMsg({ message : rs.message});
                                                       }
                                                   }
                                                 , failFn : (cause , err , obj) =>{

                                                  }
                                      });
                                 }
          });



        });





    });
</script>

<div class="wrap" style="padding: 20px;">
    <h3 data-aos="fade-up">무선국 검사보고서 통합 관리 (복합 입력 그리드형)</h3>
    <form id="inspectionReportForm" name="inspectionReportForm">
        <div class="search_area" data-aos="fade-up">
            <table class="data_tbl form">
                <colgroup>
                    <col style="width: 10%;">
                    <col style="width: 23%;">
                    <col style="width: 10%;">
                    <col style="width: 23%;">
                    <col style="width: 10%;">
                    <col style="width: 24%;">
                </colgroup>
                <tbody>
                    <tr>
                        <th>접수 번호</th>
                        <td><div style="display: flex; gap: 5px;"><input type="text" id="inspReportSerno" name="inspReportSerno" placeholder="접수번호"><button type="button" class="btn gray sml">조회</button></div></td>
                        <th>무선국 분류</th>
                        <td><select id="schStationDiv" name="schStationDiv"></select></td>
                        <th>검사 일자</th>
                        <td>
                            <span class="calendar_input">
                                <input id="inspctDt" name="inspctDt" class="w120" type="text" autocomplete="off" />
                            </span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <ul class="tab_menu">
            <li class="active" data-target="tab_basic">1. 기본 및 종합정보</li>
            <li data-target="tab_inspect">2. 검사 및 장치정보</li>
            <li data-target="tab_addition">3. 확인 및 부가정보</li>
        </ul>



        <!-- input type="hidden" id="rcvNo" name="rcvNo" value="RCV-2026-03001" -->
        <div id="tab_basic" class="tab_content active">
            <div class="section_tit"><span class="tit_text">무선국 및 검사 기본 정보 (개별 속성 폼)</span></div>
            <table class="data_tbl form">
                <colgroup><col style="width: 15%;"><col style="width: 35%;"><col style="width: 15%;"><col style="width: 35%;"></colgroup>
                <tbody>
                    <tr>
                        <th>무선국명 / 허가번호 (Text)</th>
                        <td>
                            <div style="display: flex; gap: 5px;">
                                <input type="text" name="stationNm" placeholder="무선국명" style="width: 50%;">
                                <input type="text" name="permitNo" placeholder="허가번호" class="numOnly" style="width: 50%;">
                            </div>
                        </td>
                        <th>검사 신청일 (Date)</th>
                        <td>
                            <span class="calendar_input">
                                <input id="inspctReqDt" name="inspctReqDt" class="w120" type="text" autocomplete="off" />
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>검사 종류 (Select)</th>
                        <td><select id="inspectType" name="inspectType"></select></td>
                        <th>종합 평가 판정 (Radio)</th>
                        <td id="evalResultArea"></td>
                    </tr>
                    <tr>
                        <th>종합 의견 (Textarea)</th>
                        <td colspan="3"><textarea id="totalRmk" name="totalRmk" rows="3" style="width: 100%;"></textarea></td>
                    </tr>
                </tbody>
            </table>
            <div class="section_tit">
                <span class="tit_text">과거 심의 및 검사 이력 목록 (그리드)</span>
                <div><button type="button" class="btn gray sml">선택 삭제</button></div>
            </div>
            <table class="data_tbl list" id="tblInsptHist">
                <colgroup>
                    <col style="width: 5%;">
                    <col style="width: 15%;">
                    <col style="width: 20%;">
                    <col style="width: 45%;">
                    <col style="width: 15%;">
                </colgroup>
                <thead>
                    <tr>
                        <th><input type="checkbox"  class="chk-all"  data-target-name="chkHist"></th>
                        <th>검사 연도 (Input)</th>
                        <th>검사 종류 (Select)</th>
                        <th>검사 결과 요약 (Input)</th>
                        <th>담당 검사관 (Input)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="section_tit">
                <div style="display: flex; align-items: center; gap: 15px;">
                    <span class="tit_text">기본 서류 첨부</span>

                    <div style="display: inline-flex; align-items: center; gap: 8px; font-size: 13px; font-weight: normal;">
                        <label for="docTypeSelect" style="color: #555;">서류형태</label>
                        <select id="inspBaseFileTypeSelect" style="width: 200px; padding: 4px; border: 1px solid #ccc; border-radius: 4px;"></select>
                    </div>
                </div>
            </div>
            <table class="data_tbl list">
                <colgroup><col style="width: 20%;"><col style="width: 80%;"></colgroup>
                <tbody>
                    <tr>
                        <th>무선국 허가증 사본</th>
                        <td class="text-left" id="baseDocumentFilesArea"></td>
                    </tr>
                </tbody>
            </table>
        </div>




        <div id="tab_inspect" class="tab_content">
            <div class="section_tit"><span class="tit_text">대조 검사 내역 (개별 속성 폼)</span></div>
            <table class="data_tbl form">
                <colgroup><col style="width: 20%;"><col style="width: 30%;"><col style="width: 20%;"><col style="width: 30%;"></colgroup>
                <tbody>
                    <tr>
                        <th>기기 제원 일치여부 (Select)</th>
                        <td>
                            <select id="specMatchYn" name="specMatchYn"></select>
                        </td>
                        <th>안테나 계통 일치여부 (Select)</th>
                        <td>
                            <select id="antMatchYn" name="antMatchYn"></select>
                        </td>
                    </tr>
                    <tr>
                        <th>주 사용전압 (Radio)</th>
                        <td id="rdoMainUseBoltArea"></td>
                        <th>측정 장비 교정일자 (Date)</th>
                        <td>
                             <span class="calendar_input">
                                <input id="inspEquipCngDt" name="inspEquipCngDt" class="w120" type="text" autocomplete="off" />
                            </span>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="section_tit">
                <span class="tit_text">장치 세부 정보 및 성능검사 결과 (그리드)</span>
                <div>
                    <button type="button" id="btnAddDevice" class="btn blue sml">+ 행 추가</button>
                    <button type="button" id="btnChkAllDelDevice" class="btn gray sml">선택 삭제</button>
                </div>
            </div>
            <table class="data_tbl list" id="tblDeviceDetInfoList">
                <colgroup>
                    <col style="width: 4%;">
                    <col style="width: 12%;">
                    <col style="width: 20%;">
                    <col style="width: 20%;">
                    <col style="width: 15%;">
                    <col style="width: 18%;">
                    <col style="width: 11%;">
                </colgroup>
                <thead>
                    <tr>
                        <th><input type="checkbox" class="chk-all" data-target-name="chkDevice"></th>
                        <th>장치 구분 (Select)</th>
                        <th>모델명 (Input Text)</th>
                        <th>제조 번호 (Input Text)</th>
                        <th>설치 일자 (Datepicker)</th>
                        <th>성능 판정 (Radio)</th>
                        <th>관리 (Button)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>





        <div id="tab_addition" class="tab_content">
            <div class="section_tit"><span class="tit_text">기타 환경 및 특기 사항 (개별 속성 폼)</span></div>
            <table class="data_tbl form">
                <colgroup><col style="width: 20%;"><col style="width: 30%;"><col style="width: 20%;"><col style="width: 30%;"></colgroup>
                <tbody>
                    <tr>
                        <th>전자파 측정 대상 (Radio)</th>
                        <td id="emfTargetYnArea"></td>
                        <th>안전 시설 (Checkbox 다중선택)</th>
                        <td id="safeFacilityArea"></td>
                    </tr>
                    <tr>
                        <th>특기 사항 (Text)</th>
                        <td colspan="3">
                            <textarea id="addNote" name="addNote" rows="3" style="width: 100%;"></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="section_tit">
                <span class="tit_text">무선종사자 및 안전관리자 현황 (그리드 내 File 포함)</span>
                <div><button type="button" class="btn gray sml">종사자 조회</button></div>
            </div>
            <table class="data_tbl list" id="tblSafeAdminList">
                <colgroup>
                    <col style="width: 4%;">
                    <col style="width: 15%;">
                    <col style="width: 15%;">
                    <col style="width: 20%;">
                    <col style="width: 15%;">
                    <col style="width: 31%;">
                </colgroup>
                <thead>
                    <tr>
                        <th><input type="checkbox" class="chk-all" data-target-name="chkSafeUserId"></th>
                        <th>성명 (Input)</th>
                        <th>선임 일자 (Date)</th>
                        <th>자격 종목 (Select)</th>
                        <th>자격 번호 (Input)</th>
                        <th>자격증 사본 (File)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>

            <div class="section_tit" style="margin-top: 30px;"><span class="tit_text">추가 증빙 서류 및 사진 (2개)</span></div>
            <table class="data_tbl list">
                <colgroup><col style="width: 25%;"><col style="width: 75%;"></colgroup>
                <tbody>
                    <tr>
                        <th>1. 현장 안전시설 및 전경 사진</th>
                        <td class="text-left" id="fileSafetyImgArea"></td>
                    </tr>
                    <tr>
                        <th>2. 전자파강도/성능측정 결과서 (PDF)</th>
                        <td class="text-left" id="fileMeasureDocArea"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>


    <div class="btn_area right" style="margin-top: 30px; border-top: 1px solid #ddd; padding-top: 15px;">
        <button type="button" class="btn gray" id="btnList">목록으로</button>
        <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
        <button type="button" class="btn blue" id="btnSaveReport" style="min-width: 120px;"><i class="xi-save"></i>검사결과 저장</button>
        </c:if>
    </div>

</div>