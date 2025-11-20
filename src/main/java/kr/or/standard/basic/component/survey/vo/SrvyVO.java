package kr.or.standard.basic.component.survey.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.file.vo.FileVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data 
@Alias("cmSrvyVO")
public class SrvyVO  extends CmmnDefaultVO {

	public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}
    
    //설문조사
    @NotBlank(message = "설문조사 일련번호 : 필수 입력입니다.",groups = {updateCheck.class, deleteCheck.class})
    private String srvySerno; 		//설문조사 일련번호
    @NotBlank(message = "설문 명 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
    private String srvyNm;    		//설문 명
    @NotBlank(message = "설문 설명 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
    private String srvyExpl; 		//설문 설명
    private String atchFileId; 		//첨부파일 ID
    @NotBlank(message = "설문 시작일시 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
    private String srvyStrtDt; 		//설문 시작일시
    @NotBlank(message = "설문 종료일시 : 필수 입력입니다.",groups = {insertCheck.class, updateCheck.class})
    private String srvyEndDt; 		//설문 종료일시
    private String srvyMthd; 		//설문 방법
    private String srvyOvlpYn; 		//설문조사 중복 여부
    private String srvyOvlpCnt; 	//설문 중복 수
    private String srvyRsltYn; 		//설문 결과 여부
    private String srvySts; 		//설문 게시 상태
    private String srvyIng; 		// 설문 진행 단계
    private String srvyCount; 		// 설문 갯수
    private String srvyNextYn;  // 다음섹션 구분번호
    
    private String regrSerno;       // 등록자일련번호
    private String regrNm;          // 등록자명
    private String regDt;           // 등록일시
    private String updrSerno;       // 수정자일련번호
    private String updrNm;          // 수정자명
    private String updDt;           // 수정일시
    private String useYn;           // 사용여부
    
    
    // 섹션관리
    private String srvySctnSerno;   // 설문조사 섹션 일련번호
    private String srvyNextSctnNo;  // 다음섹션 구분번호
    private String srvySctnTitl;    // 섹션 명
    private String srvySctnCtt;     // 섹션 내용
    private String srvySctnNo;      // 섹션 번호
    private List<SrvyVO> sctnList; 
    
    // 질문관리
    private String srvyQstSerno;  	// 설문조사 질문 일련번호
    private String srvyQstTitl;    // 섹션 명
    private String srvyQstCtt;     // 섹션 내용
    private String srvyNcsrYn;   	// 필수 여부
    private String srvyChcCnt;   	// 선택 가능 수
    private List<SrvyVO> qstList;
    
    // 질문항목
    private String srvyQstItmSerno; // 설문조사 질문 일련번호
    private String srvyQstItmCtt;  	// 설문조사 질문항목 내용
    private String srvyItmTpVal1;  	// 설문조사 항목유형값1
    private String srvyItmTpVal2;  	// 설문조사 항목유형값2
    private String srvyItmTpVal3;  	// 설문조사 항목유형값3
    private String srvyItmTpVal4;  	// 설문조사 항목유형값4
    private String srvyItmTpVal5;  	// 설문조사 항목유형값5
    private List<SrvyVO> qstItmList;
    
    
    private String selectOption;	//유형선택 값
    private String sectionLength;	//유형선택 값
    private String srvyNextSctnYn; 	// 다음글 이동여부
    private String srvyUpdateYn;	// 업데이트 가능 여부
    private String srvyClCd;		// 설문 관리자/사용자 구분
    private String srvyAnsCnt;		// 설문 답변 갯수
    private String srvyYn;			// 설문조사 기간 해당여부
    
    private String fileSeqo;		// 파일순서 
    private String fileNmPhclFileNm;// 물리파일명
    
    // 답변
    private String srvyAnsSerno;	// 설문조사 대상자
    private String srvyAnsCttEtc; 	// 설문 답변 기타
    private String srvyAnsCtt; 		// 설문 답변
    private String srvyAnsCgVal;   	// 설문조사 질문 분류 값
    private String srvyAnsCgValNm;  // 설문조사 질문 분류 값 명칭
    private String rplyCtt; 		// 설문 답변
    private List<SrvyVO> rplyList;
    
    private List<FileVO> atchFileList;
    
    private String excelDivn;		// 엑셀다운로드 구분
    
    private String q0; private String q1; private String q2; private String q3; private String q4; 
    private String q5; private String q6; private String q7; private String q8; private String q9; 
    private String q10; private String q11; private String q12; private String q13; private String q14;
    private String q15; private String q16; private String q17; private String q18; private String q19;
    private String q20; private String q21; private String q22; private String q23; private String q24;
    private String q25; private String q26; private String q27; private String q28; private String q29;
    private String q30; private String q31; private String q32; private String q33; private String q34;
    private String q35; private String q36; private String q37; private String q38; private String q39;
    private String q40; private String q41; private String q42; private String q43; private String q44;
    private String q45; private String q46; private String q47; private String q48; private String q49;
    private String q50; private String q51; private String q52; private String q53; private String q54;
    private String q55; private String q56; private String q57; private String q58; private String q59;
    private String q60; private String q61; private String q62; private String q63; private String q64;
    private String q65; private String q66; private String q67; private String q68; private String q69;
    private String q70; private String q71; private String q72; private String q73; private String q74;
    private String q75; private String q76; private String q77; private String q78; private String q79;
    private String q80; private String q81; private String q82; private String q83; private String q84;
    private String q85; private String q86; private String q87; private String q88; private String q89;
    private String q90; private String q91; private String q92; private String q93; private String q94;
    private String q95; private String q96; private String q97; private String q98; private String q99;
    private String q100; 
}
