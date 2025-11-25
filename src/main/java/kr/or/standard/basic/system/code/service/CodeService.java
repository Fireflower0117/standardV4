package kr.or.standard.basic.system.code.service;
 
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.code.vo.CodeVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class CodeService extends EgovAbstractServiceImpl {
     
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final MessageSource messageSource;
	private final String sqlNs = "com.standard.mapper.basic.CdMngMapper."; 
    
    public void codeList(CodeVO searchVO, Model model){
        List<CodeVO> codeList = (List<CodeVO>)defaultDao.selectList( sqlNs+"selectList" , searchVO);
		model.addAttribute("codeList", codeList);
    }
    
    public CommonMap insertProc(CodeVO searchVO, BindingResult result, HttpSession session){
        
        
		CommonMap returnMap = new CommonMap();
		String sts = "";
 
		int resultCnt = 0;

		// 관리자인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
            
            CodeVO rtnVo = (CodeVO)defaultDao.selectOne(sqlNs+"selectOvlpCount" , searchVO); 
            int ovlpCnt = Integer.parseInt(rtnVo.getRowCnt());
			if (ovlpCnt < 1) {
			    resultCnt = defaultDao.insert(sqlNs+"insertContents" , searchVO); 

				if (resultCnt > 0) {
					returnMap.put("message", messageSource.getMessage("insert.message", null, null));
				} else {
					returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
				}
			}
		}else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}

		returnMap.put("resultCnt", resultCnt);
		returnMap.put("searchVO", searchVO);
		
		return returnMap;
    }
    
     public CommonMap updateProc(CodeVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap();

		int resultCnt = 0 ;
		// 관리자인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) { 
			resultCnt = defaultDao.update(sqlNs+"updateContents" , searchVO); 
			if (resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
		}else{
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}

		returnMap.put("resultCnt", resultCnt);
		returnMap.put("searchVO", searchVO);
		return returnMap;
     }
     
     public CommonMap deleteProc(CodeVO searchVO, BindingResult result, HttpSession session){
        
		CommonMap returnMap = new CommonMap();

		int resultCnt = 0 ;
		// 관리자인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) { 
			resultCnt = defaultDao.delete(sqlNs+"deleteContents" , searchVO);

			if (resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			}

		}else{
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}

		returnMap.put("resultCnt", resultCnt);
		returnMap.put("searchVO", searchVO);
		return returnMap;
     }
     
     public CommonMap sort(CodeVO searchVO, HttpSession session){
        
		CommonMap returnMap = new CommonMap();

		int resultCnt = 0;

		// 관리자인 경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			resultCnt = codeOrder(searchVO);

			if (resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
		}else{
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}

		returnMap.put("resultCnt", resultCnt);
		returnMap.put("searchVO", searchVO);
		return returnMap;
     }
     
     
     

    public List<CodeVO> selectList(CodeVO vo) {
        return (List<CodeVO>)defaultDao.selectList( sqlNs+"selectList" , vo); 
    }

	/*public CodeVO selectContents(CodeVO vo) {
	   return (CodeVO)defaultDao.selectOne( sqlNs+"selectContents" , vo);
       //return cdMngMapper.selectContents(vo);
    }*/

	/*public int insertContents(CodeVO vo) {
	   return defaultDao.insert(sqlNs+"insertContents" , vo);
     //return cdMngMapper.insertContents(vo);
	}*/

	/*public int updateContents(CodeVO vo) {
	    return defaultDao.update(sqlNs+"updateContents" , vo);
		//return cdMngMapper.updateContents(vo);
	}*/

	/*public int deleteContents(CodeVO vo) {
	    return defaultDao.delete(sqlNs+"deleteContents" , vo);
      //return cdMngMapper.deleteContents(vo);
	}*/

    // 코드 중복 체크
    public int selectOvlpCount(CodeVO vo) {
       CodeVO rtnVo = (CodeVO)defaultDao.selectOne(sqlNs+"selectOvlpCount" , vo);
       return Integer.parseInt(rtnVo.getRowCnt()); 
       //return cdMngMapper.selectOvlpCount(vo);
    }

    public int codeOrder(CodeVO vo) {

        // 순서 수정 시 A~F 중 F가 B자리로 이동 시

        // F는 B의 순서를 갖는다
        int cnt = defaultDao.update(sqlNs+"codeSortSource" , vo);
        //int cnt = cdMngMapper.codeSortSource(vo);
        
        
        // F를 제외한 B ~ E까지 순서 + 1
        defaultDao.update(sqlNs+"codeSortTarget" , vo);
        //cdMngMapper.codeSortTarget(vo);
        
        // 순서 재정렬
        defaultDao.update(sqlNs+"codeSortSeqo" , vo);
        //cdMngMapper.codeSortSeqo(vo);

        return cnt;
    }

}

