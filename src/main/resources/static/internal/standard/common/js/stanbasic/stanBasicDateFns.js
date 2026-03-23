(function(window) {

const dateFns = {
    getDate : function({ dateObj, dateFormat = "YYYY.MM.DD" } = {}){
        // 기준 날짜 설정 (값이 없으면 현재 시간)
        const basicDate = dateObj || new Date();

        // 날짜 및 시간 요소 추출 (문자열 변환 및 두 자리 수 패딩)
        const year  = String(basicDate.getFullYear());
        const month = String(basicDate.getMonth() + 1).padStart(2, "0");
        const date  = String(basicDate.getDate()).padStart(2, "0");

        // 시간, 분, 초도 두 자리로 깔끔하게 맞춤
        const hours = String(basicDate.getHours()).padStart(2, "0");
        const mins  = String(basicDate.getMinutes()).padStart(2, "0");
        const secs  = String(basicDate.getSeconds()).padStart(2, "0");

        // 지정된 포맷으로 동적 치환하여 반환
        return dateFormat
            .replace(/YYYY/g, year)
            .replace(/MM/g, month)
            .replace(/DD/g, date)
            .replace(/HH/g, hours)
            .replace(/mm/g, mins)
            .replace(/ss/g, secs);
    },
    /* 올해 년도 조회 */
    getYear : function() {
        return on.date.getDate({dateFormat : "YYYY"})
    }
    /* 이번달 조회 */
    , getMonth : function(){
         return  on.date.getDate({dateFormat : "MM"})
    }

    /* 현재시점 날짜 nanoTimes조회 */
    , getNanoTimes : function() {
        return new Date().getTime();
    },


    /* 날짜 차이 계산기 */
    dateCalc : function(dateObj) {
        // 객체가 없거나 필수값인 strBaseDate가 없으면 false 반환
        if (!dateObj || !dateObj.strBaseDate) return false;

        // Body 영역에서 안전하게 기본값 할당 (ES5 방식)
        var strBaseDate = dateObj.strBaseDate;
        var diffDiv     = on.str.nvl(dateObj.diffDiv , "D" );
        // DiffVal은 0이 들어올 수 있으므로 undefined 체크 필수
        var DiffVal     = dateObj.DiffVal !== undefined ? dateObj.DiffVal : 0;
        var dateFormat  = dateObj.dateFormat ? dateObj.dateFormat : "YYYY.MM.DD";

        // 숫자만 추출
        var parsedDate = String(strBaseDate).replace(/[^0-9]/g, "");

        // 자릿수에 맞춰 월/일 자동 보정
        if (parsedDate.length === 4) {
            parsedDate += "0101";
        } else if (parsedDate.length === 6) {
            parsedDate += "01";
        } else if (parsedDate.length !== 8) {
            return false;
        }

        //  년/월/일 분리
        var baseYear  = on.str.subString(parsedDate, 0, 4); // 년
        var baseMonth = on.str.subString(parsedDate, 4, 6); // 월
        var baseday   = on.str.subString(parsedDate, 6, 8); // 일

        // Date 객체 생성 (안전한 생성 방식 적용: Month는 0부터 시작하므로 -1)
        var baseDateObj = new Date(Number(baseYear), Number(baseMonth) - 1, Number(baseday));

        // 날짜 계산
        var upperDiffDiv = String(diffDiv).toUpperCase();
        if (upperDiffDiv === "D") {        // 일자 차이
            baseDateObj.setDate(baseDateObj.getDate() + DiffVal);
        } else if (upperDiffDiv === "W") { // 주간 차이
            baseDateObj.setDate(baseDateObj.getDate() + (DiffVal * 7));
        } else if (upperDiffDiv === "M") { // 월 차이
            baseDateObj.setMonth(baseDateObj.getMonth() + DiffVal);
        } else if (upperDiffDiv === "Y") { // 년도 차이
            baseDateObj.setFullYear(baseDateObj.getFullYear() + DiffVal);
        }

        // 결과 포맷팅 (구형 브라우저 호환을 위해 on.str.lPad 사용)
        var resultYear  = String(baseDateObj.getFullYear());
        var resultMonth = on.str.lPad(baseDateObj.getMonth() + 1, 2, "0");
        var resultDate  = on.str.lPad(baseDateObj.getDate(), 2, "0");

        // 지정된 포맷으로 동적 치환하여 반환
        return String(dateFormat)
            .replace(/YYYY/g, resultYear)
            .replace(/MM/g, resultMonth)
            .replace(/DD/g, resultDate);
    }

    /* 조회월의 마지막날 찾기 */
    , getMonthLastDay : function(strYearMon) {
        if (on.valid.isEmpty(strYearMon)) strYearMon = on.str.subString(on.str.replaceAll( dateFns.getDate(),"-") , 0, 6);
        var tarYearMon =  on.str.replaceAll(on.str.replaceAll(strYearMon, "-"), "/");
        var nextMonFirstDay = on.date.dateCalc(tarYearMon + "01", "M", 1, "YYYY-MM-DD");
        var thisMonLastDay = on.date.dateCalc(nextMonFirstDay, "D", -1, "YYYY-MM-DD");
        return thisMonLastDay;
    },

    /* 날짜 차이비교 계산기 */
    dateDiff : function(strStartDay, strEndDay, diffDiv) {

        strStartDay = on.str.replaceAll(on.str.replaceAll(strStartDay, "-"), "/");
        strEndDay = on.str.replaceAll(on.str.replaceAll(strEndDay, "-"), "/");

        let baseStartYear = on.str.subString(strStartDay, 0, 4)
            , baseStartMonth = on.str.subString(strStartDay, 4, 6)
            , baseStartday = on.str.subString(strStartDay, 6, 8);

        let baseEndYear = on.str.subString(strEndDay, 0, 4)
            , baseEndMonth = on.str.subString(strEndDay, 4, 6)
            , baseEndday = on.str.subString(strEndDay, 6, 8);

        let strarDateObj = new Date(Number(baseStartYear), Number(baseStartMonth) - 1, Number(baseStartday));
        let endDateObj = new Date(Number(baseEndYear), Number(baseEndMonth) - 1, Number(baseEndday));

        diffDiv =  on.str.nvl(diffDiv, "D");
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

    window.dateFns = dateFns;

})(window);