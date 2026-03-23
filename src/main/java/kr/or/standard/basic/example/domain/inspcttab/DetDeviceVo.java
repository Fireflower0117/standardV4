package kr.or.standard.basic.example.domain.inspcttab;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("detDeviceVo")
public class DetDeviceVo extends CmmnDefaultVO {

    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String rowDataDiv;    // Data출처 및 상태 구분
    private String chkDevice;     // 체크박스 선택값
    private String devType;       // 장치구분
    private String devModelNm;    // 모델명
    private String devSerialNo;   // 제조 번호
    private String devInstallDt;  // 설치일자
    private String devStatus;     // 성능판정
}
