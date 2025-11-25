package kr.or.standard.basic.system.log.errlog.service;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.statistics.acsstat.vo.AcsStatVO;
import kr.or.standard.basic.system.log.errlog.vo.ErrlogVO; 
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class ErrlogService extends EgovAbstractServiceImpl {
     
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final PaginationService paginationService; 
	private final ExcelView excelView;
    private final String sqlNs = "com.standard.mapper.basic.ErrLogMngMapper.";
    
    // 에러 유형 목록 조회
    public void list(Model model){ 
		List<ErrlogVO> errTpList = (List<ErrlogVO>)defaultDao.selectList(sqlNs+"errTpSelectList");
		model.addAttribute("errTpList",errTpList); 
    }
    
    // 에러 목록 조회
    public void addList(ErrlogVO searchVO, Model model) throws Exception {
        
        ErrlogVO rtnVo = (ErrlogVO)defaultDao.selectOne(sqlNs+"selectCount" ,searchVO ); 
		int count = Integer.parseInt(rtnVo.getErrLogCnt()); 
		model.addAttribute("totalRecordCount", count);

		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		paginationInfo.setTotalRecordCount(count);
		model.addAttribute("paginationInfo", paginationInfo);
        
        List<ErrlogVO> resultList = (List<ErrlogVO>)defaultDao.selectList(sqlNs+"selectList"  , searchVO); 
		model.addAttribute("resultList", resultList);
    }
    
    // 에러 로그 상세
    public void view(ErrlogVO searchVO, Model model){ 
		ErrlogVO errlogVO = (ErrlogVO)defaultDao.selectOne(sqlNs+"selectContents" ,searchVO );
		model.addAttribute("errlogVO", errlogVO);
    
    }
    
    // 에러로그 엑셀 다운로드
    public ModelAndView excelDownload(ErrlogVO searchVO){
        
		ModelAndView mav = new ModelAndView(excelView);
		  
		String tit = "에러로그";
		String url = "/standard/system/errlogList.xlsx";

		// 엑셀 리스트 조회 
		List<ErrlogVO> resultList = (List<ErrlogVO>)defaultDao.selectList(sqlNs+"selectExcelList"  , searchVO);
		  
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
    
    }
    
	// 에러 로그 등록
	public int insertContents(ErrlogVO vo) {
	    return defaultDao.insert(sqlNs+"insertContents" , vo); 
	}

	// 메뉴별 에러 건수
	public List<CommonMap> selectMenuErr() {
	    return basicDao.selectList(sqlNs+"selectMenuErr"); 
	}

	// 메뉴별 에러 건수 상세
	public List<CommonMap> selectMenuErrDetail(AcsStatVO vo) {
		return basicDao.selectList(sqlNs+"selectMenuErrDetail", vo); 
	}

	// 에러 로그 건수
	/*public int selectCount(ErrlogVO vo) { 
	    return errLogMngMapper.selectCount(vo);
	}*/

	// 에러 로그 리스트
	/*public List<ErrlogVO> selectList(ErrlogVO vo) { 
	    return errLogMngMapper.selectList(vo);
	}*/

	// 에러 로그 상세
	/*public ErrlogVO selectContents(ErrlogVO vo) { 
	    return errLogMngMapper.selectContents(vo);
	}*/

	// 에러 유형 목록 조회
	/*public List<ErrlogVO> errTpSelectList() { 
	    return errLogMngMapper.errTpSelectList();
	}*/

	// 엑셀 리스트 조회
	/*public List<ErrlogVO> selectExcelList(ErrlogVO vo) { 
	    return errLogMngMapper.selectExcelList(vo);
	}*/
    
}
