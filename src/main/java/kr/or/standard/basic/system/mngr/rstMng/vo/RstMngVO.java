package kr.or.standard.basic.system.mngr.rstMng.vo;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
 

import javax.validation.constraints.NotBlank;

@Alias("rstMngVO")
public class RstMngVO extends CmmnDefaultVO {
	
	public interface insertCheck {}

	@NotBlank(message = "아이디 : 필수 입력입니다.", groups = {insertCheck.class})
	private String userId;	// 사용자 아이디
	private String brkYn;	// 제한여부 
	private String userSerno;	// 제한여부
	private String userIdCount;	// 제한여부

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBrkYn() {
		return brkYn;
	}

	public void setBrkYn(String brkYn) {
		this.brkYn = brkYn;
	}

	public String getUserSerno() {
		return userSerno;
	}

	public void setUserSerno(String userSerno) {
		this.userSerno = userSerno;
	}

	public String getUserIdCount() { return userIdCount; }

	public void setUserIdCount(String userIdCount) { this.userIdCount = userIdCount; }
}
