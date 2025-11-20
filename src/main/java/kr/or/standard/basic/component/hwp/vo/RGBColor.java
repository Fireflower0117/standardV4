package kr.or.standard.basic.component.hwp.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class RGBColor {
    
     private short r, g, b;
     
     public RGBColor(short r, short g, short b) {
        setR(r);
        setG(g);
        setB(b);
    }  
    
}
