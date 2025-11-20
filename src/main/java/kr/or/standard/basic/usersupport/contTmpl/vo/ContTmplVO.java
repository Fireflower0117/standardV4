package kr.or.standard.basic.usersupport.contTmpl.vo;

import java.util.HashMap;
import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;
 

@Alias("contTmplVO")
@Data
public class ContTmplVO  extends CmmnDefaultVO {
	
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
	private String isRegrCheck;
	private String isFileRegrCheck; 
	
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
	private String contTmplCount;
	
	
	 
}
