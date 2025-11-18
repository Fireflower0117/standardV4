package kr.or.standard.basic.system.log.acs.service;

//import com.opennote.standard.ma.sys.log.acs.vo.AcsVO;
//import com.opennote.standard.mapper.AcsLogMngMapper;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.log.acs.vo.AcsVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AcsService extends EgovAbstractServiceImpl  {
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final PaginationService paginationService; 
	private final ExcelView excelView;
    
	/*private final AcsLogMngMapper acsLogMngMapper; 
	public MaAcsService(AcsLogMngMapper acsLogMngMapper) {
		this.acsLogMngMapper = acsLogMngMapper;
	}*/
	
	public void addList(AcsVO searchVO, Model model) throws Exception{
		 
		// 탭 메뉴 최초 세팅
		if (StringUtils.isEmpty(searchVO.getSchEtc01())) {
			searchVO.setSchEtc01("01");
		}
        
		List<AcsVO> resultList = new ArrayList<>();
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);

		if ("03".equals(searchVO.getSchEtc01())) {
			// 과다접속 로그
			AcsVO rtnVo = (AcsVO)defaultDao.selectOne("opnt.basic.mapper.AcsLogMngMapper.tmchSelectCount" , searchVO);
		    paginationInfo.setTotalRecordCount( Integer.parseInt(rtnVo.getLogCnt())); 
		    
		    resultList = (List<AcsVO>) defaultDao.selectList("opnt.basic.mapper.AcsLogMngMapper.tmchSelectList", searchVO); 
		} else {
			
			AcsVO rtnVo = (AcsVO)defaultDao.selectOne("opnt.basic.mapper.AcsLogMngMapper.selectCount", searchVO); 
			paginationInfo.setTotalRecordCount(Integer.parseInt(rtnVo.getAcsLogCnt()));
			
			resultList = (List<AcsVO>)defaultDao.selectList("opnt.basic.mapper.AcsLogMngMapper.selectList", searchVO); 
		}

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
	
	}
	
	// 접속 로그 등록
	public int insertContents(AcsVO vo) {
	    return defaultDao.insert("opnt.basic.mapper.AcsLogMngMapper.insertContents", vo); 
	}

	// 접속 로그 건수 조회
	/*public int selectCount(AcsVO vo) {
		AcsVO rtnVo = (AcsVO)defaultDao.selectOne("opnt.basic.mapper.AcsLogMngMapper.selectCount", vo);
		return Integer.parseInt(rtnVo.getAcsLogCnt()); 
		//return acsLogMngMapper.selectCount(vo);
	};*/

	// 접속 로그 목록 조회
	/*public List<AcsVO> selectList(AcsVO vo) {
		return (List<AcsVO>)defaultDao.selectList("opnt.basic.mapper.AcsLogMngMapper.selectList", vo);
		// return acsLogMngMapper.selectList(vo);
	};*/

	// 과다접속 로그 건수 조회
	/*public int tmchSelectCount(AcsVO vo) {
		AcsVO rtnVo = (AcsVO)defaultDao.selectOne("opnt.basic.mapper.AcsLogMngMapper.tmchSelectCount" , vo);
		return Integer.parseInt(rtnVo.getLogCnt()); 
	};*/

	// 과다접속 로그 목록 조회
	/*public List<AcsVO> tmchSelectList(AcsVO vo) {
		return (List<AcsVO>) defaultDao.selectList("opnt.basic.mapper.AcsLogMngMapper.tmchSelectList", vo); 
	};*/

	// 시간별 접속수(현재날짜)
	public List<CommonMap> selectAcsTime() { 
		return basicDao.selectList("opnt.basic.mapper.AcsLogMngMapper.selectAcsTime");
		 
	}
}
