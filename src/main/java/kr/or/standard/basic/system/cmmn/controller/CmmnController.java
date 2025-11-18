package kr.or.standard.basic.system.cmmn.controller;


import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.cmmn.service.CmmnService;
import kr.or.standard.basic.system.code.service.CodeService;
import kr.or.standard.basic.system.code.vo.CodeVO;
import kr.or.standard.basic.system.regeps.vo.RegepsVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CmmnController {
    
    private final CmmnService cmmnService;
    private final CodeService codeService;
    
	// 공통 정규표현식 유효성 검사
    @ResponseBody
    @PostMapping("/cmmn/getRegeps.do")
    public CommonMap getRegeps (RegepsVO searchVO) throws Exception { 
    	return cmmnService.getRegeps(searchVO); 
    }
    
 	
    //  권한부족 execute
    @RequestMapping("/cmmn/err")
    public String execute() {
    	return "/common/execute";
    }
    
    
    // 코드 리스트 호출
    @RequestMapping("/cmmn/getCode.do")
    public String getCode(@ModelAttribute("searchVO") CodeVO searchVO, ModelMap model) throws Exception { 
        cmmnService.getCode(searchVO ,model );  
        return "/common/code/codeTemp";
    } 

}
