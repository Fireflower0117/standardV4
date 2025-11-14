package kr.or.standard.basic.login.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
 
@Alias("loginVO")
public class LoginVO extends CmmnDefaultVO {
	
	// 로그인 유효성 체크
	public interface loginCheck {}
	// 비밀번호변경 유효성 체크
	public interface pswdUpdateCheck {}
	// 최종 비밀번호 변경일 갱신 유효성 체크
	public interface lstPswdChgDtUpdateCheck {}
	// 아이디 찾기 유효성 체크
	public interface findIdCheck {}
	// 비밀번호 찾기 유효성 체크
	public interface findPswdCheck {}
	// 아이디/비밀번호 인증키 유효성 체크
	public interface emailKeyCheck {}
	// 비밀번호찾기 후 변경 유효성 체크
	public interface pswdReWriteCheck {}
		
	private String userSerno;
	
	@NotBlank(message = "아이디 : 필수 입력입니다.", groups = {loginCheck.class, pswdUpdateCheck.class, lstPswdChgDtUpdateCheck.class, findPswdCheck.class, pswdReWriteCheck.class})
	private String userId;
	private String userSabun;
	
	@NotBlank(message = "비밀번호 : 필수 입력입니다.", groups = {loginCheck.class, pswdUpdateCheck.class, pswdReWriteCheck.class})
	private String userPswd;
	
	@NotBlank(message = "이름 : 필수 입력입니다.", groups = {findIdCheck.class, findPswdCheck.class})
	private String userNm;
	private String grpAuthId;
	private String authAreaCd;
	@NotBlank(message = "휴대전화번호 : 필수 입력입니다.", groups = {findIdCheck.class, findPswdCheck.class})
	private String userTelNo;
	@NotBlank(message = "이메일 : 필수 입력입니다.", groups = {findIdCheck.class, findPswdCheck.class})
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
	
	private String snsSeCd;
	private String snsUserId;
	private String snsEmail;
	
	@NotBlank(message = "이전 비밀번호 : 필수 입력입니다.", groups = pswdUpdateCheck.class)
	private String beforeUserPswd;
	
	@NotBlank(message = "인증번호 : 필수 입력입니다.", groups = emailKeyCheck.class)
	private String emailKey;		// 이메일 인증키

	private String menuSeCd; 		// 메뉴 구분 코드
	
	public LoginVO() {
		super();
	}

	public LoginVO(String userId, String userPswd) {
		this.userId = userId;
        this.userPswd = userPswd;
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

	public String getUserSabun() {
		return userSabun;
	}

	public void setUserSabun(String userSabun) {
		this.userSabun = userSabun;
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

	public String getSnsSeCd() {
		return snsSeCd;
	}

	public void setSnsSeCd(String snsSeCd) {
		this.snsSeCd = snsSeCd;
	}

	public String getSnsUserId() {
		return snsUserId;
	}

	public void setSnsUserId(String snsUserId) {
		this.snsUserId = snsUserId;
	}

	public String getSnsEmail() {
		return snsEmail;
	}

	public void setSnsEmail(String snsEmail) {
		this.snsEmail = snsEmail;
	}

	public String getBeforeUserPswd() {
		return beforeUserPswd;
	}

	public void setBeforeUserPswd(String beforeUserPswd) {
		this.beforeUserPswd = beforeUserPswd;
	}

	public String getEmailKey() {
		return emailKey;
	}

	public void setEmailKey(String emailKey) {
		this.emailKey = emailKey;
	}

	public String getMenuSeCd() {
		return menuSeCd;
	}

	public void setMenuSeCd(String menuSeCd) {
		this.menuSeCd = menuSeCd;
	}

	@Override
	public String toString() {
		return "LoginVO{" +
				"userSerno='" + userSerno + '\'' +
				", userId='" + userId + '\'' +
				", userSabun='" + userSabun + '\'' +
				", userPswd='" + userPswd + '\'' +
				", userNm='" + userNm + '\'' +
				", grpAuthId='" + grpAuthId + '\'' +
				", authAreaCd='" + authAreaCd + '\'' +
				", userTelNo='" + userTelNo + '\'' +
				", userEmailAddr='" + userEmailAddr + '\'' +
				", brkYn='" + brkYn + '\'' +
				", pswdMsmtNocs='" + pswdMsmtNocs + '\'' +
				", lstAcsDt='" + lstAcsDt + '\'' +
				", lstPswdChgDt='" + lstPswdChgDt + '\'' +
				", pswdChgDt='" + pswdChgDt + '\'' +
				", saveIdYn='" + saveIdYn + '\'' +
				", postNo='" + postNo + '\'' +
				", homeAddr='" + homeAddr + '\'' +
				", homeAddrDtls='" + homeAddrDtls + '\'' +
				", snsSeCd='" + snsSeCd + '\'' +
				", snsUserId='" + snsUserId + '\'' +
				", snsEmail='" + snsEmail + '\'' +
				", beforeUserPswd='" + beforeUserPswd + '\'' +
				", emailKey='" + emailKey + '\'' +
				", menuSeCd='" + menuSeCd + '\'' +
				'}';
	}
}

