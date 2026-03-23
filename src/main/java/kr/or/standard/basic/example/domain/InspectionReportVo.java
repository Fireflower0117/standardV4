package kr.or.standard.basic.example.domain;

import kr.or.standard.basic.board.vo.BoardVO;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.example.domain.basictab.InspectionReportBasicVo;
import kr.or.standard.basic.example.domain.confirmtab.InspectionReportConfirmVo;
import kr.or.standard.basic.example.domain.inspcttab.InspectionReportInspctVo;
import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.List;

@Data
@ToString
@Alias("inspectionReportVo")
public class InspectionReportVo extends CmmnDefaultVO {
    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String inspReportSerno; // 접수번호
    private String schStationDiv;   // 무선국분류
    private String inspctDt;        // 검사일자

    @Valid
    private InspectionReportBasicVo basicVo;

    @Valid
    private InspectionReportInspctVo inspctVo;

    @Valid
    private InspectionReportConfirmVo confirmVo;




}
