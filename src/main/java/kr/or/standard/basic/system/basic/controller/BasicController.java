package kr.or.standard.basic.system.basic.controller;


import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.login.service.LoginService;
import kr.or.standard.basic.system.basic.service.BasicService;
import kr.or.standard.basic.system.regeps.vo.RegepsVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@RequiredArgsConstructor
@Controller
public class BasicController {


    private final BasicService basicService;
    private final String FOLDER_PATH = "/ma/system/basic/";

    // 시스템 관리정책 페이지
    @PostMapping(FOLDER_PATH+"/form.do")
    public String form (HttpServletRequest request ) throws Exception {
        return basicService.form(request);
    }
}
