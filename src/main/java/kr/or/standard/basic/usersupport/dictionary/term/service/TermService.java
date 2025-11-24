package kr.or.standard.basic.usersupport.dictionary.term.service;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.file.vo.FileVO;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.module.ExcelUtil;
import kr.or.standard.basic.usersupport.dictionary.term.vo.CmTermVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;
 
import javax.validation.Validator;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException; 
 

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class TermService  extends EgovAbstractServiceImpl {
 
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    private final Validator validator;
    private final ExcelUtil excelUtil;
    private final FileService fileService;
    	 
    private final String sqlNs = "com.opennote.standard.mapper.usersupport.TermMngMapper.";
    
    public void addList(CmTermVO searchVO, Model model) throws Exception {
        PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
        
        CmTermVO rtnVo = (CmTermVO)defaultDao.selectOne(sqlNs+"selectCount",searchVO);
        int termCount = Integer.parseInt(rtnVo.getTermCount()); 
		paginationInfo.setTotalRecordCount(termCount);
		model.addAttribute("paginationInfo", paginationInfo);
        
        List<CmTermVO> resultList = (List<CmTermVO>)defaultDao.selectList(sqlNs+"selectList",searchVO); 
		model.addAttribute("resultList", resultList); 
    }
    
    public void view(CmTermVO searchVO, Model model){
        CmTermVO cmTermVO = (CmTermVO)defaultDao.selectOne(sqlNs+"selectContents" , searchVO); 
		model.addAttribute("cmTermVO", cmTermVO);
    }
    
    public String form(CmTermVO searchVO, Model model, String procType, HttpSession session){
         
         CmTermVO cmTermVO = new CmTermVO(); 
		if("update".equals(procType)) {
			// 관리자가 아닌 경우
			if(!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
				return "redirect:list.do";
			}

			// 일련번호 없는 경우
			if(StringUtils.isEmpty(searchVO.getTermSerno())) {
				return "redirect:list.do";
			}
			cmTermVO = (CmTermVO)defaultDao.selectOne(sqlNs+"selectContents" , searchVO); 
		} 
		model.addAttribute("cmTermVO", cmTermVO);
        return "";
    }
    
    
	// 용어영문명 중복체크
	public int termEngNmDuplChk(CmTermVO vo) {
	    CmTermVO rtnVo = (CmTermVO)defaultDao.selectOne(sqlNs+"termEngNmDuplChk" , vo); 
	    return Integer.parseInt(rtnVo.getTermCount()); 
	};
    
    public CommonMap insertProc(CmTermVO searchVO, BindingResult result, HttpSession session){
		CommonMap returnMap = new CommonMap(); 

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}
        
        int resultCnt = defaultDao.insert(sqlNs+"insertContents" , searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		returnMap.put("returnUrl", "list.do");
        return returnMap;
    }
    
    public CommonMap updateProc(CmTermVO searchVO, BindingResult result, HttpSession session){
		CommonMap returnMap = new CommonMap(); 
		
		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}
        
        int resultCnt = defaultDao.insert(sqlNs+"updateContents" , searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		returnMap.put("returnUrl", "view.do");
		return returnMap; 
    }
    
    public CommonMap deleteProc(CmTermVO searchVO, BindingResult result, HttpSession session){
        
        
		CommonMap returnMap = new CommonMap();  

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}
    
        int resultCnt = defaultDao.update(sqlNs+"deleteContents" , searchVO);  
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} else {
			returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			returnMap.put("returnUrl", "view.do");
		}
		return returnMap;
    }
    
    public void excelDownload(CmTermVO searchVO, HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        
		// 데이터
		List<CmTermVO> resultList = (List<CmTermVO>)defaultDao.selectList(sqlNs+"selectExcleList" , searchVO);
		//List<CmTermVO> resultList = cmTermService.selectExcleList(searchVO);
		
		// 엑셀 헤더 설정(이름, 변수명)
		String[][] headerField = {
				{"용어명"		, "termNm"},
				{"용어영문명"		, "termEngNm"},
				{"도메인명"		, "dmnNm"},
				{"표준여부"		, "stdYn"},
				{"용어설명"		, "termExpl"},
				{"개인정보여부"	, "pinfYn"},
				{"암호화여부"		, "encYn"},
				{"도메인그룹"		, "dmnGrp"},
				{"데이터타입"		, "dataTp"},
				{"길이"			, "dataLen"},
				{"길이(소수점)"	, "dataLenDcpt"}
		};
		// workbook 생성
		Workbook workbook = createExcel(resultList, headerField);

		try (OutputStream os = response.getOutputStream()) {
			Date time = new Date();
			SimpleDateFormat dateformat = new SimpleDateFormat ("yyyyMMdd");
			String nowDate = dateformat.format(time);
			String fileName = "용어관리_"+nowDate; // 파일명 설정
			String header = request.getHeader("User-Agent");

			//브라우저별 파일명 인코딩
			if (header.contains("Edge")){
				fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
				response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\".xlsx;");
			} else if (header.contains("MSIE") || header.contains("Trident")) {
				fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
				response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx;");
			} else if (header.contains("Chrome")) {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\".xlsx");
			} else if (header.contains("Opera")) {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\".xlsx");
			} else if (header.contains("Firefox")) {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xlsx");
			}else {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\".xlsx");
			}

			response.setHeader("Set-Cookie", "fileDownload=true; path=/");
			workbook.write(os);
		} catch (IOException e) {
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
			log.info("파일 다운로드 중 에러가 발생했습니다.");
		}
    
    }
    
    public ModelAndView excelSample(CmTermVO searchVO){ 
    	
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "용어샘플";
		String url = "/standard/usersupport/termSample.xlsx"; 
		
		mav.addObject("target", tit);
		mav.addObject("source", url);

		return mav; 
    }
    
    public ResponseEntity excelUpload(FileVO fileVO, HttpSession session){
		
		CommonMap returnMap = new CommonMap(); 
		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			return ResponseEntity.ok(returnMap);
		}

		fileVO.setFileSeqo("0");
		FileVO atchFile = fileService.getAtchFile(fileVO);		// 파일 정보
		FileInputStream file = getFile(atchFile); // 파일 읽기


		// 파일 존재 X
		if (file == null) {
			returnMap.put("message", messageSource.getMessage("file.empty.message", null, null));
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(returnMap);
		}

		// 엑셀 헤더 설정(변수명)
		String[] headerField = {"termNm", "termEngNm", "dmnNm", "stdYn", "termExpl", "pinfYn", "encYn", "dmnGrp", "dataTp", "dataLen", "dataLenDcpt"};

		// 엑셀 파일 읽기
		List<CmTermVO> excelList = excelUtil.readExcel(CmTermVO.class, headerField, 0, file);

		// 읽는 중 에러 발생
		if (excelList == null) {
			returnMap.put("message", messageSource.getMessage("error.message", null, null));
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(returnMap);
		}

		// 엑셀 유효성체크
		int rowNum = 2;
		for (CmTermVO vo : excelList) {
			String errMessage = valid(vo, CmTermVO.insertCheck.class);
			if (StringUtils.isNotEmpty(errMessage)) {
				returnMap.put("message", rowNum + "번째 줄의 " + errMessage);
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(returnMap);
			} else {
				rowNum += 1;
			}
		}

		// 엑셀 일괄업로드 
		int resultCnt = defaultDao.insertList(sqlNs + "insertList" , excelList); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		} 
		return ResponseEntity.ok(returnMap); 
    }
    
	// 용어 건수 조회
	/*public int selectCount(CmTermVO vo) {
		return termMngMapper.selectCount(vo);
	};*/

	// 용어 목록 조회
	/*public List<CmTermVO> selectList(CmTermVO vo) {
		return termMngMapper.selectList(vo);
	};*/

	// 용어 상세 조회
	/*public CmTermVO selectContents(CmTermVO vo) {
		return termMngMapper.selectContents(vo);
	};*/


	// 용어 등록
	public int insertContents(CmTermVO vo) {
		return defaultDao.insert(sqlNs + "insertContents" , vo); 
	};

	// 용어 수정
	/*public int updateContents(CmTermVO vo) {
		return termMngMapper.updateContents(vo);
	};*/

	// 용어 삭제
	/*public int deleteContents(CmTermVO vo) {
		return termMngMapper.deleteContents(vo);
	};*/

	// 용어 목록 엑셀 조회
	/*public List<CmTermVO> selectExcleList(CmTermVO vo) {
		return termMngMapper.selectExcleList(vo);
	};*/

	// 용어 일괄 등록
	/*public int insertList(List<CmTermVO> list) {
		return termMngMapper.insertList(list);
	}*/
	
	// 용어명 조회
	public CmTermVO selectTermContents(String termEngNm) {
		return (CmTermVO)defaultDao.selectOne(sqlNs+"selectTermContents", termEngNm); 
	}
	/**
	 * 엑셀 생성
	 * @param resultList : 데이터
	 * @param headerField {{"헤더명", "변수명"},{"헤더명", "변수명"}}
	 * @return workbook
	 */
	public <T> Workbook createExcel(List<T> resultList, String[][] headerField) {
		Workbook workbook = new SXSSFWorkbook();
		// 시트 생성
		Sheet sheet = workbook.createSheet("Sheet1");

		// 스타일 생성
		CellStyle cellStyle = workbook.createCellStyle(); // 모든 테두리
		cellStyle.setBorderBottom(BorderStyle.THIN);
		cellStyle.setBorderTop(BorderStyle.THIN);
		cellStyle.setBorderRight(BorderStyle.THIN);
		cellStyle.setBorderLeft(BorderStyle.THIN);

		// 헤더 생성
		Row headerRow = sheet.createRow(0);

		// 헤더 셀에 이름 설정
		for (int i = 0; i < headerField.length; i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellValue(headerField[i][0]);
			cell.setCellStyle(cellStyle);
		}

		if (resultList != null) {
			// 데이터 행 삽입
			for (int i = 0; i < resultList.size(); i++) {
				Row row = sheet.createRow(i + 1); // 다음 행 생성
				T result = resultList.get(i);

				for (int j = 0; j < headerField.length; j++) {
					Object[] header = headerField[j];
					try {
						Field field = result.getClass().getDeclaredField((String) header[1]); // 변수명 가져오기
						field.setAccessible(true); // 필드에 접근하기 위해 접근 가능하도록 설정

						Object value = field.get(result); // 변수값 가져오기

						Cell cell = row.createCell(j);
						cell.setCellValue(value == null ? "" : value.toString()); // 셀에 값 세팅
						cell.setCellStyle(cellStyle);
					} catch (NoSuchFieldException | IllegalAccessException e) {
						log.info("엑셀 다운로드 중 필드값을 찾을 수 없습니다: " + header[1]);
					}
				}
			}
		}

		return workbook;
	}

	// service 유효성 체크
	public <T> String valid(T vo, Class<?>... groups) {
		Set<ConstraintViolation<T>> violations = validator.validate(vo, groups);

		String errMessage = null;
		if (!violations.isEmpty()) {
			for (ConstraintViolation<T> violation : violations) {
				errMessage = violation.getMessage();
				break;
			}
		}

		return errMessage;
	}

	// 파일 경로로 읽기
	public FileInputStream getFile(FileVO vo) {
		String filePath = vo.getPhclFilePthNm() + vo.getFileNmPhclFileNm();
		File file = new File(filePath);
		FileInputStream io = null;
		try {
			io = new FileInputStream(file);
		} catch (FileNotFoundException e) {
			log.info("파일이 존재하지 않습니다.");
		}
		return io;
	} 
    
}
