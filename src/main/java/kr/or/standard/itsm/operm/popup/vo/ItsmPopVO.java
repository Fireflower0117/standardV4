package kr.or.standard.itsm.operm.popup.vo;

  
import kr.or.standard.basic.system.popup.vo.PopupVO;
import kr.or.standard.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;

@Alias("itsmPopVO")
public class ItsmPopVO extends ItsmCommonDefaultVO {
	public interface insertCheck{}
	public interface updateCheck{}
	public interface deleteCheck{}

	// 팝업 대상코드 유효성 체크
	public interface popTrgtCd {}

	@NotBlank(groups = {PopupVO.updateCheck.class, PopupVO.deleteCheck.class})
	private String popupSn;				/*    팝업관리,팝업일련번호    */

	@NotBlank(message = "팝업대상코드를 입력해주세요.", groups = {popTrgtCd.class})
	private String popupTrgtCd;			/*    팝업관리,팝업대상코드    */
	@NotBlank(message = "제목 : 필수 입력입니다.", groups = {PopupVO.insertCheck.class, PopupVO.updateCheck.class})
	private String popupTtlNm;			/*    팝업관리,팝업제목명    */ 
	private String useYn;				/*    팝업관리,사용여부    */
	private String pstgBgngDt;			/*    팝업관리,게시시작일시    */
	@NotBlank(message = "게시여부 : 필수 선택입니다.", groups = {PopupVO.insertCheck.class, PopupVO.updateCheck.class})
	private String popupYn;				/*    팝업관리,팝업여부    */
	private String pstgEndDt;			/*    팝업관리,게시종료일시    */
	private String popupWdthSzVal;		/*    팝업관리,팝업가로크기값    */
	private String popupHghtSzVal;		/*    팝업관리,팝업세로크기값    */
	private String rprsImgFileId;		/*    팝업관리,대표이미지파일ID    */
	private String popupUpndMargnVal;	/*    팝업관리,팝업상단여백값    */
	private String popupLsdMargnVal;	/*    팝업관리,팝업좌측여백값    */ 
	private String popupCn;				/*    팝업관리,팝업내용    */
	@NotBlank(message = "구분 : 필수 선택입니다.", groups = {PopupVO.insertCheck.class, PopupVO.updateCheck.class})
	private String seVal;				/*    팝업관리,구분값    */
	@NotBlank(message = "게시 기간 : 필수 선택입니다.", groups = {PopupVO.insertCheck.class, PopupVO.updateCheck.class})
	private String popupPstgPrdYn;		/*    팝업관리,팝업게시기간여부    */ 
	
	private String bltnbCn;				/*    게시판내용(에디터 검색용)    */

	@NotBlank(message = "대상 : 필수 선택입니다.", groups = {PopupVO.insertCheck.class, PopupVO.updateCheck.class})
	private String popupTrgtCdNm;		/*    팝업대상코드이름    */
	private String seValNm;				/*    구분값이름    */
	private String imgSrc;              /*    샘플 팝업 이미지 경로    */
	
	private String fileSeqo;			/*    첨부파일 순서    */   
	private String num;                 /*    조회된 리스트 순서    */
	
	public String getBltnbCn() {
		return bltnbCn;
	}

	public void setBltnbCn(String bltnbCn) {
		this.bltnbCn = bltnbCn;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public String getPopupPstgPrdYn() {
		return popupPstgPrdYn;
	}

	public void setPopupPstgPrdYn(String popupPstgPrdYn) {
		this.popupPstgPrdYn = popupPstgPrdYn;
	}

	public String getPopupTrgtCdNm() {
		return popupTrgtCdNm;
	}

	public void setPopupTrgtCdNm(String popupTrgtCdNm) {
		this.popupTrgtCdNm = popupTrgtCdNm;
	}

	public String getSeValNm() {
		return seValNm;
	}

	public void setSeValNm(String seValNm) {
		this.seValNm = seValNm;
	}

	public String getFileSeqo() {
		return fileSeqo;
	}

	public void setFileSeqo(String fileSeqo) {
		this.fileSeqo = fileSeqo;
	}

	public String getSeVal() {
		return seVal;
	}

	public void setSeVal(String seVal) {
		this.seVal = seVal;
	}

	public String getPopupUpndMargnVal() {
		return popupUpndMargnVal;
	}

	public void setPopupUpndMargnVal(String popupUpndMargnVal) {
		this.popupUpndMargnVal = popupUpndMargnVal;
	}

	public String getPopupLsdMargnVal() {
		return popupLsdMargnVal;
	}

	public void setPopupLsdMargnVal(String popupLsdMargnVal) {
		this.popupLsdMargnVal = popupLsdMargnVal;
	}

	public String getPopupTrgtCd() {
		return popupTrgtCd;
	}

	public void setPopupTrgtCd(String popupTrgtCd) {
		this.popupTrgtCd = popupTrgtCd;
	}

	public String getPopupSn() {
		return popupSn;
	}

	public void setPopupSn(String popupSn) {
		this.popupSn = popupSn;
	}

	public String getPopupTtlNm() {
		return popupTtlNm;
	}

	public void setPopupTtlNm(String popupTtlNm) {
		this.popupTtlNm = popupTtlNm;
	}

	public String getPopupCn() {
		return popupCn;
	}

	public void setPopupCn(String popupCn) {
		this.popupCn = popupCn;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getPstgBgngDt() {
		return pstgBgngDt;
	}

	public void setPstgBgngDt(String pstgBgngDt) {
		this.pstgBgngDt = pstgBgngDt;
	}

	public String getPopupYn() {
		return popupYn;
	}

	public void setPopupYn(String popupYn) {
		this.popupYn = popupYn;
	}

	public String getPstgEndDt() {
		return pstgEndDt;
	}

	public void setPstgEndDt(String pstgEndDt) {
		this.pstgEndDt = pstgEndDt;
	}

	public String getPopupWdthSzVal() {
		return popupWdthSzVal;
	}

	public void setPopupWdthSzVal(String popupWdthSzVal) {
		this.popupWdthSzVal = popupWdthSzVal;
	}

	public String getPopupHghtSzVal() {
		return popupHghtSzVal;
	}

	public void setPopupHghtSzVal(String popupHghtSzVal) {
		this.popupHghtSzVal = popupHghtSzVal;
	}

	public String getRprsImgFileId() {
		return rprsImgFileId;
	}

	public void setRprsImgFileId(String rprsImgFileId) {
		this.rprsImgFileId = rprsImgFileId;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}
	
}

