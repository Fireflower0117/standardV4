package kr.or.opennote.itsm.serviceReq.impFnc.vo;
 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import java.util.List;

@Alias("itsmImpFncVO")
public class ItsmImpFncVO extends ItsmCommonDefaultVO {

    public interface insertCheck {}
    public interface insertCommentCheck {}
    public interface updateCheck {}
    public interface updateCommentCheck {}
    public interface deleteCheck {}
    public interface deleteCommentCheck {}

    // 담당자 지정시 담당자,처리예정일 유효성 검사
    public interface managerCheck {}

    // 처리완료시 담당자, 메뉴, 처리구분 유효성 검사
    public interface submitCheck {}

    @NotBlank(groups = {ItsmImpFncVO.updateCheck.class,ItsmImpFncVO.deleteCheck.class,ItsmImpFncVO.managerCheck.class,ItsmImpFncVO.submitCheck.class})
    private String imprvSn;       /** 개선일련번호 */

    @NotBlank(message = "요청제목 : 필수 입력입니다.", groups = {ItsmImpFncVO.insertCheck.class, ItsmImpFncVO.updateCheck.class})
    private String dmndTtl;        /** 요청제목 */

    @NotBlank(message = "요청구분 : 필수 선택입니다.", groups = {ItsmImpFncVO.insertCheck.class, ItsmImpFncVO.updateCheck.class})
    private String dmndCd;         /** 요청구분코드 */

    @NotBlank(message = "처리요청일 : 필수 입력입니다.", groups = {ItsmImpFncVO.insertCheck.class, ItsmImpFncVO.updateCheck.class})
    private String dmndDt;         /** 완료요청일 */
    private String dmndCdNm;       /** 요청구분코드명 */
    private String rqstrId;        /** 요청자ID */
    private String rqstrNm;        /** 요청자명 */
    private String prcsCn;         /** 처리내용 */
    private String prcsCd;         /** 처리상태구분코드 */

    @NotBlank(message = " 처리구분 : 필수 선택입니다.", groups = {ItsmImpFncVO.submitCheck.class})
    private String prcsGbn;         /** 처리구분코드 */
    private String prcsGbnNm;         /** 처리구분코드명 */
    private String prcsCdNm;       /** 처리상태구분코드명 */
    private String prcsDt;         /** 처리완료일 */

    private String dmndCn;         /** 요청내용 */
    private String dmndRmk;         /** 요청비고 */
    private String atchFileId;     /** 첨부파일ID */
    private String prcsCnt;
    private String chgSn;           /** 변경이력 일련번호 */
    private String prcsLeng;

    @NotBlank(message = " 처리 예정일 : 필수 입력입니다.", groups = {ItsmImpFncVO.managerCheck.class})
    private String prnmntDt; // 처리 예정일
    @NotBlank(message = " 담당자 : 필수 선택입니다.", groups = {ItsmImpFncVO.managerCheck.class,ItsmImpFncVO.submitCheck.class})
    private String userSerno; // 담당자 일련번호
    private String userNm;
    private String userId;

    private String comCnt;
    private String newComCnt;

    private List<ItsmImpFncVO> dmndCnList;     /** 요청사항리스트 */

    @NotBlank(message = " 메뉴 : 필수 선택입니다.", groups = {ItsmImpFncVO.submitCheck.class})
    private String menuCd;
    private String menuNm;
    private String dmndCnSn;
    private String upMenuNm;



    @NotBlank(groups = {ItsmImpFncVO.updateCommentCheck.class, ItsmImpFncVO.deleteCommentCheck.class})
    private String cmntSn;         /** 코멘트일련번호 */
    @NotBlank(message = " 내용 : 필수 입력입니다.", groups = {ItsmImpFncVO.insertCommentCheck.class, ItsmImpFncVO.updateCommentCheck.class})
    private String cmntCn;         /** 코멘트내용 */
    private String cmntCnt;        /** 코멘트개수 */
    private String newCmntCnt;     /** 새코멘트개수 */
    private String cmntAtchFileId;  /** 코멘트첨부파일ID */
    private String delAtchCnt;

    private String cofSn;
    private String cnt1;    /** 요청항목 총 개수*/
    private String cnt2;
    private String cnt3;
    private String cnt4;
    private String cnt5;
    private String cnt6;
    private String cnt7;
    private String cnt8;
    private String cnt9;

    private String all1;
    private String all2;
    private String all3;
    private String all4;

    private String year;
    private String month;
    private String day;
    private String week;
    private String weekStartDay;
    private String weekEndDay;

    private String yearMonth1;
    private String yearMonth2;
    private String yearMonth3;
    private String yearMonth4;
    private String yearMonth5;
    private String yearMonth6;

    public String getUpMenuNm() {
        return upMenuNm;
    }

    public void setUpMenuNm(String upMenuNm) {
        this.upMenuNm = upMenuNm;
    }

    public void setMenuCd(String menuCd) {
        this.menuCd = menuCd;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getYearMonth1() {
        return yearMonth1;
    }

    public void setYearMonth1(String yearMonth1) {
        this.yearMonth1 = yearMonth1;
    }

    public String getYearMonth2() {
        return yearMonth2;
    }

    public void setYearMonth2(String yearMonth2) {
        this.yearMonth2 = yearMonth2;
    }

    public String getYearMonth3() {
        return yearMonth3;
    }

    public void setYearMonth3(String yearMonth3) {
        this.yearMonth3 = yearMonth3;
    }

    public String getYearMonth4() {
        return yearMonth4;
    }

    public void setYearMonth4(String yearMonth4) {
        this.yearMonth4 = yearMonth4;
    }

    public String getYearMonth5() {
        return yearMonth5;
    }

    public void setYearMonth5(String yearMonth5) {
        this.yearMonth5 = yearMonth5;
    }

    public String getYearMonth6() {
        return yearMonth6;
    }

    public void setYearMonth6(String yearMonth6) {
        this.yearMonth6 = yearMonth6;
    }

    public String getAll1() {
        return all1;
    }

    public void setAll1(String all1) {
        this.all1 = all1;
    }

    public String getAll2() {
        return all2;
    }

    public void setAll2(String all2) {
        this.all2 = all2;
    }

    public String getAll3() {
        return all3;
    }

    public void setAll3(String all3) {
        this.all3 = all3;
    }

    public String getAll4() {
        return all4;
    }

    public void setAll4(String all4) {
        this.all4 = all4;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getWeekStartDay() {
        return weekStartDay;
    }

    public void setWeekStartDay(String weekStartDay) {
        this.weekStartDay = weekStartDay;
    }

    public String getWeekEndDay() {
        return weekEndDay;
    }

    public void setWeekEndDay(String weekEndDay) {
        this.weekEndDay = weekEndDay;
    }

    public String getCnt3() {
        return cnt3;
    }

    public void setCnt3(String cnt3) {
        this.cnt3 = cnt3;
    }

    public String getCnt4() {
        return cnt4;
    }

    public void setCnt4(String cnt4) {
        this.cnt4 = cnt4;
    }

    public String getCnt5() {
        return cnt5;
    }

    public void setCnt5(String cnt5) {
        this.cnt5 = cnt5;
    }

    public String getCnt6() {
        return cnt6;
    }

    public void setCnt6(String cnt6) {
        this.cnt6 = cnt6;
    }

    public String getCnt7() {
        return cnt7;
    }

    public void setCnt7(String cnt7) {
        this.cnt7 = cnt7;
    }

    public String getCnt8() {
        return cnt8;
    }

    public void setCnt8(String cnt8) {
        this.cnt8 = cnt8;
    }

    public String getCnt9() {
        return cnt9;
    }

    public void setCnt9(String cnt9) {
        this.cnt9 = cnt9;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getPrcsGbnNm() {
        return prcsGbnNm;
    }

    public void setPrcsGbnNm(String prcsGbnNm) {
        this.prcsGbnNm = prcsGbnNm;
    }

    public String getPrcsGbn() {
        return prcsGbn;
    }

    public void setPrcsGbn(String prcsGbn) {
        this.prcsGbn = prcsGbn;
    }

    public String getComCnt() {
        return comCnt;
    }

    public void setComCnt(String comCnt) {
        this.comCnt = comCnt;
    }

    public String getNewComCnt() {
        return newComCnt;
    }

    public void setNewComCnt(String newComCnt) {
        this.newComCnt = newComCnt;
    }

    /** 요청항목 처리된 개수*/

    public String getDmndDt() {
        return dmndDt;
    }

    public void setDmndDt(String dmndDt) {
        this.dmndDt = dmndDt;
    }

    public String getUserSerno() {
        return userSerno;
    }

    public void setUserSerno(String userSerno) {
        this.userSerno = userSerno;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getPrnmntDt() {
        return prnmntDt;
    }

    public void setPrnmntDt(String prnmntDt) {
        this.prnmntDt = prnmntDt;
    }

    public String getCnt1() {
        return cnt1;
    }

    public void setCnt1(String cnt1) {
        this.cnt1 = cnt1;
    }

    public String getCnt2() {
        return cnt2;
    }

    public void setCnt2(String cnt2) {
        this.cnt2 = cnt2;
    }

    public String getCofSn() {
        return cofSn;
    }

    public void setCofSn(String cofSn) {
        this.cofSn = cofSn;
    }

    public String getPrcsLeng() {
        return prcsLeng;
    }

    public void setPrcsLeng(String prcsLeng) {
        this.prcsLeng = prcsLeng;
    }

    public String getPrcsCnt() {
        return prcsCnt;
    }

    public void setPrcsCnt(String prcsCnt) {
        this.prcsCnt = prcsCnt;
    }

    public String getDmndRmk() {
        return dmndRmk;
    }

    public void setDmndRmk(String dmndRmk) {
        this.dmndRmk = dmndRmk;
    }

    public String getMenuNm() {
        return menuNm;
    }

    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    public List<ItsmImpFncVO> getDmndCnList() {
        return dmndCnList;
    }

    public void setDmndCnList(List<ItsmImpFncVO> dmndCnList) {
        this.dmndCnList = dmndCnList;
    }

    public String getMenuCd() {
        return menuCd;
    }

    public void setMenuId(String menuCd) {
        this.menuCd = menuCd;
    }

    public String getDmndCnSn() {
        return dmndCnSn;
    }

    public void setDmndCnSn(String dmndCnSn) {
        this.dmndCnSn = dmndCnSn;
    }

    public String getDelAtchCnt() {
        return delAtchCnt;
    }

    public void setDelAtchCnt(String delAtchCnt) {
        this.delAtchCnt = delAtchCnt;
    }


    public String getCmntAtchFileId() {
        return cmntAtchFileId;
    }

    public void setCmntAtchFileId(String cmntAtchFileId) {
        this.cmntAtchFileId = cmntAtchFileId;
    }

    public String getRqstrNm() {
        return rqstrNm;
    }

    public void setRqstrNm(String rqstrNm) {
        this.rqstrNm = rqstrNm;
    }

    public String getNewCmntCnt() {
        return newCmntCnt;
    }

    public void setNewCmntCnt(String newCmntCnt) {
        this.newCmntCnt = newCmntCnt;
    }

    public String getCmntCnt() {
        return cmntCnt;
    }

    public void setCmntCnt(String cmntCnt) {
        this.cmntCnt = cmntCnt;
    }
    public String getDmndCdNm() {
        return dmndCdNm;
    }

    public void setDmndCdNm(String dmndCdNm) {
        this.dmndCdNm = dmndCdNm;
    }

    public String getPrcsCdNm() {
        return prcsCdNm;
    }

    public void setPrcsCdNm(String prcsCdNm) {
        this.prcsCdNm = prcsCdNm;
    }

    /** 코멘트내용 */


    public String getImprvSn() {
        return imprvSn;
    }

    public void setImprvSn(String imprvSn) {
        this.imprvSn = imprvSn;
    }

    public String getDmndTtl() {
        return dmndTtl;
    }

    public void setDmndTtl(String dmndTtl) {
        this.dmndTtl = dmndTtl;
    }

    public String getDmndCd() {
        return dmndCd;
    }

    public void setDmndCd(String dmndCd) {
        this.dmndCd = dmndCd;
    }

    public String getRqstrId() {
        return rqstrId;
    }

    public void setRqstrId(String rqstrId) {
        this.rqstrId = rqstrId;
    }

    public String getPrcsCn() {
        return prcsCn;
    }

    public void setPrcsCn(String prcsCn) {
        this.prcsCn = prcsCn;
    }

    public String getPrcsCd() {
        return prcsCd;
    }

    public void setPrcsCd(String prcsCd) {
        this.prcsCd = prcsCd;
    }


    public String getPrcsDt() {
        return prcsDt;
    }

    public void setPrcsDt(String prcsDt) {
        this.prcsDt = prcsDt;
    }

    public String getDmndCn() {
        return dmndCn;
    }

    public void setDmndCn(String dmndCn) {
        this.dmndCn = dmndCn;
    }

    public String getAtchFileId() {
        return atchFileId;
    }

    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
    }

    public String getCmntSn() {
        return cmntSn;
    }

    public void setCmntSn(String cmntSn) {
        this.cmntSn = cmntSn;
    }

    public String getCmntCn() {
        return cmntCn;
    }

    public void setCmntCn(String cmntCn) {
        this.cmntCn = cmntCn;
    }

    public String getChgSn() {
        return chgSn;
    }

    public void setChgSn(String chgSn) {
        this.chgSn = chgSn;
    }
}
