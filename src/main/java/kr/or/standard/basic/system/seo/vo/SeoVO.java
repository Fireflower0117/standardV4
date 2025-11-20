package kr.or.standard.basic.system.seo.vo;

import java.util.List;
import javax.validation.constraints.NotBlank;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data 
@Alias("seoVO")
public class SeoVO extends CmmnDefaultVO {

    public SeoVO() { }

    public SeoVO(String optType, String probTag, String probCont, String probTips, String probEx, String optTypeDeNo) {
        this.optType = optType;
        this.probTag = probTag;
        this.probTips = probTips;
        this.probCont = probCont;
        this.probEx = probEx;
        this.optTypeDeNo = optTypeDeNo;
    }
    
    
    private String optType;                             /*최적화 종류*/ 
    private String probTag;                            /*최적화 안된 태그*/
    private String probTips;                        /*최적화 권장사항*/
    private String probCont;                        /*최적화 내용*/
    private String probEx;                            /*최적화 권장예시*/
    private String optTypeDeNo;                         /*최적화 유형 상세번호*/

    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}

    @NotBlank(message = "도메인명을 입력해주세요", groups = {insertCheck.class})
    private String vcUrl;
    private String seoType;                              /*seo종류(네이버,구글)*/
    private String domainUrl;                         /*가공된 도메인 주소*/
    private String seoSerno;                          /*seo 일련번호*/
    private String metaTageResult;                    /*메타태그 존재여부*/

    //네이버SEO 추가 조건
    private String metaTitleEqualYn;                  /*메타 타이틀끼리 동일 여부*/
    private String metaTitleOptYn;                      /*메타 타이틀 내용 최적화 여부*/
    private String metaDescrpOptYn;                      /*메타 설명 내용 최적화 여부*/

    private String sitemapResult;                     /*사이트맵 존재여부*/
    private String robotsResult;                      /*robots.txt 존재여부*/
    private String snsOptiResult;                     /*소셜미디어 최적화 여부*/

    //네이버SEO 추가 조건
    private String frameUseResult;                    /*frame 태그 사용 여부*/
    private String imgOptiResult;                     /*이미지 최적화 여부*/
    private String mobileYn;                          /*모바일 여부*/
    private String loadTimeResult;                      /*로딩시간 결과*/

    private String headingOneResult;                      /*h1표제 결과*/
    private String headingOtherResult;                  /*h1 이외 결과*/

    private String linkOptResult;                        /*link 최적화 결과*/

    private String conYn;                             /*연결여부*/
    private String titleMetaYn;                       /*meta title 존재여부*/
    private String descriptionMetaYn;                 /*meta description 존재여부 */
    private String charsetMetaYn;                     /*meta charset 존재여부*/
    private String uaCompatibleMetaYn;                /*meta uaCompatible 존재여부*/
    private String viewportMetaYn;                    /*meta viewportMeta 존재여부 */
    private String ogTypeMetaYn;                      /*meta ogType 존재여부*/
    private String ogTitleMetaYn;                     /*meta ogTitle 존재여부*/
    private String ogDescriptionMetaYn;               /*meta ogDescription 존재여부*/
    private String ogImageMetaYn;                     /*meta ogImage 존재여부*/
    private String ogUrlMetaYn;                       /*meta ogUrl 존재여부*/

    private String imgUprightUseResult;               /*이미지 올바른 사용결과*/
    private String imgUprightUseMessage;              /*올바른 사용결과 상세내용*/
    private String imgNmOptiResult;                   /*이미지 이름 최적화 결과*/
    private String imgNmOptiMessage;                  /*이미지 이름 최적화 상세내용*/
    private String imgCaptionResult;                  /*이미지 캡션 사용 결과*/
    private String imgCaptionMessage;                 /*이미지 캡션 사용 상세내용*/
    private String imgResponOptiResult;               /*이미지 반응형 이미지 최적화 결과*/
    private String imgResponOptiMessage;               /*이미지 반응형 이미지 최적화 결과*/
    private String imgOverYn;                          /*이미지 용량 줄이기 여부*/
    private String imgOverMessage;                      /*이미지 용량 줄이기 상세내용*/

    private String urlStructResult;                   /*url 구조 결과*/
    private String urlHyphenYn;                       /*url 하이픈 존재 여부*/
    private String urlAscIIYn;                        /*url ASCII 사용 여부*/
    private String urlLognIdyn;                       /*url 긴ID사용여부*/
    private String hreflangYn;                        /*hreflang태그 존재여부*/
    private String hreflangMessage;                   /*hreflang태그 상세내용*/
    private String canonicalYn;                       /*canonical 태그 존재여부*/
    private String fontSizeOptYn;                      /*font-size 최적화 여부*/

    private String loadTime;                          /*페이지 로딩 시간*/

    private String headingOneYn;                         /*h1표제 사용여부*/
    private String headingOneContYn;                /*h1표제 컨텐츠 여부*/
    private String headingOneMessage;                /*h1표제 상세내용*/
    private String headingOtherYn;                    /*h1 이외 사용여부*/
    private String headingOtherContYn;                /*h1 이외 컨텐츠 여부*/
    private String headingOtherMessage;            /*h1 이외 상세내용*/

    private String linkOptFncYn;                      /* 함수 사용 여부 */
    private String linkOptATagYn;                      /* href 적정 사용 여부 */
    private String linkOptATagTxtYn;                  /* a태그 빈 텍스트 여부*/

    private int fitCnt;                          /*적합 총계*/
    private int unfitCnt;                          /*부적합 총계*/
    private int subparCnt;                          /*미흡 총계*/

    private float totalScore;                          /*점수 합계*/

    private String regDt;
    private String seoCount;

    //이미지 서브테이블용 컬럼
    private List<SeoVO> imgSubList;


}	
