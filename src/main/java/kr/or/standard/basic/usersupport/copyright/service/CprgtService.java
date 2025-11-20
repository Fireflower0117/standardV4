package kr.or.standard.basic.usersupport.copyright.service;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.usersupport.copyright.vo.CprgtVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import java.util.HashMap;

@Service
@Transactional
@RequiredArgsConstructor
public class CprgtService extends EgovAbstractServiceImpl  {
    
    
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    
    private final String sqlNs = "com.standard.mapper.usersupport.CprgtMngMapper.";
    
    
    public void form(Model model){
        
		CprgtVO cprgtVO = new CprgtVO();
		
		// 저작권 있는경우 조회
		CprgtVO rtnVo = (CprgtVO)defaultDao.selectOne(sqlNs+"selectCount"); 
		if(Integer.parseInt(rtnVo.getCprgtCount()) > 0) { 
		     cprgtVO = (CprgtVO)defaultDao.selectOne(sqlNs+"selectOne"); 
		}
		model.addAttribute("cprgtVO", cprgtVO); 
    }
    
    public CommonMap insertProc(CprgtVO searchVO, BindingResult result){
		CommonMap returnMap = new CommonMap();
		
		CprgtVO rtnVo = (CprgtVO)defaultDao.selectOne(sqlNs+"selectCount"); 
		if(Integer.parseInt(rtnVo.getCprgtCount()) > 0) {
			returnMap.put("message", "등록된 저작권이 존재합니다. \n관리자에게 문의하세요.");
		}else {
		    int resultCnt = defaultDao.insert(sqlNs+"insertContents", searchVO); 
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("insert.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
			}
		}
		returnMap.put("returnUrl", "form.do");
		return returnMap;
    }
    
     public CommonMap updateProc(CprgtVO searchVO, BindingResult result){ 
		CommonMap returnMap = new CommonMap();
		 
		int resultCnt = defaultDao.update(sqlNs+"updateContents" , searchVO);
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		} 
		returnMap.put("returnUrl", "form.do");
		return returnMap;
     }
    
    
    
	// 저작권 건수 조회
	/*public int selectCount() {
		return cprgtMngMapper.selectCount();
	}*/
	
	// 저작권 단건 조회
	/*public CprgtVO selectOne() {
		return cprgtMngMapper.selectOne();
	}*/

	// 저작권 등록
	/*public int insertContents(CprgtVO vo) {
		return cprgtMngMapper.insertContents(vo);
	}*/

	// 저작권 수정
	/*public int updateContents(CprgtVO vo) {
		return cprgtMngMapper.updateContents(vo);
	}*/
}
