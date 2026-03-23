<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
    $(document).ready(function(){

     /**************************************************************************
     ***********************        페이지 세팅            ***********************
     ***************************************************************************/

     // 검색조건 구분
     on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#searchKeyCd" }
                                  , addOption     : [{ position : "top" , txt : "전체" , val : "" }]
                                  , optionValInfo : { optId : "code" , optTxt : "text" }
                                  , dataInfo      : [ { code : "boardCd"  , text:"게시판코드"  }
                                                    , { code : "boardNm"  , text:"게시판이름" }
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
     /**************************************************************************
      ***********************       목록조회 관련 이벤트     ***********************
      ***************************************************************************/
      // 검색조건 설정
      let searchConditionObj = {
              cmd             : "selectPage"
            , sql             : "on.standard.system.boardtype.inqBoardTypeList"
            , searchKeycd     : on.html.getEleVal({ele : "#searchKeyCd"} )
            , searchKeyWord   : on.html.getEleVal({ele : "#searchKeyWord"} )
      };

      // 화면 Load시 목록 조회
          searchData();

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

              /* Table List(목록) 표시 자료 */
              var displayInfoObj = {
                  dispTarget    : dataDispTarget // 필요에 따라 분기처리하여 사용가능
                , dispDiv       : sqlDispDiv     // displayColInfos[sqlDispDiv] ==>> 기준으로 Table Tbody를 구성함 ( 하나의 Page에 여려개 탭이 있을경우 분기처리하여 사용)
                , resource      : resource
                , paginginfo    : {targetId : "#pagenation" , btnFnName : fnPageBtnClick } // 페이징처리될영역과 , 페이징버튼 Event (자동처리)
                , displayColInfos : {
                      normal_tab_columns : [
                              {id: "rowindx"          , colType: "number"  , classNm: "number"}
                            , {id: "boardTpRadio"     , colType: "tdRadio"    , data_id1:"boardCd", data_id2:"boardKorNm"}
                            , {id: "boardKorNm"       , colType: "td"   }
                            , {id: "ntiYn"            , colType: "td"   }
                            , {id: "rcmdYn"           , colType: "td"   }
                            , {id: "contentEditorYn"  , colType: "td"   }
                            , {id: "attchFileYn"      , colType: "td"   }
                            , {id: "secretYn"         , colType: "td"   }
                            , {id: "replyYn"          , colType: "td"   }
                            , {id: "useYn"            , colType: "td"   }
                            , {id: "regDate"          , colType: "td"   , classNm: "date"}
                      ]
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
           on.html.setEleVal({ele : "#searchKeyCd"  , val : "" });
           on.html.setEleVal({ele : "#searchKeyWord", val : "" });

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
                searchConditionObj.searchKeycd   = on.html.getEleVal({ele : "#searchKeyCd" });
                searchConditionObj.searchKeyword = on.html.getEleVal({ele : "#searchKeyWord" });
                searchData(); // Search Data
          });


          // 선택
          $("#btnChoice").on("click", (evt) => {
              let selRadio = $(".board_list tbody td input[type='radio']:checked")
              let boardCd = selRadio.data("boardcd");
              let boardNm = selRadio.data("boardkornm");
              if( on.valid.isEmpty(boardCd) == true ){
                    on.msg.showMsg({message : "선택값이 없습니다.\n게시판을 선택하세요"});
                    return false;
              }

              if (opener && !opener.closed) {
                    let openerCallBackFn =  "${param.callBackFn}";
                    if(!on.valid.isEmpty(openerCallBackFn) ){
                        if (typeof opener[openerCallBackFn] === "function") {
                            opener[openerCallBackFn].call(opener,  {boardNm : boardNm, boardCd : boardCd });
                        }
                    }
              }
              else {
                on.msg.showMsg({message : "부모창을 찾을수 없습니다."});
              }
              window.close();
          });

    });
</script>

<div class="search_basic">
    <table>
        <caption>검색</caption>
        <colgroup>
                <col style="width:10%">
                <col>
                <col style="width:10%">
                <col>
        </colgroup>
        <tbody>
            <tr>
                <td><label>검색</label></td>
                <td colspan="3">
                    <select id="searchKeyCd" title="구분선택" class="w150"></select>
                    <input type="text" id="searchKeyWord">
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
    <table class="board_list" >
        <caption>목록(번호, 그룹권한ID, 그룹권한명, 그룹권한설명, 사용구분, 등록일으로 구성)</caption>
        <colgroup>
            <col class="w5p"/>
            <col class="w5p"/>
            <col class="w15p"/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col class="w10p"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">선택</th>
                <th scope="col">게시판명</th>
                <th scope="col">공지여부</th>
                <th scope="col">추천여부</th>
                <th scope="col">컨텐츠에디터여부</th>
                <th scope="col">첨부파일여부</th>
                <th scope="col">비밀글여부</th>
                <th scope="col">답글여부</th>
                <th scope="col">사용여부</th>
                <th scope="col">등록일</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div class="paging_wrap">
        <ul class="paging" id="pagenation"></ul>
        <div class="btn_right">
            <button id="btnChoice" class="btn blue">선택</button>
        </div>
    </div>
</div>