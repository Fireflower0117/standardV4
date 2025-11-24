package kr.or.standard.basic.board.service;
 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.board.vo.BoardVO;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.component.dataqualiry.dbdata.vo.DBdataVO;
import kr.or.standard.basic.module.ExcelUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ConcurrentModel;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Validator;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class BoardService extends EgovAbstractServiceImpl   {
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    private final Validator validator;
    private final ExcelUtil excelUtil;
    private final FileService fileService;
    
    private final String sqlNs = "com.standard.mapper.board.BoardMngMapper";
    
    public void addaddList(BoardVO searchVO, Model model) throws Exception{
        
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		BoardVO rtnVo = (BoardVO)defaultDao.selectOne(sqlNs+"selectCount",searchVO);
        int boardCount = Integer.parseInt(rtnVo.getBoardCount()); 
		paginationInfo.setTotalRecordCount(boardCount); 
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		List<BoardVO> resultList = (List<BoardVO>)defaultDao.selectList(sqlNs+"selectList" , searchVO);  
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalRecordCount", paginationInfo.getTotalRecordCount());
    
    }
    
    public String view(BoardVO searchVO, Model model){
        // 게시글 일련번호 없는 경우
		if(StringUtils.isEmpty(searchVO.getBoardSerno())) {
			return "redirect:list.do";
		} 
         
        BoardVO boardVO = (BoardVO)defaultDao.selectOne(sqlNs+"selectContents",searchVO); 
		model.addAttribute("boardVO", boardVO);
		return "";
    }
    
    public String form(BoardVO searchVO, Model model, String procType, HttpSession session){
        
		BoardVO boardVO = new BoardVO();
		
		if("update".equals(procType)) {
			
			// 관리자 또는 본인글인 경우
			if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
				// 게시글 일련번호 없는 경우
				if(StringUtils.isEmpty(searchVO.getBoardSerno())) {
					return "redirect:list.do";
				}
				boardVO = (BoardVO)defaultDao.selectOne(sqlNs+"selectContents",searchVO); 
			} else {
				return "redirect:list.do";
			}
		}
		
		model.addAttribute("boardVO", boardVO);
		return ""; 
    }
    
    public CommonMap insertProc(BoardVO searchVO, BindingResult result){
		CommonMap returnMap = new CommonMap();
		 
		int resultCnt = defaultDao.insert(sqlNs+"insertContents",searchVO);  
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "list.do");
		return returnMap; 
    }
    
    
    public CommonMap updateProc(BoardVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap();

		// 관리자 또는 본인글인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			
			int resultCnt = defaultDao.update(sqlNs+"updateContents",searchVO); 
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
    
    public CommonMap deleteProc(BoardVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap();

		// 관리자 또는 본인글인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			
			 
            int resultCnt = defaultDao.update(sqlNs+"deleteContents",searchVO);
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
    
    public ModelAndView excelDownload(BoardVO searchVO){
        
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "샘플게시판목록";
		String url = "/standard/board/boardList.xlsx"; 
        
        List<BoardVO> resultList = (List<BoardVO>)defaultDao.selectList(sqlNs+"selectExcelList",searchVO);  
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
    
    }
    
    
    
    // 게시글 건수 조회
	/*public int selectCount(BoardVO vo) {
		return boardMapper.selectCount(vo);
	};*/

	// 게시글 목록 조회
	/*public List<BoardVO> selectList(BoardVO vo) {
		return boardMapper.selectList(vo);
	};*/

	// 게시글 상세 조회
	/*public BoardVO selectContents(BoardVO vo) {
		return boardMapper.selectContents(vo);
	};*/
	
	// 게시글 등록
	/*public int insertContents(BoardVO vo) {
		return boardMapper.insertContents(vo);
	};*/
	
	// 게시글 수정
	/*public int updateContents(BoardVO vo) {
		return boardMapper.updateContents(vo);
	};*/
	
	// 게시글 삭제
	/*public int deleteContents(BoardVO vo) {
		return boardMapper.deleteContents(vo);
	}*/

	// 본인글 여부 체크
	public boolean regrCheck(BoardVO vo) {
	    BoardVO boardVO = (BoardVO)defaultDao.selectOne(sqlNs+"regrCheck",vo);
	    return Integer.parseInt(boardVO.getIsRegrChk()) == 1 ? true : false; 
	}

	// 게시글 엑셀 목록 조회
	/*public List<BoardVO> selectExcelList(BoardVO vo) {
		return boardMapper.selectExcelList(vo);
	}*/

}
