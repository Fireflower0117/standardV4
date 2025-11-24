package kr.or.standard.basic.component.dataqualiry.dbdata.vo;
 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Data
@Alias("cmDbDataVO")
public class DBdataVO  extends CmmnDefaultVO {

    private String tableSchema;             // 스키마
    private String tableName;               // 테이블명
    private String tableComment;            // 테이블한글명
    private String tableRows;               // 데이터개수
    private String createTime;              // 테이블생성일
    private String updateTime;              // 테이블수정일
    private String columnCnt;               // 컬럼개수
    private String dbKndCd;                 // DB종류

    private String columnName;              // 컬럼영문명
    private String columnComment;           // 컬럼한글명
    private String columnType;              // 데이터타입(길이)
    private String isNullable;              // NULL여부
    private String columnKey;               // PK여부
    private String columnDefault;           // 기본값

    private String stdCd;                   // 표준코드
    private String stdCdNm;                 // 표준코드명
    private String tableCount;              // 테이블수
    private String termCount;               // 용어수

    private List<DBdataVO> colList;
     
}
