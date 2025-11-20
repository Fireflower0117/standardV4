package kr.or.standard.basic.system.mngr.mngrMng.service;

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.module.EncryptUtil;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.usersupport.user.service.UserService;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class MngrMngService extends EgovAbstractServiceImpl  {
	  
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final PaginationService paginationService;
	private final UserService userService;
	private final AuthService authService;
	private final MessageSource messageSource;
	private final ExcelView excelView;
	
	
	public void addList(UserVO searchVO, Model model) throws Exception { 
	
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		paginationInfo.setTotalRecordCount(userService.selectUserCount(searchVO));
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<UserVO> resultList = userService.selectUserList(searchVO); 
		model.addAttribute("resultList", resultList);
	}
	
	public String insertUpdateForm(UserVO searchVO, Model model, String procType, HttpSession session){
		
		
		UserVO userVO = new UserVO();

		if("update".equals(procType)) {

			// 일련번호 없는 경우
			if(StringUtils.isEmpty(searchVO.getUserSerno())) {
				return "redirect:list.do";
			}

			if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || userService.regrCheck(searchVO)) {
				userVO = userService.selectContents(searchVO);

				// IP 리스트
				List<UserVO> rtnVoListr = (List<UserVO>)defaultDao.selectList( "com.opennote.standard.mapper.basic.UserIpMngMapper.selectList" , searchVO); 
				model.addAttribute("ipList", rtnVoListr);
			}else{
				return "redirect:list.do";
			}
		}

		// 회원 권한 목록  
		model.addAttribute("authList", authService.selectAllList());
		model.addAttribute("userVO", userVO); 
		return "";
	}
	
	public CommonMap proc(UserVO searchVO, BindingResult result) throws Exception {
		
		CommonMap returnMap = new CommonMap();
		int resultCnt = 0;

		resultCnt = insertContents(searchVO);

		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}

		returnMap.put("returnUrl", "list.do");
		return returnMap;
	}
	
	public CommonMap updateProc(UserVO searchVO, BindingResult result, HttpSession session) throws Exception {
		
		 CommonMap returnMap = new CommonMap();

		// 관리자 또는 본인글인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || userService.regrCheck(searchVO)) {
  
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
	
	public CommonMap deleteProc(UserVO searchVO, BindingResult result, HttpSession session){
		
		
		CommonMap returnMap = new CommonMap();

		// 관리자 또는 본인글인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || userService.regrCheck(searchVO)) {
			int resultCnt = 0;

			resultCnt = deleteUser(searchVO);

			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			}

			returnMap.put("returnUrl", "list.do");

		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		}
		
		return returnMap;
		
	}
	
	public ModelAndView excelDownload(UserVO searchVO, Model model){
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "관리자목록";
		String url = "/excel/standard/mngrMngList.xlsx";
		
		List<UserVO> resultList =  (List<UserVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.UserMngMapper.selectExcelList" , searchVO); 

		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
	}
	
	public CommonMap unlockProc(UserVO searchVO, HttpSession session){
		
		CommonMap returnMap = new CommonMap();
		int result = 0;
		String message = "";

		// 관리자인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			result = userService.userUnLock(searchVO);
			message = searchVO.getSchEtc11().length + "건에 대하여 잠금을 해제하였습니다.";

			if(result == 0) {
				message = messageSource.getMessage("error.message", null, null);
			}
		}else{
			message = messageSource.getMessage("acs.error.message", null, null);
		}

		returnMap.put("result", result);
		returnMap.put("message", message);
		
		return returnMap;
	}
	
	public CommonMap idOvlpChk(UserVO searchVO, BindingResult result){
		 
		CommonMap returnMap = new CommonMap(); 
		returnMap.put("ovlpCnt", userService.idOvlpSelectCount(searchVO));
		
		UserVO rtnVo = (UserVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.UserIdRstMngMapper.idRstSelectCount" ,searchVO ); 
		int userCnt = Integer.parseInt(rtnVo.getUserCount());
		returnMap.put("rstCnt",  userCnt);
		
		return returnMap; 
	}
	  

	public int insertContents(UserVO vo) throws Exception {
		// 전화번호 암호화
		vo.setUserTelNo(EncryptUtil.getEncryptAES256(vo.getUserTelNo()));

		// 비밀번호 암호화
		if(!StringUtils.isEmpty(vo.getUserPswd())) {
			vo.setUserPswd(EncryptUtil.getEncryptBCrypt(vo.getUserPswd()));
		} 
		int effCnt = defaultDao.insert("com.opennote.standard.mapper.basic.UserMngMapper.insertContents", vo);

		// IP 삭제 
		defaultDao.delete("com.opennote.standard.mapper.basic.UserIpMngMapper.deleteIpContents", vo); 

		List<UserVO> ipList = vo.getIpList();

		if (ipList != ipList && ipList.size() > 0) {
			for (UserVO ipVO : ipList) {
				ipVO.setUserSerno(vo.getUserSerno()); 
				defaultDao.insert("com.opennote.standard.mapper.basic.UserIpMngMapper.insertIpContents", vo); 
			}
		}

		return effCnt;
	}

	// 수정
	public int updateContents(UserVO vo) throws Exception {
		// 전화번호 암호화
		vo.setUserTelNo(EncryptUtil.getEncryptAES256(vo.getUserTelNo()));

		// 비밀번호 암호화
		if(!StringUtils.isEmpty(vo.getUserPswd())) {
			vo.setUserPswd(EncryptUtil.getEncryptBCrypt(vo.getUserPswd()));
		}

		// 생성
		int cnt = defaultDao.update("com.opennote.standard.mapper.basic.UserMngMapper.updateContents", vo); 

		// IP 삭제
		defaultDao.delete("com.opennote.standard.mapper.basic.UserIpMngMapper.deleteIpContents" , vo);
		  
		List<UserVO> ipList = vo.getIpList(); 
		if (ipList != null && ipList.size() > 0) {
			for (UserVO ipVO : ipList) {
				ipVO.setUserSerno(vo.getUserSerno());
				
				defaultDao.delete("com.opennote.standard.mapper.basic.UserIpMngMapper.insertIpContents" , vo); 
			}
		}

		return cnt;
	}

	/*public int idRstSelectCount(UserVO vo){ 
		return userIdRstMngMapper.idRstSelectCount(vo);
	}*/

	public int deleteUser(UserVO vo){
		// 탈퇴 테이블로 이동
		int result = defaultDao.insert("com.opennote.standard.mapper.basic.UserScssMngMapper.insertContents", vo);

		// 사용자 테이블에서 삭제
		defaultDao.delete("com.opennote.standard.mapper.basic.UserMngMapper.deleteUserContents" , vo);
		
		return result;
	}

	// 월별 탈퇴추이(현재년도)
	public List<CommonMap> selectScssUserMon() { 
		return basicDao.selectList("com.opennote.standard.mapper.basic.UserScssMngMapper.selectScssUserMon");
		
	}

	// 일별 탈퇴추이
	/*public List<CommonMap> selectScssUserDay(AcsStatVO vo) {
		return basicDao.selectList("com.opennote.standard.mapper.basic.UserScssMngMapper.selectScssUserDay", vo); 
	}*/

	// 탈퇴회원 목록
	/*public List<UserVO> selectScssUserList(AcsStatVO vo) {
		return (List<UserVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.UserScssMngMapper.selectScssUserList", vo); 
	}*/

	// 탈퇴회원 건수
	/*public int selectScssUserCount(AcsStatVO vo) {
		AcsStatVO rtnVo = (AcsStatVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.UserScssMngMapper.selectScssUserCount" , vo);
		return Integer.parseInt( rtnVo.getUserCount() ); 
	};*/

}
