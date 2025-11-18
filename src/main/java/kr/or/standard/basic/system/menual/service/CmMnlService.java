package kr.or.standard.basic.system.menual.service;



import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.file.vo.FileVO;
import kr.or.standard.basic.system.menual.vo.CmMnlVO;
import kr.or.standard.basic.system.menual.vo.CmMnlItmVO;
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.lginPlcy.service.LginPlcyService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;


@Service
@RequiredArgsConstructor
@Transactional
public class CmMnlService extends EgovAbstractServiceImpl {
	
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
    private final PaginationService paginationService;
	private final LginPlcyService lginPlcyService;
	private final MessageSource messageSource;
	private final ExcelView excelView;
	private final FileService fileService;
	
	private final String CM_FOLDER_PATH = "/component/cm_mnl/";
	
	public String list(){
		return ".mLayout:" + CM_FOLDER_PATH + "list";
	}
	
	public String addList(CmMnlVO searchVO, Model model) throws Exception{
	    
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		// 매뉴얼 건수 조회
		CmMnlVO rtnVo = (CmMnlVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.MnlMngMapper.selectCount" , searchVO);
		int cmMnlCnt = Integer.parseInt(rtnVo.getMnlCnt()); 
		paginationInfo.setTotalRecordCount(cmMnlCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//  매뉴얼 목록 조회
		List<CmMnlVO> resultList = (List<CmMnlVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MnlMngMapper.selectList" , searchVO); 

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalRecordCount", cmMnlCnt);
		
		return CM_FOLDER_PATH + "addList"; 
	}  
	
	public String view(CmMnlVO searchVO, Model model){
		
		
		// 매뉴얼 일련번호 없는 경우
		if(StringUtils.isEmpty(searchVO.getMnlSerno())) {
			return "redirect:list.do";
		}

		CmMnlVO cmMnlVO = (CmMnlVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.MnlMngMapper.selectContents", searchVO);
		model.addAttribute("cmMnlVO", cmMnlVO);
		
		// 매뉴얼 항목 조회   
		List<CmMnlItmVO> itemList = selectItemList(searchVO); 
		model.addAttribute("itemList", itemList);
		
		return ".mLayout:" + CM_FOLDER_PATH + "view";
		
	}
	
	public String insertUpdateForm(CmMnlVO searchVO, Model model, String procType, HttpSession session){
		
		CmMnlVO cmMnlVO = new CmMnlVO();
		if("update".equals(procType)) {
			
			// 관리자 또는 본인글인 경우
			if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
				// 매뉴얼 일련번호 없는 경우
				if(StringUtils.isEmpty(searchVO.getMnlSerno())) {
					return "redirect:list.do";
				}
				cmMnlVO = (CmMnlVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.MnlMngMapper.selectContents", searchVO);

				// 매뉴얼 항목 조회
				List<CmMnlItmVO> itemList = selectItemList(searchVO);
				model.addAttribute("itemList", itemList);
			} else {
				return "redirect:list.do";
			}
		}
		
		model.addAttribute("cmMnlVO", cmMnlVO); 
		return ".mLayout:" + CM_FOLDER_PATH + "form"; 
	}
	
	public String addItem(){
		return CM_FOLDER_PATH + "addItem";
	}
	
	public String addType(String mnlItmClCd, Model model){
		model.addAttribute("mnlItmClCd", mnlItmClCd);
		return CM_FOLDER_PATH + "addType";
	}
	
	public CommonMap insertProc(CmMnlVO searchVO, BindingResult result){
	
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
	
	public CommonMap updateProc(CmMnlVO searchVO, BindingResult result, HttpSession session){
		CommonMap returnMap = new CommonMap();
		  
		// 관리자 또는 본인글인 경우
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
		
			int resultCnt = updateContents(searchVO); 
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
				returnMap.put("returnUrl", "view.do");
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
				returnMap.put("returnUrl", "updateForm.do");
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		}
		return returnMap; 
	}
	
	public CommonMap deleteProc(CmMnlVO searchVO, BindingResult result, HttpSession session){
		
			CommonMap returnMap = new CommonMap();
	
			// 관리자 또는 본인글인 경우
			if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			
				int resultCnt = deleteContents(searchVO); 
				if(resultCnt > 0) {
					returnMap.put("message", messageSource.getMessage("delete.message", null, null));
					returnMap.put("returnUrl", "list.do");
				} else {
					returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
					returnMap.put("returnUrl", "view.do");
				}
			} else {
				returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
				returnMap.put("returnUrl", "list.do");
			}
			
			return returnMap;
	}
	
	public ModelAndView excelDownload(CmMnlVO searchVO){
	
		
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "매뉴얼_목록";
		String url = "/standard/system/mnlList.xlsx";  
			
		List<CmMnlVO> resultList = (List<CmMnlVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MnlMngMapper.selectExcelList",searchVO ); 
		
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
	}
	
	

	// 매뉴얼 건수 조회
	/*public int selectCount(CmMnlVO vo) {
	    return mnlMngMapper.selectCount(vo);
	}*/

	// 매뉴얼 목록 조회
	/*public List<CmMnlVO> selectList(CmMnlVO vo) {
		return mnlMngMapper.selectList(vo);
	}*/

	// 매뉴얼 상세 조회
	/*public CmMnlVO selectContents(CmMnlVO vo) { 
		return mnlMngMapper.selectContents(vo);
	}*/

	// 매뉴얼 항목 조회
	public List<CmMnlItmVO> selectItemList(CmMnlVO vo) {
 
		List<CmMnlItmVO> itemList = (List<CmMnlItmVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MnlMngMapper.selectItemList", vo);
		
		// 이미지 목록 조회
		if(!CollectionUtils.isEmpty(itemList)) {
			for(CmMnlItmVO itemVO : itemList) {
				
				String atchFileId = itemVO.getAtchFileId();
				if(!StringUtils.isEmpty(atchFileId)) { 
					List<FileVO> imgList = fileService.getAtchFileList(new FileVO(atchFileId));
					itemVO.setImgList(imgList);
				}
					
			}
		}
		
		return itemList;
	}
	
	// 매뉴얼 본인글 여부 체크
	public boolean regrCheck(CmMnlVO vo) {
		CmMnlVO rtnVo = (CmMnlVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.MnlMngMapper.regrCheck", vo); 
		return Integer.parseInt(rtnVo.getIsRegrCheck()) == 1 ? true : false; 
	}

	// 매뉴얼 등록
	public int insertContents(CmMnlVO vo) {
		
		int result = 0;
		
		// 매뉴얼 등록
		defaultDao.insert("com.opennote.standard.mapper.basic.MnlMngMapper.insertContents", vo); 
		
		// 매뉴얼 항목 등록
		for(CmMnlItmVO itemVO : vo.getItemList()) {
			// 매뉴얼 일련번호 세팅 후 등록
			itemVO.setMnlSerno(vo.getMnlSerno());
			result += defaultDao.insert("com.opennote.standard.mapper.basic.MnlMngMapper.insertItemContents", itemVO); 
		}
		
		return result;
	}

	// 매뉴얼 수정
	public int updateContents(CmMnlVO vo) {
		
		int result = 0;
		
		// 매뉴얼 수정
		defaultDao.update("com.opennote.standard.mapper.basic.MnlMngMapper.updateContents", vo);
		
		// 매뉴얼 항목 전체 삭제
		defaultDao.update("com.opennote.standard.mapper.basic.MnlMngMapper.deleteAllItemContents", vo);
		
		// 매뉴얼 항목 수정
		for(CmMnlItmVO itemVO : vo.getItemList()) {
			// 매뉴얼 일련번호 세팅 후 수정
			itemVO.setMnlSerno(vo.getMnlSerno());
			if(StringUtils.isEmpty(itemVO.getMnlItmSerno())) {
				result += defaultDao.insert("com.opennote.standard.mapper.basic.MnlMngMapper.insertItemContents", itemVO); 
			} else {
				result += defaultDao.update("com.opennote.standard.mapper.basic.MnlMngMapper.updateItemContents", itemVO); 
			}
		}
		
		return result;
	}

	// 매뉴얼 삭제
	public int deleteContents(CmMnlVO vo) {
		
		int result = 0;
		
		// 매뉴얼 삭제 
		result = defaultDao.update("com.opennote.standard.mapper.basic.MnlMngMapper.deleteContents", vo);
		
		// 매뉴얼 항목 전체 삭제
		defaultDao.update("com.opennote.standard.mapper.basic.MnlMngMapper.deleteAllItemContents", vo); 
		
		return result;
		
	}

	// 엑셀 목록 조회
	public List<CmMnlVO> selectExcelList(CmMnlVO vo) {
		return (List<CmMnlVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MnlMngMapper.selectExcelList", vo); 
	}

}
