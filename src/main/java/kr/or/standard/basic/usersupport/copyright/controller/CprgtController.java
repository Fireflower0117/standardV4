package kr.or.standard.basic.usersupport.copyright.controller;


import java.util.HashMap;
import java.util.List;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.usersupport.copyright.service.CprgtService;
import kr.or.standard.basic.usersupport.copyright.vo.CprgtVO;
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
 

@Controller
@RequiredArgsConstructor
public class CprgtController {
    
    private final CprgtService cprgtService;
    
    
	private static final String URL_PATH = "/ma/us/cprgt/";
	
	@RequestMapping(URL_PATH + "form.do") 
	/* /ma/us/cprgt/form.do */
	public String form(Model model) { 
		cprgtService.form(model); 
		return ".mLayout:" + URL_PATH + "form";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/cprgt/proc */
	public ResponseEntity<?> insertProc(@Validated(CprgtVO.insertCheck.class) @ModelAttribute("searchVO") CprgtVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = cprgtService.insertProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/cprgt/proc */
	public ResponseEntity<?> updateProc(@Validated(CprgtVO.updateCheck.class) @ModelAttribute("searchVO") CprgtVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = cprgtService.updateProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}
    
    
}
