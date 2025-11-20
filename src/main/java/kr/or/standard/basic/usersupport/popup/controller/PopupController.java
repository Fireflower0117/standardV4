package kr.or.standard.basic.usersupport.popup.controller;
 
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.usersupport.popup.service.PopupService;
import kr.or.standard.basic.usersupport.popup.vo.PopupVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class PopupController {
    
    public final PopupService popupService;  
	private final String URL_PATH = "/ma/us/popup/";


	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/popup/list.do */
	public String list(@ModelAttribute("searchVO") PopupVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/popup/addList.do */
	public String addList(@ModelAttribute("searchVO") PopupVO searchVO, Model model) throws Exception {
		
		popupService.addList(searchVO , model); 
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "view.do")
	public String view(@ModelAttribute("searchVO") PopupVO searchVO, Model model) { 
        String rtnUrl = popupService.view(searchVO , model);
        if(!"".equals(rtnUrl)) { return rtnUrl; }
        else { return ".mLayout:"+ URL_PATH + "view"; }
	}
	
	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do") 
	/* /ma/us/popup/insertForm.do, /ma/us/popup/updateForm.do */
	public String form(@ModelAttribute("searchVO") PopupVO searchVO, Model model, @PathVariable String procType, HttpSession session) {
		
		String rtnUrl = popupService.insertUpdateForm(searchVO, model, procType, session);
		if(!"".equals(rtnUrl)) { return rtnUrl; } 
		else { return ".mLayout:" + URL_PATH + "form"; }
	}
	
	@RequestMapping(URL_PATH + "{target:window|modal}Sample.do")
	/* /ma/us/popup/windowSample.do, /ma/us/popup/modalSample.do */
	public String popSample(@ModelAttribute("sampleVO") PopupVO searchVO, @PathVariable String target) { 
		
		String path = URL_PATH + "popSample"; 
		/* 윈도우 팝업 창 */
		if(target.equals("window")) {
			path = ".popLayout:" + path;
		} 
		return path;
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/popup/proc */
	public ResponseEntity<?> insertProc(@Validated(PopupVO.insertCheck.class) @ModelAttribute("searchVO") PopupVO searchVO, BindingResult result) {
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = popupService.insertProc(searchVO, result); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/popup/proc */
	public ResponseEntity<?> updateProc(@Validated(PopupVO.updateCheck.class) @ModelAttribute("searchVO") PopupVO searchVO, BindingResult result, HttpSession session){
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = popupService.updateProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/us/popup/proc */
	public ResponseEntity<?> deleteProc(@Validated(PopupVO.deleteCheck.class) @ModelAttribute("searchVO") PopupVO searchVO, BindingResult result, HttpSession session) {
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = popupService.deleteProc(searchVO, result, session);  
		return ResponseEntity.ok(returnMap);
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/popup/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") PopupVO searchVO) throws Exception { 
		return popupService.excelDownload(searchVO); 
	}
    
    

}
