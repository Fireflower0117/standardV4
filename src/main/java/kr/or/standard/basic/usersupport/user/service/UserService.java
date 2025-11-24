package kr.or.standard.basic.usersupport.user.service;


import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.module.EncryptUtil;
import kr.or.standard.basic.statistics.acsstat.vo.AcsStatVO;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.usersupport.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.usersupport.lginPlcy.vo.LginPlcyVO;

import kr.or.standard.basic.usersupport.terms.vo.TermsVO;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellUtil;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService extends EgovAbstractServiceImpl   {
    
	//private final UserMngMapper userMngMapper;
	//private final EncryptUtil encryptUtil;
	
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final PaginationService paginationService;
	private final AuthService authService;
	private final LginPlcyService lginPlcyService; 
	private final MessageSource messageSource;
	private final ExcelView excelView;
	
	private final String sqlNs = "com.standard.mapper.basic.UserMngMapper." ;
	
	
	
	// 사용자 건수 조회
	public int selectCount(UserVO vo) { 
		UserVO rtnVo = (UserVO)defaultDao.selectOne(sqlNs+"selectUserCount" ,vo);
		return Integer.parseInt(rtnVo.getUserCount());  
	}
	
	// 사용자 목록 조회
	public List<UserVO> selectList(UserVO vo) {
	    return (List<UserVO>)defaultDao.selectList(sqlNs+"selectUsertList" , vo); 
	}
	
	public void addList(UserVO userVo, Model model) throws Exception{
		
		// 사용자 건수 조회
		PaginationInfo paginationInfo = paginationService.procPagination(userVo); 
		int totalRecordCount = selectCount(userVo);  
		paginationInfo.setTotalRecordCount(totalRecordCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 사용자 목록 조회
		List<UserVO> resultList = selectList(userVo); 
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalRecordCount", paginationInfo.getTotalRecordCount());
	}
	
	// 사용자 상세 조회
	public void view(UserVO vo, Model model){ 
		UserVO userVO = (UserVO)defaultDao.selectOne(sqlNs+"selectContents", vo);
		model.addAttribute("userVO", userVO); 
	} 
	
	// 사용자 수정 페이지 기본정보 
	public void updateForm(UserVO vo, Model model){
	
		UserVO userVO = (UserVO) defaultDao.selectOne(sqlNs+"selectContents", vo);
		model.addAttribute("userVO", userVO);
		
		// 회원 권한 목록
		model.addAttribute("authList", authService.selectAllList());
		
		// 회원가입 정규식
    	model.addAttribute("lginPlcyVO", lginPlcyService.selectOne());
	}
	
	// 사용자 정보 수정
	public CommonMap updateProc(UserVO vo) throws Exception {
		
		CommonMap returnMap = new CommonMap(); 
		
		// 전화번호 암호화
		vo.setUserTelNo(EncryptUtil.getEncryptAES256(vo.getUserTelNo()));
		
		// 비밀번호 암호화
		if(!StringUtils.isEmpty(vo.getUserPswd())) {
			vo.setUserPswd(EncryptUtil.getEncryptBCrypt(vo.getUserPswd()));
		}
		
		int updateRowCount =  defaultDao.update(sqlNs+"updateContents" ,vo); 
		 
		if(updateRowCount > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "updateForm.do");
		
		return returnMap;
	}
	
	// 사용자 정보 삭제 
	public CommonMap deleteProc(UserVO vo){
		
		CommonMap returnMap = new CommonMap(); 
		int resultCnt = deleteUserContents(vo);
		
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} else {
			returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			returnMap.put("returnUrl", "updateForm.do");
		}
		
		return returnMap; 
	}
	
	
	public CommonMap unlockProc(UserVO searchVO){
		CommonMap returnMap = new CommonMap();
		  
		int result =  defaultDao.update(sqlNs+"userUnLock" ,searchVO);
		String message = searchVO.getSchEtc11().length + "건에 대하여 잠금을 해제하였습니다.";
		
		if(result == 0) {
			message = messageSource.getMessage("error.message", null, null);
		}
		
		returnMap.put("result", result);
		returnMap.put("message", message);
		
		return returnMap;
	}
	
	public void bigExcelDownload(UserVO searchVO, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		
		
		int ROW_ACCESS_WINDOW_SIZE = 1000;
		String filePath= request.getSession().getServletContext().getRealPath("/excel/standard/usersupport/userList_big.xlsx");
		 
		FileInputStream fis = new FileInputStream(filePath);
		
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fis);
		SXSSFWorkbook sxssfWorkbook = new SXSSFWorkbook(xssfWorkbook, ROW_ACCESS_WINDOW_SIZE);
		// sxssfWorkbook.setCompressTempFiles (true); // 임시 파일이 압축

	 
		SXSSFRow objRow = null;		// 행
		SXSSFCell objCell = null;   // 셀 
		
		// 현재 sheet 반환 (첫번째시트 : 0)
		SXSSFSheet objSheet = sxssfWorkbook.getSheetAt(0); // 시트 
		// 행 번호
		int rowNum = 1;
		try {
			
			// 엑셀 목록 조회
			List<UserVO> excelList = selectExcelList(searchVO);
			
			for(UserVO excelVO : excelList) {
				// 행 생성
				objRow = objSheet.createRow(rowNum);
				objRow.setHeight((short) 0x150);
				
				// 열 생성
				// 아이디
				objCell = objRow.createCell(0);
				objCell.setCellValue(excelVO.getUserId());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 이름
				objCell = objRow.createCell(1);
				objCell.setCellValue(excelVO.getUserNm());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 권한
				objCell = objRow.createCell(2);
				objCell.setCellValue(excelVO.getGrpAuthNm());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 권한영역코드
				objCell = objRow.createCell(3);
				objCell.setCellValue(excelVO.getAuthAreaCd());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 전화번호
				objCell = objRow.createCell(4);
				objCell.setCellValue(excelVO.getUserTelNo());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 이메일
				objCell = objRow.createCell(5);
				objCell.setCellValue(excelVO.getUserEmailAddr());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 우편번호
				objCell = objRow.createCell(6);
				objCell.setCellValue(excelVO.getPostNo());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 주소
				objCell = objRow.createCell(7);
				objCell.setCellValue(excelVO.getHomeAddr() + " " + excelVO.getHomeAddrDtls());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 비밀번호 불일치 건수
				objCell = objRow.createCell(8);
				objCell.setCellValue(excelVO.getPswdMsmtNocs());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 잠금여부
				objCell = objRow.createCell(9);
				objCell.setCellValue(excelVO.getLockYn());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 최종접속일시
				objCell = objRow.createCell(10);
				objCell.setCellValue(excelVO.getLstAcsDt());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 비밀번호변경일시
				objCell = objRow.createCell(11);
				objCell.setCellValue(excelVO.getLstPswdChgDt());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// SNS 구분
				objCell = objRow.createCell(12);
				objCell.setCellValue(excelVO.getSnsSeCd());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// SNS ID
				objCell = objRow.createCell(13);
				objCell.setCellValue(excelVO.getSnsUserId());
				CellUtil.setAlignment(objCell, HorizontalAlignment.LEFT);
				
				// 소속명
				objCell = objRow.createCell(14);
				objCell.setCellValue(excelVO.getBlonNm());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 팩스번호
				objCell = objRow.createCell(15);
				objCell.setCellValue(excelVO.getFaxNo());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 내선번호
				objCell = objRow.createCell(16);
				objCell.setCellValue(excelVO.getInlnNo());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 차단여부
				objCell = objRow.createCell(17);
				objCell.setCellValue(excelVO.getBrkYn());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				// 사용여부
				objCell = objRow.createCell(18);
				objCell.setCellValue(excelVO.getUseYn());
				CellUtil.setAlignment(objCell, HorizontalAlignment.CENTER);
				
				++rowNum;
			}
			
			// 파일 이름 생성
			Date time = new Date();
			SimpleDateFormat dateformat = new SimpleDateFormat ("yyyyMMdd");
			String nowDate = dateformat.format(time);
			String filename="사용자목록_"+nowDate;
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
			
			// 외부자원 해제
			try {sxssfWorkbook.close(); } catch (Exception e) {e.printStackTrace();}
			try {xssfWorkbook.close(); } catch (Exception e) {e.printStackTrace();} 
		} 
	}
	
	public ModelAndView excelDownload(UserVO searchVO)  throws Exception {
		
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "사용자목록";
		String url = "/excel/standard/usersupport/userList.xlsx";
		
		List<UserVO> resultList = selectExcelList(searchVO);
		
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
	}

	 
	public UserVO selectContents(UserVO vo) { 
		return (UserVO) defaultDao.selectOne(sqlNs+"selectContents", vo); 
	}

    // (작성자 == 로그인사용자) 판단 
	public boolean regrCheck(UserVO vo) {
		 UserVO rtnVo = (UserVO)defaultDao.selectOne(sqlNs+"regrCheck" , vo);
		 if(rtnVo == null) return false;
		 else { return Integer.parseInt(rtnVo.getIsRegrCheck()) == 0 ? false : true; } 
	}

	// 사용자 정보 수정
	/*public int updateContents(UserVO vo) throws Exception {
		// 전화번호 암호화
		vo.setUserTelNo(EncryptUtil.getEncryptAES256(vo.getUserTelNo()));
		
		// 비밀번호 암호화
		if(!StringUtils.isEmpty(vo.getUserPswd())) {
			vo.setUserPswd(EncryptUtil.getEncryptBCrypt(vo.getUserPswd()));
		}
		return defaultDao.update("com.opennote.standard.mapper.basic.UserMngMapper.updateContents" ,vo); 
	}*/
	
	// 사용자 사용여부 삭제
	/*public int deleteContents(UserVO vo) {
		return defaultDao.update("com.opennote.standard.mapper.basic.UserMngMapper.deleteContents" ,vo); 
	}*/
	
	// 사용자 잠금 해제
	public int userUnLock(UserVO vo) {
		return defaultDao.update(sqlNs+"userUnLock" ,vo); 
	}

	// 사용자 데이터 삭제
	public int deleteUserContents(UserVO vo) {
		
		int result = 0;
		
		// 로그인 정책 가져오기
		LginPlcyVO lginPlcyVO = (LginPlcyVO) Objects.requireNonNull(RequestContextHolder.getRequestAttributes()).getAttribute("lginPlcy_info", 1);
		
		// 탈퇴계정 정보보유 사용
		if(!StringUtils.isEmpty(lginPlcyVO.getScssAccPssnPrdCd())) {
			
			// 탈퇴 유저 테이블로 이동  
			result = defaultDao.insert(sqlNs+"moveUserContents", vo);
			
			// 회원정보 delete
			if(result > 0) {
				defaultDao.delete(sqlNs+"deleteUserContents", vo);
						
				if(!CollectionUtils.isEmpty(vo.getTermsList())) {
					// 사용자별 약관 저장
					for(TermsVO.Terms termsVO : vo.getTermsList()) {
						if("Y".equals(termsVO.getTermsAgreeYn())) {
							termsVO.setUserSerno(vo.getUserSerno());
							defaultDao.insert(sqlNs+"mergeUserTermsContents" , termsVO); 
						}
					}
				}
			}
		} else {
			// 회원정보 delete
			defaultDao.delete(sqlNs+"deleteUserContents" , vo); 
		}
		
		return result;
	}
	
	// ID 중복체크
	public int idOvlpSelectCount(UserVO vo) {
		UserVO rtnVo = (UserVO) defaultDao.selectOne(sqlNs+"idOvlpSelectCount" , vo); 
		return Integer.parseInt( rtnVo.getUserCount()); 
	}

	public List<UserVO> selectExcelList(UserVO vo) throws Exception {
		
		List<UserVO> userList = new ArrayList<>();
		
		// 핸드폰번호 복호화
		List<UserVO> rtnList = (List<UserVO>)defaultDao.selectList(sqlNs+"selectExcelList", vo);
		for(UserVO userVO : rtnList) {
			userVO.setUserTelNo(EncryptUtil.getDecryptAES256HyPhen(userVO.getUserTelNo()));
			userList.add(userVO);
		}
		
		return userList;
	}

	// 월별 가입추이(현재년도)
	public List<CommonMap> selectScrbUserMon() {
		return basicDao.selectList(sqlNs+"selectScrbUserMon"); 
	}

	// 일별 가입추이
	public List<CommonMap> selectScrbUserDay(AcsStatVO vo) {
		return basicDao.selectList(sqlNs+"selectScrbUserDay", vo); 
	}

	// 가입회원 목록
	public List<UserVO> selectScrbUserList(AcsStatVO vo) {
		return (List<UserVO>)defaultDao.selectList(sqlNs+"selectScrbUserList", vo); 
	}


	// 가입회원 건수
	public int selectScrbUserCount(AcsStatVO vo) { 
		AcsStatVO rtnVo = (AcsStatVO)defaultDao.selectOne(sqlNs+"selectScrbUserCount", vo);
		return Integer.parseInt(rtnVo.getUserCount());  
	};

	public List<UserVO> selectHwpList(UserVO vo) {
		return (List<UserVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.UserMngMapper.selectHwpList" , vo); 
	} 
	
}
