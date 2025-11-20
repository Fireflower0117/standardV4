package kr.or.standard.basic.usersupport.relsite.service;

import java.util.HashMap;
import java.util.List;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.usersupport.relsite.vo.RelSiteVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

@Service
@Transactional
@RequiredArgsConstructor
public class RelSiteService extends EgovAbstractServiceImpl{
 
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    
    private final String sqlNs = "com.standard.mapper.usersupport.RelSiteMngMapper.";
    
    public void form(Model model){ 
        List<RelSiteVO.RelSite> resultList = (List<RelSiteVO.RelSite>)defaultDao.selectList(sqlNs+"selectList"); 
		model.addAttribute("resultList", resultList);
    }
    
    public CommonMap insertProc(RelSiteVO searchVO, BindingResult result){
         
		CommonMap returnMap = new CommonMap(); 
		int resultCnt = insertContents(searchVO);
			
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "form.do");
        return returnMap;
    }
    
    public CommonMap updateProc(RelSiteVO searchVO, BindingResult result){
        
		CommonMap returnMap = new CommonMap();
		
		int resultCnt = updateContents(searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "form.do");
		return returnMap;
    }
    
	// 관련사이트 건수 조회
	/*public int selectCount() {
		return relSiteMngMapper.selectCount();
	}*/
	
	// 관련사이트 목록 조회
	/*public List<RelSiteVO.RelSite> selectList() {
		return relSiteMngMapper.selectList();
	}*/

	// 관련사이트 등록
	public int insertContents(RelSiteVO vo) {
		
		int result = 0; 
		for(RelSiteVO.RelSite relSite : vo.getRelSiteList()) { 
			result += defaultDao.insert(sqlNs + "insertContents", relSite); 
		} 
		return result;
	}

	// 관련사이트 수정
	public int updateContents(RelSiteVO vo) {
		int result = 0;
		
		// 관련사이트 전체 삭제
		defaultDao.update(sqlNs + "deleteAllContents"); 
		for(RelSiteVO.RelSite relSite : vo.getRelSiteList()) {
			//relSite.setLoginSerno(vo.getLoginSerno()); 
			if(StringUtils.isEmpty(relSite.getRelSiteSerno())) {
			    result += defaultDao.insert(sqlNs + "insertContents", relSite);  
			} else {
			    result += defaultDao.update(sqlNs + "updateContents", relSite); 
			} 
		} 
		return result;
	}

}
