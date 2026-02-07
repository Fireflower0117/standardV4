    (function(window) {
    /************************************************************************************
    ****************           Custom Validation 옵션 추가           **********************
     ***********************************************************************************/

    $.validator.addMethod("numberOnly", function (value, element) {
        return this.optional(element) || /^[0-9]+$/.test(value);
    }, "숫자만 입력 가능합니다.");

    $.validator.addMethod("floatOnly", function(value, element) {
        return this.optional(element) || /^-?\d+(\.\d+)?$/.test(value);
    }, "숫자((정수/소수)만 입력 가능합니다.");

    $.validator.addMethod("engOnly", function(value, element) {
        return this.optional(element) || /^[a-zA-Z]+$/.test(value);
    }, "영문만 입력 가능합니다.");

    $.validator.addMethod("engNumOnly", function(value, element) {
        return this.optional(element) || /^[a-zA-Z\d]+$/.test(value);
    }, "영문과 숫자만 입력 가능합니다.");

    $.validator.addMethod("korMobile", function(value, element) {
        return this.optional(element) || /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/.test(value);
    }, "영문과 숫자만 입력 가능합니다.");


    const validateFns = {
        isEmpty: function (chkObj) {
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
        // 지정항목 유효성 체크
        , formValidationCheck: function (validateObj) {

            if (on.valid.isEmpty(validateObj?.validateList)) {
                on.msg.consoleLog('유효성 검증할 목록이 없습니다.');
                return false;
            }

            if (on.valid.isEmpty(validateObj?.callbackFn) || typeof validateObj.callbackFn !== 'function') {
                on.msg.consoleLog('callBack Function을 입력하세요.');
                return false;
            }

            let eleForm = validateObj?.formId;
            if (on.valid.isEmpty(eleForm)) {
                on.msg.consoleLog('formValidationCheck 하려면 formId 속성은 필수값입니다.');
                return false;
            }

            let validateOptions = {
                rules: {}
                , messages: {}
                , submitHandler: validateObj.callbackFn
            };

            // 필요에따라 formValidationCheck 호출시 validateOption속성을 추가 해서 messageOption을 변경할수있다.
            let selMessageOption = validateObj?.messageOption;

            if (selMessageOption === 'normal') {
                let addValidateOptions = {
                    errorPlacement: function (error, element) {
                        error.addClass("ui red pointing label transition");
                        error.insertAfter(element.parent());
                    }
                    , highlight: function (element, errorClass, validClass) {
                        $(element).parents(".row").addClass(errorClass);
                    }
                    , unhighlight: function (element, errorClass, validClass) {
                        $(element).parents(".row").removeClass(errorClass);
                    }
                };
                validateOptions = $.extend(true, validateOptions, addValidateOptions);
            } else if (selMessageOption === 'div') {
                let addValidateOptions = {
                    errorElement: "div", // label 대신 div 사용 (줄바꿈 제어 용이)
                    errorPlacement: function (error, element) {
                        error.addClass("ui red pointing label transition");
                        // element.parent() 대신 element 자체의 뒤에 삽입 (td 내부 유지)
                        error.insertAfter(element);
                    },
                    highlight: function (element, errorClass, validClass) {
                        $(element).closest(".row").addClass("error"); // Semantic UI 스타일
                    },
                    unhighlight: function (element, errorClass, validClass) {
                        $(element).closest(".row").removeClass("error");
                    }
                };
                validateOptions = $.extend(true, validateOptions, addValidateOptions);
            }


            let validateStatus = 'success';
            for (let validAttr of validateObj.validateList) {
                let attrName = validAttr?.name;
                let attrLabel = validAttr?.label;
                let attrRule = validAttr?.rule;

                if (on.valid.isEmpty(attrName) || on.valid.isEmpty(attrLabel) || on.valid.isEmpty(attrRule)) {
                    on.msg.consoleLog("name : " + attrName + ", attrLabel : " + attrLabel + " , attrRule : " + attrRule);
                    on.msg.consoleLog('validateList 내부에 name, label, rule 속성을 입력하지 않는 Object가 있습니다.');
                    validateStatus = 'fail';
                }

                validateOptions.rules[attrName] = attrRule;
                if (typeof attrRule === "object") {
                    validateOptions.messages[attrName] = {};
                    for (let ruleKey of Object.keys(attrRule)) {
                        let keyVal = attrRule[ruleKey];
                        if (ruleKey === "required") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 필수입력 항목입니다.";
                        if (ruleKey === "maxlength") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 최대 " + keyVal + " 자리 입니다.";
                        if (ruleKey === "minlength") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 최소 " + keyVal + " 자리 입니다.";
                        if (ruleKey === "equalTo") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는)  " + keyVal + "와 같아야 합니다.";
                        if (ruleKey === "email") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 이메일 형식이어야 합니다.";
                        if (ruleKey === "engNumOnly") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 영문 또는 숫자만 입력 가능합니다.";
                        if (ruleKey === "numberOnly") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 숫자만 입력 가능합니다.";
                        if (ruleKey === "floatOnly") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 숫자 또는 소수점만 입력 가능합니다.";
                        if (ruleKey === "email") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) E-Mail 형식이 아닙니다.";
                        if (ruleKey === "korMobile") validateOptions.messages[attrName][ruleKey] = attrLabel + "은(는) 휴대폰번호 형식이 아닙니다.";


                    }
                } else {
                    validateStatus = 'fail';
                    on.msg.consoleLog('유효성 검증 rule 은 반드시 Object형태로 입력하세요.');
                }
            }

            if (validateStatus === 'fail') {
                return false;
            }

            $(eleForm).validate(validateOptions);
            return $(eleForm).valid();

        }
    }
    window.validateFns = validateFns;

})(window);