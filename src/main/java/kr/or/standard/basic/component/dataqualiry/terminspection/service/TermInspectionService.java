package kr.or.standard.basic.component.dataqualiry.terminspection.service;

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.component.dataqualiry.dbdata.vo.DBdataVO;
import kr.or.standard.basic.module.ExcelUtil;
import kr.or.standard.basic.usersupport.dictionary.term.service.TermService;
import kr.or.standard.basic.usersupport.dictionary.term.vo.CmTermVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Validator;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class TermInspectionService {
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    private final Validator validator;
    private final ExcelUtil excelUtil;
    private final FileService fileService;
    private final TermService termService;
    
    private final String sqlNs = "com.standard.mapper.component.DbDataMapper.";
    
    @Value("${spring.datasource.username}")
	private String username;
    
    public void addList(DBdataVO searchVO, Model model) throws Exception{
        
        
		List<DBdataVO> resultList;
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO); 
		searchVO.setTableSchema(username); // DB Schema 정보
		
		if ("02".equals(searchVO.getSchEtc01())) {
		
		
            DBdataVO rtnVo = (DBdataVO)defaultDao.selectOne(sqlNs+"selectColStdCount",searchVO);
            int termCount = Integer.parseInt(rtnVo.getTermCount()); 
			paginationInfo.setTotalRecordCount(termCount);
			
			resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectColStdList",searchVO); // 표준미준수 
		} else {
		    
		    DBdataVO rtnVo = (DBdataVO)defaultDao.selectOne(sqlNs+"selectColExplCount",searchVO);
            int termCount = Integer.parseInt(rtnVo.getTermCount()); 
			paginationInfo.setTotalRecordCount(termCount);
			
			resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectColExplList",searchVO); // 코멘트미표시 
		}

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
    }
    
    public void view(DBdataVO searchVO, Model model){
        
		searchVO.setTableSchema(username); // DB Schema 정보
		DBdataVO cmDbDataVO = (DBdataVO)defaultDao.selectOne(sqlNs+"selectColContents", searchVO);
		
		// 컬럼한글명불일치
		if ("ST02".equals(searchVO.getStdCd())) { 
			CmTermVO cmTermVO = termService.selectTermContents(searchVO.getColumnName());
			model.addAttribute("cmTermVO", cmTermVO);
		}

		model.addAttribute("cmDbDataVO", cmDbDataVO);
    
    }
    
    public CommonMap insertProc(CmTermVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap(); 

		// 관리자가 아닌 경우
		if (!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
			return returnMap;
		}
        
        int resultCnt = termService.insertContents(searchVO);   
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		returnMap.put("returnUrl", "list.do");
		return returnMap;
    
    }
    
    public ModelAndView excelDownload(DBdataVO searchVO){
        
		ModelAndView mav = new ModelAndView(excelView);
		String tit;
		String url;

		List<DBdataVO> resultList;

		searchVO.setTableSchema(username);	// DB Schema 정보
		searchVO.setSchEtc10("Y");			// 엑셀여부
		if ("02".equals(searchVO.getSchEtc01())) {
			tit = "DB컬럼표준_미준수목록";
			url = "/standard/component/dataquality/colStdList.xlsx";
			 
			resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectColStdList",searchVO); // 표준미준수 
		} else {
			tit = "DB컬럼코멘트_미표시목록";
			url = "/standard/component/dataquality/colExplList.xlsx";
			resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectColExplList",searchVO); // 코멘트미표시 
		}

		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
    
    }
    
    
	// DB 컬럼 설명 미표시 건수 조회
	/*public int selectColExplCount(CmDbDataVO vo) {
		return dbDataMapper.selectColExplCount(vo);
	};*/

	// DB 컬럼 설명 미표시 조회
	/*public List<CmDbDataVO> selectColExplList(CmDbDataVO vo) {
		return dbDataMapper.selectColExplList(vo);
	};*/

	// DB 컬럼 표준미준수 건수 조회
	/*public int selectColStdCount(CmDbDataVO vo) {
		return dbDataMapper.selectColStdCount(vo);
	};*/

	// DB 컬럼 표준미준수 조회
	/*public List<CmDbDataVO> selectColStdList(CmDbDataVO vo) {
		return dbDataMapper.selectColStdList(vo);
	};*/

	// DB 테이블 컬럼 상세 조회
	/*public CmDbDataVO selectColContents(CmDbDataVO vo) {
		return dbDataMapper.selectColContents(vo);
	};*/
	
}
