package kr.or.standard.basic.usersupport.user.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import java.util.List;

@Data
@ToString
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
    public interface updateCheck extends UserVO.amendCheck {}
    public interface deleteCheck {}

    @NotBlank(groups = {UserVO.insertCheck.class, UserVO.updateCheck.class, UserVO.deleteCheck.class})
    private String userId;

    @NotBlank(groups = {UserVO.insertCheck.class})
    private String userPswd;

    private String userKorNm;
    private String userEngNm;
    private String mobileNo;
    private String emailAddr;
    private String lstLoginDt;
    private String lstPswdChgDt;
    private String authAreaCd;
    private String snsSeCd;
    private String snsAccount;
    private String intgYn;
    private String zipNo;
    private String homeAddr;
    private String homeAddrDtls;
    private String blonNm;
    private String faxNo;
    private String inlnNo;
    private String jgrpCd;
    private String jrnkCd;
    private String regDivCd;
    private String useYn;
    private String pswdFailCnt;
    private String isDelAble;
    private String brkYn;
    private String brkComment;

    private String authId;
    private String authIdList;
    private String remoteAddr;
    private String loginDivCd;
    private String loginCommnet;

}
