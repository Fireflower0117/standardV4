package kr.or.standard.basic.login.vo;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@ToString
@Data
@Alias("systemPolicyVO")
public class SystemPolicyVO extends CmmnDefaultVO {

    private String pwdEncAlgorithm;
    private String pwdChgCycleUseYn;
    private String pwdChgCyclDd;
    private String lginLmtUseYn;
    private String lginFailLmtCnt;
    private String itsmUseYn;
    private String baseAuthId;
    private String pwssPrdCd;
    private String atchFileSaveDiv;
    private String atchFilePath;
    private String maDirectPage;
    private String ftDirectPage;
    private String AtchFilePath;

}
