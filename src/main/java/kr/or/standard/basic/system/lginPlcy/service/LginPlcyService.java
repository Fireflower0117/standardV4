package kr.or.standard.basic.system.lginPlcy.service;

import java.util.List;

import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.system.lginPlcy.vo.LginPlcyVO;
import kr.or.standard.basic.system.regeps.vo.RegepsVO;
import kr.or.standard.basic.term.vo.TermsVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class LginPlcyService extends EgovAbstractServiceImpl  {
    
    
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
     
	
	// 로그인정책 건수 조회
	public int selectCount() {
	    LginPlcyVO rtnVo = (LginPlcyVO) defaultDao.selectOne( "com.opennote.standard.mapper.basic.LginPlcyMngMapper.selectPlcyCount");
	    return Integer.parseInt(rtnVo.getPlcyCount());
	}
	
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
