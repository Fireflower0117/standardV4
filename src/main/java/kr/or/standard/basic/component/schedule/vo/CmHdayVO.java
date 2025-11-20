package kr.or.standard.basic.component.schedule.vo;

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
	private String regrSerno;
	private String regDt;
	private String updrSerno;
	private String updDt;
	private String useYn; 
	
}
