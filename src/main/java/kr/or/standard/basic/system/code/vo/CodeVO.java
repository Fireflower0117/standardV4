package kr.or.standard.basic.system.code.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
import javax.validation.constraints.NotBlank;

@Alias("codeVO")
public class CodeVO extends CmmnDefaultVO {
	
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}

	/* 필수값 처리 */
	@NotBlank(message = "코드를 입력해주세요",groups = {updateCheck.class, deleteCheck.class})
	private String cdVal;

	@NotBlank(message = "코드명을 입력해주세요", groups = {updateCheck.class, insertCheck.class})
	private String cdNm;

	private String cdSerno;
	private String cdUppoVal;
	private String cdLvlVal ;
	private String cdSortSeqo;
	private String cdDtlsExpl;
	private String regrSerno;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn;
	private String chldCnt;

	private String cdNextSerno;
	
	private String codeType;		//코드타입
	private String defVal;			//SELECT태그 디폴트값
	private String selVal;			//선택된값
	private String name;			//name속성값
	private String idKey;			//id Key값
	private String sort;
	private String title;
	private String required;
	private String rowCnt;

	public String getRowCnt() { return rowCnt; }

	public void setRowCnt(String rowCnt) { this.rowCnt = rowCnt; }

	public String getCdNextSerno() {
		return cdNextSerno;
	}

	public void setCdNextSerno(String cdNextSerno) {
		this.cdNextSerno = cdNextSerno;
	}

	public String getChldCnt() {
		return chldCnt;
	}

	public void setChldCnt(String chldCnt) {
		this.chldCnt = chldCnt;
	}

	public String getCdVal() {
		return cdVal;
	}

	public void setCdVal(String cdVal) {
		this.cdVal = cdVal;
	}

	public String getCdNm() {
		return cdNm;
	}

	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}

	public String getCdSerno() {
		return cdSerno;
	}

	public void setCdSerno(String cdSerno) {
		this.cdSerno = cdSerno;
	}

	public String getCdUppoVal() {
		return cdUppoVal;
	}

	public void setCdUppoVal(String cdUppoVal) {
		this.cdUppoVal = cdUppoVal;
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

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}


	@Override
	public String toString() {
		return "CodeVO{" +
				"cdVal='" + cdVal + '\'' +
				", cdNm='" + cdNm + '\'' +
				", cdSerno='" + cdSerno + '\'' +
				", cdUppoVal='" + cdUppoVal + '\'' +
				", cdLvlVal='" + cdLvlVal + '\'' +
				", cdSortSeqo='" + cdSortSeqo + '\'' +
				", cdDtlsExpl='" + cdDtlsExpl + '\'' +
				", regrSerno='" + regrSerno + '\'' +
				", regDt='" + regDt + '\'' +
				", updrSerno='" + updrSerno + '\'' +
				", updDt='" + updDt + '\'' +
				", useYn='" + useYn + '\'' +
				", chldCnt='" + chldCnt + '\'' +
				", cdNextSerno='" + cdNextSerno + '\'' +
				", codeType='" + codeType + '\'' +
				", defVal='" + defVal + '\'' +
				", selVal='" + selVal + '\'' +
				", name='" + name + '\'' +
				", idKey='" + idKey + '\'' +
				", sort='" + sort + '\'' +
				", title='" + title + '\'' +
				", required='" + required + '\'' +
				", rowCnt='" + rowCnt + '\'' +
				'}';
	}
}

