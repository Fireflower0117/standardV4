package kr.or.standard.basic.system.seo.controller;


import java.util.List;

import kr.or.standard.basic.system.seo.service.SeoService;
import kr.or.standard.basic.system.seo.vo.SeoVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
 

@Controller
@RequiredArgsConstructor
public class SeoController { 
	
	private final SeoService seoService;  
	private final String FOLDER_PATH = "/ma/sys/seo/";

	@RequestMapping(FOLDER_PATH + "list.do")
	/* /seo/list.do */
	public String list(@ModelAttribute("searchVO") SeoVO searchVO) {
		return ".mLayout:" + FOLDER_PATH + "list";
	}
	
	
	@RequestMapping(FOLDER_PATH + "addList.do")
	/* /seo/addList.do */
	public String addList(@ModelAttribute("searchVO") SeoVO searchVO, Model model) throws Exception{ 
		seoService.addList(searchVO, model); 
		return FOLDER_PATH + "addList";
	}

	
	/* Excel - 엑셀 다운로드 */
	@RequestMapping(FOLDER_PATH + "excelDownload.do")
	/* /seo/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") SeoVO searchVO) throws Exception { 
		return seoService.excelDownload(searchVO); 
	}
	
	@RequestMapping(FOLDER_PATH + "view.do")
	/* /seo/view.do */
	public String view(@ModelAttribute("searchVO") SeoVO searchVO, Model model) throws Exception{
		seoService.view(searchVO , model); 
		return FOLDER_PATH + "view"; 
	}
	
	
	@RequestMapping(FOLDER_PATH + "subList.do")
	/* /seo/subList.do */
	public String subList(@ModelAttribute("searchVO") SeoVO searchVO){
		return FOLDER_PATH + "subList"; 
	}
	
	@RequestMapping(FOLDER_PATH + "subAddList.do")
	/* /seo/subAddList.do */
	public String subAddList(@ModelAttribute("searchVO") SeoVO searchVO, Model model) throws Exception{ 
		seoService.subAddList(searchVO, model); 
		return FOLDER_PATH + "subAddList"; 
	}
	
}
