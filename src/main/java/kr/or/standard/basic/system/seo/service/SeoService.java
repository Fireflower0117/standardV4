package kr.or.standard.basic.system.seo.service;

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.seo.vo.SeoVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.apache.hc.client5.http.HttpResponseException;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.HttpEntity;
import org.apache.hc.core5.http.ParseException;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.util.Timeout;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.htmlunit.cssparser.dom.AbstractCSSRuleImpl;
import org.htmlunit.cssparser.dom.CSSRuleListImpl;
import org.htmlunit.cssparser.dom.CSSStyleRuleImpl;
import org.htmlunit.cssparser.dom.CSSStyleSheetImpl;
import org.htmlunit.cssparser.parser.CSSOMParser;
import org.htmlunit.cssparser.parser.InputSource;
import org.jsoup.Connection;
import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.text.DecimalFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Service
@Transactional
@RequiredArgsConstructor
public class SeoService extends EgovAbstractServiceImpl  {
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
    private final PaginationService paginationService; 
	private final MessageSource messageSource;
	private final ExcelView excelView;
    
    private String robotsResult = "";			//robots.txt
    private int highImgCnt = 0;   			//고화질
    private int lightImgCnt = 0;  			//가벼운이미지
    private int liImgCnt = 0;     			//로고,아이콘
    private int nomalImgCnt =0 ;  			//일반이미지 건수
    private int imgOverVol = 0;   			//고화질 오버 용량 건수

    private int mediaCnt = 0;            	//@media 건수
    private int imgSetCnt = 0;           	//image-set 건수

    private  int h1AllCnt = 0;				//<h1> 태그 총갯수
    private  int h1NoneCnt = 0;			    //<h1> 부적합 총갯수
    private  int hOtherAllCnt = 0;			//headings 태그 총갯수
    private  int hOtherNoneCnt = 0;			//headings 태그 부적합 총갯수
    
    private static List<SeoVO> imgSubList = new ArrayList<>(); 
    private List<Map<String,String>> fontLess = new ArrayList<>(); 
    private final static String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36";


    private int fitCnt = 0; 				// 적합총계
    private int unfitCnt = 0; 				// 부적합총계
    private int subparCnt = 0; 				// 미흡총계
    private int mobileCnt = 0; 				//모바일 적합 여부 갯수
    private String siteMapUrl = "";         //robots.txt 파일 sitemap.xml url
    
    
    public void addList(SeoVO searchVO, Model model){
        
		//검증 URL
		searchVO.setVcUrl(searchVO.getSearchKeyword());

		//사용자가 url마지막에 /입력시 제거하는로직
		if (searchVO.getVcUrl() != null && searchVO.getVcUrl().endsWith("/")) {
			searchVO.setVcUrl(searchVO.getVcUrl().substring(0, searchVO.getVcUrl().length() - 1));
		}

		//googleSeo 검증 실행
		SeoVO seoVO = gSeoVerification(searchVO.getVcUrl(),searchVO.getSearchCondition());
		
		float fitCnt = seoVO.getFitCnt();
		float subparCnt = seoVO.getSubparCnt();
		float unfitCnt = seoVO.getUnfitCnt();
		
		float temp = (fitCnt+(subparCnt/2))/(fitCnt+subparCnt+unfitCnt)*100;
		
		seoVO.setTotalScore(temp = Float.isNaN(temp) ? 0 : temp);
		
		model.addAttribute("seoVO", seoVO);
    
    }
    
    
    //SEO 검증 서비스
    public SeoVO gSeoVerification(String vcUrl,String seoType) {

        int imgTotalCnt = 0;        //위의 전체 건수
        int imgOptiCnt = 0;         //이미지 적합 건수
        int altCnt = 0;             //img altTag 건수
        int titleCnt = 0;           //img titleTag 건수
        int srcsetCnt = 0;          //srcset 건수
        int sizes = 0;              //sizes 건수
        int imgNmOverCnt = 0;       //img 명칭 20자 이상인경우
        int imgNmblankCnt = 0;       //img 명칭 공백 있는 경우
        int imgUnderCnt = 0;         //언더스코어 2개 이상인 경우
        int metaTagCnt = 0;          //metaTag 사용 건수
        int metaTagOgCnt = 0;       //metaTag Og tag 사용 건수
        int urlStructCnt = 0;        //URL 구조 성공 건수

		//변수 초기화
		this.highImgCnt = 0;
		this.lightImgCnt = 0;
		this.liImgCnt = 0;
		this.nomalImgCnt =0 ;
		this.imgOverVol = 0;
        this.mediaCnt = 0;
        this.imgSetCnt = 0;
		this.h1AllCnt = 0;
		this.h1NoneCnt = 0;
		this.hOtherAllCnt = 0;
		this.hOtherNoneCnt = 0;
        this.fitCnt = 0;
        this.unfitCnt = 0;
        this.subparCnt = 0;
        this.mobileCnt = 0;

        this.siteMapUrl = "";

        SeoVO returnSeoVO = new SeoVO();

        imgSubList = new ArrayList<>();
		fontLess = new ArrayList<>();

        try{
        	returnSeoVO.setSeoType(seoType);

            //url 세팅
            String domainUrl = vcUrl;
            int protocolEndIndex = vcUrl.indexOf("//") + 2; // 프로토콜 부분의 끝 인덱스
            int firstSlashIndex = vcUrl.indexOf("/", protocolEndIndex); // 프로토콜 다음의 첫 번째 슬래시의 인덱스
            if(firstSlashIndex != -1){
                domainUrl = vcUrl.substring(0, firstSlashIndex);
            }

            //엑셀 도메인 URL 세팅
            returnSeoVO.setDomainUrl(domainUrl);

            //https일때 SSL 우회
			 if (domainUrl.contains("https://")) {setSSL();}

            //robots.txt 존재여부
            boolean robotsYn = false;

             //robots.txt 존재여부
            //어차피 오류 제어를 함수내에서 하기때문에 try문 삭제
            robotsYn = isAllowedByRobotsTxt(vcUrl, "*");
            if (!robotsYn) {
                //disallowed 해당시  연결 끊고 종료
                returnSeoVO.setConYn("N");
                return returnSeoVO;
            }

            if(robotsResult.equals("적합")){
            	fitCnt++;
                returnSeoVO.setRobotsResult("적합");
            }else{
            	unfitCnt++;
                returnSeoVO.setRobotsResult("부적합");
            }

            //siteMap 존재여부
            boolean sitemapYn = false;

            try {
            	sitemapYn = checkFileExistence(domainUrl);
			} catch (Exception ignored) {}

            if(sitemapYn){
            	fitCnt++;
                returnSeoVO.setSitemapResult("적합");
            }else{
            	unfitCnt++;
                returnSeoVO.setSitemapResult("부적합");
            }

            //접속 성공
            long startTime = System.currentTimeMillis(); // 페이지 로딩 시작 시간 기록
            String loadTime;

            Document document = null;
            try {
                // Jsoup을 사용하여 웹 페이지의 HTML을 가져옵니다. 10초내 연결
                //bot오인 방지 해더 추가
                document = Jsoup.connect(vcUrl)
                        .header("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
                        .header("accept-encoding", "gzip, deflate, br")
                        .header("accept-language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,es;q=0.6")
                        .header("cache-control", "no-cache")
                        .header("pragma", "no-cache")
                        .maxBodySize(0)
                        .userAgent(USER_AGENT).method(Connection.Method.GET).timeout(10000).get();
            }catch (IOException e){

                //GZIP Stream은 대용량에 적합하지 않음 일정 용량 넘어가면 데이터가 유실되는 현상 발생
                document = inputStreamDocument(vcUrl);

                if(document == null){
                    //트래픽오류
                    returnSeoVO.setConYn("N");
                    return returnSeoVO;
                }
               /* for(int i = 0; i < 3 ;i++){
                    if(document == null){
                        document = inputStreamDocument(vcUrl);
                    }else {
                        break;
                    }
                }

                if(document == null){
                    throw new Exception("Document Error");
                }*/

            }

            //접속성공
            returnSeoVO.setConYn("Y");
            mobileCnt++;

            //이미지 처리하는데 시간가서 여기서 처리
            long totalTime = System.currentTimeMillis() - startTime; // 페이지 로딩 시간 계산
            loadTime = String.valueOf(totalTime);
            returnSeoVO.setLoadTime(loadTime);

            if(totalTime <= 3000){
                fitCnt++;
                returnSeoVO.setLoadTimeResult("적합");
            }else if(totalTime == 5000){
                subparCnt++;
                returnSeoVO.setLoadTimeResult("미흡");
            }else{
                unfitCnt++;
                returnSeoVO.setLoadTimeResult("부적합");
            }
            //TODO: 모든테스트 끝나면 지우기
            System.out.printf("domainUrl++++++++++++"+domainUrl+"\n");
            System.out.printf("vcUrl++++++++++++"+vcUrl+"\n");

            // 각 Meta 태그 추출
            Element titleMeta = document.select("meta[http-equiv=Title], meta[name=title]").first();
            Element titleMetaTag = document.select("title").first();
            Element descriptionMeta = document.select("meta[name=Description]").first();
            Element charsetMeta = document.select("meta[charset]").first();
            Element charsetMeta2 = document.select("meta[http-equiv=content-type]").first();
            Element uaCompatibleMeta = document.select("meta[http-equiv=X-UA-Compatible]").first();
            Element viewportMeta = document.select("meta[name=viewport]").first();

            // 소셜 미디어 최적화를 위한 메타 태그 체크
            Element ogTypeMeta = document.select("meta[property=og:type]").first();
            Element ogTitleMeta = document.select("meta[property=og:title]").first();
            Element ogDescriptionMeta = document.select("meta[property=og:description]").first();
            Element ogImageMeta = document.select("meta[property=og:image]").first();
            Element ogUrlMeta = document.select("meta[property=og:url]").first();

            /* 메타명세서 시작 ====================================================================== */
            //http-equiv="Title" 존재여부 체크
            String titleMetaCont =   titleMeta != null ? titleMeta.attr("content") .trim() : "";
            String ogTitleMetaCont = ogTitleMeta != null ? ogTitleMeta.attr("content") .trim() : "";

            String descriptionMetaCont = descriptionMeta != null ? descriptionMeta.attr("content").trim() : "";
            String ogDescriptionMetaCont = ogDescriptionMeta != null ? ogDescriptionMeta.attr("content").trim() : "";

            if(!titleMetaCont.isEmpty() || titleMetaTag != null ){
                returnSeoVO.setTitleMetaYn("Y");
                metaTagCnt++;
                mobileCnt++;
            }else {
                imgSubList.add(new SeoVO("titleMeta","태그 없음","<mata> 태그에 [name=title] 요소가 없습니다.",null,"<meta name=\"title\" content=\"타이틀내용을 15자이내로 작성해주세요 \" >","0"));
            }

            //name="Description" 존재여부 체크
            if(!descriptionMetaCont.isEmpty()){
                returnSeoVO.setDescriptionMetaYn("Y");
                metaTagCnt++;
                mobileCnt++;
            }else {
                imgSubList.add(new SeoVO("descriptionMeta","태그 없음","<mata> 태그에 [name=description] 요소가 없습니다.",null,"<meta name=\"description\" content=\"설명을 45자이내로 작성해주세요 \" >","0"));
            }

            //네이버 SEO일때 조건 추가
            if(seoType.equals("2")) {
            	if(!titleMetaCont.equals(ogTitleMetaCont) && !descriptionMetaCont.equals(ogDescriptionMetaCont) ) {
            		returnSeoVO.setMetaTitleEqualYn("적합");
            		metaTagCnt++;
            	}else {
            		String metaTitleEqualProbTips = "";

            		String metaTitleEqualProbCont = "";

            		if(titleMetaCont.equals(ogTitleMetaCont)) {
            			metaTitleEqualProbTips +="<meta name=\"title\" content=\"타이틀 내용을 다른 내용으로 15자이내로 작성해주세요 \" >\n";
            			metaTitleEqualProbTips +="<meta property=\"og:title\" content=\"open graph 타이틀 내용을 다른 내용으로 15자이내로 작성해주세요 \" >\n";
            			metaTitleEqualProbCont = "<mata> 태그에 태그 [title] 요소 내용이 중복되었습니다.";
            		}

            		if(descriptionMetaCont.equals(ogDescriptionMetaCont)) {
            			metaTitleEqualProbTips +="<meta name=\"description\" content=\"설명을 다른 내용으로 45자이내로 작성해주세요 \" >\n";
            			metaTitleEqualProbTips +="<meta property=\"og:description\" content=\"open graph 설명을 다른 내용으로 45자이내로 작성해주세요 \" >\n";
            			metaTitleEqualProbCont = "<mata> 태그에 태그 [description] 요소 내용이 중복되었습니다.";
            		}


            		if(titleMetaCont.equals(ogTitleMetaCont) && descriptionMetaCont.equals(ogDescriptionMetaCont)) {
            			metaTitleEqualProbCont = "<mata> 태그에 태그 [title], [description] 요소 내용이 중복되었습니다.";
            		}

                    imgSubList.add(new SeoVO("metaTitleEqual","태그 없음",metaTitleEqualProbCont,null,metaTitleEqualProbTips,"0"));
            		returnSeoVO.setMetaTitleEqualYn("부적합");
            	}

        		if(titleMetaCont.length() <= 15 ) {
        			returnSeoVO.setMetaTitleOptYn("적합");
        			metaTagCnt++;
            	}else {
            		returnSeoVO.setMetaTitleOptYn("비적합");


                    imgSubList.add(new SeoVO("titleMetaOpt","태그 부적합","<mata> 태그에 [name=title] 요소 컨텐츠가 15자 이상입니다.",null,"<meta name=\"title\" content=\"타이틀내용을 15자이내로 작성해주세요 \" >","0"));
            	}

            	if(descriptionMetaCont.length() <= 45 ) {
            		returnSeoVO.setMetaDescrpOptYn("적합");
            		metaTagCnt++;
            	}else {
            		returnSeoVO.setMetaDescrpOptYn("비적합");

                    imgSubList.add(new SeoVO("metaDescrpOpt","태그 부적합","<mata> 태그에 [name=description] 요소 컨텐츠가 45자 이상입니다.",null,"<meta name=\"description\" content=\"설명을 45자이내로 작성해주세요 \" >","0"));
            	}
            }

            //charset 존재여부 체크
            if( (charsetMeta != null && !charsetMeta.attr("charset").trim().isEmpty()) || (charsetMeta2 != null && charsetMeta2.attr("content").toUpperCase().indexOf("CHARSET") > 0) ){
                returnSeoVO.setCharsetMetaYn("Y");
                metaTagCnt++;
            }else {
                imgSubList.add(new SeoVO("charsetMeta","태그 부적합","<mata> 태그에 [charset] 속성이 없습니다.",null,"<meta charset=\"utf-8\">","0"));
            }

            //http-equiv="X-UA-Compatible" 호환성보기 존재여부 체크
            if(uaCompatibleMeta != null && !uaCompatibleMeta.attr("content").trim().isEmpty()){
                returnSeoVO.setUaCompatibleMetaYn("Y");
                metaTagCnt++;
            }else {
                imgSubList.add(new SeoVO("uaCompatibleMeta","태그 부적합","<mata> 태그에 [http-equiv=X-UA-Compatible] 요소가 없습니다.",null,"<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\">","0"));
            }

            //name="viewport" 반응형모드사용 존재여부 체크
            if (viewportMeta != null) {
                String content = viewportMeta.attr("content");

                // content 속성에 width=device-width와 initial-scale이 모두 포함되어 있는지 확인
                boolean hasWidthDeviceWidth = content.contains("width=device-width");
                boolean hasInitialScale = content.contains("initial-scale");

                // width=device-width와 initial-scale이 동시에 포함되어 있는지 확인
                if (hasWidthDeviceWidth && hasInitialScale) {
                    returnSeoVO.setViewportMetaYn("Y");
                    mobileCnt++;
                    metaTagCnt++;
                }else {
                    imgSubList.add(new SeoVO("viewportMeta","태그 부적합","[name=viewport] contents 속성에 width=device-width, initial-scale 내용이 없습니다.",null,"<meta name=\"viewport\" content=\"width=device-width, height=device-height, initial-scale=1\">","0"));
                }
            }else {
                imgSubList.add(new SeoVO("viewportMeta","태그 부적합","<mata> 태그에 [name=viewport] 요소가 없습니다.",null,"<meta name=\"viewport\" content=\"width=device-width, height=device-height, initial-scale=1\">","0"));
            }

            //meta tag 적절히 사용 되었는지 여부
            //구글 총 5개에서 80%이상일때 적합 처리(4개 이상일때)
            //네이버 총 8개에서 80%이상일때 적합 처리(6개 이상일때)
            int metaStandard = 4;
            if(seoType.equals("2")) {
            	metaStandard = 6;
            }

            if(metaTagCnt >= metaStandard ){
            	fitCnt++;
                returnSeoVO.setMetaTageResult("적합");
            }else if (metaTagCnt > 0){
            	subparCnt++;
                returnSeoVO.setMetaTageResult("미흡");
            }else{
            	unfitCnt++;
                returnSeoVO.setMetaTageResult("부적합");
            }

            //소셜미디어 최적화 여부
            //og(open graph) ogType 존재여부
            if(ogTypeMeta != null && !ogTypeMeta.attr("content").trim().isEmpty()){
                returnSeoVO.setOgTypeMetaYn("Y");
                metaTagOgCnt++;
            }else {
                imgSubList.add(new SeoVO("ogTypeMeta","태그 부적합","<mata> 태그에 [property=og:type] 요소가 없습니다.",null,"<meta property=\"og:type\" content=\"product\">","0"));
            }

            //og(open graph) ogTitleMeta 존재여부
            if(ogTitleMeta != null && !ogTitleMeta.attr("content").trim().isEmpty()){
                returnSeoVO.setOgTitleMetaYn("Y");
                metaTagOgCnt++;
            }else {
                imgSubList.add(new SeoVO("ogTitleMeta","태그 부적합","<mata> 태그에 [property=og:title] 요소가 없습니다.",null,"<meta property=\"og:title\" content=\"타이틀내용을 15자이내로 작성해주세요\">","0"));
            }

            //og(open graph) ogDescriptionMeta 존재여부
            if(ogDescriptionMeta != null && !ogDescriptionMeta.attr("content").trim().isEmpty()){
                returnSeoVO.setOgDescriptionMetaYn("Y");
                metaTagOgCnt++;
            }else {
                imgSubList.add(new SeoVO("ogDescriptionMeta","태그 부적합","<mata> 태그에 [property=og:description] 요소가 없습니다.",null,"<meta property=\"og:description\" content=\"설명을 45자이내로 작성해주세요\">","0"));
            }

            //og(open graph) ogImageMeta 존재여부
            if(ogImageMeta != null && !ogImageMeta.attr("content").trim().isEmpty()){
                returnSeoVO.setOgImageMetaYn("Y");
                metaTagOgCnt++;
            }else {
                imgSubList.add(new SeoVO("ogImageMeta","태그 부적합","<mata> 태그에 [property=og:image] 요소가 없습니다.",null,"<meta property=\"og:image\" content=\"https://as-images.apple.com/is/og-default?wid=1200&amp;hei=630&amp;fmt=jpeg&amp;qlt=95&amp;.v=1525370171638\">","0"));
            }

            //og(open graph) ogUrlMeta 존재여부
            if(ogUrlMeta != null && !ogUrlMeta.attr("content").trim().isEmpty()){
                returnSeoVO.setOgUrlMetaYn("Y");
                metaTagOgCnt++;
            }else {
                imgSubList.add(new SeoVO("ogUrlMeta","태그 부적합","<mata> 태그에 [property=og:url] 요소가 없습니다.",null,"<meta property=\"og:url\" content=\"url을 작성해주세요\">","0"));
            }

            //소설최적화 80%이상 (4개이상)
            if(metaTagOgCnt >= 4){
            	fitCnt++;
                returnSeoVO.setSnsOptiResult("적합");
            }else if(metaTagOgCnt > 0){
            	subparCnt++;
                returnSeoVO.setSnsOptiResult("미흡");
            }else{
            	unfitCnt++;
                returnSeoVO.setSnsOptiResult("부적합");
            }

            //URL 구조화 여부 체크 언더스코어 안쓰면서 하이픈 쓰는 url 이거나 , 둘다 전혀 안쓰는 url은 유효한 URL 로 판단
            if((!vcUrl.contains("_") && vcUrl.contains("-")) || (!vcUrl.contains("_") && !vcUrl.contains("-"))){
                returnSeoVO.setUrlHyphenYn("Y");
                urlStructCnt++;
            }else {
                imgSubList.add(new SeoVO("urlHyphen",vcUrl,"url에 하이픈 존재 합니다.",null,vcUrl.replaceAll("-", "_"),"0"));
            }

            // URL에 ASCII가 문자를 사용하는 경우 체크
            if(StandardCharsets.US_ASCII.newEncoder().canEncode(vcUrl)){
                returnSeoVO.setUrlAscIIYn("Y");
                urlStructCnt++;
            }

            // URL에 읽을 수 없는 긴 ID 숫자를 사용하지 않는 경우체크 10자리 이상 숫자 인지 체크
            if(!vcUrl.matches(".*\\d{10,}.*")){
                returnSeoVO.setUrlLognIdyn("Y");
                urlStructCnt++;
            }else {
                imgSubList.add(new SeoVO("urlLognId",vcUrl,"URL에 읽을 수 없는 긴 ID 숫자를 사용중 입니다.",null,"/product/123456 (제품 페이지)","0"));
            }

            //url 구조화 80% 이상 (2개이상)
            if(urlStructCnt >= 2){
            	fitCnt++;
                returnSeoVO.setUrlStructResult("적합");
            }else if(urlStructCnt > 0){
            	subparCnt++;
                returnSeoVO.setUrlStructResult("미흡");
            }else{
            	unfitCnt++;
                returnSeoVO.setUrlStructResult("부적합");
            }

            /* 메타명세서 종료 ====================================================================== */


            /* 페이지 품질 시작 ====================================================================== */

            //네이버 SEO일때 조건 추가
            if(seoType.equals("2")) {
            	//프레임 여부 확인
            	Elements frames = document.select("frame");

            	int frameCnt = 0;

            	if(!frames.isEmpty()){
            		for (Element frame : frames) {
            			SeoVO frameVO = new SeoVO();
                    	//권장사항 타입
            			frameVO.setOptType("frameUse");
                    	//태그
            			frameVO.setProbTag(frame.toString());
                    	//미흡사항
            			frameVO.setProbCont("frame태그가 존재합니다.");
            			//권장사항
            			frameVO.setProbTips("콘텐츠의 내용이 <frame> 태그로 지정되어 있는 경우 검색로봇이 해석하기 어렵습니다 \n 가급적 frame 태그 사용을 지양 해야하며 대신 iframe을 사용할수 있습니다.");
            			//전역변수에 저장
                    	imgSubList.add(frameVO);

                    	frameCnt++;
            		}
            	}

            	if(frameCnt < 1) {
            		fitCnt++;
            		returnSeoVO.setFrameUseResult("적합");
            	}else {
            		unfitCnt++;
            		returnSeoVO.setFrameUseResult("부적합");
            	}
            }

            //이미지 최적화 여부
            //이미지를 포함하는 모든 <img> 태그를 선택합니다.
            Elements images = document.select("img");

            // 각 이미지에 대해 검증 시작
            if(!images.isEmpty()){
                for (Element image : images) {
                    //src img url 추출
                    String imageUrl = image.absUrl("src");
                    if(!StringUtils.isEmpty(imageUrl)){
                        //src 태그 전체 건수 증가
                        imgTotalCnt++;
                        //src에서 실제 이미지 파일 경로 추출
                        try {
                        	checkImageFormat(imageUrl,image);
						} catch (Exception ignore) {
                            //io 오류시 처리
                            String tempTag = image.toString();
                            String tempProbCont = "확장자를 가져올 수 없는 src 입니다.";
                            String tempProbEx = "src 내용을 확인 할 수 없습니다.";
                            String tempProbTips ="이미지의 크기가 큰 경우, 웹페이지의 로딩 속도가\n 저하될 수 있습니다.예를 들어, 큰 이미지를 웹페이지에 삽입할 때 \nJPG(JPEG) 확장자 대신 PNG 확장자를 사용하면\n파일 크기가 더 커져서 로딩 속도가 느려질 수 있습니다.";
                            imgSubList.add(new SeoVO("imgUpright",tempTag,tempProbCont,tempProbTips,tempProbEx,"0"));
                        }

                        String imgCaptionProbTip ="";

                        //alt tag 건수 증가
                        if(!image.attr("alt").isEmpty()){
                            altCnt++;
                        }else {
                        	imgCaptionProbTip +="alt 속성에 내용을 입력해주세요. \n";
                        }
                        //title tag 건수 증가
                        if(!image.attr("title").isEmpty()){
                            titleCnt++;
                        }


                        //반응형 이미지 최적화 srcset 여부
                        if(image.hasAttr("srcset")){
                            srcsetCnt++;
                        }
                        //반응형 이미지 최적화 "sizes" 태그 여부
                        if(image.hasAttr("sizes")){
                            sizes++;
                        }

                        //이미지 파일 이름 최적화할 내용
                        if(!imgCaptionProbTip.isEmpty()) {

                        	//권장사항
                        	String tempProbTip = "alt 속성은 이미지를 검색 엔진에 설명하는 데 사용됩니다.\n검색 엔진은 alt 속성을 사용하여 이미지를 이해하고 색인화합니다. ";
                        	//태그
                        	String tempTag = image.toString();
                        	//권장예시
                        	image = image.attr("alt","이미지 내용에 맞는 내용을 입력해주세요");
                        	String tempProbEx = image.toString();

                        	//권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                            imgSubList.add(new SeoVO("imgCaption",tempTag,imgCaptionProbTip,tempProbTip,tempProbEx,"0"));
                        }

                        //img 명칭 추출
                        String imageName = StringUtils.defaultString(extractFileName(imageUrl));
                        String probTip = "";
                        String imageNameDeNo = "0";

                        int underscoreCount = countUnderscores(imageName);

                        if(underscoreCount >= 2) {
                        	imgUnderCnt++;
                        }

                        // 이미지명의 길이 확인 (30자 이상)
                        if (imageName.length() >= 30 && underscoreCount < 2) {
                    		imageNameDeNo = "1";
                    		probTip += "언더스코어를 사용하거나 이미지 길이를 30자 이내로 작성해주세요.";
                    		imgNmOverCnt++;
                        }
                        // 이미지명의 공백 여부 확인
                        if (imageName.contains(" ") && underscoreCount < 2 ) {
                        	imageNameDeNo = "2";
                        	probTip += "언더스코어를 사용하거나 이미지 이름 내 공백이 존재합니다.";
                            imgNmblankCnt++;
                        }

                        //이름에 공백이 있거나 길이가 30자 이상일때
                    	if(imageName.length() >= 30 && imageName.contains(" ") ) {
                    		if(underscoreCount < 2 ) {
                    			imageNameDeNo = "3";
                    			probTip += "언더스코어를 사용하거나 이미지 이름을 30자 이내 글자 사이 공백없이 작성해주세요.";
                    		}
                    	}

                        //이미지 파일 이름 최적화할 내용
                        if(!probTip.isEmpty()) {

                        	String tempTag = image.toString();
                        	String tempProbCont = "웹페이지의 다운로드 시간이 증가할 수 있습니다. \n특히 이미지가 많은 웹페이지의 경우, 모든 이미지의 src 속성이 \n길어지면 페이지 로딩 시간이 길어질 수 있습니다. ";
                        	String tempImgNm = "";
                            String  extractImgExtension = extractImgExtension(imageName);

                            if(extractImgExtension != null && !extractImgExtension.isEmpty()) {
                        		tempImgNm =  optimizeImageName(imageName);
                        	}else {
                        		tempImgNm =  "이름1-이름2-이름3.jpg";
                        	}

                        	String tempProbEx =image.attr("src",tempImgNm).toString();

                        	//권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                            imgSubList.add(new SeoVO("imgNmOpti",tempTag,probTip,tempProbCont,tempProbEx,imageNameDeNo));
                        }

                    }
                }
            }

            //이미지 고화질 용량 건수가 1건이하일때 최적화로 판단
            if(imgOverVol < 1) {
            	imgOptiCnt++;
            	returnSeoVO.setImgOverYn("Y");
            }

        	returnSeoVO.setImgOverMessage("총 img 태그 중 100kb 초과한 이미지는 "+imgOverVol+"건 입니다.");

            // HTML에서 link 태그 선택 preload로 불러오는 경우도 있어서 추가
            Elements linkTags = document.select("link[rel=stylesheet], link[as=style]");
            int allNoneOptFont = 0;

            if(!linkTags.isEmpty()){
                // 각 link 태그에 대한 처리
                for (Element linkTag : linkTags) {
                    // link 태그의 href 속성에서 CSS 파일의 URL 추출
                    String cssUrl = linkTag.attr("href");
                    //예외처리
                    if (!cssUrl.contains("http://") && !cssUrl.contains("https://") && !cssUrl.startsWith("/")) {
                        cssUrl = "/" + cssUrl;
                    }

                    //http가 없을경우 도메인 추가.
                    if (!cssUrl.contains("http://") && !cssUrl.contains("https://")) {
                        cssUrl = domainUrl + cssUrl;
                    }

                    if(!StringUtils.isEmpty(cssUrl)){
                    	try {
                            //css 검증 함수
                    		findSmallFontElements(cssUrl);
						} catch (Exception ignored) {}

                    }
                }
                //모바일 최적화 12px 이하 검증
                if(fontLess != null && !fontLess.isEmpty()){
                    Element body = document.body();
                    String allText = body.text();
                    int allTextLength = allText.length();

                    DecimalFormat df = new DecimalFormat("#.##");

                    for (Map<String,String> fontInfo : fontLess) {

                        //셀렉터 가져오기
                        String fontClass = fontInfo.get("fontSelector");

                        //해당되는 클래스가 있는지 선택자로 검색
                        Elements temps = document.select(fontClass);

                        int fontlength = 0;

                        //문자가 하나도 안들어가있을때는 체크안함
                        for (Element element : temps) {
                            if(element.hasText()) {
                                fontlength += element.text().length();
                                allNoneOptFont += element.text().length();
                            }
                        }

                        //해당되는지 텍스트가 있는지 체크
                        if(fontlength > 0) {
                            double textPercentage = (double) fontlength / allTextLength * 100;

                            String tempTag= fontInfo.get("cssName")+" : "+fontClass;
                            String probTip = "font-size가 12px 미만입니다. "+fontInfo.get("fontSize")+"("+df.format(textPercentage)+"%"+")";
                            String tempProbCont = "모바일 퍼스트 인덱싱을 채택하여 모바일 버전의 \n웹사이트를 우선적으로 색인화합니다. \n작은 폰트는 모바일 환경에서 특히 문제가 될 수 있습니다.";
                            String tempProbEx = fontClass+" { font-size : 12px } ";
                            //권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                            imgSubList.add(new SeoVO("fontSizeOpt",tempTag,probTip,tempProbCont,tempProbEx,"0"));
                        }
                    }
                }

            }
            if(allNoneOptFont < 1){
                //모바일 최적화 점수추가
                mobileCnt++;
                returnSeoVO.setFontSizeOptYn("Y");
            }
            //올바른 이미지 형식 체크
            //확장자별 전체건수 체크
            int optImgCnt = nomalImgCnt+highImgCnt+lightImgCnt+liImgCnt;
            float imgRate = (float)optImgCnt/(float) imgTotalCnt *100;

            if(imgRate > 80){
            	imgOptiCnt++;
                returnSeoVO.setImgUprightUseResult("적합");
            }else if(imgTotalCnt == 0) {
            	//이미지가 하나도 없으면 적합
            	imgOptiCnt++;
                returnSeoVO.setImgUprightUseResult("적합");
            }else{
                returnSeoVO.setImgUprightUseResult("부적합");
            }
            returnSeoVO.setImgUprightUseMessage("총 img 태그 "+ imgTotalCnt +"건 중 고화질 이미지는 "+highImgCnt+"건 가벼운 이미지는 "+lightImgCnt+"건 로고 및 아이콘은 "+liImgCnt+"건 입니다.");

            //이미지 파일 이름 최적화 체크
            if(imgNmOverCnt + imgNmblankCnt == 0){
            	imgOptiCnt++;
            	returnSeoVO.setImgNmOptiResult("적합");
            }else{
                returnSeoVO.setImgNmOptiResult("부적합");
            }

            returnSeoVO.setImgNmOptiMessage("총 img 태그 이름 30자 이상인 파일 " + imgNmOverCnt + "건 img 이름 내에 공백 있는 파일은 "+ imgNmblankCnt +"건 \n언더스코어 2개 이상인 태그는 "+ imgUnderCnt + "건 입니다.");


            //이미지 캡션사용 체크
            //img 별 alt 건수 alt 1점 title은 0.5점 추가점수 느낌으로
            float imgCaptionRate = (altCnt +(float)(titleCnt /2)) /(float) imgTotalCnt *100;

            //80점 이상이면 적합
            if(imgCaptionRate >= 80){
            	imgOptiCnt++;
            	mobileCnt++;
                returnSeoVO.setImgCaptionResult("적합");
            }else if(imgNmOverCnt + imgNmblankCnt > 0 ) {
            	//0점 이상이면 한개라도 있다는 뜻
            	returnSeoVO.setImgCaptionResult("미흡");
            }else if(imgTotalCnt == 0) {
            	//이미지가 하나도 없으면 적합
            	imgOptiCnt++;
            	mobileCnt++;
                returnSeoVO.setImgCaptionResult("적합");
            }else{
                returnSeoVO.setImgCaptionResult("부적합");
            }
            returnSeoVO.setImgCaptionMessage("총 img 태그 "+ imgTotalCnt +"건 중 alt 속성 보유한 img 태그는 "+ altCnt +"건 입니다.");

            //반응형 이미지 최적화
            //img 별 srcset, sizes, CSS 별 @media 및 image-set 속성 존재시 최적화 Y
            int totalResponse =  mediaCnt+imgSetCnt+ srcsetCnt + sizes;

            if((totalResponse) > 0){
            	imgOptiCnt++;
                returnSeoVO.setImgResponOptiResult("적합");
            }else{
                returnSeoVO.setImgResponOptiResult("부적합");
                String	tempProbEx ="/* img 예시입니다. */ \n";
            			tempProbEx +="<img \n";
            			tempProbEx +="srcset=\" \n";
            			tempProbEx +="    heart-small-480px.jpg 480w, \n ";
            			tempProbEx +="    heart-medium-700px.jpg 700w, \n";
            			tempProbEx +="     heart-large-1000px.jpg 1000w\" \n";
            			tempProbEx +="sizes=\" \n";
            			tempProbEx +="	(max-width: 너비) 너비, \n";
            			tempProbEx +="	(max-width: 너비) 너비, \n";
            			tempProbEx +="...\n";
            			tempProbEx +="src=\"heart-large-1000px.jpg\" \n";
            			tempProbEx +="alt=\"하트\"> <!-- srcset이 설정되었다면 src 속성은 무시됨 --> \n \n";
            			tempProbEx +="@media (max-width: 12450px) { ... } \n";
            			tempProbEx +="image-set( \n";
            		    tempProbEx +="\"image1.jpg\" 1x, \n";
            		    tempProbEx +="\"image2.jpg\" 2x \n )";

                imgSubList.add(new SeoVO("imgResponOpti","반응형 최적화","img별 srcset, sizes, CSS별 @media 및 image-set 속성 중 최소 한개 이상은 존재 해야됩니다.",null,tempProbEx,"0"));

            }

            returnSeoVO.setImgResponOptiMessage("css중 @media쿼리 : "+mediaCnt+"개, image-set 속성 : "+imgSetCnt+"개, srcset 속성 : "+ srcsetCnt +"개, sizes 속성 : "+ sizes +"개 입니다.");

            //이미지 최적화 여부
            //5개중에 4개이상이면 적합
            if(imgOptiCnt >= 4) {
            	fitCnt++;
            	returnSeoVO.setImgOptiResult("적합");
            }else if(imgOptiCnt > 0) {
            	subparCnt++;
            	returnSeoVO.setImgOptiResult("미흡");
            }else {
            	unfitCnt++;
            	returnSeoVO.setImgOptiResult("부적합");
            }

            //모바일 최적화
            //link rel hreflang 태그
            int linkRelCnt = 0;
            int hreflangCnt = 0;
            if(!document.select("link").isEmpty()){
                for(Element linkTag : document.select("link")){
                	linkRelCnt++;
                    // rel 속성과 hreflang 속성이 모두 있는지 확인
                    if (linkTag.hasAttr("rel") && linkTag.hasAttr("hreflang")) {
                        hreflangCnt++;
                    }
                }
            }

            //hreflang tag 존재
            if(hreflangCnt > 0){
            	mobileCnt++;
                returnSeoVO.setHreflangYn("Y");
            }else {
                imgSubList.add(new SeoVO("hreflang","태그 부적합","<link> 태그에 [hreflang] 속성이 없습니다.",null,"<link rel=\"alternate\" hreflang=\"nl-be\" href=\"URL을 적어주세요\">","0"));
            }

            returnSeoVO.setHreflangMessage("총 <link rel> 태그 "+linkRelCnt+"건 중 hreflang 유효한 태그는 "+hreflangCnt+"건 입니다.");

            //link rel canonical 존재여부
            int canonicalCnt = 0;
            if(!document.select("link").isEmpty()){
                for(Element linkTag : document.select("link")){
                    // rel 속성중에서 canonical 있는지 확인
                    if (linkTag.hasAttr("rel") && linkTag.attr("rel").contains("canonical")) {
                        canonicalCnt++;
                    }
                }
            }

            //canonical tag 존재
            if(canonicalCnt > 0){
            	mobileCnt++;
                returnSeoVO.setCanonicalYn("Y");
            }else {
                imgSubList.add(new SeoVO("canonical","태그 부적합","<link> 태그에 [rel=canonical] 요소가 없습니다.",null,"<link rel=\"canonical\" href=\"URL을 적어주세요\">","0"));
            }

            //mobile 적합 여부 총 9개에서 80%이상일때 적합 처리(7개 이상일때 약 77% )
            if(mobileCnt >= 7) {
            	fitCnt++;
            	returnSeoVO.setMobileYn("적합");
            }else if(mobileCnt > 0) {
            	subparCnt++;
            	returnSeoVO.setMobileYn("미흡");
            }else {
            	unfitCnt++;
            	returnSeoVO.setMobileYn("부적합");
            }

            /* 페이지 품질 종료 ====================================================================== */

            /* 페이지 구조 시작 ====================================================================== */
            // h1 태그들을 선택
            countHeadings(document);
            int h1FitCnt = 0;
            if(h1AllCnt > 0) {
            	h1FitCnt++;
            	if(h1AllCnt == 1) {
            		h1FitCnt++;
            	}
            }

            if(h1NoneCnt == 0) {
            	h1FitCnt++;
            }

            if(h1AllCnt == 1 ) {
        		returnSeoVO.setHeadingOneYn("적합");
        	} else if(h1AllCnt > 1) {
        		returnSeoVO.setHeadingOneYn("미흡");
        	} else {
        		returnSeoVO.setHeadingOneYn("부적합");
        	}

        	if(h1NoneCnt == 0) {
        		returnSeoVO.setHeadingOneContYn("Y");
        	}


        	//h1이외의 표제 태그
        	if(hOtherAllCnt > 0 ) {
        		h1FitCnt++;
        		returnSeoVO.setHeadingOtherYn("Y");
        	}
        	if(hOtherNoneCnt == 0) {
        		h1FitCnt++;
        		returnSeoVO.setHeadingOtherContYn("Y");
        	}

            //h1 5개중 4개 만족시 적합
            if(h1FitCnt >= 4) {
            	fitCnt++;
            	returnSeoVO.setHeadingOneResult("적합");
            }else if(h1FitCnt > 0) {
            	subparCnt++;
            	returnSeoVO.setHeadingOneResult("미흡");
            }else {
            	unfitCnt++;
            	returnSeoVO.setHeadingOneResult("부적합");

            }

            returnSeoVO.setHeadingOtherMessage("표제에 빈 텍스트가 "+hOtherNoneCnt+"개 존재합니다.");
            returnSeoVO.setHeadingOneMessage("H1 표제에 빈 텍스트가 "+h1NoneCnt+"개 존재합니다.");

            //a태그 최적화
            Map<String,Integer> hrefMap = optimizeHrefAttributes(document);

            int totalCnt = 0;

            int onclickCnt = hrefMap.get("onclickCnt");
            int notATagCnt = hrefMap.get("notATagCnt");
            int noneTextCnt = hrefMap.get("noneTextCnt");

            if(onclickCnt < 1) {
            	returnSeoVO.setLinkOptFncYn("Y");
            	totalCnt++;
            }

            if(notATagCnt < 1) {
            	returnSeoVO.setLinkOptATagYn("Y");
            	totalCnt++;
            }

            if(noneTextCnt < 1) {
            	returnSeoVO.setLinkOptATagTxtYn("Y");
            	totalCnt++;
            }

            //3개중에서 2개 이상이면 적합
            if(totalCnt >= 2 ) {
            	fitCnt++;
            	returnSeoVO.setLinkOptResult("적합");
            }else if(totalCnt > 0) {
            	subparCnt++;
            	returnSeoVO.setLinkOptResult("미흡");
            } else {
            	unfitCnt++;
            	returnSeoVO.setLinkOptResult("부적합");
            }

        	/* 페이지 구조 종료 ====================================================================== */

            //총계 저장
            returnSeoVO.setFitCnt(fitCnt);
            returnSeoVO.setUnfitCnt(unfitCnt);
            returnSeoVO.setSubparCnt(subparCnt);

            //DB insert 후 일련번호 VO로 넘기기
            defaultDao.insert("com.opennote.standard.mapper.basic.SeoMngMapper.insertContents", returnSeoVO);
              
            //미흡사항 내용 등록
            if(!imgSubList.isEmpty() ) {
            	returnSeoVO.setImgSubList(imgSubList);
            	defaultDao.insert("com.opennote.standard.mapper.basic.SeoMngMapper.insertSubContents", returnSeoVO); 
            }

        }catch (HttpStatusException e){
            // HTTP 상태 코드에 대한 예외 처리
            //접속실패 세팅
            returnSeoVO.setConYn("N");
            return returnSeoVO;
        } catch (IOException e) {
            //접속실패 세팅
            returnSeoVO.setConYn("N");
            return returnSeoVO;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return returnSeoVO; 
    }
    
    
    public ModelAndView excelDownload(SeoVO searchVO){
        
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "SEO보고서";
		String url = "";
		if(searchVO.getSearchCondition().equals("1")) {
			url = "/standard/system/seoGoogleList.xlsx";
		}else {
			url = "/standard/system/seoNaverList.xlsx"; 
		}
		
		// seoMngMapper.selectContents(seoVO);
		SeoVO seoVO = (SeoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.SeoMngMapper.selectContents" , searchVO );  
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultVO", seoVO);
		
		return mav;
    }
    
    public void view(SeoVO searchVO, Model model){ 
        List<SeoVO> subList = (List<SeoVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.SeoMngMapper.selectSubList",searchVO);
		model.addAttribute("subList",subList);
    }
    
    public void subAddList(SeoVO searchVO, Model model)throws Exception{
        
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		SeoVO rtnVo = (SeoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.SeoMngMapper.selectSubCount",searchVO);
		int seoCount = Integer.parseInt( rtnVo.getSeoCount()); 
		paginationInfo.setTotalRecordCount(seoCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<SeoVO> subList = (List<SeoVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.SeoMngMapper.selectList", searchVO ); 
		model.addAttribute("subList",subList);
		model.addAttribute("totalRecordCount", paginationInfo.getTotalRecordCount());
    }

    //siteMap 실제 데이터 내용 체크
    private boolean checkFileExistence(String urlString) throws Exception {
        BufferedReader in = null;

        try {
            String tempSiteMapUrl = urlString + "/sitemap.xml";
            
            //robots.txt에서 sitemap.xml 정보가 있으면 활용
            if(siteMapUrl != null && !siteMapUrl.isEmpty()){
                //주소창 입력할때부터 무조건 https: 사용하게 정규식 되있기 때문에 https:로 변경
                tempSiteMapUrl = siteMapUrl.replace("http:","https:");
            }
            URL url = new URL(tempSiteMapUrl);
            URLConnection con = url.openConnection();
            con.setConnectTimeout(7000);
            con.setReadTimeout(7000);

            in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    if (inputLine.contains("<urlset") || inputLine.contains("<sitemapindex") ) {
                        in.close();
                        return true;
                    }
                }
                in.close();
                return false;
            } catch (IOException e) {
                if(in != null){
                    in.close();
                }
                return false;
            }
    }

    //이미지 고화질,가벼운이미지, 로고,아이콘 건수 체크
    private void checkImageFormat(String imageUrl,Element imageElement) throws Exception{

        // 이미지 파일의 바이트 크기 확인
        int imageSize = getImageSize(imageUrl);
        // 이미지의 형식을 체크합니다.

        URL url = new URL(imageUrl);
        URLConnection connection = url.openConnection();
        connection.setConnectTimeout(5000); // 연결 시도에 대한 타임아웃: 5초
        connection.setReadTimeout(7000); // 읽기 작업에 대한 타임아웃: 7초

        BufferedImage image = ImageIO.read(connection.getInputStream());
        //BufferedImage image = ImageIO.read(new URL(imageUrl));

        if (image != null) {
            int width = image.getWidth();
            int height = image.getHeight();

            //확장자 추출
            String format = extractImgExtension(imageUrl);

            //고화질 용량 오버건수 체크 100kb이상 건수 체크
            if(width >= 1900 && imageSize > 100 * 1024 && "JPEG".equalsIgnoreCase(format)){
                imgOverVol++;
                //해당 조건에 들어가 있으면 최적화가 안됬다는 의미
                String tempTag = imageElement.toString();
            	String tempProbCont = "고화질 이미지 용량을 100KB 이하로 줄여주세요.";
            	String tempProbTip = "고용량 이미지는 웹페이지의 로딩 속도를 늦출 수 있습니다. \n 사용자가 웹페이지를 빠르게 로드할 수 없는 경우, seo에 부정적인 영향을 끼칩니다.";

            	//용량 줄여주는 사이트링크 넣어둠
            	//권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                imgSubList.add(new SeoVO("imgOver",tempTag,tempProbTip,tempProbCont,"https://compressjpeg.com/ko/","0"));
            }

            // 조건에 따라 올바른 이미지 형식에 건수를 증가.
            if (width >= 1900 && "JPEG".equalsIgnoreCase(format)) {
                highImgCnt++;
            } else if ((width > 200 && width <= 800 ) && height <= 600 && "PNG".equalsIgnoreCase(format)) {
                lightImgCnt++;
            } else if ((width <= 200 && height <= 200 ) && "SVG".equalsIgnoreCase(format)) {
                liImgCnt++;
            }else if(width > 800 && width < 1900) {
            	nomalImgCnt++;
            }else {
            	//해당 조건에 안들어가 있으면 최적화가 안됬다는 의미 위의 조건은 일반이미지 제외
            	String tempTag = imageElement.toString();
            	String tempProbCont ="";
            	String tempProbTips ="이미지의 크기가 큰 경우, 웹페이지의 로딩 속도가\n 저하될 수 있습니다.예를 들어, 큰 이미지를 웹페이지에 삽입할 때 \nJPG(JPEG) 확장자 대신 PNG 확장자를 사용하면\n파일 크기가 더 커져서 로딩 속도가 느려질 수 있습니다.";
            	String tempOptTypeDeNo = "0";
            	String tempProbEx ="";

            	if(format == null ) {
            		tempProbCont = "확장자를 가져올 수 없는 src 입니다.";
            		tempProbEx = "src 내용을 확인 할 수 없습니다.";
            		tempOptTypeDeNo = "1";
            	 } else if (width >= 1900 ) {
            		 tempProbCont = "가로 길이가 1900px 이상인 파일들은 JPEG 확장자로 바꿔주세요";
            		 tempOptTypeDeNo = "2";
            		 tempProbEx = imageElement.attr("src",imageUrl.substring(0,imageUrl.lastIndexOf("."))+".jpeg").toString();
            	 } else if( width > 200 && width <= 800 ) {
            		 tempProbCont = "가로 길이가 800px 이하인 파일들은 PNG 확장자로 바꿔주세요";
            		 tempOptTypeDeNo = "3";
            		 tempProbEx = imageElement.attr("src",imageUrl.substring(0,imageUrl.lastIndexOf("."))+".png").toString();
            	 } else if(width <= 200 && height <= 200 ) {
            		 tempProbCont = "가로 길이가 200px 이하인 파일들은 SVG 확장자로 바꿔주세요";
            		 tempOptTypeDeNo = "4";
            		 tempProbEx = imageElement.attr("src",imageUrl.substring(0,imageUrl.lastIndexOf("."))+".svg").toString();
            	 } else {
            		 nomalImgCnt++;
            	 }

            	if(!tempProbEx.isEmpty()) {
            		//권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                    imgSubList.add(new SeoVO("imgUpright",tempTag,tempProbCont,tempProbTips,tempProbEx,tempOptTypeDeNo));
            	}
            }
        }else{
            //파일 정보를 읽을수 없는 경우
            String tempTag = imageElement.toString();
            String tempProbCont = "확장자를 가져올 수 없는 src 입니다.";
            String tempProbEx = "src 내용을 확인 할 수 없습니다.";
            String tempProbTips ="이미지의 크기가 큰 경우, 웹페이지의 로딩 속도가\n 저하될 수 있습니다.예를 들어, 큰 이미지를 웹페이지에 삽입할 때 \nJPG(JPEG) 확장자 대신 PNG 확장자를 사용하면\n파일 크기가 더 커져서 로딩 속도가 느려질 수 있습니다.";
            imgSubList.add(new SeoVO("imgUpright",tempTag,tempProbCont,tempProbTips,tempProbEx,"0"));
        }
    }
    //이미지 파일 확장자 추출
    public static String extractImgExtension(String imageUrl) {
    	 String[] extractImgList = {"png","jpeg","jpg","gif","bmp","webp","svg"};
         List<String> imgList = new ArrayList<>(Arrays.asList(extractImgList));

    	for (String imgExtension : imgList) {
            if (imageUrl.contains("." + imgExtension)) {
                return imgExtension;
            }
        }
        return null; // 확장자가 없을 경우 null 반환 or 예외 처리
    }


    //이미지 용량 체크
    private static int getImageSize(String imageUrl) throws IOException {
        URL url = new URL(imageUrl);
        URLConnection connection = url.openConnection();
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(7000);

        // 이미지 파일의 바이트 크기 반환
        return connection.getContentLength();
    }

    //파일명 추출
    private static String extractFileName(String imageUrl) {
        // 파일명을 추출하는 정규 표현식 사용
        Pattern pattern = Pattern.compile("[^/\\\\]*$");
        Matcher matcher = pattern.matcher(imageUrl);

        if (matcher.find()) {
            return matcher.group(); // 파일명 반환
        } else {
            return null; // 매치되지 않을 경우 null 반환
        }
    }

    //언더스코어 갯수 확인
    private static int countUnderscores(String imageName) {
        int count = 0;
        if(imageName != null) {
            for (int i = 0, j = imageName.length(); i < j; i++) {
                if (imageName.charAt(i) == '_' || imageName.charAt(i) == '-') {
                    count++;
                }
            }
        }
        return count;
    }

    private void countHeadings(Document doc) {
    	 // h1 태그들을 선택
        Elements h1Tags = doc.select("h1");

        StringBuilder headingOneDupCont = new StringBuilder();

        for (Element h1 : h1Tags) {
        	if(h1AllCnt < 1) {
        		String h1Html = h1.html();
                if (h1Html.length() > 300) {
                    // h1 태그의 HTML 내용이 300자를 초과하는 경우에만 "..."을 추가하여 문자열로 설정
                    h1Html = h1Html.substring(0, 300) + "...";
                }
                headingOneDupCont.append(h1.html(h1Html).toString());
        	}

        	h1AllCnt++;

            if (h1.html().isEmpty()) {
            	h1NoneCnt++;

            	String tempTag = h1.toString();
             	String tempProbCont = "h1 태그에는 내용에 내용이 비어있습니다.";
             	String tempProbTip = "headings 태그는 웹사이트의 접근성을 높이는 데 도움이 됩니다.\n 스크린 리더와 같은 보조 기술을 사용하는 사람들은 headings 태그를 사용하여 페이지의 주요 콘텐츠를 식별합니다.";

             	//권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                imgSubList.add(new SeoVO("headingOneCont",tempTag,tempProbTip,tempProbCont,h1.html("적절한 내용을 넣어주세요").toString(),"0"));

            }
        }

        if(h1AllCnt < 1) {
            imgSubList.add(new SeoVO("headingOne","태그 없음","<h1> 태그가 없습니다.",null,"<h1>해당 컨텐츠에 맞는 내용을 작성해주세요.</h1>","0"));
            imgSubList.add(new SeoVO("headingOneDup","태그 없음","<h1> 태그가 없습니다.",null,"<h1>해당 컨텐츠에 맞는 내용을 작성해주세요.</h1>","0"));
        }else if(h1AllCnt > 1) {

            imgSubList.add(new SeoVO("headingOneDup","태그 즁복","총 h1태그 "+h1AllCnt+"개 \n"+headingOneDupCont,null,"<h1> 태그는 하나만 존재 해야됩니다.","0"));
        }


        // h1 태그 제외 선택
        Elements hTags = doc.select("h2, h3, h4, h5, h6");
        for (Element ho : hTags) {
        	hOtherAllCnt++;
            if (ho.html().isEmpty()) {
            	hOtherNoneCnt++;

            	String tempTag = ho.toString();
             	String tempProbCont = "headings 내용이 비어 있습니다.";
             	String tempProbTip = "headings 태그는 웹사이트의 접근성을 높이는 데 도움이 됩니다.\n 스크린 리더와 같은 보조 기술을 사용하는 사람들은 headings 태그를 사용하여 페이지의 주요 콘텐츠를 식별합니다.";

             	//권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                imgSubList.add(new SeoVO("headingOtherCont",tempTag,tempProbTip,tempProbCont,ho.html("적절한 내용을 넣어주세요").toString(),"0"));

            }
        }


        if(hOtherNoneCnt < 1) {
            imgSubList.add(new SeoVO("headingOther","태그 없음","<heading> 태그가 없습니다.",null,"<h2>해당 컨텐츠에 맞는 내용을 작성해주세요.</h2>","0"));
        }

    }

    // link 최적화 관련 전처리 해주는 메서드
    private static Map<String,Integer> optimizeHrefAttributes(Document doc) {

    	Map<String,Integer> resultMap = new HashMap<>();

	    int onclickCnt = 0;
	    int notATagCnt = 0;
	    int nontTextCnt = 0;

	    //link태그를 제외한 href 속성이 있는 태그 모두를 가져옵니다
		Elements hrefElements  =  doc.select("*:not(link)[href]");

        for (Element element : hrefElements) {
            String hrefValue = element.attr("href");
            String tagName = element.tagName();

            //a태그가 아닌데 href 쓰는 애들 카운트
            if (!tagName.equals("a")) {
                notATagCnt++;

                String tempTag = element.toString();
                String tempProbCont = "a태그 외에는 href 속성 사용을 권장하지 않습니다. ";
                String tempProbTip = "a태그 외에 다른 태그에 href 속성 사용시 \n검색로봇이 구조를 올바르게 이해하지 못하고 웹페이지를 적절하게 색인화하지 못할 수 있습니다.";

                //권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                imgSubList.add(new SeoVO("linkOptATag", tempTag, tempProbTip, tempProbCont, element.removeAttr("href").toString(), "0"));
            } else {
                //a태그에 내용 비어 있는 애들
                if (element.html().isEmpty() && StringUtils.isEmpty(element.attr("title"))) {
                    nontTextCnt++;

                    String tempTag = element.toString();
                    String tempProbCont = "a태그 내용 또는 title 속성 내용 둘중 하나는 작성하셔야 됩니다.";
                    String tempProbTip = "내용이 없는 링크는 검색 엔진이 페이지의 콘텐츠와 관련된 링크를 이해하고\n 적절하게 색인화하는 데 어려움을 줄 수 있습니다.";

                    //권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                    imgSubList.add(new SeoVO("linkOptATagTxt", tempTag, tempProbTip, tempProbCont, element.html("링크에 알맞은 적절한 내용을 넣어주세요.").toString(), "0"));

                }
            }

            //a태그에 onclick 함수 쓰는 애들이나 href에 함수쓰는 애들
            String onclick = element.attr("onclick").trim();
            if (!StringUtils.isEmpty(onclick) || hrefValue.contains("(")) {
                onclickCnt++;

                String tempTag = element.toString();
                String tempProbCont = "a태그에는 함수사용은 권장하지 않습니다,\n필요하시면 button 태그로 추천합니다.";
                String tempProbTip = "링크 표현시 javascript를 사용한다면 검색로봇이\n링크를 해석하기 어렵습니다.";

                //권장타입, 태그, 미흡사항, 권장사항, 권장예시, 권장타입 유형 번호
                imgSubList.add(new SeoVO("linkOptFnc", tempTag, tempProbTip, tempProbCont, element.removeAttr("onclick").attr("href", "적절한 url을 넣어주세요").toString(), "0"));

            }

        }

		//전역변수 사용을 최소화 하기 위해 맵에다가 넣어줍니다.
		resultMap.put("onclickCnt",onclickCnt);
		resultMap.put("notATagCnt",notATagCnt);
		resultMap.put("noneTextCnt",nontTextCnt);
		resultMap.put("totalCnt",onclickCnt+notATagCnt+nontTextCnt);

		return resultMap;
    }


    // 현재 URL이 disallow 된 URL인지 확인해주는 메서드
    private boolean isAllowedByRobotsTxt(String targetUrl, String userAgent) throws IOException {

    	//url 세팅
        String domainUrl = targetUrl;
        int protocolEndIndex = targetUrl.indexOf("//") + 2; // 프로토콜 부분의 끝 인덱스
        int firstSlashIndex = targetUrl.indexOf("/", protocolEndIndex); // 프로토콜 다음의 첫 번째 슬래시의 인덱스

        //도메인 하위 URL 추출
        String subUrl = "/";
        if(firstSlashIndex != -1){
            domainUrl = targetUrl.substring(0, firstSlashIndex);
            subUrl = targetUrl.substring(firstSlashIndex);
        }

    	try{
    		//robots.txt 파일 내용 가져옵니다.
    		String robotsTxtContent = fetchRobotsTxt(domainUrl);

            //데이터를 가져오면 robots.txt 파일이 있다는 뜻
            mobileCnt++;
            fitCnt++;
            robotsResult ="적합";

            if (robotsTxtContent != null && !StringUtils.isEmpty(robotsTxtContent)) {

                String[] cutTextSiteMap = robotsTxtContent.replaceAll("(?i)sitemap:", "sitemap:").split("sitemap:");
                if(cutTextSiteMap != null && cutTextSiteMap.length > 1){
                    int index =  cutTextSiteMap[1].indexOf(".xml");
                    if(index > 0){
                        siteMapUrl = cutTextSiteMap[1].substring(0,index+4).trim();
                    }
                }

                String selectUserAgent = null;

                // USER-AGENT 타입별로 데이터를 나눠줍니다.
                String[] cutText = robotsTxtContent.replaceAll("(?i)User-agent", "USER-AGENT").split("USER-AGENT:");

                // robots.txt 파일에 userAgent 변수랑 같은 이름이 있는지 확인하고 selectUserAgent에 넣어줍니다.
                if(cutText != null && cutText.length > 0 ){
                    for (String string : cutText) {

                        //USER-AGENT 기준 전처리
                        String trimTxt = string.trim();
                        int allowNot = !trimTxt.contains("Allow:") ? trimTxt.length() : trimTxt.indexOf("Allow:");
                        String currentUserAgent = trimTxt.substring(0, !trimTxt.contains("Disallow:") ? trimTxt.length() : trimTxt.indexOf("Disallow:") );

                        if(currentUserAgent.contains("Disallow:") ) {
                            currentUserAgent = trimTxt.substring(0, allowNot );
                        }

                        if(currentUserAgent.contains("Allow:") ) {
                            currentUserAgent = trimTxt.substring(0, allowNot );
                        }

                        if(currentUserAgent.trim().equals(userAgent)) {
                            selectUserAgent = string.substring(currentUserAgent.length()+1).trim();
                        }
                    }

                    //널처리
                    if(selectUserAgent != null) {
                        List<String> disalloList = new ArrayList<>();

                        String[] disallowTemp = selectUserAgent.split("Disallow:");
                        for (String string : disallowTemp) {
                            String tempStr = string;

                            //필요없는 데이터 삭제 전처리
                            if(StringUtils.isNotEmpty(string) && string.contains("Allow:")) {
                                tempStr = tempStr.substring(0,tempStr.indexOf("Allow:"));
                            }

                            if(StringUtils.isNotEmpty(string) && string.contains("Clean-param:")) {
                                tempStr = tempStr.substring(0,tempStr.indexOf("Clean-param:"));
                            }

                            //선택된 userAgent기준으로 disallow 데이터만 따로 리스트에 저장해줍니다.
                            disalloList.add(tempStr.trim());
                        }

                        //추출한 subUrl랑 disallow 패턴이랑 비교를 해서 맞는 패턴이 있으면 false를 리턴합니다.
                        for (String pattern : disalloList) {
                            if (matchesPattern(subUrl, pattern)) {
                                return false;
                            }
                        }
                    }

                }
            }
	    } catch (IOException e) {
            unfitCnt++;
            robotsResult ="부적합";
	    	//IOEx 오류가 뜨면은 robots.txt 파일 없다는 뜻이므로 전체 통과로 간주합니다.
	    	return true;
		} catch (ParseException e) {
            throw new RuntimeException(e);
        }


        return true;
    }

    //robots.txt 파일에 있는 내용을 리턴해주는 메서드
    private static String fetchRobotsTxt(String baseUrl) throws IOException,ParseException  {

        //timeout 7초로 제한
        Timeout timeout = Timeout.ofMilliseconds(7000);

        try (CloseableHttpClient httpClient = HttpClients.custom()
                .setDefaultRequestConfig(RequestConfig.custom()
                        .setConnectTimeout(timeout)
                        .setResponseTimeout(timeout)
                        .build())
                .build()) {
            HttpGet httpGet = new HttpGet(baseUrl + "/robots.txt");
            try (CloseableHttpResponse response = httpClient.execute(httpGet)) {
                if (response.getCode() == 200) {
                    HttpEntity entity = response.getEntity();
                    return EntityUtils.toString(entity);
                } else {
                    throw new HttpResponseException(response.getCode(), "Failed to fetch robots.txt: " + response.getReasonPhrase());
                }
            }
        }
    }
    
    //url 패턴일치하는지 확인해주는 메서드
    private static boolean matchesPattern(String url, String pattern) {
        // URL 패턴에 정규 표현식 메타 문자가 포함될 수 있으므로 Pattern.quote를 사용하여 이스케이핑합니다.
        String regex = pattern.replace("*", ".*").replace("/", "\\/");
        
        // 패턴을 컴파일합니다.
        Pattern p = Pattern.compile(regex);
        
        // URL을 검사하여 패턴과 일치하는지 확인합니다.
        Matcher m = p.matcher(url);
        return m.matches();
    }
    
    // SSL 우회 등록    
    private static void setSSL() throws NoSuchAlgorithmException, KeyManagementException {
    	TrustManager[] trustAllCerts = new TrustManager[] {
		    new X509TrustManager() {
		        public X509Certificate[] getAcceptedIssuers() {return null;}
		        public void checkClientTrusted(X509Certificate[] certs, String authType) {}
		        public void checkServerTrusted(X509Certificate[] certs, String authType) {}
		    }
		};
     
     SSLContext sc = SSLContext.getInstance("SSL");
     sc.init(null, trustAllCerts, new SecureRandom());
     
     HttpsURLConnection.setDefaultHostnameVerifier((hostname, session) -> true);
     HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
    }

    private static boolean isCamelCase(String str) {
    	// 파일 확장자 제거
        int extensionIndex = str.lastIndexOf('.');
        if (extensionIndex != -1) {
            str = str.substring(0, extensionIndex);
        }
        return str.matches("[a-z]+([A-Z][a-z0-9]*|[0-9]+)([A-Z][a-z0-9]*|[0-9]+)*\\.[a-zA-Z]+");
    }

 // 숫자 패턴 확인
 private static boolean isNumeric(String str) {
    	int extensionIndex = str.lastIndexOf('.');
	    if (extensionIndex != -1) {
	        str = str.substring(0, extensionIndex);
	    }
	    return str.matches(".*[0-9]{8,}.*");
    }

    private static String optimizeImageName(String imageName) {

        if (countUnderscores(imageName) > 0 ) {
            // 이미 하이픈이나 언더바가 포함된 경우
            return imageName;
        } else if (isCamelCase(imageName)) {
            // 카멜 표기법 패턴이 보이는 경우 
            return convertCamelToDash(imageName);
        }else if (isNumeric(imageName)) { 
        	// 숫자가 연속해서 8번이상 사용되면
        	return optimizeNumeric(imageName);
        }else if(imageName.contains(" ")) {
        	//공백이 있을 경우 
        	return imageName.replaceAll(" ","-");
        } else {
            // 둘 다 아닌 경우에 대한 처리
            return "이름1-이름2-이름3.jpg";
        }
    }
    
    //숫자 패턴을 하이픈 패턴으로 바꿔는 메서드
    private static String optimizeNumeric(String imageName) {
    	 // 파일 확장자 확인
        int extensionIndex = imageName.lastIndexOf('.');
        String extension = "";
        if (extensionIndex != -1) {
            extension = imageName.substring(extensionIndex);
            imageName = imageName.substring(0, extensionIndex);
        }

        // 숫자 패턴 확인 및 최적화
        StringBuilder result = new StringBuilder();
        int digitCount = 0;
        for (int i = 0, j= imageName.length(); i < j; i++) {
            char currentChar = imageName.charAt(i);
            if (Character.isDigit(currentChar)) {
                digitCount++;
                result.append(currentChar);
                if (digitCount % 4 == 0 && digitCount != 0 && i != imageName.length() - 1) {
                    // 4자리마다 하이픈 삽입
                    result.append('-');
                }
            } else {
                // 숫자가 아닌 경우 그대로 추가
                result.append(currentChar);
            }
        }

        // 최적화된 이미지 이름에 확장자 추가
        result.append(extension);
        return result.toString();
    }
    
    //카멜 패턴을 하이픈 패턴으로 바꿔는 메서드
    private static String convertCamelToDash(String camelCase) {
        StringBuilder result = new StringBuilder();
        for (int i = 0, j = camelCase.length(); i < j; i++) {
            char currentChar = camelCase.charAt(i);
            if (Character.isUpperCase(currentChar) && i != 0) {
                result.append('-');
                result.append(Character.toLowerCase(currentChar));
            } else {
                result.append(currentChar);
            }
        }
        return result.toString();
    }
    
    //style.css 분석 (12px 이하 여부 , @media 여부)
    private void findSmallFontElements(String cssUrl) {
    	try {
    		final String cssText = Jsoup.connect(cssUrl).header("Content-Type", "application/json;charset=UTF-8").userAgent(USER_AGENT).method(Connection.Method.GET).timeout(30000).execute().body();

            //@media, image-set 여부 확인
            if (cssText.contains("@media")) {
                mediaCnt++;
            }
            if (cssText.contains("image-set")) {
                imgSetCnt++;
            }

            //cssparser가 요구하는 데이터 전처리
        	final InputSource source = new InputSource(new StringReader(cssText));
            final CSSOMParser cssomParser = new CSSOMParser();
            final CSSStyleSheetImpl css = cssomParser.parseStyleSheet(source, null);
            final CSSRuleListImpl rules = css.getCssRules();

            if(rules != null){
                for (int i = 0 ,j= rules.getLength() ; i < j ; i++) {
                    //css 실제 데이터
                    AbstractCSSRuleImpl rule = rules.getRules().get(i);

                    //css데이터 중 font-size만 추출
                    String fontSizeValueTxt = getFontSizeValue(rule.getCssText());

                    //font-size를 숫자만 남기고 삭제
                    String fontSizeValue = fontSizeValueTxt.replaceAll("[^0-9.]", "");

                    if(!fontSizeValue.isEmpty()){
                        //double 타입으로 형변환
                        double fontSize = Double.parseDouble(fontSizeValue);
                        //원래 em사이즈는 부모 font-size 상속받아서 곱하기 해주는 형태였지만
                        // 현재는 구현이 힘들어 임시 보정 예를들어 부모가 12px일때 2em이면 24px
                        if(fontSizeValueTxt.contains("em")){
                            //1배 이상이면 font-size 보정
                            if(fontSize >= 1 ){
                                fontSize = 12;
                            }
                        }
                        //12px 미만이면 map에 저장
                        if (fontSize < 12.0) {
                            CSSStyleRuleImpl sr = (CSSStyleRuleImpl) rule;
                            String selector = sr.getSelectorText();
                            if(!sr.getSelectorText().contains(":") && !sr.getSelectorText().isEmpty()) {
                                Map<String,String> fontInfo = new HashMap<>();

                                //폰트 선택자
                                fontInfo.put("fontSelector", selector.replaceAll("[*]#","#").replaceAll("[*][.]","."));
                                //css파일 이름
                                fontInfo.put("cssName", extractFileName(cssUrl));
                                //폰트 사이즈
                                fontInfo.put("fontSize", fontSizeValueTxt);

                                fontLess.add(fontInfo);
                            }
                        }
                    }
                }
            }
            //전처리된 데이터 다시 가공
		} catch (Exception ignored) {}
    	
    }
    
    
    // CSS 규칙에서 font-size 값 추출하는 메서드
    private String getFontSizeValue(String cssRuleText) {
        String[] parts = cssRuleText.split(";");
        for (String part : parts) {
            String[] keyValue = part.trim().split(":");
            if (keyValue.length == 2 && keyValue[0].trim().equals("font-size")) {
                return keyValue[1].trim();
            }
        }
        return "";
    }

    //SEO 분석결과를 조회하는 메서드
    /*public SeoVO selectContents(SeoVO seoVO) {
    	return seoMngMapper.selectContents(seoVO);
    }*/
    
    //SEO 분석결과 최적화가 안된 상세내용을 조회하는 메서드
    /*public List<SeoVO> selectSubList(SeoVO seoVO){
    	return seoMngMapper.selectSubList(seoVO);
    }*/
    
    //SEO 분석결과 최적화가 안된 상세내용 총갯수를 구하는 매서드
   /* public int selectSubCount(SeoVO seoVO) {
        return seoMngMapper.selectSubCount(seoVO);
    }*/


    public Document inputStreamDocument (String vcUrl) throws Exception{
        try{
            URL url = new URL(vcUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setConnectTimeout(10000);
            connection.setReadTimeout(10000);
            connection.setRequestMethod("GET");
            connection.setRequestProperty("User-Agent", USER_AGENT);

               /*대용량 데이터 들어올수 잇어서 inputStream으로 받아서 처리
                대신 기존보다 속도 1~2초정도 더 느려질수 있음 기존에는 gzip포맷으로 받기 때문에
                바로 GZIP Stream 받아서 따로 파싱 할필요가 없음
                일부러 InputStream으로 받아서 다시 Document 변환시키는 2중작업발생 */
            InputStream input = connection.getInputStream();
            return Jsoup.parse(input, null, vcUrl);
        }catch (Exception e){

            return null;
        }
    }

}
