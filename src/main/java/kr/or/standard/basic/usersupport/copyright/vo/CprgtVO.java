package kr.or.standard.basic.usersupport.copyright.vo;


import javax.validation.constraints.NotBlank;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 
@Data
@Alias("cprgtVO")
public class CprgtVO  extends CmmnDefaultVO {
    
	public interface insertCheck {}
	public interface updateCheck {}
	public interface deleteCheck {}
	
	@NotBlank(groups = {updateCheck.class, deleteCheck.class})
	private String cprgtSerno;
	@NotBlank(message = "저작권 내용 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String cprgtCtt;
	@NotBlank(message = "우편번호 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coPostNo;
	@NotBlank(message = "도로명주소 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coAddr;
	@NotBlank(message = "지번주소 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coLtnoAddr;
	@NotBlank(message = "상세주소 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coDtlsAddr;
	private String coEngAddr;
	@NotBlank(message = "팩스번호 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coFaxNo;
	@NotBlank(message = "유선번호 :  필수 입력입니다.", groups = {insertCheck.class, updateCheck.class})
	private String coTelNo;
	private String regrSerno;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn;
	private String cprgtCount;

}
