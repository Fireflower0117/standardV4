package kr.or.opennote.itsm.report.reportMonth.vo;
 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("itsmRptMthVO")
public class ItsmReportMonthVO extends ItsmCommonDefaultVO {
	
	private String pageIndex;
	
	// 댓글 페이징
	private int cmntCurrentPageNo = 1;
	
	private String rptSn;					// 주간보고 일련번호
	private String lastWeekStartYmd;		// 전주시작날짜
	private String lastWeekEndYmd;			// 전주종료날짜
	private String nextWeekStartYmd;		// 차주시작날짜
	private String nextWeekEndYmd;			// 차주종료날짜
	private String thisEmpPrj;				// 금주 사업/프로젝트관리
	private String thisEmpPlan;				// 금주 기획
	private String thisEmpDsgn;				// 금주 디자인/퍼블리싱
	private String thisEmpDev;				// 금주 개발
	private String nextEmpPrj;              // 차주 사업/프로젝트관리  
	private String nextEmpPlan;             // 차주 기획         
	private String nextEmpDsgn;             // 차주 디자인/퍼블리싱   
	private String nextEmpDev;              // 차주 개발         
	private String rptRmrk;					// 비고
	private String rvseDt;					// 수정일
	private String crtDate; 
	 
	private String rptMtrlSn;				// 요청자료일련번호
	private String mtrlCn;					// 자료내용
	private String reqDt;					// 요청일
	private String mtrlGbn;					// 요청자료구분
	private String procGbn;					// 처리
	private String mtrlRmrk;				// 요청자료 비고
	
	private String rptActnSn;				// 지시 및 조치사항 일련번호
	private String instrCn;					// 지시내용
	private String instrDt;					// 지시일
	private String actnRmrk;				// 지시 비고
	private String actnGbn;					// 지시 구분
	
	private String prfrTot;					// 실적합계
	private String planTot;					// 계획합계
	private String thisEmpTot;				// 금주인력합계
	private String nextEmpTot;				// 차주인력합계
	
	private String empTot1;
	private String empTot2;
	private String empTot3;
	private String empTot4;
	private String empTot5;
	
	private List<ItsmReportMonthVO> mtrlList;
	private List<ItsmReportMonthVO> actnList;
	private List<ItsmReportMonthVO> dscsList;
	
	
	private String rptMonthSn;
	private String prjNm;					// 사업명
	private String cntrStartYmd;			// 계약시작날짜
	private String cntrEndYmd;				// 계약종료날짜
	private String cntrNo;					// 계약번호
	private String cmpnNm;					// 업체명
	private String weekStartYmd;			// 금주시작날짜
	private String weekEndYmd;				// 금주종료날짜
	private String anlyStartYmd;			// 분석시작날짜
	private String anlyEndYmd;				// 분석종료날짜
	private String dsgnStartYmd;			// 설계시작날짜
	private String dsgnEndYmd;				// 설계종료날짜
	private String impStartYmd;				// 구현시작날짜
	private String impEndYmd;				// 구현종료날짜
	private String testStartYmd;			// 시험시작날짜
	private String testEndYmd;				// 시험종료날짜
	private String pilotStartYmd;			// 시범운영시작날짜
	private String pilotEndYmd;				// 시범운영종료날짜
	private String anlyPrfr;				// 분석실적
	private String dsgnPrfr;				// 설계실적
	private String impPrfr;					// 구현실적
	private String testPrfr;				// 시험실적
	private String pilotPrfr;				// 시범운영실적
	private String anlyPlan;				// 분석계획
	private String dsgnPlan;				// 설계계획
	private String impPlan;					// 구현계획
	private String testPlan;				// 시험계획
	private String pilotPlan;				// 시범운영계획
	private String empPrj1;
	private String empPlan1;
	private String empDsgn1;
	private String empDev1;
	private String empPrj2;
	private String empPlan2;
	private String empDsgn2;
	private String empDev2;
	private String empPrj3;
	private String empPlan3;
	private String empDsgn3;
	private String empDev3;
	private String empPrj4;
	private String empPlan4;
	private String empDsgn4;
	private String empDev4;
	private String empPrj5;
	private String empPlan5;
	private String empDsgn5;
	private String empDev5;
	private String thisMonthStartYmd;
	private String thisMonthEndYmd;
	private String nextMonthStartYmd;
	private String nextMonthEndYmd;
	private String rptMonthRmrk;
	private String thisPrfr;				// 금주실적
	private String nextPlan;				// 차주계획
	private String schYear;					// 년도
	private String monWeek;					// 월주
	private String jobGbn;					// 업무구분
	private String issueCn;					// 이슈내용
	private String actnPlan;				// 조치내용
	private String useYn;					// 사용여부
	private String rgstSn;					// 등록자 일련번호
	private String rgstDt;					// 등록일
	private String rvseSn;					// 수정자 일련번호
	
	private String rptDscsSn;
	private String dscsGbn;
	private String dscsItem;
	private String dscsCn;
	private String dscsRmrk;
	
	private String weekCnt;
	private String rgstDtMm;
	
	private String monWeek1;
	private String monWeek2;
	private String monWeek3;
	private String monWeek4;
	private String monWeek5;
	
	
	public String getWeekCnt() {
		return weekCnt;
	}
	public void setWeekCnt(String weekCnt) {
		this.weekCnt = weekCnt;
	}
	public String getRgstDtMm() {
		return rgstDtMm;
	}
	public void setRgstDtMm(String rgstDtMm) {
		this.rgstDtMm = rgstDtMm;
	}
	public String getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getCmntCurrentPageNo() {
		return cmntCurrentPageNo;
	}
	public void setCmntCurrentPageNo(int cmntCurrentPageNo) {
		this.cmntCurrentPageNo = cmntCurrentPageNo;
	}
	public String getRptSn() {
		return rptSn;
	}
	public void setRptSn(String rptSn) {
		this.rptSn = rptSn;
	}
	public String getLastWeekStartYmd() {
		return lastWeekStartYmd;
	}
	public void setLastWeekStartYmd(String lastWeekStartYmd) {
		this.lastWeekStartYmd = lastWeekStartYmd;
	}
	public String getLastWeekEndYmd() {
		return lastWeekEndYmd;
	}
	public void setLastWeekEndYmd(String lastWeekEndYmd) {
		this.lastWeekEndYmd = lastWeekEndYmd;
	}
	public String getNextWeekStartYmd() {
		return nextWeekStartYmd;
	}
	public void setNextWeekStartYmd(String nextWeekStartYmd) {
		this.nextWeekStartYmd = nextWeekStartYmd;
	}
	public String getNextWeekEndYmd() {
		return nextWeekEndYmd;
	}
	public void setNextWeekEndYmd(String nextWeekEndYmd) {
		this.nextWeekEndYmd = nextWeekEndYmd;
	}
	public String getThisEmpPrj() {
		return thisEmpPrj;
	}
	public void setThisEmpPrj(String thisEmpPrj) {
		this.thisEmpPrj = thisEmpPrj;
	}
	public String getThisEmpPlan() {
		return thisEmpPlan;
	}
	public void setThisEmpPlan(String thisEmpPlan) {
		this.thisEmpPlan = thisEmpPlan;
	}
	public String getThisEmpDsgn() {
		return thisEmpDsgn;
	}
	public void setThisEmpDsgn(String thisEmpDsgn) {
		this.thisEmpDsgn = thisEmpDsgn;
	}
	public String getThisEmpDev() {
		return thisEmpDev;
	}
	public void setThisEmpDev(String thisEmpDev) {
		this.thisEmpDev = thisEmpDev;
	}
	public String getNextEmpPrj() {
		return nextEmpPrj;
	}
	public void setNextEmpPrj(String nextEmpPrj) {
		this.nextEmpPrj = nextEmpPrj;
	}
	public String getNextEmpPlan() {
		return nextEmpPlan;
	}
	public void setNextEmpPlan(String nextEmpPlan) {
		this.nextEmpPlan = nextEmpPlan;
	}
	public String getNextEmpDsgn() {
		return nextEmpDsgn;
	}
	public void setNextEmpDsgn(String nextEmpDsgn) {
		this.nextEmpDsgn = nextEmpDsgn;
	}
	public String getNextEmpDev() {
		return nextEmpDev;
	}
	public void setNextEmpDev(String nextEmpDev) {
		this.nextEmpDev = nextEmpDev;
	}
	public String getRptRmrk() {
		return rptRmrk;
	}
	public void setRptRmrk(String rptRmrk) {
		this.rptRmrk = rptRmrk;
	}
	public String getRvseDt() {
		return rvseDt;
	}
	public void setRvseDt(String rvseDt) {
		this.rvseDt = rvseDt;
	}
	public String getCrtDate() {
		return crtDate;
	}
	public void setCrtDate(String crtDate) {
		this.crtDate = crtDate;
	}
	public String getRptMtrlSn() {
		return rptMtrlSn;
	}
	public void setRptMtrlSn(String rptMtrlSn) {
		this.rptMtrlSn = rptMtrlSn;
	}
	public String getMtrlCn() {
		return mtrlCn;
	}
	public void setMtrlCn(String mtrlCn) {
		this.mtrlCn = mtrlCn;
	}
	public String getReqDt() {
		return reqDt;
	}
	public void setReqDt(String reqDt) {
		this.reqDt = reqDt;
	}
	public String getMtrlGbn() {
		return mtrlGbn;
	}
	public void setMtrlGbn(String mtrlGbn) {
		this.mtrlGbn = mtrlGbn;
	}
	public String getProcGbn() {
		return procGbn;
	}
	public void setProcGbn(String procGbn) {
		this.procGbn = procGbn;
	}
	public String getMtrlRmrk() {
		return mtrlRmrk;
	}
	public void setMtrlRmrk(String mtrlRmrk) {
		this.mtrlRmrk = mtrlRmrk;
	}
	public String getRptActnSn() {
		return rptActnSn;
	}
	public void setRptActnSn(String rptActnSn) {
		this.rptActnSn = rptActnSn;
	}
	public String getInstrCn() {
		return instrCn;
	}
	public void setInstrCn(String instrCn) {
		this.instrCn = instrCn;
	}
	public String getInstrDt() {
		return instrDt;
	}
	public void setInstrDt(String instrDt) {
		this.instrDt = instrDt;
	}
	public String getActnRmrk() {
		return actnRmrk;
	}
	public void setActnRmrk(String actnRmrk) {
		this.actnRmrk = actnRmrk;
	}
	public String getActnGbn() {
		return actnGbn;
	}
	public void setActnGbn(String actnGbn) {
		this.actnGbn = actnGbn;
	}
	public String getPrfrTot() {
		return prfrTot;
	}
	public void setPrfrTot(String prfrTot) {
		this.prfrTot = prfrTot;
	}
	public String getPlanTot() {
		return planTot;
	}
	public void setPlanTot(String planTot) {
		this.planTot = planTot;
	}
	public String getThisEmpTot() {
		return thisEmpTot;
	}
	public void setThisEmpTot(String thisEmpTot) {
		this.thisEmpTot = thisEmpTot;
	}
	public String getNextEmpTot() {
		return nextEmpTot;
	}
	public void setNextEmpTot(String nextEmpTot) {
		this.nextEmpTot = nextEmpTot;
	}
	public List<ItsmReportMonthVO> getMtrlList() {
		return mtrlList;
	}
	public void setMtrlList(List<ItsmReportMonthVO> mtrlList) {
		this.mtrlList = mtrlList;
	}
	public List<ItsmReportMonthVO> getActnList() {
		return actnList;
	}
	public void setActnList(List<ItsmReportMonthVO> actnList) {
		this.actnList = actnList;
	}
	public String getRptMonthSn() {
		return rptMonthSn;
	}
	public void setRptMonthSn(String rptMonthSn) {
		this.rptMonthSn = rptMonthSn;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getCntrStartYmd() {
		return cntrStartYmd;
	}
	public void setCntrStartYmd(String cntrStartYmd) {
		this.cntrStartYmd = cntrStartYmd;
	}
	public String getCntrEndYmd() {
		return cntrEndYmd;
	}
	public void setCntrEndYmd(String cntrEndYmd) {
		this.cntrEndYmd = cntrEndYmd;
	}
	public String getCntrNo() {
		return cntrNo;
	}
	public void setCntrNo(String cntrNo) {
		this.cntrNo = cntrNo;
	}
	public String getCmpnNm() {
		return cmpnNm;
	}
	public void setCmpnNm(String cmpnNm) {
		this.cmpnNm = cmpnNm;
	}
	public String getWeekStartYmd() {
		return weekStartYmd;
	}
	public void setWeekStartYmd(String weekStartYmd) {
		this.weekStartYmd = weekStartYmd;
	}
	public String getWeekEndYmd() {
		return weekEndYmd;
	}
	public void setWeekEndYmd(String weekEndYmd) {
		this.weekEndYmd = weekEndYmd;
	}
	public String getAnlyStartYmd() {
		return anlyStartYmd;
	}
	public void setAnlyStartYmd(String anlyStartYmd) {
		this.anlyStartYmd = anlyStartYmd;
	}
	public String getAnlyEndYmd() {
		return anlyEndYmd;
	}
	public void setAnlyEndYmd(String anlyEndYmd) {
		this.anlyEndYmd = anlyEndYmd;
	}
	public String getDsgnStartYmd() {
		return dsgnStartYmd;
	}
	public void setDsgnStartYmd(String dsgnStartYmd) {
		this.dsgnStartYmd = dsgnStartYmd;
	}
	public String getDsgnEndYmd() {
		return dsgnEndYmd;
	}
	public void setDsgnEndYmd(String dsgnEndYmd) {
		this.dsgnEndYmd = dsgnEndYmd;
	}
	public String getImpStartYmd() {
		return impStartYmd;
	}
	public void setImpStartYmd(String impStartYmd) {
		this.impStartYmd = impStartYmd;
	}
	public String getImpEndYmd() {
		return impEndYmd;
	}
	public void setImpEndYmd(String impEndYmd) {
		this.impEndYmd = impEndYmd;
	}
	public String getTestStartYmd() {
		return testStartYmd;
	}
	public void setTestStartYmd(String testStartYmd) {
		this.testStartYmd = testStartYmd;
	}
	public String getTestEndYmd() {
		return testEndYmd;
	}
	public void setTestEndYmd(String testEndYmd) {
		this.testEndYmd = testEndYmd;
	}
	public String getPilotStartYmd() {
		return pilotStartYmd;
	}
	public void setPilotStartYmd(String pilotStartYmd) {
		this.pilotStartYmd = pilotStartYmd;
	}
	public String getPilotEndYmd() {
		return pilotEndYmd;
	}
	public void setPilotEndYmd(String pilotEndYmd) {
		this.pilotEndYmd = pilotEndYmd;
	}
	public String getAnlyPrfr() {
		return anlyPrfr;
	}
	public void setAnlyPrfr(String anlyPrfr) {
		this.anlyPrfr = anlyPrfr;
	}
	public String getDsgnPrfr() {
		return dsgnPrfr;
	}
	public void setDsgnPrfr(String dsgnPrfr) {
		this.dsgnPrfr = dsgnPrfr;
	}
	public String getImpPrfr() {
		return impPrfr;
	}
	public void setImpPrfr(String impPrfr) {
		this.impPrfr = impPrfr;
	}
	public String getTestPrfr() {
		return testPrfr;
	}
	public void setTestPrfr(String testPrfr) {
		this.testPrfr = testPrfr;
	}
	public String getPilotPrfr() {
		return pilotPrfr;
	}
	public void setPilotPrfr(String pilotPrfr) {
		this.pilotPrfr = pilotPrfr;
	}
	public String getAnlyPlan() {
		return anlyPlan;
	}
	public void setAnlyPlan(String anlyPlan) {
		this.anlyPlan = anlyPlan;
	}
	public String getDsgnPlan() {
		return dsgnPlan;
	}
	public void setDsgnPlan(String dsgnPlan) {
		this.dsgnPlan = dsgnPlan;
	}
	public String getImpPlan() {
		return impPlan;
	}
	public void setImpPlan(String impPlan) {
		this.impPlan = impPlan;
	}
	public String getTestPlan() {
		return testPlan;
	}
	public void setTestPlan(String testPlan) {
		this.testPlan = testPlan;
	}
	public String getPilotPlan() {
		return pilotPlan;
	}
	public void setPilotPlan(String pilotPlan) {
		this.pilotPlan = pilotPlan;
	}
	public String getEmpPrj1() {
		return empPrj1;
	}
	public void setEmpPrj1(String empPrj1) {
		this.empPrj1 = empPrj1;
	}
	public String getEmpPlan1() {
		return empPlan1;
	}
	public void setEmpPlan1(String empPlan1) {
		this.empPlan1 = empPlan1;
	}
	public String getEmpDsgn1() {
		return empDsgn1;
	}
	public void setEmpDsgn1(String empDsgn1) {
		this.empDsgn1 = empDsgn1;
	}
	public String getEmpDev1() {
		return empDev1;
	}
	public void setEmpDev1(String empDev1) {
		this.empDev1 = empDev1;
	}
	public String getEmpPrj2() {
		return empPrj2;
	}
	public void setEmpPrj2(String empPrj2) {
		this.empPrj2 = empPrj2;
	}
	public String getEmpPlan2() {
		return empPlan2;
	}
	public void setEmpPlan2(String empPlan2) {
		this.empPlan2 = empPlan2;
	}
	public String getEmpDsgn2() {
		return empDsgn2;
	}
	public void setEmpDsgn2(String empDsgn2) {
		this.empDsgn2 = empDsgn2;
	}
	public String getEmpDev2() {
		return empDev2;
	}
	public void setEmpDev2(String empDev2) {
		this.empDev2 = empDev2;
	}
	public String getEmpPrj3() {
		return empPrj3;
	}
	public void setEmpPrj3(String empPrj3) {
		this.empPrj3 = empPrj3;
	}
	public String getEmpPlan3() {
		return empPlan3;
	}
	public void setEmpPlan3(String empPlan3) {
		this.empPlan3 = empPlan3;
	}
	public String getEmpDsgn3() {
		return empDsgn3;
	}
	public void setEmpDsgn3(String empDsgn3) {
		this.empDsgn3 = empDsgn3;
	}
	public String getEmpDev3() {
		return empDev3;
	}
	public void setEmpDev3(String empDev3) {
		this.empDev3 = empDev3;
	}
	public String getEmpPrj4() {
		return empPrj4;
	}
	public void setEmpPrj4(String empPrj4) {
		this.empPrj4 = empPrj4;
	}
	public String getEmpPlan4() {
		return empPlan4;
	}
	public void setEmpPlan4(String empPlan4) {
		this.empPlan4 = empPlan4;
	}
	public String getEmpDsgn4() {
		return empDsgn4;
	}
	public void setEmpDsgn4(String empDsgn4) {
		this.empDsgn4 = empDsgn4;
	}
	public String getEmpDev4() {
		return empDev4;
	}
	public void setEmpDev4(String empDev4) {
		this.empDev4 = empDev4;
	}
	public String getEmpPrj5() {
		return empPrj5;
	}
	public void setEmpPrj5(String empPrj5) {
		this.empPrj5 = empPrj5;
	}
	public String getEmpPlan5() {
		return empPlan5;
	}
	public void setEmpPlan5(String empPlan5) {
		this.empPlan5 = empPlan5;
	}
	public String getEmpDsgn5() {
		return empDsgn5;
	}
	public void setEmpDsgn5(String empDsgn5) {
		this.empDsgn5 = empDsgn5;
	}
	public String getEmpDev5() {
		return empDev5;
	}
	public void setEmpDev5(String empDev5) {
		this.empDev5 = empDev5;
	}
	public String getThisMonthStartYmd() {
		return thisMonthStartYmd;
	}
	public void setThisMonthStartYmd(String thisMonthStartYmd) {
		this.thisMonthStartYmd = thisMonthStartYmd;
	}
	public String getThisMonthEndYmd() {
		return thisMonthEndYmd;
	}
	public void setThisMonthEndYmd(String thisMonthEndYmd) {
		this.thisMonthEndYmd = thisMonthEndYmd;
	}
	public String getNextMonthStartYmd() {
		return nextMonthStartYmd;
	}
	public void setNextMonthStartYmd(String nextMonthStartYmd) {
		this.nextMonthStartYmd = nextMonthStartYmd;
	}
	public String getNextMonthEndYmd() {
		return nextMonthEndYmd;
	}
	public void setNextMonthEndYmd(String nextMonthEndYmd) {
		this.nextMonthEndYmd = nextMonthEndYmd;
	}
	public String getRptMonthRmrk() {
		return rptMonthRmrk;
	}
	public void setRptMonthRmrk(String rptMonthRmrk) {
		this.rptMonthRmrk = rptMonthRmrk;
	}
	public String getThisPrfr() {
		return thisPrfr;
	}
	public void setThisPrfr(String thisPrfr) {
		this.thisPrfr = thisPrfr;
	}
	public String getNextPlan() {
		return nextPlan;
	}
	public void setNextPlan(String nextPlan) {
		this.nextPlan = nextPlan;
	}
	public String getSchYear() {
		return schYear;
	}
	public void setSchYear(String schYear) {
		this.schYear = schYear;
	}
	public String getMonWeek() {
		return monWeek;
	}
	public void setMonWeek(String monWeek) {
		this.monWeek = monWeek;
	}
	public String getJobGbn() {
		return jobGbn;
	}
	public void setJobGbn(String jobGbn) {
		this.jobGbn = jobGbn;
	}
	public String getIssueCn() {
		return issueCn;
	}
	public void setIssueCn(String issueCn) {
		this.issueCn = issueCn;
	}
	public String getActnPlan() {
		return actnPlan;
	}
	public void setActnPlan(String actnPlan) {
		this.actnPlan = actnPlan;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getRgstSn() {
		return rgstSn;
	}
	public void setRgstSn(String rgstSn) {
		this.rgstSn = rgstSn;
	}
	public String getRgstDt() {
		return rgstDt;
	}
	public void setRgstDt(String rgstDt) {
		this.rgstDt = rgstDt;
	}
	public String getRvseSn() {
		return rvseSn;
	}
	public void setRvseSn(String rvseSn) {
		this.rvseSn = rvseSn;
	}
	public String getRptDscsSn() {
		return rptDscsSn;
	}
	public void setRptDscsSn(String rptDscsSn) {
		this.rptDscsSn = rptDscsSn;
	}
	public String getDscsGbn() {
		return dscsGbn;
	}
	public void setDscsGbn(String dscsGbn) {
		this.dscsGbn = dscsGbn;
	}
	public String getDscsItem() {
		return dscsItem;
	}
	public void setDscsItem(String dscsItem) {
		this.dscsItem = dscsItem;
	}
	public String getDscsCn() {
		return dscsCn;
	}
	public void setDscsCn(String dscsCn) {
		this.dscsCn = dscsCn;
	}
	public String getDscsRmrk() {
		return dscsRmrk;
	}
	public void setDscsRmrk(String dscsRmrk) {
		this.dscsRmrk = dscsRmrk;
	}
	public String getEmpTot1() {
		return empTot1;
	}
	public void setEmpTot1(String empTot1) {
		this.empTot1 = empTot1;
	}
	public String getEmpTot2() {
		return empTot2;
	}
	public void setEmpTot2(String empTot2) {
		this.empTot2 = empTot2;
	}
	public String getEmpTot3() {
		return empTot3;
	}
	public void setEmpTot3(String empTot3) {
		this.empTot3 = empTot3;
	}
	public String getEmpTot4() {
		return empTot4;
	}
	public void setEmpTot4(String empTot4) {
		this.empTot4 = empTot4;
	}
	public String getEmpTot5() {
		return empTot5;
	}
	public void setEmpTot5(String empTot5) {
		this.empTot5 = empTot5;
	}
	public List<ItsmReportMonthVO> getDscsList() {
		return dscsList;
	}
	public void setDscsList(List<ItsmReportMonthVO> dscsList) {
		this.dscsList = dscsList;
	}
	public String getMonWeek1() {
		return monWeek1;
	}
	public void setMonWeek1(String monWeek1) {
		this.monWeek1 = monWeek1;
	}
	public String getMonWeek2() {
		return monWeek2;
	}
	public void setMonWeek2(String monWeek2) {
		this.monWeek2 = monWeek2;
	}
	public String getMonWeek3() {
		return monWeek3;
	}
	public void setMonWeek3(String monWeek3) {
		this.monWeek3 = monWeek3;
	}
	public String getMonWeek4() {
		return monWeek4;
	}
	public void setMonWeek4(String monWeek4) {
		this.monWeek4 = monWeek4;
	}
	public String getMonWeek5() {
		return monWeek5;
	}
	public void setMonWeek5(String monWeek5) {
		this.monWeek5 = monWeek5;
	}
}
