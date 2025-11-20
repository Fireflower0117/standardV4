package kr.or.standard.basic.usersupport.relsite.vo;
 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Data
@Alias("relSiteVO")
public class RelSiteVO extends CmmnDefaultVO {
    
    public interface insertCheck {} 
    public interface updateCheck {}

    // 관련사이트 리스트
    @NotEmpty(groups = {insertCheck.class, updateCheck.class})
    private List<@Valid RelSite> relSiteList;
    
    @Data
    public static class RelSite  extends CmmnDefaultVO {
        private String relSiteSerno;
        @NotBlank(message = "URL주소 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
        private String relSiteUrlAddr;
        @NotBlank(message = "사이트명 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
        private String relSiteNm;
        private String atflSerno;
        private String seqo;
        private String useYn;
        private String regrSerno;
        private String regDt;
        private String updrSerno;
        private String updDt;  
    }
}
