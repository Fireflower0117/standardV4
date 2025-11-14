package kr.or.opennote.itsm.operm.inspMng.vo;
 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;
import java.util.List;

@Alias("itsmInspMngVO")
public class ItsmInspMngVO extends ItsmCommonDefaultVO {
	
	public interface insertCheck {}
	public interface insertResultCheck {}
	public interface insertItmCheck {}

	public interface updateCheck {}
	public interface updateResultCheck {}
	public interface updateItmCheck {}

	public interface deleteCheck {}
	public interface deleteResultCheck {}
	public interface deleteItmCheck {}

	/** 양식 테이블 */
	@NotBlank(groups = {updateCheck.class, deleteCheck.class, updateResultCheck.class, insertResultCheck.class})
	private String frmSn;		// 양식일련번호
	
	@NotBlank(message = "제목 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String frmNm;		// 양식 명

	@NotBlank(message = "점검 구분 : 필수 선택입니다.", groups = {updateCheck.class, insertCheck.class})
	private String inspGbn;		// 점검 구분
	private String inspGbnNm;		// 점검 구분

	private String itmSnList; 	// 항목 일련번호의 배열
	private List<ItsmInspMngVO> itmList;			//양식 항목 리스트


	/** 양식 항목 테이블 */
	private String frmItmSn;	// 양식 항목 일련번호
	private String itmSeqo;		// 항목 순서
	@NotBlank(message = "항목내용 : 필수 입력입니다.", groups = {updateItmCheck.class, insertItmCheck.class})
	private String itmCn;		// 항목 내용
	private String esntlYn;		// 필수여부


	/** 항목 테이블*/
	@NotBlank(groups = {updateItmCheck.class, deleteItmCheck.class})
	private String itmSn;		// 항목 일련번호
	@NotBlank(message = "구분 : 필수 선택입니다.", groups = {updateItmCheck.class, insertItmCheck.class})
	private String itmGbn; 		// 항목 구분값
	private String itmGbnNm; 		// 항목 구분값
	private String autoYn; 		// 시스템 자동 점검 항목 여부
	private String autoPath; 		// 시스템 자동 점검일 경우 요청 url


	/** 점점 결과 - 부모 테이블*/

	@NotBlank(groups = {updateResultCheck.class, deleteResultCheck.class})
	private String inspSn; // 점검 결과 부모의 일련번호
	private String inspTtl; // 점검 결과 부모의 제목
	private String inspCn; // 점검 결과 부모의 비고
	private String inspBegnDt; // 점검 시작 일시
	private String inspEndDt; // 점검 완료 일시
	private String atchFileId; // 첨부파일
	private String itmCnt; // 연결된 양식의 항목 건수
	private String itmYCnt; // 연결된 양식의 결과가 정상인 항목 건수


	/** 점점 결과 - 항목 테이블*/
	private String inspItmSn; // 점검 결과 항목의 일련번호
	private String rslt; 		// 점검 결과 선택값 (정상/비정상)
	private String rsltCn; 		// 조치 내용
	
	private String rowNum; //행번호

	
	public String getRowNum() {
		return rowNum;
	}

	public void setRowNum(String rowNum) {
		this.rowNum = rowNum;
	}

	public String getRslt() {
		return rslt;
	}

	public void setRslt(String rslt) {
		this.rslt = rslt;
	}

	public String getRsltCn() {
		return rsltCn;
	}

	public void setRsltCn(String rsltCn) {
		this.rsltCn = rsltCn;
	}

	public String getItmCnt() {
		return itmCnt;
	}

	public void setItmCnt(String itmCnt) {
		this.itmCnt = itmCnt;
	}

	/** GETTER, SETTER*/



	public String getInspGbn() {
		return inspGbn;
	}

	public void setInspGbn(String inspGbn) {
		this.inspGbn = inspGbn;
	}

	public String getInspGbnNm() {
		return inspGbnNm;
	}

	public void setInspGbnNm(String inspGbnNm) {
		this.inspGbnNm = inspGbnNm;
	}

	public String getInspTtl() {
		return inspTtl;
	}

	public void setInspTtl(String inspTtl) {
		this.inspTtl = inspTtl;
	}

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}


	public String getInspSn() {
		return inspSn;
	}

	public void setInspSn(String inspSn) {
		this.inspSn = inspSn;
	}

	public String getInspCn() {
		return inspCn;
	}

	public void setInspCn(String inspCn) {
		this.inspCn = inspCn;
	}

	public String getInspBegnDt() {
		return inspBegnDt;
	}

	public void setInspBegnDt(String inspBegnDt) {
		this.inspBegnDt = inspBegnDt;
	}

	public String getInspEndDt() {
		return inspEndDt;
	}

	public void setInspEndDt(String inspEndDt) {
		this.inspEndDt = inspEndDt;
	}

	public String getInspItmSn() {
		return inspItmSn;
	}

	public void setInspItmSn(String inspItmSn) {
		this.inspItmSn = inspItmSn;
	}


	public String getItmSn() {
		return itmSn;
	}

	public void setItmSn(String itmSn) {
		this.itmSn = itmSn;
	}

	public String getItmGbn() {
		return itmGbn;
	}

	public void setItmGbn(String itmGbn) {
		this.itmGbn = itmGbn;
	}

	public String getItmGbnNm() {
		return itmGbnNm;
	}

	public void setItmGbnNm(String itmGbnNm) {
		this.itmGbnNm = itmGbnNm;
	}

	public String getEsntlYn() {
		return esntlYn;
	}

	public void setEsntlYn(String esntlYn) {
		this.esntlYn = esntlYn;
	}

	public String getFrmSn() {
		return frmSn;
	}

	public void setFrmSn(String frmSn) {
		this.frmSn = frmSn;
	}

	public String getFrmNm() {
		return frmNm;
	}

	public void setFrmNm(String frmNm) {
		this.frmNm = frmNm;
	}

	public String getFrmItmSn() {
		return frmItmSn;
	}

	public void setFrmItmSn(String frmItmSn) {
		this.frmItmSn = frmItmSn;
	}

	public String getItmSeqo() {
		return itmSeqo;
	}

	public void setItmSeqo(String itmSeqo) {
		this.itmSeqo = itmSeqo;
	}

	public String getItmCn() {
		return itmCn;
	}

	public void setItmCn(String itmCn) {
		this.itmCn = itmCn;
	}

	public List<ItsmInspMngVO> getItmList() {
		return itmList;
	}

	public void setItmList(List<ItsmInspMngVO> itmList) {
		this.itmList = itmList;
	}

	public String getItmSnList() {
		return itmSnList;
	}

	public void setItmSnList(String itmSnList) {
		this.itmSnList = itmSnList;
	}

	public String getAutoYn() {
		return autoYn;
	}

	public void setAutoYn(String autoYn) {
		this.autoYn = autoYn;
	}

	public String getAutoPath() {
		return autoPath;
	}

	public void setAutoPath(String autoPath) {
		this.autoPath = autoPath;
	}

	public String getItmYCnt() {
		return itmYCnt;
	}

	public void setItmYCnt(String itmYCnt) {
		this.itmYCnt = itmYCnt;
	}


}
