package kr.or.standard.basic.system.regeps.vo;

import javax.validation.constraints.NotBlank;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
 
@Alias("regepsVO")
public class RegepsVO extends CmmnDefaultVO {
	
	public interface idCheck{}
	public interface insertCheck{}
	public interface updateCheck{}
	public interface deleteCheck{}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String regepsSerno;
	@NotBlank(message = "정규표현식ID : 필수 입력입니다.", groups = {idCheck.class, insertCheck.class})
	private String regepsId;
	@NotBlank(message = "정규표현식명 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String regepsNm;
	@NotBlank(message = "정규표현식텍스트 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String regepsTxt;
	@NotBlank(message = "플레이스홀더텍스트 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String placeholderTxt;
	@NotBlank(message = "오류 메세지 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String errMsg;
	@NotBlank(message = "정규표현식예시 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String regepsExm;
	private String regepsCount;
	private String regrCheck;
	private String regepsIdCheck;
	
	private String useYn;
	private String regrSerno;
	private String regDt;
	private String regrNm;
	private String updrSerno;
	private String updDt;

	public String getRegrCheck() {
		return regrCheck;
	}

	public void setRegrCheck(String regrCheck) {
		this.regrCheck = regrCheck;
	}

	public String getRegepsCount() {
		return regepsCount;
	}

	public void setRegepsCount(String regepsCount) {
		this.regepsCount = regepsCount;
	}

	public String getRegepsIdCheck() {
		return regepsIdCheck;
	}

	public void setRegepsIdCheck(String regepsIdCheck) {
		this.regepsIdCheck = regepsIdCheck;
	}

	public String getRegepsSerno() {
		return regepsSerno;
	}
	public void setRegepsSerno(String regepsSerno) {
		this.regepsSerno = regepsSerno;
	}
	public String getRegepsId() {
		return regepsId;
	}
	public void setRegepsId(String regepsId) {
		this.regepsId = regepsId;
	}
	public String getRegepsNm() {
		return regepsNm;
	}
	public void setRegepsNm(String regepsNm) {
		this.regepsNm = regepsNm;
	}
	public String getRegepsTxt() {
		return regepsTxt;
	}
	public void setRegepsTxt(String regepsTxt) {
		this.regepsTxt = regepsTxt;
	}
	public String getPlaceholderTxt() {
		return placeholderTxt;
	}
	public void setPlaceholderTxt(String placeholderTxt) {
		this.placeholderTxt = placeholderTxt;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getRegepsExm() {
		return regepsExm;
	}
	public void setRegepsExm(String regepsExm) {
		this.regepsExm = regepsExm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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

	@Override
	public String toString() {
		return "RegepsVO{" +
				"regepsSerno='" + regepsSerno + '\'' +
				", regepsId='" + regepsId + '\'' +
				", regepsNm='" + regepsNm + '\'' +
				", regepsTxt='" + regepsTxt + '\'' +
				", placeholderTxt='" + placeholderTxt + '\'' +
				", errMsg='" + errMsg + '\'' +
				", regepsExm='" + regepsExm + '\'' +
				", regepsCount='" + regepsCount + '\'' +
				", regrCheck='" + regrCheck + '\'' +
				", regepsIdCheck='" + regepsIdCheck + '\'' +
				", useYn='" + useYn + '\'' +
				", regrSerno='" + regrSerno + '\'' +
				", regDt='" + regDt + '\'' +
				", regrNm='" + regrNm + '\'' +
				", updrSerno='" + updrSerno + '\'' +
				", updDt='" + updDt + '\'' +
				'}';
	}
}

