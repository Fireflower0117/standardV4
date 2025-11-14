package kr.or.opennote.itsm.operm.errlog.vo;

 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;


@Alias("itsmErrlogVO")
public class ItsmErrlogVO extends ItsmCommonDefaultVO {

    private String serno;	        /*    에러관리,일련번호    */
    private String errTpNm;	        /*    에러관리,에러유형명    */
    private String errExpl;	        /*    에러관리,에러설명    */
    private String svrErrInfoCtt;	/*    에러관리,서버에러정보내용    */
    private String parmCtt1;	    /*    에러관리,파라미터내용1    */
    private String menuCgNm;	    /*    에러관리,메뉴분류명    */
    private String errPthNm;	    /*    에러관리,에러경로명    */
    private String errPageUrlAddr;	/*    에러관리,에러페이지URL주소    */
    private String ipAddr;	        /*    에러관리,IP주소    */
    private String errOccrDt;	    /*    에러관리,에러발생일시    */
    private String useYn;	        /*    에러관리,사용여부    */

    private String errKeyword;	        /*    메뉴명 검색 키워드    */

    private String menuKorNm;	        /*    메뉴 한글명   */
    
    

    public String getMenuKorNm() {
		return menuKorNm;
	}

	public void setMenuKorNm(String menuKorNm) {
		this.menuKorNm = menuKorNm;
	}

	public String getErrKeyword() {
		return errKeyword;
	}

	public void setErrKeyword(String errKeyword) {
		this.errKeyword = errKeyword;
	}

	public String getSerno() {
        return serno;
    }

    public void setSerno(String serno) {
        this.serno = serno;
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

    public String getParmCtt1() {
        return parmCtt1;
    }

    public void setParmCtt1(String parmCtt1) {
        this.parmCtt1 = parmCtt1;
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

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
}