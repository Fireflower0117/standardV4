 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
    $(document).ready(function(){
         /**************************************************************************
         ***********************        페이지 세팅            ***********************
         ***************************************************************************/

         // 공통코드 / 기타데이터 일괄조회
        let inqPageDataList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "rsTmcl"   , sqlCondi : { uppComCd : "TMCL"   } }  // 템플릿 구분 리스트
                                                                  , {rsId : "rsTmcl01" , sqlCondi : { uppComCd : "TMCL01" } }  // 통합 템플릿
                                                                  , {rsId : "rsTmcl02" , sqlCondi : { uppComCd : "TMCL02" } }  // 개별 템플릿
                                                        ]
                              });

        // 템블릿 구분 리스트
        $.each(inqPageDataList.rsTmcl , function(indx , info){
             let tmclItemHtml  =  "";
            if(indx === 0){
                tmclItemHtml  = "<li id='tab1_"+indx+"' role='tab' aria-selected='true' class='on'> ";
            }
            else{
                tmclItemHtml  = "<li id='tab1_"+indx+"' role='tab' aria-selected='false' class=''> ";
            }
            tmclItemHtml += "    <a href='javascript:void(0)' data-cdval='"+info.comCd+"'>"+info.cdNm+"</a> ";
            tmclItemHtml += "</li>";

            $("#ulTmclList").append(tmclItemHtml);
        });


        //통합 템플릿 유형
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#schEtc01" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                     , dataInfo      : inqPageDataList.rsTmcl01
                                     });

        // 개별 템플릿
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#schEtc02" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                     , dataInfo      : inqPageDataList.rsTmcl01
                                     });

        // 검색조건
        on.html.dynaGenSelectOptions({ targetInfo     : { targetId : "#searchKeyCd" }
                                      , addOption     : [{ position : "top" , txt : "전체" , val : "" }]
                                      , optionValInfo : { optId : "code" , optTxt : "text" }
                                      , dataInfo      : [ { code : "description" , text:"템플릿 설명" }  // code=1
                                                        , { code : "content"  , text:"에디터 내용" }      // code=2
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
            , sql             : "on.standard.system.menual.selMenualList"
            , schEtc00        : "TMCL01"
            , schEtc01        : on.html.getEleVal({ele : "#schEtc01"})
            , schEtc02        : on.html.getEleVal({ele : "#schEtc02"})
            , searchKeyCd     : $("#searchKeyCd :selected").val()
            , searchKeyWord   : $("#searchKeyWord").val()
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

            if(resource.length > 0){
                $.each(resource , function(indx , info){

                    let imgSrc = "/ma/images/common/no_img.png";
                    let imgClass = "noimage";

                    if (on.valid.isEmpty(info.prvwFileSerno)) {
                        imgSrc = "/tmplFile/getFileDown.do?tmplFileSerno=" + info.prvwFileSerno + "&fileSn=0";
                        imgClass = ""; // 실제 이미지가 있을 경우 클래스 제거 혹은 다른 클래스 부여
                    }

                    let galleryLi =  "<li>";
                        galleryLi += "   <a href='javascript:void(0)' data-serno='"+info.tmplSerno+"' >";
                        galleryLi += "	   <figure class='thum_img'>";
                        galleryLi += "        <img src='" + imgSrc + "' alt='image' class='" + imgClass + "' onerror=\"this.src='/ma/images/common/no_img.png'; this.className='noimage';\">";
                        galleryLi += "	   </figure>";
                        galleryLi += "	   <div class='thum_txt'>";
                        galleryLi += "	      <div class='mar_b5'>";
                        galleryLi += "           <span class='state red'>" + (info.tmplCl || '') + "</span>";
                        galleryLi += "           <span class='state blue'>" + (info.tmplTp || '') + "</span>";
                        galleryLi += "	      </div>";
                        galleryLi += "        <div class='tit'>" + (info.tmplExpl || '') + "</div>";
                        galleryLi += "        <div class='date'>" + (info.regDt || '') + "</div>";
                        galleryLi += "	   </div>";
                        galleryLi += "   </a>";
                        galleryLi += "</li>";
                        $("#galleryDisplayArea").append(galleryLi);
                });

                on.html.PageNationDisp({
                      pagingAreaId: "#pagenation"
                    , pageNo: resource[0].pageNo
                    , pageSize: resource[0].pageSize
                    , totalCount: resource[0].totalCount
                    , btnFnName: fnPageBtnClick
                });
            }
            else {
                 $("#galleryDisplayArea").html("<li class='no-data'>데이터가 없습니다.</li>");
            }
        }


    /**************************************************************************
    ********************       Component 관련 이벤트         ********************
    ***************************************************************************/

        $('.js_tmenu li a').click(function () {
            var cdVal = $(this).data("cdval")
            if(cdVal === "TMCL01"){
                $("#schEtc01").removeClass("disno");
                $("#schEtc02").addClass("disno");
            }else if(cdVal === "TMCL02"){
                $("#schEtc02").removeClass("disno");
                $("#schEtc01").addClass("disno");
            }
            $("#searchKeyCd").val("");
            $("#searchKeyWord").val("");

            searchConditionObj.schEtc00      = cdVal;
            searchConditionObj.schEtc01      = on.html.getEleVal({ele : "#schEtc01"});
            searchConditionObj.schEtc02      = on.html.getEleVal({ele : "#schEtc02"});
            searchConditionObj.searchKeyCd   = on.html.getEleVal({ele : "#searchKeyCd"});
            searchConditionObj.searchKeyWord = on.html.getEleVal({ele : "#searchKeyWord"});
            searchData();
        });

        // 검색 초기화
        $("#btnReset").on("click", () => {
           on.html.setEleVal({ele : "#searchKeyCd"  , val : "" });
           on.html.setEleVal({ele : "#searchKeyWord", val : "" });

           searchConditionObj.schEtc01      = on.html.getEleVal({ele : "#schEtc01"});
           searchConditionObj.schEtc02      = on.html.getEleVal({ele : "#schEtc02"});
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

        $('.gallery_wrap .thum_list li a').on('click', function(){
           //  fncPageBoard('update', 'updateForm.do', String($(this).data('serno')), 'tmplSerno');
           // return false;
        });


        <%-- 등록버튼 클릭시 --%>
        <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
            $('#btn_write').on('click', function(){
               //  fncPageBoard('write', 'insertForm.do');
                on.html.dynaGenHiddenForm({ formDefine : { fid       : "templateWriteForm", action: "/ma/usersupport/contTemplete/regist.do", method: "post", isSubmit : true }
                                                       , formAttrs : [ { name : "searchCondition" , value : JSON.stringify(searchConditionObj) }
                                                                     , { name : "tmplCl" , value : searchConditionObj.schEtc00 }
                                                                     , { name : "schEtc01" , value : on.html.getEleVal({ele : "#schEtc01"}) }
                                                                     , { name : "schEtc02" , value : on.html.getEleVal({ele : "#schEtc02"}) }
                                                                     ]
              });
            });
        </c:if>
    });
</script>

<div class="tab wide">
    <ul class="tab_menu js_tmenu mar_t15" role="tablist" id="ulTmclList"></ul>
</div>
<div class="search_basic">
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
                    <select id="schEtc01" name="schEtc01" class="w150" title="템플릿 유형선택"></select>
                    <select id="schEtc02" name="schEtc02" class="w150 disno mar_l0" title="템플릿 유형선택"></select>
                    <select id="searchKeyCd" name="searchKeyCd" title="구분선택" class="w150"></select>
                    <input type="text" id="searchKeyWord" name="searchKeyWord" class="w750"/>
                </td>
            </tr>
        </tbody>
    </table>
    <button type="button" class="btn btn_reset" id="btnReset"><i class="xi-refresh"></i>초기화</button>
    <button type="button" class="btn btn_search" id="btnSearch"><i class="xi-search"></i>검색</button>
</div>
<div class="tbl">
    <div class="board_top">
        <div class="board_left">
            <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num">0</span>건</div>
        </div>
        <div class="board_right">
            <button class="btn btn_excel" id="btn_excel">엑셀 다운로드</button>
            <select id="recordCountPerPage"></select>
        </div>
    </div>
    <div class="gallery_wrap">
        <ul class="thum_list" id="galleryDisplayArea"></ul>
    </div>
    <div class="paging_wrap">
        <ul class="paging"></ul>
         <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
            <div class="btn_right">
                <button type="button" id="btn_write" class="btn blue">등록</button>
            </div>
		 </c:if>
    </div>
</div>
