package kr.or.standard.basic.system.code.controller;

 
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.code.vo.CodeVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.MessageSource; 
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

import kr.or.standard.basic.system.code.service.CodeService;
import lombok.RequiredArgsConstructor; 

@Controller
@RequiredArgsConstructor
public class CodeController {
    
    private final CodeService codeService; 
	     
	private final String URL_PATH = "/ma/sys/code/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/sys/code/list.do */
	public String list(@ModelAttribute("searchVO") CodeVO searchVO) {

		if (StringUtils.isEmpty(searchVO.getCdUppoVal())) {
			searchVO.setCdUppoVal("0");
		}

		return ".mLayout:" + URL_PATH + "list";
	}

	@RequestMapping(URL_PATH + "codeList.do")
	/* /ma/sys/code/codeList.do */
	public String codeList(@ModelAttribute("searchVO") CodeVO searchVO, Model model) { 
		codeService.codeList(searchVO , model); 
		return URL_PATH + "codeList";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/code/proc */
	public ResponseEntity<?> insertProc(@Validated(CodeVO.insertCheck.class) @ModelAttribute("searchVO") CodeVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		CommonMap returnMap = codeService.insertProc(searchVO , result , session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/sys/code/proc */
	public ResponseEntity<?> updateProc(@Validated(CodeVO.updateCheck.class) @ModelAttribute("searchVO") CodeVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = codeService.updateProc(searchVO , result , session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/code/proc */
	public ResponseEntity<?> deleteProc(@Validated(CodeVO.deleteCheck.class) @ModelAttribute("searchVO") CodeVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = codeService.deleteProc(searchVO , result , session); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@RequestMapping(URL_PATH + "sort")
	/* /ma/sys/code/sort */
	public ResponseEntity<?> sort(@ModelAttribute("searchVO") CodeVO searchVO, HttpSession session){ 
		CommonMap returnMap = codeService.sort(searchVO ,session); 
		return ResponseEntity.ok(returnMap);
	}
    
    
}
