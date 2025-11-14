package kr.or.standard.basic.system.lginPlcy.controller;


import java.util.HashMap;
import java.util.List;

import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.system.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.system.lginPlcy.vo.LginPlcyVO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequiredArgsConstructor
@Controller
public class LginPlcyController {
     
	private final LginPlcyService maLginPlcyService;
	private final AuthService maAuthService;
	private final MessageSource messageSource;
    
    
	private static final String URL_PATH = "/ma/us/mem/lginPlcy/";
	
	@RequestMapping(URL_PATH + "form.do") 
	/* /ma/us/mem/lginPlcy/form.do */
	public String form(Model model) {
		
		LginPlcyVO lginPlcyVO = new LginPlcyVO();
		
		// 로그인정책 있는경우 조회
		if(maLginPlcyService.selectCount() > 0) {
			lginPlcyVO = maLginPlcyService.selectOne();
		}
		model.addAttribute("lginPlcyVO", lginPlcyVO);
		
		// 회원 권한 목록
		model.addAttribute("authList", maAuthService.selectAllList());
		// 정규표현식 목록
		model.addAttribute("regepsList", maLginPlcyService.selectRegepsList());
		
		return ".mLayout:" + URL_PATH + "form";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/mem/lginPlcy/proc */
	public ResponseEntity<?> insertProc(@Validated(LginPlcyVO.insertCheck.class) @ModelAttribute("searchVO") LginPlcyVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>();
		int resultCnt = 0;
		
		if(maLginPlcyService.selectCount() > 0) {
			returnMap.put("message", "등록된 로그인정책이 존재합니다. \n관리자에게 문의하세요.");
		}else {
			
			resultCnt = maLginPlcyService.insertContents(searchVO);
			
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("insert.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
			}
		}
		
		returnMap.put("returnUrl", "form.do");
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/mem/lginPlcy/proc */
	public ResponseEntity<?> updateProc(@Validated(LginPlcyVO.updateCheck.class) @ModelAttribute("searchVO") LginPlcyVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>();
		int resultCnt = 0;
		
		resultCnt = maLginPlcyService.updateContents(searchVO);
		
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "form.do");
		return ResponseEntity.ok(returnMap);
	}
    
    
}
