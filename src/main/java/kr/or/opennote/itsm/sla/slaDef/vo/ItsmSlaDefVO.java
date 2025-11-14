package kr.or.opennote.itsm.sla.slaDef.vo;
 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("itsmSlaDefVO")
public class ItsmSlaDefVO extends ItsmCommonDefaultVO {

    public interface insertCheck {}

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

    private List<ItsmSlaDefVO> itmList;



    /** 검색시작일 */
    private String searchBgnDe = "";

    /** 검색조건 */
    private String searchCnd = "";

    /** 검색종료일 */
    private String searchEndDe = "";

    /** 검색단어 */
    private String searchWrd = "";

    /** 정렬순서(DESC,ASC) */
    private long sortOrdr = 0L;

    /** 검색사용여부 */
    private String searchUseYn = "";

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int firstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int lastIndex = 1;

    /** 페이지당 레코드 개수 */
    private int recordCountPerPage = 10;

    private String insertId;

    private String insertNm;

    private String insertDt;

    private String updateId;

    private String updateNm;

    private String updateDt;

    private String divn;

    private String procType;

    private String searchCnd01;

    private String searchCnd02;

    private String searchCnd03;

    private String searchCnd04;

    private String searchCnd05;

    private String searchCnd06;

    private String searchCnd07;

    private String searchCnd08;

    private String searchCnd09;

    private String searchCnd10;
    private String itemCd;

    private String itemCn;

    private String dtlIndCd;

    private String dtlIndCn;

    private int points;

    private String indSeCd;

    private String indSeCdnm;

    private String useBgnYm;

    private String useEndYm;


    private String allCnt;
    private String doneCnt;

    public String getAllCnt() {
        return allCnt;
    }

    public void setAllCnt(String allCnt) {
        this.allCnt = allCnt;
    }

    public String getDoneCnt() {
        return doneCnt;
    }

    public void setDoneCnt(String doneCnt) {
        this.doneCnt = doneCnt;
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

    public List<ItsmSlaDefVO> getItmList() {
        return itmList;
    }

    public void setItmList(List<ItsmSlaDefVO> itmList) {
        this.itmList = itmList;
    }

    public String getItmSeqo() {
        return itmSeqo;
    }

    public void setItmSeqo(String itmSeqo) {
        this.itmSeqo = itmSeqo;
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

    public String getItemCd() {
        return itemCd;
    }

    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }

    public String getItemCn() {
        return itemCn;
    }

    public void setItemCn(String itemCn) {
        this.itemCn = itemCn;
    }

    public String getDtlIndCd() {
        return dtlIndCd;
    }

    public void setDtlIndCd(String dtlIndCd) {
        this.dtlIndCd = dtlIndCd;
    }

    public String getDtlIndCn() {
        return dtlIndCn;
    }

    public void setDtlIndCn(String dtlIndCn) {
        this.dtlIndCn = dtlIndCn;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getIndSeCd() {
        return indSeCd;
    }

    public void setIndSeCd(String indSeCd) {
        this.indSeCd = indSeCd;
    }

    public String getIndSeCdnm() {
        return indSeCdnm;
    }

    public void setIndSeCdnm(String indSeCdnm) {
        this.indSeCdnm = indSeCdnm;
    }

    public String getUseBgnYm() {
        return useBgnYm;
    }

    public void setUseBgnYm(String useBgnYm) {
        this.useBgnYm = useBgnYm;
    }

    public String getUseEndYm() {
        return useEndYm;
    }

    public void setUseEndYm(String useEndYm) {
        this.useEndYm = useEndYm;
    }

    public String getSearchBgnDe() {
        return searchBgnDe;
    }

    public void setSearchBgnDe(String searchBgnDe) {
        this.searchBgnDe = searchBgnDe;
    }

    public String getSearchCnd() {
        return searchCnd;
    }

    public void setSearchCnd(String searchCnd) {
        this.searchCnd = searchCnd;
    }

    public String getSearchEndDe() {
        return searchEndDe;
    }

    public void setSearchEndDe(String searchEndDe) {
        this.searchEndDe = searchEndDe;
    }

    public String getSearchWrd() {
        return searchWrd;
    }

    public void setSearchWrd(String searchWrd) {
        this.searchWrd = searchWrd;
    }

    public long getSortOrdr() {
        return sortOrdr;
    }

    public void setSortOrdr(long sortOrdr) {
        this.sortOrdr = sortOrdr;
    }

    public String getSearchUseYn() {
        return searchUseYn;
    }

    public void setSearchUseYn(String searchUseYn) {
        this.searchUseYn = searchUseYn;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    @Override
    public int getPageSize() {
        return pageSize;
    }

    @Override
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getFirstIndex() {
        return firstIndex;
    }

    public void setFirstIndex(int firstIndex) {
        this.firstIndex = firstIndex;
    }

    public int getLastIndex() {
        return lastIndex;
    }

    public void setLastIndex(int lastIndex) {
        this.lastIndex = lastIndex;
    }

    @Override
    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }

    @Override
    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }

    public String getInsertId() {
        return insertId;
    }

    public void setInsertId(String insertId) {
        this.insertId = insertId;
    }

    public String getInsertNm() {
        return insertNm;
    }

    public void setInsertNm(String insertNm) {
        this.insertNm = insertNm;
    }

    public String getInsertDt() {
        return insertDt;
    }

    public void setInsertDt(String insertDt) {
        this.insertDt = insertDt;
    }

    public String getUpdateId() {
        return updateId;
    }

    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }

    public String getUpdateNm() {
        return updateNm;
    }

    public void setUpdateNm(String updateNm) {
        this.updateNm = updateNm;
    }

    public String getUpdateDt() {
        return updateDt;
    }

    public void setUpdateDt(String updateDt) {
        this.updateDt = updateDt;
    }

    public String getDivn() {
        return divn;
    }

    public void setDivn(String divn) {
        this.divn = divn;
    }

    @Override
    public String getProcType() {
        return procType;
    }

    @Override
    public void setProcType(String procType) {
        this.procType = procType;
    }

    public String getSearchCnd01() {
        return searchCnd01;
    }

    public void setSearchCnd01(String searchCnd01) {
        this.searchCnd01 = searchCnd01;
    }

    public String getSearchCnd02() {
        return searchCnd02;
    }

    public void setSearchCnd02(String searchCnd02) {
        this.searchCnd02 = searchCnd02;
    }

    public String getSearchCnd03() {
        return searchCnd03;
    }

    public void setSearchCnd03(String searchCnd03) {
        this.searchCnd03 = searchCnd03;
    }

    public String getSearchCnd04() {
        return searchCnd04;
    }

    public void setSearchCnd04(String searchCnd04) {
        this.searchCnd04 = searchCnd04;
    }

    public String getSearchCnd05() {
        return searchCnd05;
    }

    public void setSearchCnd05(String searchCnd05) {
        this.searchCnd05 = searchCnd05;
    }

    public String getSearchCnd06() {
        return searchCnd06;
    }

    public void setSearchCnd06(String searchCnd06) {
        this.searchCnd06 = searchCnd06;
    }

    public String getSearchCnd07() {
        return searchCnd07;
    }

    public void setSearchCnd07(String searchCnd07) {
        this.searchCnd07 = searchCnd07;
    }

    public String getSearchCnd08() {
        return searchCnd08;
    }

    public void setSearchCnd08(String searchCnd08) {
        this.searchCnd08 = searchCnd08;
    }

    public String getSearchCnd09() {
        return searchCnd09;
    }

    public void setSearchCnd09(String searchCnd09) {
        this.searchCnd09 = searchCnd09;
    }

    public String getSearchCnd10() {
        return searchCnd10;
    }

    public void setSearchCnd10(String searchCnd10) {
        this.searchCnd10 = searchCnd10;
    }
}
