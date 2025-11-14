package kr.or.opennote.basic.board.vo;


import javax.validation.constraints.NotBlank;

import kr.or.opennote.basic.common.domain.CmmnDefaultVO;
import org.apache.ibatis.type.Alias;
 

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
	
	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getBoardSerno() {
		return boardSerno;
	}

	public void setBoardSerno(String boardSerno) {
		this.boardSerno = boardSerno;
	}

	public String getBoardTitl() {
		return boardTitl;
	}

	public void setBoardTitl(String boardTitl) {
		this.boardTitl = boardTitl;
	}

	public String getBoardCtt() {
		return boardCtt;
	}

	public void setBoardCtt(String boardCtt) {
		this.boardCtt = boardCtt;
	}

	public String getRegrSerno() {
		return regrSerno;
	}

	public void setRegrSerno(String regrSerno) {
		this.regrSerno = regrSerno;
	}

	public String getRegrNm() {
		return regrNm;
	}

	public void setRegrNm(String regrNm) {
		this.regrNm = regrNm;
	}

	public String getUpdDt() {
		return updDt;
	}

	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}

	public String getUpdrSerno() {
		return updrSerno;
	}

	public void setUpdrSerno(String updrSerno) {
		this.updrSerno = updrSerno;
	}

}
