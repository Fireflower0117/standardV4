package kr.or.standard.basic.login.controller;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.login.service.LoginService;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.system.auth.vo.AuthVO;
import kr.or.standard.basic.system.log.acs.service.AcsService;
import kr.or.standard.basic.system.log.acs.vo.AcsVO;
import kr.or.standard.basic.system.menu.servie.MenuService;
import kr.or.standard.basic.system.menu.vo.MenuVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils; 
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.standard.basic.login.vo.LoginVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MaLoginController {

	private final MessageSource messageSource;
	private final LoginService loginService;
	private final AcsService maAcsService;

	private final AuthService authService;
	private final MenuService menuService;
	  
	private static final String FOLDER_PATH = "/ma/login/";
	
	@GetMapping("/") 
	public String maLoginPage() {
		return "redirect:/ma/login.do";
	}
	
	// 로그인 화면
	@GetMapping("/ma/login.do") 
	public String maGetLoginPage() {
		log.info("getMapping /ma/login.do ==>> {}login", FOLDER_PATH );

		return FOLDER_PATH + "login";
	}
	
	// 로그인 처리
	@ResponseBody
	@PostMapping("/ma/loginProcess.do")
	public ResponseEntity<?> maLoginProcess(@Validated(LoginVO.loginCheck.class) @ModelAttribute("loginVO") LoginVO loginVO, BindingResult result, HttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}

		CommonMap rtnMap = loginService.maLoginProcess(loginVO ,  request);


		
		return ResponseEntity.ok(rtnMap);
	}
	
	// 로그아웃
	@RequestMapping("/ma/logout.do")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/ma/login.do";
	}
}
 