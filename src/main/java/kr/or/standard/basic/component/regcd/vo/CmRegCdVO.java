package kr.or.standard.basic.component.regcd.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 

import javax.validation.constraints.NotBlank;

@Data
@Alias("cmRegCdVO")
public class CmRegCdVO extends CmmnDefaultVO {
    
    public interface insertCheck {}
    @NotBlank(message = "법정동코드명을 입력해주세요", groups = CmRegCdVO.insertCheck.class)
    private String regCd;      // REG_CD        법정동코드
    @NotBlank(message = "주소를 입력해주세요", groups = CmRegCdVO.insertCheck.class)
    private String addr;        // ADDR       주소
    private String sidoNm;     // SIDO_NM       시도명
    private String cggNm;      // CGG_NM        시군구명
    private String umdNm;      // UMD_NM        읍면동명
    private String riNm;       // RI_NM         리명
    private String lvl;        // LVL           레벨
    
    private String rnko;       // RNKO          서열
    private String creYmd;     // CRE_YMD       생성일
    private String updYm;      // UPD_YM        갱신년월
    private String regrSerno;  // REGR_SERNO    등록자 일련번호
    private String regrSerNm;  // REGR_SERNO    등록자 명
    private String regDt;      // REG_DT        등록일시
    private String useYn;      // USE_YN        사용여부
    private String regCdCnt;   //               행정코드개수

    private String lwposAreaNm;      // LWPOS_AREA_NM        최하위 지역명

    private String sidoCd;
    private String cggCd;
    private String umdCd;
    private String riCd;

    private String schSido;
    private String schCgg;
    private String schUmd;
    private String schRi;

    private String sort;
    private String def;
    private String sel;

    
}
