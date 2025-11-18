package kr.or.standard.basic.user.controller;


import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.system.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.user.service.UserService;
import kr.or.standard.basic.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor 
public class UserController {
    
    private final UserService userService;
	private final AuthService authService;
	private final LginPlcyService lginPlcyService; 
	private final MessageSource messageSource;
	private final ExcelView excelView;
	
	
	private static final String URL_PATH = "/ma/us/mem/user/";
	
	@RequestMapping(URL_PATH + "list.do") 
	/* /ma/us/mem/user/list.do */ 
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do") 
	/* /ma/us/mem/user/addList.do */
	public String addList(@ModelAttribute("searchVO") UserVO searchVO, Model model) throws Exception { 
		userService.addList(searchVO , model); 
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "view.do") 
	/* /ma/us/mem/user/view.do */
	public String view(@ModelAttribute("searchVO") UserVO searchVO, Model model) {

		// 사용자 일련번호 비어있는 경우
		if(StringUtils.isEmpty(searchVO.getUserSerno())) {
			return "redirect:list.do";
		}
		
        userService.view(searchVO, model); 
		return ".mLayout:" + URL_PATH + "view";
	}
	
	@RequestMapping(URL_PATH + "updateForm.do") 
	/* /ma/us/mem/user/updateForm.do */
	public String form(@ModelAttribute("searchVO") UserVO searchVO, Model model, HttpSession session) {

		// 관리자가 아닌 경우
		if(!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			return "redirect:list.do";
		}
		
		// 사용자 일련번호 비어있는 경우
		if(StringUtils.isEmpty(searchVO.getUserSerno())) {
			return "redirect:list.do";
		}
        
        userService.updateForm(searchVO , model); 
		return ".mLayout:" + URL_PATH + "form";
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/mem/user/proc */
	public ResponseEntity<?> updateProc(@Validated(UserVO.updateCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result, HttpSession session) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap  = userService.updateProc(searchVO);
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/us/mem/user/proc */
	public ResponseEntity<?> deleteProc(@Validated(UserVO.deleteCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap  = userService.deleteProc(searchVO); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "unlockProc")
	/* /ma/us/mem/user/unlockProc */
	public CommonMap unlockProc(@ModelAttribute("searchVO") UserVO searchVO){ 
		return userService.unlockProc(searchVO); 
	}
	
	/* Excel - 대용량 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "bigExcelDownload.do")
	/* /ma/us/mem/user/bigExcelDownload.do */
	public void bigExcelDownload(@ModelAttribute("searchVO") UserVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception { 
        userService.bigExcelDownload(searchVO , request , response); 
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/mem/user/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") UserVO searchVO, Model model) throws Exception { 
		return userService.excelDownload(searchVO); 
	}

}
