package kr.or.standard.basic.usersupport.contTmpl.controller;

 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.code.vo.CodeVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;


import kr.or.standard.basic.usersupport.contTmpl.service.ContTmplService;
import kr.or.standard.basic.usersupport.contTmpl.vo.ContTmplVO;
import lombok.RequiredArgsConstructor; 

@Slf4j
@Controller
@RequiredArgsConstructor
public class ContTmplController {
    
    private final ContTmplService contTmplService;
    
	private final String URL_PATH = "/ma/us/contTmpl/";	
	
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/contTmpl/list.do */
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO, ModelMap model) { 
		contTmplService.list(searchVO, model ); 
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/contTmpl/addList.do */
	public String addList(@ModelAttribute("searchVO") ContTmplVO searchVO, ModelMap model) throws Exception{
		contTmplService.addList(searchVO, model );
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do") 
	/* /ma/us/contTmpl/insertForm.do /ma/us/contTmpl/updateForm.do */
	public String form(@ModelAttribute("searchVO") ContTmplVO searchVO, ModelMap model, @PathVariable String procType) {
		contTmplService.insertUpdateForm(searchVO, model , procType  ); 
		return ".mLayout:" + URL_PATH + "/form";
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/contTmpl/proc */
	public ResponseEntity<?> insertProc(@Validated(ContTmplVO.insertTmplCheck.class)@ModelAttribute("searchVO") ContTmplVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = contTmplService.insertProc(searchVO, result); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/contTmpl/proc */
	public ResponseEntity<?> updateProc(@Validated(ContTmplVO.updateTmplCheck.class) @ModelAttribute("searchVO") ContTmplVO searchVO, BindingResult result,HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = contTmplService.updateProc(searchVO, result , session);  
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/us/contTmpl/proc */
	public ResponseEntity<?> deleteProc(@Validated(ContTmplVO.deleteTmplCheck.class) @ModelAttribute("searchVO") ContTmplVO searchVO, BindingResult result,HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = contTmplService.deleteProc(searchVO, result , session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@RequestMapping(URL_PATH + "changeSel")
	/* /ma/us/contTmpl/changeSel */
	public String changeSel(ContTmplVO searchVO, ModelMap model) throws Exception { 
		contTmplService.changeSel(searchVO, model); 
		return URL_PATH + "selOption";
	}
	
	@ResponseBody
	@RequestMapping(URL_PATH + "uploadTmplFile")
	/* /ma/us/contTmpl/uploadTmplFile */
    public CommonMap uploadTmplFile(ContTmplVO contTmplVO) throws Exception{ 
		return contTmplService.uploadTmplFile(contTmplVO); 
    }
	
	@RequestMapping(URL_PATH + "tmplFileList")
	/* /ma/us/contTmpl/tmplFileList */
	public String tmplFileList(ContTmplVO searchVO, ModelMap model) { 
		contTmplService.uploadTmplFile(searchVO , model); 
		return URL_PATH  + "fileList";
	}
	
	@ResponseBody
	@RequestMapping(URL_PATH + "delTmplFile")
	/* /ma/us/contTmpl/delTmplFile */
	public ResponseEntity<?> delTmplFile(ContTmplVO searchVO, BindingResult result,HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		CommonMap returnMap = contTmplService.delTmplFile(searchVO , result , session); 
		return ResponseEntity.ok(returnMap);
    }
	
	@RequestMapping("/tmplFile/getFileDown.do")
	/* /tmplFile/getFileDown.do */
	public void getFileDown(@RequestParam String tmplFileSerno, @RequestParam String fileSeqo,HttpServletRequest request ,HttpServletResponse response) throws Exception { 
		contTmplService.getFileDown(tmplFileSerno,fileSeqo,request,response);
	}
	
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH +"excelDownload.do")
	/* /ma/us/contTmpl/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") ContTmplVO searchVO, Model model) { 
		return contTmplService.excelDownload(searchVO,model); 
	}
}
