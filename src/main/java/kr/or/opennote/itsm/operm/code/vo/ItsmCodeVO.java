package kr.or.opennote.itsm.operm.code.vo;


import java.util.List;

import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;


@Alias("itsmCodeVO")
public class ItsmCodeVO extends ItsmCommonDefaultVO {

	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}

	private String serno;
	private String uppoCdVal;
	private String cdVal;
	private String cdValNm; 
	private String cdLvlVal;
	private String cdSortSeqo;
	private String cdDtlsExpl;
	private String regrId;
	private String regDt;
	private String useYn;

	private String codeType;		//코드입
	private String defVal;			//SELECT태그 디폴트값
	private String selVal;			//선택된값
	private String name;			//name속성값
	private String idKey;			//id Key값

	private String lvl;
	private String leaf;

	private String actWork;
	private String pStdTime;
	
	private String sort;
	private String title;
	private String required;
	private String childCdValNm; 
	private String chldCnt; 
	
	private String rNum;

	private List<ItsmCodeVO> codeList;
	
	
	
	public String getrNum() {
		return rNum;
	}
	public void setrNum(String rNum) {
		this.rNum = rNum;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getUppoCdVal() {
		return uppoCdVal;
	}
	public void setUppoCdVal(String uppoCdVal) {
		this.uppoCdVal = uppoCdVal;
	}
	public String getCdVal() {
		return cdVal;
	}
	public void setCdVal(String cdVal) {
		this.cdVal = cdVal;
	}
	public String getCdValNm() {
		return cdValNm;
	}
	public void setCdValNm(String cdValNm) {
		this.cdValNm = cdValNm;
	}
	public String getCdLvlVal() {
		return cdLvlVal;
	}
	public void setCdLvlVal(String cdLvlVal) {
		this.cdLvlVal = cdLvlVal;
	}
	public String getCdSortSeqo() {
		return cdSortSeqo;
	}
	public void setCdSortSeqo(String cdSortSeqo) {
		this.cdSortSeqo = cdSortSeqo;
	}
	public String getCdDtlsExpl() {
		return cdDtlsExpl;
	}
	public void setCdDtlsExpl(String cdDtlsExpl) {
		this.cdDtlsExpl = cdDtlsExpl;
	}

	public String getRegrId() {
		return regrId;
	}

	public void setRegrId(String regrId) {
		this.regrId = regrId;
	}

	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getCodeType() {
		return codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public String getDefVal() {
		return defVal;
	}

	public void setDefVal(String defVal) {
		this.defVal = defVal;
	}

	public String getSelVal() {
		return selVal;
	}

	public void setSelVal(String selVal) {
		this.selVal = selVal;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdKey() {
		return idKey;
	}

	public void setIdKey(String idKey) {
		this.idKey = idKey;
	}

	public List<ItsmCodeVO> getCodeList() {
		return codeList;
	}

	public String getLvl() {
		return lvl;
	}

	public void setLvl(String lvl) {
		this.lvl = lvl;
	}

	public String getLeaf() {
		return leaf;
	}

	public void setLeaf(String leaf) {
		this.leaf = leaf;
	}

	public void setCodeList(List<ItsmCodeVO> codeList) {
		this.codeList = codeList;
	}

	public String getActWork() {
		return actWork;
	}

	public void setActWork(String actWork) {
		this.actWork = actWork;
	}

	public String getpStdTime() {
		return pStdTime;
	}

	public void setpStdTime(String pStdTime) {
		this.pStdTime = pStdTime;
	}
	public String getChildCdValNm() {
		return childCdValNm;
	}
	public void setChildCdValNm(String childCdValNm) {
		this.childCdValNm = childCdValNm;
	}
	public String getRequired() {
		return required;
	}
	public void setRequired(String required) {
		this.required = required;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getChldCnt() {
		return chldCnt;
	}
	public void setChldCnt(String chldCnt) {
		this.chldCnt = chldCnt;
	}

	
}