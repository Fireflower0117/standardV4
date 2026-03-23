(function(window) {

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

                    targetHtml += "<tr data-row_data_div='db'>";
                    for (var j = 0; j < colInfoLength; j++) {
                        let resourceRow = tarDispObj.resource[i];
                        let colId = colInfo[j].id;
                        let colType = on.str.nvl(colInfo[j].colType, "string");
                        let colAlign = on.str.nvl(colInfo[j].align, "center");
                        let colStyle = on.str.nvl(colInfo[j].style, "");
                        //var colClassNm  = on.str.nvl(colInfo[j].classNm  , "");
                        let uniqId = colInfo[j].id + "_" + on.str.nvl(resourceRow.rownum_, i);
                        let tarUniqId = " id='" + uniqId + "' ";
                        let tarEleNm = " name='" + colId + "' ";
                        let tarClassNm = on.str.nvl(colInfo[j].classNm) == "" ? "" : " class='" + colInfo[j].classNm + "'";
                        let tarStyleNm = on.str.nvl(colInfo[j].styleNm) == "" ? "" : " style='" + colInfo[j].styleNm + "'";
                        let tarColValue = on.str.nvl(resourceRow[colInfo[j].id], "");
                        //var nullDisp    = on.str.nvl(colInfo[j].nullDisp , "Y");


                        if (i == 0 && j == 0) {
                            totRowCnt = resourceRow.totalCount;  // row 전체 Count
                        }

                        // data prop options
                        let dataPropsHtml = "";
                        for (var k = 1; k <= 10; k++) {
                              // colInfo[j]["data_id" + k] 값이 없으면 SKIP
                              let dataProp = colInfo[j]["data_id" + k];
                              if (on.valid.isEmpty(dataProp)) {
                                continue;
                              }
                              // resource의 해당 컬럼에 값이 있는지 확인
                              let resourceVal = tarDispObj.resource[i][dataProp];
                              let dataPropVal = "";
                              if (!on.valid.isEmpty(resourceVal)) {
                                dataPropVal = resourceVal;   // resource에 값이 있으면 값을 data prop value로 지정
                              }
                              else {
                                dataPropVal = dataProp;    // resource에 값이 없으면 입력했던 key가 data prop value로 지정
                              }
                              dataPropsHtml += " data-" + dataProp + "='" + dataPropVal + "' ";
                        }

                        // Element 유형에 따른 html동적 생성후 적용
                        if (colType === "td") {
                            targetHtml += "<td " + tarUniqId + tarEleNm + tarStyleNm + tarClassNm + dataPropsHtml + ">" + tarColValue + "</td>";
                        }
                        else if (colType === "text") {
                            let placeholder = colInfo[j].placeholder ? " placeholder='" + colInfo[j].placeholder + "'" : "";
                            targetHtml += "<td style='text-align:center;'>";
                            targetHtml += "	  <input type='text' " + tarUniqId + tarEleNm + tarStyleNm + tarClassNm + dataPropsHtml + placeholder + " value='" + tarColValue + "' >";
                            targetHtml += "</td>";
                        } else if (colType === "double") {
                            let colDblPattrn = on.str.nvl(colInfo[j].pattern, ".##");
                            let decimalStr = colDblPattrn.split(".")[1] || "";
                            let colDblPattrnLen = (decimalStr.match(/#/g) || []).length;
                            let colDblVal = Number(on.str.nvl(tarColValue, 0)).toFixed(colDblPattrnLen);
                            if (Number(colDblVal) === 0) {
                                colDblVal = on.valid.isEmpty(colInfo[j].zero) ? colDblVal : colInfo[j].zero;
                            } else {
                                let parts = colDblVal.toString().split(".");
                                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                colDblVal = parts.join(".");
                            }
                            targetHtml += "   <td " + tarUniqId + tarEleNm + dataPropsHtml +  tarClassNm + " style='text-align:" + colAlign + ";'>" + colDblVal + "</td>";
                        } else if (colType === "number") {
                            if ($.isNumeric(tarColValue)) {
                                targetHtml += "   <td " + tarUniqId + tarEleNm + dataPropsHtml + tarStyleNm + tarClassNm + ">" + ("" + Math.round(tarColValue, 1)).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + "</td>";
                            } else {
                                targetHtml += "   <td " + tarUniqId + tarEleNm + dataPropsHtml + tarStyleNm + tarClassNm + ">" + (on.valid.isEmpty(colInfo[j].zero) ? "0" : colInfo[j].zero) + "</td>";
                            }
                        } else if (colType === "hidden") {
                            targetHtml += "   <td style='display: none;' " + tarUniqId + tarEleNm + dataPropsHtml +  tarStyleNm + tarClassNm + ">" + tarColValue + "</td>";
                        } else if (colType === "button") {
                            let tarBtnText = on.str.nvl(colInfo[j].btnText, "");
                            targetHtml += "  <td style='text-align:center;'>";
                            targetHtml += "  	<button type='button' " + tarUniqId +  tarStyleNm +  tarClassNm + dataPropsHtml + ">" + tarBtnText + "</button>";
                            targetHtml += "  </td>";
                        } else if (colType === "checkbox") {
                            let chkValue = on.valid.isEmpty(colInfo[j].classNm) ? "" : " value='" + colInfo[j].classNm + "'";
                            let strChecked = tarColValue === "Y" ? "checked" : "";
                            targetHtml += "<td>";
                            targetHtml += "   <span class='chk'>";
                            targetHtml += "      <span class='cbx'>";
                            targetHtml += "         <input type='checkbox' " + tarUniqId + tarEleNm+ chkValue +  tarStyleNm + tarClassNm + dataPropsHtml + strChecked + "/>";
                            targetHtml += "         <label for='"+uniqId+"' " + dataPropsHtml + "></label>";
                            targetHtml += "      </span>";
                            targetHtml += "   </span>";
                            targetHtml += "</td>";
                        }else if(colType === "select"){
                            let optIdKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optId : "code";
                            let optTxtKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optTxt : "text";
                            let optionsData = colInfo[j].dataInfo || [];

                            targetHtml += "<td style='text-align:center;'>";
                            targetHtml += "   <select " + tarUniqId + tarEleNm + tarClassNm +  tarStyleNm + dataPropsHtml + ">";

                            for (let m = 0; m < optionsData.length; m++) {
                                let optVal = optionsData[m][optIdKey];
                                let optTxt = optionsData[m][optTxtKey];
                                let isSelected = (tarColValue == optVal) ? "selected" : "";
                                targetHtml += "      <option value='" + optVal + "' " + isSelected + ">" + optTxt + "</option>";
                            }
                            targetHtml += "   </select>";
                            targetHtml += "</td>";

                        } else if(colType === "file"){
                            let wrapTag = on.str.nvl(colInfo[j].wrapTag, "div");
                            let wrapClass = on.str.nvl(colInfo[j].wrapClassNm, "");
                            let wrapStyle = on.str.nvl(colInfo[j].wrapStyleNm, "");

                            let wrapClassAttr = wrapClass ? " class='" + wrapClass + "'" : "";
                            let wrapStyleAttr = wrapStyle ? " style='" + wrapStyle + "'" : "";

                            // 💡 파일 확장자 필터링 속성 (배열 지원 로직 추가)
                            let acceptExt = colInfo[j].accept || ["doc", "docx", "hwp", "xls", "xlsx", "pdf", "jpg", "jpeg", "png", "gif", "bmp"];
                            let acceptAttr = "";

                            if (!on.valid.isEmpty(acceptExt)) {
                                if (Array.isArray(acceptExt)) {
                                    // 배열인 경우: ["pdf", " png ", "image/*"] -> ".pdf,.png,image/*" 로 변환
                                    let acceptStr = acceptExt.map(function(ext) {
                                        ext = ext.trim(); // 혹시 모를 공백 제거
                                        return ext.startsWith('.') || ext.includes('/') ? ext : '.' + ext;
                                    }).join(',');
                                    acceptAttr = " accept='" + acceptStr + "'";
                                } else if (typeof acceptExt === 'string') {
                                    // 기존 하위 호환성 (문자열로 입력했을 경우)
                                    acceptAttr = " accept='" + acceptExt + "'";
                                }
                            }

                            targetHtml += "<td style='text-align:" + colAlign + ";'>";
                            targetHtml += "   <" + wrapTag + wrapClassAttr + wrapStyleAttr + ">";

                            // 파일 input 생성 (공통 data속성 및 class, style 적용)
                            targetHtml += "       <input type='file' " + tarUniqId + tarEleNm + tarClassNm + tarStyleNm + dataPropsHtml + acceptAttr + ">";

                            // 기존에 업로드된 파일(atchFileId 등)이 있을 경우 처리를 위한 hidden 필드
                            if (tarColValue !== "") {
                                targetHtml += "       <input type='hidden' id='" + uniqId + "_oldId' name='" + uniqId + "_oldId' value='" + tarColValue + "'>";
                            }

                            targetHtml += "   </" + wrapTag + ">";
                            targetHtml += "</td>";

                        }else if(colType === "radio"){
                            let optIdKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optId : "code";
                            let optTxtKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optTxt : "text";
                            let optionsData = colInfo[j].dataInfo || [];

                            let radioGrpName = " name='" + colId + "_" + i + "' ";
                            let dataNameAttr = " data-name='" + colId + "' ";

                            targetHtml += "<td style='text-align:center;'>";
                            targetHtml += "   <div style='display: inline-flex; align-items: center; gap: 10px; justify-content: center; flex-wrap: nowrap;'>";

                            for (let m = 0; m < optionsData.length; m++) {
                                let optVal = optionsData[m][optIdKey];
                                let optTxt = optionsData[m][optTxtKey];
                                let isChecked = (tarColValue == optVal) ? "checked" : "";
                                let radioEleId = uniqId + "_rdo_" + m;

                                targetHtml += "      <label for='" + radioEleId + "' style='display: inline-flex; align-items: center; gap: 3px; cursor: pointer; margin-bottom: 0;'>";
                                targetHtml += "         <input type='radio' id='" + radioEleId + "' " + radioGrpName + dataNameAttr + " value='" + optVal + "' " + tarClassNm  + tarStyleNm +  dataPropsHtml + isChecked + " /> " + optTxt;
                                targetHtml += "      </label>";
                            }
                            targetHtml += "   </div>";
                            targetHtml += "</td>";
                        }  else if (colType === "datePicker") {
                            targetHtml += "<td style='text-align:center;'>";
                            targetHtml += "   <span class='calendar_input'>";
                            targetHtml += "	      <input type='text' data-cellTp='datePicker' " + tarUniqId + tarEleNm + tarClassNm + tarStyleNm + "  value='" + tarColValue + "' " + dataPropsHtml + " readonly>";
                            targetHtml += "   </span>";
                            targetHtml += "</td>";
                        } else if (colType === "fileIcon") {
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
                                targetHtml += "	  <img " + tarUniqId + tarEleNm + + tarClassNm + tarStyleNm + dataPropsHtml + " src='/ft/images/icon/file_" + ext + ".svg' alt='" + ext + "' >";
                            } else {
                                targetHtml += "   <div " + tarUniqId + tarEleNm + + tarClassNm + tarStyleNm + dataPropsHtml + ">-</div>";
                            }
                            targetHtml += "</td>";
                        }
                        else if(colType === "hasFile"){
                            if(tarColValue === "HAS"){
                                targetHtml += "<td><img src='/internal/standard/common/images/icon/i_clip.svg' alt='첨부파일'></td>";
                            }
                            else {
                                targetHtml += "<td></td>";
                            }
                        }
                        /* else if(각 프로젝트별 별도 칼럼필요시 추가생성){

                        } */

                    }
                    targetHtml += "</tr>";
                }
                $(tarDispObj.dispTarget).empty();
                $(tarDispObj.dispTarget).html(targetHtml);

                // Paging Area Renderer
                if (!on.valid.isEmpty(tarDispObj.paginginfo)) {

                    if (!on.valid.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                        $(tarDispObj.paginginfo.totRowsCntId).text(totRowCnt);
                    }

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
            on.html.setDatePicker({targets : ["#" + $(ele).attr("id")]});
        });
    }
    , cardDisplay : function(tarDispObj) {

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
                        let tarClassNm = on.str.nvl(colInfo[j].classNm) == "" ? "" : " class='" + colInfo[j].classNm + "'";
                        let tarStyleNm = on.str.nvl(colInfo[j].styleNm) == "" ? "" : " style='" + colInfo[j].styleNm + "'";
                        let tarColValue = on.str.nvl(resourceRow[colInfo[j].id], "");

                        if (i == 0 && j == 0) {
                            totRowCnt = resourceRow.totalCount;
                        }

                        // data prop options
                        let dataPropsHtml = "";
                        for (var k = 1; k <= 10; k++) {
                            // colInfo[j]["data_id" + k] 값이 없으면 SKIP
                            let dataProp = colInfo[j]["data_id" + k];
                            if (on.valid.isEmpty(dataProp)) {
                                continue;
                            }
                            // resource의 해당 컬럼에 값이 있는지 확인
                            let resourceVal = tarDispObj.resource[i][dataProp];
                            let dataPropVal = "";
                            if (!on.valid.isEmpty(resourceVal)) {
                                dataPropVal = resourceVal;   // resource에 값이 있으면 값을 data prop value로 지정
                            }
                            else {
                                dataPropVal = dataProp;    // resource에 값이 없으면 입력했던 key가 data prop value로 지정
                            }
                            dataPropsHtml += " data-" + dataProp + "='" + dataPropVal + "' ";
                        }

                        if (colType === "cardType") {

                            targetHtml += "<li "+dataPropsHtml+">";
                          //targetHtml += "    <a href='"+resourceRow.boardContent+"' target='_blank' title='새 창 열기'>";
                            targetHtml += "    <a href='http://www.naver.com' target='_blank' title='새 창 열기'>";
                            targetHtml += "        <div class='img_area'>";
                            targetHtml += "            <img src='/file/getImage.do?atchFileId="+resourceRow.atchFileId+"&fileSn="+resourceRow.fileSn+"&fileNmPhclFileNm="+resourceRow.phyclFileNm+"' "+dataPropsHtml+" alt='사이트명 로고'>";
                            targetHtml += "        </div>";
                            targetHtml += "        <p>"+resourceRow.boardTitl+"</p>";
                            targetHtml += "    </a>";
                            targetHtml += "</li>";

                        }
                    }
                }

                $(tarDispObj.dispTarget).empty();
                $(tarDispObj.dispTarget).html(targetHtml);

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
    }

    , tableAddRow: function(tarAddObj) {
         if (!tarAddObj || !tarAddObj.dispTarget || !tarAddObj.addColumns) return false;

         let colInfo = tarAddObj.addColumns;
         let colInfoLength = colInfo.length;
         let targetHtml = "<tr data-row_data_div='new'>";

         // 💡 신규 행 추가 시 개발자가 넘긴 기본 데이터(resource)가 있다면 활용, 없으면 빈 객체
         let resourceRow = tarAddObj.resource || {};

         // 행마다 고유한 Index 생성 (라디오 버튼 name 그룹화 및 ID 중복 방지용)
         let rowIdx = "add_" + new Date().getTime();

         for (let j = 0; j < colInfoLength; j++) {
             let colId    = colInfo[j].id;
             let colType  = on.str.nvl(colInfo[j].colType, "text");
             let colAlign = on.str.nvl(colInfo[j].align, "center");

             let uniqId     = colId + "_" + rowIdx;
             let tarUniqId  = " id='" + uniqId + "' ";
             let tarEleNm  = " name='" + colId + "' ";
             let tarClassNm = on.str.nvl(colInfo[j].classNm) === "" ? "" : " class='" + colInfo[j].classNm + "'";
             let tarStyleNm = on.str.nvl(colInfo[j].styleNm) === "" ? "" : " style='" + colInfo[j].styleNm + "'";

             let tarColValue = on.str.nvl(resourceRow[colId], "");

             // custom data properties 적용
             let dataPropsHtml = "";
             for (let k = 1; k <= 10; k++) {
                 let dataProp = colInfo[j]["data_id" + k];
                 if (on.valid.isEmpty(dataProp)) {
                     continue;
                 }

                 // resource에 해당 컬럼의 값이 지정되어 있는지 확인
                 let resourceVal = resourceRow[dataProp];
                 let dataPropVal = "";

                 if (!on.valid.isEmpty(resourceVal)) {
                     dataPropVal = resourceVal; // 전달받은 resource 값이 있으면 세팅
                 } else {
                     dataPropVal = dataProp;    // 값이 없으면 입력했던 key 자체를 value로 지정
                 }
                 dataPropsHtml += " data-" + dataProp + "='" + dataPropVal + "' ";
             }

             // Element 유형에 따른 HTML 동적 생성
             if (colType === "td") {
                 targetHtml += "<td " + tarUniqId + tarStyleNm + tarClassNm + dataPropsHtml + "></td>";

             } else if (colType === "text") {
                 let placeholder = colInfo[j].placeholder ? " placeholder='" + colInfo[j].placeholder + "'" : "";
                 targetHtml += "<td style='text-align:center;'>";
                 targetHtml += "	  <input type='text' " + tarUniqId + tarEleNm + tarStyleNm + tarClassNm + dataPropsHtml + placeholder + " value='" + tarColValue + "' >";
                 targetHtml += "</td>";

             } else if (colType === "double") {
                 let colDblPattrn = on.str.nvl(colInfo[j].pattern, ".##");
                 let decimalStr = colDblPattrn.split(".")[1] || "";
                 let colDblPattrnLen = (decimalStr.match(/#/g) || []).length;
                 let colDblVal = Number(on.str.nvl(tarColValue, 0)).toFixed(colDblPattrnLen);
                 if (Number(colDblVal) === 0) {
                     colDblVal = on.valid.isEmpty(colInfo[j].zero) ? colDblVal : colInfo[j].zero;
                 } else {
                     let parts = colDblVal.toString().split(".");
                     parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                     colDblVal = parts.join(".");
                 }
                 targetHtml += "   <td " + tarUniqId + " " + tarEleNm + " " + dataPropsHtml + " class='" + tarClassNm + "' style='text-align:" + colAlign + ";'>" + colDblVal + "</td>";
             } else if (colType === "number") {
                 if ($.isNumeric(tarColValue)) {
                     targetHtml += "   <td " + tarUniqId + tarEleNm + tarStyleNm + tarClassNm + dataPropsHtml + ">" + ("" + Math.round(tarColValue, 1)).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + "</td>";
                 } else {
                     targetHtml += "   <td " + tarUniqId + tarEleNm + tarStyleNm + tarClassNm + dataPropsHtml + ">" + (on.valid.isEmpty(colInfo[j].zero) ? "0" : colInfo[j].zero) + "</td>";
                 }

             } else if (colType === "hidden") {
                 targetHtml += "   <td style='display: none;' " + tarUniqId + dataPropsHtml + tarStyleNm + tarClassNm + ">";
                 targetHtml += "       <input type='hidden' " + tarUniqId + tarEleNm + " value=''>";
                 targetHtml += "   </td>";

             } else if (colType === "button") {
                 let tarBtnText = on.str.nvl(colInfo[j].btnText, "");
                 let btnStyle = on.str.nvl(colInfo[j].style, "");
                 targetHtml += "  <td style='text-align:center;'>";
                 targetHtml += "     <button type='button' " + tarUniqId + " style='" + btnStyle + "' " + tarStyleNm + tarClassNm + dataPropsHtml + ">" + tarBtnText + "</button>";
                 targetHtml += "  </td>";

             } else if (colType === "checkbox") {
                 let chkValue = on.valid.isEmpty(colInfo[j].classNm) ? "" : " value='" + colInfo[j].classNm + "'";
                 targetHtml += "<td>";
                 targetHtml += "   <span class='chk'>";
                 targetHtml += "      <span class='cbx'>";
                 targetHtml += "         <input type='checkbox' " + tarUniqId + tarEleNm + chkValue + tarStyleNm + tarClassNm + dataPropsHtml + "/>";
                 targetHtml += "         <label for='" + uniqId + "' " + dataPropsHtml + "></label>";
                 targetHtml += "      </span>";
                 targetHtml += "   </span>";
                 targetHtml += "</td>";

             } else if (colType === "select") {
                 let optIdKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optId : "code";
                 let optTxtKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optTxt : "text";
                 let optionsData = colInfo[j].dataInfo || [];

                 targetHtml += "<td style='text-align:center;'>";
                 targetHtml += "   <select " + tarUniqId + tarEleNm + tarClassNm + tarStyleNm + dataPropsHtml + ">";
                 for (let m = 0; m < optionsData.length; m++) {
                     targetHtml += "      <option value='" + optionsData[m][optIdKey] + "'>" + optionsData[m][optTxtKey] + "</option>";
                 }
                 targetHtml += "   </select>";
                 targetHtml += "</td>";

             }
             /* else if (colType === "file") {
                 let wrapTag = on.str.nvl(colInfo[j].wrapTag, "div");
                 let wrapClass = on.str.nvl(colInfo[j].wrapClassNm, "");
                 let wrapStyle = on.str.nvl(colInfo[j].wrapStyleNm, "");
                 let wrapClassAttr = wrapClass ? " class='" + wrapClass + "'" : "";
                 let wrapStyleAttr = wrapStyle ? " style='" + wrapStyle + "'" : "";

                 let acceptExt = colInfo[j].accept || ["doc", "docx", "hwp", "xls", "xlsx", "pdf", "jpg", "jpeg", "png", "gif", "bmp"];
                 let acceptAttr = "";

                 if (!on.valid.isEmpty(acceptExt)) {
                     if (Array.isArray(acceptExt)) {
                         let acceptStr = acceptExt.map(function(ext) {
                             ext = ext.trim();
                             return ext.startsWith('.') || ext.includes('/') ? ext : '.' + ext;
                         }).join(',');
                         acceptAttr = " accept='" + acceptStr + "'";
                     } else if (typeof acceptExt === 'string') {
                         acceptAttr = " accept='" + acceptExt + "'";
                     }
                 }

                 targetHtml += "<td style='text-align:" + colAlign + ";'>";
                 targetHtml += "   <" + wrapTag + wrapClassAttr + wrapStyleAttr + ">";
                 targetHtml += "       <input type='file' " + tarUniqId + tarEleNm + tarClassNm + tarStyleNm + dataPropsHtml + acceptAttr + ">";
                 targetHtml += "   </" + wrapTag + ">";
                 targetHtml += "</td>";

             } */
             else if (colType === "radio") {
                 let optIdKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optId : "code";
                 let optTxtKey = colInfo[j].optionValInfo ? colInfo[j].optionValInfo.optTxt : "text";
                 let optionsData = colInfo[j].dataInfo || [];

                 let radioGrpName = " name='" + colId + "_" + rowIdx + "' ";
                 let dataNameAttr = " data-name='" + colId + "' ";

                 targetHtml += "<td style='text-align:center;'>";
                 targetHtml += "   <div style='display: inline-flex; align-items: center; gap: 10px; justify-content: center; flex-wrap: nowrap;'>";
                 for (let m = 0; m < optionsData.length; m++) {
                     let optVal = optionsData[m][optIdKey];
                     let optTxt = optionsData[m][optTxtKey];
                     let isChecked = (m === 0) ? "checked" : "";
                     let radioEleId = uniqId + "_rdo_" + m;
                     targetHtml += "      <label for='" + radioEleId + "' style='display: inline-flex; align-items: center; gap: 3px; cursor: pointer; margin-bottom: 0;'>";
                     targetHtml += "         <input type='radio' id='" + radioEleId + "' " + radioGrpName + dataNameAttr + " value='" + optVal + "' " + tarClassNm + tarStyleNm + dataPropsHtml + " " + isChecked + " /> " + optTxt;
                     targetHtml += "      </label>";
                 }
                 targetHtml += "   </div>";
                 targetHtml += "</td>";

             } else if (colType === "datePicker") {
                 targetHtml += "<td style='text-align:center;'>";
                 targetHtml += "   <span class='calendar_input'>";
                 targetHtml += "       <input type='text' data-cellTp='datePicker' " + tarUniqId + tarEleNm + tarClassNm + tarStyleNm + dataPropsHtml + " readonly>";
                 targetHtml += "   </span>";
                 targetHtml += "</td>";

             } else if (colType === "fileIcon") {
                 targetHtml += "<td style='text-align:center;'>";
                 targetHtml += "   <div " + tarUniqId + tarEleNm + tarClassNm + tarStyleNm + dataPropsHtml + ">-</div>";
                 targetHtml += "</td>";

             } else if (colType === "hasFile") {
                 targetHtml += "<td></td>";
             }
         }
         targetHtml += "</tr>";

         let $targetTable = $(tarAddObj.dispTarget);
         $targetTable.append(targetHtml);

         let $newRow = $targetTable.find("tr").last();
         $.each($newRow.find("[data-cellTp='datePicker']"), function (indx, ele) {
             if(typeof on.html.setDatePicker === "function") {
                 on.html.setDatePicker({ targets : ["#" + $(ele).attr("id")] });
             }
         });
     }

     , tableChkbxDelRow: function(options) {
         if (!options || on.valid.isEmpty(options.chkNm)) {
             on.msg.showMsg({ message: "삭제할 대상(chkNm)이 누락되었습니다." });
             return false;
         }

         let chkSelector = "";
         if (options.chkNm.startsWith("#") || options.chkNm.startsWith(".")) {
             chkSelector = options.chkNm;
         } else {
             chkSelector = "input[name^='" + options.chkNm + "']";
         }

         let selector = chkSelector + ":checked";
         if (!on.valid.isEmpty(options.targetTable)) {
             selector = options.targetTable + " " + selector;
         }
         let $checkedItems = $(selector);

         if ($checkedItems.length === 0) {
             on.msg.showMsg({ message: "삭제할 항목을 먼저 선택해 주세요." });
             return false;
         }

         let confirmMsg = on.str.nvl(options.confirmMsg, $checkedItems.length + "개의 항목을 삭제하시겠습니까?");
         if (confirm(confirmMsg)) {

             // 밖에서 배열을 안 넘기면 자체적으로 빈 배열 생성
             let delArr = options.delArr || [];

             $checkedItems.each(function() {
                 //  해당 체크박스의 모든 data-* 속성을 Object 형태로 추출 (HTML5 표준 dataset 활용)
                 // 예: <input data-key1="val1" data-key2="val2"> -> { key1: "val1", key2: "val2" }
                 let dataObj = Object.assign({}, this.dataset);

                 //  추출된 Object 안의 값들 중 '빈 값'이 아닌 실제 값이 하나라도 있는지 체크
                 let hasRealValue = false;
                 for (let key in dataObj) {
                     if (!on.valid.isEmpty(dataObj[key])) {
                         hasRealValue = true;
                         break;
                     }
                 }

                 //  실제 값이 있는 경우에만 삭제 배열에 추가 (신규 추가된 빈 행은 자동으로 걸러짐!)
                 if (hasRealValue) {
                     delArr.push(dataObj);
                 }

                 //  화면(HTML)에서 행 삭제
                 $(this).closest("tr").remove();
             });

             // 헤더 전체 선택 체크박스 초기화
             let cleanTargetName = options.chkNm.replace(/^[#.]/, "");
             $(".chk-all[data-target-name='" + cleanTargetName + "']").prop("checked", false);
             $(".chk-all[data-target-name='" + options.chkNm + "']").prop("checked", false);

             // 콜백 함수로 삭제 갯수와 '자동 수집된 Object 배열' 리턴!
             if (typeof options.callbackFn === "function") {
                 options.callbackFn($checkedItems.length, delArr);
             }
         }
     }

    , PageNationDisp : function(pagingInfoObj) {

        var pageDiv = $(pagingInfoObj.pagingAreaId)
            , totalPage = Math.ceil(pagingInfoObj.totalCount / pagingInfoObj.pageSize)
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

        tags = "<li class='btn_page first'><a pageNo='1' title='처음'></a></li>"
            + "<li class='btn_page prev'><a pageNo='" + prevGroupNo + "' title='이전'></a></li>";

        pageStart = nowGroup * 10 + 1;
        pageEnd = pageStart + 10;

        if ((totalPage + 1) < pageEnd) {
            pageEnd = totalPage + 1;
        }

        for (var i = pageStart; i < pageEnd; i++) {
            if (pagingInfoObj.pageNo === i) {
                tags += "<li class='current'><a pageNo='" + i + "'>" + i + "</a></li>"
            } else {
                tags += "<li><a pageNo='" + i + "'>" + i + "</a></li>"
            }
        }

        tags += "<li class='btn_page next'><a pageNo='" + nextGroupNo + "' title='다음'></a></li>"
            + "<li class='btn_page last'><a pageNo='" + totalPage + "' title='마지막'></a></li>";

        pageDiv.html(tags);

        if (pagingInfoObj.pageNo === 1) {
            $(pagingInfoObj.pagingAreaId + " li:eq(0)").addClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(0) > a").css("cursor", "default");
        } else {
            $(pagingInfoObj.pagingAreaId + " li:eq(0)").removeClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(0) > a").css("cursor", "pointer");
        }

        if (pagingInfoObj.pageNo === totalPage) {
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1)").addClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1) > a").css("cursor", "default");
        } else {
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1)").removeClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:nth-last-child(1) > a").css("cursor", "pointer");
        }

        if (prevGroupNo === 0) {
            $(pagingInfoObj.pagingAreaId + " li:eq(1)").addClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(1) > a").css("cursor", "default");
        } else {
            $(pagingInfoObj.pagingAreaId + " li:eq(1)").removeClass("disabled");
            $(pagingInfoObj.pagingAreaId + " li:eq(1) > a").css("cursor", "pointer");
        }

        if (nextGroupNo === 0) {
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
                          , formAttrs  : [ {name : "" , value:"" }
                                         , {name : "" , value:"" }
                                         ]
                          }
        */


        let formId      = on.str.nvl(formInfo.formDefine.fid, "anonymousForm");
        let formName    = on.str.nvl(formInfo.formDefine.fname , formId  );
        let formAction  = on.valid.isEmpty(formInfo.formDefine.action) ? "" : " action='" + formInfo.formDefine.action + "'";
        let formEncType = on.valid.isEmpty(formInfo.formDefine.enctype) ? "application/json" : formInfo.formDefine.enctype;
        let formTarget  = on.valid.isEmpty(formInfo.formDefine.fTarget) ? "" : " target='" + formInfo.formDefine.fTarget + "'";
        let paramMethod = on.valid.isEmpty(formInfo.formDefine.method) ? "post" : formInfo.formDefine.method;
        if (paramMethod.toUpperCase() !== "GET" && paramMethod.toUpperCase() !== "POST") paramMethod = "POST";
        let formMethod  = " method='" + paramMethod + "'";
        let formClass   = on.valid.isEmpty(formInfo.formDefine.classNm) ? "" : " class='" + formInfo.formDefine.classNm + "'";
        let formStyle   = on.valid.isEmpty(formInfo.formDefine.style) ? "" : " style='" + formInfo.formDefine.style + "'";
        let insertTrget = on.valid.isEmpty(formInfo.formDefine.insTarget) ? "body" : formInfo.formDefine.insTarget;

         // form 데이터 유효성 검증
         if(!on.valid.isEmpty(formInfo.validation)){

             if(on.valid.isEmpty(formInfo.validation.formId)){
                 on.msg.consoleLog( "유효성 검증은 formId입력이 필수입니다.")
                 return false;
             }

             if(on.valid.isEmpty(formInfo.validation.validationList)){
                 on.msg.consoleLog( "유효성 검증은 검증대상 입력이 필수입니다.")
                 return false;
             }

             const isValid = on.valid.formValidationCheck({ formId: formInfo.validation.formId
                                                                    , validateList : formInfo.validation.validationList
                                                                    , callbackFn : () => {}
             });
             if (!isValid) {
                 return false;
             }
         }

         var inputAttrsHtml = "";
         // csrf 공통함수 내부에서  자동주입
         let csrfToken = $("meta[name='_csrf']").attr("content");
         if (csrfToken) {
             inputAttrsHtml += "<input type='hidden' name='_csrf' value='" + csrfToken + "'>";
         }

        if (!on.valid.isEmpty(formInfo.formAttrs)) {
              for(let attrIndx in  formInfo.formAttrs){
                let eleName = null;
                  if(!on.valid.isEmpty(formInfo.formAttrs[attrIndx].name) ){
                      eleName = formInfo.formAttrs[attrIndx].name;
                  }else {
                      on.msg.consoleLog("formAttrs [{name:''}] 은 필수입력 항목입니다." );
                      return false;
                      break;
                  }

                 let eleType = on.valid.isEmpty(formInfo.formAttrs[attrIndx].type) ? "hidden" : formInfo.formAttrs[attrIndx].type;
                 let eleVal = on.valid.isEmpty(formInfo.formAttrs[attrIndx].value) ? "''" : formInfo.formAttrs[attrIndx].value;

                if (eleType == "file") {
                    inputAttrsHtml += "<input type='file' id='" + eleName + "' name='" + eleName + "'  style='display:none;' >";
                } else if (eleType == "files") {
                    if (!on.valid.isEmpty(eleVal)) {
                        let fileIdx = 0;1278
                        for (inpFile of eleVal.toArray()) {
                            inputAttrsHtml += "<input type='file' name='" + eleName + "_" + fileIdx + "'   style='display:none;'>";
                            fileIdx++;
                        }
                        fileNmIndx++;
                    }
                } else {
                    inputAttrsHtml += "<input type='" + eleType + "' id='" + eleName + "' name='" + eleName + "' value='" + eleVal + "' style='display:none;' >";
                }
            }
        }

        var formHtml = "<form id='" + formId + "' name='" + formName + "' enctype='" + formEncType + "' " + formAction + " " + formTarget + " " + formMethod + " " + formClass + " " + formStyle + ">";
        formHtml += inputAttrsHtml;
        formHtml += "</form>";

        $(insertTrget).find("#" + formId).remove();
        $(insertTrget).append(formHtml);

        if (!on.valid.isEmpty(formInfo.formAttrs)) {
            for(let attrIndx in  formInfo.formAttrs){

                let eleName = null;
                if(!on.valid.isEmpty(formInfo.formAttrs[attrIndx].name) ){
                    eleName = formInfo.formAttrs[attrIndx].name;
                }else {
                    on.msg.consoleLog("formAttrs [{name:''}] 은 필수입력 항목입니다." );
                    return false;
                    break;
                }

                let eleType = on.valid.isEmpty(formInfo.formAttrs[attrIndx].type) ? "hidden" : formInfo.formAttrs[attrIndx].type;
                let eleVal = on.valid.isEmpty(formInfo.formAttrs[attrIndx].value) ? "''" : formInfo.formAttrs[attrIndx].value;

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

    // PostPopup Open
    , dynaGenOpenPostPopup( popupInfoObj ){
         if( on.valid.isEmpty( popupInfoObj.popUrlAddr ) ){
             on.msg.consoleLog("팝업 URL을 지정하세요.");
             return false;
         }

         // 팝업 이름 및 창 옵션 설정
         let popupName = popupInfoObj.popUrlAddr;
         let popupSpecs = on.str.nvl(popupInfoObj.popWinStyle, "width=800, height=600, top=100, left=100, scrollbars=yes, resizable=yes");

         // 빈 팝업창 먼저 띄우기 (POST 폼의 Target 영역 선점)
         window.open("", popupName, popupSpecs);

         // 기능(template/board)에 따른 분기 처리
         let actionUrl = popupInfoObj.popUrlAddr;
         let paramList = popupInfoObj.params || [];

         if (popupInfoObj.callBackFn) {
             paramList.push({ name: "callBackFn", value: popupInfoObj.callBackFn });
         }

         // dynaGenHiddenForm을 사용하여 팝업창으로 POST 전송
         on.html.dynaGenHiddenForm({
               formDefine : { fid: "popupPostForm", fTarget: popupName, action: actionUrl, method: "post", isSubmit: true }
             , formAttrs  : paramList      // 팝업에 전달할 데이터 배열
         });
     }

     , dynaGenRadio: function(optionsInfoObj) {
         // 💡 하위 호환성을 위해 targetInfo가 없으면 radioInfo를 찾음
         let targetInfo = optionsInfoObj.targetInfo || optionsInfoObj.radioInfo;
         if (!optionsInfoObj || !targetInfo || on.valid.isEmpty(targetInfo.targetId)) return false;

         const targetId      = targetInfo.targetId;
         const targetProp    = optionsInfoObj.targetProp || optionsInfoObj.radioProp || {};
         const optionWrapper = optionsInfoObj.optionWrapper || {};
         const optionValInfo = optionsInfoObj.optionValInfo || {};
         const dataInfo      = optionsInfoObj.dataInfo || optionsInfoObj.radioDataInfo || [];

         let regex = new RegExp('[^ㄱ-ㅎ가-힣a-zA-Z0-9]', 'g');
         const tempNm = targetId.replace(regex, '');

         // 💡 컴포넌트 전환을 위해 eleNm/eleId를 최우선으로 찾고, 없으면 radioNm/radioId 사용
         const eleNm = targetProp.eleNm || tempNm;
         const eleId = targetProp.eleId || tempNm;
         const inputStyle = targetProp.style ? ` style="${targetProp.style}"` : "";
         const inputClass = targetProp.classNm ? ` class="${targetProp.classNm}"` : "";

         const wrapUseYn = optionWrapper.useYn === "Y";
         const wrapTag   = optionWrapper.tagName || "label";
         const wrapStyle = optionWrapper.style ? ` style="${optionWrapper.style}"` : "";
         const wrapClass = optionWrapper.classNm ? ` class="${optionWrapper.classNm}"` : "";

         let defaultVal = on.valid.isEmpty(optionValInfo.defaultVal) ? "" : String(optionValInfo.defaultVal);
         let inputHtml = "";

         if (dataInfo.length > 0) {
             dataInfo.forEach((data, idx) => {
                 let optionVal  = data[optionValInfo.optId || "code"];
                 let optionText = data[optionValInfo.optTxt || "text"];

                 // 💡 defaultVal 매칭 또는 데이터 자체의 checkYN 속성 모두 지원
                 let isChecked = (data.checkYN === "Y" || data.checkYn === "Y" || String(optionVal) === defaultVal) ? " checked" : "";

                 // 동적 data 속성 바인딩
                 let dynamicDataAttr = "";
                 for (let rowKey in data) {
                     if (rowKey.startsWith("data_") || rowKey.startsWith("data-")) {
                         let cleanKey = rowKey.replace("data_", "").replace("data-", "");
                         dynamicDataAttr += ` data-${cleanKey}="${data[rowKey]}"`;
                     }
                 }

                 let currentId = eleId + "_" + idx;
                 let inputTag = `<input type="radio" name="${eleNm}" id="${currentId}" value="${optionVal}"${inputClass}${inputStyle}${dynamicDataAttr}${isChecked}>`;

                 if (wrapUseYn) {
                     if (wrapTag.toLowerCase() === "label") {
                         inputHtml += `<${wrapTag}${wrapClass}${wrapStyle}>${inputTag} ${optionText}</${wrapTag}>\n`;
                     } else {
                         inputHtml += `<${wrapTag}${wrapClass}${wrapStyle}>${inputTag} <label for="${currentId}">${optionText}</label></${wrapTag}>\n`;
                     }
                 } else {
                     inputHtml += `${inputTag} <label for="${currentId}">${optionText}</label>\n`;
                 }
             });
         }

         $(targetId).empty().html(inputHtml);
     }


     , dynaGenCheckboxes: function(optionsInfoObj) {
         //  필수 타겟 ID 체크
         if (!optionsInfoObj || !optionsInfoObj.targetInfo || on.valid.isEmpty(optionsInfoObj.targetInfo.targetId)) return false;

         const targetId      = optionsInfoObj.targetInfo.targetId;
         const targetProp    = optionsInfoObj.targetProp || {};
         const optionWrapper = optionsInfoObj.optionWrapper || {};
         const optionValInfo = optionsInfoObj.optionValInfo || {};
         const dataInfo      = optionsInfoObj.dataInfo || [];

         // targetId에서 특수문자 제거하여 기본값 생성
         let regex = new RegExp('[^ㄱ-ㅎ가-힣a-zA-Z0-9]', 'g');
         const tempNm = targetId.replace(regex, '');

         // Input 기본 속성 세팅 (eleNm 로직 제거)
         const eleId = on.valid.isEmpty(targetProp.eleId) ? tempNm : targetProp.eleId;
         const inputStyle = targetProp.style ? ` style="${targetProp.style}"` : "";
         const inputClass = targetProp.classNm ? ` class="${targetProp.classNm}"` : "";

         // Wrapper 속성 세팅
         const wrapUseYn = optionWrapper.useYn === "Y";
         const wrapTag   = optionWrapper.tagName || "label";
         const wrapStyle = optionWrapper.style ? ` style="${optionWrapper.style}"` : "";
         const wrapClass = optionWrapper.classNm ? ` class="${optionWrapper.classNm}"` : "";

         let inputHtml = "";

         // 4. 데이터 루프 및 HTML 조립
         if (dataInfo.length > 0) {
             dataInfo.forEach((data, idx) => {
                 let optionVal  = data[optionValInfo.optId || "code"];
                 let optionText = data[optionValInfo.optTxt || "text"];

                 let currentName = optionVal;
                 let currentVal  = "Y";

                 let isChecked = (data.checkYN === "Y" || data.checkYn === "Y") ? " checked" : "";
                 let dynamicDataAttr = "";
                 for (let rowKey in data) {
                     if (rowKey.startsWith("data_") || rowKey.startsWith("data-")) {
                         let cleanKey = rowKey.replace("data_", "").replace("data-", "");
                         dynamicDataAttr += ` data-${cleanKey}="${data[rowKey]}"`;
                     }
                 }

                 let currentId = eleId + "_" + idx;

                 // 최종 Input 태그 조립
                 let inputTag = `<input type="checkbox" name="${currentName}" id="${currentId}" value="${currentVal}"${inputClass}${inputStyle}${dynamicDataAttr}${isChecked}>`;

                 // Wrapper 처리에 따른 분기
                 if (wrapUseYn) {
                     if (wrapTag.toLowerCase() === "label") {
                         inputHtml += `<${wrapTag}${wrapClass}${wrapStyle}>${inputTag} ${optionText}</${wrapTag}>\n`;
                     } else {
                         inputHtml += `<${wrapTag}${wrapClass}${wrapStyle}>${inputTag} <label for="${currentId}">${optionText}</label></${wrapTag}>\n`;
                     }
                 } else {
                     inputHtml += `${inputTag} <label for="${currentId}">${optionText}</label>\n`;
                 }
             });
         }
         // 화면에 렌더링
         $(targetId).empty().html(inputHtml);
     }


    // select Box Option 갱신
     , dynaGenSelectOptions: function(optionsInfoObj) {
         let targetInfo = optionsInfoObj.targetInfo || optionsInfoObj.comboInfo;
         if (!optionsInfoObj || !targetInfo || on.valid.isEmpty(targetInfo.targetId)) return false;

         const targetId      = targetInfo.targetId;
         const addOption     = optionsInfoObj.addOption || []; // "전체", "선택" 등 최상단 요소
         const optionValInfo = optionsInfoObj.optionValInfo || {};
         const dataInfo      = optionsInfoObj.dataInfo || optionsInfoObj.comboDataInfo || [];

         let defaultVal = on.valid.isEmpty(optionValInfo.defaultVal) ? "" : String(optionValInfo.defaultVal);
         let optionHtml = "";

         // 1. addOption 처리 (상단 추가)
         if (addOption.length > 0) {
             addOption.forEach(opt => {
                 if (opt.position === "top" || !opt.position) {
                     optionHtml += `<option value="${opt.val}">${opt.txt}</option>\n`;
                 }
             });
         }

         // 2. dataInfo 데이터 루프
         if (dataInfo.length > 0) {
             dataInfo.forEach(data => {
                 let optionVal  = data[optionValInfo.optId || "code"];
                 let optionText = data[optionValInfo.optTxt || "text"];

                 // Select는 checked 대신 selected 사용
                 let isSelected = (data.checkYN === "Y" || data.checkYn === "Y" || String(optionVal) === defaultVal) ? " selected" : "";

                 // Option 태그에도 동적 data 속성 지원
                 let dynamicDataAttr = "";
                 for (let rowKey in data) {
                     if (rowKey.startsWith("data_") || rowKey.startsWith("data-")) {
                         let cleanKey = rowKey.replace("data_", "").replace("data-", "");
                         dynamicDataAttr += ` data-${cleanKey}="${data[rowKey]}"`;
                     }
                 }

                 optionHtml += `<option value="${optionVal}"${dynamicDataAttr}${isSelected}>${optionText}</option>\n`;
             });
         }

         // 3. addOption 처리 (하단 추가가 필요할 경우 대비)
         if (addOption.length > 0) {
             addOption.forEach(opt => {
                 if (opt.position === "bottom") {
                     optionHtml += `<option value="${opt.val}">${opt.txt}</option>\n`;
                 }
             });
         }

         $(targetId).empty().html(optionHtml);
     }



    /* 12개월 ComboBox Option 생성  */
   , getMonthComboOptions : function() {
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
    getYearComboOptions(yearOptObj) {
        if (on.valid.isEmpty(comboInfoObj.targetId)) return false;
        let beginYear = Number(on.valid.isEmpty(comboInfoObj.years.beginYear) ?  on.date.getYear() : comboInfoObj.years.beginYear);
        let finishYear = Number(on.valid.isEmpty(comboInfoObj.years.finishYear) ? on.date.getYear() : comboInfoObj.years.finishYear);


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
    }



     , getYearArrayList : function(yearOptObj){
         let beginYear  = Number(on.valid.isEmpty(yearOptObj.beginYear)  ? on.date.getYear() : yearOptObj.beginYear);
         let finishYear = Number(on.valid.isEmpty(yearOptObj.finishYear) ? on.date.getYear() : yearOptObj.finishYear);

         let yearList = [];

         // on.html.getYearArrayList({yearOptObj  })

         //  오름차순 (예: 2020 -> 2026)
         if (beginYear <= finishYear) {
             for (let i = beginYear; i <= finishYear; i++) {
                 yearList.push(i);
             }
         }
         // 내림차순 (예: 2026 -> 2020) - 셀렉트박스에서 최근 연도를 맨 위에 보여줄 때 유용합니다.
         else {
             for (let i = beginYear; i >= finishYear; i--) {
                 yearList.push(i);
             }
         }
         return yearList;
      }

    /*****  Document의 값 수집 ****/
    , getEleVal : function(eleObj) {

        var eleVal;
        var eleDiv = on.html.getEleType($(eleObj.ele));
        if (!on.valid.isEmpty( eleDiv ) ) {
            if (eleDiv == "text" || eleDiv == "number") {
                eleVal = $(eleObj.ele).val();
            } else if (eleDiv == "hidden") {
                eleVal = $(eleObj.ele).val();
            } else if (eleDiv == "radio") {
                let radioName = $(eleObj.ele).attr("name");
                if (!on.valid.isEmpty(radioName)) {
                    eleVal = $("input[type='radio'][name='" + radioName + "']:checked").val();
                } else {
                    eleVal = $(eleObj.ele).filter(":checked").val();
                }
            } else if (eleDiv == "select") {
                eleVal = $(eleObj.ele).val();
            } else if (eleDiv == "file") {
                eleVal = $(eleObj.ele).clone();
            } else if (eleDiv == "checkbox") {
                eleVal = $(eleObj.ele).is(":checked") ? "Y" : "N";
            } else if (eleDiv == "textarea") {
                eleVal = $(eleObj.ele).val();
            } else if (eleDiv == "password") {
                eleVal = on.enc.encrypt({encVal: $(eleObj.ele).val()});
            } else {
                eleVal = $(eleObj.ele).text();
            }
        }
        else {
            on.msg.consoleLog("eleObj.ele : "+eleObj.ele+"은(는) 없습니다.")
        }

        // eleVal이 값이없고,  defaultVal값이 선언되어 있다면...
        if(on.valid.isEmpty(eleVal) && !on.valid.isEmpty(eleObj.defaultVal)){
            eleVal = ele.defaultVal;
        }
        return eleVal;
    }
    , setEleVal : function(setObj) {

        if(on.valid.isEmpty(setObj.ele) ){
            console.log("Set element Id를 지정하세요.");
            return false;
        }

        var eleVal = on.str.nvl(setObj.val,setObj.defaultVal);
        var eleDiv = on.html.getEleType($(setObj.ele));
        if (!on.valid.isEmpty( eleDiv ) ){
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
        }
        else {
            on.msg.consoleLog(setObj.ele+"는 Document에 없습니다. (대소문자 구분함) ");
        }
        return  $(setObj.ele);
    }
    /*****  Element Type 조회 ****/
   ,  getEleType : function (ele) {
        var $el = $(ele);
        var eleType;

        if( $el.length > 0 ){
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
        }
        return eleType;
    }

    /*  콤퍼넌트 DatePicker 지정  as-is : opntFncDate*/
    , setDatePicker : function(dataPickersObj) {
         if (on.valid.isEmpty(dataPickersObj.targets)) {
             console.log("개발자오류: dataPickersObj.targets 없음");
             return false;
         }

         let pickerFormat = dataPickersObj.dateFormat || "yy.mm.dd";
         let isRangeMode = (dataPickersObj.targets.length >= 2); // 2개 이상일 때만 기간(Range) 모드 작동

         let startDateId = "";
         let tarEles = "";

         if (isRangeMode) {
             startDateId = dataPickersObj.targets[0].replace("#", "");
         }

         for (let i = 0; i < dataPickersObj.targets.length; i++) {
             if (i != 0) tarEles += ", ";
             tarEles += dataPickersObj.targets[i];
         }

         $(tarEles).attr('readonly', true);

         let dates = $(tarEles).datepicker({
             changeMonth: true
             , changeYear: true
             , showOn: "button"
             , buttonImage: "/internal/standard/guide/images/icon/i_cal.svg"
             , buttonImageOnly: true
             , dateFormat: pickerFormat
             , onSelect: function (selectedDate) {
                 // 단일 달력이면 onSelect에서 아무 연동 작업도 하지 않음
                 if (!isRangeMode) {
                     $(this).trigger("change");
                     return;
                 }

                 // 기간(Range) 모드일 때만 minDate / maxDate 연동 처리
                 var option = this.id == startDateId ? "minDate" : "maxDate",
                     instance = $(this).data("datepicker"),
                     date;

                 if (pickerFormat === 'yy.mm') {
                     date = new Date(instance.selectedYear, instance.selectedMonth, 1);
                 } else {
                     date = $.datepicker.parseDate(pickerFormat, selectedDate, instance.settings);
                 }
                 dates.not(this).datepicker("option", option, date);
                 $(this).trigger("change");
             }
         });
     }
    /*  이미지 파일 미리보기 */
     , preViewImageShow : function(preViewObj) {
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

    // Table 내부 엘리먼트 tbody > tr > td 값 수집 (Array in Object형태)
     , tableData2Array: function(dataInfo) {
         let targetSelector = "";
         if (typeof dataInfo === "string") {
             targetSelector = dataInfo;
         } else if (!on.valid.isEmpty(dataInfo) && !on.valid.isEmpty(dataInfo.targetId)) {
             targetSelector = dataInfo.targetId;
         } else {
             on.msg.consoleLog("대상 테이블의 Selector를 지정해주세요.");
             return [];
         }

         let resultArr = [];

         $(targetSelector).find("tr").each(function() {
             let $tr = $(this);
             let rowData = {};
             let isRowHasData = false;

             let rowDataDiv = $tr.attr("data-row_data_div");
             if (!on.valid.isEmpty(rowDataDiv)) {
                 rowData["rowDataDiv"] = rowDataDiv; // "db" 또는 "new" 삽입
             }

             let processedNames = new Set();

             $tr.find("[name]").each(function() {
                 let $el = $(this);
                 let domName = $el.attr("name");

                 if (on.valid.isEmpty(domName) || processedNames.has(domName)) return true;
                 let eleVal = on.html.getEleVal({ ele: $el });
                 let voName = $el.attr("data-name") || domName;
                 rowData[voName] = on.valid.isEmpty(eleVal) ? "" : eleVal;
                 processedNames.add(domName);
                 isRowHasData = true;
             });

             if (isRowHasData) {
                 resultArr.push(rowData);
             }
         });

         return resultArr;
     }
    // Html Docuemnt내부에 엘리먼트 ID와 eleValues의 Key 가 일치하면 자동으로 값 세팅
     , docSetElementById( eleValues ){
         if(on.valid.isEmpty(eleValues)) return false;

         for(let eleKey of Object.keys(eleValues)){
             let eleVal = eleValues[eleKey];
             if (eleVal === null || eleVal === undefined) continue;

             let $ele = $("[name='" + eleKey + "']");
             if($ele.length === 0){ $ele = $("#" + eleKey); }

             if($ele.length > 0){
                 let eleType = on.html.getEleType($ele.first()); // 다중 요소일 수 있으므로 첫 번째 요소 기준 판단

                 if (eleType === "radio") {
                     $ele.filter("[value='" + eleVal + "']").prop("checked", true);
                 } else if (eleType === "checkbox") {
                     if (eleVal === "Y" || eleVal === "N" || eleVal === true || eleVal === false) {
                         $ele.prop("checked", (eleVal === "Y" || eleVal === true));
                     } else {
                         $ele.filter("[value='" + eleVal + "']").prop("checked", true);
                     }
                 } else if (eleType === "select") {
                     $ele.val(eleVal).prop("selected", true);
                 } else if (eleType === "text" || eleType === "hidden" || eleType === "textarea" || eleType === "number" || eleType === "password") {
                      $ele.val(eleVal);
                 } else {
                     $ele.text(eleVal);
                 }
             }
         }
     }
    // 특정 앨리먼트 값들을 세팅한다.
     , resetElementsByObject : function(resetObj) {
         if(on.valid.isEmpty(resetObj)) return false;
         this.docSetElementById(resetObj);
     }
     , docFormDisEnable : function (formInfoObj){
         if(on.valid.isEmpty(formInfoObj) || on.valid.isEmpty(formInfoObj.formId)) {
             console.log("대상 Form ID를 지정하세요.");
             return false;
         }

         let formId  = formInfoObj.formId;
         let isAbleDiv = formInfoObj.isAbleDiv;  // true: 활성화(enable), false: 비활성화(disable)

         // form 하위의 모든 입력 관련 요소 제어
         $(formId).find("input, select, textarea, button").prop("disabled", isAbleDiv);
         //$(formId).find(".hasDatepicker").datepicker("option", "disabled", isAbleDiv);
    }
     /* 검색조건 다시 세팅 */
     , setSearchConditions : function(searchCondiObj) {
         $.each(Object.keys(searchCondiObj), function (indx, key) {
             let eleType = on.html.getEleType("#" + key);
             let eleVal = searchCondiObj[key];

             if (!on.valid.isEmpty(eleType)) {
                 if (eleType == "radio") {
                     //$("#"+name+"[value='"+eleVal+"']").prop("checked", true).attr("checked", true);
                     $("#" + key + "[value='" + eleVal + "']").prop("checked", true).attr("checked", true);
                 } else if (eleType == "checkbox") {
                     if (eleVal == "Y") {
                         $("#" + key).prop("checked", true).attr("checked", true);
                     }
                 } else if (eleType == "select") {
                     $("#" + key).val(eleVal).attr("selected", "selected");
                 } else {
                     $("#" + key).val(eleVal);
                 }
             }
         });
     }

}

    window.htmlFns = htmlFns;

})(window);