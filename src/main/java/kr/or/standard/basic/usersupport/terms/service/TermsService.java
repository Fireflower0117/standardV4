package kr.or.standard.basic.usersupport.terms.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.usersupport.terms.vo.TermsVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;

@Service
@Transactional
@RequiredArgsConstructor
public class TermsService extends EgovAbstractServiceImpl  {
	 
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
	
	public void form(Model model, String menuId) {
        TermsVO termsVO = new TermsVO();
		termsVO.setSchEtc00(menuId);
		List<TermsVO.Terms> termsList =  (List<TermsVO.Terms>)defaultDao.selectList("com.opennote.standard.mapper.usersupport.TermsMngMapper.selectList", termsVO); 
		model.addAttribute("termsList", termsList);
    } 
    
    public CommonMap insertProc(TermsVO searchVO, String menuId, BindingResult result){
        		
		CommonMap returnMap = new CommonMap();
		  
		// 약관구분 세팅
		searchVO.setSchEtc00(menuId); 
		int resultCnt = insertAllContents(searchVO);
		
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "form.do");
		return returnMap;
    }
    
    
    
	// 약관 리스트 등록
	public int insertAllContents(TermsVO vo) {
		
		int result = 0;
		
		for(TermsVO.Terms tempTermsVO : vo.getTermsList()) {
			tempTermsVO.setLoginSerno(vo.getLoginSerno());
			tempTermsVO.setTermsClCd(vo.getSchEtc00());
			result += this.insertContents(tempTermsVO);
		}
		
		return result;
	} 
	
	
	
    
    public CommonMap updateProc(TermsVO searchVO, String menuId, BindingResult result){
        		
		
		CommonMap returnMap = new CommonMap();
		int resultCnt = 0;
		
		// 약관구분 세팅
		searchVO.setSchEtc00(menuId);
		resultCnt = updateAllContents(searchVO);
		
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		returnMap.put("returnUrl", "form.do");
		return returnMap;
    }
    
    // 약관 리스트 수정
	public int updateAllContents(TermsVO vo) {
		
		// 전체 약관 삭제
		this.deleteContents(vo);
		
		int result = 0;
		
		for(TermsVO.Terms tempTermsVO : vo.getTermsList()) {
			tempTermsVO.setLoginSerno(vo.getLoginSerno());
			tempTermsVO.setTermsClCd(vo.getSchEtc00());
			if(StringUtils.isEmpty(tempTermsVO.getTermsSerno())) {
				result += this.insertContents(tempTermsVO);
			}else {
				result += this.updateContents(tempTermsVO);
			}
		}

		return result;
		
	}
	
	// 약관 등록
	public int insertContents(TermsVO.Terms vo) {
	     return defaultDao.insert("com.opennote.standard.mapper.usersupport.TermsMngMapper.insertContents", vo); 
	}
	
	
	// 약관 수정
	public int updateContents(TermsVO.Terms vo) {
		return defaultDao.update("com.opennote.standard.mapper.usersupport.TermsMngMapper.updateContents", vo); 
	}
	
	// 약관 삭제
	public int deleteContents(TermsVO vo) {
	    return defaultDao.update("com.opennote.standard.mapper.usersupport.TermsMngMapper.deleteContents", vo); 
	}
     

	// 약관 건수 조회
	/*public int selectCount(TermsVO vo) {
		return termsMngMapper.selectCount(vo);
	}*/
	
	// 약관 목록 조회
	/*public List<TermsVO.Terms> selectList(TermsVO vo) {
		return termsMngMapper.selectList(vo);
	}*/ 
	
	
	

	

}
