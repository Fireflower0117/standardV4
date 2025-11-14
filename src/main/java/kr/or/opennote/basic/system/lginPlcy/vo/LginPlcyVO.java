package kr.or.opennote.basic.system.lginPlcy.vo;

import javax.validation.constraints.NotBlank;
import kr.or.opennote.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

@Alias("lginPlcyVO")
public class LginPlcyVO extends CmmnDefaultVO {
	
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String lginPlcySerno;
	private String pwdChgCyclDd;		// 비밀번호변경주기일
	
	@NotBlank(message = "비밀번호변경주기 사용여부 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String pwdChgCyclUseYn;		// 비밀번호변경주기 사용여부
	
	@NotBlank(message = "탈퇴정보보유기간 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String scssAccPssnPrdCd;	// 탈퇴계정보유기간코드
	private String lginLmtCnt;			// 로그인제한횟수
	
	@NotBlank(message = "로그인횟수제한 사용여부 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String lginLmtUseYn;		// 로그인제한 사용여부
	
	@NotBlank(message = "기본권한 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String bascGrpAuthId;
	
	@NotBlank(message = "회원기본권한 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String mbrsBascGrpAuthId;
	
	private String regepsId;
	private String regepsPswd;
	private String regepsEmail;
	private String regepsPhone;
	
	private String scssAccPssnPrdNm;	// 탈퇴계정보유기간명
	
	public String getLginPlcySerno() {
		return lginPlcySerno;
	}
	public void setLginPlcySerno(String lginPlcySerno) {
		this.lginPlcySerno = lginPlcySerno;
	}
	public String getPwdChgCyclDd() {
		return pwdChgCyclDd;
	}
	public void setPwdChgCyclDd(String pwdChgCyclDd) {
		this.pwdChgCyclDd = pwdChgCyclDd;
	}
	public String getPwdChgCyclUseYn() {
		return pwdChgCyclUseYn;
	}
	public void setPwdChgCyclUseYn(String pwdChgCyclUseYn) {
		this.pwdChgCyclUseYn = pwdChgCyclUseYn;
	}
	public String getScssAccPssnPrdCd() {
		return scssAccPssnPrdCd;
	}
	public void setScssAccPssnPrdCd(String scssAccPssnPrdCd) {
		this.scssAccPssnPrdCd = scssAccPssnPrdCd;
	}
	public String getLginLmtCnt() {
		return lginLmtCnt;
	}
	public void setLginLmtCnt(String lginLmtCnt) {
		this.lginLmtCnt = lginLmtCnt;
	}
	public String getLginLmtUseYn() {
		return lginLmtUseYn;
	}
	public void setLginLmtUseYn(String lginLmtUseYn) {
		this.lginLmtUseYn = lginLmtUseYn;
	}
	public String getBascGrpAuthId() {
		return bascGrpAuthId;
	}
	public void setBascGrpAuthId(String bascGrpAuthId) {
		this.bascGrpAuthId = bascGrpAuthId;
	}
	public String getMbrsBascGrpAuthId() {
		return mbrsBascGrpAuthId;
	}
	public void setMbrsBascGrpAuthId(String mbrsBascGrpAuthId) {
		this.mbrsBascGrpAuthId = mbrsBascGrpAuthId;
	}
	public String getRegepsId() {
		return regepsId;
	}
	public void setRegepsId(String regepsId) {
		this.regepsId = regepsId;
	}
	public String getRegepsPswd() {
		return regepsPswd;
	}
	public void setRegepsPswd(String regepsPswd) {
		this.regepsPswd = regepsPswd;
	}
	public String getRegepsEmail() {
		return regepsEmail;
	}
	public void setRegepsEmail(String regepsEmail) {
		this.regepsEmail = regepsEmail;
	}
	public String getRegepsPhone() {
		return regepsPhone;
	}
	public void setRegepsPhone(String regepsPhone) {
		this.regepsPhone = regepsPhone;
	}
	public String getScssAccPssnPrdNm() {
		return scssAccPssnPrdNm;
	}
	public void setScssAccPssnPrdNm(String scssAccPssnPrdNm) {
		this.scssAccPssnPrdNm = scssAccPssnPrdNm;
	}
}
