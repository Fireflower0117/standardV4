package kr.or.standard.basic.usersupport.dictionary.term.vo;

 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
@Alias("cmTermVO")
public class CmTermVO extends CmmnDefaultVO {

    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    @NotBlank(groups = {updateCheck.class, deleteCheck.class})
    private String termSerno;       // 용어일련번호
    @NotBlank(message = "용어명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    @Size(max = 30, message = "용어명은 30자 이하여야 합니다.", groups = {updateCheck.class, insertCheck.class})
    private String termNm;          // 용어명
    @NotBlank(message = "용어영문명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    @Size(max = 30, message = "용어영문명은 30자 이하여야 합니다.", groups = {updateCheck.class, insertCheck.class})
    private String termEngNm;       // 용어영문명
    @NotBlank(message = "도메인명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    @Size(max = 20, message = "도메인명은 20자 이하여야 합니다.", groups = {updateCheck.class, insertCheck.class})
    private String dmnNm;           // 도메인명
    private String stdYn;           // 표준여부
    @NotBlank(message = "용어설명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    @Size(max = 1000, message = "용어설명은 1000자 이하여야 합니다.", groups = {updateCheck.class, insertCheck.class})
    private String termExpl;        // 용어설명
    private String pinfYn;          // 개인정보여부
    private String encYn;           // 암호화여부
    @NotBlank(message = "도메인그룹 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String dmnGrp;          // 도메인그룹
    @NotBlank(message = "데이터타입 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String dataTp;          // 데이터타입
    @NotBlank(message = "길이 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    @Size(max = 5, message = "데이터길이는 5자 이하여야 합니다.", groups = {updateCheck.class, insertCheck.class})
    private String dataLen;         // 길이
    @Size(max = 5, message = "데이터길이(소수점)는 5자 이하여야 합니다.", groups = {updateCheck.class, insertCheck.class})
    private String dataLenDcpt;     // 길이(소수점)
    private String regrSerno;       // 등록자일련번호
    private String regrNm;          // 등록자명
    private String regDt;           // 등록일시
    private String updrSerno;       // 수정자일련번호
    private String updrNm;          // 수정자명
    private String updDt;           // 수정일시
    private String useYn;           // 사용여부
    private String termCount;       // 용어갯수

    private String atchFileId;      // 파일 ID
}
