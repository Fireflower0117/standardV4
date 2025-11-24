package kr.or.standard.basic.component.dataqualiry.tableinspection.controller;

 
import kr.or.standard.basic.component.dataqualiry.dbdata.vo.DBdataVO;
import kr.or.standard.basic.component.dataqualiry.tableinspection.service.TblInspectionService;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequiredArgsConstructor
@PropertySource("classpath:component.properties")
public class TblInspectionController {

    private final TblInspectionService tblInspectionService; 

	private final String URL_PATH = "${cm_tblDgns.url-path}";
	private final String CM_FOLDER_PATH = "/component/cm_dbQlt/cm_tblDgns/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/dbQlt/tblDgns/list.do */
	public String list(@ModelAttribute("searchVO") DBdataVO searchVO) {
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/dbQlt/tblDgns/addList.do */
	public String addList(@ModelAttribute("searchVO") DBdataVO searchVO, Model model) throws Exception { 
        tblInspectionService.addList(searchVO, model);  
		return CM_FOLDER_PATH + "addList";
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/dbQlt/tblDgns/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") DBdataVO searchVO) { 
        return tblInspectionService.excelDownload(searchVO);   
	}
    
    
}
