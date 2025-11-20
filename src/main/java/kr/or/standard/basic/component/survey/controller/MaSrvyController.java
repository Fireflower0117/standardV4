package kr.or.standard.basic.component.survey.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.component.survey.service.SrvyService;
import kr.or.standard.basic.component.survey.vo.SrvyVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
 

@Controller
@PropertySource("classpath:component.properties")
@RequiredArgsConstructor
public class MaSrvyController {
    
	private final String MA_URL_PATH = "${cm_srvy.ma-url-path}";
	private final String CM_FOLDER_PATH = "/component/cm_srvy/ma/";
        
	private final SrvyService srvyService;
	
	/*
	 * 설문관리 list
	 */
	@RequestMapping(MA_URL_PATH + "list.do")
	/*  /ma/us/srvy/list.do */
	public String maList(@ModelAttribute("searchVO") SrvyVO searchVO){
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}
	/*
	 * 설문관리 addList
	 */
	@RequestMapping(MA_URL_PATH + "addList.do")
	/*  /ma/us/srvy/addList.do */
	public String maAddList(@ModelAttribute("searchVO") SrvyVO searchVO,Model model) throws Exception { 
		srvyService.maAddList(searchVO , model); 
		return CM_FOLDER_PATH + "addList";
	}
	
	/*
	 * 설문관리 등록/수정 Form
	 */
	@RequestMapping(MA_URL_PATH + "{procType:insert|update}Form.do")
	/*  /ma/us/srvy/insertForm.do , /ma/us/srvy/updateForm.do */  
	public String maForm(@ModelAttribute("searchVO") SrvyVO searchVO, @PathVariable String procType, Model model) { 
        srvyService.maForm(searchVO, procType, model); 
		return ".mLayout:" + CM_FOLDER_PATH + "form";
	}
	
	/*
	 * 설문섹션 추가
	 */
	@RequestMapping(MA_URL_PATH + "addSection.do")
	/*  /ma/us/srvy/addSection.do */
	public String addSection(@ModelAttribute("searchVO") SrvyVO  searchVO){
		return CM_FOLDER_PATH + "addSection";
	}
	/*
	 * 설문문항 추가
	 */
	@RequestMapping(MA_URL_PATH + "addQst.do")
	/*  /ma/us/srvy/addQst.do */
	public String addQst(@ModelAttribute("searchVO") SrvyVO  searchVO){
		return CM_FOLDER_PATH + "addQst";
	}
	
	/*
	 * 설문관리 유형선택시 selectOption 변경
	 */
	@RequestMapping(MA_URL_PATH + "selectOption.do")
	/*  /ma/us/srvy/selectOption.do */
	public String selectOption(@ModelAttribute("searchVO") SrvyVO searchVO){
		return CM_FOLDER_PATH + "selectOption";
	}
	
	/*
	 * 설문 미리보기 및 설문 참여
	 */
	@RequestMapping(MA_URL_PATH + "viewPop.do")
	/*  /ma/us/srvy/viewPop.do */
	public String maViewPop(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) {
		srvyService.maViewPop(searchVO, model); 
		return ".popLayout:" + CM_FOLDER_PATH + "viewPop";
	}
	
	/*
	 * 설문 view 항목
	 */
	@RequestMapping(MA_URL_PATH + "srvy.do")
	/*  /ma/us/srvy/srvy.do */
	public String maSrvy(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) {
		srvyService.maSrvy(searchVO, model); 
		return CM_FOLDER_PATH + "srvy";
	}
	
	/*
	 * 설문 등록
	 */
	@ResponseBody
	@PostMapping(MA_URL_PATH + "proc")
	/* /ma/us/srvy/proc */
	public ResponseEntity<?> insertProc(@Validated(SrvyVO.insertCheck.class) @ModelAttribute("searchVO") SrvyVO searchVO, BindingResult result) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = srvyService.maInsertProc(searchVO, result); 
		return ResponseEntity.ok(returnMap);
	}
	
	/*
	 * 설문 수정
	 */
	@ResponseBody
	@PatchMapping(MA_URL_PATH + "proc")
	/* /ma/us/srvy/proc */
	public ResponseEntity<?> updateProc(@Validated(SrvyVO.updateCheck.class) @ModelAttribute("searchVO") SrvyVO searchVO, BindingResult result, HttpSession session) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = srvyService.maUpdateProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	/*
	 * 설문 삭제
	 */
	@ResponseBody
	@DeleteMapping(MA_URL_PATH + "proc")
	/* /ma/us/srvy/proc */
	public ResponseEntity<?> deleteProc(@Validated(SrvyVO.deleteCheck.class) @ModelAttribute("searchVO") SrvyVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = srvyService.maDeleteProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	
	
	
	/*
	 * 결과보기 pop
	 */
	@RequestMapping(MA_URL_PATH + "resultPop.do")
	/*  /ma/us/srvy/resultPop.do */
	public String maResultPop(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) throws Exception {
		
		if(searchVO.getSrvySerno() != null && !"".equals(searchVO.getSrvySerno())) {
			srvyService.maResultPop(searchVO, model);
		} else {
			return "redirect:"+CM_FOLDER_PATH +"list.do";
		}

		return ".mLayout:" + CM_FOLDER_PATH +"resultPop";
	}
	
	/*
	 * 결과보기 상세 (단답, 파일 등)
	 */
	@RequestMapping(MA_URL_PATH + "resultPopDetail.do")
	/*  /ma/us/srvy/resultPopDetailDetail.do */
	public String maResultPopDetail(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) {
		srvyService.maResultPopDetail(searchVO, model);
		return ".popLayout:" + CM_FOLDER_PATH  + "resultPopDetail";
	}
	
	/*
	 * 결과보기 리스트 (단답, 파일 등)
	 */
	@RequestMapping(MA_URL_PATH + "resultPopDetailList.do")
	/*  /ma/us/srvy/resultPopDetailList.do */
	public String maResultPopDetailList(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) {
		return ".popLayout:" + CM_FOLDER_PATH +"resultPopDetailList";
	}
	
	@RequestMapping(MA_URL_PATH + "resultPopDetailAddList.do")
	/*  /ma/us/srvy/resultPopDetailAddList.do */
	public String maResultPopDetailAddList(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) throws Exception {

		if(searchVO.getSrvyQstSerno() != null && !"".equals(searchVO.getSrvyQstSerno())) {
			srvyService.maResultPopDetailAddList(searchVO, model);
		} else {
			return "redirect:" + CM_FOLDER_PATH  + "list.do";
		}
		return CM_FOLDER_PATH + "resultPopDetailAddList";
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(MA_URL_PATH + "excelDownload.do")
	/* /ma/us/srvy/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) throws Exception { 
		return srvyService.maExcelDownload(searchVO); 
	}
}
