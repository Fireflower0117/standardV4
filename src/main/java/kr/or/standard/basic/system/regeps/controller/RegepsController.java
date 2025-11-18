package kr.or.standard.basic.system.regeps.controller;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.regeps.service.RegepsService;
import kr.or.standard.basic.system.regeps.vo.RegepsVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
 
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity; 
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 
import java.util.List;


@Controller
@RequiredArgsConstructor
public class RegepsController {
    
    private final RegepsService regepsService;
	private final String URL_PATH = "/ma/sys/regeps/"; 
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/sys/regeps/list.do */
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/sys/regeps/addList.do */
	public String addList(@ModelAttribute("searchVO") RegepsVO searchVO, Model model) throws Exception { 
		regepsService.addList(searchVO , model ); 
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "regepsPop.do")
	/* /ma/sys/regeps/regepsPop.do */
	public String regepsPop(@ModelAttribute("searchVO") RegepsVO searchVO, Model model) {
		
		// 정규표현식 전체 목록 조회
		regepsService.regepsPop(searchVO , model );  
		return URL_PATH + "regepsPop";
	}
	
	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do") 
	/* /ma/sys/regeps/insertForm.do, /ma/sys/regeps/updateForm.do */
	public String form(@ModelAttribute("searchVO") RegepsVO searchVO, Model model, @PathVariable String procType, HttpSession session) { 
		String rtnStr = regepsService.insertUpdateForm(searchVO , model, procType ,session);
		if(!"".equals(rtnStr)) return rtnStr;
		else return ".mLayout:" + URL_PATH + "form";
	}
	
	@PostMapping(URL_PATH + "regepsIdCheckProc")
	/* /ma/sys/regeps/regepsIdCheckProc */
	public ResponseEntity<?> regepsIdCheckProc(@Validated(RegepsVO.idCheck.class) RegepsVO searchVO, BindingResult result){
		
		 
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		} 
		
		CommonMap returnMap = regepsService.regepsIdCheckProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/regeps/proc */
	public ResponseEntity<?> insertProc(@Validated(RegepsVO.insertCheck.class) @ModelAttribute("searchVO") RegepsVO searchVO, BindingResult result, HttpSession session) {
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = regepsService.insertProc(searchVO, result , session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/sys/regeps/proc */
	public ResponseEntity<?> updateProc(@Validated(RegepsVO.updateCheck.class) @ModelAttribute("searchVO") RegepsVO searchVO, BindingResult result, HttpSession session){
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		 CommonMap returnMap = regepsService.updateProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/regeps/proc */
	public ResponseEntity<?> deleteProc(@Validated(RegepsVO.deleteCheck.class) @ModelAttribute("searchVO") RegepsVO searchVO, BindingResult result, HttpSession session) {
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = regepsService.deleteProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	
	/* Excel - 대용량 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "bigExcelDownload.do")
	/* /ma/sys/regeps/bigExcelDownload.do */
	public void bigExcelDownload(@ModelAttribute("searchVO") RegepsVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
        regepsService.bigExcelDownload(searchVO , request , response );
	}
	
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/sys/regeps/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") RegepsVO searchVO, Model model) { 
		return regepsService.excelDownload(searchVO , model ); 
	}

}
