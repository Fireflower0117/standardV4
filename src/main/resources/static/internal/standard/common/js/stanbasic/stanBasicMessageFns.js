const messageFns = {
    // 공통 Alert 메세지 (시스템 메세지 팝업으로 일괄변경 대비)
    alertMsg (msgObj) {
        alert(msgObj.message);
    }
    // 공통 Confirm 메세지 (시스템 메세지 팝업으로 일괄변경 대비)
    , confirm (msgObj) {
        return confirm(msgObj.message);
    }
    // Progress Bar 띄우기
    ,showProgressBar() {
        opnt.msg.consoleLog('opntShowProgressBar');
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
    }
    // Progress Bar 닫기
    , hideProgressBar() {
        opnt.msg.consoleLog('opntHideProgress');
        //if (typeof $.unblockUI != "undefined") {
        //    $.unblockUI();
        //}
    }
    // Progress Circle 띄우기
    , showProgressCircle() {
        opnt.msg.consoleLog('showProgressCircle');
    }
    // Progress Circle 닫기
    , hideProgressCircle() {
        opnt.msg.consoleLog('hideProgressCircle');
    }
    // 웹브라우저 console.log (기록남기기)
    , consoleLog (message){
        console.log(message);
    }


}

export default messageFns;