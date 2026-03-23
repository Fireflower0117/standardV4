package kr.or.standard.basic.example.domain.basictab;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("insptHistVo")
public class InsptHistVo extends CmmnDefaultVO {

    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String rowDataDiv;  // Data출처 및 상태 구분
    private String chkHist;  // 체크박스 선택여부
    private String hisYear;  // 검사 연도
    private String hisType;  // 검사 종류
    private String histSummary;  // 검사 결과 요약
    private String hisInspector;  // 담당 검사관

}
