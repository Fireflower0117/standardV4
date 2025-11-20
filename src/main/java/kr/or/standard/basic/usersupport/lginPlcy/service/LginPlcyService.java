package kr.or.standard.basic.usersupport.lginPlcy.service;

import java.util.HashMap;
import java.util.List;

import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.usersupport.lginPlcy.vo.LginPlcyVO;
import kr.or.standard.basic.system.regeps.vo.RegepsVO;

import kr.or.standard.basic.usersupport.terms.vo.TermsVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

@Service
@RequiredArgsConstructor
@Transactional
public class LginPlcyService extends EgovAbstractServiceImpl  {
    
    
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
    private final AuthService authService;
    private final MessageSource messageSource;
    
    public void form(Model model){
    	
		LginPlcyVO lginPlcyVO = new LginPlcyVO();
		
		// 로그인정책 있는경우 조회
		LginPlcyVO rtnVo = (LginPlcyVO) defaultDao.selectOne( "com.opennote.standard.mapper.basic.LginPlcyMngMapper.selectPlcyCount");
	    int lginPlcyCount = Integer.parseInt(rtnVo.getPlcyCount()); 
		if(lginPlcyCount > 0) {
		
			lginPlcyVO = (LginPlcyVO) defaultDao.selectOne( "com.opennote.standard.mapper.basic.LginPlcyMngMapper.selectPlcyOne");
		}
		model.addAttribute("lginPlcyVO", lginPlcyVO);
		
		// 회원 권한 목록
		model.addAttribute("authList", authService.selectAllList());
		
		// 정규표현식 목록
		List<RegepsVO> regepsList = (List<RegepsVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.RegepsMngMapper.selectAllList");
		model.addAttribute("regepsList", regepsList);
    } 
    
    public CommonMap insertProc(LginPlcyVO searchVO, BindingResult result){
    	
		CommonMap returnMap = new CommonMap();
		int resultCnt = 0;
		LginPlcyVO rtnVo = (LginPlcyVO) defaultDao.selectOne( "com.opennote.standard.mapper.basic.LginPlcyMngMapper.selectPlcyCount");
	    int lginPlcyCount = Integer.parseInt(rtnVo.getPlcyCount()); 
		if(lginPlcyCount > 0) {
			returnMap.put("message", "등록된 로그인정책이 존재합니다. \n관리자에게 문의하세요.");
		}else {
			resultCnt = defaultDao.insert("com.opennote.standard.mapper.basic.LginPlcyMngMapper.insertContents",searchVO);  
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("insert.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
			}
		}
		
		returnMap.put("returnUrl", "form.do"); 
		return returnMap; 
    }
    
    public CommonMap updateProc(LginPlcyVO searchVO, BindingResult result){
    	
		CommonMap returnMap = new CommonMap();
		int resultCnt = 0;
		
		resultCnt = updateContents(searchVO);
		
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("update.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "form.do");
		return returnMap;
    }
	
	// 로그인정책 건수 조회
	/*public int selectCount() {
	    LginPlcyVO rtnVo = (LginPlcyVO) defaultDao.selectOne( "com.opennote.standard.mapper.basic.LginPlcyMngMapper.selectPlcyCount");
	    return Integer.parseInt(rtnVo.getPlcyCount());
	}*/
	
	// 로그인정책 단건 조회
	public LginPlcyVO selectOne() {
	    return (LginPlcyVO) defaultDao.selectOne( "com.opennote.standard.mapper.basic.LginPlcyMngMapper.selectPlcyOne");
	}

	// 로그인정책 등록
	public int insertContents(LginPlcyVO vo) {
		int result =defaultDao.insert("com.opennote.standard.mapper.basic.LginPlcyMngMapper.insertContents" , vo);

		// 탈퇴약관 정보보유기간 코드 수정
		if(result > 0) {
			TermsVO termsVO = new TermsVO();
			termsVO.setSchEtc01(vo.getScssAccPssnPrdCd());
			defaultDao.update("com.opennote.standard.mapper.basic.TermsMngMapper.updateScssContents", termsVO);
		}
		
		return result;
	}

	// 로그인정책 수정
	public int updateContents(LginPlcyVO vo) {
		int result =defaultDao.update("com.opennote.standard.mapper.basic.LginPlcyMngMapper.updateContents" , vo);
		
		// 탈퇴약관 정보보유기간 코드 수정
		if(result > 0) {
			TermsVO termsVO = new TermsVO();
			termsVO.setSchEtc01(vo.getScssAccPssnPrdCd());
			defaultDao.update("com.opennote.standard.mapper.basic.TermsMngMapper.updateScssContents", termsVO); 
		} 
		return result;
	}
	
	// 정규표현식 목록 조회
	public List<RegepsVO> selectRegepsList() { 
		return (List<RegepsVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.RegepsMngMapper.selectAllList"); 
	}

}
