package kr.or.standard.basic.component.regcd.service;
  
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.view.excel.ExcelView; 
import kr.or.standard.basic.component.regcd.vo.CmRegCdVO; 
import lombok.RequiredArgsConstructor;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellUtil;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class CmRegCdService extends EgovAbstractServiceImpl {
     
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
    private final PaginationService paginationService; 
	private final MessageSource messageSource;
	private final ExcelView excelView;
	private final String sqlNs = "com.standard.mapper.component.RegCdMngMapper.";
     
    @Value("${bcode.decodingkey}")
	private String DECODINGKEY;
	 
     
    
    public void addList(CmRegCdVO searchVO, Model model) throws Exception {
        
        
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		CmRegCdVO rtnMap = (CmRegCdVO)defaultDao.selectOne(sqlNs+"selectCount" ,searchVO );
		int regCdCnt = Integer.parseInt(rtnMap.getRegCdCnt()); 
		paginationInfo.setTotalRecordCount(regCdCnt);
		model.addAttribute("paginationInfo", paginationInfo);

        List<CmRegCdVO> resultList = (List<CmRegCdVO>)defaultDao.selectList(sqlNs+"selectList" ,searchVO ); 
		model.addAttribute("resultList", resultList); 
    }
    
    public void cmmnRegJsp(CmRegCdVO searchVO, Model model, String menuTp) throws Exception{
    	
		List<CmRegCdVO> selectList = new ArrayList<>();

		// 시도
		if("SIDO".equals(menuTp)) {
			searchVO.setLvl("1");
			selectList =  (List<CmRegCdVO>)defaultDao.selectList(sqlNs+"selectRegList" ,searchVO ); 
		// 시군구
		} else if("CGG".equals(menuTp)) {
			searchVO.setLvl("2");
			selectList =  (List<CmRegCdVO>)defaultDao.selectList(sqlNs+"selectRegList" ,searchVO ); 
		// 읍면동
		} else if("UMD".equals(menuTp)) {
			searchVO.setLvl("3");
			selectList =  (List<CmRegCdVO>)defaultDao.selectList(sqlNs+"selectRegList" ,searchVO ); 
		// 리
		} else if("RI".equals(menuTp)) {
			searchVO.setLvl("4");
			selectList =  (List<CmRegCdVO>)defaultDao.selectList(sqlNs+"selectRegList" ,searchVO );  
		}

		model.addAttribute("selectList", selectList);
		model.addAttribute("menuTp", menuTp);
    
    }
    
    public String regUpdate() {

		String message = "오류가 발생하였습니다.\n관리자에게 문의하세요."; 
		defaultDao.delete(sqlNs+"deleteTempContents"); 

		/** api 건수 */
		int regCount = 0;
		/** 한번에 가져올 건수 */
		int numOfRows = 1000;
		
		try {
			/** API 법정동 건수 조회 */
			JSONObject object = regApi("", "", "json", "");
			JSONArray arrJson = (JSONArray) object.get("StanReginCd");
			JSONObject head = (JSONObject) arrJson.get(0);
			JSONArray arrJson2 = (JSONArray) head.get("head");
			JSONObject totalCount = (JSONObject) arrJson2.get(0);

			regCount = Integer.parseInt(ObjectUtils.defaultIfNull(totalCount.get("totalCount") + "", "0"));
			log.info("regCount : {}", regCount);
		} catch (Exception e) {
			return message;
		}

		// API 전체 조회
		List<Map<String, String>> list;
		try {
			int cnt = regCount / numOfRows + (regCount % numOfRows > 0 ? 1 : 0); 
			for(int i = 0;i < cnt;i++) {
  
				JSONObject object = regApi((i + 1) + "", numOfRows + "", "json", "");
				JSONArray arrJson = (JSONArray) object.get("StanReginCd");

				JSONObject row = (JSONObject) arrJson.get(1);
				JSONArray arrJson2 = (JSONArray) row.get("row");

				list = arrJsonToListMap(arrJson2);

				if(CollectionUtils.size(list) > 0) {
					/** API INSERT */
					this.regCodeInsert(list);
				}

			}

		} catch (Exception e) {
			return message;
		}

		/** 임시테이블 2차작업 */
		updateTempSet();
	
		defaultDao.delete(sqlNs+"deleteContents"); 
		  
		/** 최종 인서트 */
		defaultDao.insert(sqlNs+"insertContents"); 

		/* del_ymd 셋팅 */
		defaultDao.update(sqlNs+"updateDelYmdContents"); 

		message = "법정동 코드의 갱신이 완료되었습니다."; 
		return message;

	}
	
	public void bigExcelDownload(CmRegCdVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			int ROW_ACCESS_WINDOW_SIZE = 1000;
			String filePath= request.getSession().getServletContext().getRealPath("/excel/standard/component/CmRegCd/regCdList_big.xlsx");
			
			FileInputStream fis = null;
			XSSFWorkbook xssfWorkbook = null; 
			SXSSFWorkbook sxssfWorkbook = null; 
	 		
			// 행 번호
			int rowNum = 1;
			try {
			
				fis = new FileInputStream(filePath);
				 
				xssfWorkbook = new XSSFWorkbook(fis);
				sxssfWorkbook = new SXSSFWorkbook(xssfWorkbook, ROW_ACCESS_WINDOW_SIZE);
				 
				// 현재 sheet 반환 (첫번째시트 : 0)
				SXSSFSheet objSheet = sxssfWorkbook.getSheetAt(0);
				 
				// 엑셀 목록 조회
				List<CmRegCdVO> excelList = (List<CmRegCdVO>)defaultDao.selectList(sqlNs+"selectExcelList" ,searchVO ); 
				
				SXSSFRow objRow = null;		// 행
				SXSSFCell objCell = null;   // 셀
				for(CmRegCdVO excelVO : excelList) {
					// 행 생성
					objRow = objSheet.createRow(rowNum);
					objRow.setHeight((short) 0x150);
	
					// 열 생성
					// 법정동 코드
					objCell = objRow.createCell(0);
					objCell.setCellValue(excelVO.getRegCd());
					CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
	
					// 시도
					objCell = objRow.createCell(1);
					objCell.setCellValue(excelVO.getSidoNm());
					CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
	
					// 시군구
					objCell = objRow.createCell(2);
					objCell.setCellValue(excelVO.getCggNm());
					CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
	
					// 읍면동
					objCell = objRow.createCell(3);
					objCell.setCellValue(excelVO.getUmdNm());
					CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
	
					// 리
					objCell = objRow.createCell(4);
					objCell.setCellValue(excelVO.getRiNm());
					CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
	
					// 레벨
					objCell = objRow.createCell(5);
					objCell.setCellValue(excelVO.getLvl());
					CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
	
					++rowNum;
				}
	
				// 파일 이름 생성
				Date time = new Date();
				SimpleDateFormat dateformat = new SimpleDateFormat ("yyyyMMdd");
				String nowDate = dateformat.format(time);
				String filename="법정동코드_"+nowDate;
				String header = request.getHeader("User-Agent");
	
				//브라우저별 파일명 인코딩
				if (header.contains("Edge")){
					filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
					response.setHeader("Content-Disposition", "attachment;filename=\"" + filename + "\".xlsx;");
				} else if (header.contains("MSIE") || header.contains("Trident")) {
					filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
					response.setHeader("Content-Disposition", "attachment;filename=" + filename + ".xlsx;");
				} else if (header.contains("Chrome")) {
					filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
					response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\".xlsx");
				} else if (header.contains("Opera")) {
					filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
					response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\".xlsx");
				} else if (header.contains("Firefox")) {
					filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
					response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".xlsx");
				}else {
					filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
					response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\".xlsx");
				}
	
				response.setHeader("Set-Cookie", "fileDownload=true; path=/");
				OutputStream fileOut = response.getOutputStream();
	
				// 클라이언트로 파일 전송
				sxssfWorkbook.write(fileOut);
			} catch (Exception e) {
				// 실패시에도 fileDownload=false 값으로 응답해줘야 종료됨
				response.setHeader("Set-Cookie", "fileDownload=false; path=/");
				response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
				response.setHeader("Content-Type", "text/html; charset=utf-8");
				OutputStream out = null;
				try {
					out = response.getOutputStream();
					byte[] data = new String("fail").getBytes();
					out.write(data, 0, data.length);
				} catch (Exception ignore) {
					ignore.printStackTrace();
				} finally {
					if (out != null) {out.close();}
				}
			} finally {
				// fileOut.close();
				response.getOutputStream().flush();
				response.getOutputStream().close();
	
				//임시 엑셀파일 삭제
				if(sxssfWorkbook != null) { 
					try{ sxssfWorkbook.dispose(); sxssfWorkbook.close();}catch(Exception e){}
				}  
				
				if(xssfWorkbook != null) try{ xssfWorkbook.close();}catch(Exception e){}
				if(fis != null) try{ fis.close();}catch(Exception e){}
				 
			}
	}
    
    

	/*public int selectCount(CmRegCdVO vo) { 
		return regCdMngMapper.selectCount(vo);
	};*/

	/*public List<CmRegCdVO> selectList(CmRegCdVO vo) { 
		return regCdMngMapper.selectList(vo);
	};*/

	/*public List<CmRegCdVO> selectExcelList(CmRegCdVO vo) { 
		return regCdMngMapper.selectExcelList(vo);
	};*/
 
	/*public void deleteContents() { 
		regCdMngMapper.deleteContents();
	}*/

	/*public void insertContents() { 
		regCdMngMapper.insertContents();
	}*/

	/*public void updateDelYmdContents() { 
		regCdMngMapper.updateDelYmdContents();
	}*/

	/*public List<CmRegCdVO> selectRegList(CmRegCdVO vo) { 
		return regCdMngMapper.selectRegList(vo);
	};*/

	/*public void deleteTempContents() {
		regCdMngMapper.deleteTempContents();
	};*/

	public void updateTempSet() {
		defaultDao.update(sqlNs+"updateTempSidoContents");
		defaultDao.update(sqlNs+"updateTempCggContents");
		defaultDao.update(sqlNs+"updateTempUmdContents");
	}

	

	public void regCodeInsert(List<Map<String, String>> list) {

		List<CmRegCdVO> apiList = new ArrayList<>();

		if(CollectionUtils.size(list) > 0) {
			for(Map<String, String> map : list) {
				CmRegCdVO vo = new CmRegCdVO();
				String regionCd = map.get("region_cd");
				vo.setRegCd(regionCd);   						// 1 법정동코드
				vo.setRnko(map.get("locat_order")); 			// 7 서열
				vo.setCreYmd(map.get("adpt_de")); 				// 8 생성일
				vo.setLwposAreaNm(map.get("locallow_nm"));  	// 9 최하위지역명


				// 유효성검사
				if(! "".equals(ObjectUtils.defaultIfNull(regionCd, ""))) {

					vo.setSidoNm(null); // 7 시도명
					vo.setCggNm(null); // 8 시군구명
					vo.setUmdNm(null); // 9 읍면동명
					vo.setRiNm(null); // 10 리명
					vo.setLvl("5"); // 16 레벨

					// 1레벨 시도
					if("00000000".equals(regionCd.substring(2, 10))) {
						vo.setLvl("1");
						vo.setSidoNm(map.get("locallow_nm"));
						// 2레벨 시군구
					} else if("00000".equals(regionCd.substring(5, 10))) {
						vo.setLvl("2");
						vo.setCggNm(map.get("locallow_nm"));

						// 3레벨 읍면동
					} else if("00".equals(regionCd.substring(8, 10))) {
						vo.setLvl("3");
						vo.setUmdNm(map.get("locallow_nm"));
						// 4레벨 리
					} else {
						vo.setLvl("4");
						vo.setRiNm(map.get("locallow_nm"));
					}

				}

				apiList.add(vo);
			}
			 
			defaultDao.insertList(sqlNs+"insertList", apiList); 
		}
	}

	public JSONObject regApi(String pageNo, String numOfRows, String type, String keyWord) throws Exception {

		/** URL 원본 */
		String apiUrl = "http://apis.data.go.kr/1741000/StanReginCd/getStanReginCdList";

		/** URL */
		StringBuilder urlBuilder = new StringBuilder(apiUrl);

		/** Service Key */
		urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + URLEncoder.encode(DECODINGKEY, "UTF-8"));

		/** 페이지 번호 */
		urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(ObjectUtils.defaultIfNull(pageNo, "1") , "UTF-8"));

		/** 한페이지 결과 수  */
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(ObjectUtils.defaultIfNull(numOfRows, "10"), "UTF-8"));

		/** 호출문서(xml, json) default : xml */
		urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode(ObjectUtils.defaultIfNull(type, "xml"), "UTF-8"));

		/** 지역주소명 */
		if(! "".equals(ObjectUtils.defaultIfNull(keyWord,""))) {
			urlBuilder.append("&" + URLEncoder.encode("locatadd_nm","UTF-8") + "=" + URLEncoder.encode(ObjectUtils.defaultIfNull(keyWord, ""), "UTF-8"));
		}

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		//System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();

		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			return strJsonToJsonObject(sb.toString());
		} else {
			return new JSONObject();
		}

	}

	// 문자열(JSON 형식)을 파싱하여 JSONObject로 변환
	public static JSONObject strJsonToJsonObject(String strJson) throws Exception {

		JSONParser parser = new JSONParser();

		JSONObject jsonObject = null;

		try {
			Object obj = parser.parse(strJson);
			jsonObject = (JSONObject) obj;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return jsonObject;

	}

	

	// JSONArray를 List<Map<String, String>>
	public static List<Map<String, String>> arrJsonToListMap(JSONArray arrJson){

		List<Map<String, String>> list = new ArrayList<>();

		int size = arrJson.size();

		if(size > 0) {
			for(int i=0; i < size; i++){
				list.add(objJsonToMap((JSONObject) arrJson.get(i)));
			}
		}

		return list;
	}
	
	/* JSONObject를 Map<String, String>으로 변환 */
	public static Map<String, String> objJsonToMap(JSONObject objJson){

		Map<String, String> map = new HashMap<>();

		if(objJson.size() > 0) {
			for(Object key : objJson.keySet()) {
				String keyStr = (String)key;
				String valueStr = objJson.get(keyStr).toString();
				map.put(keyStr, valueStr);
			}
		}

		return map;
	}
    

}
