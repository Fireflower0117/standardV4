package kr.or.standard.basic.component.regcd.controller;

 
import kr.or.standard.basic.component.regcd.service.CmRegCdService;
import kr.or.standard.basic.component.regcd.vo.CmRegCdVO;
import lombok.RequiredArgsConstructor; 
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 


@Controller
@RequiredArgsConstructor
@PropertySource("classpath:component.properties")
public class CmRegCdController {
    
    private final CmRegCdService cmRegCdService;
    
    
    private final String URL_PATH = "${cm_regCd.folder-path}"; 
	private final String CM_FOLDER_PATH = "/component/cm_regCd/";
     
	@RequestMapping(URL_PATH + "list.do")
	/* /ma/sys/dm/regCd/list.do */
	public String list(@ModelAttribute("searchVO") CmRegCdVO searchVO, Model model) {
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}

	@RequestMapping(URL_PATH + "addList.do")
	/* /ma/sys/dm/regCd/addList.do */
	public String addList(@ModelAttribute("searchVO") CmRegCdVO searchVO, Model model) throws Exception {
        
        cmRegCdService.addList(searchVO , model);
        return CM_FOLDER_PATH + "addList";
	}

	// 시도 시군구 읍면동 리 select box용
	@RequestMapping(URL_PATH + "get{menuTp:SIDO|CGG|UMD|RI}RegData")
	public String cmmnRegJsp(@ModelAttribute("searchVO") CmRegCdVO searchVO, Model model, @PathVariable String menuTp) throws Exception { 
		cmRegCdService.cmmnRegJsp(searchVO, model , menuTp); 
		return CM_FOLDER_PATH + "regList";
	}

	/** 법정동 갱신 */
	@ResponseBody
	@RequestMapping(URL_PATH +"regUpdate")
	public String regUpdate(){ 
		return cmRegCdService.regUpdate();  
	}

	/* Excel - 대용량 엑셀 다운로드 */
	@RequestMapping(URL_PATH + "bigExcelDownload.do")
	/* /ma/sys/regeps/bigExcelDownload.do */
	public void bigExcelDownload(@ModelAttribute("searchVO") CmRegCdVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception { 
		cmRegCdService.bigExcelDownload(searchVO, request, response);	 
	} 

}
