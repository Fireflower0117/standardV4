<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
    .board_list tbody tr.is-modified td {
        background-color: #fff4e5 !important;
    }
</style>
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
	 on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#menuDivCd" }
                                  , optionValInfo : { optId : "comCd" , optTxt : "cdDesc" }
                                  , dataInfo      :  inqCdRsltList.menuDivCdList
                                  });

     // 권한 리스트
	 on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#authId" }
                                  , optionValInfo : { optId : "authId" , optTxt : "authKorName" }
                                  , dataInfo      :  inqCdRsltList.authIdList
                                  });
        // 검색조건 구분
     on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#searchKeyCd" }
                                  , addOption     : [{ position : "top" , txt : "전체" , val : "" }]
                                  , optionValInfo : { optId : "code" , optTxt : "text" }
                                  , dataInfo      : [ { code : "menuNm"   , text:"메뉴명" }
                                                    , { code : "menuAddr" , text:"URL" }
                                                    ]
                                 });
     /**************************************************************************
     ***********************       목록조회 관련 이벤트     ***********************
     ***************************************************************************/
     // 검색조건 설정
     let searchConditionObj = {
              cmd             : "selectList" //  default : selectList지만 명시적 선언..
            , sql             : "on.standard.system.authmenu.selectLevelByMenuList"
            , menuDivCd       : on.html.getEleVal({ele : "#menuDivCd"})
            , authId          : on.html.getEleVal({ele : "#authId" })
            , searchKeyCd     : on.html.getEleVal({ele : "#searchKeyCd"} )
            , searchKeyWord   : on.html.getEleVal({ele : "#searchKeyWord"} )
     };


     // 화면 Load시 목록 조회 (권한 있는 사용자만..)
     <c:if test="${USER_AUTH.READ_YN== 'Y'}">
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
                        {id: "useYn"          , colType: "checkbox" , data_id1:"authId", data_id2:"menuCd" , classNm : "chkFunc USEYN" }
                      , {id: "authId"         , colType: "td" , data_id1:"authId", data_id2:"menuCd"}
                      , {id: "menuDivCd"      , colType: "td" }
                      , {id: "level"          , colType: "td" }
                      , {id: "levKorNm"       , colType: "td" , styleNm:"text-align: left;"}
                      , {id: "urlAddr"        , colType: "td" , styleNm:"text-align: left;"}
                      , {id: "menuCl"         , colType: "td" }
                      , {id: "readYn"         , colType: "checkbox" , classNm : "chkFunc R" }
                      , {id: "writeYn"        , colType: "checkbox" , classNm : "chkFunc W" }
                      , {id: "updateYn"       , colType: "checkbox" , classNm : "chkFunc U" }
                      , {id: "deletYn"        , colType: "checkbox" , classNm : "chkFunc D" }
                      , {id: "popupOpenYn"    , colType: "checkbox" , classNm : "chkFunc PO"}
                      , {id: "popupReadYn"    , colType: "checkbox" , classNm : "chkFunc PR"}
                      , {id: "popupWiteYn"    , colType: "checkbox" , classNm : "chkFunc PW"}
                      , {id: "popupUpdateYn"  , colType: "checkbox" , classNm : "chkFunc PU"}
                      , {id: "popupDeleteYn"  , colType: "checkbox" , classNm : "chkFunc PD"}
                ]
          }
        }

        // Table Display
        on.html.tableDisplay(displayInfoObj);
     }
     </c:if>

     // 그리드 옵션(체크박스) 변경시 배경 색상변경
     $(".board_list").on("change", "input[type='checkbox']", (evt) => {
         $(evt.target).closest("tr").addClass("is-modified");
     });

      /**************************************************************************
      ***********************       버튼 관련 이벤트         ***********************
      ***************************************************************************/

     // 검색권한 있는 사용자만 검색가능
     <c:if test="${USER_AUTH.READ_YN== 'Y'}">
     $("#btnSearch").on("click", (evt) => {
            searchConditionObj.menuDivCd     = on.html.getEleVal({ele : "#menuDivCd" });
            searchConditionObj.authId        = on.html.getEleVal({ele : "#authId" } );
            searchConditionObj.searchKeyCd   = on.html.getEleVal({ele : "#searchKeyCd"} )
            searchConditionObj.searchKeyWord = on.html.getEleVal({ele : "#searchKeyWord"} )
            searchData(); // Search Data
     });
     </c:if>

      // 저장권한 있는 사용자만 저장가능
     <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
          $("#btnSave").on("click", (evt) => {
              let updateTargetList = [];
              $(".board_list > tbody > tr.is-modified").each(function(indx , trObj){
                    let authMenuData = {
                            authId        : $(trObj).find("[id^='authId']").data("authid")
                          , menuCd        : $(trObj).find("[id^='authId']").data("menucd")
                          , useYn         : on.html.getEleVal({ele : $(trObj).find("[id^='useYn']")         })
                          , readYn        : on.html.getEleVal({ele : $(trObj).find("[id^='readYn']")        })
                          , writeYn       : on.html.getEleVal({ele : $(trObj).find("[id^='writeYn']")       })
                          , updateYn      : on.html.getEleVal({ele : $(trObj).find("[id^='updateYn']")      })
                          , deletYn       : on.html.getEleVal({ele : $(trObj).find("[id^='deletYn']")       })
                          , popupOpenYn   : on.html.getEleVal({ele : $(trObj).find("[id^='popupOpenYn']")   })
                          , popupReadYn   : on.html.getEleVal({ele : $(trObj).find("[id^='popupReadYn']")   })
                          , popupWiteYn   : on.html.getEleVal({ele : $(trObj).find("[id^='popupWiteYn']")   })
                          , popupUpdateYn : on.html.getEleVal({ele : $(trObj).find("[id^='popupUpdateYn']") })
                          , popupDeleteYn : on.html.getEleVal({ele : $(trObj).find("[id^='popupDeleteYn']") })
                         };
                    updateTargetList.push(authMenuData);
              });

              // 변경정보 수집 결과 확인
              if (updateTargetList.length === 0) {
                  on.msg.showMsg({message : "변경된 권한 정보가 없습니다."});
                  return;
              }

              if( on.msg.confirm({message : "저장하겠습니까?"}) == true ){
                  on.xhr.ajax({ cmd : "insert" , sql : "on.standard.system.authmenu.mergeMenuAuthMng"
                              , authMenuData  : updateTargetList // SQL수행시 ArrayList로 동작한다. MYSQL계열에서 VALUES(),()등으로 활용가능
                              , successFn  : function (data){
                                        on.msg.showMsg({message : "저장되었습니다."});
                                        $("#btnSearch").click();
                               }
                  });
              }
          });
     </c:if>

      // 그리드 헤더 체크박스 클릭
      $(".gridHeadChkBx").on("click", (evt) => {
          let $headChk = $(evt.target);
          let chkFunc = $headChk.data("func");
          let isChecked = $headChk.prop("checked");

          // tbody 안에서 해당 기능(chkFunc) 클래스를 가진 td를 찾고, 그 안의 checkbox 상태를 변경
          $(".board_list > tbody > tr input[type='checkbox'][class='chkFunc " + chkFunc + "']").prop("checked", isChecked);

          // (선택사항) 상태가 변경된 row의 배경색 처리를 위해 change 이벤트를 강제로 발생시킴
          $(".board_list > tbody > tr input[type='checkbox'][class='chkFunc " + chkFunc + "']").trigger("change");

      });

});
</script>
<div class="search_basic" style="padding-right: 280px;">
       <table>
          <caption>검색</caption>
          <colgroup>
                <col style="width: 100px;">
                <col style="width: 160px;">
                <col style="width: 80px;">
                <col style="width: 160px;">
                <col style="width: 80px;">
                <col>
          </colgroup>
          <tbody>
             <tr>
                <td><label>페이지 구분</label></td>
                <td>
                    <select id="menuDivCd" title="페이지구분 선택" class="w150"></select>
                </td>

                <td style="padding-left: 15px;"><label>권한</label></td>
                <td>
                    <select id="authId" title="권한 선택" class="w150"></select>
                </td>
                <td style="padding-left: 15px;"><label>검색</label></td>

                <td style="display: flex; gap: 5px;">
                    <select id="searchKeyCd" title="구분선택" class="w150"></select>
                    <input type="text" id="searchKeyWord" style="flex: 1;">
                </td>
             </tr>
          </tbody>
       </table>
       <c:if test="${USER_AUTH.READ_YN== 'Y'}">
          <button id="btnSearch" class="btn btn_search" style="right: 190px;"><i class="xi-search"></i>검색</button>
       </c:if>
       <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
          <button id="btnAdd" class="btn btn_reset" style="right: 105px;">추가</button>
          <button id="btnSave" class="btn btn_save" style="right: 20px;">저장</button>
       </c:if>
</div>
<div class="tbl">
    <table class="board_list">
        <caption>목록(번호, 그룹권한ID, 그룹권한명, 그룹권한설명, 사용구분, 등록일으로 구성)</caption>
        <colgroup>
            <col class="w5p"/>
            <col class="w5p"/>
            <col class="w5p"/>
            <col class="w5p"/>
            <col class="w20p"/>
            <col class="w20p"/>
            <col class="w5p"/>
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
                <th scope="col" >메뉴접근<br>가능여부</th>
                <th scope="col" rowspan="2">권한ID</th>
                <th scope="col" rowspan="2">메뉴그룹</th>
                <th scope="col" rowspan="2">LEVEL</th>
                <th scope="col" rowspan="2">메뉴명</th>
                <th scope="col" rowspan="2">URL</th>
                <th scope="col" rowspan="2" >메뉴CL</th>
                <th scope="col">읽기</th>
                <th scope="col">쓰기</th>
                <th scope="col">수정</th>
                <th scope="col">삭제</th>
                <th scope="col">팝업 열기</th>
                <th scope="col">팝업 읽기</th>
                <th scope="col">팝업 쓰기</th>
                <th scope="col">팝업 수정</th>
                <th scope="col">팝업 삭제</th>
            </tr>
            <tr>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkUseYnAll" checked="true" class="gridHeadChkBx" data-func="USEYN">
                      <label for="chkUseYnAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkRAll" checked="true" class="gridHeadChkBx" data-func="R">
                      <label for="chkRAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkWAll" checked="true" class="gridHeadChkBx" data-func="W">
                      <label for="chkWAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkUAll" checked="true" class="gridHeadChkBx" data-func="U">
                      <label for="chkUAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkDAll" checked="true" class="gridHeadChkBx" data-func="D">
                      <label for="chkDAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkPOAll" checked="true" class="gridHeadChkBx" data-func="PO">
                      <label for="chkPOAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkPRAll" checked="true" class="gridHeadChkBx" data-func="PR">
                      <label for="chkPRAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkPWAll" checked="true" class="gridHeadChkBx" data-func="PW">
                      <label for="chkPWAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                    <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkPUAll" checked="true" class="gridHeadChkBx" data-func="PU">
                      <label for="chkPUAll"></label>
                   </span></span>
                </th>
                <th scope="col">
                   <span class="chk"><span class="cbx">
                      <input type="checkbox" id="chkPDAll" checked="true" class="gridHeadChkBx" data-func="PD">
                      <label for="chkPDAll"></label>
                   </span></span>
                </th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>