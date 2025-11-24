package kr.or.standard.basic.usersupport.dictionary.word.vo;

import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;
 

import javax.validation.constraints.NotBlank;

@Data
@Alias("cmWrdVO")
public class WordVO extends CmmnDefaultVO {

    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    @NotBlank(groups = {updateCheck.class, deleteCheck.class})
    private String wrdSerno;       // 단어일련번호
    @NotBlank(message = "단어명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String wrdNm;          // 단어명
    @NotBlank(message = "영문명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String engNm;           // 영문명
    @NotBlank(message = "영문약어명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String engAbrvNm;       // 영문약어명
    @NotBlank(message = "단어설명 : 필수 입력입니다.", groups = {updateCheck.class, insertCheck.class})
    private String wrdExpl;         // 단어설명
    private String stdWrd;          // 표준단어
    private String wrdTp;           // 단어유형
    private String regrSerno;       // 등록자일련번호
    private String regrNm;          // 등록자명
    private String regDt;           // 등록일시
    private String updrSerno;       // 수정자일련번호
    private String updrNm;          // 수정자명
    private String updDt;           // 수정일시
    private String useYn;           // 사용여부
    private String wrdCount;        // 단어수
 
}
