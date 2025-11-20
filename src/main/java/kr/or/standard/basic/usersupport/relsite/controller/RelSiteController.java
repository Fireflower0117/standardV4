package kr.or.standard.basic.usersupport.relsite.controller;


import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.usersupport.relsite.service.RelSiteService;
import kr.or.standard.basic.usersupport.relsite.vo.RelSiteVO;
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
public class RelSiteController {
 
    private final RelSiteService relSiteService;
 
	private final String URL_PATH = "/ma/us/relSite/";
	
	@RequestMapping(URL_PATH + "form.do") 
	/* /ma/us/relSite/form.do */
	public String form(Model model) {
		relSiteService.form(model); 
		return ".mLayout:" + URL_PATH + "form";
	}
	
	@RequestMapping(URL_PATH + "addSite.do") 
	/* /ma/us/relSite/addSite.do */
	public String addSite() {
		return URL_PATH + "addSite";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/relSite/proc */
	public ResponseEntity<?> insertProc(@Validated(RelSiteVO.insertCheck.class) @ModelAttribute("searchVO") RelSiteVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = relSiteService.insertProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/relSite/proc */
	public ResponseEntity<?> updateProc(@Validated(RelSiteVO.updateCheck.class) @ModelAttribute("searchVO") RelSiteVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = relSiteService.updateProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}
}
