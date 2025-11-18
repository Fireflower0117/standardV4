package kr.or.standard.basic.system.log.acs.controller;

 
import kr.or.standard.basic.system.log.acs.service.AcsService;
import kr.or.standard.basic.system.log.acs.vo.AcsVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AcsController {
    
    private final AcsService acsService; 
    
    private final String URL_PATH = "/ma/sys/log/acs/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/sys/log/acs/list.do */
	public String list(@ModelAttribute("searchVO") AcsVO searchVO) { 
		return ".mLayout:" + URL_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/sys/log/acs/addList.do */
	public String addList(@ModelAttribute("searchVO") AcsVO searchVO, Model model) throws Exception { 
		acsService.addList(searchVO, model); 
		return URL_PATH + "addList";
	}

}
