package kr.or.standard.basic.statistics.acsstat.service;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.module.ExcelUtil;
import kr.or.standard.basic.statistics.acsstat.vo.AcsStatVO;
import kr.or.standard.basic.system.log.acs.service.AcsService;
import kr.or.standard.basic.system.log.errlog.service.ErrlogService;
import kr.or.standard.basic.system.menu.servie.MenuService;
import kr.or.standard.basic.system.mngr.mngrMng.service.MngrMngService;
import kr.or.standard.basic.usersupport.user.service.UserService;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import javax.validation.Validator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class AcsStatService extends EgovAbstractServiceImpl {
    
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    private final Validator validator;
    private final ExcelUtil excelUtil;
    private final FileService fileService;
    
    private final MenuService menuService;
    private final AcsService acsService;
    private final ErrlogService errlogService;
    private final UserService userService;
    private final MngrMngService mngrMngService;
     
    	 
    private final String sqlNs = "com.standard.mapper.component.DbDataMapper.";
    
    public CommonMap getAcsStat(AcsStatVO vo){
            
        CommonMap returnMap = new CommonMap();
        List<CommonMap> resultList = new ArrayList<CommonMap>();

        String clcd = vo.getProcType(); // 조회구분코드

        if ("chart1".equals(clcd)) {
            
            resultList = menuService.selectMenuRank();                // 메뉴 접속 수 Top5
        } else if ("chart1Dtls".equals(clcd)) {
            resultList = menuService.selectMenuRankDetail(vo);        // 메뉴 접속 수 Top5 상세
        } else if ("chart2".equals(clcd)) {
            resultList = menuService.selectMenuNow();                 // 메뉴별 접속수(현재날짜)
        } else if ("chart2Dtls".equals(clcd)) {
            resultList = menuService.selectMenuNowDetail(vo);         // 메뉴별 접속수(현재날짜) 상세
        } else if ("chart3".equals(clcd)) {
            resultList = acsService.selectAcsTime();                  // 시간별 접속수(현재날짜)
        } else if ("chart4".equals(clcd)) {
            resultList = errlogService.selectMenuErr();               // 메뉴별 에러 건수
        } else if ("chart4Dtls".equals(clcd)) {
            resultList = errlogService.selectMenuErrDetail(vo);       // 메뉴별 에러 건수 상세
        } else if ("chart5".equals(clcd)) {
            resultList = userService.selectScrbUserMon();             // 월별 가입추이(현재년도)
        } else if ("chart5Dtls".equals(clcd)) {
            resultList = userService.selectScrbUserDay(vo);           // 일별 가입추이
        } else if ("chart6".equals(clcd)) {
            resultList = mngrMngService.selectScssUserMon();          // 월별 탈퇴추이(현재년도)
        } else if ("chart6Dtls".equals(clcd)) {
            resultList = mngrMngService.selectScssUserDay(vo);        // 일별 탈퇴추이(현재년도)
        }

        returnMap.put("resultList", resultList);
        returnMap.put("props", vo.getSchEtc00()); // 차트 상세명
        return returnMap;
    }
    
    public void userAddList(AcsStatVO searchVO, Model model) throws Exception {
        
        HashMap<String, Object> returnMap = new HashMap<>();

        PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
        List<UserVO> resultList;
        if ("scrb".equals(searchVO.getProcType())) {  
            paginationInfo.setTotalRecordCount(userService.selectScrbUserCount(searchVO)); 
            resultList = userService.selectScrbUserList(searchVO);  
        } else {
        
            paginationInfo.setTotalRecordCount(mngrMngService.selectScssUserCount(searchVO));
            resultList = mngrMngService.selectScssUserList(searchVO);
        }

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("resultList", resultList);
    
    }

}
