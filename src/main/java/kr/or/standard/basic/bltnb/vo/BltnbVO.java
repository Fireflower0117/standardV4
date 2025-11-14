package kr.or.standard.basic.bltnb.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
import javax.validation.constraints.NotBlank;
 
@Alias("bltnbVO")
public class BltnbVO  extends CmmnDefaultVO {
 
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	public interface pswdCheck {}
	public interface insertReplCheck {}
	public interface updateReplCheck {}
	public interface deleteReplCheck {}
	public interface insertLikeCheck {}
	public interface updateLikeCheck {}

	@NotBlank(message = "공통게시판 일련번호 : 필수 입력입니다.",groups = {updateCheck.class, deleteCheck.class, pswdCheck.class})
	private String bltnbSerno;
	private String menuCd;
	private String bltnbCl;
	
	private String regrSerno;		/* 등록자 일련번호 */
	private String regrNm;			/* 등록자 이름 */
	private String regDt;			/* 등록 일시 */
	private String updrSerno;		/* 수정자 일련번호 */
	private int    isRegrChecked;	/* 작성자 == 로그인사용자 확인 */
	private int    isRegrReplChecked;	/* 댓글작성자 == 로그인사용자 확인 */
	private String updDt;			/* 수정일시 */
	private int rowCnt;			    /* 수정일시 */  
	
	@NotBlank(message = "제목 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String bltnbTitl;
	@NotBlank(message = "내용 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String bltnbCtt;
	private String regionCd;
	
	// 공지사항(nt)
	private String ntiYn;
	private String ntiStrtDt;
	private String ntiEndDt;
	private String ntiCheck;
	
	private String oppbYn;
	private String replYn;
	private String scretYn;
	@NotBlank(message = "비밀번호 : 필수 입력입니다.",groups = {pswdCheck.class})
	private String bltnbPswd;
	private String bltnbPswdCheck; 
	
	private String atchFileId;
	private String fileSeqo;
	private String fileNmPhclFileNm;
	
	//이전글 다음글
	private String serno;
	private String titl;
	private String divn;
	
	//좋아요
	@NotBlank(message = "좋아요 일련번호 : 필수 입력입니다.",groups = {updateLikeCheck.class})
	private String rcmdSerno;
	@NotBlank(message = "좋아요구분 : 필수 입력입니다.",groups = {insertLikeCheck.class})
	private String rcmdYn;
	private String rcmdYCnt;
	private String rcmdNCnt;
	
	//QNA 답변
	@NotBlank(message = "답변 일련번호 : 필수 입력입니다.",groups = {updateReplCheck.class, deleteReplCheck.class})
	private String replSerno;
	private String uprReplSerno;
	
	@NotBlank(message = "내용 : 필수 입력입니다.",groups = {insertReplCheck.class, updateReplCheck.class})
	private String replCtt;		
	private String replRegrNm;
	private String replRegrSerno;
	private String replRegDt;	
	private String replCnt;
	private String path1;
	private String supportSerno;
	private String supportTitl;
	private String regionNm;
	private String regionClass;
	private String busiTitl;
	private String reqPireod;
	private String reqStrtDt;
	private String reqEndDt;
	private String busiCtt;
	private String ClickCnt;

	public String getBltnbSerno() {
		return bltnbSerno;
	}

	public void setBltnbSerno(String bltnbSerno) {
		this.bltnbSerno = bltnbSerno;
	}

	public String getMenuCd() {
		return menuCd;
	}

	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}

	public String getBltnbCl() {
		return bltnbCl;
	}

	public void setBltnbCl(String bltnbCl) {
		this.bltnbCl = bltnbCl;
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

	public int getIsRegrChecked() {
		return isRegrChecked;
	}

	public void setIsRegrChecked(int isRegrChecked) {
		this.isRegrChecked = isRegrChecked;
	}

	public int getIsRegrReplChecked() {
		return isRegrReplChecked;
	}

	public void setIsRegrReplChecked(int isRegrReplChecked) {
		this.isRegrReplChecked = isRegrReplChecked;
	}

	public String getUpdDt() {
		return updDt;
	}

	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}

	public int getRowCnt() {
		return rowCnt;
	}

	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
	}

	public String getBltnbTitl() {
		return bltnbTitl;
	}

	public void setBltnbTitl(String bltnbTitl) {
		this.bltnbTitl = bltnbTitl;
	}

	public String getBltnbCtt() {
		return bltnbCtt;
	}

	public void setBltnbCtt(String bltnbCtt) {
		this.bltnbCtt = bltnbCtt;
	}

	public String getRegionCd() {
		return regionCd;
	}

	public void setRegionCd(String regionCd) {
		this.regionCd = regionCd;
	}

	public String getNtiYn() {
		return ntiYn;
	}

	public void setNtiYn(String ntiYn) {
		this.ntiYn = ntiYn;
	}

	public String getNtiStrtDt() {
		return ntiStrtDt;
	}

	public void setNtiStrtDt(String ntiStrtDt) {
		this.ntiStrtDt = ntiStrtDt;
	}

	public String getNtiEndDt() {
		return ntiEndDt;
	}

	public void setNtiEndDt(String ntiEndDt) {
		this.ntiEndDt = ntiEndDt;
	}

	public String getNtiCheck() {
		return ntiCheck;
	}

	public void setNtiCheck(String ntiCheck) {
		this.ntiCheck = ntiCheck;
	}

	public String getOppbYn() {
		return oppbYn;
	}

	public void setOppbYn(String oppbYn) {
		this.oppbYn = oppbYn;
	}

	public String getReplYn() {
		return replYn;
	}

	public void setReplYn(String replYn) {
		this.replYn = replYn;
	}

	public String getScretYn() {
		return scretYn;
	}

	public void setScretYn(String scretYn) {
		this.scretYn = scretYn;
	}

	public String getBltnbPswd() {
		return bltnbPswd;
	}

	public void setBltnbPswd(String bltnbPswd) {
		this.bltnbPswd = bltnbPswd;
	}

	public String getBltnbPswdCheck() {
		return bltnbPswdCheck;
	}

	public void setBltnbPswdCheck(String bltnbPswdCheck) {
		this.bltnbPswdCheck = bltnbPswdCheck;
	}

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public String getFileSeqo() {
		return fileSeqo;
	}

	public void setFileSeqo(String fileSeqo) {
		this.fileSeqo = fileSeqo;
	}

	public String getFileNmPhclFileNm() {
		return fileNmPhclFileNm;
	}

	public void setFileNmPhclFileNm(String fileNmPhclFileNm) {
		this.fileNmPhclFileNm = fileNmPhclFileNm;
	}

	public String getSerno() {
		return serno;
	}

	public void setSerno(String serno) {
		this.serno = serno;
	}

	public String getTitl() {
		return titl;
	}

	public void setTitl(String titl) {
		this.titl = titl;
	}

	public String getDivn() {
		return divn;
	}

	public void setDivn(String divn) {
		this.divn = divn;
	}

	public String getRcmdSerno() {
		return rcmdSerno;
	}

	public void setRcmdSerno(String rcmdSerno) {
		this.rcmdSerno = rcmdSerno;
	}

	public String getRcmdYn() {
		return rcmdYn;
	}

	public void setRcmdYn(String rcmdYn) {
		this.rcmdYn = rcmdYn;
	}

	public String getRcmdYCnt() {
		return rcmdYCnt;
	}

	public void setRcmdYCnt(String rcmdYCnt) {
		this.rcmdYCnt = rcmdYCnt;
	}

	public String getRcmdNCnt() {
		return rcmdNCnt;
	}

	public void setRcmdNCnt(String rcmdNCnt) {
		this.rcmdNCnt = rcmdNCnt;
	}

	public String getReplSerno() {
		return replSerno;
	}

	public void setReplSerno(String replSerno) {
		this.replSerno = replSerno;
	}

	public String getUprReplSerno() {
		return uprReplSerno;
	}

	public void setUprReplSerno(String uprReplSerno) {
		this.uprReplSerno = uprReplSerno;
	}

	public String getReplCtt() {
		return replCtt;
	}

	public void setReplCtt(String replCtt) {
		this.replCtt = replCtt;
	}

	public String getReplRegrNm() {
		return replRegrNm;
	}

	public void setReplRegrNm(String replRegrNm) {
		this.replRegrNm = replRegrNm;
	}

	public String getReplRegrSerno() {
		return replRegrSerno;
	}

	public void setReplRegrSerno(String replRegrSerno) {
		this.replRegrSerno = replRegrSerno;
	}

	public String getReplRegDt() {
		return replRegDt;
	}

	public void setReplRegDt(String replRegDt) {
		this.replRegDt = replRegDt;
	}

	public String getReplCnt() {
		return replCnt;
	}

	public void setReplCnt(String replCnt) {
		this.replCnt = replCnt;
	}

	public String getPath1() {
		return path1;
	}

	public void setPath1(String path1) {
		this.path1 = path1;
	}

	public String getSupportSerno() {
		return supportSerno;
	}

	public void setSupportSerno(String supportSerno) {
		this.supportSerno = supportSerno;
	}

	public String getSupportTitl() {
		return supportTitl;
	}

	public void setSupportTitl(String supportTitl) {
		this.supportTitl = supportTitl;
	}

	public String getRegionNm() {
		return regionNm;
	}

	public void setRegionNm(String regionNm) {
		this.regionNm = regionNm;
	}

	public String getRegionClass() {
		return regionClass;
	}

	public void setRegionClass(String regionClass) {
		this.regionClass = regionClass;
	}

	public String getBusiTitl() {
		return busiTitl;
	}

	public void setBusiTitl(String busiTitl) {
		this.busiTitl = busiTitl;
	}

	public String getReqPireod() {
		return reqPireod;
	}

	public void setReqPireod(String reqPireod) {
		this.reqPireod = reqPireod;
	}

	public String getReqStrtDt() {
		return reqStrtDt;
	}

	public void setReqStrtDt(String reqStrtDt) {
		this.reqStrtDt = reqStrtDt;
	}

	public String getReqEndDt() {
		return reqEndDt;
	}

	public void setReqEndDt(String reqEndDt) {
		this.reqEndDt = reqEndDt;
	}

	public String getBusiCtt() {
		return busiCtt;
	}

	public void setBusiCtt(String busiCtt) {
		this.busiCtt = busiCtt;
	}

	public String getClickCnt() {
		return ClickCnt;
	}

	public void setClickCnt(String clickCnt) {
		ClickCnt = clickCnt;
	}

	@Override
    public String toString() {
        return "BltnbVO{" +
                "bltnbSerno='" + bltnbSerno + '\'' +
                ", menuCd='" + menuCd + '\'' +
                ", bltnbCl='" + bltnbCl + '\'' +
                ", regrSerno='" + regrSerno + '\'' +
                ", regrNm='" + regrNm + '\'' +
                ", regDt='" + regDt + '\'' +
                ", updrSerno='" + updrSerno + '\'' +
                ", updDt='" + updDt + '\'' +
                ", bltnbTitl='" + bltnbTitl + '\'' +
                ", bltnbCtt='" + bltnbCtt + '\'' +
                ", regionCd='" + regionCd + '\'' +
                ", ntiYn='" + ntiYn + '\'' +
                ", ntiStrtDt='" + ntiStrtDt + '\'' +
                ", ntiEndDt='" + ntiEndDt + '\'' +
                ", ntiCheck='" + ntiCheck + '\'' +
                ", oppbYn='" + oppbYn + '\'' +
                ", replYn='" + replYn + '\'' +
                ", scretYn='" + scretYn + '\'' +
                ", bltnbPswd='" + bltnbPswd + '\'' +
                ", bltnbPswdCheck='" + bltnbPswdCheck + '\'' +
                ", atchFileId='" + atchFileId + '\'' +
                ", fileSeqo='" + fileSeqo + '\'' +
                ", fileNmPhclFileNm='" + fileNmPhclFileNm + '\'' +
                ", serno='" + serno + '\'' +
                ", titl='" + titl + '\'' +
                ", divn='" + divn + '\'' +
                ", rcmdSerno='" + rcmdSerno + '\'' +
                ", rcmdYn='" + rcmdYn + '\'' +
                ", rcmdYCnt='" + rcmdYCnt + '\'' +
                ", rcmdNCnt='" + rcmdNCnt + '\'' +
                ", replSerno='" + replSerno + '\'' +
                ", uprReplSerno='" + uprReplSerno + '\'' +
                ", replCtt='" + replCtt + '\'' +
                ", replRegrNm='" + replRegrNm + '\'' +
                ", replRegrSerno='" + replRegrSerno + '\'' +
                ", replRegDt='" + replRegDt + '\'' +
                ", replCnt='" + replCnt + '\'' +
                ", path1='" + path1 + '\'' +
                ", supportSerno='" + supportSerno + '\'' +
                ", supportTitl='" + supportTitl + '\'' +
                ", regionNm='" + regionNm + '\'' +
                ", regionClass='" + regionClass + '\'' +
                ", busiTitl='" + busiTitl + '\'' +
                ", reqPireod='" + reqPireod + '\'' +
                ", reqStrtDt='" + reqStrtDt + '\'' +
                ", reqEndDt='" + reqEndDt + '\'' +
                ", busiCtt='" + busiCtt + '\'' +
                ", ClickCnt='" + ClickCnt + '\'' +
                '}';
    }
}

