package kr.or.opennote.itsm.common.file.vo;
 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Alias("itsmFileVO")
public class ItsmFileVO extends ItsmCommonDefaultVO {
	public ItsmFileVO() {

	}

	public ItsmFileVO(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	// 첨부파일 아이디.
	private String atchFileId;
	private List<MultipartFile> files;
	// 파일순서.
	private String fileSeqo;
	// 물리파일경로명.
	private String phclFilePthNm;
	// 파일명물리파일명.
	private String fileNmPhclFileNm;
	// 파일실제명.
	private String fileRlNm;
	// 파일확장자명.
	private String fileFextNm;
	// 파일내용.
	private String fileCtt;
	// 파일크기값.
	private String fileSizeVal;
	// 파일유형명.
	private String fileTpNm;
	// 파일참조값.
	private String fileRefVal;
	// 이미지넓이값.
	private String imgSqrVal;
	// 이미지높이값.
	private String imgHghtVal;
	// 삭제여부.
	private String delYn;
	// 바이트화 시킨 파일
	private byte[] fileByte;

	private String deleteFileJsonString;

	/**
	 * 첨부파일ID
	 */
	private String atchmnflId;
	/**
	 * 첨부파일일련번호
	 */
	private String atchmnflSn;
	/**
	 * 첨부파일명
	 */
	private String atchmnflNm;
	/**
	 * 첨부파일url
	 */
	private String atchFileUrl;
	/**
	 * 첨부파일경로
	 */
	private String atchmnflCoursNm;
	/**
	 * 파일크기
	 */
	private String fileMg;
	/**
	 * 저장파일명
	 */
	private String streFileNm;
	/**
	 * 확장자명
	 */
	private String extsnNm;
	private byte[] atcFileImgDat;
	private String txtData;
	/**
	 * 파일명
	 */
	private String fileName;
	/**
	 * 에디터 문서처리용
	 */
	private int[] serializedData;
	/**
	 * 에디터 문서처리용 경로
	 */
	private String importPath;
	private List fileInfo;
	/**
	 * 뷰어 문서 경로
	 */
	private String viewerPath;
	/**
	 * 뷰어타겟스트링
	 */
	private String viewerTarget;
	
	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public List<MultipartFile> getFiles() {
		return files;
	}

	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}

	public String getFileSeqo() {
		return fileSeqo;
	}

	public void setFileSeqo(String fileSeqo) {
		this.fileSeqo = fileSeqo;
	}

	public String getPhclFilePthNm() {
		return phclFilePthNm;
	}

	public void setPhclFilePthNm(String phclFilePthNm) {
		this.phclFilePthNm = phclFilePthNm;
	}

	public String getFileNmPhclFileNm() {
		return fileNmPhclFileNm;
	}

	public void setFileNmPhclFileNm(String fileNmPhclFileNm) {
		this.fileNmPhclFileNm = fileNmPhclFileNm;
	}

	public String getFileRlNm() {
		return fileRlNm;
	}

	public void setFileRlNm(String fileRlNm) {
		this.fileRlNm = fileRlNm;
	}

	public String getFileFextNm() {
		return fileFextNm;
	}

	public void setFileFextNm(String fileFextNm) {
		this.fileFextNm = fileFextNm;
	}

	public String getFileCtt() {
		return fileCtt;
	}

	public void setFileCtt(String fileCtt) {
		this.fileCtt = fileCtt;
	}

	public String getFileSizeVal() {
		return fileSizeVal;
	}

	public void setFileSizeVal(String fileSizeVal) {
		this.fileSizeVal = fileSizeVal;
	}

	public String getFileTpNm() {
		return fileTpNm;
	}

	public void setFileTpNm(String fileTpNm) {
		this.fileTpNm = fileTpNm;
	}

	public String getFileRefVal() {
		return fileRefVal;
	}

	public void setFileRefVal(String fileRefVal) {
		this.fileRefVal = fileRefVal;
	}

	public String getImgSqrVal() {
		return imgSqrVal;
	}

	public void setImgSqrVal(String imgSqrVal) {
		this.imgSqrVal = imgSqrVal;
	}

	public String getImgHghtVal() {
		return imgHghtVal;
	}

	public void setImgHghtVal(String imgHghtVal) {
		this.imgHghtVal = imgHghtVal;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}

	public String getDeleteFileJsonString() {
		return deleteFileJsonString;
	}

	public void setDeleteFileJsonString(String deleteFileJsonString) {
		this.deleteFileJsonString = deleteFileJsonString;
	}

	public String getAtchmnflId() {
		return atchmnflId;
	}

	public void setAtchmnflId(String atchmnflId) {
		this.atchmnflId = atchmnflId;
	}

	public String getAtchmnflSn() {
		return atchmnflSn;
	}

	public void setAtchmnflSn(String atchmnflSn) {
		this.atchmnflSn = atchmnflSn;
	}

	public String getAtchmnflNm() {
		return atchmnflNm;
	}

	public void setAtchmnflNm(String atchmnflNm) {
		this.atchmnflNm = atchmnflNm;
	}

	public String getAtchFileUrl() {
		return atchFileUrl;
	}

	public void setAtchFileUrl(String atchFileUrl) {
		this.atchFileUrl = atchFileUrl;
	}

	public String getAtchmnflCoursNm() {
		return atchmnflCoursNm;
	}

	public void setAtchmnflCoursNm(String atchmnflCoursNm) {
		this.atchmnflCoursNm = atchmnflCoursNm;
	}

	public String getFileMg() {
		return fileMg;
	}

	public void setFileMg(String fileMg) {
		this.fileMg = fileMg;
	}

	public String getStreFileNm() {
		return streFileNm;
	}

	public void setStreFileNm(String streFileNm) {
		this.streFileNm = streFileNm;
	}

	public String getExtsnNm() {
		return extsnNm;
	}

	public void setExtsnNm(String extsnNm) {
		this.extsnNm = extsnNm;
	}

	public byte[] getAtcFileImgDat() {
		return atcFileImgDat;
	}

	public void setAtcFileImgDat(byte[] atcFileImgDat) {
		this.atcFileImgDat = atcFileImgDat;
	}

	public String getTxtData() {
		return txtData;
	}

	public void setTxtData(String txtData) {
		this.txtData = txtData;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int[] getSerializedData() {
		return serializedData;
	}

	public void setSerializedData(int[] serializedData) {
		this.serializedData = serializedData;
	}

	public String getImportPath() {
		return importPath;
	}

	public void setImportPath(String importPath) {
		this.importPath = importPath;
	}

	public List getFileInfo() {
		return fileInfo;
	}

	public void setFileInfo(List fileInfo) {
		this.fileInfo = fileInfo;
	}

	public String getViewerPath() {
		return viewerPath;
	}

	public void setViewerPath(String viewerPath) {
		this.viewerPath = viewerPath;
	}

	public String getViewerTarget() {
		return viewerTarget;
	}

	public void setViewerTarget(String viewerTarget) {
		this.viewerTarget = viewerTarget;
	}

	public byte[] getFileByte() {
		return fileByte;
	}

	public void setFileByte(byte[] fileByte) {
		this.fileByte = fileByte;
	}
	
	
}
