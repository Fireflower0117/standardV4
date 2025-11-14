package kr.or.standard.basic.system.cprgt.vo;

import javax.validation.constraints.NotBlank;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

@Alias("cprgtVO")
public class CprgtVO extends CmmnDefaultVO {
	
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String cprgtSerno;
	@NotBlank(message = "저작권 내용 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String cprgtCtt;
	@NotBlank(message = "우편번호 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coPostNo;
	@NotBlank(message = "도로명주소 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coAddr;
	@NotBlank(message = "지번주소 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coLtnoAddr;
	@NotBlank(message = "상세주소 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coDtlsAddr;
	private String coEngAddr;
	@NotBlank(message = "팩스번호 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coFaxNo;
	@NotBlank(message = "유선번호 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coTelNo;
	private String regrSerno;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn;
	
	public String getCprgtSerno() {
		return cprgtSerno;
	}
	public void setCprgtSerno(String cprgtSerno) {
		this.cprgtSerno = cprgtSerno;
	}
	public String getCprgtCtt() {
		return cprgtCtt;
	}
	public void setCprgtCtt(String cprgtCtt) {
		this.cprgtCtt = cprgtCtt;
	}
	public String getCoAddr() {
		return coAddr;
	}
	public void setCoAddr(String coAddr) {
		this.coAddr = coAddr;
	}
	public String getCoDtlsAddr() {
		return coDtlsAddr;
	}
	public void setCoDtlsAddr(String coDtlsAddr) {
		this.coDtlsAddr = coDtlsAddr;
	}
	public String getCoPostNo() {
		return coPostNo;
	}
	public void setCoPostNo(String coPostNo) {
		this.coPostNo = coPostNo;
	}
	public String getCoLtnoAddr() {
		return coLtnoAddr;
	}
	public void setCoLtnoAddr(String coLtnoAddr) {
		this.coLtnoAddr = coLtnoAddr;
	}
	public String getCoEngAddr() {
		return coEngAddr;
	}
	public void setCoEngAddr(String coEngAddr) {
		this.coEngAddr = coEngAddr;
	}
	public String getCoFaxNo() {
		return coFaxNo;
	}
	public void setCoFaxNo(String coFaxNo) {
		this.coFaxNo = coFaxNo;
	}
	public String getCoTelNo() {
		return coTelNo;
	}
	public void setCoTelNo(String coTelNo) {
		this.coTelNo = coTelNo;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
}
