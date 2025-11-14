package kr.or.standard.basic.system.logo.service;


 
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.system.logo.vo.LogoVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class LogoService {
     
    
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    
    
    public int selectCount(LogoVO vo) {
      LogoVO rtnVo = (LogoVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.selectCount" , vo);
      return Integer.parseInt(rtnVo.getLogoCount()); 
    }

    public List<LogoVO> selectList(LogoVO vo) {
        return (List<LogoVO>) defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectList" , vo); 
    }

    public int insertContent(LogoVO vo) {
        return  defaultDao.insert("com.opennote.standard.mapper.basic.LogoMngMapper.insertContent" , vo); 
    }

    public LogoVO selectContents(LogoVO vo) { 
        return (LogoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.selectContents" , vo); 
    }

    public int updateContents(LogoVO vo) { 
        return defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.updateContents" , vo); 
    }

    public int deleteContents(LogoVO vo) {
        return defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.deleteContents" , vo); 
    }

    /* 활성화 항목 중복 등록 판단 */
    public int itmActvtYnChk(LogoVO vo) {
      LogoVO rtnVo = (LogoVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.itmActvtYnChk" , vo);
      return Integer.parseInt(rtnVo.getLogoCount()); 
    }

    /* 활성화 등록, 수정 시 기존 활성화 항목 비활성화 */
    public int updateActvtYn(LogoVO vo) { 
        return defaultDao.update("com.opennote.standard.mapper.basic.LogoMngMapper.updateActvtYn" , vo); 
        
    }

    /* 활성화 로고 정보 조회 */
    public List<LogoVO> selectActvYnItm(){ 
       return (List<LogoVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectActvYnItm"); 
    }

    /* 로고 엑셀 목록 조회 */
    public List<LogoVO> selectExcelList(LogoVO vo) {
        return (List<LogoVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.LogoMngMapper.selectExcelList", vo); 
    }

    /* 본인글 여부 확인 */
    public boolean regrCheck(LogoVO vo) {
       LogoVO rtnVo = (LogoVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.LogoMngMapper.regrCheck", vo);
       return Integer.parseInt(rtnVo.getIsRegrChk()) == 1 ? true : false; 
    }    
        
}
