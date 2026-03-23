(function(window) {

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
                                              , cmd       : "selectPageList" , sql       : "on.common.sql_test"
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



            let isReturn = true;
            let ajaxPostOptions = {data: {}};
            /* Custom Success Function Init */

            if (!on.valid.isEmpty(callAjaxObj.successFn) && typeof callAjaxObj.successFn === 'function') {
                ajaxPostOptions.success = function (rs, status, xhr) {

                    // [NEW] 서버가 헤더로 내려준 '새로운 OTP 토큰'이 있다면 meta 태그 갱신
                    let newOtpToken = xhr.getResponseHeader("X-ON-OTP-NEW-TOKEN");
                    if(newOtpToken) {
                        $("meta[name='x-on-otp-token']").attr("content", newOtpToken);
                    }

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
            if (!on.valid.isEmpty(callAjaxObj.failFn) && typeof callAjaxObj.failFn === 'function') {
                ajaxPostOptions.error = function (errObj, errMsg, errCause) {

                    isReturn = false;
                    callAjaxObj.failFn(errObj, errMsg, errCause);
                }
            }

            // form 데이터 유효성 검증
            if(!on.valid.isEmpty(callAjaxObj.validation)){

                if(on.valid.isEmpty(callAjaxObj.validation.formId)){
                    on.msg.consoleLog( "유효성 검증은 formId입력이 필수입니다.")
                    return false;
                }

                if(on.valid.isEmpty(callAjaxObj.validation.validationList)){
                    on.msg.consoleLog( "유효성 검증은 검증대상 입력이 필수입니다.")
                    return false;
                }

                const isValid = on.valid.formValidationCheck({ formId       : callAjaxObj.validation.formId
                                                                       , validateList : callAjaxObj.validation.validationList
                                                                         });

                if (!isValid) {
                    return false;
                }

            }

            /* callAjaxObj.url */
            if(!on.valid.isEmpty(callAjaxObj.url)){
                if(!on.valid.isEmpty(callAjaxObj.data)){  // form.serialize때 사용
                    if (Array.isArray(callAjaxObj.data)) {
                        for(let dataAttr of callAjaxObj.data){
                            ajaxPostOptions.data[dataAttr.name] = dataAttr.value;
                        }
                    } else if (typeof callAjaxObj.data === "object") {
                        $.extend(true, ajaxPostOptions.data, callAjaxObj.data);
                    }
                }
                for (const [key, value] of Object.entries(callAjaxObj)) { // form Attr외  외부속성 추가
                    if (key !== "successFn" && key !== "failFn" && key !== "data" && key !== "url" && key !== "validation" && key !== "contentType") {
                        ajaxPostOptions.data[key] = value;
                    }
                }
                ajaxPostOptions.url = callAjaxObj.url; // Request Mapping URL
                // 외부 파라미터로 받은 contentType을 우선 적용
                ajaxPostOptions.contentType = on.str.nvl( callAjaxObj.contentType, "application/x-www-form-urlencoded;charset=UTF-8");

                // application/json일 경우 반드시 JSON 문자열로 변환해야 Illegal invocation 에러가 발생하지 않음!
                if (ajaxPostOptions.contentType.indexOf("application/json") !== -1) {
                    ajaxPostOptions.data = JSON.stringify(ajaxPostOptions.data);
                }
            }
            else {
                // 입력 ajax Data 정리
                if (!on.valid.isEmpty(callAjaxObj.data)) {
                    if (Array.isArray(callAjaxObj.data)) {
                        // serializeArray() 형태 [{name: "A", value: "1"}] 처리
                        for (let dataObj of callAjaxObj.data) {
                            ajaxPostOptions.data[dataObj.name] = dataObj.value;
                        }
                    } else {
                        // 일반 Object 형태 { boardDivCd: "QnA" } 처리
                        $.extend(ajaxPostOptions.data, callAjaxObj.data);
                    }
                }

                const ignoreKeys = ["successFn", "failFn", "sql", "validation", "data", "url"];
                for (const [key, value] of Object.entries(callAjaxObj)) {
                    if (ignoreKeys.indexOf(key) === -1) {
                        ajaxPostOptions.data[key] = value;
                    }
                }

                /* Ajax 호출 기본값 SelectList */
                let sqlCmd = on.str.nvl(callAjaxObj.cmd, "selectList");
                if (sqlCmd === "selectPage") {

                    // sql Attribute 없으면 return
                    if (on.valid.isEmpty(callAjaxObj.sql)) return {};

                    //ajaxPostOptions.url = getContextPath() +'/query/json?qid='+ callAjaxObj.sql+'_page';
                    ajaxPostOptions.url = '/com/query/selectList.ajx?qid=' + callAjaxObj.sql;
                    let pageNo = Number(on.str.nvl(callAjaxObj.pageNo, 1));
                    let pageSize = Number(on.str.nvl(callAjaxObj.pageSize, 10));
                    ajaxPostOptions.data.rn_bottom = (pageNo * pageSize) - pageSize;
                    ajaxPostOptions.data.rn_top = (pageNo * pageSize);
                    ajaxPostOptions.data.rn_deorder = ajaxPostOptions.data.rn_bottom + ajaxPostOptions.data.rn_top;



                } else if (sqlCmd === "selectList") {
                    // sql Attribute 없으면 return
                    if (on.valid.isEmpty(callAjaxObj.sql)) return {};
                    ajaxPostOptions.url = '/com/query/selectList.ajx?qid=' + callAjaxObj.sql;
                } else if (sqlCmd === "selectOne") {

                    // sql Attribute 없으면 return
                    if (on.valid.isEmpty(callAjaxObj.sql)) return {};
                    ajaxPostOptions.url = '/com/query/selectOne.ajx?qid=' + callAjaxObj.sql;

                } else if (sqlCmd === "multiSelect") {
                    ajaxPostOptions.url = '/com/query/multiSelect.ajx';

                } else if (sqlCmd === "insert") {

                    // sql Attribute 없으면 return
                    if (on.valid.isEmpty(callAjaxObj.sql)){
                        on.msg.consoleLog("cmd(insert)를 입력하면 sql은 필수입력입니다.", )
                        return {};
                    }
                    ajaxPostOptions.url = '/com/query/insert.ajx?qid=' + callAjaxObj.sql;

                } else if (sqlCmd === "update") {

                    // sql Attribute 없으면 return
                    if (on.valid.isEmpty(callAjaxObj.sql)){
                        on.msg.consoleLog("cmd(update)를 입력하면 sql은 필수입력입니다.", )
                        return {};
                    }
                    ajaxPostOptions.url = '/com/query/update.ajx?qid=' + callAjaxObj.sql;
                }
                else if (sqlCmd === "delete") {

                    // sql Attribute 없으면 return
                    if (on.valid.isEmpty(callAjaxObj.sql)){
                        on.msg.consoleLog("cmd(delete)를 입력하면 sql은 필수입력입니다.", )
                        return {};
                    }
                    ajaxPostOptions.url = '/com/query/delete.ajx?qid=' + callAjaxObj.sql;

                }
                else if(sqlCmd === "multiAction"){
                    ajaxPostOptions.url = '/com/query/multiAction.ajx';
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
            ajaxPostOptions.async = on.str.nvl(callAjaxObj.async, ajaxPostOptions.success ? true : false);

            // How to dynamic make[{},{},{}]
            ajaxPostOptions.type = on.str.nvl(ajaxPostOptions.methodType , "post");



            let resultData = {};
            let baseAjaxObj = {
                  type: "post"
                , async: false
                , dataType: "json"
                //, contentType : 'application/json;charset=UTF-8'
                , beforeSend: function (xhr, settings) {

                    // JSP 화면 head에 세팅된 CSRF meta 토큰 읽어오기
                    let csrfToken = $("meta[name='_csrf']").attr("content");
                    let csrfHeader = $("meta[name='_csrf_header']").attr("content") || "X-CSRF-TOKEN";
                    let onOtpToken = $("meta[name='x-on-otp-token']").attr("content");
                    // 헤더에 토큰 세팅 (CSRF 방어)
                    if (csrfToken && csrfHeader) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    }

                    // 비동기 통신 명시 (기본적인 툴 접근 방어)
                    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

                    // F/W 전용 커스텀 헤더 추가 (콘솔 수동 입력 방어용 암호)
                    xhr.setRequestHeader("X-ON-FRAMEWORK", "REQ_VALID");

                    // F/W 전용 재입력 방지용 OneTimePassword Token
                    xhr.setRequestHeader("X-ON-OTP-TOKEN", onOtpToken);

                    on.msg.showProgressBar();
                }
                , complete: function (xhr, sts) {
                    on.msg.hideProgressBar();
                }
                , success: function (rs, status, xhr) {
                    isReturn = true;
                    resultData = rs;

                    let newOtpToken = xhr.getResponseHeader("X-ON-OTP-NEW-TOKEN");
                    if (newOtpToken) {
                        $("meta[name='x-on-otp-token']").attr("content", newOtpToken);
                    }
                }
                , error: function (err) {
                    on.msg.showMsg({message : "장애가 발생했습니다."});
                    //on.msg.showMsg({message : "장애발생 사유 : "+ err.responseJSON.message});
                }
            }

            let targetObj = $.extend(true, baseAjaxObj, ajaxPostOptions);
            $.ajax(targetObj);
            if (isReturn) return resultData;
        }
        /*  공통코드 조회 */
      ,   ajaxComCd (conditions){
             if( on.valid.isEmpty(conditions.sqlCondi)  ){
                    on.msg.consoleLog("sqlCondi는 필수입력값입니다.");
                    return {}
             }

             // SQL기본 공통코드 조회
             conditions.sql = on.valid.isEmpty(conditions.sql) ? "on.standard.system.comcode.selectComCode" : conditions.sql;

             // 공통코드조회 ( 그외 다른 데이터 조회시 sql 변경 필요)
             let rtnComCdObj = on.xhr.ajax({cmd : "selectList", sql : conditions.sql , data : conditions.sqlCondi });
             return rtnComCdObj;
         }
         /*   공통코드 일괄조회 */
      ,  ajaxComCdList (conditions){


               // 필수입력값 검증
               if( on.valid.isEmpty(conditions?.condiList) ) return null;

               // 유효성 검증
               let isValidation = true;
               for(let condiObj of conditions.condiList){
                   if( on.valid.isEmpty(condiObj.rsId)  ){
                       on.msg.consoleLog("rsId, sqlCondi는 필수입력값입니다.");
                       isValidation = false;
                       break;
                   }
                   // SQL기본 공통코드 조회
                   condiObj.sql = on.valid.isEmpty(condiObj.sql) ? "on.standard.system.comcode.selectComCode" : condiObj.sql;

                   // sid 설정안하면 rslt가 sid가됨
                   condiObj.sid = on.valid.isEmpty(condiObj.sid) ? condiObj.rsId : condiObj.sid;

                   // cmd 입력안하면 기본적으로 selectList
                   condiObj.cmd = on.valid.isEmpty(condiObj.cmd) ? "selectList" : condiObj.cmd;

                   // sqlCondi 입력안하면 기본적으로 Object
                   condiObj.sqlCondi = on.valid.isEmpty(condiObj.sqlCondi) ? {} : condiObj.sqlCondi;


               }
               if(isValidation === false) return null;

               // 공통코드 Data호출
               let rsltObj = new Object();
               on.xhr.ajax({sid : "comCdList" , async : false ,  cmd : "multiSelect", selectTargets : conditions.condiList
                        , successFn : function(sid , rs){
                                       for(let sqlRslt of rs) {
                                           rsltObj[sqlRslt.rsId] = sqlRslt[sqlRslt.rsId];
                                       }
                        }
               });
               return rsltObj
      }
}
    window.xhrFns = xhrFns;

})(window);
