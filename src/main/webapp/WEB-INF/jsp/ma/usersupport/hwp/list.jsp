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
                                      , dataInfo      : [ { code : "userId"    , text:"아이디" }
                                                        , { code : "userNm"    , text:"이름" }
                                                        , { code : "userEmail" , text:"이메일" }
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
                            {id: "rowindx"    , colType: "number" , data_id1:"userId", classNm: "number"}
                          , {id: "userId"     , colType: "td"  , data_id1:"userId", classNm: "ellipsis"}
                          , {id: "userKorNm"  , colType: "td"  , data_id1:"userId"}
                          , {id: "mobileNo"   , colType: "td"  , data_id1:"userId"}
                          , {id: "emailAddr"  , colType: "td"  , data_id1:"userId" , classNm: "ellipsis"}
                          , {id: "authNm"     , colType: "td"  , data_id1:"userId" }
                          , {id: "brkYnNm"    , colType: "td"  , data_id1:"userId" }
                          , {id: "useYnNm"    , colType: "td"  , data_id1:"userId" }
                          , {id: "cbx"       , colType: "checkbox"  , data_id1:"userId" }
                    ]
              }
            }

            // Table Display
            on.html.tableDisplay(displayInfoObj);
          }

          /**************************************************************************
          *********************       Component  이벤트         **********************
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

            let selMenualSerno = target.find("td[data-mnlserno]").data("mnlserno");
            if(!on.valid.isEmpty(selMenualSerno)){
                  on.html.dynaGenHiddenForm({ formDefine : { fid       : "authViewForm", action: "/ma/usersupport/hwp/view.do", method: "post", isSubmit : true }
                                                           , formAttrs : [ { name : "searchCondition" , value : JSON.stringify(searchConditionObj) }
                                                                         , { name : "menualSerno"          , value : selMenualSerno }
                                                                         ]
                  });
            }
          });

           <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
                 // 로그인 사용자가 현재 페이지의 작성권한이 있다면...
                 $("#btnWrite").on("click", (evt) => {
                     on.html.dynaGenHiddenForm({ formDefine : { fid : "authWriteForm", action: "/ma/usersupport/hwp/regist.do", method: "post", isSubmit : true }
                                               , formAttrs : [ { name : "searchCondition" , value : JSON.stringify(searchConditionObj) } ]
                     });
                 });
           </c:if>

           <%-- 한글 다운로드 클릭--%>
		   $('#btnHwp').on('click', function(){
			  // cmFncHwpDown();

                if(userArr.length <= 0){
                    alert("선택된 항목이 없습니다.")
                    return false;
                }else{
                    $("#schEtc11").val(userArr)
                }

                window.open("", "childForm", "width=600, height=800, resizable = no, scrollbars = no");

                var defaultFrm = document.defaultFrm;

                defaultFrm.action = "/ma/us/hwp/hwpView.do";
                defaultFrm.method = "post";
                defaultFrm.target = "childForm";
                defaultFrm.submit();
                defaultFrm.target = "";

                return false;
		   });

		   $('#btnHwpLib').on('click', function(){
			  // cmFncHwplibDown(); 
                if(userArr.length <= 0){
                    alert("선택된 항목이 없습니다.")
                    return false;
                }else{
                    $("#schEtc11").val(userArr)
                }

                window.open("", "childForm", "width=600, height=800, resizable = no, scrollbars = no");

                var defaultFrm = document.defaultFrm;

                defaultFrm.action = "/ma/us/hwp/hwpView.do";
                defaultFrm.method = "post";
                defaultFrm.target = "childForm";
                defaultFrm.submit();
                defaultFrm.target = "";

                return false;
		   });


          /**************************************************************************
          *********************       CheckBox 관련  이벤트         **********************
          ***************************************************************************/
           <%-- 사용자 일련번호 저장용 배열 --%>
           let userArr = new Array();

           <%-- 페이지 이동시 체크박스 유지 --%>
           const fncPageMoveCheckSet = function(){
                for (let i = 0; i < userArr.length; i++) {
                    let data = userArr[i];
                    $('#cbx_' + data).prop('checked', true);
                }

                <%-- 체크박스 전체가 선택되어있나 확인 --%>
                funCheckAllAction();
           }

		   <%-- 전체선택 클릭시 --%>
		   $('#allChk').on('click', function(evt){
			  let isChk = $(evt.target).is(":checked");
               $('input[type="checkbox"][id^="cbx_"]').prop('checked', isChk).trigger('change');
		   });

		   <%-- 체크박스 부모 td 클릭시 이벤트 막기 --%>
		   $('input[type="checkbox"][id^="cbx_"]').parents('td').on('click', function(e){
			   e.stopPropagation();
		   });

		   <%-- 체크박스 클릭시 --%>
		   $('input[type="checkbox"][id^="cbx_"]').on('change', function(evt) {

                let userId = $(evt.target).parents('tr').data('userid');
                let idx = userArr.indexOf(userId);

                if($(evt.target).is(":checked")){
                    if(idx === -1){
                        userArr.push(userId);
                    }
                }else{
                    if(idx > -1){
                        userArr.splice(idx, 1);
                    }
                }

                <%-- 체크박스 전체가 선택되어있나 확인 --%>
                funCheckAllAction();
		   });

           <%-- 체크박스 전체가 선택되어있나 확인 --%>
           const funCheckAllAction = function(){
                <%-- 체크박스 개수 --%>
                let checkboxLength = $('input[id^=cbx_]').length;
                <%-- 체크된 체크박스 개수 --%>
                let checkedLength = $('input[id^=cbx_]:checked').length;

                if(checkboxLength > 0){
                    <%-- 전체 체크 --%>
                    if(checkboxLength === checkedLength) {
                        $('#allChk').prop('checked',true);
                    <%-- 그 외 --%>
                    } else {
                        $('#allChk').prop('checked',false);
                    }
                }
           }
    });
</script>
<div class="search_basic">
	<form id="defaultFrm" name="defaultFrm" >
		<!--form:hidden path="currentPageNo"/ -->
		<!--form:hidden path="recordCountPerPage"/ -->
		<input type="hidden" id="authAreaCd" name="authAreaCd" value="FT"/>
		<input type="hidden" id=schEtc11 name="schEtc11"/>
		<table>
			<caption>검색</caption>
			<colgroup>
				<col class="w10p">
				<col>
				<col class="w10p">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<td><label>검색</label></td>
					<td colspan="3">
						<select id="searchKeyCd" title="구분선택" class="w150"></select>
						<input type="text" id="searchKeyWord" name="searchKeyword"/>
					</td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn_reset" id="btnReset"><i class="xi-refresh"></i>초기화</button>
    	<button type="button" class="btn btn_search" id="btnSearch"><i class="xi-search"></i>검색</button>
	</form>
</div>
<div class="tbl">
    <div class="board_top">
        <div class="board_left">
            <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num">0</span>건</div>
        </div>
        <div class="board_right">
            <button type="button" id="btnHwp" class="btn btn_hwp">hwp다운로드</button>
            <button type="button" id="btnHwpLib" class="btn btn_hwp">hwp(lib)다운로드</button>
            <select id="recordCountPerPage"></select>
        </div>
    </div>
    <table class="board_list">
        <caption>목록(번호, 아이디, 이름, 전화번호, 이메일, 권한, 차단여부, 사용여부, 잠금여부로 구성)</caption>
        <colgroup>
            <col class="w5p"/>
            <col/>
            <col class="w15p"/>
            <col class="w10p"/>
            <col class="w20p"/>
            <col class="w10p"/>
            <col class="w10p"/>
            <col class="w10p"/>
            <col class="w5p"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">아이디</th>
                <th scope="col">이름</th>
                <th scope="col">전화번호</th>
                <th scope="col">이메일</th>
                <th scope="col">권한</th>
                <th scope="col">차단여부</th>
                <th scope="col">사용여부</th>
                <th scope="col"><span class="chk"><span class="cbx"><input type="checkbox" id="allChk" name="allChk"/><label for="allChk"></label></span></span></th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div class="paging_wrap">
        <ul class="paging" id="pagenation"></ul>
    </div>
</div>
