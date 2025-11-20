package kr.or.standard.basic.component.survey.controller;
 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.component.survey.service.SrvyService;
import kr.or.standard.basic.component.survey.vo.SrvyVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
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
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;


@Controller
@PropertySource("classpath:component.properties")
@RequiredArgsConstructor
public class FtSrvyController {

    
	private static final String FT_URL_PATH = "${cm_srvy.ft-url-path}";
	private static final String CM_FOLDER_PATH = "/component/cm_srvy/ft/";

    private final SrvyService srvyService;
     
	/*
	 * 설문관리 list
	 */
	@RequestMapping(FT_URL_PATH + "list.do")
	/*  /ft/community/survey/list.do */
	public String ftList(@ModelAttribute("searchVO") SrvyVO searchVO){
		return ".fLayout:" + CM_FOLDER_PATH + "list";
	}
	
	/*
	 * 설문관리 addList
	 */
	@RequestMapping(FT_URL_PATH + "addList.do")
	/*  /ft/community/survey/addList.do */
	public String ftAddList(@ModelAttribute("searchVO") SrvyVO searchVO,Model model) throws Exception { 
		srvyService.ftAddList(searchVO, model); 
		return CM_FOLDER_PATH + "addList";
	}
	
	/*
	 * 설문 참여
	 */
	@RequestMapping(FT_URL_PATH + "viewPop.do")
	/*  /ft/community/survey/viewPop.do */
	public String ftViewPop(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) { 
		String rtnUrl = srvyService.ftViewPop(searchVO, model);
		if(!"".equals(rtnUrl)){ return rtnUrl; } 
		else { return ".popLayout:" + CM_FOLDER_PATH + "viewPop"; }
	}
	
	/*
	 * 설문 view 항목
	 */
	@RequestMapping(FT_URL_PATH + "srvy.do")
	/*  /ft/community/survey/srvy */
	public String ftSrvy(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) {
	    srvyService.ftSrvy(searchVO, model); 
		return CM_FOLDER_PATH + "srvy";
	}
	
	/*
	 * 설문 답변 등록
	 */
	@ResponseBody
	@PostMapping(FT_URL_PATH + "ansProc")
	/* /ft/community/survey/ansProc */
	public ResponseEntity<?> ansProc(@ModelAttribute("searchVO") SrvyVO searchVO, BindingResult result) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = srvyService.ftAnsProc(searchVO ); 
		return ResponseEntity.ok(returnMap);
	}
	
	/*
	 * 결과보기 pop
	 */
	@RequestMapping(FT_URL_PATH + "resultPop.do")
	/*  /ft/community/survey/resultPop.do */
	public String ftResultPop(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) throws Exception {
		
		if(!StringUtils.isEmpty(searchVO.getSrvySerno())) { 
			srvyService.ftResultPop(searchVO, model); 
		} else {
			return "redirect:"+CM_FOLDER_PATH +"list.do";
		}

		return ".fLayout:" + CM_FOLDER_PATH +"resultPop";
	}
	
	/*
	 * 결과보기 리스트 (단답, 파일 등)
	 */
	@RequestMapping(FT_URL_PATH + "resultPopDetailList.do")
	/*  /ft/community/survey/resultPopDetailList.do */
	public String ftResultPopDetailList(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) {
		return ".popLayout:" + CM_FOLDER_PATH +"resultPopDetailList";
	}
	

	@RequestMapping(FT_URL_PATH + "resultPopDetailAddList.do")
	/*  /ft/community/survey/resultPopDetailAddList.do */
	public String ftResultPopDetailAddList(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) throws Exception {

		if(!StringUtils.isEmpty(searchVO.getSrvyQstSerno())) { 
			srvyService.ftResultPopDetailAddList(searchVO, model); 
		} else {
			return "redirect:" + CM_FOLDER_PATH  + "list.do";
		}
		return CM_FOLDER_PATH + "resultPopDetailAddList";
	}
	
	/*
	 * 결과보기 상세 (단답, 파일 등)
	 */
	@RequestMapping(FT_URL_PATH + "resultPopDetail.do")
	/*  /ft/community/survey/resultPopDetailDetail.do */
	public String ftResultPopDetail(@ModelAttribute("searchVO") SrvyVO searchVO, Model model) { 
		srvyService.ftResultPopDetail(searchVO, model); 
		return ".popLayout:" + CM_FOLDER_PATH  + "resultPopDetail";
	}

}
