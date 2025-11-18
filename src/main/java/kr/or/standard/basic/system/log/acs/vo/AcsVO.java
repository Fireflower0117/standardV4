package kr.or.standard.basic.system.log.acs.vo;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data  
@Alias("acsVO")
public class AcsVO extends CmmnDefaultVO {

	private String acsLogSerno;				// 접속로그일련번호
	private String acsLogIpAddr;			// 접속로그IP주소
	private String ipErrYn;					// IP오류여부
	private String lginYn;					// 로그인여부
	private String lginLmtYn;				// 로그인제한여부
	private String acsId;					// 접근ID
	private String authAreaCd;				// 권한영역코드
	private String acsLogCnt;				// 접근기록수
	
	private String regrSerno;				// 등록자일련번호
	private String regDt;					// 등록일시
	private String updrSerno;				// 수정자일련번호
	private String updDt;					// 수정일시

	private String regrNm;					// 등록자명
	private String logCnt;					// 접속자수
 
}
