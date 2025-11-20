package kr.or.standard.basic.bltnb.serivce;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.bltnb.vo.BltnbVO;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.file.vo.FileVO;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.module.EncryptUtil;
import kr.or.standard.basic.system.menu.servie.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class BltnbService {
    
    private final MenuService menuService;
    private final PaginationService paginationService;
    private final FileService fileService;
    private final EncryptUtil encryptUtil;
    private final MessageSource messageSource;
    private final BasicCrudDao basicCrudDao;
    private final CmmnDefaultDao defaultDao;
    private final ExcelView excelView;
    
    public String inqBltnbCl(String menuCd){
        CommonMap condiMap = new CommonMap();
        condiMap.put("menuCd", menuCd);
        return menuService.selectBltnbCl(condiMap); 
  
    }
    
    public String pathCheck(String path1 , String bltnbCl , String layoutYn , String url){
            String returnUrl = "";
            
            if("".equals(path1)) {
                return null;
            }else if("".equals(bltnbCl)) {
                returnUrl =  "/"  + path1 + "/bltnb/"  + url;
            // 관리자
            }else if("ma".equals(path1)) {
                if("Y".equals(layoutYn)) {
                    returnUrl =  ".mLayout:/"  + path1 + "/bltnb/" + bltnbCl + "/" + url;
                }else {
                    returnUrl =  "/"  + path1 + "/bltnb/" + bltnbCl + "/" + url;
                }
            // 사용자
            } else if("ft".equals(path1)) {
                if("Y".equals(layoutYn)) {
                    returnUrl =  ".fLayout:/"  + path1 + "/bltnb/" + bltnbCl + "/" + url;
                }else {
                    returnUrl =  "/"  + path1 + "/bltnb/" + bltnbCl + "/" + url;
                }
            } else {
                returnUrl = "";
            }
        	
        	log.info(" return url : {} ", returnUrl); 
            return returnUrl;
    }
    
    /** 
	 * 리스트 제작
	 */
	public void addListModel(BltnbVO searchVO, ModelMap model, String menuCd, String bltnbCl) throws Exception {
		
		searchVO.setMenuCd(menuCd);
		searchVO.setBltnbCl(bltnbCl);
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		BltnbVO resultVo = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectContentCount", searchVO); 
		paginationInfo.setTotalRecordCount(resultVo.getRowCnt());
		model.addAttribute("paginationInfo", paginationInfo);
		List<BltnbVO> resultListVo = (List<BltnbVO>) defaultDao.selectList("opnt.basic.mapper.BltnbMngMapper.selectContentList", searchVO); 
		model.addAttribute("resultList", resultListVo);
	}
	
	/** 
	 * 상세 제작
	 */
	public void viewModel(BltnbVO searchVO, ModelMap model,String menuCd,String bltnbCl,String path1) throws Exception {
		
		searchVO.setBltnbCl(bltnbCl);
		searchVO.setMenuCd(menuCd); 
		BltnbVO bltnbVO = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectContents", searchVO); 
		model.addAttribute("bltnbVO", bltnbVO);		
		
		// 사용자화면인 경우
		if("ft".equals(path1) && !"qa".equals(bltnbCl) && !"fa".equals(bltnbCl)){  
		    List<BltnbVO> sernoList = (List<BltnbVO>)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectPrevNextContents", searchVO); 
			model.addAttribute("sernoList", sernoList);	
		}
		
		//갤러리일 경우 첨부파일 리스트 불러오기
		if("gr".equals(bltnbCl)){
			if(!StringUtils.isEmpty(bltnbVO.getAtchFileId())){
				FileVO fileVO = new FileVO();
				fileVO.setAtchFileId(bltnbVO.getAtchFileId()); 
				List<FileVO> fileList = fileService.getAtchFileList(fileVO);
				model.addAttribute("fileList", fileList);
			}
		}
	}
	
	
	/** 
	 * 폼 제작
	 */
	public void formModel(BltnbVO searchVO, ModelMap model,String menuCd,String bltnbCl,String procType) throws Exception {
		
		searchVO.setBltnbCl(bltnbCl);
		searchVO.setMenuCd(menuCd);
		BltnbVO bltnbVO = new BltnbVO();
		if("update".equals(procType)) {
		    bltnbVO = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectContents", searchVO); 
		}else if("insert".equals(procType)) {
			bltnbVO.setMenuCd(menuCd);
			bltnbVO.setBltnbCl(bltnbCl);
		}
		
		model.addAttribute("bltnbVO", bltnbVO);
	}
	
	public String getReplListUrl(BltnbVO searchVO,ModelMap model,String bltnbCl,String path1, String layoutYn , String url) throws Exception {
	     
		if(!StringUtils.isEmpty(bltnbCl) && ("bd".equals(bltnbCl) || "nt".equals(bltnbCl) || "gr".equals(bltnbCl))) {
			this.replListModel(searchVO, model);		
			return this.pathCheck(path1,"",layoutYn,url);
		}else {
			return "redirect:list.do";			
		}
	
	}
	
	/** 
	 * 댓글 리스트 제작
	 */
	public void replListModel(BltnbVO searchVO, ModelMap model) throws Exception {
		
		BltnbVO resultVo = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectReplCount", searchVO);
		int count = resultVo.getRowCnt();  
		model.addAttribute("replCount", count);
		
		List<BltnbVO> replList = (List<BltnbVO>)defaultDao.selectList("opnt.basic.mapper.BltnbMngMapper.selectReplList", searchVO); 
		model.addAttribute("replList", replList);
	}
    
    public String getreplForm(BltnbVO searchVO,ModelMap model,String bltnbCl,String path1,String layoutYn , String url) throws Exception{
         
		if(!StringUtils.isEmpty(bltnbCl) && "qa".equals(bltnbCl)) {
			this.replFormModel(searchVO, model);		
			return this.pathCheck(path1,bltnbCl,"N","replForm");
		}else {
			return "redirect:list.do";			
		}
    }
    
    /** 
	 * 좋아요 제작
	 */
	public void replFormModel(BltnbVO searchVO, ModelMap model) throws Exception { 
		BltnbVO replVO = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectReplContents", searchVO); 
		model.addAttribute("replVO", replVO);
	}
	
	
	
	public String getContentLike(BltnbVO searchVO,ModelMap model,String bltnbCl,String path1,String layoutYn , String url) throws Exception { 
		if(!StringUtils.isEmpty(bltnbCl) && ("bd".equals(bltnbCl) || "nt".equals(bltnbCl) || "gr".equals(bltnbCl))) {
			this.likeModel(searchVO, model);		
			return this.pathCheck(path1,"",layoutYn ,url);
		}else {
			return "redirect:list.do";			
		}	
	}
	
	/** 댓글 폼 제작 */
	public void likeModel(BltnbVO searchVO, ModelMap model) throws Exception { 
		BltnbVO rcmdVO = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectLikeCounts", searchVO); 
		model.addAttribute("rcmdVO", rcmdVO);	
	}
	
	/** 댓글의 댓글 **/
    public ResponseEntity getReplOfRepl(BltnbVO searchVO , BindingResult result ){
        
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		HashMap<String, Object> returnMap = new HashMap<>();
		List<BltnbVO> replList = (List<BltnbVO>)defaultDao.selectList("opnt.basic.mapper.BltnbMngMapper.selectReplOfReplList", searchVO); 
		returnMap.put("returnData", replList);
		
		return ResponseEntity.ok(returnMap);
    }
    
    /** QNA 비밀번호 체크 **/
     public ResponseEntity getPswdCheck(BltnbVO searchVO , BindingResult result ){
          
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		HashMap<String, Object> returnMap = new HashMap<>(); 
		returnMap.put("check", this.bltnbPwsdCheck(searchVO));
		return ResponseEntity.ok(returnMap);
    }
    
    public boolean bltnbPwsdCheck(BltnbVO searchVO){
      // 비밀번호 조회
        BltnbVO resultVo = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.getBltnbPswd", searchVO);
         
		// 비밀번호 일치여부 판단
		return encryptUtil.matchBCrypt(searchVO.getBltnbPswd(), resultVo.getBltnbPswd());
    }
    
    
    public ResponseEntity getPostProc1(BltnbVO searchVO ,BindingResult result ,String menuCd , String path1 ){
       return getPostProc(searchVO, result, menuCd, path1); 
    }
    
    public ResponseEntity getPostProc2(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
       return getPostProc(searchVO, result, menuCd, path1);   
    }
    
     public ResponseEntity getPostProc3(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
       	return getPostProc(searchVO, result, menuCd, path1); 
    }
    
     public ResponseEntity getPostProc4(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
        return getPostProc(searchVO, result, menuCd, path1); 
    }
    
    private ResponseEntity getPostProc(BltnbVO searchVO , BindingResult result , String menuCd , String path1){
    	
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		//menuCd 넣기
		searchVO.setMenuCd(menuCd);
		// bltnb 구분값 가져오기
		searchVO.setBltnbCl(inqBltnbCl(menuCd));
		// 관리자/사용자 구분
		searchVO.setPath1(path1);
		
		//insert
		defaultDao.insert("opnt.basic.mapper.BltnbMngMapper.insertContents",searchVO); 
		
		//insert 완료후
		HashMap<String, Object> returnMap = new HashMap<>();
		returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		returnMap.put("returnUrl", "list.do");

		return ResponseEntity.ok(returnMap);
    
    } 
    
    public ResponseEntity getPatchProc1(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
		 return getPatchProc(request, searchVO, result, menuCd , path1);
    }
    
    public ResponseEntity getPatchProc2(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
         return getPatchProc(request, searchVO, result, menuCd , path1); 
    } 
    
    public ResponseEntity getPatchProc3(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
		 return getPatchProc(request, searchVO, result, menuCd , path1);		  
    } 
    
    public ResponseEntity getPatchProc4(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
		return getPatchProc(request, searchVO, result, menuCd , path1); 
    }
    
    private ResponseEntity getPatchProc(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1){
			if(result.hasErrors()) {
				List<ObjectError> errors = result.getAllErrors();
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
			}
			
			int resultCnt = 0;
			HashMap<String, Object> returnMap = new HashMap<>();
			HttpSession session = request.getSession();
			
			// 관리자/사용자 구분 담기
			searchVO.setPath1(path1);
			// 관리자권한이 있거나 사용자가 작성자 본인일때만 update
			if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
				//menuCd 넣기
				searchVO.setMenuCd(menuCd);
				// bltnb 구분값 가져오기
				searchVO.setBltnbCl(inqBltnbCl(menuCd));
				resultCnt =  defaultDao.update("opnt.basic.mapper.BltnbMngMapper.updateContents",searchVO);
				  
				if(resultCnt > 0) {
					returnMap.put("message", messageSource.getMessage("update.message", null, null));
					returnMap.put("returnUrl", "view.do");
					// faq는 list로 return
					if("fa".equals(searchVO.getBltnbCl())){
						returnMap.put("returnUrl", "list.do");
					}
				} else {
					returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
					returnMap.put("returnUrl", "updateForm.do");
				}
			}else {
				returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
				returnMap.put("returnUrl", "list.do");
			} 
			return ResponseEntity.ok(returnMap);
    }
    
    
    
    public ResponseEntity getDeleteProc1(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
        return getDeleteProc(request, searchVO, result, menuCd , path1);
    }
    
    public ResponseEntity getDeleteProc2(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
        return getDeleteProc(request, searchVO, result, menuCd , path1);
    }
    
    public ResponseEntity getDeleteProc3(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
		return getDeleteProc(request, searchVO, result, menuCd , path1);
    }
    
    public ResponseEntity getDeleteProc4(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
		return getDeleteProc(request, searchVO, result, menuCd , path1); 
    }  
    
    private ResponseEntity getDeleteProc(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1){
			 if(result.hasErrors()) {
					List<ObjectError> errors = result.getAllErrors();				
					return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
				}
				
				int resultCnt = 0;
				HashMap<String, Object> returnMap = new HashMap<>();
				HttpSession session = request.getSession();
				
				// 관리자/사용자 구분 담기
				searchVO.setPath1(path1);
				// 관리자권한이 있거나 사용자가 작성자 본인일때만 delete
				if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
					//menuCd 넣기
					searchVO.setMenuCd(menuCd);
					
					// bltnb 구분값 가져오기
					searchVO.setBltnbCl(inqBltnbCl(menuCd));
					resultCnt =  defaultDao.delete("opnt.basic.mapper.BltnbMngMapper.deleteContents",searchVO);
					
					if(resultCnt > 0) {
						returnMap.put("message", messageSource.getMessage("delete.message", null, null));
						returnMap.put("returnUrl", "list.do");
					} else {
						returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
						returnMap.put("returnUrl", "view.do");
					}
				}else {
					returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
					returnMap.put("returnUrl", "list.do");
				}
				
				return ResponseEntity.ok(returnMap);
     }
    
    
    public ResponseEntity getInsertRepl1(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
		 return getInsertRepl(searchVO, result, menuCd, path1);
    }   
    
    public ResponseEntity getInsertRepl2(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
		 return getInsertRepl(searchVO, result, menuCd, path1); 
    }
     
    public ResponseEntity getInsertRepl3(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
		return getInsertRepl(searchVO, result, menuCd, path1);
    } 
    
    public ResponseEntity getInsertRepl4(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
		return getInsertRepl(searchVO, result, menuCd, path1);  
    } 
    
    private ResponseEntity getInsertRepl(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    		
    		if(result.hasErrors()) {
				List<ObjectError> errors = result.getAllErrors();
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
			}
			
			HashMap<String, Object> returnMap = new HashMap<>();
			// 관리자/사용자 구분
			searchVO.setPath1(path1);
			int resultCnt = defaultDao.insert("opnt.basic.mapper.BltnbMngMapper.insertReplContents",searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("insert.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
			}
			
			return ResponseEntity.ok(returnMap);
    }
    
    
    public ResponseEntity getUpdateRepl1(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	return getUpdateRepl(request, searchVO, result ,  menuCd , path1 );  
    }
    
    public ResponseEntity getUpdateRepl2(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	return getUpdateRepl(request, searchVO, result ,  menuCd , path1 );  
    }
    
    public ResponseEntity getUpdateRepl3(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	 return getUpdateRepl(request, searchVO, result ,  menuCd , path1 );  
    }
    
    public ResponseEntity getUpdateRepl4(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
    	 return getUpdateRepl(request, searchVO, result ,  menuCd , path1 ); 
    }
    
    private ResponseEntity getUpdateRepl(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		 
		HashMap<String, Object> returnMap = new HashMap<>();
		HttpSession session = request.getSession();
		
		// 관리자/사용자 구분		
		searchVO.setPath1(path1);
		// 관리자권한이 있거나 사용자가 작성자 본인일때만 update
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrReplCheck(searchVO)) { 
			int resultCnt = defaultDao.insert("opnt.basic.mapper.BltnbMngMapper.updateReplContents",searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
		}else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
		
		return ResponseEntity.ok(returnMap); 
    }
    
    
    
    public ResponseEntity getDeleteRepl1(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	 return getDeleteRepl(request, searchVO , result, menuCd, path1); 
    }
    
    public ResponseEntity getDeleteRepl2(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	return getDeleteRepl(request, searchVO , result, menuCd, path1); 
    }
    
    
    public ResponseEntity getDeleteRepl3(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	return getDeleteRepl(request, searchVO , result, menuCd, path1);
    } 
    
    public ResponseEntity getDeleteRepl4(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	 return getDeleteRepl(request, searchVO , result, menuCd, path1); 
    }
    
    private ResponseEntity getDeleteRepl(HttpServletRequest request, BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		 
		HashMap<String, Object> returnMap = new HashMap<>();
		HttpSession session = request.getSession();
		
		// 관리자/사용자 구분		
		searchVO.setPath1(path1);
		// 관리자권한이 있거나 사용자가 작성자 본인일때만 delete
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrReplCheck(searchVO)) { 
			int resultCnt = defaultDao.insert("opnt.basic.mapper.BltnbMngMapper.deleteReplContents",searchVO);	
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			}
		}else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
		
		return ResponseEntity.ok(returnMap);
    }
    
    
    
    public ResponseEntity getInsertLike1(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	 return getInsertLike(searchVO, result, menuCd, path1); 
    } 
    
    public ResponseEntity getInsertLike2(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	return getInsertLike(searchVO, result, menuCd, path1); 
    }
    
    
    public ResponseEntity getInsertLike3(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	 return getInsertLike(searchVO, result, menuCd, path1);
    }
    
    
     public ResponseEntity getInsertLike4(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	 return getInsertLike(searchVO, result, menuCd, path1);
    }
    
     private ResponseEntity getInsertLike(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
      
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>();
		defaultDao.insert("opnt.basic.mapper.BltnbMngMapper.insertLikeContents",searchVO); 
		int rmcdSerno = Integer.parseInt(searchVO.getRcmdSerno());
		if(rmcdSerno > 0) {
			returnMap.put("rmcdSerno", rmcdSerno);
		}

		return ResponseEntity.ok(returnMap);
     
     }
    
    
     public ResponseEntity getUpdatelike1(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
     	return getUpdatelike(searchVO, result, menuCd, path1);
     } 
    
     public ResponseEntity getUpdatelike2(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
     	return getUpdatelike(searchVO, result, menuCd, path1);
     } 
    
     public ResponseEntity getUpdatelike3(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
     	return getUpdatelike(searchVO, result, menuCd, path1);
     } 
    
    
     public ResponseEntity getUpdatelike4(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
     	return getUpdatelike(searchVO, result, menuCd, path1); 
     } 
    
     private ResponseEntity getUpdatelike(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){
    	if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>(); 
		int effCnt = defaultDao.update("opnt.basic.mapper.BltnbMngMapper.updateLikeContents",searchVO);
		returnMap.put("effCnt", effCnt); 
		return ResponseEntity.ok(returnMap);
     }
    
    
    
     public ResponseEntity getDeletelike1(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
     	return getDeletelike(searchVO, result, menuCd, path1); 
     } 
    
    
     public ResponseEntity getDeletelike2(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
     	return getDeletelike(searchVO, result, menuCd, path1); 
     } 
    
     public ResponseEntity getDeletelike3(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
     	return getDeletelike(searchVO, result, menuCd, path1);  
     } 
    
    
     public ResponseEntity getDeletelike4(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
     	return getDeletelike(searchVO, result, menuCd, path1); 
     } 
    
     private ResponseEntity getDeletelike(BltnbVO searchVO , BindingResult result , String menuCd , String path1 ){ 
    	if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> returnMap = new HashMap<>(); 
		int effCnt = defaultDao.update("opnt.basic.mapper.BltnbMngMapper.deleteLikeContents",searchVO);
		returnMap.put("effCnt", effCnt);  
		return ResponseEntity.ok(returnMap);
     } 
     
     
     public ModelAndView getExcelDownload1(BltnbVO searchVO , Model model , String menuCd , String path1 ){ 
     	return getExcelDownload(searchVO, model, menuCd, path1); 
     }   
     
     public ModelAndView getExcelDownload2(BltnbVO searchVO , Model model , String menuCd , String path1 ){ 
     	return getExcelDownload(searchVO, model, menuCd, path1); 
     } 
     
     public ModelAndView getExcelDownload3(BltnbVO searchVO , Model model , String menuCd , String path1 ){ 
     	return getExcelDownload(searchVO, model, menuCd, path1); 
     } 
     
     public ModelAndView getExcelDownload4(BltnbVO searchVO , Model model , String menuCd , String path1 ){ 
     	return getExcelDownload(searchVO, model, menuCd, path1); 
     } 
     
     private ModelAndView getExcelDownload(BltnbVO searchVO , Model model , String menuCd , String path1 ){
     	
		
			ModelAndView mav = new ModelAndView(excelView);
			
			searchVO.setMenuCd(menuCd);
			// bltnb 구분값 가져오기
			searchVO.setBltnbCl(inqBltnbCl(menuCd));
			defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.selectMenuNm" , searchVO);
			String menuNm = menuService.selectMenuNm(menuCd);
			String url = "";
			
			String tit = "";
			if(!StringUtils.isEmpty(menuNm)) {
				tit = menuNm + "목록";
			}
			if(!StringUtils.isEmpty(searchVO.getBltnbCl())) {
				if("bd".equals(searchVO.getBltnbCl())){
					 url = "/standard/bltnb/bltnbBdList.xlsx";
				}else if("nt".equals(searchVO.getBltnbCl())){
					 url = "/standard/bltnb/bltnbNtList.xlsx";
				}else if("gr".equals(searchVO.getBltnbCl())){
					 url = "/standard/bltnb/bltnbGrList.xlsx";
				}else if("fa".equals(searchVO.getBltnbCl())){
					 url = "/standard/bltnb/bltnbFaList.xlsx";
				}else if("qa".equals(searchVO.getBltnbCl())){
					 url = "/standard/bltnb/bltnbQaList.xlsx";
				}
			}
			List<BltnbVO> resultList = (List<BltnbVO>)defaultDao.selectList("basic.BltnbMngMapper.selectExcelList" , searchVO);
			  
			//HTML 태그 제거
			String regEx = "<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
			for(BltnbVO vo : resultList) {
				vo.setBltnbCtt(vo.getBltnbCtt().replaceAll(regEx, ""));
			}
			
			mav.addObject("target", tit);
			mav.addObject("source", url);
			mav.addObject("resultList", resultList);
			
			return mav;
     } 
    
     public boolean regrCheck(BltnbVO searchVO ){  
    	BltnbVO resultVo = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.regrCheck", searchVO);
    	return resultVo.getIsRegrChecked() == 1 ? true : false; 
     }
    
     public boolean regrReplCheck(BltnbVO searchVO ){
    	BltnbVO resultVo = (BltnbVO)defaultDao.selectOne("opnt.basic.mapper.BltnbMngMapper.regrReplCheck", searchVO);
    	return resultVo.getIsRegrReplChecked() == 1 ? true : false; 
     }
    
}
