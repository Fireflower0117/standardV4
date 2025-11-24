package kr.or.standard.basic.board.vo;

import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("boardVO")
public class BoardVO extends CmmnDefaultVO {
	
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String boardSerno;
	
	@NotBlank(message = "제목 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String boardTitl;

	@NotBlank(message = "내용 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
	private String boardCtt;
	
	private String useYn;
	private String regDt;
	private String regrSerno;
	private String regrNm;
	private String updDt;
	private String updrSerno;
	private String boardCount;
	private String isRegrChk;

}
