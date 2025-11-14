package kr.or.standard.itsm.operm.acs.vo;
 
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;


@Alias("itsmAcsVO")
public class ItsmAcsVO extends ItsmCommonDefaultVO {

    private String logSerno;	/*    로그관리,로그일련번호    */
    private String logIpAddr;	/*    로그관리,로그IP주소    */
    private String regDt;	    /*    로그관리,등록일시    */
    private String regrId;	    /*    로그관리,등록자ID    */
    private String logIpErrYn;	/*    로그관리,로그IP오류여부    */
    private String lgnYn;		/*    로그인 여부    */
    private String acsId;		/*    접근ID    */
    private String authrtAreaCd;	/*    권한영역코드    */
    private String authrtAreaNm;	/*    권한영역명    */

    private String menuLogSerno;	/*    메뉴로그관리,메뉴로그일련번호    */
    private String menuUrlAddr;	/*    메뉴로그관리,메뉴URL주소    */
    private String menuLcgCdVal;	/*    메뉴로그관리,메뉴대분류코드값    */

    private String userSn;
    
    private String name;
    private String logCnt;
    
    private String excelYn;

    public String getExcelYn() {
		return excelYn;
	}


    public String getUserSn() {
        return userSn;
    }

    public void setUserSn(String userSn) {
        this.userSn = userSn;
    }

    public void setExcelYn(String excelYn) {
		this.excelYn = excelYn;
	}

	public String getLogSerno() {
        return logSerno;
    }

    public void setLogSerno(String logSerno) {
        this.logSerno = logSerno;
    }

    public String getLogIpAddr() {
        return logIpAddr;
    }

    public void setLogIpAddr(String logIpAddr) {
        this.logIpAddr = logIpAddr;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public String getRegrId() {
        return regrId;
    }

    public void setRegrId(String regrId) {
        this.regrId = regrId;
    }

    public String getLogIpErrYn() {
        return logIpErrYn;
    }

    public void setLogIpErrYn(String logIpErrYn) {
        this.logIpErrYn = logIpErrYn;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogCnt() {
        return logCnt;
    }

    public void setLogCnt(String logCnt) {
        this.logCnt = logCnt;
    }

    public String getMenuLogSerno() {
        return menuLogSerno;
    }

    public void setMenuLogSerno(String menuLogSerno) {
        this.menuLogSerno = menuLogSerno;
    }

    public String getMenuUrlAddr() {
        return menuUrlAddr;
    }

    public void setMenuUrlAddr(String menuUrlAddr) {
        this.menuUrlAddr = menuUrlAddr;
    }

    public String getMenuLcgCdVal() {
        return menuLcgCdVal;
    }

    public void setMenuLcgCdVal(String menuLcgCdVal) {
        this.menuLcgCdVal = menuLcgCdVal;
    }
	public String getLgnYn() {
		return lgnYn;
	}
	public void setLgnYn(String lgnYn) {
		this.lgnYn = lgnYn;
	}
	public String getAcsId() {
		return acsId;
	}
	public void setAcsId(String acsId) {
		this.acsId = acsId;
	}
	public String getAuthrtAreaCd() {
		return authrtAreaCd;
	}
	public void setAuthrtAreaCd(String authrtAreaCd) {
		this.authrtAreaCd = authrtAreaCd;
	}
	public String getAuthrtAreaNm() {
		return authrtAreaNm;
	}
	public void setAuthrtAreaNm(String authrtAreaNm) {
		this.authrtAreaNm = authrtAreaNm;
	}
	
    
}