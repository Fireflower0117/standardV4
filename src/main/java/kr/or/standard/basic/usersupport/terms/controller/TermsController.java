package kr.or.standard.basic.usersupport.terms.controller;

 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.usersupport.terms.service.TermsService;
import kr.or.standard.basic.usersupport.terms.vo.TermsVO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class TermsController {

    private final TermsService termsService;    
    
    
	private static final String URL_PATH = "/ma/us/mem/terms/";
	
	@RequestMapping(URL_PATH + "{menuId:termsScrb|termsScss}/form.do")
	/* /ma/us/mem/terms/termsScrb/form.do, /ma/us/mem/terms/termsScss/form.do */
	public String form(@ModelAttribute("searchVO") CmmnDefaultVO searchVO, Model model, @PathVariable String menuId) {
		
		// 약관 목록 조회
		termsService.form(model, menuId); 
		return ".mLayout:" + URL_PATH + "form";
	}
	
	@RequestMapping(URL_PATH + "{menuId:termsScrb|termsScss}/addForm.do")
	/* /ma/us/mem/terms/termsScrb/addForm.do, /ma/us/mem/terms/termsScss/addForm.do */
	public String addForm(@PathVariable String menuId) {
		return URL_PATH + "addForm";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "{menuId:termsScrb|termsScss}/proc")
	/* /ma/us/mem/terms/termsScrb/proc, /ma/us/mem/terms/termsScss/proc */
	public ResponseEntity<?> insertProc(@Validated(TermsVO.insertCheck.class) @ModelAttribute("searchVO") TermsVO searchVO, @PathVariable String menuId, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = termsService.insertProc(searchVO ,menuId , result ); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "{menuId:termsScrb|termsScss}/proc")
	/* /ma/us/mem/terms/termsScrb/proc, /ma/us/mem/terms/termsScss/proc */
	public ResponseEntity<?> updateProc(@Validated(TermsVO.updateCheck.class) @ModelAttribute("searchVO") TermsVO searchVO, @PathVariable String menuId, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = termsService.updateProc(searchVO ,menuId , result ); 
		return ResponseEntity.ok(returnMap);
	}
	    
}
