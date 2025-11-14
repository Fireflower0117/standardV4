package kr.or.opennote.itsm.operm.auth.vo;

 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import java.util.List;

@Alias("itsmAuthVO")
public class ItsmAuthVO extends ItsmCommonDefaultVO {

	public interface updateCheck {}

	private String grpAuthSerno;	/* 그룹 권한 일련번호 */

	@NotBlank(groups = {updateCheck.class})
	private String grpAuthId;	/* 그룹 권한 ID */
	private String grpAuthNm;	/* 그룹 권한 ID */
	private String grpAuthExpl;		/* 그룹 권한 설명 */
	private String delYn;			/* 삭제 여부 */
	private String regrSerno;		/* 등록자 일련번호 */
	private String regDt;			/* 등록 일시 */
	private String updrSerno;		/* 수정자 일련번호 */
	private String updDt;			/* 수정일시 */
	private String menuSerno;		/* 메뉴 일련번호 */
	private String uprMenuCd;		/* 상위 메뉴 코드*/
	private String menuLvl;			/* 메뉴 레벨 */
	private String menuSeqo;		/* 메뉴 순번 */
	private String menuNm;			/* 메뉴 명 */
	private String menuCd;			/* 메뉴 코드 */
	private String wrtAuthYn;		/* 관리자, 읽기, 쓰기 권한 ex) M, R, W */
	private String authExst;		/* 메뉴 권한 등록 여부  */
	private String isleaf;			/* 하위메뉴 존재여부 */
	// 관리자 권한 리스트
	private List<ItsmAuthVO> itsmAuthList;

	public List<ItsmAuthVO> getItsmAuthList() {
		return itsmAuthList;
	}
	public void setItsmAuthList(List<ItsmAuthVO> itsmAuthList) {
		this.itsmAuthList = itsmAuthList;
	}

	public String getGrpAuthId() {
		return grpAuthId;
	}

	public void setGrpAuthId(String grpAuthId) {
		this.grpAuthId = grpAuthId;
	}

	public String getGrpAuthSerno() {
		return grpAuthSerno;
	}

	public void setGrpAuthSerno(String grpAuthSerno) {
		this.grpAuthSerno = grpAuthSerno;
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

	@Override
	public String getRegDt() {
		return regDt;
	}

	@Override
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

	public String getAuthExst() {
		return authExst;
	}

	public void setAuthExst(String authExst) {
		this.authExst = authExst;
	}

	public String getIsleaf() {
		return isleaf;
	}

	public void setIsleaf(String isleaf) {
		this.isleaf = isleaf;
	}

	public String getGrpAuthNm() {
		return grpAuthNm;
	}

	public void setGrpAuthNm(String grpAuthNm) {
		this.grpAuthNm = grpAuthNm;
	}
}