package kr.or.standard.basic.component.schedule.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "OpenAPI_ServiceResponse")
public class CmHdayResponseErrorVO {
    private CmmMsgHeader cmmMsgHeader;

    @XmlElement(name = "cmmMsgHeader")
    public CmmMsgHeader getCmmMsgHeader() {
        return cmmMsgHeader;
    }

    public void setCmmMsgHeader(CmmMsgHeader cmmMsgHeader) {
        this.cmmMsgHeader = cmmMsgHeader;
    }

    public static class CmmMsgHeader extends CmmnDefaultVO {
    	private String errMsg;
    	private String returnAuthMsg;
    	private String returnReasonCode;
    	
    	@XmlElement(name = "errMsg")
    	public String getErrMsg() {
    		return errMsg;
    	}
    	
    	public void setErrMsg(String errMsg) {
    		this.errMsg = errMsg;
    	}
    	
    	@XmlElement(name = "returnAuthMsg")
    	public String getReturnAuthMsg() {
    		return returnAuthMsg;
    	}
    	
    	public void setReturnAuthMsg(String returnAuthMsg) {
    		this.returnAuthMsg = returnAuthMsg;
    	}
    	
    	@XmlElement(name = "returnReasonCode")
    	public String getReturnReasonCode() {
    		return returnReasonCode;
    	}
    	
    	public void setReturnReasonCode(String returnReasonCode) {
    		this.returnReasonCode = returnReasonCode;
    	}
    }
}
