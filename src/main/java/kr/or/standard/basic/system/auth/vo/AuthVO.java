package kr.or.standard.basic.system.auth.vo;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import java.util.List;

@Alias("authVO")
public class AuthVO extends CmmnDefaultVO {
	
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}

	/* 필수값 처리 */
	@NotBlank(message = "그룹권한ID : 필수 입력입니다.",groups = {updateCheck.class, deleteCheck.class})
	private String grpAuthId;

	@NotBlank(message = "그룹권한명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String grpAuthNm;

	@NotBlank(message = "사용여부 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String useYn;
	private String useYnNm;

	private String grpAuthSerno;	/* 그룹 권한 일련번호 */
	private String authCount;	/* 그룹 권한 일련번호 */
	private String grpAuthExpl;		/* 그룹 권한 설명 */ 
	private String delYn;			/* 삭제 여부 */
	private String isMyRegr;        /* 로그인사용자 = 등록자 여부 */ 
	private String regrSerno;		/* 등록자 일련번호 */
	private String regrSerNm;		/* 등록자 일련번호 */
	private String regDt;			/* 등록 일시 */
	private String updrSerno;		/* 수정자 일련번호 */
	private String updrSerNm;		/* 수정자 일련번호 */
	private String updDt;			/* 수정일시 */

	private List<AuthVO> maAuthList; /* 관리자 메뉴 권한 */
	private List<AuthVO> ftAuthList; /* 사용자 메뉴 권한 */
	
	private List<AuthVO> myAuthList; /* 마이페이지 메뉴 권한 */

	private String menuSerno;		/* 메뉴 일련번호 */
	private String uprMenuCd;		/* 상위 메뉴 코드*/
	private String menuLvl;			/* 메뉴 레벨 */
	private String menuSeqo;		/* 메뉴 순번 */
	private String menuNm;			/* 메뉴 명 */
	private String menuCd;			/* 메뉴 코드 */
	private String wrtAuthYn;		/* 관리자, 읽기, 쓰기 권한 ex) M, R, W */
	private String authExst;		/* 메뉴 권한 등록 여부  */
	private String menuSeCd;		/* 메뉴 구분 코드 ex) MA, FT */
	private String isleaf;			/* 하위메뉴 존재여부 */

	public String getUseYnNm() { return useYnNm; }

	public void setUseYnNm(String useYnNm) { this.useYnNm = useYnNm; }

	public String getRegrSerNm() { return regrSerNm; }

	public void setRegrSerNm(String regrSerNm) { this.regrSerNm = regrSerNm; }

	public String getUpdrSerNm() { return updrSerNm; }

	public void setUpdrSerNm(String updrSerNm) { this.updrSerNm = updrSerNm; }

	public String getIsMyRegr() { return isMyRegr; }

	public void setIsMyRegr(String isMyRegr) { this.isMyRegr = isMyRegr; }

	public String getAuthCount() { return authCount; }

	public void setAuthCount(String authCount) { this.authCount = authCount; }

	public List<AuthVO> getFtAuthList() {
		return ftAuthList;
	}

	public void setFtAuthList(List<AuthVO> ftAuthList) {
		this.ftAuthList = ftAuthList;
	}

	public String getIsleaf() {
		return isleaf;
	}

	public void setIsleaf(String isleaf) {
		this.isleaf = isleaf;
	}

	public List<AuthVO> getMaAuthList() {
		return maAuthList;
	}

	public void setMaAuthList(List<AuthVO> maAuthList) {
		this.maAuthList = maAuthList;
	}

	public String getMenuSeCd() {
		return menuSeCd;
	}

	public void setMenuSeCd(String menuSeCd) {
		this.menuSeCd = menuSeCd;
	}

	public String getAuthExst() {
		return authExst;
	}

	public void setAuthExst(String authExst) {
		this.authExst = authExst;
	}

	public String getMenuSerno() {
		return menuSerno;
	}

	public void setMenuSerno(String menuSerno) {
		this.menuSerno = menuSerno;
	}

	public String getUprMenuCd() {
		return uprMenuCd;
	}

	public void setUprMenuCd(String uprMenuCd) {
		this.uprMenuCd = uprMenuCd;
	}

	public String getMenuLvl() {
		return menuLvl;
	}

	public void setMenuLvl(String menuLvl) {
		this.menuLvl = menuLvl;
	}

	public String getMenuSeqo() {
		return menuSeqo;
	}

	public void setMenuSeqo(String menuSeqo) {
		this.menuSeqo = menuSeqo;
	}

	public String getMenuNm() {
		return menuNm;
	}

	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}

	public String getMenuCd() {
		return menuCd;
	}

	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}

	public String getWrtAuthYn() {
		return wrtAuthYn;
	}

	public void setWrtAuthYn(String wrtAuthYn) {
		this.wrtAuthYn = wrtAuthYn;
	}

	public String getGrpAuthSerno() {
		return grpAuthSerno;
	}

	public void setGrpAuthSerno(String grpAuthSerno) {
		this.grpAuthSerno = grpAuthSerno;
	}

	public String getGrpAuthId() {
		return grpAuthId;
	}

	public void setGrpAuthId(String grpAuthId) {
		this.grpAuthId = grpAuthId;
	}

	public String getGrpAuthExpl() {
		return grpAuthExpl;
	}

	public void setGrpAuthExpl(String grpAuthExpl) {
		this.grpAuthExpl = grpAuthExpl;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
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

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getGrpAuthNm() {
		return grpAuthNm;
	}

	public void setGrpAuthNm(String grpAuthNm) {
		this.grpAuthNm = grpAuthNm;
	}

	public List<AuthVO> getMyAuthList() {
		return myAuthList;
	}

	public void setMyAuthList(List<AuthVO> myAuthList) {
		this.myAuthList = myAuthList;
	}
}
