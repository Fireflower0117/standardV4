package kr.or.standard.basic.example.domain.inspcttab;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.example.domain.basictab.InsptHistVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Data
@Alias("inspectionReportInspctVo")
public class InspectionReportInspctVo extends CmmnDefaultVO {
    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String specMatchYn;        // 기기제원일치여부
    private String antMatchYn;         // 안테나계통 일치여부
    private String mainUseBolt;        // 주사용전압
    private String inspEquipCngDt;     // 측정장비 교정일자
    private List<DetDeviceVo> detDeviceList ;  // 과거심의 및 검사이력 목록

}
