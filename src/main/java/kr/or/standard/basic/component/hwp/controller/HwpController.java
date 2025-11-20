package kr.or.standard.basic.component.hwp.controller;
 
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.component.hwp.service.HwpService; 
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
 
@Controller
@PropertySource("classpath:component.properties")
@RequiredArgsConstructor
public class HwpController {

    private final HwpService hwpService;  
    private final String URL_PATH = "${cm_hwp.folder-path}";
    private final String CM_FOLDER_PATH = "/component/cm_hwp/";
     
    @RequestMapping(URL_PATH + "list.do")
    /* /ma/us/hwp/list.do */
    public String list(@ModelAttribute("searchVO") CmmnDefaultVO searchVO) {
        return ".mLayout:" + CM_FOLDER_PATH + "list";
    }

    @RequestMapping(URL_PATH + "addList.do")
    /* /ma/us/hwp/addList.do */
    public String addList(@ModelAttribute("searchVO") UserVO searchVO, Model model) throws Exception { 
        hwpService.addList(searchVO , model);  
        return CM_FOLDER_PATH + "addList";
    }

    @RequestMapping(value = URL_PATH + "hwpView{downType:.do|Down}", method = RequestMethod.POST)
    /* /ma/us/hwp/hwpView.do | /ma/us/hwp/hwpViewDown */
    public String hwpView(@ModelAttribute("searchVO") UserVO searchVO, @PathVariable String downType, Model model) {
        hwpService.hwpView(searchVO, downType , model); 
        return CM_FOLDER_PATH + "hwpView";
    }
    
    
     
    @ResponseBody
    @RequestMapping(URL_PATH + "hwplibDown") 
    // /ma/us/hwp/hwplibDown
    public void hwpDown(){ 
        hwpService.run(); 
    } 
    
}
