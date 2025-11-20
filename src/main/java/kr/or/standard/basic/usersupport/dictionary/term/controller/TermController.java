package kr.or.standard.basic.usersupport.dictionary.term.controller;
 
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.vo.FileVO;
import kr.or.standard.basic.usersupport.dictionary.term.service.TermService;
import kr.or.standard.basic.usersupport.dictionary.term.vo.CmTermVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@PropertySource("classpath:component.properties")
@RequiredArgsConstructor
public class TermController {
    
    private final TermService termService;
     
	private final String URL_PATH = "${cm_term.url-path}";
	private final String CM_FOLDER_PATH = "/component/cm_std/cm_term/";

	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/std/term/list.do */
	public String list(@ModelAttribute("searchVO") CmTermVO searchVO) { 
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/std/term/addList.do */
	public String addList(@ModelAttribute("searchVO") CmTermVO searchVO, Model model) throws Exception { 
        termService.addList(searchVO, model); 
		return CM_FOLDER_PATH + "addList";
	}

	@RequestMapping(URL_PATH + "view.do")
	/* /ma/us/std/term/view.do */
	public String view(@ModelAttribute("searchVO") CmTermVO searchVO, Model model) {
        termService.view(searchVO, model); 
		return ".mLayout:" + CM_FOLDER_PATH + "view";
	}


	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do")
	/* /ma/us/std/term/insertForm.do , /ma/us/std/term/updateForm.do */
	public String form(@ModelAttribute("searchVO") CmTermVO searchVO, Model model, @PathVariable String procType, HttpSession session) {
        String rtnUrl = termService.form(searchVO, model, procType, session);
        if(!"".equals(rtnUrl)) { return rtnUrl; }
        else { return ".mLayout:" + CM_FOLDER_PATH + "form"; }
	}

	@ResponseBody
	@RequestMapping(URL_PATH + "termEngNmDuplChk")
	/* /ma/us/std/term/termEngNmDuplChk */
	public int termEngNmDuplChk(CmTermVO cmTermVO) {
        return termService.termEngNmDuplChk(cmTermVO);
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/std/term/proc */
	public ResponseEntity<?> insertProc(@Validated(CmTermVO.insertCheck.class) @ModelAttribute("searchVO") CmTermVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
        
        CommonMap returnMap = termService.insertProc(searchVO, result , session); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/std/term/proc */
	public ResponseEntity<?> updateProc(@Validated(CmTermVO.updateCheck.class) @ModelAttribute("searchVO") CmTermVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
        
        CommonMap returnMap = termService.updateProc(searchVO, result , session); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/us/std/term/proc */
	public ResponseEntity<?> deleteProc(@Validated(CmTermVO.deleteCheck.class) @ModelAttribute("searchVO") CmTermVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
        
        CommonMap returnMap = termService.deleteProc(searchVO, result , session);
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/std/term/excelDownload.do */
	public void excelDownload(@ModelAttribute("searchVO") CmTermVO searchVO, HttpServletRequest request, HttpServletResponse response) throws IOException { 
		termService.excelDownload(searchVO , request , response); 
	}


	/* Excel - 엑셀 샘플 다운로드 */
	@RequestMapping(URL_PATH + "excelSample.do")
	/* /ma/us/std/term/excelSample.do */
	public ModelAndView excelSample(@ModelAttribute("searchVO") CmTermVO searchVO) { 
		return termService.excelSample(searchVO ); 
	}

	/* Excel - 엑셀 업로드 */
	@ResponseBody
	@PostMapping(URL_PATH + "excelProc")
	/* /ma/us/std/term/excelProc */
	public ResponseEntity<?> excelUpload(FileVO fileVO, HttpSession session) { 
		return termService.excelUpload(fileVO , session ); 
	}
}
