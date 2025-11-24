package kr.or.standard.basic.usersupport.dictionary.domain.vo;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 

import javax.validation.constraints.NotBlank;

@Data
@Alias("cmDmnVO")
public class DomainVO  extends CmmnDefaultVO {

    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    @NotBlank(groups = {updateCheck.class, deleteCheck.class})
    private String dmnSerno;        // 도메인일련번호
    @NotBlank(message = "도메인명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String dmnNm;           // 도메인명
    @NotBlank(message = "도메인영문명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String dmnEngNm;        // 도메인영문명
    @NotBlank(message = "도메인그룹 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String dmnGrp;          // 도메인그룹
    @NotBlank(message = "논리데이터타입 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String lgclDataTp;      // 논리데이터타입
    @NotBlank(message = "길이 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String dataLen;         // 길이
    private String dataLenDcpt;     // 길이(소수점)
    private String cgCd;            // 분류어
    @NotBlank(message = "도메인설명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String dmnExpl;         // 도메인설명
    private String cdTp;            // 코드유형
    private String cdDtlsTp;        // 코드상세유형
    private String uppoDmnNm;       // 상위도메인명
    private String lwpoDmnNm;       // 하위도메인명
    private String echCdSchm;       // 개별코드스키마
    private String echCdTbl;        // 개별코드테이블
    private String dmnTp;           // 도메인유형
    private String sysNm;           // 시스템명
    private String pinfYn;          // 개인정보여부
    private String encYn;           // 암호화여부
    private String regrSerno;       // 등록자일련번호
    private String regrNm;          // 등록자명
    private String regDt;           // 등록일시
    private String updrSerno;       // 수정자일련번호
    private String updrNm;          // 수정자명
    private String updDt;           // 수정일시
    private String useYn;           // 사용여부
    private String dmnCount;        // 사용여부
 
}
