package kr.or.opennote.basic.bltnb.controller;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.opennote.basic.bltnb.vo.BltnbVO;
import kr.or.opennote.basic.common.ajax.service.BasicCrudService; 
import kr.or.opennote.basic.common.file.service.FileService;
import kr.or.opennote.basic.common.view.excel.ExcelView;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
 


import kr.or.opennote.basic.bltnb.serivce.BltnbService;
  

@Slf4j
@Controller
public class BltnbController {
	 
	@Autowired public BltnbService bltnbService;
	// @Autowired public MaMenuService maMenuService;
	@Autowired public BasicCrudService crudService; 
	@Autowired public MessageSource messageSource;
	@Autowired public FileService fileService;
	@Autowired public ExcelView excelView;
	 
	
	@RequestMapping("{path1}/{menuCd}/list.do")
	public String list1(@ModelAttribute("searchVO") BltnbVO searchVO, @PathVariable String menuCd
	, @PathVariable String path1) throws Exception { 
		log.info("=================================== bltnbController list1 urlmapping ==>> {}/{}/list.do", path1 , menuCd ); 
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.pathCheck(path1,bltnbCl,"Y","list"); 
	}
	
	
	@RequestMapping("{path1}/{path2}/{menuCd}/list.do") 
	public String list2(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
	,@PathVariable String path1,@PathVariable String path2) throws Exception { 
		log.info("=================================== bltnbController list2 urlmapping ==>> {}/{}/{}/list.do", path1, path2, menuCd); 
		String bltnbCl = bltnbService.inqBltnbCl(menuCd); 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","list");
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/list.do") 
	public String list3(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) throws Exception {
		log.info("=================================== bltnbController  list3 urlmapping ==>> {}/{}/{}/{}/list.do",path1,path2,path3,menuCd);
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.pathCheck(path1,bltnbCl,"Y","list");
		  
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/list.do")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/list.do */
	public String list4(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) throws Exception { 
		log.info("=================================== bltnbController  list4 urlmapping ==>> {}/{}/{}/{}/{}/list.do",path1,path2,path3,path4,menuCd); 
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.pathCheck(path1,bltnbCl,"Y","list"); 
	}
	
	@RequestMapping("{path1}/{menuCd}/addList.do")
	/* {path1}/{menuCd}/addList.do */
	public String addList1(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
	,@PathVariable String path1) throws Exception { 
		log.info("=================================== bltnbController  addList1 mapping ==>>  {}/{}/addList.do",path1,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.addListModel(searchVO, model, menuCd,bltnbCl);	 
		return bltnbService.pathCheck(path1,bltnbCl,"N","addList");  
	}
	
	@RequestMapping("{path1}/{path2}/{menuCd}/addList.do")
	/* {path1}/{path2}/{menuCd}/addList.do */
	public String addList2(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
	,@PathVariable String path1,@PathVariable String path2) throws Exception {
		log.info("=================================== bltnbController  addList2 mapping ==>>  {}/{}/{}/addList.do",path1,path2,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.addListModel(searchVO, model, menuCd,bltnbCl);	 
		return bltnbService.pathCheck(path1,bltnbCl,"N","addList"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/addList.do")
	/* {path1}/{path2}/{path3}/{menuCd}/addList.do */
	public String addList3(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
	,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) throws Exception {
		log.info("=================================== bltnbController  addList3 mapping ==>>  {}/{}/{}/{}/addList.do",path1,path2,path3,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.addListModel(searchVO, model, menuCd,bltnbCl);	 
		return bltnbService.pathCheck(path1,bltnbCl,"N","addList"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/addList.do")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/addList.do */
	public String addList4(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model, @PathVariable String menuCd
	, @PathVariable String path1, @PathVariable String path2, @PathVariable String path3, @PathVariable String path4) throws Exception {
		log.info("=================================== bltnbController  addList4 mapping ==>>  {}/{}/{}/{}/{}/addList.do",path1,path2,path3,path4,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.addListModel(searchVO, model, menuCd,bltnbCl);	 
		return bltnbService.pathCheck(path1,bltnbCl,"N","addList"); 
	}
	
	@RequestMapping("{path1}/{menuCd}/view.do")
	/* {path1}/{menuCd}/view.do */
	public String view1(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
	,@PathVariable String path1) throws Exception {
		log.info("=================================== bltnbController  view1 mapping ==>>  {}/{}/view.do",path1,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.viewModel(searchVO, model, menuCd,bltnbCl, path1);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","view");  
		 
	}
	
	@RequestMapping("{path1}/{path2}/{menuCd}/view.do")
	/* {path1}/{path2}/{menuCd}/view.do */
	public String view2(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2) throws Exception {
		log.info("=================================== bltnbController  view2 mapping ==>>  {}/{}/{}/view.do",path1,path2,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.viewModel(searchVO, model, menuCd,bltnbCl, path1);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","view"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/view.do")
	/* {path1}/{path2}/{path3}/{menuCd}/view.do */
	public String view3(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) throws Exception {
		log.info("=================================== bltnbController  view3 mapping ==>>  {}/{}/{}/{}/view.do",path1,path2,path3,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.viewModel(searchVO, model, menuCd,bltnbCl, path1);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","view"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/view.do")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/view.do */
	public String view4(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
	    ,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) throws Exception {
		log.info("=================================== bltnbController  view4 mapping ==>>  {}/{}/{}/{}/{}/view.do",path1,path2,path3,path4,menuCd); 
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.viewModel(searchVO, model, menuCd,bltnbCl, path1);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","view"); 
	}
	
	@RequestMapping("{path1}/{menuCd}/{procType}Form.do")
	/* {path1}/{menuCd}/{procType}Form.do */
	public String form1(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String procType) throws Exception { 
		log.info("=================================== bltnbController  form1 mapping ==>>  {}/{}/{}Form.do",path1,menuCd,procType); 
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.formModel(searchVO, model, menuCd,bltnbCl, procType);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","form"); 
		 
	}
	
	@RequestMapping("{path1}/{path2}/{menuCd}/{procType}Form.do")
	public String form2(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String procType) throws Exception {
		log.info("=================================== bltnbController  form2 mapping ==>>  {}/{}/{}/{}Form.do",path1,path2,menuCd,procType);
		 
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.formModel(searchVO, model, menuCd,bltnbCl, procType);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","form"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/{procType}Form.do")
	/* {path1}/{path2}/{path3}/{menuCd}/{procType}Form.do */
	public String form3(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String procType) throws Exception {
		log.info("=================================== bltnbController  form3 mapping ==>>  {}/{}/{}/{}/{}Form.do",path1,path2,path3,menuCd,procType);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.formModel(searchVO, model, menuCd,bltnbCl, procType);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","form");  
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/{procType}Form.do")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/{procType}Form.do */
	public String form4(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4,@PathVariable String procType) throws Exception {
		log.info("=================================== bltnbController  form4 mapping ==>>  {}/{}/{}/{}/{}/{}Form.do",path1,path2,path3,path4,menuCd,procType);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		bltnbService.formModel(searchVO, model, menuCd,bltnbCl, procType);	 
		return bltnbService.pathCheck(path1,bltnbCl,"Y","form");   
	}
	
	/*
	 * 댓글 리스트 호출
	 */
	@RequestMapping("{path1}/{menuCd}/replList.do")
	/* {path1}/{menuCd}/replList.do*/
	public String replList1(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1) throws Exception {
		log.info("=================================== bltnbController  replList1 mapping ==>>  {}/{}/replList.do",path1,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getReplListUrl(searchVO, model, bltnbCl, path1,"N","replList" ); 
	}
	
	@RequestMapping("{path1}/{path2}/{menuCd}/replList.do")
	/* {path1}/{path2}/{menuCd}/replList.do */
	public String replList2(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2) throws Exception {
		log.info("=================================== bltnbController  replList2 mapping ==>>  {}/{}/{}/replList.do",path1,path2,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getReplListUrl(searchVO, model, bltnbCl, path1,"N","replList"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/replList.do")
	/* {path1}/{path2}/{path3}/{menuCd}/replList.do */
	public String replList3(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) throws Exception {
		log.info("=================================== bltnbController  replList3 mapping ==>>  {}/{}/{}/{}/replList.do",path1,path2,path3,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getReplListUrl(searchVO, model, bltnbCl, path1,"N","replList");  
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/replList.do")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/replList.do */
	public String replList4(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
	,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) throws Exception {
		log.info("=================================== bltnbController  replList3 mapping ==>>  {}/{}/{}/{}/{}/replList.do",path1,path2,path3,path4,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getReplListUrl(searchVO, model, bltnbCl, path1,"N","replList"); 
	}
	
	/*
	 * 답변 form 호출
	 */
	@RequestMapping("{path1}/{menuCd}/replForm.do")
	/* {path1}/{menuCd}/replForm.do */
	public String replForm1(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
	,@PathVariable String path1) throws Exception { 
		log.info("=================================== bltnbController  replForm1 mapping ==>>  {}/{}/replForm.do",path1,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getreplForm(searchVO, model, bltnbCl, path1,"N","replForm"); 
	}
	
	@RequestMapping("{path1}/{path2}/{menuCd}/replForm.do")
	/* {path1}/{path2}/{menuCd}/replForm.do */
	public String replForm2(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2) throws Exception {
		log.info("=================================== bltnbController  replForm2 mapping ==>>  {}/{}/{}/replForm.do",path1,path2,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getreplForm(searchVO, model, bltnbCl, path1,"N","replForm"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/replForm.do")
	/* {path1}/{path2}/{path3}/{menuCd}/replForm.do */
	public String replForm3(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) throws Exception {
		log.info("=================================== bltnbController  replForm3 mapping ==>>  {}/{}/{}/{}/replForm.do",path1,path2,path3,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getreplForm(searchVO, model, bltnbCl, path1,"N","replForm"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/replForm.do")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/replForm.do */
	public String replForm4(@ModelAttribute("searchVO") BltnbVO searchVO, ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) throws Exception {
		log.info("=================================== bltnbController  replForm4 mapping ==>>  {}/{}/{}/{}/{}/replForm.do",path1,path2,path3,path4,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getreplForm(searchVO, model, bltnbCl, path1,"N","replForm"); 
	}
	
	/*
	 *  좋아요 호출
	 */
	@RequestMapping("{path1}/{menuCd}/like")
	/* {path1}/{menuCd}/like */
	public String like1(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1) throws Exception {
		log.info("=================================== bltnbController  like1 mapping ==>>  {}/{}/like",path1,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getContentLike(searchVO, model, bltnbCl, path1,"N","like"); 
	}
	
	@RequestMapping("{path1}/{path2}/{menuCd}/like")
	/* {path1}/{menuCd}/replList.do*/
	public String like2(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2) throws Exception {
		log.info("=================================== bltnbController  like2 mapping ==>>  {}/{}/{}/like",path1,path2,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getContentLike(searchVO, model, bltnbCl, path1,"N","like"); 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/like")
	/* {path1}/{path2}/{path3}/{menuCd}/like */
	public String like3(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) throws Exception {
		log.info("=================================== bltnbController  like3 mapping ==>>  {}/{}/{}/{}/like",path1,path2,path3,menuCd);
	 	
	 	String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getContentLike(searchVO, model, bltnbCl, path1,"N","like");
		 
	}
	
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/like")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/like */
	public String like4(@ModelAttribute("searchVO") BltnbVO searchVO,ModelMap model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) throws Exception {
		log.info("=================================== bltnbController  like4 mapping ==>>  {}/{}/{}/{}/{}/like",path1,path2,path3,path4,menuCd);
		
		String bltnbCl = bltnbService.inqBltnbCl(menuCd);
		return bltnbService.getContentLike(searchVO, model, bltnbCl, path1,"N","like"); 
	}
	 
	
	/*
	 * 대댓글 불러오기
	 */
	@ResponseBody
	@PostMapping( "{path1}/{menuCd}/replOfRepl")
	/* {path1}/{menuCd}/replOfRepl */
	public ResponseEntity<?> replReplList1(@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd
		,@PathVariable String path1) {
		log.info("=================================== bltnbController  replReplList1 mapping ==>>  {}/{}/replOfRepl",path1,menuCd);
		
		return bltnbService.getReplOfRepl(searchVO , result ); 
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{menuCd}/replOfRepl")
	/* {path1}/{path2}/{menuCd}/replOfRepl */
	public ResponseEntity<?> replReplList2( @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  replReplList2 mapping ==>>  {}/{}/{}/replOfRepl",path1,path2,menuCd);
		  
		return bltnbService.getReplOfRepl(searchVO , result );
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{menuCd}/replOfRepl")
	/* {path1}/{path2}/{path3}/{menuCd}/replOfRepl */
	public ResponseEntity<?> replReplList3( @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  replReplList3 mapping ==>>  {}/{}/{}/{}/replOfRepl",path1,path2,path3,menuCd);
		
		return bltnbService.getReplOfRepl(searchVO , result );
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/replOfRepl")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/replOfRepl */
	public ResponseEntity<?> replReplList4( @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  replReplList4 mapping ==>>  {}/{}/{}/{}/{}/replOfRepl",path1,path2,path3,path4,menuCd);
		 
		return bltnbService.getReplOfRepl(searchVO , result );
	}
	
	/*
	 * QNA 비밀번호 체크
	 */
	@ResponseBody
	@PostMapping( "{path1}/{menuCd}/pswdCheck")
	/* {path1}/{menuCd}/pswdCheck */
	public ResponseEntity<?> pswdCheck1(@Validated(BltnbVO.pswdCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  pswdCheck1 mapping ==>>  {}/{}/pswdCheck",path1,menuCd);
		 
		return bltnbService.getPswdCheck(searchVO , result ); 
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{menuCd}/pswdCheck")
	/* {path1}/{path2}/{menuCd}/pswdCheck */
	public ResponseEntity<?> pswdCheck2(@Validated(BltnbVO.pswdCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  pswdCheck2 mapping ==>>  {}/{}/{}/pswdCheck",path1,path2,menuCd);
		 
		return bltnbService.getPswdCheck(searchVO , result );
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{menuCd}/pswdCheck")
	/* {path1}/{path2}/{path3}/{menuCd}/pswdCheck */
	public ResponseEntity<?> pswdCheck3(@Validated(BltnbVO.pswdCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  pswdCheck3 mapping ==>>  {}/{}/{}/{}/pswdCheck",path1,path2,path3,menuCd);
		  
		 return bltnbService.getPswdCheck(searchVO , result );
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/pswdCheck")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/pswdCheck */
	public ResponseEntity<?> pswdCheck4(@Validated(BltnbVO.pswdCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  pswdCheck4 mapping ==>>  {}/{}/{}/{}/{}/pswdCheck",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getPswdCheck(searchVO , result );
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{menuCd}/proc")
	/* {path1}/{menuCd}/proc */
	public ResponseEntity<?> insertProc1(@Validated(BltnbVO.insertCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  insertProc1 Post mapping ==>>  {}/{}/proc",path1,menuCd); 
		
		return bltnbService.getPostProc1(searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{menuCd}/proc")
	/* {path1}/{menuCd}/proc */
	public ResponseEntity<?> updateProc1(@Validated(BltnbVO.updateCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  updateProc1 Patch mapping ==>>  {}/{}/proc",path1,menuCd); 
		
		return bltnbService.getPatchProc1(request , searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{menuCd}/proc")
	/* {path1}/{menuCd}/proc */
	public ResponseEntity<?> deleteProc1(@Validated(BltnbVO.deleteCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  updateProc1 delete mapping ==>>  {}/{}/proc",path1,menuCd); 
		
		return bltnbService.getDeleteProc1(request , searchVO , result , menuCd , path1 );  
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{menuCd}/proc")
	/* {path1}/{path2}/{menuCd}/proc */
	public ResponseEntity<?> insertProc2(@Validated(BltnbVO.insertCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  insertProc2 post mapping ==>>  {}/{}/{}/proc",path1,path2,menuCd);
		
		return bltnbService.getPostProc2( searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{menuCd}/proc")
	/* {path1}/{path2}/{menuCd}/proc */
	public ResponseEntity<?> updateProc2(@Validated(BltnbVO.updateCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result, HttpServletRequest request,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  insertProc2 patch mapping ==>>  {}/{}/{}/proc",path1,path2,menuCd);
		
		return bltnbService.getPatchProc2(request , searchVO , result , menuCd , path1 );  
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{menuCd}/proc")
	/* {path1}/{path2}/{menuCd}/proc */
	public ResponseEntity<?> deleteProc2(@Validated(BltnbVO.deleteCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  insertProc2 delete mapping ==>>  {}/{}/{}/proc",path1,path2,menuCd);
		
		
		return bltnbService.getDeleteProc2(request , searchVO , result , menuCd , path1 );  
		
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{menuCd}/proc")
	/* {path1}/{path2}/{path3}/{menuCd}/proc */
	public ResponseEntity<?> insertProc3(@Validated(BltnbVO.insertCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  insertProc3 post mapping ==>>  {}/{}/{}/{}/proc",path1,path2,path3,menuCd);
		
		return bltnbService.getPostProc3(searchVO , result , menuCd , path1 );
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{path3}/{menuCd}/proc")
	/* {path1}/{path2}/{path3}/{menuCd}/proc */
	public ResponseEntity<?> updateProc3(@Validated(BltnbVO.updateCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result, HttpServletRequest request,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  insertProc3 patch mapping ==>>  {}/{}/{}/{}/proc",path1,path2,path3,menuCd);
		
		return bltnbService.getPatchProc3(request , searchVO , result , menuCd , path1 );
		
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{path3}/{menuCd}/proc")
	/* {path1}/{path2}/{path3}/{menuCd}/proc */
	public ResponseEntity<?> deleteProc3(@Validated(BltnbVO.deleteCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  insertProc3 delete mapping ==>>  {}/{}/{}/{}/proc",path1,path2,path3,menuCd);
		
		return bltnbService.getDeleteProc3(request , searchVO , result , menuCd , path1 );  
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/proc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/proc */
	public ResponseEntity<?> insertProc4(@Validated(BltnbVO.insertCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  insertProc4 post mapping ==>>  {}/{}/{}/{}/{}/proc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getPostProc4(searchVO , result , menuCd , path1 );
			
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/proc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/proc */
	public ResponseEntity<?> updateProc4(@Validated(BltnbVO.updateCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  insertProc4 patch mapping ==>>  {}/{}/{}/{}/{}/proc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getPatchProc4(request , searchVO , result , menuCd , path1 );
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/proc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/proc */
	public ResponseEntity<?> deleteProc4(@Validated(BltnbVO.deleteCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  insertProc4 delete mapping ==>>  {}/{}/{}/{}/{}/proc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getDeleteProc4(request , searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{menuCd}/replProc")
	/* {path1}/{menuCd}/replProc  */
	public ResponseEntity<?> insertRepl1(@Validated(BltnbVO.insertReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  insertRepl1 post mapping ==>>  {}/{}/replProc",path1,menuCd);
		
		return bltnbService.getInsertRepl1(searchVO , result , menuCd , path1 ); 
		
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{menuCd}/replProc")
	/* {path1}/{path2}/{menuCd}/replProc  */
	public ResponseEntity<?> insertRepl2(@Validated(BltnbVO.insertReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  insertRepl2 post mapping ==>>  {}/{}/{}/replProc",path1,path2,menuCd);
		
		return bltnbService.getInsertRepl2(searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{menuCd}/replProc")
	/* {path1}/{path2}/{path3}/{menuCd}/replProc */
	public ResponseEntity<?> insertRepl3(@Validated(BltnbVO.insertReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  insertRepl3 post mapping ==>>  {}/{}/{}/{}/replProc",path1,path2,path3,menuCd);
		
		return bltnbService.getInsertRepl3(searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/replProc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/replProc  */
	public ResponseEntity<?> insertRepl4(@Validated(BltnbVO.insertReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  insertRepl4 post mapping ==>>  {}/{}/{}/{}/{}/replProc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getInsertRepl4(searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{menuCd}/replProc")
	/* {path1}/{menuCd}/replProc */
	public ResponseEntity<?> updateRepl(@Validated(BltnbVO.updateReplCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  updateRepl patch mapping ==>>  {}/{}/replProc",path1,menuCd);
		 
		return bltnbService.getUpdateRepl1(request, searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{menuCd}/replProc")
	/* {path1}/{path2}/{menuCd}/replProc */
	public ResponseEntity<?> updateRepl2(@Validated(BltnbVO.updateReplCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  updateRepl2 patch mapping ==>>  {}/{}/{}/replProc",path1,path2,menuCd);
		
		return bltnbService.getUpdateRepl2(request, searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{path3}/{menuCd}/replProc")
	/* {path1}/{path2}/{path3}/{menuCd}/replProc  */
	public ResponseEntity<?> updateRepl3(@Validated(BltnbVO.updateReplCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  updateRepl3 patch mapping ==>>  {}/{}/{}/{}/replProc",path1,path2,path3,menuCd);
		
		return bltnbService.getUpdateRepl3(request, searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/replProc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/replProc  */
	public ResponseEntity<?> updateRepl4(@Validated(BltnbVO.updateReplCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  updateRepl4 patch mapping ==>>  {}/{}/{}/{}/{}/replProc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getUpdateRepl4(request, searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{menuCd}/replProc")
	/* {path1}/{menuCd}/replProc  */
	public ResponseEntity<?> deleteRepl1(@Validated(BltnbVO.deleteReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  deleteRepl1 patch mapping ==>>  {}/{}/replProc",path1,menuCd);
		
		return bltnbService.getDeleteRepl1(request, searchVO , result , menuCd , path1 );
		
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{menuCd}/replProc")
	/* {path1}/{path2}/{menuCd}/replProc  */
	public ResponseEntity<?> deleteRepl2(@Validated(BltnbVO.deleteReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  deleteRepl2 delete mapping ==>>  {}/{}/{}/replProc",path1,path2,menuCd);
		return bltnbService.getDeleteRepl2(request, searchVO , result , menuCd , path1 );
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{path3}/{menuCd}/replProc")
	/* {path1}/{path2}/{path3}/{menuCd}/replProc  */
	public ResponseEntity<?> deleteRepl3(@Validated(BltnbVO.deleteReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  deleteRepl3 delete mapping ==>>  {}/{}/{}/{}/replProc",path1,path2,path3,menuCd);
		
		return bltnbService.getDeleteRepl3(request, searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/replProc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/replProc */
	public ResponseEntity<?> deleteRepl4(@Validated(BltnbVO.deleteReplCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		, HttpServletRequest request,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  deleteRepl4 delete mapping ==>>  {}/{}/{}/{}/{}/replProc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getDeleteRepl4(request, searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{menuCd}/likeProc")
	/* {path1}/{menuCd}/likeProc */
	public ResponseEntity<?> insertLike1(@Validated(BltnbVO.insertLikeCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  insertLike1 post mapping ==>>  {}/{}/likeProc",path1,menuCd);
		
		return bltnbService.getInsertLike1(searchVO , result , menuCd , path1 );
		  
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{menuCd}/likeProc")
	/* {path1}/{path2}/{menuCd}/likeProc */
	public ResponseEntity<?> insertLike2(@Validated(BltnbVO.insertLikeCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  insertLike2 post mapping ==>>  {}/{}/{}/likeProc",path1,path2,menuCd);
		
		return bltnbService.getInsertLike2(searchVO , result , menuCd , path1 ); 
		
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{menuCd}/likeProc")
	/* {path1}/{path2}/{path3}/{menuCd}/likeProc  */
	public ResponseEntity<?> insertLike3(@Validated(BltnbVO.insertLikeCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  insertLike3 post mapping ==>>  {}/{}/{}/{}/likeProc",path1,path2,path3,menuCd);
		
		return bltnbService.getInsertLike3(searchVO , result , menuCd , path1 );
		  
	}
	
	@ResponseBody
	@PostMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/likeProc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/likeProc  */
	public ResponseEntity<?> insertLike4(@Validated(BltnbVO.insertLikeCheck.class) @ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  insertLike4 post mapping ==>>  {}/{}/{}/{}/{}/likeProc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getInsertLike4(searchVO , result , menuCd , path1 );
		
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{menuCd}/likeProc")
	/* {path1}/{menuCd}/likeProc */
	public ResponseEntity<?> updatelike1(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  updatelike1 patch mapping ==>>  {}/{}/likeProc",path1,menuCd);
		 
		 return bltnbService.getUpdatelike1(searchVO , result , menuCd , path1 );
		
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{menuCd}/likeProc")
	/* {path1}/{path2}/likeProc */
	public ResponseEntity<?> updatelike2(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  updatelike2 patch mapping ==>>  {}/{}/{}/likeProc",path1,path2,menuCd);
		
		 return bltnbService.getUpdatelike2(searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{path3}/{menuCd}/likeProc")
	/* {path1}/{path2}/{path3}/likeProc */
	public ResponseEntity<?> updatelike3(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  updatelike3 patch mapping ==>>  {}/{}/{}/{}/likeProc",path1,path2,path3,menuCd);
		
		return bltnbService.getUpdatelike3(searchVO , result , menuCd , path1 ); 
		
	}
	
	@ResponseBody
	@PatchMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/likeProc")
	/* {path1}/{path2}/{path3}/{path4}/likeProc */
	public ResponseEntity<?> updatelike4(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  updatelike4 patch mapping ==>>  {}/{}/{}/{}/{}/likeProc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getUpdatelike4(searchVO , result , menuCd , path1 ); 
		 
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{menuCd}/likeProc")
	/* {path1}/{menuCd}/likeProc */
	public ResponseEntity<?> deletelike1(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd,@PathVariable String path1) {
		log.info("=================================== bltnbController  deletelike1 delete mapping ==>>  {}/{}/likeProc",path1,menuCd); 
		
		return bltnbService.getDeletelike1(searchVO , result , menuCd , path1 );  
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{menuCd}/likeProc")
	/* {path1}/{path2}/{menuCd}/likeProc */
	public ResponseEntity<?> deletelike2(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2) {
		log.info("=================================== bltnbController  deletelike2 delete mapping ==>>  {}/{}/{}/likeProc",path1,path2,menuCd);
		
		return bltnbService.getDeletelike2(searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{path3}/{menuCd}/likeProc")
	/* {path1}/{path2}/{path3}/{menuCd}/likeProc */
	public ResponseEntity<?> deletelike3(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) {
		log.info("=================================== bltnbController  deletelike3 delete mapping ==>>  {}/{}/{}/{}/likeProc",path1,path2,path3,menuCd);
		
		return bltnbService.getDeletelike3(searchVO , result , menuCd , path1 ); 
	}
	
	@ResponseBody
	@DeleteMapping( "{path1}/{path2}/{path3}/{path4}/{menuCd}/likeProc")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/likeProc */
	public ResponseEntity<?> deletelike4(@Validated(BltnbVO.updateLikeCheck.class)@ModelAttribute("searchVO") BltnbVO searchVO, BindingResult result
		,@PathVariable String menuCd,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) {
		log.info("=================================== bltnbController  deletelike3 delete mapping ==>>  {}/{}/{}/{}/{}/likeProc",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getDeletelike4(searchVO , result , menuCd , path1 ); 
		 
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping("{path1}/{menuCd}/excelDownload.do")
	/* {path1}/{menuCd}/excelDownload.do */
	public ModelAndView excelDownload1(@ModelAttribute("searchVO") BltnbVO searchVO, Model model,@PathVariable String menuCd,@PathVariable String path1) throws Exception {
		log.info("=================================== bltnbController  excelDownload1 mapping ==>>  {}/{}/excelDownload",path1,menuCd);
		
		return bltnbService.getExcelDownload1(searchVO , model , menuCd , path1 ); 
		
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping("{path1}/{path2}/{menuCd}/excelDownload.do")
	/* {path1}/{path2}/{menuCd}/excelDownload.do */
	public ModelAndView excelDownload2(@ModelAttribute("searchVO") BltnbVO searchVO, Model model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2) throws Exception {
		log.info("=================================== bltnbController  excelDownload2 mapping ==>>  {}/{}/{}/excelDownload",path1,path2,menuCd);
		
		return bltnbService.getExcelDownload2(searchVO , model , menuCd , path1 ); 
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping("{path1}/{path2}/{path3}/{menuCd}/excelDownload.do")
	/* {path1}/{path2}/{path3}/{menuCd}/excelDownload.do */
	public ModelAndView excelDownload3(@ModelAttribute("searchVO") BltnbVO searchVO, Model model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3) throws Exception {
		log.info("=================================== bltnbController  excelDownload3 mapping ==>>  {}/{}/{}/{}/excelDownload",path1,path2,path3,menuCd);
		
		return bltnbService.getExcelDownload3(searchVO , model , menuCd , path1 ); 
	}
	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping("{path1}/{path2}/{path3}/{path4}/{menuCd}/excelDownload.do")
	/* {path1}/{path2}/{path3}/{path4}/{menuCd}/excelDownload.do */
	public ModelAndView excelDownload4(@ModelAttribute("searchVO") BltnbVO searchVO, Model model,@PathVariable String menuCd
		,@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4) throws Exception {
		log.info("=================================== bltnbController  excelDownload4 mapping ==>>  {}/{}/{}/{}/{}/excelDownload",path1,path2,path3,path4,menuCd);
		
		return bltnbService.getExcelDownload4(searchVO , model , menuCd , path1 ); 
	}
	
}