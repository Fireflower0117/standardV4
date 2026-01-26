 const htmlFns = {

    tableDisplay : function(tarDispObj) {

        /** 사용법)
         *  var displayInfoObj = {
         dispTarget    : "#userlist_table > tbody"
         , dispDiv       : dispDivVal
         , resource      : opntAjaxPost(searchConditionObj )
         , paginginfo    : {targetId : "#pagination" , btnFnName : userPagingBtnClick }
         , displayColInfos : {
         list_for_userInfo :  [ {id:"rownum_"                      , align:"center"                                      }
         , {id:"equip_no"                     , align:"center"                                      }
         , {id:"equip_name"                   , align:"center"                                      }
         , {id:"org_headquarter_name"         , align:"center"                                      }
         , {id:"org_branch_name"              , align:"center"                                      }
         , {id:"item_volume_curr_num"         , align:"center" , colType:"double" , pattern : ".#"  }
         , {id:"item_rate_curr_num"           , align:"center" , colType:"double" , pattern : ".#"  }
         , {id:"equip_operation_status_name"  , align:"center"                                      }
         , {id:"obs_date_curr"                , align:"center"                                      }
         , {id:"equip_standard_code"          , align:"center"                                      }
         , {id:"favBtn_reservoir"             , colType:"button" , buttonTxt : "해제"  , classNm:"btn btn-link btn-xs" , data_id1:"equip_no"}]
         }
         opntTableDisplay(displayInfoObj);

         -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         displayInfoObj.dispTarget => DisplayTarget => 조회한 리스트를 어디에 표현할지 JquerySelector형태로 입력
         displayInfoObj.dispDiv    => displayInfoObj.dispDiv.displayColInfos내부 Array Key선택자 (일반적으로 SQLID )
         displayInfoObj.resource   => 조회한 DataList
         displayInfoObj.paginginfo => targetId   => Paging를 어디에 표현할지 선택자
         => btnFnName  => Paging버튼 클릭시 이벤트호출 함수  ex) function favoriteEquipPageBtnClick(pageNo)
         => displayInfoObj.paginginfo 속성이 없으면 Paging 처리 하지 않음 , 조회한 Data가 없으면 표현안함
         displayInfoObj.displayColInfos => { sqlid1:[] , sqlid2:[] , sqlid3:[] } 형태
         Array내부 id= displayInfoObj.resource의 DataColumn과 일치해야함 (대소문자 구분함)
         Array내부 align = 값의 정렬기준 left , cenger , rigth
         Array내부 colType = 값의 형태 (string , double , number  , hidden , button , checkbox ....... )
         Array내부 nullDisp = 값이 Null일 경우 Null표현 여부 (default : Y )
         */

        if (!tarDispObj.dispDiv) return false;
        var dispDiv = tarDispObj.dispDiv;
        var colInfo = eval("tarDispObj.displayColInfos." + dispDiv);
        var targetHtml = "";
        var colInfoLength = colInfo.length;

        if (!on.valid.isEmpty(colInfo)) {
            var resourceRowsLenght = tarDispObj.resource.length;
            if (resourceRowsLenght == 0) {
                $(tarDispObj.dispTarget).html("<tr><td colSpan='"+colInfoLength+"' class='no_data'>데이터가 없습니다.</td></tr>");
                if (!on.valid.isEmpty(tarDispObj.paginginfo)) {
                    $(tarDispObj.paginginfo.targetId).html("");
                    if (!on.valid.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                        $(tarDispObj.paginginfo.totRowsCntId).text("0");
                    }
                }
            } else {
                var totRowCnt = 0;
                for (var i = 0; i < resourceRowsLenght; i++) {

                    targetHtml += "<tr>";
                    for (var j = 0; j < colInfoLength; j++) {
                        let resourceRow = tarDispObj.resource[i];
                        let colId = colInfo[j].id;
                        let colType = on.str.nvl(colInfo[j].colType, "string");
                        let colAlign = on.str.nvl(colInfo[j].align, "center");
                        let colStyle = on.str.nvl(colInfo[j].style, "");
                        //var colClassNm  = on.str.nvl(colInfo[j].classNm  , "");
                        let uniqId = colInfo[j].id + "_" + on.str.nvl(resourceRow.rownum_, i);
                        let tarUniqId = " id='" + uniqId + "' ";
                        let tarUniqNm = " name='" + uniqId + "' ";
                        let tarUniqFor = " for='" + uniqId + "' ";
                        let tarClassNm = on.str.nvl(colInfo[j].classNm) == "" ? "" : " class='" + colInfo[j].classNm + "'";
                        let tarStyleNm = on.str.nvl(colInfo[j].styleNm) == "" ? "" : " style='" + colInfo[j].styleNm + "'";
                        let tarColValue = on.str.nvl(resourceRow[colInfo[j].id], "");
                        //var nullDisp    = on.str.nvl(colInfo[j].nullDisp , "Y");

                        var dataPropsHtml = "";
                        if (i == 0 && j == 0) {
                            totRowCnt = resourceRow.totalCount;
                        }

                        for (var k = 1; k <= 10; k++) {
                            var dataProp = on.str.nvl(colInfo[j]["data_id" + k], "anonymous");
                            if ("anonymous" != dataProp) {
                                tarDispObj.resource[i][dataProp]
                                var dataPropVal = on.str.nvl(tarDispObj.resource[i][dataProp], "");
                                dataPropsHtml += " data-" + dataProp + "='" + dataPropVal + "' ";
                            }
                        }
                        if (colType == "string") {
                            targetHtml += "<td " + tarUniqId + " " + tarStyleNm + " " + tarClassNm + " " + dataPropsHtml + ">" + tarColValue + "</td>";
                        } else if (colType == "double") {
                            var colDblPattrn = on.str.nvl(colInfo[j].pattern, ".##");
                            var colDblPattrnLen = opntInStrCount(colDblPattrn, "#");

                            var colDblVal = Number(on.str.nvl(tarColValue, 0)).toFixed(colDblPattrnLen);
                            if (colDblVal == 0) colDblVal = on.valid.isEmpty(colInfo[j].zero) ? colDblVal : colInfo[j].zero;

                            targetHtml += "   <td " + tarUniqId + " " + tarUniqNm + " " + dataPropsHtml + ">" + colDblVal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + "</td>";

                        } else if (colType == "number") {
                            if ($.isNumeric(tarColValue)) {
                                targetHtml += "   <td " + tarUniqId + " " + dataPropsHtml + " " + tarStyleNm + " " + tarClassNm + ">" + ("" + Math.round(tarColValue, 1)).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + "</td>";
                            } else {
                                targetHtml += "   <td " + tarUniqId + " " + dataPropsHtml + " " + tarStyleNm + " " + tarClassNm + ">" + (on.valid.isEmpty(colInfo[j].zero) ? "0" : colInfo[j].zero) + "</td>";
                            }
                        } else if (colType == "hidden") {
                            targetHtml += "   <td style='display: none;' " + tarUniqId + " " + dataPropsHtml + " " + tarStyleNm + " " + tarClassNm + ">" + tarColValue + "</td>";
                        } else if (colType == "button") {
                            let tarBtnText = on.str.nvl(resourceRow[colInfo[j].btnText], "")
                            targetHtml += "  <td style='text-align:center;'>";
                            targetHtml += "  	<button type='button' " + tarUniqId + " style='" + colStyle + "' " + tarStyleNm + " " + tarClassNm + " " + dataPropsHtml + ">" + tarBtnText + "</button>";
                            targetHtml += "  </td>";
                        } else if (colType == "checkbox") {
                            let chkValue = on.valid.isEmpty(colInfo[j].classNm) ? "" : " value='" + colInfo[j].classNm + "'";
                            var strChecked = tarColValue == "Y" ? "checked" : "";
                            targetHtml += "<td style='text-align:center;'>";
                            targetHtml += "   <input type='checkbox' " + tarUniqId + " " + chkValue + " " + tarStyleNm + " " + tarClassNm + " " + dataPropsHtml + " " + strChecked + "/>";
                            targetHtml += "</td>";
                        } else if (colType == "text") {
                            targetHtml += "<td style='text-align:center;'>";
                            targetHtml += "	  <input type='text' " + tarUniqId + " " + tarStyleNm + " " + tarClassNm + " " + dataPropsHtml + "  value='" + tarColValue + "' >";
                            targetHtml += "</td>";
                        } else if (colType == "datepicker") {
                            targetHtml += "<td style='text-align:center;'>";
                            targetHtml += "	  <input type='text' data-cellTp='datePicker' " + tarUniqId + " " + tarUniqNm + " " + tarClassNm + "  " + tarStyleNm + "  value='" + tarColValue + "' " + dataPropsHtml + " readonly>";
                            targetHtml += "</td>";
                        } else if (colType == "fileIcon") {
                            // file_${ext}.svg 형태로 이미지를 가져옴.
                            let ext = on.str.nvl(resourceRow[colInfo[j].id], "");

                            const imgExts = new Set(["jpg", "jpeg", "png", "gif", "bmp", "tif", "tiff", "svg"]);
                            const excelExts = new Set(["xlsx", "xls"]);
                            const hwpExts = new Set(["hwp", "hwpx"]);
                            const wordExts = new Set(["doc", "word", "docx", "csv"]);
                            const pptExts = new Set(["ppt", "pptx"]);
                            const zipExts = new Set(["7zip", "egg"]);
                            const etcExts = new Set(["txt", "xml"]);

                            if (imgExts.has(ext)) {
                                ext = "img";
                            } else if (excelExts.has(ext)) {
                                ext = "excel";
                            } else if (hwpExts.has(ext)) {
                                ext = "hwp";
                            } else if (wordExts.has(ext)) {
                                ext = "word";
                            } else if (pptExts.has(ext)) {
                                ext = "ppt";
                            } else if (zipExts.has(ext)) {
                                ext = "zip";
                            }

                            targetHtml += "<td style='text-align:center;'>";
                            if (ext) {
                                targetHtml += "	  <img " + tarUniqId + " " + tarUniqNm + "  " + tarClassNm + "  " + tarStyleNm + " " + dataPropsHtml + " src='/ft/images/icon/file_" + ext + ".svg' alt='" + ext + "' >";
                            } else {
                                targetHtml += "   <div " + tarUniqId + " " + tarUniqNm + "  " + tarClassNm + "  " + tarStyleNm + " " + dataPropsHtml + ">-</div>";
                            }
                            targetHtml += "</td>";
                        }
                        else if (colType == "tdClass") {
                            targetHtml += "<td " + dataPropsHtml + " " + tarClassNm + ">" + tarColValue + "</td>";
                        }
                        else if (colType == "kpsTitle") {
                            targetHtml += "<td class='ellipsis'><a " + dataPropsHtml + " class='ellipsis td_view'>" + tarColValue + "</a></td>";
                        }
                        else if (colType == "kpsLTitle") {
                            targetHtml += "<td class='l ellipsis'><a " + dataPropsHtml + "   class='ellipsis td_view'>" + tarColValue + "</a></td>";
                        }
                        else if (colType == "kpsLTitleNew") {
                            let addNew = ""
                            if(resourceRow.isNew) {
                                addNew = "<span class='new'>NEW</span>";
                            }
                            targetHtml += "<td class='l ellipsis'><a " + dataPropsHtml + "   class='ellipsis td_view'>" + tarColValue + "</a>"+addNew+"</td>";

                        }
                        else if(colType == "hasFile"){
                            if(tarColValue == "HAS"){
                                targetHtml += "<td><img src='/ma/images/icon/i_clip.svg' alt='첨부파일'></td>";
                            }
                            else {
                                targetHtml += "<td></td>";
                            }
                        }
                        else if(colType == "recruitDDay") {
                            if(tarColValue < 0){
                                targetHtml += "<td><span class='badge gray'>공고마감</span></td>";
                            }
                            else {
                                targetHtml += "<td><span class='badge blue'>D-"+tarColValue+"</span></td>";
                            }
                        }
                        else if(colType == "bltnbConfm") {
                            if(tarColValue == "Y"){
                                targetHtml += "<td><img src='/ma/images/icon/check_ok.svg' alt='확인'></td>";
                            }
                            else {
                                targetHtml += "<td><img src='/ma/images/icon/check_no.svg' alt='미확인'></td>";
                            }
                        }
                        else if(colType == "kpSrOnly") {
                            if(resourceRow.ntiYn == 'Y'){
                                targetHtml += "<td class='number'><span class='notice'><span class='sr_only'>공지</span></span></td>";
                            }
                            else {
                                targetHtml += "<td class='number'>" + tarColValue + "</td>";
                            }
                        }
                        else if(colType == "kpSmsSendChkBx"){
                            targetHtml += "<td>";
                            targetHtml += "   <span class='chk'>";
                            targetHtml += "      <span class='cbx'><input type='checkbox' id='smsSendCbx_"+resourceRow.userSerno+"' "+dataPropsHtml+" ><label for='smsSendCbx_"+resourceRow.userSerno+"'><span class='sr_only'>선택</span></label></span>";
                            targetHtml += "   </span>";
                            targetHtml += "</td>";
                        }


                    }
                    targetHtml += "</tr>";

                    $(tarDispObj.dispTarget).empty();
                    $(tarDispObj.dispTarget).html(targetHtml);
                }

                // Paging Area Renderer
                if (!on.valid.isEmpty(tarDispObj.paginginfo)) {

                    if (!on.valid.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                        $(tarDispObj.paginginfo.totRowsCntId).text(totRowCnt);
                    }


                    var isDel = on.str.nvl(tarDispObj.paginginfo.clear, false);
                    if (on.str.nvl(tarDispObj.paginginfo.clear, false)) {
                        $(tarDispObj.paginginfo.targetId).html("");
                    } else {
                        on.html.PageNationDisp({
                            pagingAreaId: tarDispObj.paginginfo.targetId
                            , pageNo: tarDispObj.resource[0].pageNo
                            , pageSize: tarDispObj.resource[0].pageSize
                            , totalCount: tarDispObj.resource[0].totalCount
                            , btnFnName: tarDispObj.paginginfo.btnFnName
                        });
                    }
                }
            }
        }

        // DatePicker적용
        $.each($(tarDispObj.dispTarget).find("[data-cellTp='datePicker']"), function (indx, ele) {
            on.html.setDatePicker("#" + $(ele).attr("id"));
        });
    } ,
    cardDisplay : function(tarDispObj) {

        /** 사용법)
         *  var displayInfoObj = {
         dispTarget    : "#userlist_table > tbody"
         , dispDiv       : dispDivVal
         , resource      : opntAjaxPost(searchConditionObj )
         , paginginfo    : {targetId : "#pagination" , btnFnName : userPagingBtnClick }
         , displayColInfos : {
         list_for_userInfo :  [ {id:"rownum_"                      , align:"center"                                      }
         , {id:"equip_no"                     , align:"center"                                      }
         , {id:"equip_name"                   , align:"center"                                      }
         , {id:"org_headquarter_name"         , align:"center"                                      }
         , {id:"org_branch_name"              , align:"center"                                      }
         , {id:"item_volume_curr_num"         , align:"center" , colType:"double" , pattern : ".#"  }
         , {id:"item_rate_curr_num"           , align:"center" , colType:"double" , pattern : ".#"  }
         , {id:"equip_operation_status_name"  , align:"center"                                      }
         , {id:"obs_date_curr"                , align:"center"                                      }
         , {id:"equip_standard_code"          , align:"center"                                      }
         , {id:"favBtn_reservoir"             , colType:"button" , buttonTxt : "해제"  , classNm:"btn btn-link btn-xs" , data_id1:"equip_no"}]
         }
         opntTableDisplay(displayInfoObj);

         -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         displayInfoObj.dispTarget => DisplayTarget => 조회한 리스트를 어디에 표현할지 JquerySelector형태로 입력
         displayInfoObj.dispDiv    => displayInfoObj.dispDiv.displayColInfos내부 Array Key선택자 (일반적으로 SQLID )
         displayInfoObj.resource   => 조회한 DataList
         displayInfoObj.paginginfo => targetId   => Paging를 어디에 표현할지 선택자
         => btnFnName  => Paging버튼 클릭시 이벤트호출 함수  ex) function favoriteEquipPageBtnClick(pageNo)
         => displayInfoObj.paginginfo 속성이 없으면 Paging 처리 하지 않음 , 조회한 Data가 없으면 표현안함
         displayInfoObj.displayColInfos => { sqlid1:[] , sqlid2:[] , sqlid3:[] } 형태
         Array내부 id= displayInfoObj.resource의 DataColumn과 일치해야함 (대소문자 구분함)
         Array내부 align = 값의 정렬기준 left , cenger , rigth
         Array내부 colType = 값의 형태 (string , double , number  , hidden , button , checkbox ....... )
         Array내부 nullDisp = 값이 Null일 경우 Null표현 여부 (default : Y )
         */

        if (!tarDispObj.dispDiv) return false;
        var dispDiv = tarDispObj.dispDiv;
        var colInfo = eval("tarDispObj.displayColInfos." + dispDiv);
        var targetHtml = "";
        var colInfoLength = colInfo.length;

        if (!on.valid.isEmpty(colInfo)) {
            var resourceRowsLenght = tarDispObj.resource.length;
            if (resourceRowsLenght == 0) {
                $(tarDispObj.dispTarget).html("<li class='no_data'><p>데이터가 없습니다.</p></li>");
                if (!on.valid.isEmpty(tarDispObj.paginginfo)) {
                    $(tarDispObj.paginginfo.targetId).html("");
                    if (!on.valid.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                        $(tarDispObj.paginginfo.totRowsCntId).text("0");
                    }
                }
            } else {
                var totRowCnt = 0;
                for (var i = 0; i < resourceRowsLenght; i++) {

                    for (var j = 0; j < colInfoLength; j++) {
                        let resourceRow = tarDispObj.resource[i];
                        let colId = colInfo[j].id;
                        let colType = on.str.nvl(colInfo[j].colType, "string");
                        let colAlign = on.str.nvl(colInfo[j].align, "center");
                        let colStyle = on.str.nvl(colInfo[j].style, "");
                        //var colClassNm  = on.str.nvl(colInfo[j].classNm  , "");
                        let uniqId = colInfo[j].id + "_" + on.str.nvl(resourceRow.rownum_, i);
                        let tarUniqId = " id='" + uniqId + "' ";
                        let tarUniqNm = " name='" + uniqId + "' ";
                        let tarUniqFor = " for='" + uniqId + "' ";
                        let tarClassNm = on.str.nvl(colInfo[j].classNm) ? "" : " class='" + colInfo[j].classNm + "'";
                        let tarStyleNm = on.str.nvl(colInfo[j].styleNm) ? "" : " style='" + colInfo[j].styleNm + "'";
                        let tarColValue = on.str.nvl(resourceRow[colInfo[j].id], "");
                        //var nullDisp    = on.str.nvl(colInfo[j].nullDisp , "Y");

                        var dataPropsHtml = "";
                        if (i == 0 && j == 0) {
                            totRowCnt = resourceRow.totalCount;
                        }

                        for (var k = 1; k <= 10; k++) {
                            var dataProp = on.str.nvl(colInfo[j]["data_id" + k], "anonymous");
                            if ("anonymous" != dataProp) {
                                tarDispObj.resource[i][dataProp]
                                var dataPropVal = on.str.nvl(tarDispObj.resource[i][dataProp], "");
                                dataPropsHtml += " data-" + dataProp + "='" + dataPropVal + "' ";
                            }
                        }

                        if (colType == "rapaRegion") {

                            targetHtml += "<li "+dataPropsHtml+">";
                            targetHtml += "    <a href='"+resourceRow.BLTNB_CTT+"' target='_blank' title='새 창 열기'>";
                            targetHtml += "        <div class='img_area'>";
                            targetHtml += "            <img src='/file/getImage.do?atchFileId="+resourceRow.ATCH_FILE_ID+"&fileSeqo="+resourceRow.FILE_SEQ+"&fileNmPhclFileNm="+resourceRow.PHCL_FILE_NM+"' "+dataPropsHtml+" alt='사이트명 로고'>";
                            targetHtml += "        </div>";
                            targetHtml += "        <p>"+resourceRow.BLTNB_TITL+"</p>";
                            targetHtml += "    </a>";
                            targetHtml += "</li>";

                        }
                    }

                    $(tarDispObj.dispTarget).empty();
                    $(tarDispObj.dispTarget).html(targetHtml);
                }

                // Paging Area Renderer
                if (!on.valid.isEmpty(tarDispObj.paginginfo)) {

                    if (!on.valid.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                        $(tarDispObj.paginginfo.totRowsCntId).text(totRowCnt);
                    }


                    var isDel =  on.str.nvl(tarDispObj.paginginfo.clear, false);
                    if (on.str.nvl(tarDispObj.paginginfo.clear, false)) {
                        $(tarDispObj.paginginfo.targetId).html("");
                    } else { 
                        on.html.PageNationDisp({
                            pagingAreaId: tarDispObj.paginginfo.targetId
                            , pageNo: tarDispObj.resource[0].pageNo
                            , pageSize: tarDispObj.resource[0].pageSize
                            , totalCount: tarDispObj.resource[0].totalCount
                            , btnFnName: tarDispObj.paginginfo.btnFnName
                        });
                    }
                }
            }
        }

        // DatePicker적용
        $.each($(tarDispObj.dispTarget).find("[data-cellTp='datePicker']"), function (indx, ele) {
            on.html.setDatePicker("#" + $(ele).attr("id"));
        });
    }

    , PageNationDisp : function(pagingInfoObj) {

        var pageDiv = $(pagingInfoObj.pagingAreaId)
            , totalPage = Math.ceil(pagingInfoObj.totalCount / pagingInfoObj.pageSize)
            //, 	totalGroup = Math.ceil(totalPage/10)
            , totalGroup = Math.ceil(pagingInfoObj.totalCount / 10)
            , prevGroupNo
            , nextGroupNo
            , pageStart
            , pageEnd
            , groupSize = 10
            , nowGroup = parseInt((pagingInfoObj.pageNo - 0.1) / groupSize)
            , tags = null;

        if (nowGroup <= 0) prevGroupNo = 1;
        else prevGroupNo = (nowGroup - 1) * groupSize + 1;

        nextGroupNo = Math.min((nowGroup + 1) * groupSize + 1, totalPage);

        /*
            tags = "<ul ><li ><span style='cursor:pointer;' pageNo='1'>처음</span></li>"
                + "<li ><span style='cursor:pointer;' pageNo='" + prevGroupNo + "'>이전</span></li>";
        */
        tags = "<li class='btn_page first'><a pageNo='1' title='처음'></a></li>"
            + "<li class='btn_page prev'><a pageNo='" + prevGroupNo + "' title='이전'></a></li>";

        pageStart = nowGroup * 10 + 1;
        pageEnd = pageStart + 10;

        if ((totalPage + 1) < pageEnd) {
            pageEnd = totalPage + 1;
        }

        for (var i = pageStart; i < pageEnd; i++) {
            if (pagingInfoObj.pageNo == i) {
                tags += "<li class='current'><a pageNo='" + i + "'>" + i + "</a></li>"
            } else {
                tags += "<li><a pageNo='" + i + "'>" + i + "</a></li>"
            }
        }

        tags += "<li class='btn_page next'><a pageNo='" + nextGroupNo + "' title='다음'></a></li>"
            + "<li class='btn_page last'><a pageNo='" + totalPage + "' title='마지막'></a></li>";

        pageDiv.html(tags);

        if (pagingInfoObj.pageNo == 1) {
            $(pagingInfoObj.pagingAreaId + " li:eq(0)").addClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(0) > a").css("cursor", "default");
        } else {
            $(pagingInfoObj.pagingAreaId + " li:eq(0)").removeClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(0) > a").css("cursor", "pointer");
        }

        if (pagingInfoObj.pageNo == totalPage) {
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1)").addClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1) > a").css("cursor", "default");
        } else {
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1)").removeClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1) > a").css("cursor", "pointer");
        }

        if (prevGroupNo == 0) {
            $(pagingInfoObj.pagingAreaId + " li:eq(1)").addClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(1) > a").css("cursor", "default");
        } else {
            $(pagingInfoObj.pagingAreaId + " li:eq(1)").removeClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(1) > a").css("cursor", "pointer");
        }

        if (nextGroupNo == 0) {
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(2)").addClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(2) > a").css("cursor", "default");
        } else {
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(2)").removeClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(2) > a").css("cursor", "pointer");
        }

        $(pagingInfoObj.pagingAreaId + " li[class !='disabled'] > a").on("click", function () {
            pagingInfoObj.btnFnName($(this).attr("pageNo"));
        });
    }
    , dynaGenHiddenForm : function(formInfo) {
        /* var formInfo = { formDefine : { fid:"" , fname:"" , target:"" , action:"" , method : "" , classNm : "" , style:"" }
                          , formAttrs  : { equip_no    : {name : "" , val:"" }
                                         , date_upload : {name : "" , val:"" }
                                         }
                          }
        */

        /*$("body").append("<form id='FormExcel' name='FormExcel' method='post'></form>");
        $("#FormExcel").attr("action",excelDownUrl);
        $("#FormExcel").submit();
        $("#FormExcel").remove();*/

        if (on.valid.isEmpty(formInfo.formDefine.fid)) return false;

        var formId = formInfo.formDefine.fid;
        var formName = on.valid.isEmpty(formInfo.formDefine.fname) ? formId : formInfo.formDefine.fname;
        var formAction = on.valid.isEmpty(formInfo.formDefine.action) ? "" : " action='" + formInfo.formDefine.action + "'";
        var formEncType = on.valid.isEmpty(formInfo.formDefine.enctype) ? "application/json" : formInfo.formDefine.enctype;
        var formTarget = on.valid.isEmpty(formInfo.formDefine.fTarget) ? "" : " target='" + formInfo.formDefine.fTarget + "'";
        var paramMethod = on.valid.isEmpty(formInfo.formDefine.method) ? "post" : formInfo.formDefine.method;
        if (paramMethod.toUpperCase() != "GET" && paramMethod.toUpperCase() != "POST") paramMethod = "post";
        let formMethod = " method='" + paramMethod + "'";
        var formClass = on.valid.isEmpty(formInfo.formDefine.classNm) ? "" : " class='" + formInfo.formDefine.classNm + "'";
        var formStyle = on.valid.isEmpty(formInfo.formDefine.style) ? "" : " style='" + formInfo.formDefine.style + "'";
        var insertTrget = on.valid.isEmpty(formInfo.formDefine.insTarget) ? "body" : formInfo.formDefine.insTarget;


        var inputAttrsHtml = "";
        if (!on.valid.isEmpty(formInfo.formAttrs)) {
            var formAttrsKeys = Object.keys(formInfo.formAttrs);
            let fileNmIndx = 0;
            for (var i = 0; i < formAttrsKeys.length; i++) {
                var inputEleObj = eval("formInfo.formAttrs." + formAttrsKeys[i]);
                var eleName = on.valid.isEmpty(inputEleObj.name) ? formAttrsKeys[i] : inputEleObj.name;
                var eleType = on.valid.isEmpty(inputEleObj.type) ? "hidden" : inputEleObj.type;
                var eleVal = on.valid.isEmpty(inputEleObj.val) ? "''" : inputEleObj.val;

                if (eleType == "file") {
                    inputAttrsHtml += "<input type='" + eleType + "' id='" + formAttrsKeys[i] + "' name='" + eleName + "'                    style='display:none;' >";
                } else if (eleType == "files") {
                    if (!on.valid.isEmpty(eleVal)) {
                        let fileIdx = 0;
                        for (inpFile of eleVal.toArray()) {
                            inputAttrsHtml += "<input type='file' name='" + eleName + "_" + fileIdx + "'   style='display:none;'>";
                            fileIdx++;
                        }
                        fileNmIndx++;
                    }
                } else {
                    inputAttrsHtml += "<input type='" + eleType + "' id='" + formAttrsKeys[i] + "' name='" + eleName + "' value='" + eleVal + "' style='display:none;' >";
                }
            }
        }

        var formHtml = "<form id='" + formId + "' name='" + formName + "' enctype='" + formEncType + "' " + formAction + " " + formTarget + " " + formMethod + " " + formClass + " " + formStyle + ">";
        formHtml += inputAttrsHtml;
        formHtml += "</form>";

        $(insertTrget).find("#" + formId).remove();
        $(insertTrget).append(formHtml);

        if (!on.valid.isEmpty(formInfo.formAttrs)) {
            var formAttrsKeys = Object.keys(formInfo.formAttrs);
            for (var i = 0; i < formAttrsKeys.length; i++) {
                var inputEleObj = eval("formInfo.formAttrs." + formAttrsKeys[i]);
                var eleName = on.valid.isEmpty(inputEleObj.name) ? formAttrsKeys[i] : inputEleObj.name;
                var eleType = on.valid.isEmpty(inputEleObj.type) ? "hidden" : inputEleObj.type;
                var eleVal = on.valid.isEmpty(inputEleObj.val) ? "''" : inputEleObj.val;

                if (eleType == "file") {
                    var colneFile = $(eleVal).clone(true);
                    $("#" + formId + " [name='" + eleName + "']")[0].files = colneFile[0].files;
                } else if (eleType == "files") {

                    if (eleVal.length > 0) {
                        let eleNmFileIndex = 0;
                        for (let fileIndx in eleVal.toArray()) {
                            let originalFiles = eleVal[fFileIndx].files;
                            if (originalFiles.length > 0) {

                                //for(dFileIndx in Object.keys(originalFiles) ){
                                var fileInput = $("#" + formId + " [name='" + eleName + "_" + eleNmFileIndex + "']")[0]; // 대상 input 요소

                                var dataTransfer = new DataTransfer();
                                dataTransfer.items.add(originalFiles["0"]); // 첫 번째 파일만 추가 
                                on.msg.consoleLog("===============================================");
                                on.msg.consoleLog("eleName : " + eleName);
                                on.msg.consoleLog("fileName : " + originalFiles["0"].name);


                                on.msg.consoleLog("fileInput : " + fileInput);
                                on.msg.consoleLog("dFileIndx : " + fFileIndx);
                                on.msg.consoleLog("dataTransfer.files : " + dataTransfer.files);
                                on.msg.consoleLog("#" + formId + " [name='" + eleName + "_" + eleNmFileIndex + "']");

                                fileInput.files = dataTransfer.files; // 새 파일 리스트 적용
                                eleNmFileIndex++;
                                // }
                            }
                        }
                    }
                }
            }
        }

        if (formInfo.formDefine.isSubmit === true) {
            if (formEncType == "multipart/form-data") {

                formInfo.formDefine.action = on.valid.isEmpty(formInfo.formDefine.action) ? "/com/files/opntUpload.ajx" : formInfo.formDefine.action;
                $("#" + formId).ajaxForm({
                    url: formInfo.formDefine.action
                    , encType: formEncType
                    , dataType: "json"
                    , beforeSubmit: function (data, form, option) {
                        messageFns.showProgress();
                        var indx = 0;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].type == "file") {
                                var fileInfo = $(data[i].value)[0];
                                if (fileInfo) {
                                    console.log("indx : " + indx + " , fileName : " + fileInfo.name + " , fileSize : " + fileInfo.size);
                                    indx++;
                                }
                            }
                        }

                    }
                    , success: function (result) {
                        messageFns.hideProgress();
                        if (formInfo.succFn && typeof formInfo.succFn === "function") {
                            formInfo.succFn.call(this, result)
                        }

                    }
                    , error(data, status, err) {
                        messageFns.hideProgress();
                        console.log("error 발생 : " + data);
                    }
                }).submit();
            } else {
                $("#" + formId).submit();
            }
        }
    }
    , dynaGenWrapperForm (wrapInfoObj){

      }
    , dynaGenCheckboxes(optionsInfoObj) {
        /* Developer: sh.jang */
        if (on.valid.isEmpty(optionsInfoObj.checkInfo.targetId)) return false;


        // targetId에서 모든 특수문자 및 공백을 제거하는 코드
        let regex = new RegExp('[^ㄱ-ㅎ가-힣a-zA-Z0-9]', 'g');
        const tempNm = optionsInfoObj.checkInfo.targetId.replace(regex, '');

        const checkProp = optionsInfoObj.checkProp;
        const checkNm = on.valid.isEmpty(checkProp.checkNm) ? tempNm : checkProp.checkNm;
        const checkId = on.valid.isEmpty(checkProp.checkId) ? tempNm : checkProp.checkId;
        const prefix = on.valid.isEmpty(checkProp.prefix) ? "" : checkProp.prefix;
        const suffix = on.valid.isEmpty(checkProp.suffix) ? "" : checkProp.suffix;

        let inputHtml = "";
        let inputCnt = 0;
        if (!on.valid.isEmpty(optionsInfoObj.checkDataInfo)) {
            for (let data of optionsInfoObj.checkDataInfo) {
                let optionVal = data[optionsInfoObj.optionValInfo.optCode]
                let optionText = data[optionsInfoObj.optionValInfo.optTxt]

                if (prefix != "") inputHtml += prefix;
                inputHtml += `<input type="checkbox" name="${checkNm}" id="${checkId}${inputCnt}" value="${optionVal}"><label for="${checkId}${inputCnt}">${optionText}</label>`;
                if (suffix != "") inputHtml += suffix;
                inputCnt++;
            }
        }
        $(optionsInfoObj.checkInfo.targetId).empty().html(inputHtml);
    } ,


    // select Box Option 갱신
    dynaGenSelectOptions : function(optionsInfoObj) {

        if (on.valid.isEmpty(optionsInfoObj.comboInfo.targetId)) return false;  // options을 어디에 INPUT할지 지정안하면 return

        var optPosition = "", optTxt = "", optVal = "";
        if (!on.valid.isEmpty(optionsInfoObj.addOption)) {
            optPosition = on.str.nvl(optionsInfoObj.addOption.position, "TOP");
            optTxt = on.str.nvl(optionsInfoObj.addOption.txt, "선택");
            optVal = on.str.nvl(optionsInfoObj.addOption.val, " ");
        }

        var inputOptionHtml = "";
        if (optPosition.toUpperCase() == "TOP") {
            inputOptionHtml += "<option value='" + optVal + "' >" + optTxt + "</option>";
        }

        var optionCnt = 0;
        if (!on.valid.isEmpty(optionsInfoObj.comboDataInfo)) {
            for (let data of optionsInfoObj.comboDataInfo) {
                var optionVal = data[optionsInfoObj.optionValInfo.optId]
                var optionText = data[optionsInfoObj.optionValInfo.optTxt]
                inputOptionHtml += "<option value='" + optionVal + "'>" + optionText + "</option>";
                optionCnt++;
            }
        }

        if (optPosition.toUpperCase() == "BOTTOM") {
            inputOptionHtml += "<option value='" + optVal + "' >" + optTxt + "</option>";
        }

        // 페이지가 열릴때 기본옵션 선택 (기준 : 값)
        $(optionsInfoObj.comboInfo.targetId).empty().html(inputOptionHtml);
        if (!on.valid.isEmpty(optionsInfoObj.optionValInfo.defaultVal)) {
            if ($(optionsInfoObj.comboInfo.targetId).length > 0) {
                $(optionsInfoObj.comboInfo.targetId).val(optionsInfoObj.optionValInfo.defaultVal)
            }
        }

        // 페이지가 열릴때 기본옵션 선택 (기준 : index)
        if (!on.valid.isEmpty(optionsInfoObj.optionValInfo.defaultIndex)) {
            if ($(optionsInfoObj.comboInfo.targetId).length > 0) {
                $(optionsInfoObj.comboInfo.targetId + " option:eq(" + optionsInfoObj.optionValInfo.defaultIndex + ")").prop("selected", true);
            }
        }

        // CallBack Function
        if(!on.valid.isEmpty( optionsInfoObj.callBackFn) && typeof optionsInfoObj.callBackFn === 'function'){
            optionsInfoObj.callBackFn.call(this, optionsInfoObj );
        }
    },

    DynaGenRadio(radioOptionObj) {

        if (on.valid.isEmpty(radioOptionObj.radioInfo.targetId)) return false;
        if (!on.valid.isEmpty(radioOptionObj.radioInfo.classNm)) {
            $(radioOptionObj.radioInfo.targetId).addClass(radioOptionObj.radioInfo.classNm);
        }

        var radioId = on.valid.isEmpty(radioOptionObj.radioProp.radioId) ? "tmpRadioId" : radioOptionObj.radioProp.radioId;
        var radioNm = on.valid.isEmpty(radioOptionObj.radioProp.radioNm) ? "tmpRadioNm" : radioOptionObj.radioProp.radioNm;
        var radioClassNm = on.valid.isEmpty(radioOptionObj.radioProp.classNm) ? " " : radioOptionObj.radioProp.classNm;
        var radioStyle = on.valid.isEmpty(radioOptionObj.radioProp.style) ? " " : radioOptionObj.radioProp.style;
        var radioPrefix = on.valid.isEmpty(radioOptionObj.radioProp.prefix) ? "" : radioOptionObj.radioProp.prefix;
        var radioSuffix = on.valid.isEmpty(radioOptionObj.radioProp.suffix) ? "" : radioOptionObj.radioProp.suffix;

        var radioHtml = "";
        if (!on.valid.isEmpty(radioOptionObj.radioDataInfo)) {
            var optCode = on.valid.isEmpty(radioOptionObj.optionValInfo.optCode) ? "code" : radioOptionObj.optionValInfo.optCode;
            var optNm = on.valid.isEmpty(radioOptionObj.optionValInfo.optTxt) ? "text" : radioOptionObj.optionValInfo.optTxt;
            var optDefault = on.valid.isEmpty(radioOptionObj.optionValInfo.defaultVal) ? "" : radioOptionObj.optionValInfo.defaultVal;

            $.each(radioOptionObj.radioDataInfo, function (indx, arrVal) {

                var rdOptCode = eval("arrVal." + optCode);
                var rdOptName = eval("arrVal." + optNm);

                let isChecked = false;
                if (optDefault != "" && rdOptCode == optDefault) {
                    isChecked = true;
                }

                var cssHtml = "";
                if (radioClassNm != " ") cssHtml += " class='" + radioClassNm + "' ";
                if (radioStyle != " ") cssHtml += " style='" + radioStyle + "' ";
                if (isChecked) cssHtml += " checked";

                if (radioPrefix) {
                    radioHtml += radioPrefix;
                }
                radioHtml += "<input type='radio' name='" + radioNm + "' id='" + radioId + rdOptCode + "' value='" + rdOptCode + "' " + cssHtml + " /><label for='" + radioId + rdOptCode + "'>" + rdOptName + "</label>";
                if (radioSuffix) {
                    radioHtml += radioSuffix;
                }
            });

            $(radioOptionObj.radioInfo.targetId).html(radioHtml);
        }
    },

    /* 12개월 ComboBox Option 생성  */
    getMonthComboOptions : function() {
        var monthOptionHtml = '';
        for (var i = 1; i <= 12; i++) {
            if (i == 1) monthOptionHtml += '<option value="' + on.str.lPad(i, 2, "0") + '" selected="selected">' + i + '월</option>';
            else monthOptionHtml += '<option value="' + on.str.lPad(i, 2, "0") + '">' + i + '월</option>';
        }
        return monthOptionHtml;
    },

    /* 24시간 ComboBox생성  */
    getHourComboOptions : function () {
        let hourOptionHtml = '';
        for (let i = 0; i <= 23; i++) {
            if (i == 0) hourOptionHtml += '<option value="' + on.str.lPad(i, 2, "0") + '" selected="selected">' + on.str.lPad(i, 2, "0") + '시</option>';
            else hourOptionHtml += '<option value="' + on.str.lPad(i, 2, "0") + '">' + on.str.lPad(i, 2, "0") + '시</option>';
        }
        return hourOptionHtml;
    },
    /* 10분단위 ComboBox생성  */
    get10minuteComboOptions() {
        let minuteOptionHtml = '';
        for (let i = 0; i <= 50;) {
            if (i == 0) minuteOptionHtml += '<option value="' + on.str.lPad(i, 2, "0") + '" selected="selected">' + on.str.lPad(i, 2, "0") + '분</option>';
            else minuteOptionHtml += '<option value="' + on.str.lPad(i, 2, "0") + '">' + on.str.lPad(i, 2, "0") + '분</option>';
            i = i + 10;
        }
        return minuteOptionHtml;
    },

    /*  년도 옵션 생성 */
    GetYearComboOptions(yearOptObj) {
        if (on.valid.isEmpty(comboInfoObj.targetId)) return false;
        let beginYear = Number(on.valid.isEmpty(comboInfoObj.years.beginYear) ?  dateFns.getYear() : comboInfoObj.years.beginYear);
        let finishYear = Number(on.valid.isEmpty(comboInfoObj.years.finishYear) ? dateFns.getYear() : comboInfoObj.years.finishYear);


        var termYears = finishYear - beginYear;  // targetYear을 지정하지 않으면 기본조회기간은 현재년도 - 5년이다.

        var addOpPosition = "";
        var addOpTxt = "";
        var addOpVal = "";
        var addDefaultVal = "";

        if (!on.valid.isEmpty(comboInfoObj.addOption)) {
            addOpPosition = on.str.nvl(comboInfoObj.addOption.position, "");
            addOpTxt = on.str.nvl(comboInfoObj.addOption.opTxt, "선택");
            addOpVal = on.str.nvl(comboInfoObj.addOption.opVal, " ");
            addDefaultVal = comboInfoObj.addOption.defaultSelVal;
        }

        var yearOptionHtml = "";
        if (addOpPosition.toUpperCase() == "TOP") {
            yearOptionHtml += "<option value='" + addOpVal + "' >" + addOpTxt + "</option>";
        }
        for (var b = beginYear, f = finishYear; b <= f; b++) {
            yearOptionHtml += '<option value="' + (b) + '">' + (b) + '년</option>';
        }
        if (addOpPosition.toUpperCase() == "BOTTOM") {
            yearOptionHtml += "<option value='" + addOpVal + "' >" + addOpTxt + "</option>";
        }


        $(comboInfoObj.targetId).html(yearOptionHtml);
        if (!on.valid.isEmpty(addDefaultVal)) $(comboInfoObj.targetId).val(addDefaultVal);
    },

    /*****  Document의 값 수집 ****/
    getEleVal : function(ele) {

        var eleVal;
        var eleDiv = on.html.getEleType($(ele));
        if (eleDiv == "text" || eleDiv == "number") {
            eleVal = $(ele).val();
        } else if (eleDiv == "hidden") {
            eleVal = $(ele).val();
        } else if (eleDiv == "radio") {
            eleVal = $(ele + ":checked").val();
        } else if (eleDiv == "select") {
            eleVal = $(ele).val();
        } else if (eleDiv == "file") {
            eleVal = $(ele).clone();
        } else if (eleDiv == "checkbox") {
            eleVal = $(ele).is(":checked") ? "Y" : "N";
        } else if (eleDiv == "textarea") {
            eleVal = $(ele).val();
        } else if (eleDiv == "password") {
            eleVal = on.enc.encrypt({ encVal : $(ele).val() });
        }
        return eleVal;
    },
    setEleVal : function(setObj) {

        if(on.valid.isEmpty(setObj.ele) ){
            console.log("Set element Id를 지정하세요.");
            return false;
        }

        var eleVal = setObj.val;
        var eleDiv = on.html.getEleType($(setObj.ele));
        if (eleDiv == "text" || eleDiv == "number") {
            $(setObj.ele).val(eleVal);
        } else if (eleDiv == "hidden") {
            $(setObj.ele).val(eleVal);
        } else if (eleDiv == "radio") {
            let eleNm = setObj.ele;
            if(setObj.ele.startsWith("#") || setObj.ele.startsWith(".")){
                eleNm = "input[name='"+$(setObj.ele).attr("name")+"']";
            }
            $( eleNm + "[value='" + eleVal + "']").prop("checked", true);
        } else if (eleDiv == "select") {
            $(setObj.ele).val(eleVal).prop("selected", true);
        } else if (eleDiv == "checkbox") {
            $(setObj.ele).prop("checked", (eleVal == "Y" ? true : false));
        } else if (eleDiv == "textarea") {
            $(setObj.ele).val(eleVal);
        } else {
            $(setObj.ele).text(eleVal);
        }
    },
    /*****  Element Type 조회 ****/
    getEleType : function(ele) {
        var $el = $(ele);
        var eleType;
        if($el.is("form")){
            eleType = "form";
        }
        else if ($el.is("input")) {
            eleType = $(ele).attr("type");
        }
        else if ($el.is("select")) {
            eleType = "select";
        }
        else if ($el.is("checkbox")) {
            eleType = "checkbox";
        }
        else if ($el.is("textarea")) {
            eleType = "textarea";
        }
        else {
            eleType = $el.prop("tagName").toLowerCase();
        }
        return eleType;
    },
    /*  콤퍼넌트 DatePicker 지정  as-is : opntFncDate*/
    setDatePicker : function(dataPickersObj) {
        /* setDatePicker({ targets : ["#picker1" , "#picker2"]  // 필수입력
                                     , dateFormat : "yy.mm.dd"  // Option (default : "yy.mm.dd" )
           });
        */
        if (on.valid.isEmpty(dataPickersObj.targets)) {
            console.log("개발자요류 dataPickersObj.targets 없음 ");
            return false;
        }

        let pickerFormat = dataPickersObj.dateFormat || "yy.mm.dd"

        let startDateId = dataPickersObj.targets[0].replace("#", "");
        let tarEles = "";
        for (let i = 0; i < dataPickersObj.targets.length; i++) {
            if (i != 0) tarEles += ", ";
            tarEles += dataPickersObj.targets[i];
        }

        $(tarEles).attr('readonly', true);
        let dates = $(tarEles).datepicker({
            changeMonth: true
            , changeYear: true
            , showOn: "button"
            , buttonImage: "/ft/images/icon/i_cal.svg"
            , buttonImageOnly: true
            , dateFormat: pickerFormat
            , onSelect: function (selectedDate) {
                var option = this.id == startDateId ? "minDate" : "maxDate",
                    instance = $(this).data("datepicker"),
                    date;
                // parseDate를 pickerFormat로 변경
                if (pickerFormat === 'yy.mm') {
                    date = new Date(instance.selectedYear, instance.selectedMonth, 1);
                } else {
                    date = $.datepicker.parseDate(pickerFormat, selectedDate, instance.settings); // dateFormat을 pickerFormat로 변경
                }
                dates.not(this).datepicker("option", option, date);
                $(this).trigger("change");
            }
        });
    },
    /*  이미지 파일 미리보기 */
    preViewImageShow : function(preViewObj) {
        /*var imgPreViewObj = {
                fileEle    : "#imgPreViewFile"
             , 	preViewEle : "#imgPreView"
        }*/

        var ableImgMimeTypeArr = ["gif", "jpg", "jpeg", "tiff", "png"];
        if ($(preViewObj.fileEle).length == 0 || $(preViewObj.preViewEle).length == 0) return false;
        if ( on.html.getEleType($(preViewObj.fileEle)) != "file") return false;

        var isRegisterAble = fileFns.fileExecAllowed(preViewObj.fileEle, "image");
        if (!isRegisterAble) {
            messageFns.showMsg("등록할수없는 이미지 입니다. \n " + ableImgMimeTypeArr.join() + " 형태의 사진만 등록 가능합니다.");
            return false;
        }

        var eleFiles = $(preViewObj.fileEle).prop("files");

        var fileObj = eleFiles[0]
        var reader = new FileReader();
        reader.onload = function (e) {
            $(preViewObj.preViewEle).attr("src", e.target.result);
        }
        reader.readAsDataURL(fileObj);

        if (!on.valid.isEmpty(preViewObj.filePathEle)) {
            $(preViewObj.filePathEle).val(fileObj.name);
        }
        return true;
    }

    , setPageAsideMenuFocus : function(menuOnObj){
        $("#depth1Menus > a").attr("href",menuOnObj.menu1href).text(menuOnObj.menu1nm);
        $("#depth1Menus > ul > li > a[href='"+menuOnObj.menu1href+"']").parent("li").addClass("on");

        $("#depth2Menus > a").attr("href",menuOnObj.menu2href).text(menuOnObj.menu2nm);
        $("#depth2Menus > ul > li > a[href='"+menuOnObj.menu2href+"']").parent("li").addClass("on");
    }

    , cleanContent (html, options = {}){
        const allowedPunct = options.allowedPunct || `\\.,\\-_\\(\\)\\/\\+@:&'"!\\?%#\\*~\\^=\\|\\[\\]\\{\\}<>`;

        // 1) HTML -> TEXT (태그 제거 + 엔티티 디코드)
        const doc = new DOMParser().parseFromString(String(html || ''), 'text/html');
        let text = doc.body.textContent || '';

        // 2) 비가시 공백 정리: &nbsp; → 스페이스, 줄바꿈/탭 제거 후 단일 공백화
        text = text
            .replace(/\u00A0/g, ' ')      // NBSP -> space
            .replace(/[\r\n\t]+/g, ' ')   // 개행/탭 -> space
            .replace(/\s{2,}/g, ' ')      // 다중 공백 -> 단일 공백
            .trim();

        // 3) 허용 문자만 남김
        //   - 한글 음절: \uAC00-\uD7A3
        //   - 한글 자모: \u1100-\u11FF, \u3130-\u318F
        //   - 영문/숫자: A-Za-z0-9
        //   - 공백 및 허용 특수문자(옵션)
        const disallow = new RegExp(
            `[^\\uAC00-\\uD7A3\\u1100-\\u11FF\\u3130-\\u318FA-Za-z0-9 ${allowedPunct}]`,
            'gu'
        );
        text = text.replace(disallow, '');

        // 4) 최종 공백 정돈
        return text.replace(/\s{2,}/g, ' ').trim();
    }
    , serializeDataArray(dataInfo){
        /* 특정 Element 하위의 입력속성 객체를 serializeArray 하여 반환한다. */
         if( on.valid.isEmpty(dataInfo.target) ) return false;

         let targetEleType = on.html.getEleType(dataInfo.target);
         let serializeArrData;
         if(targetEleType === "form"){
             serializeArrData = $(dataInfo.target).serializeArray();

             // 입력 Type PassWord (암호화)
             let passwords =  $(dataInfo.target).find("input[type='password']");
             for(let inputPassword of passwords){
                 let findObject = $.grep(serializeArrData, function(obj) {
                     return obj.name === inputPassword.name;
                 });
                 findObject[0].value = on.enc.encrypt({ennVal : findObject[0].value });
             }

             // 입력 Type TextArea (CkEditor , NaverEditor 등등...)


         }
         else {
             $(dataInfo.target).wrap("<form id='serializeForm' name='serializeForm'></form>");
             serializeArrData = $("#serializeForm").serializeArray();

             // 입력 Type PassWord (암호화)
             let passwords = $("#serializeForm").find("input[type='password']");
             for(let inputPassword of passwords){
                 let findObject = $.grep(serializeArrData, function(obj) {
                     return obj.name === inputPassword.name;
                 });
                 findObject[0].value = on.enc.encrypt({encVal : findObject[0].value });
             }

             // 입력 Type TextArea (CkEditor , NaverEditor 등등...)


             $(dataInfo.target).unwrap();
         }
         return serializeArrData;
    }
}

export default htmlFns;