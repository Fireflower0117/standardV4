<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
    $(document).ready(function(){

           /********************************************************************
           *********************          검색조건         **********************
           *********************************************************************/

           // 공통코드 일괄조회 (여러개의 공통코드를 일괄적으로 한번에 조회해서 서버 부담을 줄인다.)
           	let comCodeRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "rsCareerLevel"   , sqlCondi : { uppComCd : "CAREER_LEVEL"  } }
				                                                      , {rsId : "rsRegionDivCd"   , sqlCondi : { uppComCd : "REGION_DIV_CD"   } }
		                                                            ]
		                          });



          // 등록일 기간조회
          let initRegDateConditions = function(){
              on.html.setDatePicker({ targets : ["#regStartDate" , "#regEndDate"]  // 필수입력
                                    , dateFormat : "yy.mm.dd"  // Option (default : "yy.mm.dd" )
              });

              let toDay   = on.date.getDate({});  // 오늘 (ToDay)
              let fromDay = on.date.dateCalc(toDay, "D" , -7 , "YYYY.MM.DD" ); // 오늘기준 -7일
              on.html.setEleVal({ele : "#regStartDate" , val : fromDay });
              on.html.setEleVal({ele : "#regEndDate"   , val : toDay   });
          }
          initRegDateConditions();


          // 경력단계 (input Radio )
          on.html.dynaGenRadio({ targetInfo    : { targetId : "#rdoCareerLevel" , style : "display: inline-flex; align-items: center; gap: 15px; flex-wrap: nowrap; white-space: nowrap;"  }
                               , targetProp    : { eleId  : "rdoCareerLvl"    , eleNm :"careerLevel" , style : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;"}
                               , optionWrapper : { useYn    : "Y"  , tagName   : "label", style   : "display: inline-flex; align-items: center; gap: 3px; cursor: pointer;"} // input radio  옵션을 감쌀(wrapper) 앨리먼트이다. (옵션이다. 필수입력값아님.)
                               , optionValInfo : { optId    : "comCd"           , optTxt : "cdNm" , defaultVal : "LEVEL_JNR" }
                             //, radioDataInfo : on.xhr.ajaxComCd({sqlCondi : { uppComCd : "CAREER_LEVEL"  } }) // 공통코드 개별 조회
                               , dataInfo      : comCodeRsltList.rsCareerLevel // 공통코드 일괄조회 결과 data 활용
                               });



          // 권역구분 (select box)
          on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#regionCd" }
                                       , addOption     : [ { position : "top" , txt : "전체" , val : "all" }
                                                         , { position : "bottom" , txt : "직접입력" , val : "self_" }] // 추가옵션은 어려건이 올수도 잇음.  ex) top : 선택 , bottom : 직접입력
                                       , optionValInfo : { optId : "comCd"     , optTxt : "cdNm" }
                                     //, dataInfo      : on.xhr.ajaxComCd({sqlCondi : { uppComCd : "REGION_DIV_CD"  } }) // 공통코드 개별 조회
                                       , dataInfo      : comCodeRsltList.rsRegionDivCd // 공통코드 일괄조회 결과 data 활용
                                       });

          // 검색구분 (select box)
           on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#searchKeyCd" }
                                        , addOption     : [ { position : "top" , txt : "전체" , val : "all" }] // 추가옵션은 어려건이 올수도 잇음.  ex) top : 선택 , bottom : 직접입력
                                        , optionValInfo : { optId : "code"   , optTxt : "text" }
                                        , dataInfo      : [ { code : "title"   , text:"제목" }    // 옵션데이터 수동 입력
                                                          , { code : "regUser" , text:"등록자" }
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



          /********************************************************************
           *********************     목록조회 관련 이벤트    *********************
           ********************************************************************/
          // 검색조건 설정
          let searchConditionObj = {
                  cmd           : "selectPage"
                , sql           : "on.standard.board.sampleboard.inqSampleBoardList"
                , regStartDate  : on.html.getEleVal({ ele : "#regStartDate"  })
                , regEndDate    : on.html.getEleVal({ ele : "#regEndDate"    })
                , careerLevel   : on.html.getEleVal({ ele : "[name='careerLevel']"})
                , regionCd      : on.html.getEleVal({ ele : "#regionCd"      })
                , searchKeyCd   : on.html.getEleVal({ ele : "#searchKeyCd"   })
                , searchKeyWord : on.html.getEleVal({ ele : "#searchKeyWord" })
          };

           // 검색 조건이 있는 경우 검색창에 반영
          <c:if test="${param.searchCondition ne null && param.searchCondition ne ''}">
              const search = <c:out value="${param.searchCondition}" escapeXml="false"/>;
              on.html.setSearchConditions(search);

              searchConditionObj.regStartDate  = on.html.getEleVal({ ele : "#regStartDate"  });
              searchConditionObj.regEndDate    = on.html.getEleVal({ ele : "#regEndDate"    });
              searchConditionObj.careerLevel   = on.html.getEleVal({ ele : "[name='careerLevel']" });
              searchConditionObj.regionCd      = on.html.getEleVal({ ele : "#regionCd"      });
              searchConditionObj.searchKeyCd   = on.html.getEleVal({ ele : "#searchKeyCd"   });
              searchConditionObj.searchKeyWord = on.html.getEleVal({ ele : "#searchKeyWord" })
              searchConditionObj.pageNo        = search.pageNo;
              if(search.pageSize) {
                  searchConditionObj.pageSize = search.pageSize;
                  $("#recordCountPerPage").val(search.pageSize);
              }
          </c:if>

          <c:if test="${USER_AUTH.READ_YN == 'Y'}">
              // 화면 Load시 목록 조회
              searchData();

              // 검색 Function
              function searchData() {

                if( on.valid.isEmpty(searchConditionObj.pageNo)){
                  searchConditionObj.pageNo = 1;
                }

                var sqlDispDiv          = "single_tab_columns";   // 검색조건 영역은 하나,  탭이 여러개인경우 그리드데이터 생성대상 구분자로 사용
                var dataDispTarget      = ".board_list > tbody";  // 검색조건 영역은 하나,  탭이 여러개인경우 그리드 표출 타켓 구분하여 사용

                // 테이블 표출 데이터 조회
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
                        single_tab_columns : [
                                {id: "rowindx"   , colType: "number" , data_id1:"boardSerno", classNm: "number"}
                              , {id: "region"    , colType: "select"
                                                 , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                                 , dataInfo : comCodeRsltList.rsRegionDivCd
                                }
                              , {id: "boardTitl" , colType: "td"  , data_id1:"boardSerno"}
                              , {id: "careerlvl" , colType: "radio"
                                                 , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                                 , dataInfo : comCodeRsltList.rsCareerLevel
                                }
                              , {id: "regDate"   , colType: "datePicker"  , data_id1:"boardSerno", classNm: "date"}
                              , {id: "rcmdCount" , colType: "td"  , data_id1:"boardSerno", classNm: "number"}
                        ]
                  }
                }

                // Table Display
                on.html.tableDisplay(displayInfoObj);
              }
          </c:if>


          /********************************************************************
           *********************     버튼 관련 이벤트    *********************
           ********************************************************************/

          // 검색 초기화
          $("#btnReset").on("click", () => {
             initRegDateConditions();
             on.html.setEleVal({ ele : "[name='careerLevel']" , val : "LEVEL_JNR"});
             on.html.setEleVal({ ele : "#regionCd"      , val : "all"});
             on.html.setEleVal({ ele : "#searchKeyCd"   , val : "all"});
             on.html.setEleVal({ ele : "#searchKeyWord" , val : ""});

             searchConditionObj.regStartDate  = on.html.getEleVal({ ele : "#regStartDate" });
             searchConditionObj.regEndDate    = on.html.getEleVal({ ele : "#regEndDate" });
             searchConditionObj.careerLevel   = on.html.getEleVal({ ele : "[name='careerLevel']" });
             searchConditionObj.regionCd      = on.html.getEleVal({ ele : "#regionCd" });
             searchConditionObj.searchKeyCd   = on.html.getEleVal({ ele : "#searchKeyCd" });
             searchConditionObj.searchKeyWord = on.html.getEleVal({ ele : "#searchKeyWord" });
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
          $("#searchKeyword").keydown(function(event) {
                if (event.key === "Enter") {
                  $("#btnSearch").click();
                }
          });


          <c:if test="${USER_AUTH.READ_YN == 'Y'}">
              // 검색 클릭
              $("#btnSearch").on("click", (evt) => {
                    searchConditionObj.pageNo        = 1;
                    searchConditionObj.searchKeyCd   = on.html.getEleVal({ ele : "#searchKeyCd"   });
                    searchConditionObj.searchKeyWord = on.html.getEleVal({ ele : "#searchKeyWord" });
                    searchData(); // Search Data
              });


              // 상세보기 (목록 제목클릭)
              $(".board_list > tbody td").on("click", function(evt) {
                let selBoardSerno = $(this).data("boardserno");
                if(!on.valid.isEmpty(selBoardSerno)){
                           /* 검색조건 정보 포함하여 넘김 (상세보기호 List페이지 복귀시 상세페이기 보기전상태와 동일하게 유지 목적)*/
                           on.html.dynaGenHiddenForm({ formDefine : { fid: "viewForm", action: "/ma/board/stanboard/view.do", method: "post", isSubmit : true }
                                                      , formAttrs : [ { name : "searchCondition" , value : JSON.stringify(searchConditionObj) }
                                                                    , { name : "boardSerno"      , value : selBoardSerno }
                                                                    ]
                  });
                }
              });
          </c:if>

          <c:if test="${USER_AUTH.WRITE_YN == 'Y'}">
              $("#btnWrite").on("click", function(){
                  /* 검색조건 정보(param.searchCondition) 포함하여 넘김 (상세보기호 List페이지 복귀시 상세페이기 보기전상태와 동일하게 유지 목적) */
                  on.html.dynaGenHiddenForm({ formDefine : { fid: "libraryWriteForm", action: "/ma/board/stanboard/regist.do", method: "post", isSubmit : true }
                                             , formAttrs : [ { name : "searchCondition" , value : JSON.stringify(searchConditionObj) }
                                                           ]
                  });
              });
          </c:if>
    });
</script>
<div class="search_basic" style="min-width: 1000px;"> <table style="width: 100%;">
        <caption>검색</caption>
        <colgroup>
            <col style="width:8%">  <col style="width:23%"> <col style="width:8%">  <col style="width:12%"> <col style="width:8%">  <col style="width:27%"> <col style="width:14%"> </colgroup>
        <tbody>
            <tr>
                <td><label>신청기간</label></td>
                <td>
                    <div style="display: inline-flex; align-items: center; gap: 5px; flex-wrap: nowrap; white-space: nowrap;">
                        <span class="calendar_input"><input id="regStartDate" class="w120" title="조회 시작일" type="text" autocomplete="off" /></span>
                        <span class="gap">~</span>
                        <span class="calendar_input"><input id="regEndDate" class="w120" title="조회 종료일" type="text" autocomplete="off" /></span>
                    </div>
                </td>

                <td><label>경력단계</label></td>
                <td>
                    <div id="rdoCareerLevel" ></div>
                </td>

                <td><label>상세검색</label></td>
                <td>
                    <div style="display: inline-flex; align-items: center; gap: 5px; flex-wrap: nowrap;">
                        <select id="regionCd" class="w100" title="권역선택"></select>
                        <select id="searchKeyCd" class="w100" title="구분선택"></select>
                        <input id="searchKeyWord" type="text" class="w150" placeholder="검색어 입력"/>
                    </div>
                </td>

                <td style="text-align: right; padding-right: 15px;">
                    <div style="display: inline-flex; align-items: center; gap: 8px; white-space: nowrap; justify-content: flex-end;">
                         <button type="button" class="btn btn_reset" id="btnReset"><i class="xi-refresh"></i>초기화</button>
                         <c:if test="${USER_AUTH.READ_YN == 'Y'}">
                            <button type="button" class="btn btn_search" id="btnSearch"><i class="xi-search"></i>검색</button>
                         </c:if>
                    </div>
                </td>
            </tr>
        </tbody>
     </table>
</div>

<div class="tbl">
    <div class="board_top">
        <div class="board_left">
            <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num">0</span>건</div>
        </div>
        <div class="board_right">
            <select id="recordCountPerPage"></select>
        </div>
    </div>
    <!-- 공지사항/자료실 -->
    <table class="board_list">
        <colgroup>
            <col style="width: 10%;">
            <col style="width: 10%;">
            <col>
            <col style="width: 20%;">
            <col style="width: 20%;">
            <col style="width: 10%;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">권역</th>
                <th scope="col">제목</th>
                <th scope="col">경력레벨</th>
                <th scope="col">등록일</th>
                <th scope="col">추천수</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
     <div class="paging_wrap">
        <ul class="paging" id="pagenation"></ul>
        <div class="btn_right">
            <c:if test="${USER_AUTH.WRITE_YN == 'Y'}">
            <button id="btnWrite" class="btn blue">등록</button>
            </c:if>
         </div>
    </div>
</div>