package kr.or.standard.basic.usersupport.dictionary.word.service;

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.module.ExcelUtil;
import kr.or.standard.basic.usersupport.dictionary.domain.vo.DomainVO;
import kr.or.standard.basic.usersupport.dictionary.word.vo.WordVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Validator;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class WordService extends EgovAbstractServiceImpl {
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    private final Validator validator;
    private final ExcelUtil excelUtil;
    private final FileService fileService;
    
    private final String sqlNs = "com.standard.mapper.usersupport.WrdMngMapper.";
    
    
    public void addList(WordVO searchVO, Model model)throws Exception{
         
	    PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
	    WordVO rtnVo = (WordVO)defaultDao.selectOne(sqlNs+"selectCount",searchVO);
        int wordCount = Integer.parseInt(rtnVo.getWrdCount()); 
		paginationInfo.setTotalRecordCount(wordCount);
		model.addAttribute("paginationInfo", paginationInfo);
        
        List<WordVO> resultList = (List<WordVO>)defaultDao.selectList(sqlNs+"selectList",searchVO); 
		model.addAttribute("resultList", resultList);
    
    }
    
    public void view(WordVO searchVO, Model model){ 
        WordVO cmWrdVO = (WordVO)defaultDao.selectOne( sqlNs+"selectContents", searchVO); 
		model.addAttribute("cmWrdVO", cmWrdVO);
    }
    
    public String form(WordVO searchVO, Model model, String procType, HttpSession session){
        
		WordVO cmWrdVO = new WordVO(); 

		if("update".equals(procType)) {
			// 관리자가 아닌 경우
			if(!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
				return "redirect:list.do";
			}

			// 일련번호 없는 경우
			if(StringUtils.isEmpty(searchVO.getWrdSerno())) {
				return "redirect:list.do";
			}
			
			cmWrdVO = (WordVO)defaultDao.selectOne(sqlNs+"selectContents", searchVO); 
		} 
		model.addAttribute("cmWrdVO", cmWrdVO);
		return "";
    }
    
    public CommonMap insertProc(WordVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap();

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}

      int resultCnt = defaultDao.insert(sqlNs+"insertContents", searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		returnMap.put("returnUrl", "list.do");
		return returnMap; 
    }
    
    public CommonMap updateProc(WordVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap();

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}

        int resultCnt = defaultDao.update(sqlNs+"updateContents", searchVO);  
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		returnMap.put("returnUrl", "view.do");
		return returnMap;
    }
    
    public CommonMap deleteProc(WordVO searchVO, BindingResult result, HttpSession session){
		CommonMap returnMap = new CommonMap();

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}
 
        int resultCnt = defaultDao.delete(sqlNs+"deleteContents", searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} else {
			returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			returnMap.put("returnUrl", "view.do");
		}
		return returnMap; 
    }
    
    public ModelAndView excelDownload(WordVO searchVO){
    	
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "단어목록";
		String url = "/standard/usersupport/wordList.xlsx";
		 
		List<WordVO> resultList = (List<WordVO>)defaultDao.selectList(sqlNs+"selectExcleList",searchVO); 
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
    }

    
	// 단어 건수 조회
	/*public int selectCount(WordVO vo) {
		return wrdMngMapper.selectCount(vo);
	};*/

	// 단어 목록 조회
	/*public List<WordVO> selectList(WordVO vo) {
		return wrdMngMapper.selectList(vo);
	};*/

	// 단어 상세 조회
	/*public WordVO selectContents(WordVO vo) {
		return wrdMngMapper.selectContents(vo);
	};*/

	// 단어 등록
	/*public int insertContents(WordVO vo) {
		return wrdMngMapper.insertContents(vo);
	};*/

	// 단어 수정
	/*public int updateContents(WordVO vo) {
		return wrdMngMapper.updateContents(vo);
	};*/

	// 단어 삭제
	/*public int deleteContents(WordVO vo) {
		return wrdMngMapper.deleteContents(vo);
	};*/

	// 단어 목록 엑셀 조회
	/*public List<WordVO> selectExcleList(WordVO vo) {
		return wrdMngMapper.selectExcleList(vo);
	};*/
}
