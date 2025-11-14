package kr.or.opennote.basic.system.log.errlog.vo;

import kr.or.opennote.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

@Alias("errlogVO")
public class ErrlogVO extends CmmnDefaultVO {

	private String errLogSerno;				// 오류로그일련번호
	private String errTpNm;					// 오류유형명
	private String errExpl;					// 오류설명
	private String svrErrCtt;				// 서버오류내용
	private String menuCgNm;				// 메뉴분류명
	private String menuNm;					// 메뉴명
	private String errPthNm;				// 오류경로명
	private String errOccrUrlAddr;			// 오류발생URL주소
	private String errOccrIpAddr;			// 오류발생IP주소
	private String errOccrDt;				// 오류발생일시
	private String useYn;					// 사용여부

	public String getErrLogSerno() {
		return errLogSerno;
	}

	public void setErrLogSerno(String errLogSerno) {
		this.errLogSerno = errLogSerno;
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

	public String getSvrErrCtt() {
		return svrErrCtt;
	}

	public void setSvrErrCtt(String svrErrCtt) {
		this.svrErrCtt = svrErrCtt;
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

	public String getErrOccrUrlAddr() {
		return errOccrUrlAddr;
	}

	public void setErrOccrUrlAddr(String errOccrUrlAddr) {
		this.errOccrUrlAddr = errOccrUrlAddr;
	}

	public String getErrOccrIpAddr() {
		return errOccrIpAddr;
	}

	public void setErrOccrIpAddr(String errOccrIpAddr) {
		this.errOccrIpAddr = errOccrIpAddr;
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

	public String getMenuNm() {
		return menuNm;
	}

	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
}
