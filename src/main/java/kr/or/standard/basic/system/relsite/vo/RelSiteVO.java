package kr.or.standard.basic.system.relsite.vo;

 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Alias("relSiteVO")
public class RelSiteVO extends CmmnDefaultVO {

    public interface insertCheck {}

    public interface updateCheck {}

    // 관련사이트 리스트
    @NotEmpty(groups = {insertCheck.class, updateCheck.class})
    private List<@Valid RelSite> relSiteList;

    public static class RelSite {
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

        private String loginSerno;

        public String getLoginSerno() {
            return loginSerno;
        }

        public void setLoginSerno(String loginSerno) {
            this.loginSerno = loginSerno;
        }

        public String getRelSiteSerno() {
            return relSiteSerno;
        }

        public void setRelSiteSerno(String relSiteSerno) {
            this.relSiteSerno = relSiteSerno;
        }

        public String getRelSiteUrlAddr() {
            return relSiteUrlAddr;
        }

        public void setRelSiteUrlAddr(String relSiteUrlAddr) {
            this.relSiteUrlAddr = relSiteUrlAddr;
        }

        public String getRelSiteNm() {
            return relSiteNm;
        }

        public void setRelSiteNm(String relSiteNm) {
            this.relSiteNm = relSiteNm;
        }

        public String getAtflSerno() {
            return atflSerno;
        }

        public void setAtflSerno(String atflSerno) {
            this.atflSerno = atflSerno;
        }

        public String getSeqo() {
            return seqo;
        }

        public void setSeqo(String seqo) {
            this.seqo = seqo;
        }

        public String getUseYn() {
            return useYn;
        }

        public void setUseYn(String useYn) {
            this.useYn = useYn;
        }

        public String getRegrSerno() {
            return regrSerno;
        }

        public void setRegrSerno(String regrSerno) {
            this.regrSerno = regrSerno;
        }

        public String getRegDt() {
            return regDt;
        }

        public void setRegDt(String regDt) {
            this.regDt = regDt;
        }

        public String getUpdrSerno() {
            return updrSerno;
        }

        public void setUpdrSerno(String updrSerno) {
            this.updrSerno = updrSerno;
        }

        public String getUpdDt() {
            return updDt;
        }

        public void setUpdDt(String updDt) {
            this.updDt = updDt;
        }

    }

    public List<RelSite> getRelSiteList() {
        return relSiteList;
    }

    public void setRelSiteList(List<RelSite> relSiteList) {
        this.relSiteList = relSiteList;
    }

}
