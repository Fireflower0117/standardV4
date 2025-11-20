package kr.or.standard.basic.usersupport.user.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

@Alias("userIpVO")
public class UserIpVO extends CmmnDefaultVO {
	
	private String ipSerno;
	private String userSerno;
	private String strtIp;
	private String endIp;
	private String bawdYn;
	private String seqo;
	private int ipBrkYn;
	
	public String getIpSerno() {
		return ipSerno;
	}
	public void setIpSerno(String ipSerno) {
		this.ipSerno = ipSerno;
	}
	public String getUserSerno() {
		return userSerno;
	}
	public void setUserSerno(String userSerno) {
		this.userSerno = userSerno;
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

	public int getIpBrkYn() {
		return ipBrkYn;
	}

	public void setIpBrkYn(int ipBrkYn) {
		this.ipBrkYn = ipBrkYn;
	}

	@Override
	public String toString() {
		return "UserIpVO{" +
				"ipSerno='" + ipSerno + '\'' +
				", userSerno='" + userSerno + '\'' +
				", strtIp='" + strtIp + '\'' +
				", endIp='" + endIp + '\'' +
				", bawdYn='" + bawdYn + '\'' +
				", seqo='" + seqo + '\'' +
				", ipBrkYn='" + ipBrkYn + '\'' +
				'}';
	}
}

