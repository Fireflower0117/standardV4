package kr.or.standard.itsm.serviceReq.request.vo;
  
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;

@Alias("itsmRqstVO") 
public class ItsmRequestVO extends ItsmCommonDefaultVO {

    public interface insertCheck {}
    public interface insertCommentCheck {}
    public interface updateCheck {}
    public interface updateCommentCheck {}
    public interface deleteCheck {}
    public interface deleteCommentCheck {}

    private String rqrSn;          /** 요구사항일련번호 */
    private String rqrId;          /** 요구사항 ID */
    private String rqrItm;         /** 요구사항 항목 */
    private String rqrDtl;         /** 요구사항 세부내역 */
    private String rqrSrc;         /** 출처 */
    private String rqrProc;        /** 상태(진행/종료) */
    private String rqrProcNm;      /** 상태(진행/종료) 명 */
    private String rqrCls;         /** 분류(디자인/개발) */
    private String custMngrSn;     /** 고객 담당자 일련번호 */
    private String custMngrNm;     /** 고객 담당자 명 */
    private String dvlpMngrSn;     /** 개발 담당자 일련번호 */
    private String dvlpMngrNm;     /** 개발 담당자 명 */
    private String rqrDtlId;       /** 요구사항 세부 ID */
    private String rqrCn;          /** 요구정의 진행현황 */
    private String rqrDiv;         /** 구분(요청사항) */
    private String rqrDivNm;       /** 구분(요청사항) 명 */
    private String dcmntId;        /** 구분(요청사항) */
    private String atchFileId;     /** 첨부파일ID */

    private String cmntSn;         /** 코멘트일련번호 */
    @NotBlank(message = " 내용 : 필수 입력입니다.", groups = {ItsmRequestVO.insertCommentCheck.class, ItsmRequestVO.updateCommentCheck.class})
    private String cmntCn;         /** 코멘트내용 */
    private String cmntCnt;        /** 코멘트개수 */
    private String newCmntCnt;     /** 새코멘트개수 */
    private String cmntAtchFileId; /** 코멘트첨부파일ID */
    private int cmntCurrentPageNo = 1; /** 댓글 페이징 */
    private String delAtchCnt;
    private String mngrGbn;


    private String rqrProcSn;
    private String rqrProcCn;
    private String procAtchFileId;
    private String rqrProcStts;
    private String rqrProcSttsNm;

    private String cofSn;

    public String getCofSn() {
        return cofSn;
    }

    public void setCofSn(String cofSn) {
        this.cofSn = cofSn;
    }

    public String getMngrGbn() {
        return mngrGbn;
    }

    public void setMngrGbn(String mngrGbn) {
        this.mngrGbn = mngrGbn;
    }

    public String getRqrProcSttsNm() {
        return rqrProcSttsNm;
    }

    public void setRqrProcSttsNm(String rqrProcSttsNm) {
        this.rqrProcSttsNm = rqrProcSttsNm;
    }

    public String getRqrProcSn() {
        return rqrProcSn;
    }

    public void setRqrProcSn(String rqrProcSn) {
        this.rqrProcSn = rqrProcSn;
    }

    public String getRqrProcCn() {
        return rqrProcCn;
    }

    public void setRqrProcCn(String rqrProcCn) {
        this.rqrProcCn = rqrProcCn;
    }

    public String getProcAtchFileId() {
        return procAtchFileId;
    }

    public void setProcAtchFileId(String procAtchFileId) {
        this.procAtchFileId = procAtchFileId;
    }

    public String getRqrProcStts() {
        return rqrProcStts;
    }

    public void setRqrProcStts(String rqrProcStts) {
        this.rqrProcStts = rqrProcStts;
    }

    public int getCmntCurrentPageNo() {
        return cmntCurrentPageNo;
    }

    public void setCmntCurrentPageNo(int cmntCurrentPageNo) {
        this.cmntCurrentPageNo = cmntCurrentPageNo;
    }

    public String getCustMngrNm() {
        return custMngrNm;
    }

    public void setCustMngrNm(String custMngrNm) {
        this.custMngrNm = custMngrNm;
    }

    public String getDvlpMngrNm() {
        return dvlpMngrNm;
    }

    public void setDvlpMngrNm(String dvlpMngrNm) {
        this.dvlpMngrNm = dvlpMngrNm;
    }

    public String getRqrProcNm() {
        return rqrProcNm;
    }

    public void setRqrProcNm(String rqrProcNm) {
        this.rqrProcNm = rqrProcNm;
    }

    public String getRqrDivNm() {
        return rqrDivNm;
    }

    public void setRqrDivNm(String rqrDivNm) {
        this.rqrDivNm = rqrDivNm;
    }

    public String getRqrSn() {
        return rqrSn;
    }

    public void setRqrSn(String rqrSn) {
        this.rqrSn = rqrSn;
    }

    public String getRqrId() {
        return rqrId;
    }

    public void setRqrId(String rqrId) {
        this.rqrId = rqrId;
    }

    public String getRqrItm() {
        return rqrItm;
    }

    public void setRqrItm(String rqrItm) {
        this.rqrItm = rqrItm;
    }

    public String getRqrDtl() {
        return rqrDtl;
    }

    public void setRqrDtl(String rqrDtl) {
        this.rqrDtl = rqrDtl;
    }

    public String getRqrSrc() {
        return rqrSrc;
    }

    public void setRqrSrc(String rqrSrc) {
        this.rqrSrc = rqrSrc;
    }

    public String getRqrProc() {
        return rqrProc;
    }

    public void setRqrProc(String rqrProc) {
        this.rqrProc = rqrProc;
    }

    public String getRqrCls() {
        return rqrCls;
    }

    public void setRqrCls(String rqrCls) {
        this.rqrCls = rqrCls;
    }

    public String getCustMngrSn() {
        return custMngrSn;
    }

    public void setCustMngrSn(String custMngrSn) {
        this.custMngrSn = custMngrSn;
    }

    public String getDvlpMngrSn() {
        return dvlpMngrSn;
    }

    public void setDvlpMngrSn(String dvlpMngrSn) {
        this.dvlpMngrSn = dvlpMngrSn;
    }

    public String getRqrDtlId() {
        return rqrDtlId;
    }

    public void setRqrDtlId(String rqrDtlId) {
        this.rqrDtlId = rqrDtlId;
    }

    public String getRqrCn() {
        return rqrCn;
    }

    public void setRqrCn(String rqrCn) {
        this.rqrCn = rqrCn;
    }

    public String getRqrDiv() {
        return rqrDiv;
    }

    public void setRqrDiv(String rqrDiv) {
        this.rqrDiv = rqrDiv;
    }

    public String getDcmntId() {
        return dcmntId;
    }

    public void setDcmntId(String dcmntId) {
        this.dcmntId = dcmntId;
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
