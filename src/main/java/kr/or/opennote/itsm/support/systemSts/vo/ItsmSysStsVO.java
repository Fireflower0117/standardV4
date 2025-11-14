package kr.or.opennote.itsm.support.systemSts.vo;

 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("itsmSysStsVO")
public class ItsmSysStsVO extends ItsmCommonDefaultVO {
    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    private String chgSn;       /** 서비스변경이력 일련번호 */
    private String chgTtl;      /** 요청제목 */
    private String chgCn;      /** 처리내용 */
    private String jobCd;       /** 업무분류구분코드 */
    private String jobNm;       /** 업무분류구분명 */
    private String dmndCnSn;       /** 요청 항목 일련번호 */
    private String imprvSn;       /** 요청 항목 일련번호 */

    private String cnt;

    private List<ItsmSysStsVO> dmndArr;

    public String getCnt() {
        return cnt;
    }

    public void setCnt(String cnt) {
        this.cnt = cnt;
    }

    public String getDmndCnSn() {
        return dmndCnSn;
    }

    public void setDmndCnSn(String dmndCnSn) {
        this.dmndCnSn = dmndCnSn;
    }

    public String getImprvSn() {
        return imprvSn;
    }

    public void setImprvSn(String imprvSn) {
        this.imprvSn = imprvSn;
    }

    public String getChgSn() {
        return chgSn;
    }

    public void setChgSn(String chgSn) {
        this.chgSn = chgSn;
    }

    public String getChgTtl() {
        return chgTtl;
    }

    public void setChgTtl(String chgTtl) {
        this.chgTtl = chgTtl;
    }

    public String getChgCn() {
        return chgCn;
    }

    public void setChgCn(String chgCn) {
        this.chgCn = chgCn;
    }

    public String getJobCd() {
        return jobCd;
    }

    public void setJobCd(String jobCd) {
        this.jobCd = jobCd;
    }

    public String getJobNm() {
        return jobNm;
    }

    public void setJobNm(String jobNm) {
        this.jobNm = jobNm;
    }

    public List<ItsmSysStsVO> getDmndArr() {
        return dmndArr;
    }

    public void setDmndArr(List<ItsmSysStsVO> dmndArr) {
        this.dmndArr = dmndArr;
    }
}
