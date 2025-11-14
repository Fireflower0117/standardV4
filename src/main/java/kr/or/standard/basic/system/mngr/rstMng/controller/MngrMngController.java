package kr.or.standard.basic.system.mngr.rstMng.controller;
 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.system.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.system.mngr.rstMng.service.MngrMngService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@RequiredArgsConstructor
@Controller 
public class MngrMngController {

    //private final MngrMngService maMngrMngService;
	//private final UserService maUserService;
	//private final AuthService maAuthService;
	//private final LginPlcyService maLginPlcyService;
	//private final PaginationService paginationService;
	//private final MessageSource messageSource;
	//private final ExcelView excelView;
	 
	private final String URL_PATH = "/ma/sys/mngr/mngrMng/";
	
	@RequestMapping(URL_PATH + "list.do") 
	/* /ma/sys/mngr/mngrMng/list.do */ 
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do") 
	/* /ma/sys/mngr/mngrMng/addList.do */
	public String addList(@ModelAttribute("searchVO") UserVO searchVO, Model model) throws Exception {
		
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		paginationInfo.setTotalRecordCount(maUserService.selectCount(searchVO));
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<UserVO> resultList = maUserService.selectList(searchVO);

		model.addAttribute("resultList", resultList);
		
		return URL_PATH + "addList";
	}

	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do")
	/* /ma/sys/auth/insertForm.do | /ma/sys/auth/updateForm.do */
	/* /ma/sys/mngr/mngrMng/updateForm.do */
	public String form(@ModelAttribute("searchVO") UserVO searchVO, Model model, @PathVariable String procType, HttpSession session) {
		
		UserVO userVO = new UserVO();

		if("update".equals(procType)) {

			// 일련번호 없는 경우
			if(StringUtils.isEmpty(searchVO.getUserSerno())) {
				return "redirect:list.do";
			}

			if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || maUserService.regrCheck(searchVO)) {
				userVO = maUserService.selectContents(searchVO);

				// IP 리스트
				List<UserVO> ipList = maMngrMngService.selectIpList(userVO);
				model.addAttribute("ipList", ipList);
			}else{
				return "redirect:list.do";
			}
		}

		// 회원 권한 목록
		model.addAttribute("authList", maAuthService.selectAllList());
		model.addAttribute("userVO", userVO);
		
		return ".mLayout:" + URL_PATH + "form";
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/mngrMng/proc */
	public ResponseEntity<?> insertProc(@Validated(UserVO.insertCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}

		HashMap<String, Object> returnMap = new HashMap<>();
		int resultCnt = 0;

		resultCnt = maMngrMngService.insertContents(searchVO);

		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}

		returnMap.put("returnUrl", "list.do");
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/mngrMng/proc */
	public ResponseEntity<?> updateProc(@Validated(UserVO.updateCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result, HttpSession session) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>();

		// 관리자 또는 본인글인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || maUserService.regrCheck(searchVO)) {

			int resultCnt = 0;

			resultCnt = maMngrMngService.updateContents(searchVO);

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


		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/mngrMng/proc */
	public ResponseEntity<?> deleteProc(@Validated(UserVO.deleteCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>();

		// 관리자 또는 본인글인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || maUserService.regrCheck(searchVO)) {
			int resultCnt = 0;

			resultCnt = maMngrMngService.deleteUser(searchVO);

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
		
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/sys/auth/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") UserVO searchVO, Model model) throws Exception {

		ModelAndView mav = new ModelAndView(excelView);
		String tit = "관리자목록";
		String url = "/mngrMngList.xlsx";

		List<UserVO> resultList = maUserService.selectExcelList(searchVO);

		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "unlockProc")
	/* /ma/sys/mngr/mngrMng/unlockProc */
	public HashMap<String, Object> unlockProc(@ModelAttribute("searchVO") UserVO searchVO, HttpSession session){
		
		HashMap<String, Object> returnMap = new HashMap<>();
		int result = 0;
		String message = "";

		// 관리자인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			result = maUserService.userUnLock(searchVO);
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

	@RequestMapping(URL_PATH + "addIpForm.do")
	/* /ma/sys/mngr/mngrMng/addIpFrom.do */
	public String addIpFrom(@ModelAttribute("searchVO") UserVO searchVO,@RequestParam String cnt, Model model) throws Exception {


		model.addAttribute("cnt", cnt);

		return URL_PATH + "addIpForm";
	}

	/* 그룹권한ID 중복체크 */
	@ResponseBody
	@RequestMapping(URL_PATH + "idOvlpChk")
	/* /ma/sys/mngr/mngrMng/idOvlpChk */
	public ResponseEntity<?> idOvlpChk(@Validated(UserVO.idCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result){
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}

		HashMap<String, Object> returnMap = new HashMap<>();

		returnMap.put("ovlpCnt", maUserService.idOvlpSelectCount(searchVO));
		returnMap.put("rstCnt", maMngrMngService.idRstSelectCount(searchVO));


		return ResponseEntity.ok(returnMap);
	}

}
