package kr.or.standard.basic.system.logo.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
import javax.validation.constraints.NotBlank;

@Alias("logoVO")
public class LogoVO extends CmmnDefaultVO {

    public interface inserCheck {}  // 등록 유효성 체크
    public interface updateCheck {} // 수정 유효성 체크

    private String logoSerno;       // 일련번호
    private String itmNm;		    // 항목명
    @NotBlank(message = "항목 : 필수 입력입니다.", groups = {inserCheck.class, updateCheck.class})
    private String itmCd;		    // 항목코드
    private String actvtYn;		    // 활성화여부
    private String useYn;		    // 사용여부
    private String lnkYn;		    // 링크여부
    private String url;			    // URL
    private String lnkTgtCd;	    // 링크대상코드
    private String fileSeqo;	    // 첨부파일 순서
    private String atchFileId;      // 첨부파일아이디
    private String fileNmPhclFileNm;


    private String nextSn;		    // 다음글일련번호
    private String nextItmNm;	    // 다음글항목이름
    private String prevSn;		    // 이전글일련번호
    private String prevItmNm;	    // 이전글항목이름
    
    private String regDt;
    private String regrNm;
    private String linkTgtNm;
    private String logoCount;
    private String isRegrChk;

    public String getIsRegrChk() { return isRegrChk; }

    public void setIsRegrChk(String isRegrChk) { this.isRegrChk = isRegrChk; }

    public String getLogoCount() { return logoCount; }

    public void setLogoCount(String logoCount) { this.logoCount = logoCount; }

    public String getLogoSerno() {
        return logoSerno;
    }

    public void setLogoSerno(String logoSerno) {
        this.logoSerno = logoSerno;
    }

    public String getItmNm() {
        return itmNm;
    }

    public void setItmNm(String itmNm) {
        this.itmNm = itmNm;
    }

    public String getItmCd() {
        return itmCd;
    }

    public void setItmCd(String itmCd) {
        this.itmCd = itmCd;
    }

    public String getActvtYn() {
        return actvtYn;
    }

    public void setActvtYn(String actvtYn) {
        this.actvtYn = actvtYn;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getLnkYn() {
        return lnkYn;
    }

    public void setLnkYn(String lnkYn) {
        this.lnkYn = lnkYn;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLnkTgtCd() {
        return lnkTgtCd;
    }

    public void setLnkTgtCd(String lnkTgtCd) {
        this.lnkTgtCd = lnkTgtCd;
    }

    public String getFileSeqo() {
        return fileSeqo;
    }

    public void setFileSeqo(String fileSeqo) {
        this.fileSeqo = fileSeqo;
    }

    public String getAtchFileId() {
        return atchFileId;
    }

    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
    }

    public String getNextSn() {
        return nextSn;
    }

    public void setNextSn(String nextSn) {
        this.nextSn = nextSn;
    }

    public String getNextItmNm() {
        return nextItmNm;
    }

    public void setNextItmNm(String nextItmNm) {
        this.nextItmNm = nextItmNm;
    }

    public String getPrevSn() {
        return prevSn;
    }

    public void setPrevSn(String prevSn) {
        this.prevSn = prevSn;
    }

    public String getPrevItmNm() {
        return prevItmNm;
    }

    public void setPrevItmNm(String prevItmNm) {
        this.prevItmNm = prevItmNm;
    }

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getFileNmPhclFileNm() {
		return fileNmPhclFileNm;
	}

	public void setFileNmPhclFileNm(String fileNmPhclFileNm) {
		this.fileNmPhclFileNm = fileNmPhclFileNm;
	}

    public String getRegrNm() {
        return regrNm;
    }

    public void setRegrNm(String regrNm) {
        this.regrNm = regrNm;
    }

    public String getLinkTgtNm() {
        return linkTgtNm;
    }

    public void setLinkTgtNm(String linkTgtNm) {
        this.linkTgtNm = linkTgtNm;
    }
}