package kr.or.standard.basic.component.dataqualiry.dbdata.controller;
 
import kr.or.standard.basic.component.dataqualiry.dbdata.service.DBdataService;
import kr.or.standard.basic.component.dataqualiry.dbdata.vo.DBdataVO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequiredArgsConstructor
@PropertySource("classpath:component.properties")
public class DBdataController {
    
    private final DBdataService dbdataService;
     
	private static final String URL_PATH = "${cm_dbData.url-path}";
	private static final String CM_FOLDER_PATH = "/component/cm_dbQlt/cm_dbData/";
	
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/us/dbQlt/dbData/list.do */
	public String list(@ModelAttribute("searchVO") DBdataVO searchVO) {
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/us/dbQlt/dbData/addList.do */
	public String addList(@ModelAttribute("searchVO") DBdataVO searchVO, Model model) throws Exception {
        dbdataService.addList(searchVO, model); 
		return CM_FOLDER_PATH + "addList";
	}

	@RequestMapping(URL_PATH + "view.do")
	/* /ma/us/dbQlt/dbData/view.do */
	public String view(@ModelAttribute("searchVO") DBdataVO searchVO, Model model) { 
        dbdataService.view(searchVO, model); 
		return ".mLayout:" + CM_FOLDER_PATH + "view";
	}

	/* DB 테이블 데이터 조회 */
	@RequestMapping(URL_PATH + "dataList.do")
	/* /ma/us/dbQlt/dbData/dataList.do */
	public String dataList(@ModelAttribute("searchVO") DBdataVO searchVO, Model model) throws Exception {
        dbdataService.dataList(searchVO, model); 
		return CM_FOLDER_PATH + "dataList";
	}

	/* Excel - 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "excelDownload.do")
	/* /ma/us/dbQlt/dbData/excelDownload.do */
	public ModelAndView excelDownload(@ModelAttribute("searchVO") DBdataVO searchVO) { 
        return dbdataService.excelDownload(searchVO); 
	}

}
