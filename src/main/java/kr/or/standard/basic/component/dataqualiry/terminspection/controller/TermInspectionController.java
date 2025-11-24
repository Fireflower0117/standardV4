package kr.or.standard.basic.component.dataqualiry.terminspection.controller;

 
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.component.dataqualiry.dbdata.vo.DBdataVO;
import kr.or.standard.basic.component.dataqualiry.terminspection.service.TermInspectionService;
import kr.or.standard.basic.usersupport.dictionary.term.vo.CmTermVO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@PropertySource("classpath:component.properties")
public class TermInspectionController {
    
    private final TermInspectionService termInspectionService;
    
    
	private static final String URL_PATH = "${cm_termDgns.url-path}";
	private static final String CM_FOLDER_PATH = "/component/cm_dbQlt/cm_termDgns/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/dbQlt/termDgns/list.do */
	public String list(@ModelAttribute("searchVO") DBdataVO searchVO) { 
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/dbQlt/termDgns/addList.do */
	public String addList(@ModelAttribute("searchVO") DBdataVO searchVO, Model model) throws Exception { 
        termInspectionService.addList(searchVO, model); 
		return CM_FOLDER_PATH + "addList";
	}

	@RequestMapping(URL_PATH + "view.do")
	/* /ma/us/dbQlt/termDgns/view.do */
	public String view(@ModelAttribute("searchVO") DBdataVO searchVO, Model model) { 
        termInspectionService.view(searchVO, model); 
		return ".mLayout:" + CM_FOLDER_PATH + "view";
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/us/dbQlt/termDgns/proc */
	public ResponseEntity<?> insertProc(@Validated(CmTermVO.insertCheck.class) @ModelAttribute("searchVO") CmTermVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
        
        CommonMap returnMap = termInspectionService.insertProc(searchVO, result, session ); 
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/dbQlt/termDgns/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") DBdataVO searchVO) { 
        return termInspectionService.excelDownload(searchVO); 
	}
    
}
