package kr.or.standard.basic.common.domain;


import java.util.Arrays;
import java.util.Objects;

import kr.or.standard.basic.login.vo.LoginVO;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.web.context.request.RequestContextHolder;
   
public class CmmnDefaultVO {
	
	// 현재 페이지 번호.
	private int currentPageNo = 1;
	// 페이징 SQL의 조건절에 사용되는 시작.
	private int firstRecordIndex;
	// 페이징 SQL의 조건절에 사용되는 마지막.
	private int lastRecordIndex;
	
	// 한 페이지당 게시되는 게시물 건 수.
	private int recordCountPerPage = 10;
	
	// 페이징 영역에 보여질 페이지 버튼수
	private int pageSize = 10;
	 
	// 조회 목록 전체건수
	private int totalCount;
	
	// 페이지번호 
	private int pageNo;
	   
	// 순서번호
	private int rowindx;
	
	// 영향받은 RowCount
	private int effCnt;
	
	// 페이징 처리 공통영역
	private String cmd;
	private String rn_top;
	private String rn_bottom;
	private int rn_limit; 
	 
	
	/** 검색조건 . */
	private String searchCondition = "";

	/** 검색키워드 . */
	private String searchKeyword = "";
	
	/** 검색시작일시 . */
	private String searchStartDate = "";

	/** 검색종료일시 . */
	private String searchEndDate = "";
	
	/** 기타 검색 조건 */
	private String schEtc00 = "";
	
	/** 기타 검색 조건 . */
	private String schEtc01 = "";

	/** 기타 검색 조건 . */
	private String schEtc02 = "";

	/** 기타 검색 조건 . */
	private String schEtc03 = "";

	/** 기타 검색 조건 . */
	private String schEtc04 = "";

	/** 기타 검색 조건. */
	private String schEtc05 = "";

	/** 기타 검색 조건. */
	private String schEtc06 = "";

	/** 기타 검색 조건. */
	private String schEtc07 = "";

	/** 기타 검색 조건. */
	private String schEtc08 = "";

	/** 기타 검색 조건. */
	private String schEtc09 = "";

	/** 기타 검색 조건. */
	private String schEtc10 = "";

	/** 기타 검색 조건. */
	private String[] schEtc11;

	/** 기타 검색 조건. */
	private String[] schEtc12;
	
	/** 기타 검색 조건 schEtc11 String으로 변환 */
	private String pSchEtc11;
	
	/** 기타 검색 조건 schEtc12 String으로 변환 */
	private String pSchEtc12;
	
	/** 업무구분 . */
	private String procType = "";


	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public int getFirstRecordIndex() {
		return firstRecordIndex;
	}

	public void setFirstRecordIndex(int firstRecordIndex) {
		this.firstRecordIndex = firstRecordIndex;
	}

	public int getLastRecordIndex() {
		return lastRecordIndex;
	}

	public void setLastRecordIndex(int lastRecordIndex) {
		this.lastRecordIndex = lastRecordIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getRowindx() {
		return rowindx;
	}

	public void setRowindx(int rowindx) {
		this.rowindx = rowindx;
	}

	public int getEffCnt() {
		return effCnt;
	}

	public void setEffCnt(int effCnt) {
		this.effCnt = effCnt;
	}

	public String getCmd() {
		return cmd;
	}

	public void setCmd(String cmd) {
		this.cmd = cmd;
	}

	public String getRn_top() {
		return rn_top;
	}

	public void setRn_top(String rn_top) {
		this.rn_top = rn_top;
	}

	public String getRn_bottom() {
		return rn_bottom;
	}

	public void setRn_bottom(String rn_bottom) {
		this.rn_bottom = rn_bottom;
	}

	public int getRn_limit() {
		return rn_limit;
	}

	public void setRn_limit(int rn_limit) {
		this.rn_limit = rn_limit;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchStartDate() {
		return searchStartDate;
	}

	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}

	public String getSearchEndDate() {
		return searchEndDate;
	}

	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}

	public String getSchEtc00() {
		return schEtc00;
	}

	public void setSchEtc00(String schEtc00) {
		this.schEtc00 = schEtc00;
	}

	public String getSchEtc01() {
		return schEtc01;
	}

	public void setSchEtc01(String schEtc01) {
		this.schEtc01 = schEtc01;
	}

	public String getSchEtc02() {
		return schEtc02;
	}

	public void setSchEtc02(String schEtc02) {
		this.schEtc02 = schEtc02;
	}

	public String getSchEtc03() {
		return schEtc03;
	}

	public void setSchEtc03(String schEtc03) {
		this.schEtc03 = schEtc03;
	}

	public String getSchEtc04() {
		return schEtc04;
	}

	public void setSchEtc04(String schEtc04) {
		this.schEtc04 = schEtc04;
	}

	public String getSchEtc05() {
		return schEtc05;
	}

	public void setSchEtc05(String schEtc05) {
		this.schEtc05 = schEtc05;
	}

	public String getSchEtc06() {
		return schEtc06;
	}

	public void setSchEtc06(String schEtc06) {
		this.schEtc06 = schEtc06;
	}

	public String getSchEtc07() {
		return schEtc07;
	}

	public void setSchEtc07(String schEtc07) {
		this.schEtc07 = schEtc07;
	}

	public String getSchEtc08() {
		return schEtc08;
	}

	public void setSchEtc08(String schEtc08) {
		this.schEtc08 = schEtc08;
	}

	public String getSchEtc09() {
		return schEtc09;
	}

	public void setSchEtc09(String schEtc09) {
		this.schEtc09 = schEtc09;
	}

	public String getSchEtc10() {
		return schEtc10;
	}

	public void setSchEtc10(String schEtc10) {
		this.schEtc10 = schEtc10;
	}

	public String getpSchEtc11() {
		return pSchEtc11;
	}

	public void setpSchEtc11(String pSchEtc11) {
		this.pSchEtc11 = pSchEtc11;
	}

	public String getpSchEtc12() {
		return pSchEtc12;
	}

	public void setpSchEtc12(String pSchEtc12) {
		this.pSchEtc12 = pSchEtc12;
	}

	public String getProcType() {
		return procType;
	}

	public void setProcType(String procType) {
		this.procType = procType;
	}

	public LoginVO getLoginVO() {
		return loginVO;
	}

	public void setLoginVO(LoginVO loginVO) {
		this.loginVO = loginVO;
	}

	public final String[] getSchEtc11() {
		String[] newSchEtc11 = null;
		if(this.schEtc11!=null){
			newSchEtc11 = new String[schEtc11.length];
			System.arraycopy(this.schEtc11, 0, newSchEtc11, 0, schEtc11.length);
		}
		return newSchEtc11;
	}

	public final void setSchEtc11(final String[] schEtc11) throws Exception {
		this.schEtc11 = schEtc11;
		this.schEtc11 = new String[schEtc11.length];
		System.arraycopy(schEtc11, 0, this.schEtc11, 0, schEtc11.length);
		
		if(!ArrayUtils.isEmpty(schEtc11)) {
			this.pSchEtc11 = Arrays.toString(schEtc11).replace("[", "").replace("]", "");
		}
	}

	public final String[] getSchEtc12() {
		String[] newSchEtc12 = null;
		if(this.schEtc12!=null){
			newSchEtc12 = new String[schEtc12.length];
			System.arraycopy(this.schEtc12, 0, newSchEtc12, 0, schEtc12.length);
		}
		return newSchEtc12;
	}

	public final void setSchEtc12(final String[] schEtc12) throws Exception {
		this.schEtc12 = schEtc12;
		this.schEtc12 = new String[schEtc12.length];
		System.arraycopy(schEtc12, 0, this.schEtc12, 0, schEtc12.length);
		
		if(!ArrayUtils.isEmpty(schEtc12)) {
			this.pSchEtc12 = Arrays.toString(schEtc12).replace("[", "").replace("]", "");
		}
	}
     
	/** 로그인 사용자 VO */
	private LoginVO loginVO = (LoginVO) Objects.requireNonNull(RequestContextHolder.getRequestAttributes()).getAttribute("ma_user_info", 1);
    
	// 사용자 ID - loginId
	public String getLoginId() {
		if(this.loginVO != null){
			return this.loginVO.getUserId();
		}else{
			return "";
		}
	}
	// 사용자 일련번호 - loginSerno
	public String getLoginSerno() {
		if(this.loginVO != null){
			return this.loginVO.getUserSerno();
		}else{
			return "";
		}
	} 
}

