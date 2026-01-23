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
  // 지정항목 유효성 체크  
  , cmValidationCheck : function(validateObj){

        if( opnt.valid.isEmpty(validateObj?.validateList)  ){
            opnt.messageFns.consoleLog('유효성 검증할 목록이 없습니다.');
            return false;
        }

        let validateWrapNm = validateObj?.formWrapperEle;
        if( opnt.valid.isEmpty(validateWrapNm) ){
            console.log('cmValidationCheck를 하려면 formWrapperEle 속성은 필수값입니다. (form Element or Wrapper Element)\n' 
                       +'자세한 내용은 개발가이드 Validation을 참고하세요 ');
            return false;
        }

        // messageOption : "feedbackType"

        let findEleType = opnt.html.getEleType(validateWrapNm);  // Wrapper 대상 Element Type조회
        let $formEle = null; // Wrapper 대상 Element
        let isFnGenForm;  // form 동적 생성여부
        if(findEleType === "form") {
            $formEle = $(validateWrapNm) ;
            isFnGenForm = false;
        }
        else {
            $(validateWrapNm).wrap("<form id='validateForm' name='validateForm'></form>"); // 선택한 Element Form으로 덮어 씌운다.
            $formEle = $("#validateForm");
            isFnGenForm = true;
        }

        // default Validate Message Option
            let validateOptions;

            // 필요에따라 cmValidationCheck함수 호출시 validateOption속성을 추가 해서 messageOption을 변경할수있다.
            let selMessageOption = opnt.valid.isEmpty(validateObj?.messageOption) ? 'feedbackType' : validateObj.messageOption;
            if(selMessageOption === 'feedbackType'){
                validateOptions = {
                    errorElement: "em"
                    , errorPlacement: function ( error, element ) {
                        // Add the `help-block` class to the error element
                        error.addClass( "invalid-feedback" );

                        if ( element.prop( "type" ) === "checkbox" ) {
                            error.insertAfter( element.parent( "label" ) );
                        } else {
                            error.insertAfter( element );
                        }
                    }
                    , highlight: function ( element, errorClass, validClass ) {
                        $( element ).parents( ".col-sm-5" ).addClass( "has-error" ).removeClass( "has-success" );
                    }
                    , unhighlight: function (element, errorClass, validClass) {
                        $( element ).parents( ".col-sm-5" ).addClass( "has-success" ).removeClass( "has-error" );
                    }
                };
            }
            //  else if 로 selMessageOption 추가 가능....


           validateOptions.rules = {};
           validateOptions.messages = {};

        let validateStatus = 'success';
        for(let validAttr of validateObj.validateList ){
            let attrName =  validAttr?.name;
            let attrLabel =  validAttr?.label;
            let attrRule =  validAttr?.rule;

            if(opnt.valid.isEmpty(attrName) || opnt.valid.isEmpty(attrLabel)  || opnt.valid.isEmpty(attrRule) ){
                opnt.msg.consoleLog("name : "+attrName+", attrLabel : "+attrLabel+" , attrRule : "+attrRule);
                opnt.msg.consoleLog('validateList 내부에 name, label, rule 속성을 입력하지 않는 Object가 있습니다.');
                validateStatus = 'fail';
            }

            validateOptions.rules[attrName] = attrRule ;
            if(typeof attrRule === "object"){
                  validateOptions.messages[attrName]  = {};
                  for(let ruleKey of Object.keys(attrRule)){
                      let keyVal = attrRule[ruleKey];
                      if(ruleKey === "required")  validateOptions.messages[attrName][ruleKey] = attrLabel +"은(는) 필수입력 항목입니다.";
                      if(ruleKey === "maxlength")  validateOptions.messages[attrName][ruleKey] = attrLabel +"은(는) 최대 "+keyVal+" 자리 입니다.";
                      if(ruleKey === "minlength")  validateOptions.messages[attrName][ruleKey] = attrLabel +"은(는) 최소 "+keyVal+" 자리 입니다.";
                      if(ruleKey === "equalTo")  validateOptions.messages[attrName][ruleKey] = attrLabel +"은(는)  "+keyVal+"와 같아야 합니다.";
                      if(ruleKey === "email")  validateOptions.messages[attrName][ruleKey] = attrLabel +"은(는) 이메일 형식이어야 합니다.";
                  }
            }
            else {
                validateStatus = 'fail';
                opnt.msg.consoleLog('유효성 검증 rule 은 반드시 Object형태로 입력하세요.');
            }
        }

        if(validateStatus === 'fail'){
            return false;
        }

        $formEle.validate(validateOptions); // 유효성검증 실행

        let validateRslt = $formEle.valid(); // 유효성 검증 결과 조회
        if(isFnGenForm){ $formEle.unwrap(); } // 동적생성For 이면 기존상태대로 복구
        return validateRslt;  // 유효성 검증결과 반환(return)

   }

}

export default validateFns;