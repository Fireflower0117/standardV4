package kr.or.standard.basic.usersupport.lginPlcy.controller;


import java.util.HashMap;
import java.util.List;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.usersupport.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.usersupport.lginPlcy.vo.LginPlcyVO;
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
     
	private final LginPlcyService lginPlcyService;
	private final AuthService maAuthService;
	private final MessageSource messageSource;
    
    
	private final String URL_PATH = "/ma/us/mem/lginPlcy/";
	
	@RequestMapping(URL_PATH + "form.do") 
	/* /ma/us/mem/lginPlcy/form.do */
	public String form(Model model) { 
		lginPlcyService.form(model); 
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
		
		CommonMap returnMap = lginPlcyService.insertProc(searchVO, result); 
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
		
		CommonMap returnMap = lginPlcyService.updateProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}
    
    
}
