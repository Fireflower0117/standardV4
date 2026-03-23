package kr.or.standard.basic.common.file.vo;


import java.util.Arrays;
import java.util.List;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

@Data
@ToString
@Alias("fileVO")
public class FileVO extends CmmnDefaultVO {
  	
  	public FileVO(){} 
  	
	public FileVO(String atchFileId) {
		  this.atchFileId = atchFileId;
	}

	private String atchFileId;              /* 첨부파일 아이디. */
	private List<MultipartFile> files;      /* 파일리스트 */
	private String fileSeqo;                /* 파일순서. AS-IS */
	private String fileSn;                  /* 파일순서. TO-BE */
	private String phclFilePthNm;           /* 물리파일경로명. */
	private String fileNmPhclFileNm;        /* 파일명물리파일명. */
	private String fileRlNm;                /* 파일실제명. */
	private String fileFextNm;              /* 파일확장자명. */
	private String fileCtt;                 /* 파일내용. */
	private String fileSizeVal;             /* 파일크기값. */
	private String fileTpNm;                /* 파일유형명. */
	private String fileRefVal;              /* 파일참조값. */
	private String imgSqrVal;               /* 이미지넓이값. */
	private String imgHghtVal;              /* 이미지높이값. */
	private String delYn;                   /* 삭제여부. */
	private byte[] fileByte;                /* 바이트화 시킨 파일 */
	private String deleteFileJsonString;    /* 삭제File Json */
	private String atchmnflId;              /* 첨부파일ID */
	private String atchmnflSn;              /* 첨부파일일련번호 */
	private String atchmnflNm;              /* 첨부파일명 */
	private String atchFileUrl;             /* 첨부파일url */
	private String atchmnflCoursNm;         /* 첨부파일경로 */
	private String fileMg;                  /* 첨부파일 크기(용량) */
	private String streFileNm;              /* 저장파일명 */
	private String extsnNm;                 /* 확장자명 */
	private byte[] atcFileImgDat;           /* 첨부파일 Dat (Byte) */
	private String txtData;                 /* txtData */
	private String fileName;                /* 파일명 */
	private int[] serializedData;           /* 에디터 문서처리용 */
	private String importPath;              /* 에디터 문서처리용 경로 */
	private List fileInfo;                  /* fileInfo */
	private String viewerPath;              /* 뷰어 문서 경로 */
	private String viewerTarget;            /* 뷰어타겟스트링 */
	private String regrSerno;               /* 등록자 일련번호 */
	private String regrNm;                  /* 등록자 이름 */
	private String cmd;                     /* 명령어 */
	private String rn_top;                  /* 명령어 */
	private String rn_bottom;               /* 명령어 */
	private int rn_limit;                   /* 명령어 */
	private String tempcol1;                /* 임시칼럼1 */
	private String tempcol2;                /* 임시칼럼2 */
	private String tempcol3;                /* 임시칼럼3 */
	private String tempcol4;                /* 임시칼럼4 */
	private String tempcol5;                /* 임시칼럼5 */


}

