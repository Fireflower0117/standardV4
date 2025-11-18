package kr.or.standard.basic.system.cmmn.service;

import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.code.service.CodeService;
import kr.or.standard.basic.system.code.vo.CodeVO;
import kr.or.standard.basic.system.regeps.service.RegepsService;
import kr.or.standard.basic.system.regeps.vo.RegepsVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import java.util.HashMap;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class CmmnService extends EgovAbstractServiceImpl {
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final RegepsService regepsService; 
	private final CodeService codeService; 
    
    public CommonMap getRegeps(RegepsVO searchVO){
        	
    	CommonMap returnMap = new CommonMap();
    	boolean chk = false;
    	
    	if(StringUtils.isEmpty(searchVO.getRegepsId())) {
    		returnMap.put("chk", chk);
    		return returnMap;
    	}
    	
    	RegepsVO regepsVO = regepsService.selectIdContents(searchVO);
    	
    	if(regepsVO != null) {
    		if(!StringUtils.isEmpty(regepsVO.getRegepsSerno())) {
    			chk = true;
    			returnMap.put("placeMsg", regepsVO.getPlaceholderTxt());
    			returnMap.put("regex", regepsVO.getRegepsTxt());
    			returnMap.put("errMsg", regepsVO.getErrMsg());
    		}
    	} 
    	
    	returnMap.put("chk", chk);
    	return returnMap; 
    }
    
    public void getCode(CodeVO searchVO, ModelMap model){
    	List<CodeVO> codeList = codeService.selectList(searchVO);
        model.addAttribute("codeList", codeList);
    }
}
