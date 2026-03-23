package kr.or.standard.basic.example.domain.confirmtab;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Data
@Alias("inspectionReportConfirmVo")
public class InspectionReportConfirmVo extends CmmnDefaultVO {
    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String emfTargetYn;             // 전자파 측정대상
    private String chkFence;                // 안전시설 >> 보호펜스
    private String chkSign;                 // 안전시설 >> 경고표지판
    private String chkCctv;                 // 안전시설 >> CCTV
    private String addNote;                 // 특기사항
    private List<SafeUserVo> safeAdminList; // 무선종사자 및 안전관리자 현황
    private String fileSafetyImgId;         // 추가증빙 서류 및 사진 (파일그룹ID)
    private String fileMeasureDocId;        // 전자파강도 성능 측정 결과서 (파일그룹ID)


}
