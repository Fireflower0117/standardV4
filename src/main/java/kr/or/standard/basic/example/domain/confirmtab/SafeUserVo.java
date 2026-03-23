package kr.or.standard.basic.example.domain.confirmtab;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("safeUserVo")
public class SafeUserVo extends CmmnDefaultVO {
    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String rowDataDiv;     // Data출처 및 상태 구분 
    private String chkSafeUserId;  // 체크박스 선택여부
    private String opNm;           // 성명
    private String opAppointDt;    // 선임일자
    private String opCertType;     // 자격종목
    private String opCertNo;       // 자격번호
    private String safeCertFile;   // 자격증 사본

    
}
