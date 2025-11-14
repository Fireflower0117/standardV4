package kr.or.standard.itsm.common.vo;

import org.apache.ibatis.type.Alias;

@Alias("itsmSessionVO")
public class ItsmSessionVO {

    private String userSerno;
    private String userId;
    private String userPswd;
    private String userNm;
    private String grpAuthId;
    private String authAreaCd;
    private String userTelNo;
    private String userEmailAddr;
    private String brkYn;			// 차단여부
    private String pswdMsmtNocs;	// 비밀번호 불일치 건수
    private String lstAcsDt;		// 최종 접속 일시
    private String lstPswdChgDt;	// 최종비밀번호변경일시
    private String pswdChgDt;		// 비밀번호변경일
    private String saveIdYn;		// 아이디저장 여부
    private String postNo;
    private String homeAddr;
    private String homeAddrDtls;
    private String svcNm; // 서비스명
    private String svcSn; // 서비스 일련번호
    private String userSvcSn; // 서비스 일련번호
    private String excelYn; // 쿼리에서, 엑셀 다운용 쿼리인지 여부

    public String getSvcNm() {
        return svcNm;
    }

    public void setSvcNm(String svcNm) {
        this.svcNm = svcNm;
    }

    public String getSvcSn() {
        return svcSn;
    }

    public void setSvcSn(String svcSn) {
        this.svcSn = svcSn;
    }

    public String getExcelYn() {
        return excelYn;
    }

    public void setExcelYn(String excelYn) {
        this.excelYn = excelYn;
    }

    public String getUserSerno() {
        return userSerno;
    }

    public void setUserSerno(String userSerno) {
        this.userSerno = userSerno;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserPswd() {
        return userPswd;
    }

    public void setUserPswd(String userPswd) {
        this.userPswd = userPswd;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getGrpAuthId() {
        return grpAuthId;
    }

    public void setGrpAuthId(String grpAuthId) {
        this.grpAuthId = grpAuthId;
    }

    public String getAuthAreaCd() {
        return authAreaCd;
    }

    public void setAuthAreaCd(String authAreaCd) {
        this.authAreaCd = authAreaCd;
    }

    public String getUserTelNo() {
        return userTelNo;
    }

    public void setUserTelNo(String userTelNo) {
        this.userTelNo = userTelNo;
    }

    public String getUserEmailAddr() {
        return userEmailAddr;
    }

    public void setUserEmailAddr(String userEmailAddr) {
        this.userEmailAddr = userEmailAddr;
    }

    public String getBrkYn() {
        return brkYn;
    }

    public void setBrkYn(String brkYn) {
        this.brkYn = brkYn;
    }

    public String getPswdMsmtNocs() {
        return pswdMsmtNocs;
    }

    public void setPswdMsmtNocs(String pswdMsmtNocs) {
        this.pswdMsmtNocs = pswdMsmtNocs;
    }

    public String getLstAcsDt() {
        return lstAcsDt;
    }

    public void setLstAcsDt(String lstAcsDt) {
        this.lstAcsDt = lstAcsDt;
    }

    public String getLstPswdChgDt() {
        return lstPswdChgDt;
    }

    public void setLstPswdChgDt(String lstPswdChgDt) {
        this.lstPswdChgDt = lstPswdChgDt;
    }

    public String getPswdChgDt() {
        return pswdChgDt;
    }

    public void setPswdChgDt(String pswdChgDt) {
        this.pswdChgDt = pswdChgDt;
    }

    public String getSaveIdYn() {
        return saveIdYn;
    }

    public void setSaveIdYn(String saveIdYn) {
        this.saveIdYn = saveIdYn;
    }

    public String getPostNo() {
        return postNo;
    }

    public void setPostNo(String postNo) {
        this.postNo = postNo;
    }

    public String getHomeAddr() {
        return homeAddr;
    }

    public void setHomeAddr(String homeAddr) {
        this.homeAddr = homeAddr;
    }

    public String getHomeAddrDtls() {
        return homeAddrDtls;
    }

    public void setHomeAddrDtls(String homeAddrDtls) {
        this.homeAddrDtls = homeAddrDtls;
    }

    public String getUserSvcSn() {
        return userSvcSn;
    }

    public void setUserSvcSn(String userSvcSn) {
        this.userSvcSn = userSvcSn;
    }
}
