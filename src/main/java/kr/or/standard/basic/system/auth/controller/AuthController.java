package kr.or.standard.basic.system.auth.controller;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.auth.vo.AuthVO; 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import  kr.or.standard.basic.system.auth.service.AuthService ;
import kr.or.standard.basic.system.menu.servie.MenuService;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
 
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

import lombok.RequiredArgsConstructor; 

@Controller
@RequiredArgsConstructor
public class AuthController {
    
    private final AuthService authService; 
    private final MenuService menuService; 
    
	private static final String URL_PATH = "/ma/sys/auth/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/sys/auth/list.do */
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/sys/auth/addList.do */
	public String addList(@ModelAttribute("searchVO") AuthVO searchVO, Model model) throws Exception { 
        authService.addList(searchVO, model); 
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do")
	/* /ma/sys/auth/insertForm.do | /ma/sys/auth/updateForm.do */
	public String form(@ModelAttribute("searchVO") AuthVO searchVO, Model model, @PathVariable String procType, HttpSession session) {
		  
		String rtnUrl = authService.insertUpdagteForm(searchVO , model, procType , session);  
		
		if(!"".equals(rtnUrl)) return rtnUrl;
		else return ".mLayout:" + URL_PATH + "form";
	}
	
	/*
	 * insert = @PostMapping
	 * update = @PatchMapping
	 * delete = @DeleteMapping
	 * 나머지  = @RequestMapping
	 */
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/auth/proc */
	public ResponseEntity<?> insertProc(@Validated(AuthVO.insertCheck.class) @ModelAttribute("searchVO") AuthVO searchVO, BindingResult result,HttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = authService.insertProc(searchVO, request, menuService ); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/sys/auth/proc */
	public ResponseEntity<?> updateProc(@Validated(AuthVO.updateCheck.class) @ModelAttribute("searchVO") AuthVO searchVO, BindingResult result, HttpSession session,HttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = authService.updateProc(searchVO, session , request, menuService); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/auth/proc */
	public ResponseEntity<?> deleteProc(@Validated(AuthVO.deleteCheck.class) @ModelAttribute("searchVO") AuthVO searchVO, BindingResult result, HttpSession session,HttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = authService.deleteProc(searchVO, session , request, menuService);
		
		
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/sys/auth/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") AuthVO searchVO, Model model) throws Exception { 
		return authService.excelDownload(searchVO); 
	}



	/* 그룹권한ID 중복체크 */
	@ResponseBody
	@RequestMapping(URL_PATH + "idOvlpChk")
	/* /ma/sys/auth/idOvlpChk */
	public CommonMap idOvlpChk(@ModelAttribute("searchVO") AuthVO searchVO){ 
		return authService.idOvlpChk(searchVO); 
	}

}
