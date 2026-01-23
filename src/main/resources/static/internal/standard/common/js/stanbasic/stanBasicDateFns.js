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
            let months = (endDateObj.getFullYear() - strarDateObj.getFullYear()) * 12;
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

export default dateFns;