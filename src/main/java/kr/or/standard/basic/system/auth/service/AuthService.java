package kr.or.standard.basic.system.auth.service;

 
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.system.auth.vo.AuthVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.or.standard.basic.login.vo.LoginVO;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AuthService  extends EgovAbstractServiceImpl {
	
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	
	/*private final MenuAuthMngMapper menuAuthMngMapper; 
	public MaAuthService(MenuAuthMngMapper menuAuthMngMapper) {
		this.menuAuthMngMapper = menuAuthMngMapper;
	}*/
	
	public int selectCount(AuthVO vo) {
		AuthVO rtnVo = (AuthVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.MenuAuthMngMapper.selectCount", vo);
		return Integer.parseInt(rtnVo.getAuthCount()); 
	};
	
	public List<AuthVO> selectList(AuthVO vo) {
		return (List<AuthVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MenuAuthMngMapper.selectList", vo); 
	};

	public List<AuthVO> selectAllList() {
		return (List<AuthVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MenuAuthMngMapper.selectAllList"); 
	};

	public AuthVO selectContents(AuthVO vo) {
		return (AuthVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.MenuAuthMngMapper.selectContents", vo); 
	};

	public boolean regrCheck(AuthVO vo) {
		AuthVO rtnVo =  (AuthVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.MenuAuthMngMapper.regrCheck", vo); 
		return Integer.parseInt(rtnVo.getIsMyRegr()) == 1 ? true : false; 
	}
	
	public int insertContents(AuthVO vo){
		 
		// 그룹 권한 입력
		int result = defaultDao.insert("com.opennote.standard.mapper.basic.MenuAuthMngMapper.insertContents" , vo); 

		List<AuthVO> maAuthList = vo.getMaAuthList();

		/* 메뉴 권한 입력 */
		if (maAuthList != null) {
			if (maAuthList.size() > 0) {
				for (AuthVO authVO : maAuthList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MA");
					defaultDao.insert("com.opennote.standard.mapper.basic.MenuAuthMngMapper.authInsertContents" ,authVO ); 
				}
			}
		}

		List<AuthVO> ftAuthFtList = vo.getFtAuthList();

		/* 권한메뉴 사용자 */
		if (ftAuthFtList != null) {
			if (ftAuthFtList.size() > 0) {
				for (AuthVO authVO : ftAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("FT");
					defaultDao.insert("com.opennote.standard.mapper.basic.MenuAuthMngMapper.authInsertContents" ,authVO );  
				}
			}
		}

		List<AuthVO> myAuthFtList = vo.getMyAuthList();

		/* 권한메뉴 사용자 */
		if (myAuthFtList != null) {
			if (myAuthFtList.size() > 0) {
				for (AuthVO authVO : myAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MY"); 
					defaultDao.insert("com.opennote.standard.mapper.basic.MenuAuthMngMapper.authInsertContents" ,authVO );  
				}
			}
		}

		return result;
	}


	public int updateContents(AuthVO vo) {
		 
		// 그룹 권한 수정
		int result = defaultDao.update("com.opennote.standard.mapper.basic.MenuAuthMngMapper.updateContents" , vo);
		  
		// 기존 등록된 메뉴 권한 삭제
		defaultDao.delete("com.opennote.standard.mapper.basic.MenuAuthMngMapper.authDeleteContents", vo);
		  
		List<AuthVO> maAuthList = vo.getMaAuthList();

		/* 메뉴 권한 입력 */
		if (maAuthList != null) {
			if (maAuthList.size() > 0) {
				for (AuthVO authVO : maAuthList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MA");
					defaultDao.insert("com.opennote.standard.mapper.basic.MenuAuthMngMapper.authInsertContents" ,authVO ); 
				}
			}
		}

		List<AuthVO> ftAuthFtList = vo.getFtAuthList();

		/* 권한메뉴 사용자 */
		if (ftAuthFtList != null) {
			if (ftAuthFtList.size() > 0) {
				for (AuthVO authVO : ftAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("FT");
					defaultDao.insert("com.opennote.standard.mapper.basic.MenuAuthMngMapper.authInsertContents" ,authVO ); 
				}
			}
		}

		List<AuthVO> myAuthFtList = vo.getMyAuthList();

		/* 권한메뉴 사용자 */
		if (myAuthFtList != null) {
			if (myAuthFtList.size() > 0) {
				for (AuthVO authVO : myAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MY");
					defaultDao.insert("com.opennote.standard.mapper.basic.MenuAuthMngMapper.authInsertContents" ,authVO ); 
					 
				}
			}
		}

		return result;
	};

	public int deleteContents(AuthVO vo) {
		return defaultDao.update("com.opennote.standard.mapper.basic.MenuAuthMngMapper.deleteContents", vo); 
	};

	/*public int idOvlpSelectCount(AuthVO vo) {
		 AuthVO rtnVo = (AuthVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.MenuAuthMngMapper.deleteContents", vo);
		 return Integer.parseInt( rtnVo.getAuthCount());  
	};*/

	/*public List<AuthVO> selectMenuList(AuthVO vo) {
		return (List<AuthVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MenuAuthMngMapper.selectMenuList", vo); 
	};*/


	// 관리자 권한 취득
	public List<String> getAuthList(LoginVO vo){ 
		 List<AuthVO> rtnList = (List<AuthVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MenuAuthMngMapper.getAuthList", vo);
		 List<String> authList = new ArrayList<String>();
		 for (AuthVO authVo : rtnList){
		 	authList.add(authVo.getMenuCd()); 
		 } 
		 return authList;
	}


	// 관리자 작성 권한
	public List<AuthVO> getWrtAuthList(LoginVO vo) {
		return (List<AuthVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MenuAuthMngMapper.getWrtAuthList" , vo); 
	}


	public List<AuthVO> selectExcelList(AuthVO vo){
		return (List<AuthVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MenuAuthMngMapper.selectExcelList" , vo); 
	}
	
	
	// 권한이 가지고 있는 메뉴 조회
	public List<AuthVO> getGrpAuthIdList(AuthVO vo){
		return (List<AuthVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.MenuAuthMngMapper.getGrpAuthIdList" , vo); 
	}
	
	// 메뉴 권한 삭제
	public int menuAuthDeleteContents(String menuCd) {
		return defaultDao.delete("com.opennote.standard.mapper.basic.MenuAuthMngMapper.getGrpAuthIdList" , menuCd); 
	}
}
