package kr.or.standard.basic.example.controller;

import kr.or.standard.basic.board.vo.BoardVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.example.domain.InspectionReportVo;
import kr.or.standard.basic.example.service.ExampleService;
import kr.or.standard.basic.system.logo.vo.LogoVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class ExampleController {

    private final ExampleService exampleService;

    private final String URL_PATH = "/ma/example/";

    @PostMapping(URL_PATH + "insertInspctReportInfo.do")
    /* /ma/example/insertInspctReportInfo.do, /ma/example/insertInspctReportInfo.do */
    public ResponseEntity<Map<String, Object>> insertInspctReportInfo(@RequestBody InspectionReportVo inspctReportVO
                      , HttpServletRequest request , HttpServletResponse response
                      , HttpSession session , Model model
                       ) {


        CommonMap resultMap = exampleService.insertInspctReportInfo(inspctReportVO , request , response, session , model);


        return ResponseEntity.ok(resultMap);
    }
}
