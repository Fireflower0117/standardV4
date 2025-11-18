 
(function($) {
 
    /*  Data조회 관련 함수 */
    const xhrFns = {
      
      ajax: function(callAjaxObj) {
        /*  호출 템플릿 = var  callAjaxObj =   { sid       : "callAjax_Uniq_Id"
                                             , cmd       : "selectPageList"
                                             , sql       : "opnt.common.sql_test"
                                             , ..........
                                             , successFn : function (rs){ }
                                             , failFn    : function (err){ } 
                                             } 
         *  @descriptions
         *    callAjaxObj.sid = ajax실행주체의 고유ID , callbackFunction.successFn함수 sid로 전달됨
         *    callAjaxObj.successFn = Ajax 호출후 결과가 성공일때 호출되는 Function , 만약 callAjaxObj.sid가 있다면 사용자 정의 success Function의 첫 인자값으로 sid가 넘어간다.
         *    callAjaxObj.failFn    = Ajax 호출후 결과가 실패일때 호출되는 Function
         *    callAjaxObj.cmd = selectPage, selectList, selectOne , multiSelect 
         *                     , insert , insertlist  , update , updatelist , delete , deletelist  
         *                      ex) cmd = selectPageList :
         *                                pageNo , pageSize는 필수값.  pageNo : 사용자가 선택한 페이지번호 ,  pageSize 한화면에 보여질 dataRowCount
         *                                사용자 미입력시 기본값 ( pageNo = 1 ,  pageSize = 10 )
         *                          cmd = selectList : return List<map>  
         *                          cmd = selectOne : return map
         *                          cmd = multiSelect : return {List<map> , List<map> , List<map>}
         *                          cmd = insert 단건 입력 , insertlist 다건일괄 입력
         *                          cmd = update 단건 수정 , updatelist 다건일괄 수정
         *                          cmd = delete 단건 삭제 , deletelist 다건일괄 삭제  
         *   callAjaxObj.sql = "opnt.common.sql_test" => mybatis( <mapper namespace="opnt.common"> <sql id="sql_test"> )
          
         *  ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
         *   ====>>>> callAjaxObj의 successFn , failFn 을 제외한 나머지 속성은 전부 ajax.data안에 입력된다.  <<=====
         *  ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
         */  
         
          var isReturn = true;

          var ajaxPostOptions = {data: {}};
          /* Custom Success Function Init */
           
         if (!validateFns.isEmpty(callAjaxObj.successFn) && typeof callAjaxObj.successFn === 'function') {
                ajaxPostOptions.success = function (rs) {
                    if (typeof callAjaxObj.sid == "string") {
                        isReturn = false;
                        callAjaxObj.successFn(callAjaxObj.sid, rs);
                    } else {
                        isReturn = false;
                        callAjaxObj.successFn(rs);
                    }
                }
          }
        
          /* Custom Fail Function Init */
          if (!validateFns.isEmpty(callAjaxObj.failFn) && typeof callAjaxObj.failFn === 'function') {
                ajaxPostOptions.error = function (errObj, errMsg, errCause) {
                    isReturn = false;
                    callAjaxObj.failFn(errObj, errMsg, errCause);
                }
          }
        
          /* 동기 호출 여부 세팅 */
          ajaxPostOptions.async = stringFns.nvl(callAjaxObj.async, ajaxPostOptions.success ? true : false);
        
          /* Ajax 호출 기본값 SelectList */
          var sqlCmd = stringFns.nvl(callAjaxObj.cmd, "selectList");
        
          if (sqlCmd == "selectPage") {
        
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                //ajaxPostOptions.url = getContextPath() +'/query/json?qid='+ callAjaxObj.sql+'_page';
                ajaxPostOptions.url = '/com/query/selectList.ajx?qid=' + callAjaxObj.sql;
                var pageNo = Number(stringFns.nvl(callAjaxObj.pageNo, 1));
                var pageSize = Number(stringFns.nvl(callAjaxObj.pageSize, 10));
                ajaxPostOptions.data.rn_bottom = (pageNo * pageSize) - pageSize;
                ajaxPostOptions.data.rn_top = (pageNo * pageSize);
                ajaxPostOptions.data.rn_deorder = ajaxPostOptions.data.rn_bottom + ajaxPostOptions.data.rn_top;
        
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          } else if (sqlCmd == "selectList") {
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                ajaxPostOptions.url = '/com/query/selectList.ajx?qid=' + callAjaxObj.sql;
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          } else if (sqlCmd == "selectOne") {
        
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                ajaxPostOptions.url = '/com/query/selectOne.ajx?qid=' + callAjaxObj.sql;
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          } else if (sqlCmd == "multiSelect") {
                ajaxPostOptions.url = '/com/query/multiSelect.ajx';
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;  // selectTargets Only
                    }
                }
          } else if (sqlCmd == "insert") {
        
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                ajaxPostOptions.url = '/com/query/insert.ajx?qid=' + callAjaxObj.sql;
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          } else if (sqlCmd == "update") {
        
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                ajaxPostOptions.url = '/com/query/update.ajx?qid=' + callAjaxObj.sql;
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          } else if (sqlCmd == "updatelist") {
        
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                ajaxPostOptions.url = '/com/query/updatelist.ajx?qid=' + callAjaxObj.sql;
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          } else if (sqlCmd == "delete") {
        
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                ajaxPostOptions.url = '/com/query/delete.ajx?qid=' + callAjaxObj.sql;
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          } else if (sqlCmd == "deletelist") {
        
                // sql Attribute 없으면 return
                if (validateFns.isEmpty(callAjaxObj.sql)) return {};
        
                ajaxPostOptions.url = '/com/query/deletelist.ajx?qid=' + callAjaxObj.sql;
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (key != "successFn" && key != "failFn") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
          }
        
          // How to dynamic make[{},{},{}]
          ajaxPostOptions.contentType = "application/json;charset=UTF-8";
            //ajaxPostOptions.contentType = "application/x-www-form-urlencoded;charset=UTF-8";
          if (ajaxPostOptions.data && !(ajaxPostOptions.data instanceof Array))
              ajaxPostOptions.data = [ajaxPostOptions.data];
        
          if (ajaxPostOptions.data)
              ajaxPostOptions.data = JSON.stringify(ajaxPostOptions.data);
        
          var resultData = {};
          var baseAjaxObj = {
                  type: "post"
                , async: false
                , dataType: "json"
                //, contentType : 'application/json;charset=UTF-8'
                , beforeSend: function (xhr, settings) {
                    messageFns.showProgress();
                }
                , complete: function (xhr, sts) {
                    messageFns.hideProgress(); 
                }
                , success: function (rs) {
                    isReturn = true;
                    resultData = rs;
                }
                , error: function (err) {
                    messageFns.showMsg("처리중 에러발생.");
                }
            }
        
          var targetObj = $.extend(true, baseAjaxObj, ajaxPostOptions);
          $.ajax(targetObj); 
          if (isReturn) return resultData; 
      } ,
      /* 검색조건 다시 세팅 */
      setSearchConditions : function(searchCondiObj) {
            $.each(Object.keys(searchCondiObj), function (indx, key) {
                let eleType = htmlFns.getEleType("#" + key);
                let eleVal = searchCondiObj[key];
        
                if (!validateFns.isEmpty(eleType)) {
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

    /************************************************************************************/
    /***************************          STRING FUNCTIONS           ********************/
    /************************************************************************************/  
    const stringFns = {
        nvl  : function (chkObj, repStr) { 
               repStr = validateFns.isEmpty(repStr) ? "" : repStr;
               if (validateFns.isEmpty(chkObj)) return repStr;
               else return chkObj;
        },
        trim : function(tarTrimStr) {
            return $.trim(tarTrimStr);
        },
        inStrCount : function(tarStr , chkChr) {
            var duplCharCnt = 0
            for (var i = 0; i < tarStr.length; i++) {
                if (tarStr[i] == chkChr) duplCharCnt++;
            }
            return duplCharCnt;
        },
        trimAll : function(tarTrimStr) {
            var trimSplitArr = tarTrimStr.split(" ");
            return trimSplitArr.join("");
        },
        searchConditionParse : function(JsonSearchCondi) {
            return JSON.parse(stringFns.replaceAll(JsonSearchCondi, "&#034;", '"'));
        },
        replaceAll : function(tarStr, tarSplitStr, tarRepStr = "") {
            var trimSplitArr = tarStr.split(tarSplitStr);
            return trimSplitArr.join(tarRepStr);
        },
        lPad : function (tarStr, paddLen, paddStr) {
            tarStr = tarStr.toString();
            return tarStr.length < paddLen ? stringFns.lPad(paddStr + tarStr, paddLen, paddStr) : tarStr;
        },
        rPad : function(tarStr, paddLen, paddStr) {
            tarStr = tarStr.toString();
            return tarStr.length < paddLen ? stringFns.rPad(tarStr + paddStr, paddLen, paddStr) : tarStr;
        },
        subString : function (orgStr, beginIndx, endIndx) {
            return orgStr.substring(beginIndx, endIndx);
        }, 
        shaEncrypt512 : function(orgStr) {
            //  include sha.js (Ver.01 )
            // var jsShaStr = new jsSHA(stringFns.trimAll(orgStr));
            // return jsShaStr.getHash("SHA-512", "HEX");
            
            var shaObj = new jsSHA("SHA-512", "TEXT"); // v3라면 옵션 추가 가능: , { encoding: "UTF8" }
            shaObj.update(stringFns.trimAll(orgStr));
            return shaObj.getHash("HEX");
        } 
    }
    
    
    /************************************************************************************/
    /***************************          VALIDATE FUNCTIONS           ********************/
    /************************************************************************************/
    const validateFns = {
        isEmpty : function(chkObj){
              // null 또는 undefined
              if (chkObj === null || chkObj === undefined) return true;
            
              if (typeof chkObj === 'string') { // 문자열
                  return chkObj.trim() === '' || chkObj === 'null';
              } 
              if (typeof chkObj === 'number') { // 숫자 (0은 empty로 보지 않음)
                return isNaN(chkObj);
              } 
              if (Array.isArray(chkObj)) { // 배열
                return chkObj.length === 0;
              } 
              if (typeof chkObj === 'object') { // 객체 (null은 이미 걸렀고, 배열은 위에서 처리함)
                return Object.keys(chkObj).length === 0;
              }  
              if (typeof chkObj === 'boolean') { // 불리언은 무조건 비어있지 않다고 판단
                return false;
              }
              if (typeof chkObj === 'function') {
                return false;
              } 
              return true;
        }
    }
    
    /************************************************************************************/
    /***************************            ETC FUNCTIONS            ********************/
    /************************************************************************************/
    const messageFns = {
          showMsg : function(msg) {
              alert(msg);
          },
          confirm : function(msg) {
                return confirm(msg);
          },
          showProgress() {
                 console.log('opntShowProgress'); 
                /*
                var progresHtml = `<div class="loading_wrap entire">
                                            <div class="loading_box">
                                                <svg class="loader" width="79px" height="79px" viewBox="0 0 80 80" xmlns="http://www.w3.org/2000/svg">
                                                    <circle class="path" fill="none" stroke-width="8" stroke-linecap="round" cx="40" cy="40" r="25"></circle>
                                                </svg>
                                                <b>loading</b>
                                            </div>
                                         </div>`;
                                         
                if (typeof $.blockUI != "undefined") {
                    $.blockUI({message: progresHtml});
                }*/
          },
          hideProgress() {
             console.log('opntHideProgress');
            //if (typeof $.unblockUI != "undefined") {
            //    $.unblockUI();
            //} 
          }  
    }
    
    
        
    

    
    
    
    /************************************************************************************/
    /***************************            Host FUNCTIONS            ********************/
    /************************************************************************************/
    const hostFns = {
          getContextPath : function(msg) {
              var hostIndex = location.href.indexOf(location.host) + location.host.length;
              return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
          },
          hostContextPath : function(msg) {
                    return location.protocol + "//" + location.host + hostFns.getContextPath();
          }

    }
    
    /************************************************************************************/
    /***************************            HTML FUNCTIONS            ********************/
    /************************************************************************************/
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
            
                if (!validateFns.isEmpty(colInfo)) { 
                    var resourceRowsLenght = tarDispObj.resource.length;
                    if (resourceRowsLenght == 0) {
                        $(tarDispObj.dispTarget).html("<tr><td colSpan='"+colInfoLength+"' class='no_data'>데이터가 없습니다.</td></tr>");
                        if (!validateFns.isEmpty(tarDispObj.paginginfo)) {
                            $(tarDispObj.paginginfo.targetId).html(""); 
                            if (!validateFns.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
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
                                let colType = stringFns.nvl(colInfo[j].colType, "string");
                                let colAlign = stringFns.nvl(colInfo[j].align, "center");
                                let colStyle = stringFns.nvl(colInfo[j].style, "");
                                //var colClassNm  = stringFns.nvl(colInfo[j].classNm  , "");
                                let uniqId = colInfo[j].id + "_" + stringFns.nvl(resourceRow.rownum_, i);
                                let tarUniqId = " id='" + uniqId + "' ";
                                let tarUniqNm = " name='" + uniqId + "' ";
                                let tarUniqFor = " for='" + uniqId + "' ";
                                let tarClassNm = stringFns.nvl(colInfo[j].classNm) == "" ? "" : " class='" + colInfo[j].classNm + "'";
                                let tarStyleNm = stringFns.nvl(colInfo[j].styleNm) == "" ? "" : " style='" + colInfo[j].styleNm + "'";
                                let tarColValue = stringFns.nvl(resourceRow[colInfo[j].id], "");
                                //var nullDisp    = stringFns.nvl(colInfo[j].nullDisp , "Y"); 

                                var dataPropsHtml = "";
                                if (i == 0 && j == 0) {
                                    totRowCnt = resourceRow.totalCount;
                                }

                                for (var k = 1; k <= 10; k++) {
                                    var dataProp = stringFns.nvl(colInfo[j]["data_id" + k], "anonymous");
                                    if ("anonymous" != dataProp) {
                                        tarDispObj.resource[i][dataProp]
                                        var dataPropVal = stringFns.nvl(tarDispObj.resource[i][dataProp], "");
                                        dataPropsHtml += " data-" + dataProp + "='" + dataPropVal + "' ";
                                    }
                                }
                                if (colType == "string") {
                                    targetHtml += "<td " + tarUniqId + " " + tarStyleNm + " " + tarClassNm + " " + dataPropsHtml + ">" + tarColValue + "</td>";
                                } else if (colType == "double") {
                                    var colDblPattrn = stringFns.nvl(colInfo[j].pattern, ".##");
                                    var colDblPattrnLen = opntInStrCount(colDblPattrn, "#");

                                    var colDblVal = Number(stringFns.nvl(tarColValue, 0)).toFixed(colDblPattrnLen);
                                    if (colDblVal == 0) colDblVal = validateFns.isEmpty(colInfo[j].zero) ? colDblVal : colInfo[j].zero;

                                    targetHtml += "   <td " + tarUniqId + " " + tarUniqNm + " " + dataPropsHtml + ">" + colDblVal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + "</td>";

                                } else if (colType == "number") {
                                    if ($.isNumeric(tarColValue)) {
                                        targetHtml += "   <td " + tarUniqId + " " + dataPropsHtml + " " + tarStyleNm + " " + tarClassNm + ">" + ("" + Math.round(tarColValue, 1)).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + "</td>";
                                    } else {
                                        targetHtml += "   <td " + tarUniqId + " " + dataPropsHtml + " " + tarStyleNm + " " + tarClassNm + ">" + (validateFns.isEmpty(colInfo[j].zero) ? "0" : colInfo[j].zero) + "</td>";
                                    }
                                } else if (colType == "hidden") {
                                    targetHtml += "   <td style='display: none;' " + tarUniqId + " " + dataPropsHtml + " " + tarStyleNm + " " + tarClassNm + ">" + tarColValue + "</td>";
                                } else if (colType == "button") {
                                    let tarBtnText = stringFns.nvl(resourceRow[colInfo[j].btnText], "")
                                    targetHtml += "  <td style='text-align:center;'>";
                                    targetHtml += "  	<button type='button' " + tarUniqId + " style='" + colStyle + "' " + tarStyleNm + " " + tarClassNm + " " + dataPropsHtml + ">" + tarBtnText + "</button>";
                                    targetHtml += "  </td>";
                                } else if (colType == "checkbox") {
                                    let chkValue = validateFns.isEmpty(colInfo[j].classNm) ? "" : " value='" + colInfo[j].classNm + "'";
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
                                    let ext = stringFns.nvl(resourceRow[colInfo[j].id], "");

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
                        if (!validateFns.isEmpty(tarDispObj.paginginfo)) {

                            if (!validateFns.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                                $(tarDispObj.paginginfo.totRowsCntId).text(totRowCnt);
                            }


                            var isDel = stringFns.nvl(tarDispObj.paginginfo.clear, false);
                            if (stringFns.nvl(tarDispObj.paginginfo.clear, false)) {
                                $(tarDispObj.paginginfo.targetId).html("");
                            } else {
                                htmlFns.PageNationDisp({
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
                    htmlFns.setDatePicker("#" + $(ele).attr("id"));
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
            
                if (!validateFns.isEmpty(colInfo)) { 
                    var resourceRowsLenght = tarDispObj.resource.length;
                    if (resourceRowsLenght == 0) {
                        $(tarDispObj.dispTarget).html("<li class='no_data'><p>데이터가 없습니다.</p></li>");
                        if (!validateFns.isEmpty(tarDispObj.paginginfo)) {
                            $(tarDispObj.paginginfo.targetId).html(""); 
                            if (!validateFns.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                                $(tarDispObj.paginginfo.totRowsCntId).text("0");
                            }  
                        }
                    } else {
                        var totRowCnt = 0;
                        for (var i = 0; i < resourceRowsLenght; i++) {
 
                            for (var j = 0; j < colInfoLength; j++) {
                                let resourceRow = tarDispObj.resource[i];
                                let colId = colInfo[j].id;
                                let colType = stringFns.nvl(colInfo[j].colType, "string");
                                let colAlign = stringFns.nvl(colInfo[j].align, "center");
                                let colStyle = stringFns.nvl(colInfo[j].style, "");
                                //var colClassNm  = stringFns.nvl(colInfo[j].classNm  , "");
                                let uniqId = colInfo[j].id + "_" + stringFns.nvl(resourceRow.rownum_, i);
                                let tarUniqId = " id='" + uniqId + "' ";
                                let tarUniqNm = " name='" + uniqId + "' ";
                                let tarUniqFor = " for='" + uniqId + "' ";
                                let tarClassNm = stringFns.nvl(colInfo[j].classNm) ? "" : " class='" + colInfo[j].classNm + "'";
                                let tarStyleNm = stringFns.nvl(colInfo[j].styleNm) ? "" : " style='" + colInfo[j].styleNm + "'";
                                let tarColValue = stringFns.nvl(resourceRow[colInfo[j].id], "");
                                //var nullDisp    = stringFns.nvl(colInfo[j].nullDisp , "Y"); 

                                var dataPropsHtml = "";
                                if (i == 0 && j == 0) {
                                    totRowCnt = resourceRow.totalCount;
                                }

                                for (var k = 1; k <= 10; k++) {
                                    var dataProp = stringFns.nvl(colInfo[j]["data_id" + k], "anonymous");
                                    if ("anonymous" != dataProp) {
                                        tarDispObj.resource[i][dataProp]
                                        var dataPropVal = stringFns.nvl(tarDispObj.resource[i][dataProp], "");
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
                        if (!validateFns.isEmpty(tarDispObj.paginginfo)) {

                            if (!validateFns.isEmpty(tarDispObj.paginginfo.totRowsCntId)) {
                                $(tarDispObj.paginginfo.totRowsCntId).text(totRowCnt);
                            }


                            var isDel = stringFns.nvl(tarDispObj.paginginfo.clear, false);
                            if (stringFns.nvl(tarDispObj.paginginfo.clear, false)) {
                                $(tarDispObj.paginginfo.targetId).html("");
                            } else {
                                htmlFns.PageNationDisp({
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
                    htmlFns.setDatePicker("#" + $(ele).attr("id"));
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
            
            if (validateFns.isEmpty(formInfo.formDefine.fid)) return false;

            var formId = formInfo.formDefine.fid;
            var formName = validateFns.isEmpty(formInfo.formDefine.fname) ? formId : formInfo.formDefine.fname;
            var formAction = validateFns.isEmpty(formInfo.formDefine.action) ? "" : " action='" + formInfo.formDefine.action + "'";
            var formEncType = validateFns.isEmpty(formInfo.formDefine.enctype) ? "application/json" : formInfo.formDefine.enctype;
            var formTarget = validateFns.isEmpty(formInfo.formDefine.fTarget) ? "" : " target='" + formInfo.formDefine.fTarget + "'";
            var paramMethod = validateFns.isEmpty(formInfo.formDefine.method) ? "post" : formInfo.formDefine.method;
            if (paramMethod.toUpperCase() != "GET" && paramMethod.toUpperCase() != "POST") paramMethod = "post";
            formMethod = " method='" + paramMethod + "'";
            var formClass = validateFns.isEmpty(formInfo.formDefine.classNm) ? "" : " class='" + formInfo.formDefine.classNm + "'";
            var formStyle = validateFns.isEmpty(formInfo.formDefine.style) ? "" : " style='" + formInfo.formDefine.style + "'";
            var insertTrget = validateFns.isEmpty(formInfo.formDefine.insTarget) ? "body" : formInfo.formDefine.insTarget;
            
            
            var inputAttrsHtml = "";
            if (!validateFns.isEmpty(formInfo.formAttrs)) {
                var formAttrsKeys = Object.keys(formInfo.formAttrs);
                let fileNmIndx = 0;
                for (var i = 0; i < formAttrsKeys.length; i++) {
                    var inputEleObj = eval("formInfo.formAttrs." + formAttrsKeys[i]);
                    var eleName = validateFns.isEmpty(inputEleObj.name) ? formAttrsKeys[i] : inputEleObj.name;
                    var eleType = validateFns.isEmpty(inputEleObj.type) ? "hidden" : inputEleObj.type;
                    var eleVal = validateFns.isEmpty(inputEleObj.val) ? "''" : inputEleObj.val;
        
                    if (eleType == "file") {
                        inputAttrsHtml += "<input type='" + eleType + "' id='" + formAttrsKeys[i] + "' name='" + eleName + "'                    style='display:none;' >";
                    } else if (eleType == "files") {
                        if (!validateFnsisEmpty(eleVal)) {
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
            
            if (!validateFns.isEmpty(formInfo.formAttrs)) {
                var formAttrsKeys = Object.keys(formInfo.formAttrs);
                for (var i = 0; i < formAttrsKeys.length; i++) {
                    var inputEleObj = eval("formInfo.formAttrs." + formAttrsKeys[i]);
                    var eleName = validateFns.isEmpty(inputEleObj.name) ? formAttrsKeys[i] : inputEleObj.name;
                    var eleType = validateFns.isEmpty(inputEleObj.type) ? "hidden" : inputEleObj.type;
                    var eleVal = validateFns.isEmpty(inputEleObj.val) ? "''" : inputEleObj.val;
        
                    if (eleType == "file") {
                        var colneFile = $(eleVal).clone(true);
                        $("#" + formId + " [name='" + eleName + "']")[0].files = colneFile[0].files;
                    } else if (eleType == "files") {
        
                        if (eleVal.length > 0) {
                            let eleNmFileIndex = 0;
                            for (fFileIndx in eleVal.toArray()) {
                                let originalFiles = eleVal[fFileIndx].files;
                                if (originalFiles.length > 0) {
        
                                    //for(dFileIndx in Object.keys(originalFiles) ){
                                    var fileInput = $("#" + formId + " [name='" + eleName + "_" + eleNmFileIndex + "']")[0]; // 대상 input 요소 
        
                                    var dataTransfer = new DataTransfer();
                                    dataTransfer.items.add(originalFiles["0"]); // 첫 번째 파일만 추가
                                    console.log("===============================================");
                                    console.log("eleName : " + eleName);
                                    console.log("fileName : " + originalFiles["0"].name);
        
        
                                    console.log("fileInput : " + fileInput);
                                    console.log("dFileIndx : " + fFileIndx);
                                    console.log("dataTransfer.files : " + dataTransfer.files);
                                    console.log("#" + formId + " [name='" + eleName + "_" + eleNmFileIndex + "']");
        
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
        
                    formInfo.formDefine.action = validateFns.isEmpty(formInfo.formDefine.action) ? "/com/files/opntUpload.ajx" : formInfo.formDefine.action;
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
        } ,
        
        dynaGenCheckboxes : function(optionsInfoObj) {
            /* Developer: sh.jang */
            if (validateFns.isEmpty(optionsInfoObj.checkInfo.targetId)) return false;
        
        
            // targetId에서 모든 특수문자 및 공백을 제거하는 코드
            let regex = new RegExp('[^ㄱ-ㅎ가-힣a-zA-Z0-9]', 'g');
            const tempNm = optionsInfoObj.checkInfo.targetId.replace(regex, '');
        
            const checkProp = optionsInfoObj.checkProp;
            const checkNm = validateFns.isEmpty(checkProp.checkNm) ? tempNm : checkProp.checkNm;
            const checkId = validateFns.isEmpty(checkProp.checkId) ? tempNm : checkProp.checkId;
            const prefix = validateFns.isEmpty(checkProp.prefix) ? "" : checkProp.prefix;
            const suffix = validateFns.isEmpty(checkProp.suffix) ? "" : checkProp.suffix;
        
            let inputHtml = "";
            let inputCnt = 0;
            if (!validateFns.isEmpty(optionsInfoObj.checkDataInfo)) {
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
        
            if (validateFns.isEmpty(optionsInfoObj.comboInfo.targetId)) return false;  // options을 어디에 INPUT할지 지정안하면 return
        
            var optPosition = "", optTxt = "", optVal = "";
            if (!validateFns.isEmpty(optionsInfoObj.addOption)) {
                optPosition = stringFns.nvl(optionsInfoObj.addOption.position, "TOP");
                optTxt = stringFns.nvl(optionsInfoObj.addOption.txt, "선택");
                optVal = stringFns.nvl(optionsInfoObj.addOption.val, " ");
            }
        
            var inputOptionHtml = "";
            if (optPosition.toUpperCase() == "TOP") {
                inputOptionHtml += "<option value='" + optVal + "' >" + optTxt + "</option>";
            }
        
            var optionCnt = 0;
            if (!validateFns.isEmpty(optionsInfoObj.comboDataInfo)) {
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
            if (!validateFns.isEmpty(optionsInfoObj.optionValInfo.defaultVal)) {
                if ($(optionsInfoObj.comboInfo.targetId).length > 0) {
                    $(optionsInfoObj.comboInfo.targetId).val(optionsInfoObj.optionValInfo.defaultVal)
                }
            }
        
            // 페이지가 열릴때 기본옵션 선택 (기준 : index)
            if (!validateFns.isEmpty(optionsInfoObj.optionValInfo.defaultIndex)) {
                if ($(optionsInfoObj.comboInfo.targetId).length > 0) {
                    $(optionsInfoObj.comboInfo.targetId + " option:eq(" + optionsInfoObj.optionValInfo.defaultIndex + ")").prop("selected", true);
                }
            }
            
            // CallBack Function
            if(!validateFns.isEmpty( optionsInfoObj.callBackFn) && typeof optionsInfoObj.callBackFn === 'function'){
                optionsInfoObj.callBackFn.call(this, optionsInfoObj );    
            }
        },
        
        DynaGenRadio(radioOptionObj) {

            if (validateFns.isEmpty(radioOptionObj.radioInfo.targetId)) return false;
            if (!validateFns.isEmpty(radioOptionObj.radioInfo.classNm)) {
                $(radioOptionObj.radioInfo.targetId).addClass(radioOptionObj.radioInfo.classNm);
            }
        
            var radioId = validateFns.isEmpty(radioOptionObj.radioProp.radioId) ? "tmpRadioId" : radioOptionObj.radioProp.radioId;
            var radioNm = validateFns.isEmpty(radioOptionObj.radioProp.radioNm) ? "tmpRadioNm" : radioOptionObj.radioProp.radioNm;
            var radioClassNm = validateFns.isEmpty(radioOptionObj.radioProp.classNm) ? " " : radioOptionObj.radioProp.classNm;
            var radioStyle = validateFns.isEmpty(radioOptionObj.radioProp.style) ? " " : radioOptionObj.radioProp.style;
            var radioPrefix = validateFns.isEmpty(radioOptionObj.radioProp.prefix) ? "" : radioOptionObj.radioProp.prefix;
            var radioSuffix = validateFns.isEmpty(radioOptionObj.radioProp.suffix) ? "" : radioOptionObj.radioProp.suffix;
        
            var radioHtml = "";
            if (!validateFns.isEmpty(radioOptionObj.radioDataInfo)) {
                var optCode = validateFns.isEmpty(radioOptionObj.optionValInfo.optCode) ? "code" : radioOptionObj.optionValInfo.optCode;
                var optNm = validateFns.isEmpty(radioOptionObj.optionValInfo.optTxt) ? "text" : radioOptionObj.optionValInfo.optTxt;
                var optDefault = validateFns.isEmpty(radioOptionObj.optionValInfo.defaultVal) ? "" : radioOptionObj.optionValInfo.defaultVal;
        
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
                if (i == 1) monthOptionHtml += '<option value="' + stringFns.lPad(i, 2, "0") + '" selected="selected">' + i + '월</option>';
                else monthOptionHtml += '<option value="' + stringFns.lPad(i, 2, "0") + '">' + i + '월</option>';
            }
            return monthOptionHtml;
        },
        
        /* 24시간 ComboBox생성  */
        getHourComboOptions : function () {
            let hourOptionHtml = '';
            for (let i = 0; i <= 23; i++) {
                if (i == 0) hourOptionHtml += '<option value="' + stringFns.lPad(i, 2, "0") + '" selected="selected">' + stringFns.lPad(i, 2, "0") + '시</option>';
                else hourOptionHtml += '<option value="' + stringFns.lPad(i, 2, "0") + '">' + stringFns.lPad(i, 2, "0") + '시</option>';
            }
            return hourOptionHtml;
        },
        /* 10분단위 ComboBox생성  */
        get10minuteComboOptions() {
            let minuteOptionHtml = '';
            for (let i = 0; i <= 50;) {
                if (i == 0) minuteOptionHtml += '<option value="' + stringFns.lPad(i, 2, "0") + '" selected="selected">' + stringFns.lPad(i, 2, "0") + '분</option>';
                else minuteOptionHtml += '<option value="' + stringFns.lPad(i, 2, "0") + '">' + stringFns.lPad(i, 2, "0") + '분</option>';
                i = i + 10;
            }
            return minuteOptionHtml;
        },
        
        /*  년도 옵션 생성 */
        GetYearComboOptions(yearOptObj) { 
            if (validateFns.isEmpty(comboInfoObj.targetId)) return false;
            let beginYear = Number(validateFns.isEmpty(comboInfoObj.years.beginYear) ?  dateFns.getYear() : comboInfoObj.years.beginYear);
            let finishYear = Number(validateFns.isEmpty(comboInfoObj.years.finishYear) ? dateFns.getYear() : comboInfoObj.years.finishYear);
        
        
            var termYears = finishYear - beginYear;  // targetYear을 지정하지 않으면 기본조회기간은 현재년도 - 5년이다.
        
            var addOpPosition = "";
            var addOpTxt = "";
            var addOpVal = "";
            var addDefaultVal = "";
        
            if (!validateFns.isEmpty(comboInfoObj.addOption)) {
                addOpPosition = stringFns.nvl(comboInfoObj.addOption.position, "");
                addOpTxt = stringFns.nvl(comboInfoObj.addOption.opTxt, "선택");
                addOpVal = stringFns.nvl(comboInfoObj.addOption.opVal, " ");
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
            if (!validateFns.isEmpty(addDefaultVal)) $(comboInfoObj.targetId).val(addDefaultVal);
        },
         
        /*****  Document의 값 수집 ****/ 
        getEleVal : function(ele) {

            var eleVal;
            var eleDiv = htmlFns.getEleType($(ele));
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
                eleVal = stringFns.shaEncrypt512($(ele).val());
            }
            return eleVal;
        },
         setEleVal : function(setObj) { 
             
            if(validateFns.isEmpty(setObj.ele) ){
                console.log("Set element Id를 지정하세요.");
                return false;
            }   
            
            var eleVal = setObj.val;
            var eleDiv = htmlFns.getEleType($(setObj.ele)); 
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
            var eleType;
            if ($(ele).is("input")) {
                eleType = $(ele).attr("type");
            } else if ($(ele).is("select")) {
                eleType = "select";
            } else if ($(ele).is("checkbox")) {
                eleType = "checkbox";
            } else if ($(ele).is("textarea")) {
                eleType = "textarea";
            }
            return eleType;
        },
        /*  콤퍼넌트 DatePicker 지정  as-is : opntFncDate*/
        setDatePicker : function(dataPickersObj) {
            /* setDatePicker({ targets : ["#picker1" , "#picker2"]  // 필수입력  
                                         , dateFormat : "yy.mm.dd"  // Option (default : "yy.mm.dd" )
               });
            */ 
            if (validateFns.isEmpty(dataPickersObj.targets)) {
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
            if ( htmlFns.getEleType($(preViewObj.fileEle)) != "file") return false;
        
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
        
            if (!validateFns.isEmpty(preViewObj.filePathEle)) {
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
        
        , cleanContent : function (html, options = {}){
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
        
    }
    
    /************************************************************************************/
    /***************************            DATE FUNCTIONS            *******************/
    /************************************************************************************/
    const dateFns = {
        getDate : function(){
             var dateFormat = stringFns.nvl(dateInfoObj.dateFormat, "YYYY-MM-DD");

            var basicDate = dateInfoObj.dateObj;
            if (validateFns.isEmpty(basicDate)) basicDate = new Date();
        
            var baseYear = basicDate.getFullYear();
            var baseMonth = stringFns.lPad(basicDate.getMonth() + 1, 2, "0");
            var baseDate = stringFns.lPad(basicDate.getDate(), 2, "0");
             
            if(dateFormat == "YYYY-MM-DD HH:mm:ss"){
               return baseYear + "-" + baseMonth + "-" + baseDate + " " + basicDate.getHours() + ":" + basicDate.getMinutes() + ":" + basicDate.getSeconds()
            }else if(dateFormat == "YYYY-MM-DD HH:mm"){
               return baseYear + "-" + baseMonth + "-" + baseDate + " " + basicDate.getHours() + ":" + basicDate.getMinutes()
            }else if(dateFormat == "YYYY-MM-DD HH"){
               return baseYear + "-" + baseMonth + "-" + baseDate + " " + basicDate.getHours()
            }else if(dateFormat == "YYYY-MM-DD"){
               return baseYear + "-" + baseMonth + "-" + baseDate
            }else if(dateFormat == "YYYY-MM"){
               return baseYear + "-" + baseMonth
            }else if(dateFormat == "YYYY"){
               return baseYear
            } 
        },
        /* 올해 년도 조회 */
        getYear : function() {
            return dateFns.getDate({dateFormat : "YYYY"})
        },
        /* 현재시점 날짜 nanoTimes조회 */
        getNanoTimes : function() {
            return new Date().getTime();
        },
        
        /* 날짜 차이 계산기 */
        dateCalc : function(strBaseDate, diffDiv, DiffVal, dateFormat) {
            if (validateFns.isEmpty(strBaseDate)) return false;
            strBaseDate = stringFns.replaceAll(stringFns.replaceAll(strBaseDate, "-"), "/");
            if (strBaseDate.length != 8) return false;
        
            var baseYear = stringFns.subString(strBaseDate, 0, 4)
                , baseMonth = stringFns.subString(strBaseDate, 4, 6)
                , baseday = stringFns.subString(strBaseDate, 6, 8);
        
            var baseDateObj = new Date(baseMonth + "/" + baseday + "/" + baseYear);
            if (diffDiv.toUpperCase() == "D") { // 일자 차이
                baseDateObj.setDate(baseDateObj.getDate() + DiffVal);
            } else if (diffDiv.toUpperCase() == "W") { // 주간 차이
                baseDateObj.setDate(baseDateObj.getDate() + (DiffVal * 7));
            } else if (diffDiv.toUpperCase() == "M") { // 월 차이
                baseDateObj.setMonth(baseDateObj.getMonth() + DiffVal);
            } else if (diffDiv.toUpperCase() == "Y") { // 년도 차이
                baseDateObj.setFullYear(baseDateObj.getFullYear() + DiffVal);
            }
             
            var resultYear  = baseDateObj.getFullYear();
            var resultMonth = stringFns.lPad(baseDateObj.getMonth() + 1, 2, "0");
            var resultDate  = stringFns.lPad(baseDateObj.getDate()     , 2, "0");
        
            if ("YYYY" == dateFormat) {
                return resultYear;
            } else if ("YYYY-MM" == dateFormat) {
                return resultYear + "-" + resultMonth;
            } else if ("YYYY-MM-DD" == dateFormat) {
                return resultYear + "-" + resultMonth + "-" + resultDate;
            } else {
                return resultYear + "-" + resultMonth + "-" + resultDate;
            } 
        },  
        
        /* 조회월의 마지막날 찾기 */
        getMonthLastDay : function(strYearMon) { 
            if (validateFns.isEmpty(strYearMon)) strYearMon = stringFns.subString(stringFns.replaceAll( dateFns.getDate(),"-") , 0, 6);
            var tarYearMon =  stringFns.replaceAll(stringFns.replaceAll(strYearMon, "-"), "/");
            var nextMonFirstDay = dateFns.dateCalc(tarYearMon + "01", "M", 1, "YYYY-MM-DD");
            var thisMonLastDay = dateFns.dateCalc(nextMonFirstDay, "D", -1, "YYYY-MM-DD");
            return thisMonLastDay;
        }, 
        
        /* 날짜 차이비교 계산기 */
        dateDiff : function(strStartDay, strEndDay, diffDiv) {
        
            strStartDay = stringFns.replaceAll(stringFns.replaceAll(strStartDay, "-"), "/");
            strEndDay = stringFns.replaceAll(stringFns.replaceAll(strEndDay, "-"), "/");
        
            let baseStartYear = stringFns.subString(strStartDay, 0, 4)
                , baseStartMonth = stringFns.subString(strStartDay, 4, 6)
                , baseStartday = stringFns.subString(strStartDay, 6, 8);
        
            let baseEndYear = stringFns.subString(strEndDay, 0, 4)
                , baseEndMonth = stringFns.subString(strEndDay, 4, 6)
                , baseEndday = stringFns.subString(strEndDay, 6, 8);
        
            let strarDateObj = new Date(Number(baseStartYear), Number(baseStartMonth) - 1, Number(baseStartday));
            let endDateObj = new Date(Number(baseEndYear), Number(baseEndMonth) - 1, Number(baseEndday));
        
            diffDiv =  stringFns.nvl(diffDiv, "D");
            let diffs;
            if (diffDiv == "D") {
                diffs = Math.round((endDateObj - strarDateObj) / (1000 * 60 * 60 * 24));
            } else if (diffDiv == "M") {
                months = (endDateObj.getFullYear() - strarDateObj.getFullYear()) * 12;
                months -= strarDateObj.getMonth() - 1;
                months += endDateObj.getMonth();
        //		diffs = months <= 1 ? 0 : months-1;
                diffs = months <= 1 ? 0 : months;
            } else if (diffDiv == "Y") {
                diffs = endDateObj.getFullYear() - strarDateObj.getFullYear();
            }
            return diffs;
        }  
        
    }
    
   /************************************************************************************/
   /******************            FILES FUNCTIONS                  *******************/
   /************************************************************************************/
   const fileFns = {
         fileExecAllowed : function(fileEle, fileDiv) {
            var isFileAble = true;
            if (fileDiv.toUpperCase() == "IMAGE") {
                var ableImgMimeTypeArr = ["gif", "jpg", "jpeg", "tiff", "png"];
                var mimeType = fileFns.getFileMimeType(fileEle);
                isFileAble = $.inArray(mimeType, ableImgMimeTypeArr) == -1 ? false : true;
            }
        
            return isFileAble;
        },
        getFileMimeType : function(eleSelector) {
            var fileVal = $(eleSelector).val();
            var lastIndxDot = fileVal.lastIndexOf(".");
            return fileVal.substring(lastIndxDot + 1);
        }, 
        
        getFileInfo : function(fileSelector) { 
            var trnObj = {}
            if (htmlFns.getEleType(fileSelector) == "file") {
        
                var eleFiles = $(fileSelector).prop("files");
                if (eleFiles.length > 0) {
                    trnObj.fullFileName = eleFiles[0].name;
                    trnObj.fileName = ("" + eleFiles[0].name).substr(0, ("" + eleFiles[0].name).indexOf("."));
                    trnObj.fileExt = fileFns.getFileMimeType(fileSelector);
                    trnObj.fileType = eleFiles[0].type;
                    trnObj.fileSize = eleFiles[0].size;
                }
            }
            return trnObj;
        },
        //  파일다운로드 공통 
        commFileDownLoad : function(fileInfoObj) { 
            if (validateFns.isEmpty(fileInfoObj.conditions)) return false;
            fileInfoObj.url = validateFns.isEmpty(fileInfoObj.url) ? '/com/files/opntDownload.ajx' : fileInfoObj.url;
            var excelCondition = {
                httpMethod: "post"
                , data: fileInfoObj.conditions
                , prepareCallback: function (url) {
                    console.log(JSON.stringify(fileInfoObj.conditions) + " 다운로드 시작");
                }
            };
        
            $.fileDownload(fileInfoObj.url, excelCondition);
        }, 
        //  파일삭제 공통
        commFileDelete : function(pFileGrpSeq, pFileSeq) {
            xhrFns.ajax({
                sid: "deletComFile",
                cmd: "update",
                sql: "common.opnt.file.delCommonFile",
                fileGrpSeq: pFileGrpSeq,
                fileSeq: pFileSeq , 
                successFn: function (sid, rs) {
                    messageFns.showMsg("삭제 했습니다. ");
                }
            });
        },
        formatBytes : function(bytes, decimals = 2) {
            if (bytes === 0) return '0 Bytes'; 
            const k = 1024;
            const dm = decimals < 0 ? 0 : decimals;
            const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']; 
            const i = Math.floor(Math.log(bytes) / Math.log(k)); 
            return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
        }
        
   }
    
    
  // DOM 준비되면 $.opnt 정의
  $(function() {
		$.opnt = {
			   xhr : xhrFns 
			 , str : stringFns
			 , valid : validateFns
			 , host : hostFns
			 , msg : messageFns
			 , html : htmlFns
			 , date : dateFns
			 , file : fileFns 
		};
  });

})(jQuery);
	 