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
                                  , dataInfo      : [ { code : "userId"   , text:"사용자ID" }
                                                    , { code : "userNm"   , text:"사용자명" }
                                                    , { code : "mobileNo" , text:"휴대폰번호" }
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
            , sql             : "on.standard.system.user.selUserList"
            , searchKeyCd     : $("#searchKeyCd :selected").val()
            , searchKeyWord   : $("#searchKeyWord").val()
      };

      // 검색 조건이 있는 경우 검색창에 반영
      <c:if test="${param.searchCondition ne null && param.searchCondition ne ''}">
          const search = <c:out value="${param.searchCondition}" escapeXml="false"/>;
          on.html.setEleVal({ele : "#searchKeyCd"  , val : search.searchKeyCd });
          on.html.setEleVal({ele : "#searchKeyWord", val : search.searchKeyWord });

          searchConditionObj.searchKeyCd   = on.html.getEleVal({ele : "#searchKeyCd"});
          searchConditionObj.searchKeyWord = on.html.getEleVal({ele : "#searchKeyWord"});
          searchConditionObj.pageNo        = search.pageNo;
          if(!on.valid.isEmpty(search.pageSize)) {
              on.html.setEleVal({ele : "#recordCountPerPage"  , val : search.pageSize });
              searchConditionObj.pageSize = on.html.getEleVal({ele : "#recordCountPerPage"});
          }
      </c:if>

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
                            {id: "rowindx"     , colType: "number" , data_id1:"userId", classNm: "number"}
                          , {id: "userId"      , colType: "td"  , data_id1:"userId"}
                          , {id: "userKorNm"   , colType: "td"  , data_id1:"userId"}
                          , {id: "userEngNm"   , colType: "td"  , data_id1:"userId"}
                          , {id: "blonNm"      , colType: "td"  , data_id1:"userId"}
                          , {id: "authNm"      , colType: "td"  , data_id1:"userId"}
                          , {id: "lstLoginDt"  , colType: "td"  , data_id1:"userId", classNm: "date"}
                          , {id: "regDate"     , colType: "td"  , data_id1:"userId", classNm: "date"}
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

           searchConditionObj.searchKeyCd   = on.html.getEleVal({ele : "#searchKeyCd" });
           searchConditionObj.searchKeyWord = on.html.getEleVal({ele : "#searchKeyWord"});
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
                searchConditionObj.searchKeyCd   = on.html.getEleVal({ele : "#searchKeyCd"});
                searchConditionObj.searchKeyWord = on.html.getEleVal({ele : "#searchKeyWord"});
                searchData(); // Search Data
          });

          // 상세보기
          $(".board_list > tbody").on("click" , (evt) => {
            let target = $(evt.target).closest("tr"); // 각 레코드의 부모인 tr로 가서 board_seq 찾기

            let selUserId = target.find("td[data-userid]").data("userid");
            if(!on.valid.isEmpty(selUserId)){
                  on.html.dynaGenHiddenForm({ formDefine : { fid       : "authViewForm", action: "/ma/system/user/view.do", method: "post", isSubmit : true }
                                                           , formAttrs : [ { name : "searchCondition" , value : JSON.stringify(searchConditionObj) }
                                                                         , { name : "userId"          , value : selUserId }
                                                                         ]
                  });
            }
          });

           <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
                 // 로그인 사용자가 현재 페이지의 작성권한이 있다면...
                 $("#btnWrite").on("click", (evt) => {
                     on.html.dynaGenHiddenForm({ formDefine : { fid : "authWriteForm", action: "/ma/system/user/regist.do", method: "post", isSubmit : true } });
                 });
		   </c:if>

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
    <table class="board_list">
        <colgroup>
            <col class="w5p"/>
            <col class="w10p"/>
            <col/>
            <col/>
            <col class="w10p"/>
            <col class="w10p"/>
            <col class="w10p"/>
            <col class="w10p"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">사용자아이디</th>
                <th scope="col">사용자이름(한글)</th>
                <th scope="col">사용자이름(영문)</th>
                <th scope="col">소속</th>
                <th scope="col">권한</th>
                <th scope="col">최종로그인일시</th>
                <th scope="col">등록일시</th>
            </tr>
        </thead>
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