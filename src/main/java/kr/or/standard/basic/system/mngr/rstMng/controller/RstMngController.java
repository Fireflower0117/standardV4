package kr.or.standard.basic.system.mngr.rstMng.controller;

 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.mngr.rstMng.service.RstMngService;
import kr.or.standard.basic.system.mngr.rstMng.vo.RstMngVO;
import kr.or.standard.basic.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
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
public class RstMngController {

    private final RstMngService rstMngService;
    
    
	private static final String URL_PATH = "/ma/sys/mngr/rstMng/";
	
	@RequestMapping(URL_PATH + "list.do") 
	/* /ma/sys/mngr/rstMng/list.do */ 
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do") 
	/* /ma/sys/mngr/rstMng/addList.do */
	public String addList(@ModelAttribute("searchVO") RstMngVO searchVO, Model model) throws Exception {
		
		rstMngService.addList(searchVO , model); 
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "insertForm.do")
	/* /ma/sys/mngr/rstMng/inertForm.do */
	public String form(@ModelAttribute("searchVO") RstMngVO searchVO, Model model) { 
		return ".mLayout:" + URL_PATH + "form";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/rstMng/proc */
	public ResponseEntity<?> insertProc(@Validated(RstMngVO.insertCheck.class) @ModelAttribute("searchVO") RstMngVO searchVO, BindingResult result) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = rstMngService.insertProc(searchVO , result); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/rstMng/proc */
	public ResponseEntity<?> deleteProc(@Validated(UserVO.deleteCheck.class) @ModelAttribute("searchVO") RstMngVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
    
        CommonMap returnMap = rstMngService.deleteProc(searchVO , result , session);
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/sys/auth/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") RstMngVO searchVO, Model model) throws Exception { 
        return rstMngService.excelDownload(searchVO , model); 
	}

	// 일괄제한 및 일괄제한해제
	@ResponseBody
	@RequestMapping(URL_PATH + "{procType:allBlk|allClear}")
	/* /ma/sys/mngr/rstMng/allBlk |  /ma/sys/mngr/rstMng/allClear */
	public CommonMap allAction(@ModelAttribute("searchVO") RstMngVO searchVO, @PathVariable String procType){ 
		return rstMngService.allAction(searchVO , procType); 
	}

	/* ID 중복체크 */
	@ResponseBody
	@RequestMapping(URL_PATH + "idOvlpChk")
	/* /ma/sys/mngr/rstMng/idOvlpChk */
	public CommonMap idOvlpChk(@ModelAttribute("searchVO") RstMngVO searchVO){ 
        return rstMngService.idOvlpChk(searchVO); 
	}
}
