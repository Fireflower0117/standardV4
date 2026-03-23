<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
    let globalBoardConfig = {};
    $(document).ready(function(){

    /**************************************************************************
     ***********************        페이지 세팅            ***********************
     ***************************************************************************/

      // 검색일자 시작일 , 종료일 DatePicker적용   TO-DO : DatePicker적용 안됨 확인필요
      /* on.html.setDatePicker({ targets : ["#searchStDt" , "#searchEdDt"]  // 필수입력
                            , dateFormat : "yy.mm.dd"  // Option (default : "yy.mm.dd" )
                            }); */

      let toDay   = on.date.getDate({}); // 오늘 (ToDay)
      let fromDay = on.date.dateCalc(toDay, "D" , -7 , "YYYY-MM-DD" ); // 오늘기준 -7일
      on.html.setEleVal({ele : "#searchStDt"   , val : fromDay });
      on.html.setEleVal({ele : "#searchEdDt"   , val : toDay  });


      // 검색조건 구분
       on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#searchKeyCd" }
                                    , addOption     : [{ position : "top" , txt : "전체" , val : "" }]
                                    , optionValInfo : { optId : "code" , optTxt : "text" }
                                    , dataInfo      : [ { code : "regUser"    , text:"작성자"  }
                                                      , { code : "contTitle"  , text:"제목" }
                                                    ]
                                     });
       // Paging Per Row
       on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#recordCountPerPage" }
                                    , optionValInfo : { optId : "code" , optTxt : "text", defaultVal : "10" }
                                    , dataInfo      : [ { code : "10" , text:"10건" }
                                                    , { code : "20" , text:"20건" }
                                                    , { code : "30" , text:"30건" }
                                                    , { code : "50" , text:"50건" }
                                                    ]
                                     });

        /***************************************************************************
        ********************      페이지 Table Grid 설정         ********************
        ***************************************************************************/
        // 게시판 정보 조회
        if(!on.valid.isEmpty('${param.menuFuncCd}') ){
             on.xhr.ajax({ cmd : "selectOne" , sql : "on.standard.system.boardtype.inqBoardTypeDetail"
                         , menuFuncCd : '${param.menuFuncCd}'
                         , successFn : function(rs){
                                globalBoardConfig = rs; // 게시판 Meata정보 Global 설정

                                // 테이블 Header(<th>) 동적 생성
                                lfnDrawBoardHeader(rs);

                                // page Load시 수행
                                searchData();
                         }
             });
        }
        // 게시판 Table Head정보 생성
        function lfnDrawBoardHeader(cfg) {
            let thHtml = `<tr>
                              <th style="width:8%;">번호</th>`;

            // 공지여부 컬럼
            if (cfg.ntiYn === 'Y'){
                thHtml += `<th style="width:8%;">공지여부</th>`;
            }

            // 제목 컬럼 (보통 무조건 Y지만 설정에 따름)
            if (cfg.titleYn === 'Y'){
                thHtml += `<th>제목</th>`;
            }

            // 첨부파일 컬럼
            if (cfg.attchFileYn === 'Y'){
                thHtml += `<th style="width:8%;">첨부</th>`;
            }

            // 기본 컬럼
            thHtml += `
                <th style="width:12%;">작성자</th>
                <th style="width:15%;">등록일</th>`;

            // 추천수 컬럼
            if (cfg.rcmdYn === 'Y'){
                thHtml += `<th style="width:8%;">추천수</th>`;
            }

            thHtml += `</tr>`;

            // thead 영역에 꽂아넣기
            $("#dynamicBoardTable thead").html(thHtml);
        }

        /***************************************************************************
        ********************           게시판 Data 조회           ********************
        ***************************************************************************/
         // 검색조건 설정
         let searchConditionObj = {
                  cmd             : "selectPage"
                , sql             : "on.standard.board.comboard.inqBoardList"
                , menuFuncCd      : '${param.menuFuncCd}'
                , searchStDt      : on.html.getEleVal({ele : "#searchStDt"} )
                , searchEdDt      : on.html.getEleVal({ele : "#searchEdDt"} )
                , searchKeycd     : on.html.getEleVal({ele : "#searchKeyCd"} )
                , searchKeyWord   : on.html.getEleVal({ele : "#searchKeyWord"} )
         };

        // 검색 조건이 있는 경우 검색창에 반영
         <c:if test="${param.searchCondition ne null && param.searchCondition ne ''}">
              const search = <c:out value="${param.searchCondition}" escapeXml="false"/>;
              on.html.setEleVal({ele : "#searchStDt"   , val : search.searchStDt });
              on.html.setEleVal({ele : "#searchEdDt"   , val : search.searchEdDt });
              on.html.setEleVal({ele : "#searchKeyCd"  , val : search.searchKeyCd });
              on.html.setEleVal({ele : "#searchKeyWord", val : search.searchKeyWord });

              searchConditionObj.searchStDt    = on.html.getEleVal({ele : "#searchStDt"});
              searchConditionObj.searchEdDt    = on.html.getEleVal({ele : "#searchEdDt"});
              searchConditionObj.searchKeyCd   = on.html.getEleVal({ele : "#searchKeyCd"});
              searchConditionObj.searchKeyWord = on.html.getEleVal({ele : "#searchKeyWord"});
              searchConditionObj.pageNo        = search.pageNo;
              if(!on.valid.isEmpty(search.pageSize)) {
                  on.html.setEleVal({ele : "#recordCountPerPage"  , val : search.pageSize });
                  searchConditionObj.pageSize = on.html.getEleVal({ele : "#recordCountPerPage"});
              }

              searchData();
         </c:if>


        // 검색 Function
        function searchData() {

            if( on.valid.isEmpty(searchConditionObj.pageNo)){
              searchConditionObj.pageNo = 1;
            }

            var sqlDispDiv          = "normal_tab_columns";
            var dataDispTarget      = ".board_list > tbody";

            const resource          = on.xhr.ajax(searchConditionObj);

            /* 페이지 건수 표기 */
            let totalCount = 0;
            if (resource.length > 0) { totalCount = resource[0].totalCount; }
            $(".all_num > .num").text(totalCount);


            //  동적 컬럼(displayColInfos) 조립 로직 (lfnDrawBoardHeader 함수와 동일한 조건)
            // dynamicColumns ArrayList 순서 변경주의 (lfnDrawBoardHeader 함수내부 순서와 동일성 유지 필수)
            let cfg = globalBoardConfig || {};
            let dynamicColumns = [];

            //  번호 (고정) - data_id1은 보통 PK인 boardSerno를 매핑
            dynamicColumns.push({id: "rowindx", colType: "rowNumber", data_id1:"boardSerno", classNm: "number"});

            //  공지여부 컬럼
            if (cfg.ntiYn === 'Y'){
                dynamicColumns.push({id: "ntiYn", colType: "normalTd", data_id1:"boardSerno"});
            }

            // 제목 컬럼
            if (cfg.titleYn === 'Y'){
                dynamicColumns.push({id: "titl", colType: "normalTd", data_id1:"boardSerno", classNm: "left"});
            }

            //  첨부파일 컬럼 (파일 ID가 있는지 여부로 판단)
            if (cfg.attchFileYn === 'Y'){
                dynamicColumns.push({id: "hasFile", colType: "normalTd", data_id1:"boardSerno", data_id2:"atchFileId"});
            }

            // 기본 컬럼 (작성자, 등록일)
            dynamicColumns.push({id: "regUser", colType: "normalTd", data_id1:"boardSerno"});
            dynamicColumns.push({id: "regDate", colType: "normalTd", data_id1:"boardSerno", classNm: "date"});

            // 추천수 컬럼
            if (cfg.rcmdYn === 'Y'){
                dynamicColumns.push({id: "rcmdCount", colType: "normalTd", data_id1:"boardSerno", classNm: "number"});
            }
            // =========================================================================

            /* Table List(목록) 표시 자료 */
            var displayInfoObj = {
                dispTarget    : dataDispTarget // 필요에 따라 분기처리하여 사용가능
              , dispDiv       : sqlDispDiv     // displayColInfos[sqlDispDiv] ==>> 기준으로 Table Tbody를 구성함 ( 하나의 Page에 여려개 탭이 있을경우 분기처리하여 사용)
              , resource      : resource
              , paginginfo    : {targetId : "#pagenation" , btnFnName : fnPageBtnClick } // 페이징처리될영역과 , 페이징버튼 Event (자동처리)
              , displayColInfos : {
                    normal_tab_columns : dynamicColumns
              }
            }

            // Table Display
            on.html.tableDisplay(displayInfoObj);
          }

           /**************************************************************************
          ***********************       버튼 관련 이벤트         ***********************
          ***************************************************************************/
         // 검색 초기화
          $("#btnReset").on("click", () => {

            let toDay   = on.date.getDate({}); // 오늘 (ToDay)
            let fromDay = on.date.dateCalc(toDay, "D" , -7 , "YYYY-MM-DD" ); // 오늘기준 -7일
            on.html.setEleVal({ele : "#searchStDt"   , val : fromDay});
            on.html.setEleVal({ele : "#searchEdDt"   , val : toDay });
            on.html.setEleVal({ele : "#searchKeyCd"  , val : "" });
            on.html.setEleVal({ele : "#searchKeyWord", val : "" });

            searchConditionObj.searchStDt    = on.html.getEleVal({ele : "#searchStDt"} );
            searchConditionObj.searchEdDt    = on.html.getEleVal({ele : "#searchEdDt"} );
            searchConditionObj.searchKeyCd   = on.html.getEleVal({ele : "#searchKeyCd"} );
            searchConditionObj.searchKeyWord = on.html.getEleVal({ele : "#searchKeyWord" });
            searchConditionObj.pageNo = 1;
         });

          // PagePerRow 변경
          $("#recordCountPerPage").on("change", (evt) => {
              searchConditionObj.pageNo = 1;
              searchConditionObj.pageSize = $(evt.target).val();
              searchData();
          });

           // Paging버튼 클릭
          function fnPageBtnClick(pageNo) {
            searchConditionObj.pageNo = pageNo;
            searchData();
          }

          // 키워드 검색창에서 엔터를 누르면 검색 트리거
          $("#searchKeyWord").keydown(function(event) {
                if (event.key === "Enter") {
                  $("#btnSearch").click();
                }
          });

           // 검색 클릭
          $("#btnSearch").on("click", (evt) => {
                searchConditionObj.pageNo        = 1;
                searchConditionObj.searchStDt    = on.html.getEleVal({ele : "#searchStDt"} );
                searchConditionObj.searchEdDt    = on.html.getEleVal({ele : "#searchEdDt"} );
                searchConditionObj.searchKeycd   = on.html.getEleVal({ele : "#searchKeyCd" });
                searchConditionObj.searchKeyword = on.html.getEleVal({ele : "#searchKeyWord" });
                searchData(); // Search Data
          });

          // 상세보기
          <c:if test="${USER_AUTH.READ_YN== 'Y'}">
          $(".board_list > tbody").on("click" , (evt) => {
            let target = $(evt.target).closest("tr");
            let selBoardSerno = target.find("td[data-boardserno]").data("boardserno");
            if(!on.valid.isEmpty(selBoardSerno)){
                  on.html.dynaGenHiddenForm({ formDefine : { fid       : "boardTypeViewForm", action: "/ma/comboard/view.do", method: "post", isSubmit : true }
                                                           , formAttrs : [ { name : "searchCondition" , value : JSON.stringify(searchConditionObj) }
                                                                         , { name : "menuFuncCd"      , value : '${param.menuFuncCd}' }
                                                                         , { name : "menuFuncDivCd"   , value : 'board' }
                                                                         , { name : "boardSerno"      , value : selBoardSerno }
                                                                         ]
                  });
            }
          });
          </c:if>

          <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
                 // 작성권한이 있는 사용자만 권한 등록가능
                 $("#btnWrite").on("click", (evt) => {
                     on.html.dynaGenHiddenForm({ formDefine : { fid : "authWriteForm", action: "/ma/comboard/regist.do", method: "post", isSubmit : true }
                                               , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                              , { name : "menuFuncCd"      , value : '${param.menuFuncCd}' }
                                                              , { name : "menuFuncDivCd"   , value : 'board' }
                                                              ]
                     });


                 });
		  </c:if>

    });
</script>
<div class="search_basic">
    <table>
        <caption>검색</caption>
        <colgroup>
            <col style="width:10%">
            <col style="width:40%">
            <col style="width:10%">
            <col style="width:40%">
        </colgroup>
        <tbody>
            <tr>
                <td><label>작성일자</label></td>
                <td>
                    <div style="display: inline-flex; align-items: center; gap: 5px;">
                        <input type="text" id="searchStDt" class="w150">
                        <span>~</span>
                        <input type="text" id="searchEdDt" class="w150">
                    </div>
                </td>
                <td><label>검색</label></td>
                <td>
                    <select id="searchKeyCd" title="구분선택" class="w150"></select>
                    <input type="text" id="searchKeyWord" class="w200">
                </td>
            </tr>
        </tbody>
    </table>
    <button id="btnReset" class="btn btn_reset"><i class="xi-refresh"></i>초기화</button>
    <button id="btnSearch" class="btn btn_search"><i class="xi-search"></i>검색</button>
</div>
<div class="tbl">
    <div class="board_top">
        <div class="board_left">
            <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num">0</span>건</div>
        </div>
        <div class="board_right">
            <button type="button" id="btn_excel" class="btn btn_excel">엑셀 다운로드</button>
            <select id="recordCountPerPage" title="목록의 컨텐츠 Row수"></select>
        </div>
    </div>
    <table id="dynamicBoardTable" class="board_list">
        <thead></thead>
        <tbody></tbody>
    </table>
    <div class="paging_wrap">
        <ul class="paging" id="pagenation"></ul>
        <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
			<div class="btn_right">
                <button id="btnWrite" class="btn blue">등록</button>
            </div>
		</c:if>
    </div>
</div>