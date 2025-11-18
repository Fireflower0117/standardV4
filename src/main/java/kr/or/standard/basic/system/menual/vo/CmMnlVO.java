package kr.or.standard.basic.system.menual.vo;


import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 
@Data
@Alias("cmMnlVO")
public class CmMnlVO extends CmmnDefaultVO {

	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String mnlSerno;
	@NotBlank(message = "메뉴구분명 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String menuClNm;
	@NotBlank(message = "담당자명 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String tchgrNm;
	@NotBlank(message = "메뉴설명 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String menuExpl;
	private String atchFileId;
	private String regrSerno;
	private String regrNm;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn;
	private String mnlCnt;
	private String isRegrCheck;
	
	// 항목 리스트
	@NotEmpty(message="항목 목록을 한 개 이상 입력해주세요.", groups = {insertCheck.class, updateCheck.class})
	private List<@Valid CmMnlItmVO> itemList;
	
	/*
	public String getMnlSerno() {
		return mnlSerno;
	}
	public void setMnlSerno(String mnlSerno) {
		this.mnlSerno = mnlSerno;
	}
	public String getMenuClNm() {
		return menuClNm;
	}
	public void setMenuClNm(String menuClNm) {
		this.menuClNm = menuClNm;
	}
	public String getTchgrNm() {
		return tchgrNm;
	}
	public void setTchgrNm(String tchgrNm) {
		this.tchgrNm = tchgrNm;
	}
	public String getMenuExpl() {
		return menuExpl;
	}
	public void setMenuExpl(String menuExpl) {
		this.menuExpl = menuExpl;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getRegrSerno() {
		return regrSerno;
	}
	public void setRegrSerno(String regrSerno) {
		this.regrSerno = regrSerno;
	}
	public String getRegrNm() {
		return regrNm;
	}
	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
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
	public List<CmMnlItmVO> getItemList() {
		return itemList;
	}
	public void setItemList(List<CmMnlItmVO> itemList) {
		this.itemList = itemList;
	}*/
}
