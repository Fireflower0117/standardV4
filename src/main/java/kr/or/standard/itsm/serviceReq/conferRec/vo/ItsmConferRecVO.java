package kr.or.standard.itsm.serviceReq.conferRec.vo;

 
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias("itsmConferRecVO")
public class ItsmConferRecVO extends ItsmCommonDefaultVO {
	
	// T_CONFER_MNG
	private String cofSn;		            // 회의록일련번호
	private String bsnNm;		            // 사업명
	private String cofTtl;		            // 회의제목
	private String cofCn;		            // 회의내용
	private String cofDt;		            // 회의일시
	private String regNm;		            // 작성자
	private String apvrNm;		            // 승인자
	private String version;		            // 버전
	private String cofInfo;		        	// 문서정보
	private String cofKind;		        	// 문서종류
	private String cofType;		        	// 문서유형
	private String cofNm;					// 문서명
	private String atchFileId;			    // 첨부파일ID
	private String cofStaHh;			    // 회의시작시
	private String cofStaMi;			    // 회의시작분
	private String cofEndHh;			    // 회의종료시
	private String cofEndMi;			    // 회의종료분
	private String cofTime;			    	// 회의시간

	private String svcDivn;

	
	// T_CONFER_ATTEND
	private String attSn;					// 회의참석자일련번호
	private String attDeptCd;				// 참석자소속구분(담당,개발)
	private String attDeptNm;				// 참석자소속구분(담당,개발)
	private String attNm;					// 참석자이름
	private String attOftlNm;				// 참석자직급
	private String attCnt;					// 참석자수
	private List<ItsmConferRecVO> attList; 		// 참석자 리스트
	
	
	// 엑셀 rownum
	private String RNUM;

	private List<ItsmConferRecVO> dmndList;

	private String imprvSn;
	private String dmndCnSn;
	private String dmndTtl;
	private String dmndCdNm;
	private String menuCd;
	private String menuNm;
	private String dmndCn;         /** 요청내용 */
	private String prcsCn;         /** 처리내용 */
	private String prcsCd;         /** 처리상태구분코드 */
	private String prcsCdNm;       /** 처리상태구분코드명 */
	private String uprMenuCd;
	private String upMenuNm;
	private String prcsDt;

	private String rqrSn;
	private String rqrId;
	private String rqrItm;
	private String rqrDtl;

	private String dmndSn;
	private String cofDmndSn;

	public String getImprvSn() {
		return imprvSn;
	}

	public void setImprvSn(String imprvSn) {
		this.imprvSn = imprvSn;
	}

	public String getDmndTtl() {
		return dmndTtl;
	}

	public void setDmndTtl(String dmndTtl) {
		this.dmndTtl = dmndTtl;
	}

	public String getDmndCdNm() {
		return dmndCdNm;
	}

	public void setDmndCdNm(String dmndCdNm) {
		this.dmndCdNm = dmndCdNm;
	}

	public String getCofDmndSn() {
		return cofDmndSn;
	}

	public void setCofDmndSn(String cofDmndSn) {
		this.cofDmndSn = cofDmndSn;
	}

	public String getDmndSn() {
		
		return dmndSn;
	}

	public void setDmndSn(String dmndSn) {
		this.dmndSn = dmndSn;
	}

	public List<ItsmConferRecVO> getDmndList() {
		return dmndList;
	}

	public void setDmndList(List<ItsmConferRecVO> dmndList) {
		this.dmndList = dmndList;
	}

	public String getAttDeptNm() {
		return attDeptNm;
	}

	public void setAttDeptNm(String attDeptNm) {
		this.attDeptNm = attDeptNm;
	}

	public String getRqrSn() {
		return rqrSn;
	}

	public void setRqrSn(String rqrSn) {
		this.rqrSn = rqrSn;
	}

	public String getRqrId() {
		return rqrId;
	}

	public void setRqrId(String rqrId) {
		this.rqrId = rqrId;
	}

	public String getRqrItm() {
		return rqrItm;
	}

	public void setRqrItm(String rqrItm) {
		this.rqrItm = rqrItm;
	}

	public String getRqrDtl() {
		return rqrDtl;
	}

	public void setRqrDtl(String rqrDtl) {
		this.rqrDtl = rqrDtl;
	}

	public String getPrcsDt() {
		return prcsDt;
	}

	public void setPrcsDt(String prcsDt) {
		this.prcsDt = prcsDt;
	}

	public String getDmndCnSn() {
		return dmndCnSn;
	}

	public void setDmndCnSn(String dmndCnSn) {
		this.dmndCnSn = dmndCnSn;
	}

	public String getMenuCd() {
		return menuCd;
	}

	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}

	public String getUprMenuCd() {
		return uprMenuCd;
	}

	public String getMenuNm() {
		return menuNm;
	}

	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}

	public String getDmndCn() {
		return dmndCn;
	}

	public void setDmndCn(String dmndCn) {
		this.dmndCn = dmndCn;
	}

	public String getPrcsCn() {
		return prcsCn;
	}

	public void setPrcsCn(String prcsCn) {
		this.prcsCn = prcsCn;
	}

	public String getPrcsCd() {
		return prcsCd;
	}

	public void setPrcsCd(String prcsCd) {
		this.prcsCd = prcsCd;
	}

	public String getPrcsCdNm() {
		return prcsCdNm;
	}

	public void setPrcsCdNm(String prcsCdNm) {
		this.prcsCdNm = prcsCdNm;
	}

	public String getUpMenuId() {
		return uprMenuCd;
	}

	public void setUprMenuCd(String uprMenuCd) {
		this.uprMenuCd = uprMenuCd;
	}

	public String getUpMenuNm() {
		return upMenuNm;
	}

	public void setUpMenuNm(String upMenuNm) {
		this.upMenuNm = upMenuNm;
	}

	public String getSvcDivn() {
		return svcDivn;
	}

	public void setSvcDivn(String svcDivn) {
		this.svcDivn = svcDivn;
	}

	public String getRNUM() {
		return RNUM;
	}
	public void setRNUM(String rNUM) {
		RNUM = rNUM;
	}
	public String getCofTime() {
		return cofTime;
	}
	public void setCofTime(String cofTime) {
		this.cofTime = cofTime;
	}
	public String getCofStaHh() {
		return cofStaHh;
	}
	public void setCofStaHh(String cofStaHh) {
		this.cofStaHh = cofStaHh;
	}
	public String getCofStaMi() {
		return cofStaMi;
	}
	public void setCofStaMi(String cofStaMi) {
		this.cofStaMi = cofStaMi;
	}
	public String getCofEndHh() {
		return cofEndHh;
	}
	public void setCofEndHh(String cofEndHh) {
		this.cofEndHh = cofEndHh;
	}
	public String getCofEndMi() {
		return cofEndMi;
	}
	public void setCofEndMi(String cofEndMi) {
		this.cofEndMi = cofEndMi;
	}
	public String getAttCnt() {
		return attCnt;
	}
	public void setAttCnt(String attCnt) {
		this.attCnt = attCnt;
	}
	public List<ItsmConferRecVO> getAttList() {
		return attList;
	}
	public void setAttList(List<ItsmConferRecVO> attList) {
		this.attList = attList;
	}
	public String getCofSn() {
		return cofSn;
	}
	public void setCofSn(String cofSn) {
		this.cofSn = cofSn;
	}
	public String getBsnNm() {
		return bsnNm;
	}
	public void setBsnNm(String bsnNm) {
		this.bsnNm = bsnNm;
	}
	public String getCofTtl() {
		return cofTtl;
	}
	public void setCofTtl(String cofTtl) {
		this.cofTtl = cofTtl;
	}
	public String getCofCn() {
		return cofCn;
	}
	public void setCofCn(String cofCn) {
		this.cofCn = cofCn;
	}
	public String getCofDt() {
		return cofDt;
	}
	public void setCofDt(String cofDt) {
		this.cofDt = cofDt;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getApvrNm() {
		return apvrNm;
	}
	public void setApvrNm(String apvrNm) {
		this.apvrNm = apvrNm;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getCofInfo() {
		return cofInfo;
	}
	public void setCofInfo(String cofInfo) {
		this.cofInfo = cofInfo;
	}
	public String getCofKind() {
		return cofKind;
	}
	public void setCofKind(String cofKind) {
		this.cofKind = cofKind;
	}
	public String getCofType() {
		return cofType;
	}
	public void setCofType(String cofType) {
		this.cofType = cofType;
	}
	public String getCofNm() {
		return cofNm;
	}
	public void setCofNm(String cofNm) {
		this.cofNm = cofNm;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getAttSn() {
		return attSn;
	}
	public void setAttSn(String attSn) {
		this.attSn = attSn;
	}
	public String getAttDeptCd() {
		return attDeptCd;
	}
	public void setAttDeptCd(String attDeptCd) {
		this.attDeptCd = attDeptCd;
	}
	public String getAttNm() {
		return attNm;
	}
	public void setAttNm(String attNm) {
		this.attNm = attNm;
	}
	public String getAttOftlNm() {
		return attOftlNm;
	}
	public void setAttOftlNm(String attOftlNm) {
		this.attOftlNm = attOftlNm;
	}
}
