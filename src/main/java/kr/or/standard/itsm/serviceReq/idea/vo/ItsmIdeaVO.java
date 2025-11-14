package kr.or.standard.itsm.serviceReq.idea.vo;
  
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;


@Alias("itsmIdeaVO")
public class ItsmIdeaVO extends ItsmCommonDefaultVO {

	public interface insertCheck {}
	public interface insertCommentCheck {}
	public interface updateCheck {}
	public interface updateCommentCheck {}
	public interface deleteCheck {}
	public interface deleteCommentCheck {}

	@NotBlank(message = "제목 : 필수 입력입니다.", groups = {ItsmIdeaVO.insertCheck.class, ItsmIdeaVO.updateCheck.class})
	private String ideaTtl;

	@NotBlank(message = "내용 : 필수 입력입니다.", groups = {ItsmIdeaVO.insertCheck.class, ItsmIdeaVO.updateCheck.class})
	private String bltnbCn;
	
	private String rNum;
	private int cmntCurrentPageNo = 1;
	
	private String ideaSn;
	private String serno;
	private String atchFileId;
	private String regDt;
	private String rgtrSn;
	private String mdfcnDt;
	private String mdfrSn;
	private String useYn;
	private String fileSeqo;
	private String prcsStts;

	@NotBlank(message = "내용 : 필수 입력입니다.", groups = {ItsmIdeaVO.insertCommentCheck.class, ItsmIdeaVO.updateCommentCheck.class})
	private String cmntCn;

	private String cmntSn;
	private String cmntCnAsr;
	private String upPstatSn;
	private String menuCd;
	private String cmntAtchFileId;
	private String delAtchCnt;
	private String comCnt;
	private String newComCnt;

	public String getComCnt() {
		return comCnt;
	}

	public void setComCnt(String comCnt) {
		this.comCnt = comCnt;
	}

	public String getNewComCnt() {
		return newComCnt;
	}

	public void setNewComCnt(String newComCnt) {
		this.newComCnt = newComCnt;
	}

	public String getDelAtchCnt() {
		return delAtchCnt;
	}

	public void setDelAtchCnt(String delAtchCnt) {
		this.delAtchCnt = delAtchCnt;
	}

	public String getCmntAtchFileId() {
		return cmntAtchFileId;
	}

	public void setCmntAtchFileId(String cmntAtchFileId) {
		this.cmntAtchFileId = cmntAtchFileId;
	}

	public String getIdeaSn() {
		return ideaSn;
	}
	public void setIdeaSn(String ideaSn) {
		this.ideaSn = ideaSn;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getIdeaTtl() {
		return ideaTtl;
	}
	public void setIdeaTtl(String ideaTtl) {
		this.ideaTtl = ideaTtl;
	}
	public String getBltnbCn() {
		return bltnbCn;
	}
	public void setBltnbCn(String bltnbCn) {
		this.bltnbCn = bltnbCn;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getRgtrSn() {
		return rgtrSn;
	}
	public void setRgtrSn(String rgtrSn) {
		this.rgtrSn = rgtrSn;
	}
	public String getMdfcnDt() {
		return mdfcnDt;
	}
	public void setMdfcnDt(String mdfcnDt) {
		this.mdfcnDt = mdfcnDt;
	}
	public String getMdfrSn() {
		return mdfrSn;
	}
	public void setMdfrSn(String mdfrSn) {
		this.mdfrSn = mdfrSn;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getFileSeqo() {
		return fileSeqo;
	}
	public void setFileSeqo(String fileSeqo) {
		this.fileSeqo = fileSeqo;
	}
	public String getCmntSn() {
		return cmntSn;
	}
	public void setCmntSn(String cmntSn) {
		this.cmntSn = cmntSn;
	}
	public String getCmntCn() {
		return cmntCn;
	}
	public void setCmntCn(String cmntCn) {
		this.cmntCn = cmntCn;
	}
	public String getMenuCd() {
		return menuCd;
	}
	public void setMenuId(String menuCd) {
		this.menuCd = menuCd;
	}
	public String getCmntCnAsr() {
		return cmntCnAsr;
	}
	public void setCmntCnAsr(String cmntCnAsr) {
		this.cmntCnAsr = cmntCnAsr;
	}
	public String getrNum() {
		return rNum;
	}
	public void setrNum(String rNum) {
		this.rNum = rNum;
	}
	public int getCmntCurrentPageNo() {
		return cmntCurrentPageNo;
	}
	public void setCmntCurrentPageNo(int cmntCurrentPageNo) {
		this.cmntCurrentPageNo = cmntCurrentPageNo;
	}
	public String getUpPstatSn() {
		return upPstatSn;
	}
	public void setUpPstatSn(String upPstatSn) {
		this.upPstatSn = upPstatSn;
	}
	public String getPrcsStts() {
		return prcsStts;
	}
	public void setPrcsStts(String prcsStts) {
		this.prcsStts = prcsStts;
	} 
}