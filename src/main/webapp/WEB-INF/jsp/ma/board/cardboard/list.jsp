<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<style>
/* ul 태그를 바둑판(Grid/Flex) 형태로 정렬 */
.thumb_list ul {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    padding: 0;
    margin: 0;
    list-style: none;
}

/* 개별 카드(li)의 크기 지정 (예: 1줄에 3개씩) */
.thumb_list ul li {
    width: calc(33.333% - 14px);
    box-sizing: border-box;
    border: 1px solid #e1e1e1;
    border-radius: 8px;
    overflow: hidden;
}

/*  이미지 영역 크기 고정 및 비율 유지 */
.thumb_list .img_area {
    width: 100%;
    height: 180px;
    overflow: hidden;
    background-color: #f9f9f9;
}

.thumb_list .img_area img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
<script>
    $(document).ready(function(){


          /********************************************************************
           *********************     목록조회 관련 이벤트    *********************
           ********************************************************************/
          // 검색조건 설정
          let searchConditionObj = {
                  pageSize        : 15 // 한페이지에 보여질 기관수
                , cmd             : "selectPage"
                , sql             : "on.standard.board.sampleboard.inqCardBoardList"
          };

          // 화면 Load시 목록 조회
          searchData();

          // 검색 Function
          function searchData() {

            if( on.valid.isEmpty(searchConditionObj.pageNo)){
              searchConditionObj.pageNo = 1;
            }

            var sqlDispDiv          = "card_tab_columns";
            var dataDispTarget      = ".thumb_list > ul";

            const resource          = on.xhr.ajax(searchConditionObj);

            /* 페이지 건수 표기 */
            let totalCount = 0;
            if (resource.length > 0) { totalCount = resource[0].totalCount; }
            $(".all_num > .num").text(totalCount);

            /* Table List(목록) 표시 자료  */
            var displayInfoObj = {
                dispTarget    : dataDispTarget // 필요에 따라 분기처리하여 사용가능
              , dispDiv       : sqlDispDiv     // displayColInfos[sqlDispDiv] ==>> 기준으로 Table Tbody를 구성함 ( 하나의 Page에 여려개 탭이 있을경우 분기처리하여 사용)
              , resource      : resource
              , paginginfo    : {targetId : "#pagenation" , btnFnName : fnPageBtnClick } // 페이징처리될영역과 , 페이징버튼 Event (자동처리)
              , displayColInfos : {
                    card_tab_columns : [
                        {id: "rowindx"  , colType: "cardType" , data_id1:"atchFileId" }
                    ]
               }
            }

            // Table Display
            on.html.cardDisplay(displayInfoObj);
          }

          /********************************************************************
           *********************       버튼 관련 이벤트      *********************
           ********************************************************************/


          // Paging버튼 클릭
          function fnPageBtnClick(pageNo) {
             searchConditionObj.pageNo = pageNo;
             searchData();
          }


    });
</script>
<!-- content -->
<section class="content">
    <div class="wrap">
        <h3 data-aos="fade-up">지역별주요기관</h3>
        <div class="tbl" data-aos="fade-up">
            <div class="board_top">
                <div class="board_left">
                    <div class="all_num"><i class="xi-paper-o"></i>전체<span class="num">0</span>건</div>
                </div>
            </div>
            <!-- 지역별 주요기관 -->
            <div class="thumb_list">
                <ul></ul>
            </div>
            <div class="paging_wrap">
                <ul class="paging" id="pagenation"></ul>
            </div>
        </div>
    </div>

</section>
<!-- // content -->