package kr.or.standard.basic.common.internalviewresolver.controller;

import kr.or.standard.basic.common.internalviewresolver.service.OnNameViewService;
import kr.or.standard.basic.system.basic.service.BasicService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OnlNameViewController {

    private final OnNameViewService onNameViewService;

    @PostMapping("/ma/{page}.do")
    public String maPage0( @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("maPage0 /ma/{}.do", page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ma/{menuCd}/{page}.do")
    public String maPage1(@PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("maPage1 /ma/{}/{}.do", menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ma/{path1}/{menuCd}/{page}.do")
    public String maPage2(@PathVariable String path1, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("maPage2 /ma/{}/{}/{}.do", path1, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ma/{path1}/{path2}/{menuCd}/{page}.do")
    public String maPage3(@PathVariable String path1,@PathVariable String path2, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("maPage3 /ma/{}/{}/{}/{}.do", path1,path2, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ma/{path1}/{path2}/{path3}/{menuCd}/{page}.do")
    public String maPage4(@PathVariable String path1,@PathVariable String path2,@PathVariable String path3, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("maPage4 /ma/{}/{}/{}/{}/{}.do", path1,path2,path3, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ma/{path1}/{path2}/{path3}/{path4}/{menuCd}/{page}.do")
    public String maPage5(@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("maPage5 /ma/{}/{}/{}/{}/{}/{}.do", path1,path2,path3,path4, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ma/{path1}/{path2}/{path3}/{path4}/{path5}/{menuCd}/{page}.do")
    public String maPage6(@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4,@PathVariable String path5, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("maPage6 /ma/{}/{}/{}/{}/{}/{}/{}.do", path1,path2,path3,path4,path5, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }


    @PostMapping("/ft/{menuCd}/{page}.do")
    public String ftPage1(@PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("ftPage1 /ft/{}/{}.do", menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ft/{path1}/{menuCd}/{page}.do")
    public String ftPage2(@PathVariable String path1, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("ftPage2 /ft/{}/{}/{}.do", path1, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ft/{path1}/{path2}/{menuCd}/{page}.do")
    public String ftPage3(@PathVariable String path1,@PathVariable String path2, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("ftPage3 /ma/{}/{}/{}/{}.do", path1,path2, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ft/{path1}/{path2}/{path3}/{menuCd}/{page}.do")
    public String ftPage4(@PathVariable String path1,@PathVariable String path2,@PathVariable String path3, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("ftPage4 /ft/{}/{}/{}/{}/{}.do", path1,path2,path3, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ft/{path1}/{path2}/{path3}/{path4}/{menuCd}/{page}.do")
    public String ftPage5(@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("ftPage5 /ft/{}/{}/{}/{}/{}/{}.do", path1,path2,path3,path4, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }

    @PostMapping("/ft/{path1}/{path2}/{path3}/{path4}/{path5}/{menuCd}/{page}.do")
    public String ftPage6(@PathVariable String path1,@PathVariable String path2,@PathVariable String path3,@PathVariable String path4,@PathVariable String path5, @PathVariable String menuCd, @PathVariable String page, HttpServletRequest request, ModelMap model) throws Exception {
        log.debug("ftPage6 /ft/{}/{}/{}/{}/{}/{}/{}.do", path1,path2,path3,path4,path5, menuCd,page);
        return onNameViewService.viewResolver(request, model);
    }



}
