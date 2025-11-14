package kr.or.standard.itsm.serviceReq.qna.vo;
  
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;

@Alias("itsmQnaVO")
public class ItsmQnaVO extends ItsmCommonDefaultVO {
    public interface insertCheck {}
    public interface insertCommentCheck {}
    public interface updateCheck {}
    public interface updateCommentCheck {}
    public interface deleteCheck {}
    public interface deleteCommentCheck {}

    @NotBlank(message = "요청제목 : 필수 입력입니다.", groups = {ItsmQnaVO.insertCheck.class, ItsmQnaVO.updateCheck.class})
    private String dmndTtl;        /** 요청제목 */

    @NotBlank(message = "요청제목 : 필수 입력입니다.", groups = {ItsmQnaVO.insertCheck.class, ItsmQnaVO.updateCheck.class})
    private String dmndCd;         /** 요청구분코드 */

    private String qnaSn;       /** 질의응답일련번호 */
    private String dmndCdNm;       /** 요청구분코드명 */
    private String rqstrId;        /** 요청자ID */
    private String rqstrNm;        /** 요청자명 */
    private String prcsCn;         /** 처리내용 */
    private String mngrSn;         /** 담당자 일련번호 */
    private String mngrNm;         /** 담당자명 */
    private String prcsCd;         /** 처리상태구분코드 */
    private String prcsCdNm;       /** 처리상태구분코드명 */
    private String jobCd;          /** 업무분류구분코드 */
    private String jobCdNm;        /** 업무분류구분코드명 */
    private String prcsDt;         /** 처리완료일 */
    private String dmndCn;         /** 요청내용 */
    private String rfltDt;         /** 반영일시 */
    private String atchFileId;     /** 첨부파일ID */


    @NotBlank(message = "답변 : 필수 입력입니다.", groups = {ItsmQnaVO.insertCommentCheck.class, ItsmQnaVO.updateCommentCheck.class})
    private String cmntCn;         /** 코멘트내용 */

    private String cmntSn;         /** 코멘트일련번호 */
    private String cmntCnt;        /** 코멘트개수 */
    private String newCmntCnt;     /** 새코멘트개수 */
    private String cmntAtchFileId;  /** 코멘트첨부파일ID */
    private String delAtchCnt;

    public String getQnaSn() {
        return qnaSn;
    }

    public void setQnaSn(String qnaSn) {
        this.qnaSn = qnaSn;
    }

    public String getDmndTtl() {
        return dmndTtl;
    }

    public void setDmndTtl(String dmndTtl) {
        this.dmndTtl = dmndTtl;
    }

    public String getDmndCd() {
        return dmndCd;
    }

    public void setDmndCd(String dmndCd) {
        this.dmndCd = dmndCd;
    }

    public String getDmndCdNm() {
        return dmndCdNm;
    }

    public void setDmndCdNm(String dmndCdNm) {
        this.dmndCdNm = dmndCdNm;
    }

    public String getRqstrId() {
        return rqstrId;
    }

    public void setRqstrId(String rqstrId) {
        this.rqstrId = rqstrId;
    }

    public String getRqstrNm() {
        return rqstrNm;
    }

    public void setRqstrNm(String rqstrNm) {
        this.rqstrNm = rqstrNm;
    }

    public String getPrcsCn() {
        return prcsCn;
    }

    public void setPrcsCn(String prcsCn) {
        this.prcsCn = prcsCn;
    }

    public String getMngrSn() {
        return mngrSn;
    }

    public void setMngrSn(String mngrSn) {
        this.mngrSn = mngrSn;
    }

    public String getMngrNm() {
        return mngrNm;
    }

    public void setMngrNm(String mngrNm) {
        this.mngrNm = mngrNm;
    }

    public String getPrcsCd() {
        return prcsCd;
    }

    public void setPrcsCd(String prcsCd) {
        this.prcsCd = prcsCd;
    }

    public String getPrcsCdNm() {
        return prcsCdNm;
    }

    public void setPrcsCdNm(String prcsCdNm) {
        this.prcsCdNm = prcsCdNm;
    }

    public String getJobCd() {
        return jobCd;
    }

    public void setJobCd(String jobCd) {
        this.jobCd = jobCd;
    }

    public String getJobCdNm() {
        return jobCdNm;
    }

    public void setJobCdNm(String jobCdNm) {
        this.jobCdNm = jobCdNm;
    }

    public String getPrcsDt() {
        return prcsDt;
    }

    public void setPrcsDt(String prcsDt) {
        this.prcsDt = prcsDt;
    }

    public String getDmndCn() {
        return dmndCn;
    }

    public void setDmndCn(String dmndCn) {
        this.dmndCn = dmndCn;
    }

    public String getRfltDt() {
        return rfltDt;
    }

    public void setRfltDt(String rfltDt) {
        this.rfltDt = rfltDt;
    }

    public String getAtchFileId() {
        return atchFileId;
    }

    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
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

    public String getCmntCnt() {
        return cmntCnt;
    }

    public void setCmntCnt(String cmntCnt) {
        this.cmntCnt = cmntCnt;
    }

    public String getNewCmntCnt() {
        return newCmntCnt;
    }

    public void setNewCmntCnt(String newCmntCnt) {
        this.newCmntCnt = newCmntCnt;
    }

    public String getCmntAtchFileId() {
        return cmntAtchFileId;
    }

    public void setCmntAtchFileId(String cmntAtchFileId) {
        this.cmntAtchFileId = cmntAtchFileId;
    }

    public String getDelAtchCnt() {
        return delAtchCnt;
    }

    public void setDelAtchCnt(String delAtchCnt) {
        this.delAtchCnt = delAtchCnt;
    }
}

