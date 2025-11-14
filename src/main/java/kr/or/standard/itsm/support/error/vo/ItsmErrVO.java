package kr.or.standard.itsm.support.error.vo;

 
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotEmpty;

@Alias("itsmErrVO")
public class ItsmErrVO extends ItsmCommonDefaultVO {

    public interface updateCheck {}

    private String errSn;	        /*    에러관리,장애이력 일련번호    */
    private String errLogSn;	        /*    에러관리,에러 로그 일련번호    */
    private String errTpNm;	        /*    에러관리,에러유형명    */
    private String errExpl;	        /*    에러관리,에러설명    */
    private String svrErrInfoCtt;	/*    에러관리,서버에러정보내용    */
    private String menuCgNm;	    /*    에러관리,메뉴분류명    */
    private String errPthNm;	    /*    에러관리,에러경로명    */
    private String errPageUrlAddr;	/*    에러관리,에러페이지URL주소    */
    private String ipAddr;	        /*    에러관리,IP주소    */
    private String errOccrDt;	    /*    에러관리,에러발생일시    */
    private String errMngrDt;	    /*    에러관리,담당자 배정 일시    */
    private String errResDt;	    /*    에러관리,오류해결일시    */
    private String errResCn;	    /*    에러관리,오류 처리 내용    */

    @NotEmpty(message = "담당자 : 필수 선택입니다.", groups = {ItsmErrVO.updateCheck.class})
    private String mngrSn;	        /*    담당자 일련번호   */
    private String mngrNm;	        /*    담당자 일련번호 이름 */
    private String menuKorNm;	        /*    메뉴 한글명   */

    @NotEmpty(message = "에러 구분 : 필수 선택입니다.", groups = {ItsmErrVO.updateCheck.class})
    private String errGbn;	        /*   에러 구분(FRONT,PG,SERVER,DB)   */
    private String errGbnNm;	        /*   에러 구분(FRONT,PG,SERVER,DB)   */

    @NotEmpty(message = "메뉴 : 필수 선택입니다.", groups = {ItsmErrVO.updateCheck.class})
    private String menuCd;	        /*   메뉴 ID   */

    private String menuNm;	        /*   메뉴 ID   */
    private String reqDd;	        /*   소요일   */

    private String snList;       	// 에러 일괄처리할때 체크박스 체크한 목록

    public String getSnList() {
        return snList;
    }

    public void setSnList(String snList) {
        this.snList = snList;
    }

    public String getErrGbnNm() {
        return errGbnNm;
    }

    public void setErrGbnNm(String errGbnNm) {
        this.errGbnNm = errGbnNm;
    }

    public String getMenuNm() {
        return menuNm;
    }

    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }

    public String getMngrSn() {
        return mngrSn;
    }

    public void setMngrSn(String mngrSn) {
        this.mngrSn = mngrSn;
    }

    public String getMngrNm() {
        return mngrNm;
    }

    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    public String getErrSn() {
        return errSn;
    }

    public void setErrSn(String errSn) {
        this.errSn = errSn;
    }

    public String getErrLogSn() {
        return errLogSn;
    }

    public void setErrLogSn(String errLogSn) {
        this.errLogSn = errLogSn;
    }

    public String getErrTpNm() {
        return errTpNm;
    }

    public void setErrTpNm(String errTpNm) {
        this.errTpNm = errTpNm;
    }

    public String getErrExpl() {
        return errExpl;
    }

    public void setErrExpl(String errExpl) {
        this.errExpl = errExpl;
    }

    public String getSvrErrInfoCtt() {
        return svrErrInfoCtt;
    }

    public void setSvrErrInfoCtt(String svrErrInfoCtt) {
        this.svrErrInfoCtt = svrErrInfoCtt;
    }


    public String getMenuCgNm() {
        return menuCgNm;
    }

    public void setMenuCgNm(String menuCgNm) {
        this.menuCgNm = menuCgNm;
    }

    public String getErrPthNm() {
        return errPthNm;
    }

    public void setErrPthNm(String errPthNm) {
        this.errPthNm = errPthNm;
    }

    public String getErrPageUrlAddr() {
        return errPageUrlAddr;
    }

    public void setErrPageUrlAddr(String errPageUrlAddr) {
        this.errPageUrlAddr = errPageUrlAddr;
    }

    public String getIpAddr() {
        return ipAddr;
    }

    public void setIpAddr(String ipAddr) {
        this.ipAddr = ipAddr;
    }

    public String getErrOccrDt() {
        return errOccrDt;
    }

    public void setErrOccrDt(String errOccrDt) {
        this.errOccrDt = errOccrDt;
    }

    public String getErrMngrDt() {
        return errMngrDt;
    }

    public void setErrMngrDt(String errMngrDt) {
        this.errMngrDt = errMngrDt;
    }

    public String getErrResDt() {
        return errResDt;
    }

    public void setErrResDt(String errResDt) {
        this.errResDt = errResDt;
    }

    public String getMenuKorNm() {
        return menuKorNm;
    }

    public void setMenuKorNm(String menuKorNm) {
        this.menuKorNm = menuKorNm;
    }

    public String getErrResCn() {
        return errResCn;
    }

    public void setErrResCn(String errResCn) {
        this.errResCn = errResCn;
    }


    public String getErrGbn() {
        return errGbn;
    }

    public void setErrGbn(String errGbn) {
        this.errGbn = errGbn;
    }

    public String getMenuCd() {
        return menuCd;
    }

    public void setMenuId(String menuCd) {
        this.menuCd = menuCd;
    }

    public String getReqDd() {
        return reqDd;
    }

    public void setReqDd(String reqDd) {
        this.reqDd = reqDd;
    }
}
