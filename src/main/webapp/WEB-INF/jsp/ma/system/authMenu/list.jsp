<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(document).ready(function(){
     /*  일단 디자인 요소는 접어두고 기능부터 개발후 디자인은 보완적용 하기로 한다.  */

     /**************************************************************************
     ***********************        페이지 세팅            ***********************
     ***************************************************************************/

     	let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "menuDivCdList"   , sqlCondi : { uppComCd : "AUTH_DIV"    } }
				                                                , {rsId : "authIdList"      , sql : "on.standard.system.auth.selectAuthList"  }
		                                                       ]
		                     });

        // 메뉴 구분 리스트
		on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#menuDivCd" }
                                       , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" }
                                       , comboDataInfo :  inqCdRsltList.menuDivCdList
                                       });

         // 권한 리스트
		on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#authId" }
                                       , optionValInfo : { optId : "authId" , optTxt : "authKorName" }
                                       , comboDataInfo :  inqCdRsltList.authIdList
                                       });

         /**************************************************************************
      ***********************       목록조회 관련 이벤트     ***********************
      ***************************************************************************/
      // 검색조건 설정
      let searchConditionObj = {
              cmd             : "selectList" //  default : selectList지만 명시적 선언..
            , sql             : "on.standard.system.authmenu.selectLevelByMenuList"
            , menuDivCd       : on.html.getEleVal("#menuDivCd")
            , authId          : on.html.getEleVal("#authId")
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


            /* Table List(목록) 표시 자료 */
            var displayInfoObj = {
                dispTarget    : dataDispTarget // 필요에 따라 분기처리하여 사용가능
              , dispDiv       : sqlDispDiv     // displayColInfos[sqlDispDiv] ==>> 기준으로 Table Tbody를 구성함 ( 하나의 Page에 여려개 탭이 있을경우 분기처리하여 사용)
              , resource      : resource
              , displayColInfos : {
                    normal_tab_columns : [
                            {id: "authId"         , colType: "normalTd" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "menuDivCd"      , colType: "normalTd" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "menuCd"         , colType: "normalTd" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "levKorNm"       , colType: "normalTd" , data_id1:"authId", data_id2:"menuCd", style:"text-align: left;"}
                          , {id: "pageCl"         , colType: "normalTd" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "readYn"         , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "writeYn"        , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "updateYn"       , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "deletYn"        , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "popupOpenYn"    , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "popupReadYn"    , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "popupWiteYn"    , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "popupUpdateYn"  , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                          , {id: "popupDeleteYn"  , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd"}
                    ]
              }
            }

            // Table Display
            on.html.tableDisplay(displayInfoObj);
          }

          /**************************************************************************
          ***********************       버튼 관련 이벤트         ***********************
          ***************************************************************************/

            // 검색 클릭
          $("#btnSearch").on("click", (evt) => {
                searchConditionObj.menuDivCd  = on.html.getEleVal("#menuDivCd");
                searchConditionObj.authId     = on.html.getEleVal("#authId");
                searchData(); // Search Data
          });


          <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
              $("#btnSave").on("click", (evt) => {

                   // 권한정보 수집
                  let updateTargetList = [];
                  $(".board_list > tbody > tr").each(function(indx , trObj){
                        let authMenuData = {
                                authId        : $(trObj).find("[id^='menuCd']").data("authid")
                              , menuCd        : $(trObj).find("[id^='menuCd']").data("menucd")
                              , readYn        : on.html.getEleVal($(trObj).find("[id^='readYn']"))
                              , writeYn       : on.html.getEleVal($(trObj).find("[id^='writeYn']"))
                              , updateYn      : on.html.getEleVal($(trObj).find("[id^='updateYn']"))
                              , deletYn       : on.html.getEleVal($(trObj).find("[id^='deletYn']"))
                              , popupOpenYn   : on.html.getEleVal($(trObj).find("[id^='popupOpenYn']"))
                              , popupReadYn   : on.html.getEleVal($(trObj).find("[id^='popupReadYn']"))
                              , popupWiteYn   : on.html.getEleVal($(trObj).find("[id^='popupWiteYn']"))
                              , popupUpdateYn : on.html.getEleVal($(trObj).find("[id^='popupUpdateYn']"))
                              , popupDeleteYn : on.html.getEleVal($(trObj).find("[id^='popupDeleteYn']"))
                             };
                        updateTargetList.push(authMenuData);
                  });


                  // DB저장 (on.standard.system.authmenu.mergeMenuAuthMng)
                  on.xhr.ajax({ sid : "authMenuMerge"  // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                              , cmd : "insert" , sql : "on.standard.system.authmenu.mergeMenuAuthMng"  // on.standard.system.auth.updAuthInfo SQL을 수행, update 문을 수행한다.
                              , authMenuData  : updateTargetList// ajax data속성 + data 추가  ==>> (successFn, failFn, sql , cmd , validation 외 속성키는 전부 data로 추가입력 )
                              , successFn  : function (sid, data){
                                        on.msg.showMsg({message : "저장되었습니다."});
                                        $("#btnSearch").click();
                               }
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
					<col>
					<col style="width:10%">
					<col>
			</colgroup>
			<tbody>
				<tr>
				    <td><label>페이지 구분</label></td>
					<td>
					    <select id="menuDivCd" title="페이지구분 선택" class="w150"></select>
					</td>
					<td><label>권한</label></td>
					<td>
					    <select id="authId" title="권한 선택" class="w150"></select>
					</td>
				</tr>
			</tbody>
		</table>
        <button id="btnSearch" class="btn btn_search"><i class="xi-search"></i>검색</button>
        <button id="btnSave" class="btn btn_reset">저장</button>
</div>
<div class="tbl">
    <table class="board_list">
        <caption>목록(번호, 그룹권한ID, 그룹권한명, 그룹권한설명, 사용구분, 등록일으로 구성)</caption>
        <colgroup>
            <col class="w10p"/>
            <col class="w5p"/>
            <col class="w10p"/>
            <col class="w20p"/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
            <col/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">권한ID</th>
                <th scope="col">메뉴그룹그분</th>
                <th scope="col">메뉴코드</th>
                <th scope="col">메뉴명</th>
                <th scope="col">페이지구분</th>
                <th scope="col">읽기여부</th>
                <th scope="col">쓰기여부</th>
                <th scope="col">수정여부</th>
                <th scope="col">삭제여부</th>
                <th scope="col">팝업열기여부</th>
                <th scope="col">팝업읽기여부</th>
                <th scope="col">팝업쓰기기여부</th>
                <th scope="col">팝업수정기여부</th>
                <th scope="col">팝업삭제기여부</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>