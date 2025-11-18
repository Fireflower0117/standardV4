package kr.or.standard.basic.system.regeps.service;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.system.regeps.vo.RegepsVO;
 
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellUtil;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Transactional
@RequiredArgsConstructor
public class RegepsService extends EgovAbstractServiceImpl {
     
     
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
    private final PaginationService paginationService;
	private final LginPlcyService lginPlcyService;
	private final MessageSource messageSource;
	private final ExcelView excelView;
	
	public void addList(RegepsVO searchVO, Model model )  throws Exception {
	    
	    
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		// 정규표현식 건수 조회
		RegepsVO rtnVo = (RegepsVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.RegepsMngMapper.selectCount", searchVO);
	    int totalRecordCount = Integer.parseInt( rtnVo.getRegepsCount()); 
		paginationInfo.setTotalRecordCount(totalRecordCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 정규표현식 목록 조회
		List<RegepsVO> resultList = (List<RegepsVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.RegepsMngMapper.selectList" , searchVO); 
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalRecordCount", paginationInfo.getTotalRecordCount());
	}
	   
        
	// 정규표현식 건수 조회
	/*public int selectCount(RegepsVO vo) { 
	  RegepsVO rtnVo = (RegepsVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.RegepsMngMapper.selectCount", vo);
	  return Integer.parseInt( rtnVo.getRegepsCount());  
	};*/
		
	// 정규표현식 목록 조회
	/*public List<RegepsVO> selectList(RegepsVO vo) {
	    return (List<RegepsVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.RegepsMngMapper.selectList" , vo); 
	}*/
	
	public void regepsPop(RegepsVO searchVO, Model model){ 
		List<RegepsVO> resultList = lginPlcyService.selectRegepsList();
		model.addAttribute("resultList", resultList); 
	}
	
	public String insertUpdateForm(RegepsVO searchVO, Model model, String procType, HttpSession session){
	    
	    RegepsVO regepsVO = new RegepsVO(); 
		if("update".equals(procType)) {
			
			// 관리자 또는 본인글인 경우
			if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
				// 정규표현식 일련번호 없는 경우
				if(StringUtils.isEmpty(searchVO.getRegepsSerno())) {
					return "redirect:list.do";
				}
				regepsVO = (RegepsVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.RegepsMngMapper.selectContents" , searchVO);
			} else {
				return "redirect:list.do";
			}
		} 
		model.addAttribute("regepsVO", regepsVO); 
	    return "";
	}
	
	public CommonMap regepsIdCheckProc(RegepsVO searchVO, BindingResult result){
	    
	    
		CommonMap returnMap = new CommonMap();
		boolean resultYn = false;
		String message = "";
		
		// 정규표현식ID 중복체크 
		resultYn = regepsIdCheck(searchVO);
		
		if(resultYn) {
			message = "사용가능한 아이디입니다.";
		} else {
			message = "중복된 아이디입니다.";
		}
		
		returnMap.put("result", resultYn);
		returnMap.put("message", message);
	    return returnMap;
	}
	
	public CommonMap insertProc(RegepsVO searchVO, BindingResult result, HttpSession session){
	    
	    
		
		CommonMap returnMap = new CommonMap(); 
		int resultCnt = insertContents(searchVO);
		
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "list.do");
		
		return returnMap;
	}
	
	public CommonMap updateProc(RegepsVO searchVO, BindingResult result, HttpSession session){
	    
	    
		CommonMap returnMap = new CommonMap();
		  
		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			int resultCnt = updateContents(searchVO);

			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
			returnMap.put("returnUrl", "updateForm.do");
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		}
		
		return returnMap; 
	}
	
	public CommonMap deleteProc(RegepsVO searchVO, BindingResult result, HttpSession session){
		
		CommonMap returnMap = new CommonMap();
		int resultCnt = 0;

		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			resultCnt = deleteContents(searchVO);

			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
				returnMap.put("returnUrl", "list.do");
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
				returnMap.put("returnUrl", "updateForm.do");
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} 
		return returnMap;
	}
	
	public void bigExcelDownload(RegepsVO searchVO, HttpServletRequest request, HttpServletResponse response ) throws Exception{
	    
		int ROW_ACCESS_WINDOW_SIZE = 1000;
		String filePath= request.getSession().getServletContext().getRealPath("/excel/standard/system/regepsList_big.xlsx");
		FileInputStream fis = null;  
		fis = new FileInputStream(filePath);
		
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fis);
		SXSSFWorkbook sxssfWorkbook = new SXSSFWorkbook(xssfWorkbook, ROW_ACCESS_WINDOW_SIZE);
		// sxssfWorkbook.setCompressTempFiles (true); // 임시 파일이 압축

		SXSSFSheet objSheet = null;	// 시트
		SXSSFRow objRow = null;		// 행
		SXSSFCell objCell = null;   // 셀 
		
		// 현재 sheet 반환 (첫번째시트 : 0)
		objSheet = sxssfWorkbook.getSheetAt(0);
		// 행 번호
		int rowNum = 1;
		try {
			
			// 엑셀 목록 조회
			List<RegepsVO> excelList = selectExcelList(searchVO);
			
			for(RegepsVO excelVO : excelList) {
				// 행 생성
				objRow = objSheet.createRow(rowNum);
				objRow.setHeight((short) 0x150);
				
				// 열 생성
				// 정규표현식ID
				objCell = objRow.createCell(0);
				objCell.setCellValue(excelVO.getRegepsId());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 정규표현식명
				objCell = objRow.createCell(1);
				objCell.setCellValue(excelVO.getRegepsNm());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 정규표현식텍스트
				objCell = objRow.createCell(2);
				objCell.setCellValue(excelVO.getRegepsTxt());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 플레이스홀더텍스트
				objCell = objRow.createCell(3);
				objCell.setCellValue(excelVO.getPlaceholderTxt());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 오류 메세지
				objCell = objRow.createCell(4);
				objCell.setCellValue(excelVO.getErrMsg());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 정규표현식예시
				objCell = objRow.createCell(5);
				objCell.setCellValue(excelVO.getRegepsExm());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				++rowNum;
			}
			
			// 파일 이름 생성
			Date time = new Date();
			SimpleDateFormat dateformat = new SimpleDateFormat ("yyyyMMdd");
			String nowDate = dateformat.format(time);
			String filename="정규표현식목록_"+nowDate;
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
			 sxssfWorkbook.dispose();
			 
			 try {sxssfWorkbook.close(); } catch (Exception e) {}
			 try {xssfWorkbook.close(); } catch (Exception e) {}
			 try {fis.close(); } catch (Exception e) {}  
		}
	
	}
	
	public ModelAndView excelDownload(RegepsVO searchVO, Model model){
	    
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "정규표현식목록";
		String url = "/standard/system/regepsList.xlsx";
		
		List<RegepsVO> resultList = selectExcelList(searchVO);
		
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
	}
	
	

	// 정규표현식 상세 id값으로 조회
	public RegepsVO selectIdContents(RegepsVO vo) {
	    return (RegepsVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.RegepsMngMapper.selectIdContents" , vo); 
	}

	// 정규표현식 상세 조회
	public RegepsVO selectContents(RegepsVO vo) {
	    return (RegepsVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.RegepsMngMapper.selectContents" , vo); 
	}

	// 정규표현식ID 검증
	public boolean regepsIdCheck(RegepsVO vo) {
	    RegepsVO rtnVo = (RegepsVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.RegepsMngMapper.regepsIdCheck" , vo); 
	    return Integer.parseInt( rtnVo.getRegepsIdCheck()) == 0 ? false : true; 
	}

	// 정규표현식 등록
	public int insertContents(RegepsVO vo) {
		
		int result = 0;
		
		// 정규표현식ID, 정규표현식 검증
		if(this.regepsTest(vo) && this.regepsIdCheck(vo)) {
		    result = defaultDao.insert("com.opennote.standard.mapper.basic.RegepsMngMapper.insertContents" , vo); 
		}
		
		return result;
	}

	// 정규표현식 검증
	private boolean regepsTest(RegepsVO vo) {
		Pattern pattern = Pattern.compile(vo.getRegepsTxt());
		Matcher matcher = pattern.matcher(vo.getRegepsExm());
		
		return matcher.matches();
	}
	
	// 정규표현식 본인글 여부 
	public boolean regrCheck(RegepsVO vo) { 
      RegepsVO rtnVo = (RegepsVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.RegepsMngMapper.regrCheck" , vo);
      return Integer.parseInt(rtnVo.getRegrCheck()) == 1 ? true : false; 
	}
	
	// 정규표현식 수정
	public int updateContents(RegepsVO vo) {
		
		int result = 0;
		
		// 정규표현식ID, 정규표현식 검증
		if(this.regepsTest(vo) && this.regepsIdCheck(vo)) {
		   result = defaultDao.update("com.opennote.standard.mapper.basic.RegepsMngMapper.updateContents" , vo); 
		}
		
		return result;
	}
	

	// 정규표현식 삭제
	public int deleteContents(RegepsVO vo) {
		
		int result = 0;
		
		// 정규표현식ID, 정규표현식 검증
		if(this.regepsTest(vo) && this.regepsIdCheck(vo)) {
		    result = defaultDao.update("com.opennote.standard.mapper.basic.RegepsMngMapper.deleteContents" , vo); 
		}
		
		return result;
	}

	// 정규표현식 엑셀 다운로드
	public List<RegepsVO> selectExcelList(RegepsVO vo) { 
	    return (List<RegepsVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.RegepsMngMapper.selectExcelList" , vo); 
	}
}
