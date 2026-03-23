package kr.or.standard.basic.example.service;


import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.example.domain.InspectionReportVo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExampleService extends EgovAbstractServiceImpl {

    private final BasicCrudDao basicDao;
    private final CmmnDefaultDao defaultDao;

    public CommonMap insertInspctReportInfo(InspectionReportVo inspctReportVO
            , HttpServletRequest request , HttpServletResponse response
            , HttpSession session , Model model){

        log.info("========  basicDao  : {} ", basicDao.toString());
        log.info("========  defaultDao  : {} ", defaultDao.toString());

        log.info("===============================     InspctReportInfo   VO   BEGIN  =====================================");
        log.info(inspctReportVO.toString());
        log.info("================================    InspctReportInfo   VO   FINISH ===================================");



        CommonMap resultMap = new CommonMap();
        resultMap.put("resultCode", "SUCCESS");
        resultMap.put("message", "검사보고서가 성공적으로 저장되었습니다.");

        return resultMap;
    }

}
