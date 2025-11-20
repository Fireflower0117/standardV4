package kr.or.standard.basic.component.schedule.controller;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.component.schedule.service.ScheduleService;
import kr.or.standard.basic.component.schedule.vo.CmSchdVO;
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
public class ScheduleController {

    
	private final String URL_PATH = "${cm_schd.url-path}";
	private final String CM_FOLDER_PATH = "/component/cm_schd/";
	
	private final ScheduleService scheduleService;
	
	
	@RequestMapping(URL_PATH + "list.do") 
	/* /ma/us/schd/list.do */
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO, Model model) { 
		scheduleService.list(searchVO); 
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addCalList.do") 
	/* /ma/us/schd/addCalList.do */
	public String addCalList(@ModelAttribute("searchVO") CmSchdVO searchVO, Model model ) {
		scheduleService.addCalList(searchVO, model); 
		return CM_FOLDER_PATH + "addCalList";
	}
	
	@RequestMapping(URL_PATH + "addDayList.do") 
	/* /ma/us/schd/addDayList.do */
	public String addDayList(@ModelAttribute("searchVO") CmSchdVO searchVO, Model model ) { 
	    scheduleService.addDayList(searchVO, model); 
		return CM_FOLDER_PATH + "addDayList";
	}
	
	@RequestMapping(URL_PATH + "addList.do") 
	/* /ma/us/schd/addList.do */
	public String addList(@ModelAttribute("searchVO") CmSchdVO searchVO, Model model ) throws Exception { 
		scheduleService.addList(searchVO, model);  
		return CM_FOLDER_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "{procType:insert|update}PopForm.do")
	/* /ma/us/schd/insertPopForm.do, /ma/us/schd/updatePopForm.do */
	public String popForm(@ModelAttribute("searchVO") CmSchdVO searchVO, @PathVariable String procType, Model model, HttpSession session) { 
		String rtnUrl = scheduleService.popForm(searchVO, procType, model, session );
		if(!"".equals(rtnUrl)) return  rtnUrl;
		else return CM_FOLDER_PATH + "form";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/schd/proc */
	public ResponseEntity<?> insertProc(@Validated(CmSchdVO.insertCheck.class) @ModelAttribute("searchVO") CmSchdVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap =scheduleService.insertProc(searchVO , result ); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/schd/proc */
	public ResponseEntity<?> updateProc(@Validated(CmSchdVO.updateCheck.class) @ModelAttribute("searchVO") CmSchdVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap =scheduleService.updateProc(searchVO , result , session ); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/us/schd/proc */
	public ResponseEntity<?> deleteProc(@Validated(CmSchdVO.deleteCheck.class) @ModelAttribute("searchVO") CmSchdVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = scheduleService.deleteProc(searchVO , result , session ); 
		return ResponseEntity.ok(returnMap);
	}
	
	@PostMapping(URL_PATH + "hdayInsertProc")
	/* /ma/us/schd/hdayInsertProc */
	public ResponseEntity<?> hdayInsertProc(@RequestParam(name = "selYear", required = true) String selYear, HttpSession session) throws Exception {
        
        CommonMap returnMap = scheduleService.hdayInsertProc(selYear , session); 
		return ResponseEntity.ok(returnMap);
	}
	
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/schd/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") CmSchdVO searchVO, Model model) throws Exception { 
		return scheduleService.excelDownload(searchVO); 
	}
	
}
