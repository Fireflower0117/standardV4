const stringFns = {
    nvl  : function (chkObj, repStr) {
        repStr = opnt.valid.isEmpty(repStr) ? "" : repStr;
        if (opnt.valid.isEmpty(chkObj)) return repStr;
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
        return JSON.parse(opnt.str.replaceAll(JsonSearchCondi, "&#034;", '"'));
    },
    replaceAll : function(tarStr, tarSplitStr, tarRepStr = "") {
        var trimSplitArr = tarStr.split(tarSplitStr);
        return trimSplitArr.join(tarRepStr);
    },
    lPad : function (tarStr, paddLen, paddStr) {
        tarStr = tarStr.toString();
        return tarStr.length < paddLen ? opnt.str.lPad(paddStr + tarStr, paddLen, paddStr) : tarStr;
    },
    rPad : function(tarStr, paddLen, paddStr) {
        tarStr = tarStr.toString();
        return tarStr.length < paddLen ? opnt.str.rPad(tarStr + paddStr, paddLen, paddStr) : tarStr;
    },
    subString : function (orgStr, beginIndx, endIndx) {
        return orgStr.substring(beginIndx, endIndx);
    }
}

export default stringFns;