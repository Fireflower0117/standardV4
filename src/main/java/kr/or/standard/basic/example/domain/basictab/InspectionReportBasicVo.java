package kr.or.standard.basic.example.domain.basictab;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Data
@Alias("inspectionReportBasicVo")
public class InspectionReportBasicVo extends CmmnDefaultVO {

    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String stationNm;        // 무선국
    private String permitNo;         // 허가번호
    private String inspctReqDt;      // 검사신청일
    private String inspectType;      // 검사 종류
    private String totalEvalResult;  // 종합평가판정
    private String totalRmk;         // 종합의견
    private List<InsptHistVo> insptHistList ;  // 과거심의 및 검사이력 목록
    private String baseDocFilesId;   // 기본서류 첨부 파일그룹ID

}
