package kr.or.standard.basic.usersupport.popup.service;
 
import java.util.List;
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.usersupport.popup.vo.PopupVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;


@Service
@Transactional
@RequiredArgsConstructor
public class PopupService  extends EgovAbstractServiceImpl {
    
    
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    
    private final String sqlNs = "com.standard.mapper.usersupport.PopupMngMapper.";
    
    public void addList(PopupVO searchVO, Model model) throws Exception{
    
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		PopupVO rtnVo = (PopupVO)defaultDao.selectOne(sqlNs+"selectCount", searchVO);
		int popupCount = Integer.parseInt(rtnVo.getPopupCount()); 
		paginationInfo.setTotalRecordCount(popupCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<PopupVO> resultList = (List<PopupVO>)defaultDao.selectList(sqlNs+"selectList", searchVO);  
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalRecordCount", paginationInfo.getTotalRecordCount());
    
    }
    
    public String view(PopupVO searchVO, Model model){
		// 팝업 일련번호 없는 경우
		if(StringUtils.isEmpty(searchVO.getPopupSerno())) {
			return "redirect:list.do";
		}
        
        PopupVO popupVO = (PopupVO)defaultDao.selectOne(sqlNs+"selectContents", searchVO); 
		model.addAttribute("popupVO", popupVO);
		return ""; 
    }
    
    public String insertUpdateForm(PopupVO searchVO, Model model, String procType, HttpSession session){
        
        
		PopupVO popupVO = new PopupVO();
		
		if("update".equals(procType)) {
			
			// 관리자 또는 본인글인 경우
			if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
				// 팝업 일련번호 없는 경우
				if(StringUtils.isEmpty(searchVO.getPopupSerno())) {
					return "redirect:list.do";
				}
				popupVO = (PopupVO)defaultDao.selectOne(sqlNs+"selectContents", searchVO); 
			} else {
				return "redirect:list.do";
			}
		}
		
		model.addAttribute("popupVO", popupVO);
		return ""; 
    }
    
    
    public CommonMap insertProc(PopupVO searchVO, BindingResult result){

		CommonMap returnMap = new CommonMap(); 
		int resultCnt = defaultDao.insert(sqlNs+"insertContents", searchVO);
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		} 
		returnMap.put("returnUrl", "list.do");
		return returnMap; 
    }
    
    public CommonMap updateProc(PopupVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap(); 
		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) { 
            int resultCnt = defaultDao.update(sqlNs+"updateContents", searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
			returnMap.put("returnUrl", "view.do");
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		}
		return returnMap;
    }
    
    
    public CommonMap deleteProc(PopupVO searchVO, BindingResult result, HttpSession session){
		
		CommonMap returnMap = new CommonMap(); 
		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) { 
        int resultCnt = defaultDao.update(sqlNs+"deleteContents", searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
				returnMap.put("returnUrl", "list.do");
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
				returnMap.put("returnUrl", "updateForm.do");
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		}
		
		return returnMap;
    }
      
    public ModelAndView excelDownload(PopupVO searchVO){
    
        ModelAndView mav = new ModelAndView(excelView);
		String tit = "팝업목록";
		String url = "/standard/usersupport/popupList.xlsx"; 
		List<PopupVO> resultList = (List<PopupVO>)defaultDao.selectList(sqlNs+"selectExcelList", searchVO);  
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
    }
    
    
    
    
	// 팝업 건수 조회
	/*public int selectCount(PopupVO vo) {
		return popupMngMapper.selectCount(vo);
	}*/

	// 팝업 목록 조회
	/*public List<PopupVO> selectList(PopupVO vo) {
		return popupMngMapper.selectList(vo);
	}*/

	// 팝업 상세 조회
	/*public PopupVO selectContents(PopupVO vo) {
		return popupMngMapper.selectContents(vo);
	}*/

	// 본인글 여부 체크
	public boolean regrCheck(PopupVO vo) { 
	    PopupVO rtnVo = (PopupVO)defaultDao.selectOne(sqlNs+"regrCheck", vo);    
	    return Integer.parseInt(rtnVo.getIsRegrCheck()) == 1 ? true : false; 
	}

	// 팝업 등록
	/*public int insertContents(PopupVO vo) {
		return popupMngMapper.insertContents(vo);
	}*/

	// 팝업 수정
	/*public int updateContents(PopupVO vo) {
		return popupMngMapper.updateContents(vo);
	}*/

	// 팝업 삭제
	/*public int deleteContents(PopupVO vo) {
		return popupMngMapper.deleteContents(vo);
	}*/

	// 팝업 엑셀 목록 조회
	/*public List<PopupVO> selectExcelList(PopupVO vo) {
		return popupMngMapper.selectExcelList(vo);
	}*/

	// 메인 팝업 목록 조회
	/*public List<PopupVO> selectMainList(PopupVO vo) {
		return popupMngMapper.selectMainList(vo);
	}*/

}
