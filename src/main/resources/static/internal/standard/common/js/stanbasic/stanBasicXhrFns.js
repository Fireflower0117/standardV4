
const xhrFns = {

        ajax: function(callAjaxObj) {
            /*  함수 사용예시 )
                     1) 별도의 Request URL호출 (RequestMapping)
                        var  callAjaxObj =   { sid       : "callAjax_Uniq_Id"
                                              , url      : "login/loginproc.do"
                                              , data      : [{},{}, .....]
                                              , attchFileId : "1234"
                                              , ..........
                                              , successFn : function (rs){ }
                                              , failFn    : function (err){ }
                                              }

                     2)  단순 Data 입력 , 출력, 갱신 , 삭제
                        var  callAjaxObj =   { sid       : "callAjax_Uniq_Id"
                                              , cmd       : "selectPageList" , sql       : "opnt.common.sql_test"
                                              , data      : [{},{}, .....]
                                              , attchFileId : "1234"
                                              , ..........
                                              , successFn : function (rs){ }
                                              , failFn    : function (err){ }
                                              }
                        **  cmd 속성이 있으면 sql속성은 필수값이다.
                        **  sql이 있는데 cmd가 없으면 기본값은 selectList이다.



             *  @descriptions
             *    callAjaxObj.sid       = Ajax 실행고유 ID , callbackFunction.successFn함수 sid로 전달됨 (비동기 통신시 callback 동시성 방지용)
             *    callAjaxObj.successFn = Ajax 호출후 결과가 성공일때 호출되는 Function , 만약 callAjaxObj.sid가 있다면 사용자 정의 success Function의 첫 인자값으로 sid가 넘어간다.
             *    callAjaxObj.failFn    = Ajax 호출후 결과가 실패일때 호출되는 Function
             *    callAjaxObj.data      = Ajax 호출시 Server에 전달할 속성 (주로 form.serializeArray() 로 사용함, 수기추가도 가능 )

             *    callAjaxObj.cmd = selectPage, selectList, selectOne , multiSelect , insert , update , delete
             *                      ex) cmd = selectPageList :
             *                                pageNo , pageSize는 필수값.  pageNo : 사용자가 선택한 페이지번호 ,  pageSize 한화면에 보여질 dataRowCount
             *                                사용자 미입력시 기본값 ( pageNo = 1 ,  pageSize = 10 )
             *                          cmd = selectList : return List<map>
             *                          cmd = selectOne : return map
             *                          cmd = multiSelect : return {List<map> , List<map> , List<map>}
             *                          cmd = insert 단건 입력 , insertlist 다건일괄 입력
             *                          cmd = update 단건 수정 , updatelist 다건일괄 수정
             *                          cmd = delete 단건 삭제 , deletelist 다건일괄 삭제


             *  ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
             *   ====>>>> callAjaxObj의 successFn , failFn 을 제외한 나머지 속성은 전부 ajax.data안에 입력된다.  <<=====
             *  ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
             */

            var isReturn = true;

            var ajaxPostOptions = {data: {}};
            /* Custom Success Function Init */

            if (!opnt.valid.isEmpty(callAjaxObj.successFn) && typeof callAjaxObj.successFn === 'function') {
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
            if (!opnt.valid.isEmpty(callAjaxObj.failFn) && typeof callAjaxObj.failFn === 'function') {
                ajaxPostOptions.error = function (errObj, errMsg, errCause) {
                    isReturn = false;
                    callAjaxObj.failFn(errObj, errMsg, errCause);
                }
            }

            /* callAjaxObj.url */
            if(!opnt.valid.isEmpty(callAjaxObj.url)){
                if(!opnt.valid.isEmpty(callAjaxObj.data)){  // form.serialize때 사용
                    for(let dataAttr of callAjaxObj.data){
                        ajaxPostOptions.data[dataAttr.name] = dataAttr.val;
                    }
                }
                for (const [key, value] of Object.entries(callAjaxObj)) { // form Attr외  외부속성 추가
                    if (key !== "successFn" && key !== "failFn" && key !== "data" && key !== "url") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
                ajaxPostOptions.url = callAjaxObj.url; // Request Mapping URL
                ajaxPostOptions.contentType = opnt.str.nvl( callAjaxObj.contentType  , "application/x-www-form-urlencoded;charset=UTF-8");
            }
            else {
                /* Ajax 호출 기본값 SelectList */
                var sqlCmd = opnt.str.nvl(callAjaxObj.cmd, "selectList");
                if (sqlCmd == "selectPage") {

                    // sql Attribute 없으면 return
                    if (opnt.valid.isEmpty(callAjaxObj.sql)) return {};

                    //ajaxPostOptions.url = getContextPath() +'/query/json?qid='+ callAjaxObj.sql+'_page';
                    ajaxPostOptions.url = '/com/query/selectList.ajx?qid=' + callAjaxObj.sql;
                    var pageNo = Number(opnt.str.nvl(callAjaxObj.pageNo, 1));
                    var pageSize = Number(opnt.str.nvl(callAjaxObj.pageSize, 10));
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
                    if (opnt.valid.isEmpty(callAjaxObj.sql)) return {};

                    ajaxPostOptions.url = '/com/query/selectList.ajx?qid=' + callAjaxObj.sql;
                    for (const [key, value] of Object.entries(callAjaxObj)) {
                        if (key != "successFn" && key != "failFn") {
                            ajaxPostOptions.data[key] = value;
                        }
                    }
                } else if (sqlCmd == "selectOne") {

                    // sql Attribute 없으면 return
                    if (opnt.valid.isEmpty(callAjaxObj.sql)) return {};

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
                    if (opnt.valid.isEmpty(callAjaxObj.sql)) return {};

                    ajaxPostOptions.url = '/com/query/insert.ajx?qid=' + callAjaxObj.sql;
                    for (const [key, value] of Object.entries(callAjaxObj)) {
                        if (key != "successFn" && key != "failFn") {
                            ajaxPostOptions.data[key] = value;
                        }
                    }
                } else if (sqlCmd == "update") {

                    // sql Attribute 없으면 return
                    if (opnt.valid.isEmpty(callAjaxObj.sql)) return {};

                    ajaxPostOptions.url = '/com/query/update.ajx?qid=' + callAjaxObj.sql;
                    for (const [key, value] of Object.entries(callAjaxObj)) {
                        if (key != "successFn" && key != "failFn") {
                            ajaxPostOptions.data[key] = value;
                        }
                    }
                }
                else if (sqlCmd == "delete") {

                    // sql Attribute 없으면 return
                    if (opnt.valid.isEmpty(callAjaxObj.sql)) return {};

                    ajaxPostOptions.url = '/com/query/delete.ajx?qid=' + callAjaxObj.sql;
                    for (const [key, value] of Object.entries(callAjaxObj)) {
                        if (key != "successFn" && key != "failFn") {
                            ajaxPostOptions.data[key] = value;
                        }
                    }
                }

                // 비동기 CRUD는 무조건 JSON으로 넘긴다.
                if (ajaxPostOptions.data && !(ajaxPostOptions.data instanceof Array)){
                    ajaxPostOptions.data = [ajaxPostOptions.data];
                }
                if (ajaxPostOptions.data){
                    ajaxPostOptions.data = JSON.stringify(ajaxPostOptions.data);
                }
                ajaxPostOptions.contentType = "application/json;charset=UTF-8";
            }

            /* 동기 호출 여부 세팅 */
            ajaxPostOptions.async = opnt.str.nvl(callAjaxObj.async, ajaxPostOptions.success ? true : false);

            // How to dynamic make[{},{},{}]
            ajaxPostOptions.type = opnt.str.nvl(ajaxPostOptions.methodType , "post");



            var resultData = {};
            var baseAjaxObj = {
                 type: "post"
                , async: false
                , dataType: "json"
                //, contentType : 'application/json;charset=UTF-8'
                , beforeSend: function (xhr, settings) {
                    opnt.msg.showProgressBar();
                }
                , complete: function (xhr, sts) {
                    opnt.msg.hideProgressBar();
                }
                , success: function (rs) {
                    isReturn = true;
                    resultData = rs;
                }
                , error: function (err) {
                    opnt.msg.alertMsg("처리중 에러발생.");
                }
            }

            var targetObj = $.extend(true, baseAjaxObj, ajaxPostOptions);
            $.ajax(targetObj);
            if (isReturn) return resultData;
        }

      /* 검색조건 다시 세팅 */
      , setSearchConditions : function(searchCondiObj) {
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

export default xhrFns;