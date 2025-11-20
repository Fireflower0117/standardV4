package kr.or.standard.basic.component.hwp.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CmHwpVO {

    private double width, height;
    private int type, colspan, rowspan;
    private String text;

}
