<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
    .tab_menu { display: flex; list-style: none; border-bottom: 2px solid #333; padding-left: 0; margin-bottom: 20px; }
    .tab_menu > li { margin-right: 5px; }
    .tab_menu > li > a { display: block; padding: 10px 30px; background: #f1f1f1; color: #333; text-decoration: none; transition: background 0.2s ease; }
    .tab_menu > li.on > a { background: #333; color: #fff; font-weight: bold; }
</style>

<script>
    $(document).ready(function(){

           /*****************************************************************************
           *********************          검색조건 영역 세팅         **********************
           *****************************************************************************/
            // 조회기간 DatePicker적용
            let initRegDateConditions = function(){
                on.html.setDatePicker({ targets : ["#searchStDt" , "#searchEdDt"], dateFormat : "yy.mm.dd" });
                let toDay   = on.date.getDate({});
                let fromDay = on.date.dateCalc(toDay, "D" , -7 , "YYYY.MM.DD" );
                on.html.setEleVal({ele : "#searchStDt" , val : fromDay });
                on.html.setEleVal({ele : "#searchEdDt" , val : toDay   });
            }
            initRegDateConditions();

            // 공통코드 일괄조회 (서버 부하 경감, 1회 일괄조회)
            let comCodeRsltList = on.xhr.ajaxComCdList({
                                    condiList : [ {rsId : "rsCareerLevel", sqlCondi : { uppComCd : "CAREER_LEVEL" }}
                                                , {rsId : "rsRegionDivCd", sqlCondi : { uppComCd : "REGION_DIV_CD" }} ]
                                  });

            // 권역코드 (테스트용 공통코드)
            on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#searchCmnRegionCd" }
                                         , addOption     : [{ position: "top", txt: "전체", val: "all" }]
                                         , optionValInfo : { optId: "comCd", optTxt: "cdNm" }
                                         , dataInfo      : comCodeRsltList.rsRegionDivCd     // 일괄조회 SQL 적용
                                       //, dataInfo      : on.xhr.ajaxComCd({sqlCondi : { uppComCd : "REGION_DIV_CD"  } }) // 공통코드 개별 조회
            });

            // 상세검색 조건
            on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#searchKeyCd" }
                                         , addOption     : [{ position: "top", txt: "전체", val: "all" }]
                                         , optionValInfo : { optId: "code", optTxt: "text" }
                                         , dataInfo      : [ { code: "title", text:"제목" }        // 수동 코드 적용
                                                          , { code: "regUser", text:"등록자" }
                                                          ]
            });


            // 검색조건 설정
            let searchConditionObj = { cmd             : "selectPage"
                                     , sql             : "on.standard.board.sampleboard.inqTabGridList"
                                     , searchStDt      : on.html.getEleVal({ ele : "#searchStDt" })
                                     , searchEdDt      : on.html.getEleVal({ ele : "#searchEdDt" })
                                     , searchRegionCd  : on.html.getEleVal({ ele : "#searchCmnRegionCd" })
                                     , searchKeyCd     : on.html.getEleVal({ ele : "#searchKeyCd" })
                                     , searchKeyWord   : on.html.getEleVal({ ele : "#searchKeyWord" })
                                     , activeTabId     : "tab01"  // 페이지 Open시점에 기본적으로 선택할Tab (SQL조회 기준)
            };



          /*****************************************************************************
           *********************          페이지 내부 함수          **********************
           *****************************************************************************/
        // 데이터 조회
        function searchData() {

            if(on.valid.isEmpty(searchConditionObj.pageNo)){
                 searchConditionObj.pageNo = 1;
            }

            // activeTabId에 따라 SQL/ 표출대상테이블(dataDispTarget) , 표출대상페이징(pagingTarget) , 표출대상 칼럼(sqlDispDiv) 정리
            let currentTabId   = searchConditionObj.activeTabId;
            let dataDispTarget = "#" + currentTabId + " .board_list > tbody"; // SQL조회 결과 (resource)를 어느탭에 그리드에 Display할지 판단
            let pagingTarget   = "#" + currentTabId + " .paging";             // SQL조회 결과 (resource)를 어디탭에 Paging에 적용할지 판단
            let sqlDispDiv     = currentTabId + "_columns";                   // SQL조회 결과 그리드 항목을 지정 판단

            // 필요에따라 SQL분기 적용 (Optional)
            if(currentTabId === "tab01"){
                searchConditionObj.sql = "on.standard.board.sampleboard.inqTabGridList"; // ex) ~~.inqTab01GridList
            }
            else if(currentTabId === "tab02"){
                searchConditionObj.sql = "on.standard.board.sampleboard.inqTabGridList"; // ex) ~~.inqTab02GridList
            }
            else if(currentTabId === "tab03"){
                searchConditionObj.sql = "on.standard.board.sampleboard.inqTabGridList"; // ex) ~~.inqTab03GridList
            }
            else if(currentTabId === "tab04"){
                searchConditionObj.sql = "on.standard.board.sampleboard.inqTabGridList"; // ex) ~~.inqTab04GridList
            }
            else if(currentTabId === "tab05"){
                searchConditionObj.sql = "on.standard.board.sampleboard.inqTabGridList"; // ex) ~~.inqTab05GridList
            }

             // 데이터 조회
            const resource = on.xhr.ajax(searchConditionObj);

            // record 전체 개수(Row Count) 조회 (cmd가 selectPage 일떄.. )
            let totalCount = 0;
            if (resource.length > 0) {
                totalCount = resource[0].totalCount;
            }

            // 활성화된 탭의 전체 건수 갱신
            $("#" + currentTabId + " .all_num > .num").text(totalCount);

            var displayInfoObj = {
                     dispTarget : dataDispTarget  // 동적 타겟팅 (예: #tab01의 tbody)
                   , dispDiv    : sqlDispDiv      // 동적 컬럼 매핑 (예: tab01_columns)
                   , resource   : resource        // SQL조회 결과 Data
                   , paginginfo : { targetId : pagingTarget, btnFnName : fnPageBtnClick } // 페이징 처리 정보
                   , displayColInfos : {
                        // [탭 1] 수도권: 일반 텍스트, 버튼, 파일 아이콘 위주로 구성된 테이블 칼럼들
                        tab01_columns : [ {id: "rowindx"    , colType: "number", classNm: "number"}
                                        , {id: "branchNm"   , colType: "td"}
                                        , {id: "mgrNm"      , colType: "text"} // 인풋 박스 렌더링
                                        , {id: "fileExt"    , colType: "fileIcon"} // 확장자에 맞는 아이콘
                                        , {id: "detailBtn"  , colType: "button", btnText: "btnNm", classNm: "btn blue"}
                                        ]
                      , // [탭 2] 경인권: 셀렉트 박스, 라디오, 달력 위주로 구성된 테이블 칼럼들
                        tab02_columns : [ {id: "rowindx"    , colType: "number", classNm: "number"}
                                        , {id: "evalResult" , colType: "select"
                                                            , optionValInfo: {optId: "comCd", optTxt: "cdNm"}
                                                            , dataInfo: comCodeRsltList.rsRegionDivCd}
                                        , {id: "grade"      , colType: "radio"
                                                            , optionValInfo: {optId: "comCd", optTxt: "cdNm"}
                                                            , dataInfo: comCodeRsltList.rsCareerLevel}
                                        , {id: "regDate"    , colType: "datePicker", classNm: "date"}
                                        ]
                      , // [탭 3] 충남권: 체크박스, 숫자(금액) 콤마 표기로 구성된 테이블 칼럼들
                        tab03_columns : [ {id: "chk"         , colType: "checkbox", classNm: "Y"}
                                        , {id: "title"       , colType: "td"}
                                        , {id: "budgetAmount", colType: "double", pattern: "###,###,###.##"} // 1000단위 콤마
                                         ]
                        // [탭 4] 호남권: 숨김 필드(hidden), 파일 첨부 여부로 구성된 테이블 칼럼들
                      , tab04_columns : [ {id: "rowindx"   , colType: "number", classNm: "number"}
                                        , {id: "secretKey" , colType: "hidden"} // 화면엔 안 보이지만 data로는 존재
                                        , {id: "title"     , colType: "td"}
                                        , {id: "hasFileYn" , colType: "hasFile"} // 클립 아이콘 노출
                                        ]
                      , // [탭 5] 영남권: 종합 혼합형
                        tab05_columns : [ {id: "rowindx"   , colType: "number", classNm: "number"}
                                        , {id: "branchNm"  , colType: "td"}
                                        , {id: "evalResult", colType: "select"
                                                           , optionValInfo: {optId: "comCd", optTxt: "cdNm"}
                                                           , dataInfo: comCodeRsltList.rsRegionDivCd}
                                        , {id: "regDate"   , colType: "datePicker", classNm: "date"}
                                        , {id: "fileExt"   , colType: "fileIcon"}
                        ]
                }
            };
            on.html.tableDisplay(displayInfoObj);

            // 데이터 그릴 때마다 달력 이벤트 바인딩 호출은 프레임워크 내부에 있으니 생략
        }

        function fnPageBtnClick(pageNo) {
            searchConditionObj.pageNo = pageNo;
            searchData();
        }

        // 초기 화면 로드 데이터 조회
        searchData();

        /*****************************************************************************
         *********************           콤퍼넌트 이벤트          **********************
         *****************************************************************************/

        // 검색 버튼 클릭
        $("#btnSearch").on("click", () => {
            searchConditionObj.pageNo = 1;
            searchConditionObj.searchStDt     = on.html.getEleVal({ ele : "#searchStDt"    });
            searchConditionObj.searchEdDt     = on.html.getEleVal({ ele : "#searchEdDt"    });
            searchConditionObj.searchRegionCd = on.html.getEleVal({ ele : "#searchCmnRegionCd" });
            searchConditionObj.searchKeyCd    = on.html.getEleVal({ ele : "#searchKeyCd"   });
            searchConditionObj.searchKeyWord  = on.html.getEleVal({ ele : "#searchKeyWord" });
            searchData();
        });

         // 3. 탭 클릭 이벤트 (탭 변경 시 해당 탭에 맞는 그리드 재조회)
        $("#regionTabs > li > a").on("click", function(e) {
            e.preventDefault();
            $("#regionTabs > li").removeClass("on");
            $(this).parent("li").addClass("on");

            $(".tab_cont").hide();
            let targetTabId = $(this).attr("href"); // ex) "#tab01"
            $(targetTabId).show();

            // 탭을 누를 때마다 활성화된 탭 ID를 갱신하고 데이터를 다시 조회!
            searchConditionObj.activeTabId = targetTabId.replace("#", "");
            searchConditionObj.pageNo = 1;
            searchData();
        });
    });
</script>

<div class="search_basic" style="min-width: 1000px;">
    <table style="width: 100%;">
        <caption>검색</caption>
        <colgroup><col style="width:8%"><col style="width:25%"><col style="width:8%"><col style="width:15%"><col style="width:8%"><col style="width:22%"><col style="width:14%"></colgroup>
        <tbody>
        <tr>
            <td><label>조회기간</label></td>
            <td>
                <div style="display: inline-flex; align-items: center; gap: 5px; flex-wrap: nowrap;">
                    <span class="calendar_input"><input id="searchStDt" class="w120" type="text" autocomplete="off" /></span>
                    <span class="gap">~</span>
                    <span class="calendar_input"><input id="searchEdDt" class="w120" type="text" autocomplete="off" /></span>
                </div>
            </td>
            <td><label>공통권역</label></td>
            <td><select id="searchCmnRegionCd" class="w100p"></select></td>
            <td><label>상세검색</label></td>
            <td>
                <div style="display: inline-flex; align-items: center; gap: 5px; flex-wrap: nowrap;">
                    <select id="searchKeyCd" class="w100"></select>
                    <input id="searchKeyWord" type="text" class="w150" placeholder="검색어 입력"/>
                </div>
            </td>
            <td style="text-align: right; padding-right: 15px;">
                <div style="display: inline-flex; align-items: center; gap: 8px; justify-content: flex-end;">
                    <button type="button" class="btn btn_reset" id="btnReset"><i class="xi-refresh"></i>초기화</button>
                    <button type="button" class="btn btn_search" id="btnSearch"><i class="xi-search"></i>검색</button>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<div class="tab_wrap mt20">
    <ul class="tab_menu" id="regionTabs">
        <li class="on"><a href="#tab01">수도권</a></li>
        <li><a href="#tab02">경인권</a></li>
        <li><a href="#tab03">충남권</a></li>
        <li><a href="#tab04">호남권</a></li>
        <li><a href="#tab05">영남권</a></li>
    </ul>
</div>

    <div id="tab01" class="tab_cont" style="display: block;">
        <div class="tbl">
            <div class="board_top"><div class="board_left"><div class="all_num">전체<span class="num">0</span>건</div></div></div>
            <table class="board_list">
                <colgroup>
                    <col style="width: 10%;">
                    <col>
                    <col style="width: 20%;">
                    <col style="width: 15%;">
                    <col style="width: 15%;">
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">지점명 (TD)</th>
                        <th scope="col">담당자 (Input)</th>
                        <th scope="col">문서 (Icon)</th>
                        <th scope="col">관리 (Btn)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="paging_wrap"><ul class="paging"></ul></div>
        </div>
    </div>

    <div id="tab02" class="tab_cont" style="display: none;">
        <div class="tbl">
            <div class="board_top"><div class="board_left"><div class="all_num">전체<span class="num">0</span>건</div></div></div>
            <table class="board_list">
                <colgroup>
                    <col style="width: 10%;">
                    <col>
                    <col style="width: 30%;">
                    <col style="width: 20%;">
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">심사결과 (Select)</th>
                        <th scope="col">등급 (Radio)</th>
                        <th scope="col">등록일 (Date)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="paging_wrap"><ul class="paging"></ul></div>
        </div>
    </div>`

    <div id="tab03" class="tab_cont" style="display: none;">
        <div class="tbl">
            <div class="board_top"><div class="board_left"><div class="all_num">전체<span class="num">0</span>건</div></div></div>
            <table class="board_list">
                <colgroup>
                    <col style="width: 10%;">
                    <col>
                    <col style="width: 30%;">
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">선택 (Chk)</th>
                        <th scope="col">프로젝트명 (TD)</th>
                        <th scope="col">예산 (Double)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="paging_wrap"><ul class="paging"></ul></div>
        </div>
    </div>

    <div id="tab04" class="tab_cont" style="display: none;">
        <div class="tbl">
            <div class="board_top"><div class="board_left"><div class="all_num">전체<span class="num">0</span>건</div></div></div>
            <table class="board_list">
                <colgroup>
                    <col style="width: 10%;">
                    <col>
                    <col style="width: 15%;">
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">게시글 제목 (TD + Hidden)</th>
                        <th scope="col">첨부파일 (Clip)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="paging_wrap"><ul class="paging"></ul></div>
        </div>
    </div>

    <div id="tab05" class="tab_cont" style="display: none;">
        <div class="tbl">
            <div class="board_top"><div class="board_left"><div class="all_num">전체<span class="num">0</span>건</div></div></div>
            <table class="board_list">
                <colgroup>
                    <col style="width: 10%;">
                    <col>
                    <col style="width: 20%;">
                    <col style="width: 20%;">
                    <col style="width: 15%;">
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">지점명</th>
                        <th scope="col">결과 (Select)</th>
                        <th scope="col">일자 (Date)</th>
                        <th scope="col">비고 (Icon)</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="paging_wrap"><ul class="paging"></ul></div>
        </div>
    </div>