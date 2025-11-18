package kr.or.standard.basic.system.mngr.mngrMng.controller;
 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.system.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.system.mngr.mngrMng.service.MngrMngService;
import kr.or.standard.basic.user.service.UserService;
import kr.or.standard.basic.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
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

@RequiredArgsConstructor
@Controller 
public class MngrMngController {

    private final MngrMngService mngrMngService; 
	 
	private final String URL_PATH = "/ma/sys/mngr/mngrMng/";
	
	@RequestMapping(URL_PATH + "list.do") 
	/* /ma/sys/mngr/mngrMng/list.do */ 
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do") 
	/* /ma/sys/mngr/mngrMng/addList.do */
	public String addList(@ModelAttribute("searchVO") UserVO searchVO, Model model) throws Exception {
		mngrMngService.addList(searchVO, model);
		return URL_PATH + "addList";
	}
	
	

	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do")
	/* /ma/sys/auth/insertForm.do | /ma/sys/auth/updateForm.do */
	/* /ma/sys/mngr/mngrMng/updateForm.do */
	public String form(@ModelAttribute("searchVO") UserVO searchVO, Model model, @PathVariable String procType, HttpSession session) {
		
		String rtnUrl = mngrMngService.insertUpdateForm(searchVO,  model , procType , session);
		if(! "".equals(rtnUrl)){
			return rtnUrl;
		}
		return ".mLayout:" + URL_PATH + "form";
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/mngrMng/proc */
	public ResponseEntity<?> insertProc(@Validated(UserVO.insertCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = mngrMngService.proc(searchVO, result ); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/mngrMng/proc */
	public ResponseEntity<?> updateProc(@Validated(UserVO.updateCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result, HttpSession session) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap =  mngrMngService.updateProc(searchVO , result , session ); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/mngr/mngrMng/proc */
	public ResponseEntity<?> deleteProc(@Validated(UserVO.deleteCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = mngrMngService.deleteProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/sys/auth/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") UserVO searchVO, Model model) throws Exception { 
		return mngrMngService.excelDownload(searchVO, model); 
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "unlockProc")
	/* /ma/sys/mngr/mngrMng/unlockProc */
	public CommonMap unlockProc(@ModelAttribute("searchVO") UserVO searchVO, HttpSession session){ 
		return mngrMngService.unlockProc(searchVO, session); 
	}

	@RequestMapping(URL_PATH + "addIpForm.do")
	/* /ma/sys/mngr/mngrMng/addIpFrom.do */
	public String addIpFrom(@ModelAttribute("searchVO") UserVO searchVO,@RequestParam String cnt, Model model) throws Exception { 
		model.addAttribute("cnt", cnt); 
		return URL_PATH + "addIpForm";
	}

	/* 그룹권한ID 중복체크 */
	@ResponseBody
	@RequestMapping(URL_PATH + "idOvlpChk")
	/* /ma/sys/mngr/mngrMng/idOvlpChk */
	public ResponseEntity<?> idOvlpChk(@Validated(UserVO.idCheck.class) @ModelAttribute("searchVO") UserVO searchVO, BindingResult result){
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = mngrMngService.idOvlpChk(searchVO, result); 
		return ResponseEntity.ok(returnMap);
	}

}
