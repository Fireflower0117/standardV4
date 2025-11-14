package kr.or.standard.itsm.sla.slaReport.vo;
  
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import kr.or.standard.itsm.sla.slaDef.vo.ItsmSlaDefVO;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("itsmSlaRptVO")
public class ItsmSlaReportVO extends ItsmCommonDefaultVO {

    private String scrngSn;             /** 항목별 배점 일련번호 */
    private String svrngSubSn;          /** 항목별 배점 일련번호 서브 일련번호 */
    private String itmCn;               /** 항목 내용 */
    private String itmScrng;            /** 항목별 배점 */
    private String idxiSeCd;            /** 지표구분코드 */
    private String idxiSeNm;            /** 지표구분코드명 */
    private String bgngYm;              /** 시작년월 */
    private String itmSeqo;             /** 항목순서 */
    private String msrmtCnt;            /** 측정건수 */
    private String msrmtTrgtCnt;        /** 측정대상건수 */
    private String searchbgngYm;

    private String rptdSn;             /** 보고서 일련번호 */
    private String rptdTtl;            /** 보고서 제목 */
    private String bgngDt;             /** 시작일 */
    private String endDt;              /** 종료일 */
    private String crtDate;

    private List<ItsmSlaDefVO> itmList;

    public String getCrtDate() {
        return crtDate;
    }

    public void setCrtDate(String crtDate) {
        this.crtDate = crtDate;
    }

    public String getBgngDt() {
        return bgngDt;
    }

    public void setBgngDt(String bgngDt) {
        this.bgngDt = bgngDt;
    }

    public String getEndDt() {
        return endDt;
    }

    public void setEndDt(String endDt) {
        this.endDt = endDt;
    }

    public String getScrngSn() {
        return scrngSn;
    }

    public void setScrngSn(String scrngSn) {
        this.scrngSn = scrngSn;
    }

    public String getSvrngSubSn() {
        return svrngSubSn;
    }

    public void setSvrngSubSn(String svrngSubSn) {
        this.svrngSubSn = svrngSubSn;
    }

    public String getItmCn() {
        return itmCn;
    }

    public void setItmCn(String itmCn) {
        this.itmCn = itmCn;
    }

    public String getItmScrng() {
        return itmScrng;
    }

    public void setItmScrng(String itmScrng) {
        this.itmScrng = itmScrng;
    }

    public String getIdxiSeCd() {
        return idxiSeCd;
    }

    public void setIdxiSeCd(String idxiSeCd) {
        this.idxiSeCd = idxiSeCd;
    }

    public String getIdxiSeNm() {
        return idxiSeNm;
    }

    public void setIdxiSeNm(String idxiSeNm) {
        this.idxiSeNm = idxiSeNm;
    }

    public String getBgngYm() {
        return bgngYm;
    }

    public void setBgngYm(String bgngYm) {
        this.bgngYm = bgngYm;
    }

    public String getItmSeqo() {
        return itmSeqo;
    }

    public void setItmSeqo(String itmSeqo) {
        this.itmSeqo = itmSeqo;
    }

    public String getMsrmtCnt() {
        return msrmtCnt;
    }

    public void setMsrmtCnt(String msrmtCnt) {
        this.msrmtCnt = msrmtCnt;
    }

    public String getMsrmtTrgtCnt() {
        return msrmtTrgtCnt;
    }

    public void setMsrmtTrgtCnt(String msrmtTrgtCnt) {
        this.msrmtTrgtCnt = msrmtTrgtCnt;
    }

    public String getSearchbgngYm() {
        return searchbgngYm;
    }

    public void setSearchbgngYm(String searchbgngYm) {
        this.searchbgngYm = searchbgngYm;
    }

    public String getRptdSn() {
        return rptdSn;
    }

    public void setRptdSn(String rptdSn) {
        this.rptdSn = rptdSn;
    }

    public String getRptdTtl() {
        return rptdTtl;
    }

    public void setRptdTtl(String rptdTtl) {
        this.rptdTtl = rptdTtl;
    }

    public List<ItsmSlaDefVO> getItmList() {
        return itmList;
    }

    public void setItmList(List<ItsmSlaDefVO> itmList) {
        this.itmList = itmList;
    }
}
