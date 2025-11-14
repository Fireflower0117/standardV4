package kr.or.standard.itsm.common.vo;
 
import kr.or.standard.itsm.info.sinfo.vo.ItsmSinfoVO;
import org.apache.ibatis.type.Alias;
import org.springframework.web.context.request.RequestContextHolder;

import javax.validation.constraints.NotBlank;
import java.util.Arrays;
import java.util.Objects;

@Alias("itsmCommonDefaultVO")
public class ItsmCommonDefaultVO {
	
	// 현재 페이지 번호.
	private int currentPageNo = 1;
	// 페이징 SQL의 조건절에 사용되는 시작.
	private int firstRecordIndex;
	// 페이징 SQL의 조건절에 사용되는 마지막.
	private int lastRecordIndex;
	// 한 페이지당 게시되는 게시물 건 수.
	private int recordCountPerPage = 10;
	// 페이지 리스트에 게시되는 페이지 건수.
	private int pageSize = 10;
	
	
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
		
	/** 동작 구분 . */
	private String procType = "";
	
	/** 공지등록일/기간 조건 . */
	private String dateCondition = "";
	
	/** 작성자 이름 */
	private String regrNm = "";
	
	/** 관리자 로그인 VO */
	private ItsmSessionVO itsmSessionVO = (ItsmSessionVO) Objects.requireNonNull(RequestContextHolder.getRequestAttributes()).getAttribute("itsm_user_info", 1);

	public ItsmSessionVO getItsmSessionVO() {
		return itsmSessionVO;
	}

	public void setItsmSessionVO(ItsmSessionVO itsmSessionVO) {
		this.itsmSessionVO = itsmSessionVO;
	}

	private String regId;
	private String regDt;		/** 등록일     	*/
	private String rgtrSn;		/** 등록자일련번호 	*/
	private String rgtrId;		/** 등록자ID 		*/
	private String rgtrNm;		/** 등록자명		*/
	private String mdfcnDt;		/** 수정일    	*/
	private String mdfrSn;		/** 수정자일련번호  */
	private String mdfrId;		/** 수정자ID   	*/
	private String mdfrNm;		/** 수정자명    	*/
	private String useYn;		/** 사용여부    	*/

	/** ITSM 공통 변수*/

	@NotBlank(groups = {ItsmSinfoVO.updateCheck.class, ItsmSinfoVO.deleteCheck.class , ItsmSinfoVO.itsmCheck.class})
	private String svcSn; // 서비스 일련번호
	private String svcNm; // 서비스명
	private String userSvcSn; // 로그인한 사용자의 svcSn
	private String excelYn; // 쿼리에서, 엑셀 다운용 쿼리인지 여부

	/**
	 * <pre>
	 * Description :  검색 조건을 를 설정한다.
	 * </pre>
	 *
	 * @param vo 검색조건
	 */
	public void setSearchVO(final ItsmCommonDefaultVO vo) {
		this.searchCondition = vo.getSearchCondition();
		this.dateCondition = vo.getDateCondition();
		this.searchKeyword = vo.getSearchKeyword();
		this.searchStartDate = vo.getSearchStartDate();
		this.searchEndDate = vo.getSearchEndDate();
		this.schEtc01 = vo.getSchEtc01();
		this.schEtc02 = vo.getSchEtc02();
		this.schEtc03 = vo.getSchEtc03();
		this.schEtc04 = vo.getSchEtc04();
		this.schEtc05 = vo.getSchEtc05();
		this.schEtc06 = vo.getSchEtc06();
		this.schEtc07 = vo.getSchEtc07();
		this.schEtc08 = vo.getSchEtc08();
		this.schEtc09 = vo.getSchEtc09();
		this.schEtc10 = vo.getSchEtc10();
		this.pageSize = vo.getPageSize();
		this.currentPageNo = vo.getCurrentPageNo();
	}


	public String getRegrNm() {
		return regrNm;
	}


	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
	}


	public String getRegDt() {
		return regDt;
	}


	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}


	public String getRegId() {
		return regId;
	}


	public void setRegId(String regId) {
		this.regId = regId;
	}


	public String getRgtrNm() {
		return rgtrNm;
	}


	public void setRgtrNm(String rgtrNm) {
		this.rgtrNm = rgtrNm;
	}


	public String getRgtrSn() {
		return rgtrSn;
	}


	public void setRgtrSn(String rgtrSn) {
		this.rgtrSn = rgtrSn;
	}


	public String getRgtrId() {
		return rgtrId;
	}


	public void setRgtrId(String rgtrId) {
		this.rgtrId = rgtrId;
	}


	public String getMdfrSn() {
		return mdfrSn;
	}


	public void setMdfrSn(String mdfrSn) {
		this.mdfrSn = mdfrSn;
	}


	public String getMdfrId() {
		return mdfrId;
	}


	public void setMdfrId(String mdfrId) {
		this.mdfrId = mdfrId;
	}


	public String getMdfcnDt() {
		return mdfcnDt;
	}


	public void setMdfcnDt(String mdfcnDt) {
		this.mdfcnDt = mdfcnDt;
	}

	public String getUseYn() {
		return useYn;
	}


	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}


	public String getDateCondition() {
		return dateCondition;
	}

	public void setDateCondition(String dateCondition) {
		this.dateCondition = dateCondition;
	}

	public String getProcType() {
		return procType;
	}

	public void setProcType(String procType) {
		this.procType = procType;
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
		
		if(schEtc11 != null) {
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
		this.schEtc12 = new String[schEtc12.length];
		System.arraycopy(schEtc12, 0, this.schEtc12, 0, schEtc12.length);
		
		if(schEtc12 != null) {
			this.pSchEtc12 = Arrays.toString(schEtc12).replace("[", "").replace("]", "");
		}
	}

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
	// 사용자명 loginUserNm
	public String getLoginUserNm(){
		if(this.itsmSessionVO != null){
			return this.itsmSessionVO.getUserNm();
		}else{
			return "";
		}
	}
	// 사용자 ID - loginId
	public String getLoginId() {
		if(this.itsmSessionVO != null){
			return this.itsmSessionVO.getUserId();
		}else{
			return "";
		}
	}
	// 사용자 일련번호 - loginSerno
	public String getLoginSerno() {
		if(this.itsmSessionVO != null){
			return this.itsmSessionVO.getUserSerno();
		}else{
			return "";
		}
	}
	// 권한 - grpAuthId
	public String getGrpAuthId() {
		if(this.itsmSessionVO != null){
			return this.itsmSessionVO.getGrpAuthId();
		}else{
			return "";
		}
	}

	// 서비스 정보 - svcSn
	public String getUserSvcSn() {
		if(this.itsmSessionVO != null){
			return this.itsmSessionVO.getUserSvcSn();
		}else{
			return "";
		}
	}


	public String getMdfrNm() {
		return mdfrNm;
	}
	public void setMdfrNm(String mdfrNm) {
		this.mdfrNm = mdfrNm;
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

	public String getSvcSn() {
		return svcSn;
	}

	public void setSvcSn(String svcSn) {
		this.svcSn = svcSn;
	}

	public String getExcelYn() {
		return excelYn;
	}

	public void setExcelYn(String excelYn) {
		this.excelYn = excelYn;
	}
	public String getSvcNm() {
		return svcNm;
	}

	public void setSvcNm(String svcNm) {
		this.svcNm = svcNm;
	}

	public void setUserSvcSn(String userSvcSn) {
		this.userSvcSn = userSvcSn;
	}
}
