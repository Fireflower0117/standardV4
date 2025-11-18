package kr.or.standard.basic.system.menu.controller;
 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.code.service.CodeService;
import kr.or.standard.basic.system.code.vo.CodeVO;
import kr.or.standard.basic.system.contTmpl.vo.ContTmplVO;
import kr.or.standard.basic.system.menu.servie.MenuService;
import kr.or.standard.basic.system.menu.vo.MenuVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MenuController {

	@Value("${file.env.divn}")
	private String FILE_ENV_DIVN;
	
	private final MenuService menuService;
	private final CodeService codeService;
	private final MessageSource messageSource;
	private final PaginationService paginationService;
	private final ExcelView excelView;
	
	 
	
	private static final String URL_PATH = "/ma/sys/menu/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/sys/menu/list.do */
	public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
		return ".mLayout:" + URL_PATH + "list";
	}
	
	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/sys/menu/addList.do */
	public String addList(@ModelAttribute("searchVO") MenuVO searchVO, ModelMap model) {

		List<MenuVO> resultList = menuService.selectList(searchVO);
		model.addAttribute("resultList", resultList);
		
		return URL_PATH + "addList";
	}
	
	@RequestMapping(URL_PATH + "addForm.do")
	/* /ma/sys/menu/addForm.do */
	public String addForm(MenuVO searchVO, ModelMap model) {
		
		MenuVO menuVO = new MenuVO();
		if(!StringUtils.isEmpty(searchVO.getMenuCd())){
			menuVO = menuService.selectContents(searchVO);
		}
		model.addAttribute("menuVO",menuVO); 
		return URL_PATH + "addForm";
	}

	
	@ResponseBody
	@RequestMapping(URL_PATH + "menuCdDuplCheck")
	/* /ma/sys/menu/menuCdDuplCheck */
	public ResponseEntity<?> menuCdDuplCheck(@ModelAttribute("searchVO") MenuVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("check", menuService.menuCdDuplCheck(searchVO));
		log.info("check : {}" , returnMap.get("check") ); 
		log.info("check : {}" , returnMap.get("check") ); 
		return ResponseEntity.ok(returnMap);
	}

	@ResponseBody
	@PostMapping(URL_PATH + "proc")
	/* /ma/sys/menu/proc */
	public ResponseEntity<?> insertProc(@Validated(MenuVO.insertCheck.class) @ModelAttribute("searchVO") MenuVO searchVO, BindingResult result,HttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>();
		
		//메뉴코드 유효성 검사 체크
		if(menuService.menuCdDuplCheck(searchVO) > 0) { 
			returnMap.put("message", messageSource.getMessage("menu.duplCheck.message", null, null));
			returnMap.put("returnUrl", "form.do");
			return ResponseEntity.ok(returnMap);
		}
		
		int resultCnt = 0;
		resultCnt = menuService.insertContents(searchVO);
		
		if(resultCnt > 0) {
			// 게시판 유형이 컨텐츠 일때
			if("C".equals(searchVO.getMenuTpCl())){
				//컨텐츠 HTML 파일 생성
				menuService.makeContHtml(request, searchVO,URL_PATH);
			}
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}

		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@PatchMapping(URL_PATH + "proc")
	/* /ma/sys/menu/proc */
	public ResponseEntity<?> updateProc(@Validated(MenuVO.updateCheck.class) @ModelAttribute("searchVO") MenuVO searchVO, BindingResult result,HttpServletRequest request) throws Exception {
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		int resultCnt = 0;
		HashMap<String, Object> returnMap = new HashMap<>();
		HttpSession session = request.getSession();
	
		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || menuService.regrCheck(searchVO)) {			
			resultCnt = menuService.updateContents(searchVO);
			
			if(resultCnt > 0) {
				// 게시판 유형이 컨텐츠 일때
				if("C".equals(searchVO.getMenuTpCl())){
					//컨텐츠 HTML 파일 생성
					menuService.makeContHtml(request, searchVO,URL_PATH);
				}
				// 수정된 메뉴포함하여 menuList layout jsp 생성
				menuService.makeLayoutHtml(request, searchVO,null,URL_PATH, "");
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
		}else {			
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
				
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "proc")
	/* /ma/sys/menu/proc */
	public ResponseEntity<?> deleteProc(@Validated(MenuVO.deleteCheck.class) @ModelAttribute("searchVO") MenuVO searchVO, BindingResult result,HttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		int resultCnt = 0;
		HashMap<String, Object> returnMap = new HashMap<>();
		HttpSession session = request.getSession();

		// 관리자 또는 본인글인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || menuService.regrCheck(searchVO)) {
			resultCnt = menuService.deleteContents(request,searchVO);
			
			if(resultCnt > 0) {
				// 삭제된 메뉴 제외하고 menuList layout 생성
				menuService.makeLayoutHtml(request, searchVO,null,URL_PATH, "delete");
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			}
		}else {			
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
			
		
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@RequestMapping(URL_PATH + "{procType:up|down}Proc")
	/* /ma/sys/menu/upProc /ma/sys/menu/downProc */
	public ResponseEntity<?> upDownProc(@ModelAttribute("searchVO") MenuVO searchVO, BindingResult result, @PathVariable String procType) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}

		HashMap<String, Object> returnMap = new HashMap<>();
		int cnt = 0;

		 if ("up".equals(procType)) {
			 cnt = menuService.orderUp(searchVO);
		} else if ("down".equals(procType)) {
			 cnt = menuService.orderDown(searchVO);
		}

		returnMap.put("cnt", cnt);
		returnMap.put("searchVO", searchVO);

		return ResponseEntity.ok(returnMap);
	}
	
	//콘텐츠 addPop
	@RequestMapping(URL_PATH + "addContTmpl")
	/* /ma/sys/menu/addContTmpl */
	public String form(@ModelAttribute("searchVO") MenuVO searchVO, ModelMap model) throws Exception {

		// 메뉴 유형구분이 콘텐츠 일때만 실행
		if("C".equals(searchVO.getMenuTpCl())) {
			String editrCont = "";
			if(!StringUtils.isEmpty(searchVO.getContSerno())){
				editrCont = menuService.selectContContents(searchVO.getMenuCd());
			}			
			model.addAttribute("editrCont",editrCont);
		}
		return URL_PATH + "addContTmpl";
	}
	
	@RequestMapping(URL_PATH + "popUpAction")
	/* /ma/sys/menu/popUpAction */
	public String popUpAction(@ModelAttribute("searchVO") ContTmplVO searchVO, ModelMap model) throws Exception {
		

		if("Detail".equals(searchVO.getPopDivn())) {
			CodeVO codeVO = new CodeVO();	
			codeVO.setCdUppoVal("TMCL");
			List<CodeVO> cateCdList = (List<CodeVO>) codeService.selectList(codeVO);
			model.addAttribute("cateCdList", cateCdList);			
		}
		
		/* /ma/sys/menu/tmplTotal , /ma/sys/menu/tmplDetail */
		return URL_PATH + "tmpl" + searchVO.getPopDivn();
	}
	
	@RequestMapping(URL_PATH  + "popAddList")
	/* /ma/sys/menu/popAddList */
	public String popAddList(@ModelAttribute("searchVO") ContTmplVO searchVO, ModelMap model) throws Exception {
		
		searchVO.setRecordCountPerPage(8);
		if(StringUtils.isEmpty(searchVO.getTabDivn())) {
			searchVO.setTabDivn("TMCL01");
		}	
			
		if("favorit".equals(searchVO.getTabDivn())) {
			PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
			paginationInfo.setTotalRecordCount(menuService.fvrtSelectCount(searchVO));
			model.addAttribute("paginationInfo", paginationInfo);
			
			List<ContTmplVO> resultList = menuService.fvrtSelectList(searchVO);
			model.addAttribute("resultList", resultList);

		}else{
			PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
			paginationInfo.setTotalRecordCount(menuService.popSelectCount(searchVO));
			model.addAttribute("paginationInfo", paginationInfo);
			
			List<ContTmplVO> resultList = menuService.popSelectList(searchVO);
			model.addAttribute("resultList", resultList);
		}
		/* /ma/sys/menu/tmplTotalList , /ma/sys/menu/tmplDetailList */
		return URL_PATH  + "tmpl" + searchVO.getPopDivn() + "List";
	}
	
	@RequestMapping(URL_PATH + "popSetAciton")
	/* /ma/sys/menu/popSetAciton */
	public String popSetAciton(@ModelAttribute("searchVO") ContTmplVO searchVO, ModelMap model) throws Exception {
		
		List<HashMap<String,String>> popArr = searchVO.getMapArr();
		
		List<ContTmplVO> setList = new ArrayList<>();
		for (HashMap<String,String> tempMap : popArr) {
			ContTmplVO contTmplVO = new ContTmplVO();
			contTmplVO.setTmplSerno(tempMap.get("tmplSerno"));
			contTmplVO.setEditrCont(tempMap.get("editrCont"));
			contTmplVO.setTmplExpl(tempMap.get("tmplExpl"));
			contTmplVO.setTmplCnt(tempMap.get("tmplCnt"));
			setList.add(contTmplVO);
		}
		
		model.addAttribute("setList", setList);
		model.addAttribute("tmplTotalCnt", searchVO.getTmplTotalCnt());
		
		return URL_PATH + "tmplDetailSetList";
	}
	
	@RequestMapping(URL_PATH + "popPreview.do")
	/* /ma/sys/menu/popPreview.do */
	public String popPreview(@ModelAttribute("searchVO")ContTmplVO searchVO, ModelMap model) throws Exception {
		
		String editrCont = "";
		if(!StringUtils.isEmpty(searchVO.getMenuCd())){
			editrCont = menuService.selectContContents(searchVO.getMenuCd());
		}else {			
			editrCont = searchVO.getPreviewCont();
		}
		model.addAttribute("editrCont", editrCont);
		return URL_PATH + "popPreview";
	}
	
	@ResponseBody
	@PostMapping(URL_PATH + "fvrtProc")
	/* /ma/sys/menu/fvrtProc */
	public ResponseEntity<?> fvrtInsertProc(@Validated(ContTmplVO.insertFvrtCheck.class) @ModelAttribute("searchVO") ContTmplVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		HashMap<String, Object> returnMap = new HashMap<>();
		
		if("Y".equals(searchVO.getUseYn())){
			menuService.insertFvrtContents(searchVO);
		}
		
		return ResponseEntity.ok(returnMap);
	}
	
	@ResponseBody
	@DeleteMapping(URL_PATH + "fvrtProc")
	/* /ma/sys/menu/fvrtProc */
	public ResponseEntity<?> fvrtDeleteProc(@Validated(ContTmplVO.deleteFvrtCheck.class) @ModelAttribute("searchVO") ContTmplVO searchVO, BindingResult result) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		HashMap<String, Object> returnMap = new HashMap<>();
		
		if("N".equals(searchVO.getUseYn())){
			menuService.deleteFvrtContents(searchVO);
		}
		
		return ResponseEntity.ok(returnMap);
	}
	
	/* 
	 * Excel - 엑셀 다운로드 
	 */
	@RequestMapping(URL_PATH  + "excelDownload.do")
	/* /ma/sys/menu/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") MenuVO searchVO, Model model) throws Exception {
		
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "메뉴목록";
		String url = "/standard/system/menuList.xlsx";
		
		List<MenuVO> resultList = menuService.selectExcelList(searchVO);
		
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
	}
	
	/* 
	 * header menuList layout 파일 읽기 
	 */
	@RequestMapping(URL_PATH + "{path:ma|ft|my}MenuList")
	/* /ma/sys/menu/maLayout /ma/sys/menu/ftLayout /ma/sys/menu/myLayout */
	public String menuList(@ModelAttribute("searchVO") MenuVO searchVO,  Model model, @PathVariable String path,HttpServletRequest request) throws Exception {
		
		MenuVO menuVO = menuService.getMenuList(path, searchVO.getGrpAuthId(),path);
		model.addAttribute("menuVO", menuVO);
		//관리자 layout일 경우 공통게시판 목록 조회
		if("ma".equals(path)) {
			List<MenuVO> menuBltnbList = menuService.selectMenuBltnbList(searchVO.getGrpAuthId());			
			model.addAttribute("menuBltnbList", menuBltnbList);
		}
		return "/common/layout/" + path + "/menuList";
	}
	
	/* 
	 * aside layout 파일 읽기 
	 */
	@RequestMapping(URL_PATH + "{path:ft|my}Aside")
	/* /ma/sys/menu/ftAside /ma/sys/menu/myAside */
	public String aside(@ModelAttribute("searchVO") MenuVO searchVO,  Model model, @PathVariable String path,HttpServletRequest request) throws Exception {
		
		
		MenuVO menuVO = menuService.getMenuList(path, searchVO.getGrpAuthId(),path);
		model.addAttribute("menuVO", menuVO);
		return "/common/layout/" + path + "/aside";
	}
}
 