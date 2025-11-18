package kr.or.standard.basic.system.menual.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.file.vo.FileVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 
@Data
@Alias("cmMnlItmVO")
public class CmMnlItmVO extends CmmnDefaultVO {

	public interface insertCheck {}
	public interface updateCheck {}
	
	private String mnlItmSerno;
	private String mnlSerno;
	private String mnlItmNo;
	@NotBlank(message = "항목구분 : 필수 선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String mnlItmClCd;
	@NotBlank(groups = {insertCheck.class, updateCheck.class})
	private String mnlItmSeqo;
	private String titlNm;
	private String subTitlNm;
	private String dtlsCtt;
	private String atchFileId;
	private String urlAddr;
	private String htmlSrcdCtt;
	private String cssSrcdCtt;
	private String jsSrcdCtt;
	private String javaSrcdCtt;
	private String xmlSrcdCtt;
	private String regrSerno;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn;
	
	private List<FileVO> imgList;	// 이미지 목록
	
	/*
	public String getMnlItmSerno() {
		return mnlItmSerno;
	}
	public void setMnlItmSerno(String mnlItmSerno) {
		this.mnlItmSerno = mnlItmSerno;
	}
	public String getMnlSerno() {
		return mnlSerno;
	}
	public void setMnlSerno(String mnlSerno) {
		this.mnlSerno = mnlSerno;
	}
	public String getMnlItmNo() {
		return mnlItmNo;
	}
	public void setMnlItmNo(String mnlItmNo) {
		this.mnlItmNo = mnlItmNo;
	}
	public String getMnlItmClCd() {
		return mnlItmClCd;
	}
	public void setMnlItmClCd(String mnlItmClCd) {
		this.mnlItmClCd = mnlItmClCd;
	}
	public String getMnlItmSeqo() {
		return mnlItmSeqo;
	}
	public void setMnlItmSeqo(String mnlItmSeqo) {
		this.mnlItmSeqo = mnlItmSeqo;
	}
	public String getTitlNm() {
		return titlNm;
	}
	public void setTitlNm(String titlNm) {
		this.titlNm = titlNm;
	}
	public String getSubTitlNm() {
		return subTitlNm;
	}
	public void setSubTitlNm(String subTitlNm) {
		this.subTitlNm = subTitlNm;
	}
	public String getDtlsCtt() {
		return dtlsCtt;
	}
	public void setDtlsCtt(String dtlsCtt) {
		this.dtlsCtt = dtlsCtt;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getUrlAddr() {
		return urlAddr;
	}
	public void setUrlAddr(String urlAddr) {
		this.urlAddr = urlAddr;
	}
	public String getHtmlSrcdCtt() {
		return htmlSrcdCtt;
	}
	public void setHtmlSrcdCtt(String htmlSrcdCtt) {
		this.htmlSrcdCtt = htmlSrcdCtt;
	}
	public String getCssSrcdCtt() {
		return cssSrcdCtt;
	}
	public void setCssSrcdCtt(String cssSrcdCtt) {
		this.cssSrcdCtt = cssSrcdCtt;
	}
	public String getJsSrcdCtt() {
		return jsSrcdCtt;
	}
	public void setJsSrcdCtt(String jsSrcdCtt) {
		this.jsSrcdCtt = jsSrcdCtt;
	}
	public String getJavaSrcdCtt() {
		return javaSrcdCtt;
	}
	public void setJavaSrcdCtt(String javaSrcdCtt) {
		this.javaSrcdCtt = javaSrcdCtt;
	}
	public String getXmlSrcdCtt() {
		return xmlSrcdCtt;
	}
	public void setXmlSrcdCtt(String xmlSrcdCtt) {
		this.xmlSrcdCtt = xmlSrcdCtt;
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
	public List<FileVO> getImgList() {
		return imgList;
	}
	public void setImgList(List<FileVO> imgList) {
		this.imgList = imgList;
	}*/
	
}
