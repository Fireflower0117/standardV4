package kr.or.standard.basic.login.controller;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.login.service.LoginService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RequiredArgsConstructor
@Controller
public class LoginController {

	private final LoginService loginService;
	private final String JSP_PATH = "/ma/login/";

	// 기본 로그인 페이지 이동
	@GetMapping("/")
	public String maLoginPage() {
		return "redirect:/ma/login.do";  // 운영환경에서는  ft/main으로 수정
	}
	
	// 로그인 페이지
	@RequestMapping("/ma/login.do")
	public String maGetLoginPage() {
		log.info("postMapping /login.do ==>> {} login", JSP_PATH);
		return JSP_PATH + "login";
	}
	
	// 로그인 처리
	@ResponseBody
	@PostMapping("/ma/loginProcess.do")
	public ResponseEntity<?> maLoginProcess(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		CommonMap rtnMap = loginService.loginProcess(request, response, model);
		return ResponseEntity.ok(rtnMap);
	}
	
	// 로그아웃
	@RequestMapping("/ma/logout.do")
	public String maLogout(HttpServletRequest request) {
		loginService.userLogout(request);
		return "redirect:/";
	}
}
 