package kr.or.standard.basic.system.mngr.rstMng.service;

 
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.module.EncryptUtil;
import kr.or.standard.basic.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class MngrMngService extends EgovAbstractServiceImpl  {
    
    //private final UserMngMapper userMngMapper;
	//private final UserIpMngMapper userIpMngMapper;
	//private final UserIdRstMngMapper userIdRstMngMapper;
	//private final UserScssMngMapper userScssMngMapper;
	  
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	 
	public List<UserVO> selectIpList(UserVO vo) {
		return userIpMngMapper.selectList(vo);
	}

	public int insertContents(UserVO vo) throws Exception {
		// 전화번호 암호화
		vo.setUserTelNo(EncryptUtil.getEncryptAES256(vo.getUserTelNo()));

		// 비밀번호 암호화
		if(!StringUtils.isEmpty(vo.getUserPswd())) {
			vo.setUserPswd(EncryptUtil.getEncryptBCrypt(vo.getUserPswd()));
		}

		int cnt = userMngMapper.insertContents(vo);

		// IP 삭제
		userIpMngMapper.deleteIpContents(vo);

		List<UserVO> ipList = vo.getIpList();

		if (ipList != ipList && ipList.size() > 0) {
			for (UserVO ipVO : ipList) {
				ipVO.setUserSerno(vo.getUserSerno());

				userIpMngMapper.insertIpContents(ipVO);
			}
		}

		return cnt;
	}

	// 수정
	public int updateContents(UserVO vo) throws Exception {
		// 전화번호 암호화
		vo.setUserTelNo(EncryptUtil.getEncryptAES256(vo.getUserTelNo()));

		// 비밀번호 암호화
		if(!StringUtils.isEmpty(vo.getUserPswd())) {
			vo.setUserPswd(EncryptUtil.getEncryptBCrypt(vo.getUserPswd()));
		}

		// 생성
		int cnt = userMngMapper.updateContents(vo);

		// IP 삭제
		userIpMngMapper.deleteIpContents(vo);

		List<UserVO> ipList = vo.getIpList();

		if (ipList != null && ipList.size() > 0) {
			for (UserVO ipVO : ipList) {
				ipVO.setUserSerno(vo.getUserSerno());

				userIpMngMapper.insertIpContents(ipVO);
			}
		}

		return cnt;
	}

	public int idRstSelectCount(UserVO vo){
		return userIdRstMngMapper.idRstSelectCount(vo);
	}

	public int deleteUser(UserVO vo){
		int result = 0;
		
		// 탈퇴 테이블로 이동
		result = userScssMngMapper.insertContents(vo);

		// 사용자 테이블에서 삭제
		userMngMapper.deleteUserContents(vo);

		return result;
	}

	// 월별 탈퇴추이(현재년도)
	public List<HashMap<String, Object>> selectScssUserMon() {
		return userScssMngMapper.selectScssUserMon();
	}

	// 일별 탈퇴추이
	public List<HashMap<String, Object>> selectScssUserDay(AcsStatVO vo) {
		return userScssMngMapper.selectScssUserDay(vo);
	}

	// 탈퇴회원 목록
	public List<UserVO> selectScssUserList(AcsStatVO vo) {
		return userScssMngMapper.selectScssUserList(vo);
	}

	// 탈퇴회원 건수
	public int selectScssUserCount(AcsStatVO vo) {
		return userScssMngMapper.selectScssUserCount(vo);
	};

}
