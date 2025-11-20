package kr.or.standard.basic.component.schedule.vo;

import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 
@Data
@Alias("cmSchdVO")
public class CmSchdVO extends CmmnDefaultVO {

	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}

	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String schdSerno;
	@NotBlank(message = "일정구분 : 필수 선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String schdClCd;
	@NotBlank(message = "일정시간코드 : 필수 선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String schdHhCd;
	@NotBlank(message = "일정시작일시 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String schdStrtDt;
	@NotBlank(message = "일정종료일시 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String schdEndDt;
	@NotBlank(message = "일정명 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String schdTitlNm;
	@NotBlank(message = "일정내용 : 필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String schdCtt;
	@NotBlank(message = "업무연계 : 필수 선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String jobConYn;
	private String regrSerno;
	private String regDt;
	private String regrNm;
	private String updrSerno;
	private String updDt;
	private String useYn;
	
	private String schdClNm;		// 일정구분명
	private String schdStrtYmd;		// 시작일	
	private String schdEndYmd;		// 종료일
	private String schdStrtHhMn;	// 시작시간분
	private String schdEndHhMn;		// 종료시간분
	private String selYear;			// 선택 년
	private String selMonth;		// 선택 월
	private String selDate;			// 선택 일
	private String currentDate;		// 오늘 날짜
	private String schdEndYn;		// 일정종료여부
	private String schdCount;
	private String isRegrCheck;
	 
}
