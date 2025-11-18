package kr.or.standard.basic.system.logo.controller;

 
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.logo.service.LogoService;
import kr.or.standard.basic.system.logo.vo.LogoVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class LogoController {
    
    private final LogoService logoService;
    
    
    private final String URL_PATH = "/ma/sys/logo/";

    @RequestMapping(URL_PATH + "list.do")
    /* /ma/sys/logo/list.do */
    public String list(@ModelAttribute("searchVO") LogoVO searchVO, Model model){
        return ".mLayout:" + URL_PATH + "list";
    }

    @RequestMapping(URL_PATH + "addList.do")
    /* /ma/sys/logo/addList.do */
    public String addList(@ModelAttribute("searchVO") LogoVO searchVO, Model model) throws Exception{ 
        logoService.addList(searchVO, model); 
        return URL_PATH + "addList";
    }

    @RequestMapping(URL_PATH + "view.do")
    /* /ma/sys/logo.view.do */
    public String view(@ModelAttribute("searchVO") LogoVO searchVO, Model model){
        logoService.view(searchVO, model); 
        return ".mLayout:" + URL_PATH + "view";
    }

    @RequestMapping(URL_PATH + "{procType:insert|update}Form.do")
    /* /ma/sys/logo/insertForm.do, /ma/sys/logo/updateForm.do */
    public String Form(@ModelAttribute("searchVO") LogoVO searchVO, @PathVariable String procType, Model model, HttpSession session){
        
        String rtnUrl = logoService.insertUpdateForm(searchVO, procType, model, session);
        if(!"".equals(rtnUrl)){ return rtnUrl; }
        else { return ".mLayout:" + URL_PATH + "form"; } 
    }

    @ResponseBody
    @PostMapping(URL_PATH + "proc")
    /* /ma/sys/logo/proc */
    public ResponseEntity<?> insertProc(@Validated(LogoVO.inserCheck.class) @ModelAttribute("searchVO") LogoVO searchVO, BindingResult result){
        if(result.hasErrors()){
            List<ObjectError>  errors = result.getAllErrors();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }
    
        CommonMap returnMap = logoService.insertProc(searchVO , result); 
        return ResponseEntity.ok(returnMap);
    }

    @ResponseBody
    @PatchMapping(URL_PATH + "proc")
    /* /ma/sys/logo/proc */
    public ResponseEntity<?> updateProc(@Validated(LogoVO.updateCheck.class) @ModelAttribute("searchVO") LogoVO searchVO, BindingResult result, HttpSession session){
        if(result.hasErrors()){
            List<ObjectError> errors = result.getAllErrors();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }
        
        CommonMap returnMap = logoService.updateProc(searchVO , result, session); 
        return ResponseEntity.ok(returnMap);
    }

    @ResponseBody
    @DeleteMapping(URL_PATH + "proc")
    /* /ma/sys/logo/proc */
    public ResponseEntity<?> deleteProc(@ModelAttribute("searchVO") LogoVO searchVO, BindingResult result, HttpSession session){
        if(result.hasErrors()){
            List<ObjectError> errors = result.getAllErrors();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }
        
        CommonMap returnMap = logoService.deleteProc(searchVO , result, session); 
        return ResponseEntity.ok(returnMap);
    }

    /* 활성화 항목 중복 등록 판단 */
    @ResponseBody
    @RequestMapping(URL_PATH + "itmActvtYnChk")
    /* /ma/sys/logo/itmActvtYnChk */
    public ResponseEntity itmActvtYnChk(@ModelAttribute("searchVO") LogoVO logoVO, BindingResult result){
        if(result.hasErrors()){
            List<ObjectError> errors = result.getAllErrors();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }

        int cnt = logoService.itmActvtYnChk(logoVO); 
        return ResponseEntity.ok(cnt);
    }

    /* Excel - 엑셀 다운로드 */
    @RequestMapping(URL_PATH + "excelDownload.do")
    /* /ma/sys/regeps/excelDownload.do */
    public ModelAndView excelDownload(@ModelAttribute("searchVO") LogoVO searchVO, Model model) { 
        return logoService.excelDownload(searchVO, model); 
    }
        
}
