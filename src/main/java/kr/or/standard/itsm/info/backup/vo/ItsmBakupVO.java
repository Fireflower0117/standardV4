package kr.or.standard.itsm.info.backup.vo;

 
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

@Alias("itsmBakupVO")
public class ItsmBakupVO extends ItsmCommonDefaultVO {
    private String bakSn; // 백업관리 일련번호
    private String bakNm; // 백업제목
    private String bakGbn; // 백업 구분
    private String bakGbnNm; // 백업 구분
    private String bakCont; // 백업내용
    private String atchFileId; // 첨부파일 아이디
    private String bakPath; // 백업 파일이 위치한 경로
    private String bakVol; // 백업 용량
    private String autoYn; // 자동백업 여부

    private String bakYn;
    private String bakTime; // 소요시간
    private String errCn; // 백업 실패시 스크립트


    /** ITSM_DATA_TIMER 테이블 변수*/
    private String dataTimerSeq;
    private String dbBackupDay;
    private String dbBackupHour;



    // 댓글
    private String comSn;					// 댓글일련번호
    private String comCn;					// 댓글내용
    private String comCnt;					// 댓글갯수
    private String comAtchFileId;			// 댓글첨부파일ID
    private String comRegDt;				// 댓글등록일
    private String comRegDth;				// 댓글등록일시
    private String newComCnt;				// new코멘트갯수
    private String delAtchCnt;				// 삭제첨부파일갯수

    public String getBakTime() {
        return bakTime;
    }

    public void setBakTime(String bakTime) {
        this.bakTime = bakTime;
    }

    public String getErrCn() {
        return errCn;
    }

    public void setErrCn(String errCn) {
        this.errCn = errCn;
    }

    public String getAutoYn() {
        return autoYn;
    }

    public void setAutoYn(String autoYn) {
        this.autoYn = autoYn;
    }

    public String getBakPath() {
        return bakPath;
    }

    public void setBakPath(String bakPath) {
        this.bakPath = bakPath;
    }

    public String getBakVol() {
        return bakVol;
    }

    public void setBakVol(String bakVol) {
        this.bakVol = bakVol;
    }

    public String getDataTimerSeq() {
        return dataTimerSeq;
    }

    public void setDataTimerSeq(String dataTimerSeq) {
        this.dataTimerSeq = dataTimerSeq;
    }

    public String getDbBackupDay() {
        return dbBackupDay;
    }

    public void setDbBackupDay(String dbBackupDay) {
        this.dbBackupDay = dbBackupDay;
    }

    public String getDbBackupHour() {
        return dbBackupHour;
    }

    public void setDbBackupHour(String dbBackupHour) {
        this.dbBackupHour = dbBackupHour;
    }

    public String getBakYn() {
        return bakYn;
    }

    public void setBakYn(String bakYn) {
        this.bakYn = bakYn;
    }

    public String getBakSn() {
        return bakSn;
    }

    public void setBakSn(String bakSn) {
        this.bakSn = bakSn;
    }

    public String getBakNm() {
        return bakNm;
    }

    public void setBakNm(String bakNm) {
        this.bakNm = bakNm;
    }

    public String getBakCont() {
        return bakCont;
    }

    public void setBakCont(String bakCont) {
        this.bakCont = bakCont;
    }

    public String getAtchFileId() {
        return atchFileId;
    }

    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
    }

    public String getComSn() {
        return comSn;
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

    public String getBakGbn() {
        return bakGbn;
    }

    public void setBakGbn(String bakGbn) {
        this.bakGbn = bakGbn;
    }

    public String getBakGbnNm() {
        return bakGbnNm;
    }

    public void setBakGbnNm(String bakGbnNm) {
        this.bakGbnNm = bakGbnNm;
    }
}

