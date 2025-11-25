package kr.or.standard.basic.system.mngr.rstMng.service;

import kr.or.standard.basic.system.mngr.rstMng.vo.RstMngVO;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;


import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor 
public class RstMngService extends EgovAbstractServiceImpl {
        
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final PaginationService paginationService;
	private final MessageSource messageSource;
	private final ExcelView excelView;
	
	private final String sqlNs = "com.standard.mapper.basic.UserIdRstMngMapper.";
         
	
	public void addList(RstMngVO searchVO, Model model) throws Exception{
	    
	    int totalCount = selectCount(searchVO);
	    	
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		paginationInfo.setTotalRecordCount(totalCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<RstMngVO> resultList = selectList(searchVO); 
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalRecordCount", totalCount);
		
	}
	
	public CommonMap insertProc(RstMngVO searchVO, BindingResult result){
	    
	    
		CommonMap returnMap = new CommonMap();

		int resultCnt = insertContents(searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		} 
		returnMap.put("returnUrl", "list.do"); 
		return returnMap;
	}
	
	public CommonMap deleteProc(RstMngVO searchVO, BindingResult result, HttpSession session){
	    
		CommonMap returnMap = new CommonMap(); 
		int resultCnt = deleteContents(searchVO);

		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("delete.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
		} 
		returnMap.put("returnUrl", "list.do");
		returnMap.put("message", messageSource.getMessage("delete.message", null, null));
		
		return returnMap;
	}
	
	public ModelAndView excelDownload(RstMngVO searchVO, Model model){
	    
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "제한목록";
		String url = "/standard/rstMngList.xlsx";

		List<RstMngVO> resultList = (List<RstMngVO>) defaultDao.selectList(sqlNs+"selectExcelList", searchVO);

		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
	
	}
	
	public CommonMap allAction(RstMngVO searchVO ,String procType){
	    
	    
		CommonMap returnMap = new CommonMap();

		int result = 0;
		String message = "";

		if ("allBlk".equals(searchVO.getProcType())) {
			if(searchVO.getSchEtc12() != null && searchVO.getSchEtc12().length > 0) {
				result = defaultDao.update(sqlNs+"allBlock", searchVO);
				message = searchVO.getSchEtc12().length + "건에 대하여 제한하였습니다.";
			}
		} else if ("allClear".equals(searchVO.getProcType())) {
			if(searchVO.getSchEtc11() != null && searchVO.getSchEtc11().length > 0) {
				result = defaultDao.update(sqlNs+"allClear", searchVO);
				message = searchVO.getSchEtc11().length + "건에 대하여 제한 해제하였습니다.";
			}
		}

		returnMap.put("result", result);
		returnMap.put("message", message);

		return returnMap;
	
	}
	
	public CommonMap idOvlpChk(RstMngVO searchVO){
		CommonMap returnMap = new CommonMap(); 
		
		RstMngVO rtnVo = (RstMngVO)defaultDao.selectOne(sqlNs+"idOvlpSelectCount", searchVO);
		int rstCnt =  Integer.parseInt(rtnVo.getUserIdCount()); 
		
		returnMap.put("rstCnt", rstCnt); 
		return returnMap;
	
	}
        
	public int selectCount(RstMngVO vo) { 
	   RstMngVO rtnVo = (RstMngVO)defaultDao.selectOne(sqlNs+"selectCount" , vo);
	   return Integer.parseInt(rtnVo.getUserIdCount()); 
	}

	public List<RstMngVO> selectList(RstMngVO vo) {
	    return (List<RstMngVO>)defaultDao.selectList(sqlNs+"selectList", vo); 
	}

	public int insertContents(RstMngVO vo) {
	    return defaultDao.insert(sqlNs+"insertContents", vo); 
	}

	public int deleteContents(RstMngVO vo) {
	    return defaultDao.delete(sqlNs+"deleteContents", vo); 
	}

	/*public List<RstMngVO> selectExcelList(RstMngVO vo) {
        return (List<RstMngVO>) defaultDao.selectList(sqlNs+"selectExcelList", vo); 
	}*/

	// 중복체크
	/*public int idOvlpSelectCount(RstMngVO vo) {
		RstMngVO rtnVo = (RstMngVO)defaultDao.selectOne(sqlNs+"idOvlpSelectCount", vo);
		return Integer.parseInt(rtnVo.getUserIdCount());  
	}*/
	
	// 일괄 제한
	/*public int allBlock(RstMngVO vo) {
	    return defaultDao.update(sqlNs+"allBlock", vo); 
	}*/
	
	// 일괄 제한해제
	/*public int allClear(RstMngVO vo) {
	    return defaultDao.update(sqlNs+"allClear", vo); 
	}*/
    
}
