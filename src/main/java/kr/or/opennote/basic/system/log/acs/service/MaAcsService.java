package kr.or.opennote.basic.system.log.acs.service;

//import com.opennote.standard.ma.sys.log.acs.vo.AcsVO;
//import com.opennote.standard.mapper.AcsLogMngMapper;

import kr.or.opennote.basic.common.ajax.dao.BasicCrudDao;
import kr.or.opennote.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.opennote.basic.common.domain.CommonMap;
import kr.or.opennote.basic.system.log.acs.vo.AcsVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class MaAcsService extends EgovAbstractServiceImpl  {
    
    private final CmmnDefaultDao defaultDao;
    private final BasicCrudDao crudDao;
    
	/*private final AcsLogMngMapper acsLogMngMapper; 
	public MaAcsService(AcsLogMngMapper acsLogMngMapper) {
		this.acsLogMngMapper = acsLogMngMapper;
	}*/
	
	// 접속 로그 등록
	public int insertContents(AcsVO vo) {
	    return defaultDao.insert("opnt.basic.mapper.AcsLogMngMapper.insertContents", vo); 
	}

	// 접속 로그 건수 조회
	public int selectCount(AcsVO vo) {
		return defaultDao.insert("opnt.basic.mapper.AcsLogMngMapper.insertContents", vo);
		//return acsLogMngMapper.selectCount(vo);
	};

	// 접속 로그 목록 조회
	public List<AcsVO> selectList(AcsVO vo) {
		return (List<AcsVO>)defaultDao.selectList("opnt.basic.mapper.AcsLogMngMapper.selectList", vo);
		// return acsLogMngMapper.selectList(vo);
	};

	// 과다접속 로그 건수 조회
	public int tmchSelectCount(AcsVO vo) {
		AcsVO rtnVo = (AcsVO)defaultDao.selectOne("opnt.basic.mapper.AcsLogMngMapper.tmchSelectCount" , vo);
		return Integer.parseInt(rtnVo.getLogCnt()); 
	};

	// 과다접속 로그 목록 조회
	public List<AcsVO> tmchSelectList(AcsVO vo) {
		return (List<AcsVO>) defaultDao.selectList("opnt.basic.mapper.AcsLogMngMapper.tmchSelectList", vo); 
	};

	// 시간별 접속수(현재날짜)
	public List<CommonMap> selectAcsTime() { 
		return crudDao.selectList("opnt.basic.mapper.AcsLogMngMapper.selectAcsTime");
		 
	}
}
