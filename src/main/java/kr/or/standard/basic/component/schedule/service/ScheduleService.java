package kr.or.standard.basic.component.schedule.service;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.component.schedule.vo.CmHdayResponseErrorVO;
import kr.or.standard.basic.component.schedule.vo.CmHdayResponseVO;
import kr.or.standard.basic.component.schedule.vo.CmSchdVO;
import kr.or.standard.basic.system.menual.vo.CmMnlVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;

import kr.or.standard.basic.component.schedule.vo.CmHdayResponseErrorVO;
import kr.or.standard.basic.component.schedule.vo.CmHdayResponseErrorVO.CmmMsgHeader;
import kr.or.standard.basic.component.schedule.vo.CmHdayResponseVO.CmHdayResponseItem;
import kr.or.standard.basic.component.schedule.vo.CmHdayResponseVO.Items;
import org.springframework.web.servlet.ModelAndView;


@Service
@RequiredArgsConstructor
@Transactional
public class ScheduleService extends EgovAbstractServiceImpl  {
    
    // 휴일 정보 api key
	@Value("${cm_schd.hday.service-key}")
    private String serviceKey;
    
    private final BasicCrudDao basicCrudDao;
    private final CmmnDefaultDao defaultDao;
    private final PaginationService paginationService;
    private final MessageSource messageSource;
    private final ExcelView excelView;
    
    private final String sqlNs = "com.standard.mapper.component.SchdMngMapper.";
    
    public void list(CmmnDefaultVO searchVO){
    	
		// default 년 월
		if(StringUtils.isEmpty(searchVO.getSchEtc01()) && StringUtils.isEmpty(searchVO.getSchEtc02())) {
			String nowDate = new SimpleDateFormat("yyyy.MM.dd").format(new Date());
			searchVO.setSchEtc00(nowDate.substring(8));
			searchVO.setSchEtc01(nowDate.substring(0, 4));
			searchVO.setSchEtc02(nowDate.substring(5, 7));
			searchVO.setSchEtc03(nowDate);
		}
		
		// default 검색날짜
		if (StringUtils.isEmpty(searchVO.getSearchStartDate()) && StringUtils.isEmpty(searchVO.getSearchEndDate())) {
			DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy.MM.dd");
			String startDate = new SimpleDateFormat("yyyy.MM.dd").format(new Date());	// 오늘
			String endDate = dateFormat.format(LocalDate.parse(startDate, dateFormat).plusDays(7));	// 7일뒤 
			searchVO.setSearchStartDate(startDate);
			searchVO.setSearchEndDate(endDate);
		} 
    }
    
    public void addCalList(CmSchdVO searchVO, Model model) {
		
		LocalDate selDate = LocalDate.parse(searchVO.getSchEtc01() + searchVO.getSchEtc02() + "01", DateTimeFormatter.ofPattern("yyyyMMdd"));
		
		// 첫주의 시작요일  
		model.addAttribute("firstWeekdayOfMonth", selDate.with(TemporalAdjusters.firstDayOfMonth()).getDayOfWeek().getValue()); // 월1 화2 수3 목4 금5 토6 일7
		// 마지막 날짜
		model.addAttribute("lastDayOfMonth", selDate.with(TemporalAdjusters.lastDayOfMonth()).getDayOfMonth());
		
		// 월간 목록 
		List<CmSchdVO> resultList = (List<CmSchdVO>)defaultDao.selectList(sqlNs+"selectMonthList", searchVO); 
		model.addAttribute("resultList", resultList);
		
		// 휴일 목록
		List<CmSchdVO> holidayList = (List<CmSchdVO>)defaultDao.selectList(sqlNs+"selectHolidayList", searchVO); 
		model.addAttribute("holidayList", holidayList);
	}
	
	public void addDayList(CmSchdVO searchVO, Model model){
		
		LocalDate selDate = LocalDate.parse(searchVO.getSchEtc01() + searchVO.getSchEtc02() + "01", DateTimeFormatter.ofPattern("yyyyMMdd"));
		
		// 첫주의 시작요일  
		model.addAttribute("firstWeekdayOfMonth", selDate.with(TemporalAdjusters.firstDayOfMonth()).getDayOfWeek().getValue()); // 월1 화2 수3 목4 금5 토6 일7
		// 마지막 날짜
		model.addAttribute("lastDayOfMonth", selDate.with(TemporalAdjusters.lastDayOfMonth()).getDayOfMonth());
		
		// 월간 목록
		List<CmSchdVO> resultList = (List<CmSchdVO>)defaultDao.selectList(sqlNs+"selectMonthList", searchVO); 
		model.addAttribute("resultList", resultList);
		
		// 휴일 목록
		List<CmSchdVO> holidayList = (List<CmSchdVO>)defaultDao.selectList(sqlNs+"selectHolidayList", searchVO); 
		model.addAttribute("holidayList", holidayList);
	}
	
	public void addList(CmSchdVO searchVO, Model model)  throws Exception {
		
		
		// default 년 월
		if(StringUtils.isEmpty(searchVO.getSelYear()) && StringUtils.isEmpty(searchVO.getSelMonth())) {
			String nowDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
			searchVO.setSelYear(nowDate.substring(0, 4));
			searchVO.setSelMonth(nowDate.substring(4, 6));
			searchVO.setCurrentDate(nowDate);
		}
		
		// 스케줄 건수 조회
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		CmSchdVO rtnVo = (CmSchdVO)defaultDao.selectOne(sqlNs+"selectCount" , searchVO);
		int schdCount =  Integer.parseInt(rtnVo.getSchdCount());
		paginationInfo.setTotalRecordCount(schdCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 스케줄 목록 조회
		List<CmSchdVO> resultList = (List<CmSchdVO>)defaultDao.selectList(sqlNs+"selectList",searchVO ); 
		model.addAttribute("resultList", resultList);
	}
	
	public String popForm(CmSchdVO searchVO, String procType, Model model, HttpSession session){
		
		CmSchdVO cmSchdVO = new CmSchdVO();
		
		if ("update".equals(searchVO.getProcType())) { 
			// 관리자 또는 본인글인 경우
			if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
				// 일정 일련번호 없는 경우
				if(StringUtils.isEmpty(searchVO.getSchdSerno())) {
					return "redirect:list.do";
				}
				
				cmSchdVO = (CmSchdVO)defaultDao.selectOne(sqlNs+"selectContents", searchVO); 
			} else {
				return "redirect:list.do";
			}
		} else {
			// default 일정 세팅
			String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm"));
			cmSchdVO.setSchdStrtYmd(now.substring(0, 10));
			cmSchdVO.setSchdEndYmd(now.substring(0, 10));
			cmSchdVO.setSchdStrtHhMn(now.substring(11, 15) + "0");
			cmSchdVO.setSchdEndHhMn(now.substring(11, 15) + "0");
		} 
		model.addAttribute("cmSchdVO", cmSchdVO); 
		return ""; 
	}
	
	public CommonMap insertProc(CmSchdVO searchVO, BindingResult result){
		
		CommonMap returnMap = new CommonMap(); 
		int resultCnt = defaultDao.insert(sqlNs+"insertContents" , searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "list.do");
		return returnMap;
	}
	
	public CommonMap updateProc(CmSchdVO searchVO, BindingResult result, HttpSession session){
		
		CommonMap returnMap = new CommonMap(); 
		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			
			int resultCnt = defaultDao.update(sqlNs+"updateContents" ,searchVO ); 
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
		
		returnMap.put("returnUrl", "list.do");
		return returnMap;
	}
	
	public CommonMap deleteProc(CmSchdVO searchVO, BindingResult result, HttpSession session){
		CommonMap returnMap = new CommonMap(); 

		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) { 
			int resultCnt = defaultDao.update(sqlNs+"deleteContents" ,searchVO );
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
		
		returnMap.put("returnUrl", "list.do");
		return returnMap;
	
	}
	
	public CommonMap hdayInsertProc(String selYear, HttpSession session) throws Exception {
		
		CommonMap returnMap = new CommonMap(); 
		
		// 관리자 아닌 경우
		if(!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		} else { 
			returnMap.putAll(insertHolidayContents(selYear)); 
		}
		return returnMap;
	}
	
	public ModelAndView excelDownload(CmSchdVO searchVO) throws Exception{
		
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "일정_목록";
		String url = "/standard/component/Schedule/schdList.xlsx";  
		
		List<CmMnlVO> resultList = (List<CmMnlVO>)defaultDao.selectList(sqlNs+"selectExcelList", searchVO); 
		
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
	
	}
    
    
	// 일정 건수 조회
	/*public int selectCount(CmSchdVO vo) {
		return schdMngMapper.selectCount(vo);
	}*/
	
	// 일정 목록 조회
	/*public List<CmSchdVO> selectList(CmSchdVO vo) {
		return schdMngMapper.selectList(vo);
	}*/
	
	// 일정 상세 조회
	/*public CmSchdVO selectContents(CmSchdVO vo) {
		return schdMngMapper.selectContents(vo);
	}*/
	
	// 일정 월별 목록 조회
	/*public List<CmSchdVO> selectMonthList(CmSchdVO vo) {
		return schdMngMapper.selectMonthList(vo);
	}*/

	// 일정 일별 목록 조회
	/*public List<CmSchdVO> selectTodayList(CmSchdVO vo) {
		return schdMngMapper.selectTodayList(vo);
	}*/

	// 일정 엑셀 목록 조회
	/*public List<CmMnlVO> selectExcelList(CmSchdVO vo) {
		return schdMngMapper.selectExcelList(vo);
	}*/
	
	// 일정 본인글 여부
	public boolean regrCheck(CmSchdVO vo) {
		CmSchdVO rtnVo = (CmSchdVO)defaultDao.selectOne(sqlNs+"regrCheck", vo);
		return Integer.parseInt(rtnVo.getIsRegrCheck()) == 1 ? true : false; 
	}

	// 일정 등록
	/*public int insertContents(CmSchdVO vo) {
		return schdMngMapper.insertContents(vo);
	}*/

	// 일정 수정
	/*public int updateContents(CmSchdVO vo) {
		return schdMngMapper.updateContents(vo);
	}*/

	// 일정 삭제
	/*public int deleteContents(CmSchdVO vo) {
		return schdMngMapper.deleteContents(vo);
	}*/
	
	// 휴일 등록
	/*public int mergeHolidayList(List<CmHdayResponseItem> holidayList) {
		return defaultDao.insertList( "com.opennote.standard.mapper.component.SchdMngMapper.mergeHolidayList", holidayList ); 
	}*/
	
	// 휴일 목록 조회
	/*public List<CmSchdVO> selectHolidayList(CmSchdVO vo) {
		return schdMngMapper.selectHolidayList(vo);
	}*/
	
	// 휴일 API 호출 및 등록
	public CommonMap insertHolidayContents(String selYear) throws Exception {
		
		CommonMap returnMap = new CommonMap();
		
		// 국경일 및 공휴일 조회
		HashMap<String, Object> getHolideInfoResult = unmarshalXml(getHolidayInfo("getHoliDeInfo", selYear));
		
		// API오류 발생시 메소드 종료
		if(!"00".equals(getHolideInfoResult.get("responseCode"))) {
			returnMap.put("message", getHolideInfoResult.get("message"));
			return returnMap;
		} else {
			List<CmHdayResponseItem> holidayList = (List<CmHdayResponseItem>) getHolideInfoResult.get("itemList"); 
			defaultDao.insertList( sqlNs+"mergeHolidayList", holidayList ); 
			returnMap.put("holidayMessage", selYear + "년도 공휴일이 저장되었습니다.");
		}

		// 기념일 조회
		HashMap<String, Object> getAnniversaryInfoResult = unmarshalXml(getHolidayInfo("getAnniversaryInfo", selYear)); 
		// API오류 발생시 메소드 종료
		if(!"00".equals(getAnniversaryInfoResult.get("responseCode"))) {
			returnMap.put("message", getAnniversaryInfoResult.get("message"));
			return returnMap;
		} else {
			List<CmHdayResponseItem> anniversaryList = (List<CmHdayResponseItem>) getAnniversaryInfoResult.get("itemList");
			defaultDao.insertList( sqlNs+"mergeHolidayList", anniversaryList );  
			returnMap.put("anniversaryMessage", selYear + "년도 기념일이 저장되었습니다.");
		}
		return returnMap;
	}
	
	public String getHolidayInfo(String operationName, String selYear) throws Exception{
		
		// numOfRows 미입력 시 공공데이터가 페이징 처리되어 일부만 넘어옴
		String numOfRows = "100";
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/" + operationName); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + serviceKey); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8")); /*한 페이지 결과 수*/
		urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(selYear, "UTF-8")); /*연*/
//		urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		
		URL url = new URL(urlBuilder.toString());
	    HttpURLConnection conn = null;
	    BufferedReader rd = null;
	    
	    try {
	        conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");

	        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        
	        return sb.toString();
	    } finally {
	        if (rd != null) {
	            try {
	                rd.close();
	            } catch (IOException e) {
	                System.out.println("CmSchdService.getHolidayInfo 예외 발생");
	            } catch (Exception e) {
	            	System.out.println("CmSchdService.getHolidayInfo 예외 발생");
	            }
	        }
	        if (conn != null) {
	            conn.disconnect();
	        }
	    }
	}
	
	// 언마샬링 : XML 형식의 데이터를 Java 객체로 매핑
	public HashMap<String, Object> unmarshalXml(String xml) throws Exception {
		
		// dateName = '1월1일' >> '신정'으로 바꾸기
		xml = xml.replace("1월1일", "신정");
		// dateName = '기독탄신일' >> '성탄절'로 바꾸기
		xml = xml.replace("기독탄신일", "성탄절");
		
		HashMap<String, Object> resultMapList = new HashMap<>();
		JAXBContext jaxbContext;
	    Unmarshaller jaxbUnmarshaller;
	    
	    if(xml.contains("<response>")) {
	    	// CmHdayResponseVO 클래스를 JAXB컨텍스트에 등록 
	    	jaxbContext = JAXBContext.newInstance(CmHdayResponseVO.class);
	        jaxbUnmarshaller = jaxbContext.createUnmarshaller();
	        
	        // xml 문자열을 CmHdayResponseVO 객체로 변환
	        CmHdayResponseVO response = (CmHdayResponseVO) jaxbUnmarshaller.unmarshal(new StringReader(xml));
		    Items items = response.getBody().getItems();
		    if (items != null) {
		    	List<CmHdayResponseItem> itemList = items.getItemList();
		    	resultMapList.put("itemList", itemList);
		    	resultMapList.put("responseCode", response.getHeader().getResultCode());
		    } 
	    } else {
	    	// CmHdayResponseErrorVO 클래스를 JAXB컨텍스트에 등록 
	    	jaxbContext = JAXBContext.newInstance(CmHdayResponseErrorVO.class);
	        jaxbUnmarshaller = jaxbContext.createUnmarshaller();
	        
	        // xml 문자열을 CmHdayResponseErrorVO 객체로 변환
	    	CmHdayResponseErrorVO responseWrapper = (CmHdayResponseErrorVO) jaxbUnmarshaller.unmarshal(new StringReader(xml));
	    	CmmMsgHeader cmmMsgHeader = responseWrapper.getCmmMsgHeader();
	    	
	    	if (cmmMsgHeader != null) {
	    		resultMapList.put("responseCode", cmmMsgHeader.getReturnReasonCode());
	    		resultMapList.put("message", getErrorMsg(cmmMsgHeader.getReturnReasonCode()));
	    		return resultMapList;
	    	}
	    }
	    
	    return resultMapList;
    }
	
	public String getErrorMsg(String errorCode) {
		String message = "";
		
		switch(errorCode) {
			case "01" :
				message = "어플리케이션 에러가 발생하였습니다.";
				break;
			case "02" :
				message = "데이터베이스 에러가 발생하였습니다.";
				break;
			case "03" :
				message = "데이터없음 에러가 발생하였습니다.";
				break;
			case "04" :
				message = "HTTP 에러가 발생하였습니다.";
				break;
			case "05" :
				message = "서비스 연결실패 에러가 발생하였습니다.";
				break;
			case "10" :
				message = "잘못된 요청 파라미터 에러가 발생하였습니다.";
				break;
			case "11" :
				message = "필수요청 파라미터가 없습니다.";
				break;
			case "12" :
				message = "해당 오픈API서비스가 없거나 폐기되었습니다.";
				break;
			case "20" :
				message = "서비스 접근거부 되었습니다.";
				break;
			case "21" :
				message = "일시적으로 사용할 수 없는 서비스키 입니다.";
				break;
			case "22" :
				message = "서비스 요청제한횟수 초과에러가 발생하였습니다.";
				break;
			case "30" :
				message = "등록되지 않은 서비스키입니다.";
				break;
			case "31" :
				message = "기한만료된 서비스키입니다.";
				break;
			case "32" :
				message = "등록되지 않은 IP주소입니다.";
				break;
			case "33" :
				message = "서명되지 않은 호출입니다.";
				break;
			default :
				message = "기타 에러가 발생하였습니다.";
				break;
		}
		
		return message;
	}

}
