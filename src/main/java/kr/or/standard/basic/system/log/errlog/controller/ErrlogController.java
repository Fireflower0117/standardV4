package kr.or.standard.basic.system.log.errlog.controller;
 
 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.system.log.errlog.vo.ErrlogVO;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
 

import kr.or.standard.basic.system.log.errlog.service.ErrlogService;
import lombok.RequiredArgsConstructor; 

@Controller
@RequiredArgsConstructor
public class ErrlogController {
    
    private final ErrlogService errlogService; 
    
	private final String FOLDER_PATH = "/ma/sys/log/errlog/";

	@RequestMapping(FOLDER_PATH + "list.do")
	/* /ma/sys/errlog/list.do */
	public String list(@ModelAttribute("searchVO") ErrlogVO searchVO, Model model){ 
        errlogService.list(model); 
		return ".mLayout:" + FOLDER_PATH + "list";
	}

	@RequestMapping(FOLDER_PATH + "addList.do")
	/* /ma/sys/log/errlog/addList.do */
	public String addList(@ModelAttribute("searchVO") ErrlogVO searchVO, Model model) throws Exception{ 
        errlogService.addList(searchVO, model); 
		return FOLDER_PATH + "addList";
	}

	@RequestMapping(FOLDER_PATH + "view.do")
	/* /ma/sys/log/errlog/view.do */
	public String view(@ModelAttribute("searchVO") ErrlogVO searchVO, Model model){ 
        errlogService.view(searchVO, model);  
		return ".mLayout:" + FOLDER_PATH + "view";
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(FOLDER_PATH + "excelDownload.do")
	/* /ma/sys/log/errlog/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") ErrlogVO searchVO) { 
        return errlogService.excelDownload(searchVO); 
	}
    
    
}
