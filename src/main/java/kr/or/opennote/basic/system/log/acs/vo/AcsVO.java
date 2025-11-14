package kr.or.opennote.basic.system.log.acs.vo;


import kr.or.opennote.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
  
@Alias("acsVO")
public class AcsVO extends CmmnDefaultVO {

	private String acsLogSerno;				// 접속로그일련번호
	private String acsLogIpAddr;			// 접속로그IP주소
	private String ipErrYn;					// IP오류여부
	private String lginYn;					// 로그인여부
	private String lginLmtYn;				// 로그인제한여부
	private String acsId;					// 접근ID
	private String authAreaCd;				// 권한영역코드
	
	private String regrSerno;				// 등록자일련번호
	private String regDt;					// 등록일시
	private String updrSerno;				// 수정자일련번호
	private String updDt;					// 수정일시

	private String regrNm;					// 등록자명
	private String logCnt;					// 접속자수

	public String getAcsLogSerno() {
		return acsLogSerno;
	}

	public void setAcsLogSerno(String acsLogSerno) {
		this.acsLogSerno = acsLogSerno;
	}

	public String getAcsLogIpAddr() {
		return acsLogIpAddr;
	}

	public void setAcsLogIpAddr(String acsLogIpAddr) {
		this.acsLogIpAddr = acsLogIpAddr;
	}

	public String getIpErrYn() {
		return ipErrYn;
	}

	public void setIpErrYn(String ipErrYn) {
		this.ipErrYn = ipErrYn;
	}

	public String getLginYn() {
		return lginYn;
	}

	public void setLginYn(String lginYn) {
		this.lginYn = lginYn;
	}

	public String getLginLmtYn() {
		return lginLmtYn;
	}

	public void setLginLmtYn(String lginLmtYn) {
		this.lginLmtYn = lginLmtYn;
	}

	public String getAcsId() {
		return acsId;
	}

	public void setAcsId(String acsId) {
		this.acsId = acsId;
	}

	public String getAuthAreaCd() {
		return authAreaCd;
	}

	public void setAuthAreaCd(String authAreaCd) {
		this.authAreaCd = authAreaCd;
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

	public String getUpdrSerno() {
		return updrSerno;
	}

	public void setUpdrSerno(String updrSerno) {
		this.updrSerno = updrSerno;
	}

	public String getUpdDt() {
		return updDt;
	}

	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}

	public String getRegrNm() {
		return regrNm;
	}

	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
	}

	public String getLogCnt() {
		return logCnt;
	}

	public void setLogCnt(String logCnt) {
		this.logCnt = logCnt;
	}
}
