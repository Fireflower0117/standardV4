package kr.or.standard.basic.system.code.service;


 
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.system.code.vo.CodeVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class CodeService extends EgovAbstractServiceImpl {
     
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	
    /*private final CdMngMapper cdMngMapper; 
    public MaCodeService(CdMngMapper cdMngMapper) {
        this.cdMngMapper = cdMngMapper;
    }*/

    public List<CodeVO> selectList(CodeVO vo) {
        return (List<CodeVO>)defaultDao.selectList( "kr.or.kps.partners.mapper.CdMngMapper.selectList" , vo); 
        //return cdMngMapper.selectList(vo);
    }

	/*public CodeVO selectContents(CodeVO vo) {
	   return (CodeVO)defaultDao.selectOne( "kr.or.kps.partners.mapper.CdMngMapper.selectContents" , vo);
       //return cdMngMapper.selectContents(vo);
    }*/

	public int insertContents(CodeVO vo) {
	   return defaultDao.insert("kr.or.kps.partners.mapper.CdMngMapper.insertContents" , vo);
     //return cdMngMapper.insertContents(vo);
	}

	public int updateContents(CodeVO vo) {
	    return defaultDao.update("kr.or.kps.partners.mapper.CdMngMapper.updateContents" , vo);
		//return cdMngMapper.updateContents(vo);
	}

	public int deleteContents(CodeVO vo) {
	    return defaultDao.delete("kr.or.kps.partners.mapper.CdMngMapper.deleteContents" , vo);
      //return cdMngMapper.deleteContents(vo);
	}

    // 코드 중복 체크
    public int selectOvlpCount(CodeVO vo) {
       CodeVO rtnVo = (CodeVO)defaultDao.selectOne("kr.or.kps.partners.mapper.CdMngMapper.selectOvlpCount" , vo);
       return Integer.parseInt(rtnVo.getRowCnt()); 
       //return cdMngMapper.selectOvlpCount(vo);
    }

    public int codeOrder(CodeVO vo) {

        // 순서 수정 시 A~F 중 F가 B자리로 이동 시

        // F는 B의 순서를 갖는다
        int cnt = defaultDao.update("kr.or.kps.partners.mapper.CdMngMapper.codeSortSource" , vo);
        //int cnt = cdMngMapper.codeSortSource(vo);
        
        
        // F를 제외한 B ~ E까지 순서 + 1
        defaultDao.update("kr.or.kps.partners.mapper.CdMngMapper.codeSortTarget" , vo);
        //cdMngMapper.codeSortTarget(vo);
        
        // 순서 재정렬
        defaultDao.update("kr.or.kps.partners.mapper.CdMngMapper.codeSortSeqo" , vo);
        //cdMngMapper.codeSortSeqo(vo);

        return cnt;
    }

}

