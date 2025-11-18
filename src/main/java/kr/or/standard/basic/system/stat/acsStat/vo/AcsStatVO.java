package kr.or.standard.basic.system.stat.acsStat.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

@Alias("acsStatVO")
public class AcsStatVO extends CmmnDefaultVO {

    private String menuLogSerno;                // 메뉴로그일련번호
    private String menuUrlAddr;                 // 메뉴URL주소
    private String acsIpAddr;                   // 접속IP주소
    private String menuCd;                      // 메뉴코드
    private String regrSerno;                   // 등록자일련번호
    private String regDt;                       // 등록일시
    private String userCount;                   // 사용자 Count


    public String getUserCount() { return userCount; }

    public void setUserCount(String userCount) { this.userCount = userCount; }

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

    public String getAcsIpAddr() {
        return acsIpAddr;
    }

    public void setAcsIpAddr(String acsIpAddr) {
        this.acsIpAddr = acsIpAddr;
    }

    public String getMenuCd() {
        return menuCd;
    }

    public void setMenuCd(String menuCd) {
        this.menuCd = menuCd;
    }

    public String getRegrSerno() {
        return regrSerno;
    }

    public void setRegrSerno(String regrSerno) {
        this.regrSerno = regrSerno;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }
}
