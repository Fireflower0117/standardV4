package kr.or.opennote.basic.user.vo;

  
import kr.or.opennote.basic.common.domain.CmmnDefaultVO;
import kr.or.opennote.basic.term.vo.TermsVO.Terms;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import java.util.List;

@Alias("userVO")
public class UserVO extends CmmnDefaultVO {
	
	// 아이디 중복 체크
	public interface idCheck {}
	// 회원가입 유효성 체크
	public interface joinCheck {}
	// 회원정보 수정 유효성 체크
	public interface amendCheck {}
	// 비밀번호 재확인 유효성 체크
	public interface pswdReConfirmCheck {}
	// 사용자 등록,수정,삭제 유효성 체크
	public interface insertCheck {}
	public interface updateCheck extends amendCheck {}
	public interface deleteCheck {}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String userSerno;
	
	@NotBlank(message = "아이디 : 필수 입력입니다.", groups = {idCheck.class, joinCheck.class, amendCheck.class, insertCheck.class, pswdReConfirmCheck.class})
	private String userId;
	@NotBlank(message = "비밀번호 : 필수 입력입니다.", groups = {joinCheck.class, insertCheck.class, pswdReConfirmCheck.class})
	private String userPswd;
	@NotBlank(message = "이름 : 필수 입력입니다.", groups = {joinCheck.class, amendCheck.class, insertCheck.class})
	private String userNm;
	@NotBlank(message = "그룹 권한 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String grpAuthId;
	@NotBlank(message = "전화번호 : 필수 입력입니다.", groups = {joinCheck.class, amendCheck.class, insertCheck.class})
	private String userTelNo;
	@NotBlank(message = "이메일 : 필수 입력입니다.", groups = {joinCheck.class, amendCheck.class, insertCheck.class})
	private String userEmailAddr;
	private String pswdMsmtNocs;
	@NotBlank(message = "차단여부 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String brkYn;
	private String lstAcsDt;
	private String lstPswdChgDt;
	@NotBlank(message = "권한영역 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String authAreaCd;
	private String snsSeCd;
	private String snsUserId;
	private String snsEmail;
	private String intgYn;
	@NotBlank(message = "우편번호 : 필수 입력입니다.", groups = {joinCheck.class, amendCheck.class, insertCheck.class})
	private String postNo;
	@NotBlank(message = "주소 : 필수 입력입니다.", groups = {joinCheck.class, amendCheck.class, insertCheck.class})
	private String homeAddr;
	@NotBlank(message = "상세주소 : 필수 입력입니다.", groups = {joinCheck.class, amendCheck.class, insertCheck.class})
	private String homeAddrDtls;
	private String blonNm;
	private String faxNo;
	private String inlnNo;
	private String jrnkCd;
	private String useYn;
	private String grpAuthNm;	// 그룹권한명
	private String authAreaNm;	// 권한영역명
	private String lockYn;		// 잠금여부

	/* ip 관련 */
	private String ipSerno;	// ip 일련번호
	private String strtIp;	// 시작 IP
	private String endIp;	// 종료 IP
	private String bawdYn;	// 대역폭 여부
	private String seqo;	// 순서
	private String strtIp1;	// 시작 IP 1
	private String strtIp2;	// 시작 IP 2
	private String strtIp3;	// 시작 IP 3
	private String strtIp4;	// 시작 IP 4
	private String endIp1;	// 종료 IP 1
	private String endIp2;	// 종료 IP 2
	private String endIp3;	// 종료 IP 3
	private String endIp4;	// 종료 IP 4

	private List<UserVO> ipList;	// IP리스트
	
	/* 회원가입 관련 */
	private List<Terms> termsList;	// 약관 목록

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
	public String getPswdMsmtNocs() {
		return pswdMsmtNocs;
	}
	public void setPswdMsmtNocs(String pswdMsmtNocs) {
		this.pswdMsmtNocs = pswdMsmtNocs;
	}
	public String getBrkYn() {
		return brkYn;
	}
	public void setBrkYn(String brkYn) {
		this.brkYn = brkYn;
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
	public String getAuthAreaCd() {
		return authAreaCd;
	}
	public void setAuthAreaCd(String authAreaCd) {
		this.authAreaCd = authAreaCd;
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
	public String getIntgYn() {
		return intgYn;
	}
	public void setIntgYn(String intgYn) {
		this.intgYn = intgYn;
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
	public String getBlonNm() {
		return blonNm;
	}
	public void setBlonNm(String blonNm) {
		this.blonNm = blonNm;
	}
	public String getFaxNo() {
		return faxNo;
	}
	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}
	public String getInlnNo() {
		return inlnNo;
	}
	public void setInlnNo(String inlnNo) {
		this.inlnNo = inlnNo;
	}
	public String getJrnkCd() {
		return jrnkCd;
	}
	public void setJrnkCd(String jrnkCd) {
		this.jrnkCd = jrnkCd;
	}
	public String getGrpAuthNm() {
		return grpAuthNm;
	}
	public void setGrpAuthNm(String grpAuthNm) {
		this.grpAuthNm = grpAuthNm;
	}
	public String getLockYn() {
		return lockYn;
	}
	public void setLockYn(String lockYn) {
		this.lockYn = lockYn;
	}
	public String getAuthAreaNm() {
		return authAreaNm;
	}
	public void setAuthAreaNm(String authAreaNm) {
		this.authAreaNm = authAreaNm;
	}

	public String getIpSerno() {
		return ipSerno;
	}

	public void setIpSerno(String ipSerno) {
		this.ipSerno = ipSerno;
	}

	public String getStrtIp() {
		return strtIp;
	}

	public void setStrtIp(String strtIp) {
		this.strtIp = strtIp;
	}

	public String getEndIp() {
		return endIp;
	}

	public void setEndIp(String endIp) {
		this.endIp = endIp;
	}

	public String getBawdYn() {
		return bawdYn;
	}

	public void setBawdYn(String bawdYn) {
		this.bawdYn = bawdYn;
	}

	public String getSeqo() {
		return seqo;
	}

	public void setSeqo(String seqo) {
		this.seqo = seqo;
	}

	public String getStrtIp1() {
		return strtIp1;
	}

	public void setStrtIp1(String strtIp1) {
		this.strtIp1 = strtIp1;
	}

	public String getStrtIp2() {
		return strtIp2;
	}

	public void setStrtIp2(String strtIp2) {
		this.strtIp2 = strtIp2;
	}

	public String getStrtIp3() {
		return strtIp3;
	}

	public void setStrtIp3(String strtIp3) {
		this.strtIp3 = strtIp3;
	}

	public String getStrtIp4() {
		return strtIp4;
	}

	public void setStrtIp4(String strtIp4) {
		this.strtIp4 = strtIp4;
	}

	public String getEndIp1() {
		return endIp1;
	}

	public void setEndIp1(String endIp1) {
		this.endIp1 = endIp1;
	}

	public String getEndIp2() {
		return endIp2;
	}

	public void setEndIp2(String endIp2) {
		this.endIp2 = endIp2;
	}

	public String getEndIp3() {
		return endIp3;
	}

	public void setEndIp3(String endIp3) {
		this.endIp3 = endIp3;
	}

	public String getEndIp4() {
		return endIp4;
	}

	public void setEndIp4(String endIp4) {
		this.endIp4 = endIp4;
	}

	public List<UserVO> getIpList() {
		return ipList;
	}

	public void setIpList(List<UserVO> ipList) {
		this.ipList = ipList;
	}
	public List<Terms> getTermsList() {
		return termsList;
	}
	public void setTermsList(List<Terms> termsList) {
		this.termsList = termsList;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
}
