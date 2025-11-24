package kr.or.standard.basic.usersupport.dictionary.domain.service;

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.module.ExcelUtil;
import kr.or.standard.basic.usersupport.dictionary.domain.vo.DomainVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Validator;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class DomainService extends EgovAbstractServiceImpl  {
	 
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    private final Validator validator;
    private final ExcelUtil excelUtil;
    private final FileService fileService;
    	 
    private final String sqlNs = "com.standard.mapper.usersupport.DmnMngMapper.";
    
    public void addList(DomainVO searchVO, Model model) throws Exception {
        
        
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
        DomainVO rtnVo = (DomainVO)defaultDao.selectOne(sqlNs+"selectCount",searchVO);
        int dmnomainCount = Integer.parseInt(rtnVo.getDmnCount());  
		paginationInfo.setTotalRecordCount(dmnomainCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<DomainVO> resultList = (List<DomainVO>)defaultDao.selectList(sqlNs+"selectList",searchVO); 
		model.addAttribute("resultList", resultList);
    }
    
    public void view(DomainVO searchVO, Model model){
    	DomainVO cmDmnVO = (DomainVO)defaultDao.selectOne(sqlNs+"selectContents",searchVO ); 
		model.addAttribute("cmDmnVO", cmDmnVO);
    }
    
    public String form(DomainVO searchVO, Model model, String procType, HttpSession session){
		DomainVO cmDmnVO = new DomainVO(); 

		if("update".equals(procType)) {
			// 관리자가 아닌 경우
			if(!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
				return "redirect:list.do";
			}

			// 일련번호 없는 경우
			if(StringUtils.isEmpty(searchVO.getDmnSerno())) {
				return "redirect:list.do";
			}
			cmDmnVO = (DomainVO)defaultDao.selectOne(sqlNs+"selectContents",searchVO); 
		}

		model.addAttribute("cmDmnVO", cmDmnVO);
		return "";
    }
    
    	
    public CommonMap insertProc(DomainVO searchVO, BindingResult result, HttpSession session){
    	
		CommonMap returnMap = new CommonMap(); 

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}
		
		int resultCnt = defaultDao.insert(sqlNs+"insertContents",searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		returnMap.put("returnUrl", "list.do");
		return returnMap;

    }
    
    public CommonMap updateProc(DomainVO searchVO, BindingResult result, HttpSession session){
		CommonMap returnMap = new CommonMap(); 
		
		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		} 
		
		int resultCnt = defaultDao.update(sqlNs+"updateContents",searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		returnMap.put("returnUrl", "view.do");
		return returnMap;
    }
    
    public CommonMap deleteProc(DomainVO searchVO, BindingResult result, HttpSession session){
    	
		CommonMap returnMap = new CommonMap();

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}
		
		int resultCnt = defaultDao.delete(sqlNs+"deleteContents",searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} else {
			returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			returnMap.put("returnUrl", "view.do");
		}
		
		return returnMap;
    }
    
    public ModelAndView excelDownload(DomainVO searchVO){
    
    	
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "도메인목록";
		String url = "/standard/usersupport/dmnList.xlsx";
		 
		List<DomainVO> resultList = (List<DomainVO>)defaultDao.selectList(sqlNs+"selectExcleList",searchVO); 

		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		return mav;
    }
    
    
	// 도메인 건수 조회
	/*public int selectCount(DomainVO vo) {
		return dmnMngMapper.selectCount(vo);
	};*/

	// 도메인 목록 조회
	/*public List<DomainVO> selectList(DomainVO vo) {
		return dmnMngMapper.selectList(vo);
	};*/

	// 도메인 상세 조회
	/*public DomainVO selectContents(DomainVO vo) {
		return dmnMngMapper.selectContents(vo);
	};*/

	// 도메인 등록
	/*public int insertContents(DomainVO vo) {
		return dmnMngMapper.insertContents(vo);
	};*/

	// 도메인 수정
	/*public int updateContents(DomainVO vo) {
		return dmnMngMapper.updateContents(vo);
	};*/

	// 도메인 삭제
	/*public int deleteContents(DomainVO vo) {
		return dmnMngMapper.deleteContents(vo);
	};*/

	// 도메인 목록 엑셀 조회
	/*public List<DomainVO> selectExcleList(DomainVO vo) {
		return dmnMngMapper.selectExcleList(vo);
	};*/

}
