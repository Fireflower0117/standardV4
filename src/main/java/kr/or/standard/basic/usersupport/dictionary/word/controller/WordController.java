package kr.or.standard.basic.usersupport.dictionary.word.controller;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.usersupport.dictionary.word.service.WordService;
import kr.or.standard.basic.usersupport.dictionary.word.vo.WordVO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
public class WordController {
    
    private final WordService wordService;
    
	private final String URL_PATH = "${cm_wrd.url-path}";
	private final String CM_FOLDER_PATH = "/component/cm_std/cm_wrd/";
	
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/std/wrd/list.do */
	public String list(@ModelAttribute("searchVO") WordVO searchVO) { 
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/std/wrd/addList.do */
	public String addList(@ModelAttribute("searchVO") WordVO searchVO, Model model) throws Exception { 
        wordService.addList(searchVO, model); 
		return CM_FOLDER_PATH + "addList";
	}

	@RequestMapping(URL_PATH + "view.do")
	/* /ma/us/std/wrd/view.do */
	public String view(@ModelAttribute("searchVO") WordVO searchVO, Model model) { 
        wordService.view(searchVO, model); 
		return ".mLayout:" + CM_FOLDER_PATH + "view";
	}


	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do")
	/* /ma/us/std/wrd/insertForm.do , /ma/us/std/wrd/updateForm.do */
	public String form(@ModelAttribute("searchVO") WordVO searchVO, Model model, @PathVariable String procType, HttpSession session) { 
        String rtnUrl = wordService.form(searchVO, model, procType , session);
        if(!"".equals(rtnUrl)) {return rtnUrl;}  
		else { return ".mLayout:" + CM_FOLDER_PATH + "form"; }
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/std/wrd/proc */
	public ResponseEntity<?> insertProc(@Validated(WordVO.insertCheck.class) @ModelAttribute("searchVO") WordVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap =  wordService.insertProc(searchVO, result , session ); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/us/std/wrd/proc */
	public ResponseEntity<?> updateProc(@Validated(WordVO.updateCheck.class) @ModelAttribute("searchVO") WordVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
    
        CommonMap returnMap =  wordService.updateProc(searchVO, result , session ); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/us/std/wrd/proc */
	public ResponseEntity<?> deleteProc(@Validated(WordVO.deleteCheck.class) @ModelAttribute("searchVO") WordVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
        
        CommonMap returnMap =  wordService.deleteProc(searchVO, result , session ); 
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/std/wrd/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") WordVO searchVO) { 
		return wordService.excelDownload(searchVO); 
	} 

}
