package kr.or.opennote.itsm.operm.menu.vo;

  
import kr.or.opennote.basic.system.menu.vo.MenuVO;
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Alias("itsmMenuVO")
public class ItsmMenuVO extends ItsmCommonDefaultVO {

	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	public interface insertContCheck {}
	public interface updateContCheck {}
	public interface deleteContCheck {}

	private String menuSerno;		/* 메뉴 일련번호 */
	private String uprMenuCd;		/* 상위 메뉴 코드*/
	/* 필수값 처리 */
	@NotBlank(message = "메뉴코드 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class, deleteCheck.class, insertContCheck.class, updateContCheck.class, deleteContCheck.class})
	private String menuCd;			/* 메뉴코드 */
	@NotBlank(message = "메뉴레벨 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String menuLvl;			/* 메뉴 레벨 */
	@NotBlank(message = "메뉴순서 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String menuSeqo;		/* 메뉴 순번 */
	@NotBlank(message = "메뉴명을 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String menuNm;		  	/* 메뉴 명 */
	private String menuUrlAddr;		/* 메뉴 URL 주소*/
	@NotBlank(message = "노출여부 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String expsrYn;			/* 노출여부*/
	@NotBlank(message = "하위탭여부 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String lwrTabYn;		/* 하위탭여부 */
	@NotBlank(message = "새창구분 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
	private String tgtBlankYn;		/* 새창열기여부 */
	private String menuExpl;		/* 메뉴 설명 */
	private String useYn;			/* 사용여부 */

	private String regrSerno;		/* 등록자 일련번호 */
	private String regDt;			/* 등록 일시 */
	private String updrSerno;		/* 수정자 일련번호 */
	private String updDt;			/* 수정일시 */

	private String isLeaf;			/* 하위자식 존재유무 */

	private String grpAuthId;		/* 그룹권한 명 */
	private String prLwrTabYn;		/* 부모 하위탭여부 */
	private List<ItsmMenuVO> menuList;	/* 메뉴 리스트 */
	private List<ItsmMenuVO> tabList;	/* 메뉴 탭 리스트 */
	private Map<String, MenuVO> menuMap; /* 메뉴 맵 */

	@NotBlank(message = "에디터 내용 : 필수 입력입니다.",groups = {insertContCheck.class, updateContCheck.class})
	private String editrCont;		/* 에디터 작성내용 */
	private String tempHtml;		/* 에디터 미리보기 */
	private String popDivn;			/* 콘텐츠 팝업구분 */
	private String tabDivn;			/* 콘텐츠 탭구분 */
	private String divn;			/* 구분 */

	private List<HashMap<String,String>> mapArr;

	public String getMenuCd() {
		return menuCd;
	}

	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
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

	public String getMenuUrlAddr() {
		return menuUrlAddr;
	}

	public void setMenuUrlAddr(String menuUrlAddr) {
		this.menuUrlAddr = menuUrlAddr;
	}

	public String getMenuExpl() {
		return menuExpl;
	}

	public void setMenuExpl(String menuExpl) {
		this.menuExpl = menuExpl;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getExpsrYn() {
		return expsrYn;
	}

	public void setExpsrYn(String expsrYn) {
		this.expsrYn = expsrYn;
	}

	public String getLwrTabYn() {
		return lwrTabYn;
	}

	public void setLwrTabYn(String lwrTabYn) {
		this.lwrTabYn = lwrTabYn;
	}

	public String getTgtBlankYn() {
		return tgtBlankYn;
	}

	public void setTgtBlankYn(String tgtBlankYn) {
		this.tgtBlankYn = tgtBlankYn;
	}

	public String getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}

	public List<ItsmMenuVO> getMenuList() {
		return menuList;
	}

	public void setMenuList(List<ItsmMenuVO> menuList) {
		this.menuList = menuList;
	}

	public Map<String, MenuVO> getMenuMap() {
		return menuMap;
	}

	public void setMenuMap(Map<String, MenuVO> menuMap) {
		this.menuMap = menuMap;
	}

	public String getGrpAuthId() {
		return grpAuthId;
	}

	public void setGrpAuthId(String grpAuthId) {
		this.grpAuthId = grpAuthId;
	}

	public String getPrLwrTabYn() {
		return prLwrTabYn;
	}

	public void setPrLwrTabYn(String prLwrTabYn) {
		this.prLwrTabYn = prLwrTabYn;
	}

	public String getEditrCont() {
		return editrCont;
	}

	public void setEditrCont(String editrCont) {
		this.editrCont = editrCont;
	}

	public String getTempHtml() {
		return tempHtml;
	}

	public void setTempHtml(String tempHtml) {
		this.tempHtml = tempHtml;
	}

	public String getPopDivn() {
		return popDivn;
	}

	public void setPopDivn(String popDivn) {
		this.popDivn = popDivn;
	}

	public String getTabDivn() {
		return tabDivn;
	}

	public void setTabDivn(String tabDivn) {
		this.tabDivn = tabDivn;
	}

	public String getDivn() {
		return divn;
	}

	public void setDivn(String divn) {
		this.divn = divn;
	}

	public List<HashMap<String, String>> getMapArr() {
		return mapArr;
	}

	public void setMapArr(List<HashMap<String, String>> mapArr) {
		this.mapArr = mapArr;
	}

	public List<ItsmMenuVO> getTabList() {
		return tabList;
	}

	public void setTabList(List<ItsmMenuVO> tabList) {
		this.tabList = tabList;
	}
	
}
