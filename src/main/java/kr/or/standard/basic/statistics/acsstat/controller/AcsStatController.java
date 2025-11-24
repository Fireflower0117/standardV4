package kr.or.standard.basic.statistics.acsstat.controller;

 
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.statistics.acsstat.service.AcsStatService;
import kr.or.standard.basic.statistics.acsstat.vo.AcsStatVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AcsStatController {
    
    private final AcsStatService acsStatService;
    
    private final String URL_PATH = "/ma/stat/acsStat/";

    @RequestMapping(URL_PATH + "list.do")
    /* /ma/stat/acsStat/list.do */
    public String list(@ModelAttribute("searchVO") AcsStatVO searchVO) {
        return ".mLayout:" + URL_PATH + "list";
    }

    @ResponseBody
    @PostMapping(URL_PATH + "getAcsStat")
    /* /ma/stat/acsStat/getAcsStat */
    public ResponseEntity<?> getAcsStat(AcsStatVO vo) {
        
       CommonMap returnMap =  acsStatService.getAcsStat(vo); 
        return ResponseEntity.ok(returnMap);
    }

    // 회원 리스트 팝업
    @RequestMapping(URL_PATH + "userList.do")
    /* /ma/stat/acsStat/userList.do */
    public String userList(@ModelAttribute("searchVO") AcsStatVO searchVO) {
        return URL_PATH + "userList";
    }

    // 회원 리스트
    @RequestMapping(URL_PATH + "userAddList.do")
    /* /ma/stat/acsStat/userAddList.do */
    public String userAddList(@ModelAttribute("searchVO") AcsStatVO searchVO, Model model) throws Exception { 
        acsStatService.userAddList(searchVO, model); 
        return URL_PATH + "userAddList";
    }
}
