package kr.or.standard.basic.system.logo.service; 

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.logo.vo.LogoVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
public class LogoService {
     
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
	private final PaginationService paginationService;
    private final MessageSource messageSource;
    private final ExcelView excelView;
        
    public void addList(LogoVO searchVO, Model model) throws Exception {
        
         LogoVO rtnVo = (LogoVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.selectCount" , searchVO);
         int count =  Integer.parseInt(rtnVo.getLogoCount());  
        model.addAttribute("totalRecordCount", count);
        

        PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
        paginationInfo.setTotalRecordCount(count);
        model.addAttribute("paginationInfo", paginationInfo);

        List<LogoVO> resultList =  (List<LogoVO>) defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectList" , searchVO);
        model.addAttribute("resultList", resultList);
    }
    
    public void view(LogoVO searchVO, Model model){
        LogoVO logoVO = (LogoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.selectContents" , searchVO);
        model.addAttribute("logoVO", logoVO);
    }
    
    public String insertUpdateForm(LogoVO searchVO, String procType, Model model, HttpSession session) {
        
        
        LogoVO logoVO = new LogoVO();

        if (procType.equals("update")){

            // 관리자 또는 본인글이 아닌 경우
            if(!((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO))) {
                return "redirect:list.do";
            }

            // 정규표현식 일련번호 없는 경우
            if(StringUtils.isEmpty(searchVO.getLogoSerno())) {
                return "redirect:list.do";
            }

            logoVO = (LogoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.selectContents" , searchVO);
        }

        model.addAttribute("logoVO", logoVO);
        return "";
    
    }
    
    public CommonMap insertProc(LogoVO searchVO, BindingResult result){
        CommonMap returnMap = new CommonMap();
        
        /* 활성화 등록, 수정 시 기존 활성화 항목 비활성화 */
        defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.updateActvtYn" , searchVO);; /* 활성화 등록, 수정 시 기존 활성화 항목 비활성화 */ 
        int resultCnt = defaultDao.insert("com.opennote.standard.mapper.basic.LogoMngMapper.insertContent" , searchVO); 

        if(resultCnt > 0){
            returnMap.put("message", messageSource.getMessage("insert.message", null, null));
            returnMap.put("returnUrl", "list.do");
        } else {
            returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
            returnMap.put("returnUrl", "list.do");
        }
        
        return returnMap; 
    }
    
    public CommonMap updateProc(LogoVO searchVO, BindingResult result,HttpSession session){
        
        CommonMap returnMap = new CommonMap();
        
        /* 활성화 등록, 수정 시 기존 활성화 항목 비활성화 */ /* 활성화 등록, 수정 시 기존 활성화 항목 비활성화 */
        defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.updateActvtYn" , searchVO);
          
        // 관리자 또는 본인글이 아닌 경우
        if(!((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO))) {
            returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
            returnMap.put("returnUrl", "list.do");
        } else {
          int resultCnt = defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.updateContents" , searchVO);

            if(resultCnt > 0){
                returnMap.put("message", messageSource.getMessage("update.message", null, null));
                returnMap.put("returnUrl", "view.do");
            } else {
                returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
                returnMap.put("returnUrl", "updateForm.do");
            }
        }
        
        return returnMap; 
    }
    
    public CommonMap deleteProc(LogoVO searchVO, BindingResult result,HttpSession session){
        
        
        CommonMap returnMap = new CommonMap();
 

        // 관리자 또는 본인글이 아닌 경우
        if(!((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO))) {
            returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
            returnMap.put("returnUrl", "list.do");
        } else {
           int resultCnt = defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.deleteContents" , searchVO); 

            if(resultCnt > 0){
                returnMap.put("message", messageSource.getMessage("delete.message", null, null));
                returnMap.put("returnUrl", "list.do");
            } else {
                returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
            }
        } 
        return returnMap; 
    }
    
    public ModelAndView excelDownload(LogoVO searchVO, Model model){
        
        ModelAndView mav = new ModelAndView(excelView);
        String tit = "로고목록";
        String url = "/standard/system/logoList.xlsx";

        List<LogoVO> resultList = (List<LogoVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectExcelList", searchVO);;

        mav.addObject("target", tit);
        mav.addObject("source", url);
        mav.addObject("resultList", resultList);
        return mav;
    }
    
   /* public int selectCount(LogoVO vo) {
      LogoVO rtnVo = (LogoVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.selectCount" , vo);
      return Integer.parseInt(rtnVo.getLogoCount()); 
    }*/

    /*public List<LogoVO> selectList(LogoVO vo) {
        return (List<LogoVO>) defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectList" , vo); 
    }*/

    /*public int insertContent(LogoVO vo) {
        return  defaultDao.insert("com.opennote.standard.mapper.basic.LogoMngMapper.insertContent" , vo); 
    }*/

    /*public LogoVO selectContents(LogoVO vo) { 
        return (LogoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.selectContents" , vo); 
    }*/

    /*public int updateContents(LogoVO vo) { 
        return defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.updateContents" , vo); 
    }*/

   /* public int deleteContents(LogoVO vo) {
        return defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.deleteContents" , vo); 
    }*/

    /* 활성화 항목 중복 등록 판단 */
    public int itmActvtYnChk(LogoVO vo) {
      LogoVO rtnVo = (LogoVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.itmActvtYnChk" , vo);
      return Integer.parseInt(rtnVo.getLogoCount()); 
    }

    /* 활성화 등록, 수정 시 기존 활성화 항목 비활성화 */
    /*public int updateActvtYn(LogoVO vo) { 
        return defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.updateActvtYn" , vo); 
        
    }*/

    /* 활성화 로고 정보 조회 */
    public List<LogoVO> selectActvYnItm(){ 
       return (List<LogoVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectActvYnItm"); 
    }

    /* 로고 엑셀 목록 조회 */
    /*public List<LogoVO> selectExcelList(LogoVO vo) {
        return (List<LogoVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectExcelList", vo); 
    }*/

    /* 본인글 여부 확인 */
    public boolean regrCheck(LogoVO vo) {
       LogoVO rtnVo = (LogoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.regrCheck", vo);
       return Integer.parseInt(rtnVo.getIsRegrChk()) == 1 ? true : false; 
    }    
        
}
