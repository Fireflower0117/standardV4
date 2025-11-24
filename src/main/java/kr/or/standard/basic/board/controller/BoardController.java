package kr.or.standard.basic.board.controller;
 
import kr.or.standard.basic.board.service.BoardService;
import kr.or.standard.basic.board.vo.BoardVO;
import kr.or.standard.basic.common.domain.CommonMap;
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
public class BoardController {

    private final BoardService boardService; 
    
	private final String URL_PATH = "/ma/board/";
	
	@RequestMapping(URL_PATH + "list.do") 
	/* /ma/board/list.do */
	public String list(@ModelAttribute("searchVO") BoardVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do") 
	/* /ma/board/addList.do */
	public String addList(@ModelAttribute("searchVO") BoardVO searchVO, Model model) throws Exception { 
		boardService.addaddList(searchVO, model); 
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "view.do") 
	/* /ma/board/view.do */
	public String view(@ModelAttribute("searchVO") BoardVO searchVO, Model model) { 
        boardService.view(searchVO, model); 
		return ".mLayout:" + URL_PATH + "view";
	}
	
	@RequestMapping(URL_PATH + "{procType:insert|update}Form.do") 
	/* /ma/board/insertForm.do, /ma/board/updateForm.do */
	public String form(@ModelAttribute("searchVO") BoardVO searchVO, Model model, @PathVariable String procType, HttpSession session) { 
		String rtnUrl = boardService.form(searchVO, model , procType, session);
		if(!"".equals(rtnUrl)) { return rtnUrl; }  
		else { return ".mLayout:" + URL_PATH + "form"; }
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/board/proc */
	public ResponseEntity<?> insertProc(@Validated(BoardVO.insertCheck.class) @ModelAttribute("searchVO") BoardVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = boardService.insertProc(searchVO, result); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/board/proc */
	public ResponseEntity<?> updateProc(@Validated(BoardVO.updateCheck.class) @ModelAttribute("searchVO") BoardVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = boardService.updateProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/board/proc */
	public ResponseEntity<?> deleteProc(@Validated(BoardVO.deleteCheck.class) @ModelAttribute("searchVO") BoardVO searchVO, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		CommonMap returnMap = boardService.deleteProc(searchVO, result, session); 
		return ResponseEntity.ok(returnMap);
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/board/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") BoardVO searchVO) throws Exception { 
        return boardService.excelDownload(searchVO); 
	}
}