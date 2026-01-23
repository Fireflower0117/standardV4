package kr.or.standard.basic.usersupport.lginPlcy.vo;

import javax.validation.constraints.NotBlank;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("lginPlcyVO")
public class LginPlcyVO extends CmmnDefaultVO {
	
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String lginPlcySerno;
	private String pwdChgCyclDd;		// 비밀번호변경주기일
	
	@NotBlank(message = "비밀번호변경주기 사용여부 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String pwdChgCyclUseYn;		// 비밀번호변경주기 사용여부
	
	@NotBlank(message = "탈퇴정보보유기간 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String scssAccPssnPrdCd;	// 탈퇴계정보유기간코드
	private String lginLmtCnt;			// 로그인제한횟수
	
	@NotBlank(message = "로그인횟수제한 사용여부 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String lginLmtUseYn;		// 로그인제한 사용여부
	
	@NotBlank(message = "기본권한 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String bascAuthId;
	
	@NotBlank(message = "회원기본권한 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String mbrsBascGrpAuthId;
	
	private String regepsId;
	private String regepsPswd;
	private String regepsEmail;
	private String regepsPhone;
	private String scssAccPssnPrdNm;	// 탈퇴계정보유기간명
	private String plcyCount;	// 로그인 정책수


}
