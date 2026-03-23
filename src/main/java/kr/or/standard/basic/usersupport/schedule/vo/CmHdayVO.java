package kr.or.standard.basic.usersupport.schedule.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 
@Data
@Alias("cmHdayVO")
public class CmHdayVO extends CmmnDefaultVO {
	
	private String hdaySerno;
	private String hdayDt;
	private String hdayNm;
	private String hdayYn;
	private String regUser;
	private String regDate;
	private String useYn; 
	
}
