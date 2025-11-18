package kr.or.standard.basic.term.vo;

 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Alias("termsVO")
public class TermsVO extends CmmnDefaultVO {
	
	public interface insertCheck {}
	public interface updateCheck {}
	
	private String menuClCd;		// 선택 메뉴 코드
	
	// 약관 리스트
	@NotEmpty(groups = {insertCheck.class, updateCheck.class})
	private List<@Valid Terms> termsList;

	public static class Terms extends CmmnDefaultVO  {
		@NotBlank(groups = updateCheck.class)
		private String termsSerno;
		private String termsClCd;
		@NotBlank(groups = {insertCheck.class, updateCheck.class})
		private String seqo;
		@NotBlank(message = "약관제목 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
		private String titlNm;
		@NotBlank(message = "약관내용 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
		private String termsCtt;
		@NotBlank(message = "약관유형 : 필수 선택입니다.", groups = {insertCheck.class, updateCheck.class})
		private String selTpCd;
		@NotBlank(message = "보유기간 : 필수 선택입니다.", groups = {insertCheck.class, updateCheck.class})
		private String prdUnitCd;
		@NotBlank(message = "출력시작일 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
		private String otptStrtDt;
		@NotBlank(message = "출력종료일 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
		private String otptEndDt;
		@NotBlank(message = "노출여부 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
		private String expsrYn;
		
		private String loginSerno;
		
		private String selTpNm;			// 선택유형명
		private String prdUnitNm;		// 보유기간명
		
		private String rqrdYn;			// 필수여부
		private String termsAgreeYn;	// 동의여부
		
		private String userSerno;
		
		public String getTermsSerno() {
			return termsSerno;
		}
		public void setTermsSerno(String termsSerno) {
			this.termsSerno = termsSerno;
		}
		public String getTermsClCd() {
			return termsClCd;
		}
		public void setTermsClCd(String termsClCd) {
			this.termsClCd = termsClCd;
		}
		public String getSeqo() {
			return seqo;
		}
		public void setSeqo(String seqo) {
			this.seqo = seqo;
		}
		public String getTitlNm() {
			return titlNm;
		}
		public void setTitlNm(String titlNm) {
			this.titlNm = titlNm;
		}
		public String getTermsCtt() {
			return termsCtt;
		}
		public void setTermsCtt(String termsCtt) {
			this.termsCtt = termsCtt;
		}
		public String getSelTpCd() {
			return selTpCd;
		}
		public void setSelTpCd(String selTpCd) {
			this.selTpCd = selTpCd;
		}
		public String getPrdUnitCd() {
			return prdUnitCd;
		}
		public void setPrdUnitCd(String prdUnitCd) {
			this.prdUnitCd = prdUnitCd;
		}
		public String getOtptStrtDt() {
			return otptStrtDt;
		}
		public void setOtptStrtDt(String otptStrtDt) {
			this.otptStrtDt = otptStrtDt;
		}
		public String getOtptEndDt() {
			return otptEndDt;
		}
		public void setOtptEndDt(String otptEndDt) {
			this.otptEndDt = otptEndDt;
		}
		public String getExpsrYn() {
			return expsrYn;
		}
		public void setExpsrYn(String expsrYn) {
			this.expsrYn = expsrYn;
		}
		public String getLoginSerno() {
			return loginSerno;
		}
		public void setLoginSerno(String loginSerno) {
			this.loginSerno = loginSerno;
		}
		public String getSelTpNm() {
			return selTpNm;
		}
		public void setSelTpNm(String selTpNm) {
			this.selTpNm = selTpNm;
		}
		public String getPrdUnitNm() {
			return prdUnitNm;
		}
		public void setPrdUnitNm(String prdUnitNm) {
			this.prdUnitNm = prdUnitNm;
		}
		public String getRqrdYn() {
			return rqrdYn;
		}
		public void setRqrdYn(String rqrdYn) {
			this.rqrdYn = rqrdYn;
		}
		public String getTermsAgreeYn() {
			return termsAgreeYn;
		}
		public void setTermsAgreeYn(String termsAgreeYn) {
			this.termsAgreeYn = termsAgreeYn;
		}
		public String getUserSerno() {
			return userSerno;
		}
		public void setUserSerno(String userSerno) {
			this.userSerno = userSerno;
		}
		
		
	}
	public List<Terms> getTermsList() {
		return termsList;
	}
	public void setTermsList(List<Terms> termsList) {
		this.termsList = termsList;
	}
	public String getMenuClCd() {
		return menuClCd;
	}
	public void setMenuClCd(String menuClCd) {
		this.menuClCd = menuClCd;
	}
}
