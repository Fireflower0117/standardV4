package kr.or.standard.basic.usersupport.popup.vo;

import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data 
@Alias("popupVO")
public class PopupVO  extends CmmnDefaultVO {
	
	public interface insertCheck{}
	public interface updateCheck{}
	public interface deleteCheck{}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String popupSerno;
	@NotBlank(message = "팝업제목 : 필수입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupTitlNm;
	@NotBlank(message = "팝업게시여부 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupPstnYn;
	@NotBlank(message = "팝업게시기간 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupPstnPrdYn;
	private String popupPstnStrtDt;
	private String popupPstnEndDt;
	private String popupWdthSizeVal;
	private String popupHghtSizeVal;
	private String repImgId;
	@NotBlank(message = "팝업대상 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupTgtCd;
	private String popupUpndMargnVal;
	private String popupLsdMargnVal;
	@NotBlank(message = "팝업내용 : 필수입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupCtt;
	@NotBlank(message = "팝업구분 : 필수선택입니다.", groups = {insertCheck.class, updateCheck.class})
	private String popupClCd;
	private String regrSerno;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn;
	private String popupCount;
	private String isRegrCheck;
	
	
	private String regrNm;
	private String repImgSrc;	// 팝업 이미지 경로
	private String popupClNm;	// 팝업구분명
	private String popupTgtNm;	// 팝업대상명
	
	private String fileSeqo;		// 파일순서
	private String phclFileNm;	// 물리파일명
	
}
