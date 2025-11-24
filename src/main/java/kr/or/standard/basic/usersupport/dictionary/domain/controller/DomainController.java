package kr.or.standard.basic.usersupport.dictionary.domain.controller;


import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.usersupport.dictionary.domain.service.DomainService;
import kr.or.standard.basic.usersupport.dictionary.domain.vo.DomainVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
 

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;


@Controller
@RequiredArgsConstructor
@PropertySource("classpath:component.properties")
public class DomainController {

    private final DomainService domainService;
     
	private final String URL_PATH = "${cm_dmn.url-path}";
	private final String CM_FOLDER_PATH = "/component/cm_std/cm_dmn/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/std/dmn/list.do */
	public String list(@ModelAttribute("searchVO") DomainVO searchVO) {

		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/std/dmn/addList.do */
	public String addList(@ModelAttribute("searchVO") DomainVO searchVO, Model model) throws Exception { 
        domainService.addList(searchVO , model); 
		return CM_FOLDER_PATH + "addList";
	}

	@RequestMapping(URL_PATH + "view.do")
	/* /ma/us/std/dmn/view.do */
	public String view(@ModelAttribute("searchVO") DomainVO searchVO, Model model) {
		domainService.view(searchVO , model); 
		return ".mLayout:" + CM_FOLDER_PATH + "view";
	}


	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do")
	/* /ma/us/std/dmn/insertForm.do , /ma/us/std/dmn/updateForm.do */
	public String form(@ModelAttribute("searchVO") DomainVO searchVO, Model model, @PathVariable String procType, HttpSession session) { 
		String rtnUrl = domainService.form(searchVO , model, procType, session);
		if(!"".equals(rtnUrl)){ return rtnUrl; }  
		else { return ".mLayout:" + CM_FOLDER_PATH + "form"; }
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/std/dmn/proc */
	public ResponseEntity<?> insertProc(@Validated(DomainVO.insertCheck.class) @ModelAttribute("searchVO") DomainVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}

		CommonMap returnMap = domainService.insertProc(searchVO, result, session ); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/std/dmn/proc */
	public ResponseEntity<?> updateProc(@Validated(DomainVO.updateCheck.class) @ModelAttribute("searchVO") DomainVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = domainService.updateProc(searchVO, result,  session); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/us/std/dmn/proc */
	public ResponseEntity<?> deleteProc(@Validated(DomainVO.deleteCheck.class) @ModelAttribute("searchVO") DomainVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = domainService.deleteProc(searchVO, result,  session);  
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/std/dmn/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") DomainVO searchVO) { 
		return domainService.excelDownload(searchVO); 
	}
}
