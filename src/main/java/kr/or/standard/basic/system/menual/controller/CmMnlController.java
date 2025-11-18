package kr.or.standard.basic.system.menual.controller;


 
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.menual.service.CmMnlService;
import kr.or.standard.basic.system.menual.vo.CmMnlVO;
import lombok.RequiredArgsConstructor; 
import org.springframework.context.annotation.PropertySource;
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
import java.util.List;

@Controller
@RequiredArgsConstructor
@PropertySource("classpath:component.properties")
public class CmMnlController {
    
    
	private final String URL_PATH = "${cm_mnl.url-path}"; 
	
	private final CmMnlService cmMnlService;
	
	@RequestMapping(URL_PATH + "list.do") 
	/* /ma/sys/mnl/list.do */ 
	public String list(@ModelAttribute("searchVO") CmMnlVO searchVO) {
		return cmMnlService.list();  
	}
	
	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/sys/mnl/addList.do */
	public String addList(@ModelAttribute("searchVO") CmMnlVO searchVO, Model model) throws Exception { 
		return cmMnlService.addList(searchVO, model); 
	}
	
	@RequestMapping(URL_PATH + "view.do") 
	/* /ma/sys/mnl/view.do */
	public String view(@ModelAttribute("searchVO") CmMnlVO searchVO, Model model) { 
		return cmMnlService.view(searchVO, model); 
	}
	
	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do") 
	/* /ma/sys/mnl/insertForm.do, /ma/sys/mnl/updateForm.do */
	public String form(@ModelAttribute("searchVO") CmMnlVO searchVO, Model model, @PathVariable String procType, HttpSession session) { 
		return cmMnlService.insertUpdateForm(searchVO, model , procType , session ); 
	}
	
	@RequestMapping(URL_PATH + "addItem.do") 
	/* /ma/sys/mnl/addItem.do */
	public String addItem() {
		return cmMnlService.addItem(); 
	}
	
	@RequestMapping(URL_PATH + "addType.do") 
	/* /ma/sys/mnl/addType.do */
	public String addType(@RequestParam(name = "mnlItmClCd") String mnlItmClCd, Model model) { 
		return cmMnlService.addType(mnlItmClCd, model); 
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/mnl/proc */
	public ResponseEntity<?> insertProc(@Validated(CmMnlVO.insertCheck.class) @ModelAttribute("searchVO") CmMnlVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = cmMnlService.insertProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/sys/mnl/proc */
	public ResponseEntity<?> updateProc(@Validated(CmMnlVO.updateCheck.class) @ModelAttribute("searchVO") CmMnlVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = cmMnlService.updateProc(searchVO , result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/mnl/proc */
	public ResponseEntity<?> deleteProc(@Validated(CmMnlVO.deleteCheck.class) @ModelAttribute("searchVO") CmMnlVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = cmMnlService.deleteProc(searchVO , result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/sys/mnl/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") CmMnlVO searchVO) throws Exception { 
		return cmMnlService.excelDownload(searchVO); 
	}

}
