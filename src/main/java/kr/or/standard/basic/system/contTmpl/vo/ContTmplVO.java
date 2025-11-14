package kr.or.standard.basic.system.contTmpl.vo;

import java.util.HashMap;
import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;
  
@Alias("contTmplVO")
public class ContTmplVO extends CmmnDefaultVO {
	
	public interface insertTmplCheck {}
	public interface updateTmplCheck {}
	public interface deleteTmplCheck {}
	public interface insertContCheck {}
	public interface updateContCheck {}
	public interface deleteContCheck {}
	public interface insertFvrtCheck {}
	public interface deleteFvrtCheck {}
	
	private String regrSerno;		/* 등록자 일련번호 */
	private String regDt;			/* 등록 일시 */
	private String updrSerno;		/* 수정자 일련번호 */
	private String updDt;			/* 수정일시 */
	private String useYn;
	
	//콘텐츠 관리
	@NotBlank(message = "콘텐츠 일련번호 : 필수 입력입니다.",groups = {updateContCheck.class, deleteContCheck.class})
	private String contSerno;		/* 콘텐츠 일련번호 */
	@NotBlank(message = "메뉴코드 : 필수 입력입니다.",groups = {insertContCheck.class,updateContCheck.class})
	private String menuCd;			/* 메뉴코드 */
	@NotBlank(message = "에디터 작성내용 : 필수 입력입니다.",groups = {insertContCheck.class,updateContCheck.class,insertTmplCheck.class,updateTmplCheck.class})
	private String editrCont;		/* 에디터 작성내용 */
	
	//콘텐츠 템플릿 관리
	private String tmplCd;
	@NotBlank(message = "템플릿 일련번호 : 필수 입력입니다.",groups = {updateTmplCheck.class,deleteTmplCheck.class,insertFvrtCheck.class,deleteFvrtCheck.class})
	private String tmplSerno;		/* 템플릿 일련번호 */
	private String fvrtSerno;		/* 템플릿 즐겨찾기 일련번호 */
	@NotBlank(message = "템플릿 구분 : 필수 입력입니다.",groups = {insertTmplCheck.class,updateTmplCheck.class})
	private String tmplCl;			/* 템플릿 구분 */
	@NotBlank(message = "템플릿 타입 : 필수 입력입니다.",groups = {insertTmplCheck.class,updateTmplCheck.class})
	private String tmplTp;			/* 템플릿 타입 */
	@NotBlank(message = "템플릿 설명 : 필수 입력입니다.",groups = {insertTmplCheck.class,updateTmplCheck.class})
	private String tmplExpl;		/* 템플릿 설명 */
	private String tmplFileSerno;		/* 템플릿 파일 일련번호 */
	private String prvwFileSerno;		/* 미리보기 파일 일련번호 */
	
	private String popDivn;		
	private String schPopCondition;
	private String schPopKeyword;
	private int popPageIndex = 1;
	private String tabDivn;
	private String tmplCnt;
	
	private String fileNm;
	private String fileSize;
	private String fileDt;
	private String filePath;
	
	private String divn;
	private String tmplHtml;
	private String previewCont;		/* 미리보기 작성내용 */
	private String tmplTotalCnt;

	private long realFileDt;
	
	private List<String> tempArr;
	private List<HashMap<String,String>> mapArr;
	private List<MultipartFile> files;
	private String fileSeqo;
	private String rlFileNm;
	private String fileExtnNm;
	private String fileSzVal;
	private String fileTpNm;
	private String imgWdthSzVal;
	private String imgHghtSzVal;
	private String delYn;
	private byte[] fileByte;
	
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
	public String getContSerno() {
		return contSerno;
	}
	public void setContSerno(String contSerno) {
		this.contSerno = contSerno;
	}
	public String getMenuCd() {
		return menuCd;
	}
	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}
	public String getEditrCont() {
		return editrCont;
	}
	public void setEditrCont(String editrCont) {
		this.editrCont = editrCont;
	}
	public String getTmplSerno() {
		return tmplSerno;
	}
	public void setTmplSerno(String tmplSerno) {
		this.tmplSerno = tmplSerno;
	}
	public String getTmplCl() {
		return tmplCl;
	}
	public void setTmplCl(String tmplCl) {
		this.tmplCl = tmplCl;
	}
	public String getTmplTp() {
		return tmplTp;
	}
	public void setTmplTp(String tmplTp) {
		this.tmplTp = tmplTp;
	}
	public String getTmplExpl() {
		return tmplExpl;
	}
	public void setTmplExpl(String tmplExpl) {
		this.tmplExpl = tmplExpl;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileDt() {
		return fileDt;
	}
	public void setFileDt(String fileDt) {
		this.fileDt = fileDt;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public long getRealFileDt() {
		return realFileDt;
	}
	public void setRealFileDt(long realFileDt) {
		this.realFileDt = realFileDt;
	}
	public List<String> getTempArr() {
		return tempArr;
	}
	public void setTempArr(List<String> tempArr) {
		this.tempArr = tempArr;
	}
	public String getPopDivn() {
		return popDivn;
	}
	public void setPopDivn(String popDivn) {
		this.popDivn = popDivn;
	}
	public String getSchPopCondition() {
		return schPopCondition;
	}
	public void setSchPopCondition(String schPopCondition) {
		this.schPopCondition = schPopCondition;
	}
	public String getSchPopKeyword() {
		return schPopKeyword;
	}
	public void setSchPopKeyword(String schPopKeyword) {
		this.schPopKeyword = schPopKeyword;
	}
	public int getPopPageIndex() {
		return popPageIndex;
	}
	public void setPopPageIndex(int popPageIndex) {
		this.popPageIndex = popPageIndex;
	}
	public String getTabDivn() {
		return tabDivn;
	}
	public void setTabDivn(String tabDivn) {
		this.tabDivn = tabDivn;
	}
	public List<HashMap<String, String>> getMapArr() {
		return mapArr;
	}
	public void setMapArr(List<HashMap<String, String>> mapArr) {
		this.mapArr = mapArr;
	}
	public String getTmplCnt() {
		return tmplCnt;
	}
	public void setTmplCnt(String tmplCnt) {
		this.tmplCnt = tmplCnt;
	}
	public String getDivn() {
		return divn;
	}
	public void setDivn(String divn) {
		this.divn = divn;
	}
	public String getTmplHtml() {
		return tmplHtml;
	}
	public void setTmplHtml(String tmplHtml) {
		this.tmplHtml = tmplHtml;
	}
	public String getTmplFileSerno() {
		return tmplFileSerno;
	}
	public void setTmplFileSerno(String tmplFileSerno) {
		this.tmplFileSerno = tmplFileSerno;
	}
	public String getPrvwFileSerno() {
		return prvwFileSerno;
	}
	public void setPrvwFileSerno(String prvwFileSerno) {
		this.prvwFileSerno = prvwFileSerno;
	}
	public String getFileSeqo() {
		return fileSeqo;
	}
	public void setFileSeqo(String fileSeqo) {
		this.fileSeqo = fileSeqo;
	}
	public String getRlFileNm() {
		return rlFileNm;
	}
	public void setRlFileNm(String rlFileNm) {
		this.rlFileNm = rlFileNm;
	}
	public String getFileExtnNm() {
		return fileExtnNm;
	}
	public void setFileExtnNm(String fileExtnNm) {
		this.fileExtnNm = fileExtnNm;
	}
	public String getFileSzVal() {
		return fileSzVal;
	}
	public void setFileSzVal(String fileSzVal) {
		this.fileSzVal = fileSzVal;
	}
	public String getFileTpNm() {
		return fileTpNm;
	}
	public void setFileTpNm(String fileTpNm) {
		this.fileTpNm = fileTpNm;
	}
	public String getImgWdthSzVal() {
		return imgWdthSzVal;
	}
	public void setImgWdthSzVal(String imgWdthSzVal) {
		this.imgWdthSzVal = imgWdthSzVal;
	}
	public String getImgHghtSzVal() {
		return imgHghtSzVal;
	}
	public void setImgHghtSzVal(String imgHghtSzVal) {
		this.imgHghtSzVal = imgHghtSzVal;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public byte[] getFileByte() {
		return fileByte;
	}
	public void setFileByte(byte[] fileByte) {
		this.fileByte = fileByte;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}	
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	public String getPreviewCont() {
		return previewCont;
	}
	public void setPreviewCont(String previewCont) {
		this.previewCont = previewCont;
	}
	public String getFvrtSerno() {
		return fvrtSerno;
	}
	public void setFvrtSerno(String fvrtSerno) {
		this.fvrtSerno = fvrtSerno;
	}
	public String getTmplCd() {
		return tmplCd;
	}
	public void setTmplCd(String tmplCd) {
		this.tmplCd = tmplCd;
	}
	public String getTmplTotalCnt() {
		return tmplTotalCnt;
	}
	public void setTmplTotalCnt(String tmplTotalCnt) {
		this.tmplTotalCnt = tmplTotalCnt;
	}
}
