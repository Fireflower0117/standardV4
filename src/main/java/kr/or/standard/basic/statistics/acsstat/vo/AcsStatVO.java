package kr.or.standard.basic.statistics.acsstat.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 
@Data
@Alias("acsStatVO")
public class AcsStatVO extends CmmnDefaultVO {
        
    private String menuLogSerno;                // 메뉴로그일련번호
    private String menuUrlAddr;                 // 메뉴URL주소
    private String acsIpAddr;                   // 접속IP주소
    private String menuCd;                      // 메뉴코드
    private String regrSerno;                   // 등록자일련번호
    private String regDt;                       // 등록일시
    private String userCount;                   // 가입자수
}
