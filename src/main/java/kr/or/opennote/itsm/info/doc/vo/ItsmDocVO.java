package kr.or.opennote.itsm.info.doc.vo;
 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;

@Alias("itsmDocVO")
public class ItsmDocVO extends ItsmCommonDefaultVO {

    public interface insertCheck {}
    public interface insertCommentCheck {}
    public interface deleteCheck {}
    public interface deleteCommentCheck {}

    @NotBlank(message = "서비스를 선택하세요.", groups = {ItsmDocVO.insertCheck.class})
    private String svcSn; // 서비스 일련번호

    @NotBlank(groups = {ItsmDocVO.deleteCheck.class})
    private String docSn; // 문서관리 일련번호

    @NotBlank(message = "문서 제목을 입력하세요.", groups = {ItsmDocVO.insertCheck.class})
    private String docNm; // 문서제목

    @NotBlank(message = "문서 구분을 선택하세요.", groups = {ItsmDocVO.insertCheck.class})
    private String docGbn; // 문서 구분 (ex: 산출물, 기타 ...)
    private String docGbnNm; // 문서 구분 (ex: 산출물, 기타 ...)

    private String docCont; // 문서내용

    private String atchFileId; // 첨부파일 아이디

    @NotBlank(message = "영역을 선택하세요.", groups = {ItsmDocVO.insertCheck.class})
    private String docAreaCd;       // 영역
    private String docAreaNm;       // 영역 명
    @NotBlank(message = "단계를 선택하세요.", groups = {ItsmDocVO.insertCheck.class})
    private String docStepCd;     // 단계 코드
    private String docStepNm;     // 단계 명
    private String docNo;         // 문서번호

    private String fileNm;
    private String fileSeqo;
    private String fileExtnNm;


    // 댓글
    @NotBlank(groups = {ItsmDocVO.deleteCommentCheck.class})
    private String comSn;					// 댓글일련번호
    private String comCn;					// 댓글내용
    private String comCnt;					// 댓글갯수

    private String comAtchFileId;			// 댓글첨부파일ID
    private String comRegDt;				// 댓글등록일
    private String comRegDth;				// 댓글등록일시
    private String newComCnt;				// new코멘트갯수
    private String delAtchCnt;				// 삭제첨부파일갯수

    public String getFileExtnNm() {
        return fileExtnNm;
    }

    public void setFileExtnNm(String fileExtnNm) {
        this.fileExtnNm = fileExtnNm;
    }

    public String getFileSeqo() {
        return fileSeqo;
    }

    public void setFileSeqo(String fileSeqo) {
        this.fileSeqo = fileSeqo;
    }

    public String getFileNm() {
        return fileNm;
    }

    public void setFileNm(String fileNm) {
        this.fileNm = fileNm;
    }

    public String getDocStepNm() {
        return docStepNm;
    }

    public void setDocStepNm(String docStepNm) {
        this.docStepNm = docStepNm;
    }

    public String getComSn() {
        return comSn;
    }

    public String getDocGbnNm() {
        return docGbnNm;
    }

    public String getDocAreaCd() {
        return docAreaCd;
    }

    public void setDocAreaCd(String docAreaCd) {
        this.docAreaCd = docAreaCd;
    }

    public String getDocAreaNm() {
        return docAreaNm;
    }

    public void setDocAreaNm(String docAreaNm) {
        this.docAreaNm = docAreaNm;
    }

    public String getDocStepCd() {
        return docStepCd;
    }

    public void setDocStepCd(String docStepCd) {
        this.docStepCd = docStepCd;
    }

    public String getDocNo() {
        return docNo;
    }

    public void setDocNo(String docNo) {
        this.docNo = docNo;
    }

    public void setDocGbnNm(String docGbnNm) {
        this.docGbnNm = docGbnNm;
    }

    public String getDocGbn() {
        return docGbn;
    }

    public void setDocGbn(String docGbn) {
        this.docGbn = docGbn;
    }


    public void setComSn(String comSn) {
        this.comSn = comSn;
    }

    public String getComCn() {
        return comCn;
    }

    public void setComCn(String comCn) {
        this.comCn = comCn;
    }

    public String getComCnt() {
        return comCnt;
    }

    public void setComCnt(String comCnt) {
        this.comCnt = comCnt;
    }

    public String getComAtchFileId() {
        return comAtchFileId;
    }

    public void setComAtchFileId(String comAtchFileId) {
        this.comAtchFileId = comAtchFileId;
    }

    public String getComRegDt() {
        return comRegDt;
    }

    public void setComRegDt(String comRegDt) {
        this.comRegDt = comRegDt;
    }

    public String getComRegDth() {
        return comRegDth;
    }

    public void setComRegDth(String comRegDth) {
        this.comRegDth = comRegDth;
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

    public String getDocSn() {
        return docSn;
    }

    public void setDocSn(String docSn) {
        this.docSn = docSn;
    }

    public String getDocNm() {
        return docNm;
    }

    public void setDocNm(String docNm) {
        this.docNm = docNm;
    }

    public String getDocCont() {
        return docCont;
    }

    public void setDocCont(String docCont) {
        this.docCont = docCont;
    }

    public String getAtchFileId() {
        return atchFileId;
    }

    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
    }

    @Override
    public String getSvcSn() {
        return svcSn;
    }

    @Override
    public void setSvcSn(String svcSn) {
        this.svcSn = svcSn;
    }
}

