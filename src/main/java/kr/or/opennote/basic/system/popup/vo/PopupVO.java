package kr.or.opennote.basic.system.popup.vo;

import javax.validation.constraints.NotBlank;

import kr.or.opennote.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
 

@Alias("popupVO")
public class PopupVO extends CmmnDefaultVO {
	
	public interface insertCheck{}
	public interface updateCheck{}
	public interface deleteCheck{}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String popupSerno;
	@NotBlank(message = "팝업제목 : 필수입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupTitlNm;
	@NotBlank(message = "팝업게시여부 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupPstnYn;
	@NotBlank(message = "팝업게시기간 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupPstnPrdYn;
	private String popupPstnStrtDt;
	private String popupPstnEndDt;
	private String popupWdthSizeVal;
	private String popupHghtSizeVal;
	private String repImgId;
	@NotBlank(message = "팝업대상 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupTgtCd;
	private String popupUpndMargnVal;
	private String popupLsdMargnVal;
	@NotBlank(message = "팝업내용 : 필수입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupCtt;
	@NotBlank(message = "팝업구분 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupClCd;
	private String regrSerno;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn;
	
	private String regrNm;
	private String repImgSrc;	// 팝업 이미지 경로
	private String popupClNm;	// 팝업구분명
	private String popupTgtNm;	// 팝업대상명
	
	private String fileSeqo;		// 파일순서
	private String phclFileNm;	// 물리파일명
	
	public String getPopupSerno() {
		return popupSerno;
	}
	public void setPopupSerno(String popupSerno) {
		this.popupSerno = popupSerno;
	}
	public String getPopupTitlNm() {
		return popupTitlNm;
	}
	public void setPopupTitlNm(String popupTitlNm) {
		this.popupTitlNm = popupTitlNm;
	}
	public String getPopupPstnPrdYn() {
		return popupPstnPrdYn;
	}
	public void setPopupPstnPrdYn(String popupPstnPrdYn) {
		this.popupPstnPrdYn = popupPstnPrdYn;
	}
	public String getPopupPstnYn() {
		return popupPstnYn;
	}
	public void setPopupPstnYn(String popupPstnYn) {
		this.popupPstnYn = popupPstnYn;
	}
	public String getPopupWdthSizeVal() {
		return popupWdthSizeVal;
	}
	public void setPopupWdthSizeVal(String popupWdthSizeVal) {
		this.popupWdthSizeVal = popupWdthSizeVal;
	}
	public String getPopupHghtSizeVal() {
		return popupHghtSizeVal;
	}
	public void setPopupHghtSizeVal(String popupHghtSizeVal) {
		this.popupHghtSizeVal = popupHghtSizeVal;
	}
	public String getRepImgId() {
		return repImgId;
	}
	public void setRepImgId(String repImgId) {
		this.repImgId = repImgId;
	}
	public String getPopupTgtCd() {
		return popupTgtCd;
	}
	public void setPopupTgtCd(String popupTgtCd) {
		this.popupTgtCd = popupTgtCd;
	}
	public String getPopupUpndMargnVal() {
		return popupUpndMargnVal;
	}
	public void setPopupUpndMargnVal(String popupUpndMargnVal) {
		this.popupUpndMargnVal = popupUpndMargnVal;
	}
	public String getPopupLsdMargnVal() {
		return popupLsdMargnVal;
	}
	public void setPopupLsdMargnVal(String popupLsdMargnVal) {
		this.popupLsdMargnVal = popupLsdMargnVal;
	}
	public String getPopupCtt() {
		return popupCtt;
	}
	public void setPopupCtt(String popupCtt) {
		this.popupCtt = popupCtt;
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
	public String getPopupPstnStrtDt() {
		return popupPstnStrtDt;
	}
	public void setPopupPstnStrtDt(String popupPstnStrtDt) {
		this.popupPstnStrtDt = popupPstnStrtDt;
	}
	public String getPopupPstnEndDt() {
		return popupPstnEndDt;
	}
	public void setPopupPstnEndDt(String popupPstnEndDt) {
		this.popupPstnEndDt = popupPstnEndDt;
	}
	public String getPopupClCd() {
		return popupClCd;
	}
	public void setPopupClCd(String popupClCd) {
		this.popupClCd = popupClCd;
	}
	public String getRegrNm() {
		return regrNm;
	}
	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
	}
	public String getRepImgSrc() {
		return repImgSrc;
	}
	public void setRepImgSrc(String repImgSrc) {
		this.repImgSrc = repImgSrc;
	}
	public String getPopupClNm() {
		return popupClNm;
	}
	public void setPopupClNm(String popupClNm) {
		this.popupClNm = popupClNm;
	}
	public String getPopupTgtNm() {
		return popupTgtNm;
	}
	public void setPopupTgtNm(String popupTgtNm) {
		this.popupTgtNm = popupTgtNm;
	}
	public String getFileSeqo() {
		return fileSeqo;
	}
	public void setFileSeqo(String fileSeqo) {
		this.fileSeqo = fileSeqo;
	}
	public String getPhclFileNm() {
		return phclFileNm;
	}
	public void setPhclFileNm(String phclFileNm) {
		this.phclFileNm = phclFileNm;
	}
}
