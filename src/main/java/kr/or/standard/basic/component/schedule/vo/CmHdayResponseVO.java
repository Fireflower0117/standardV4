package kr.or.standard.basic.component.schedule.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "response")
public class CmHdayResponseVO {
	
	private Header header;
    private Body body;

    @XmlElement(name = "header")
    public Header getHeader() {
        return header;
    }

    public void setHeader(Header header) {
        this.header = header;
    }

    @XmlElement(name = "body")
    public Body getBody() {
        return body;
    }

    public void setBody(Body body) {
        this.body = body;
    }
	
    @XmlRootElement(name = "header")
	public static class Header {
        private String resultCode;
        private String resultMsg;

        @XmlElement(name = "resultCode")
        public String getResultCode() {
            return resultCode;
        }

        public void setResultCode(String resultCode) {
            this.resultCode = resultCode;
        }

        @XmlElement(name = "resultMsg")
        public String getResultMsg() {
            return resultMsg;
        }

        public void setResultMsg(String resultMsg) {
            this.resultMsg = resultMsg;
        }
    }
	
    @XmlRootElement(name = "body")
	public static class Body {
        private Items items;

        @XmlElement(name = "items")
        public Items getItems() {
            return items;
        }

        public void setItems(Items items) {
            this.items = items;
        }
        
    }
    
    @XmlRootElement(name = "items")
    public static class Items {
    	private List<CmHdayResponseItem> itemList;
    	
    	@XmlElement(name = "item")
    	public List<CmHdayResponseItem> getItemList() {
    		return itemList;
    	}
    	
    	public void setItemList(List<CmHdayResponseItem> itemList) {
    		this.itemList = itemList;
    	}
    	
    }
    
    @XmlRootElement(name = "item")
    public static class CmHdayResponseItem extends CmmnDefaultVO {
    	private String dateKind;	// 종류
    	private String dateName;	// 명칭
    	private String isHoliday;	// 공공기관 휴일여부
    	private String locdate;		// 날짜
    	
    	@XmlElement(name = "dateKind")
    	public String getDateKind() {
    		return dateKind;
    	}
    	public void setDateKind(String dateKind) {
    		this.dateKind = dateKind;
    	}
    	
    	@XmlElement(name = "dateName")
    	public String getDateName() {
			return dateName;
		}
		public void setDateName(String dateName) {
			this.dateName = dateName;
		}
		
    	@XmlElement(name = "isHoliday")
    	public String getIsHoliday() {
    		return isHoliday;
    	}
		public void setIsHoliday(String isHoliday) {
    		this.isHoliday = isHoliday;
    	}
    	
    	@XmlElement(name = "locdate")
    	public String getLocdate() {
    		return locdate;
    	}
    	public void setLocdate(String locdate) {
    		this.locdate = locdate;
    	}
    	
		@Override
		public String toString() {
			return "CmHdayResponseItem [dateKind=" + dateKind + ", dateName=" + dateName + ", isHoliday=" + isHoliday
					+ ", locdate=" + locdate + "]";
		}
    }
}
