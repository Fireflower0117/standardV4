package kr.or.standard.basic.login.service;


import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.login.vo.LoginVO;
import kr.or.standard.basic.module.EncryptUtil;
import kr.or.standard.basic.usersupport.user.vo.UserIpVO;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class MaLoginService extends EgovAbstractServiceImpl  {
 
	private final CmmnDefaultDao defaultDao; 
	private final EncryptUtil encryptUtil;
	
	private final String userMngSqlNs = "com.standard.mapper.basic.UserMngMapper."; 
	
	// 로그인
	public LoginVO getCont(LoginVO vo) {
		vo.setAuthAreaCd("MA"); 
		return (LoginVO)defaultDao.selectOne(userMngSqlNs+"getCont",vo); 
	}
	
	// 비밀번호 불일치 건수 증가
	public int pswdMsmtNocsUpdateContent(LoginVO vo) {
		return defaultDao.update(userMngSqlNs+"pswdMsmtNocsUpdateContent",vo); 
	}

	// 접근가능 IP대역 여부 체크
	public boolean userIpBrkYn(String clientIp, String userSerno) {
	
		UserIpVO userIpVO = new UserIpVO();
		userIpVO.setUserSerno(userSerno);
		userIpVO.setSchEtc00(clientIp);
		UserIpVO rtnVo = (UserIpVO)defaultDao.selectOne("com.standard.mapper.basic.UserIpMngMapper.userIpBrkYn",userIpVO);
		return rtnVo.getIpBrkYn() == 0 ? false : true; 
	}

	// 최종 접속 일시 갱신
	public int userLstAcsDtUpdateContent(LoginVO vo) {
		log.info("defaultDao : {}", defaultDao);
		return defaultDao.update(userMngSqlNs+"userLstAcsDtUpdateContent",vo); 
	}

	// 비밀번호 불일치 건수 초기화
	public int userPswdMsmtNocsClearContent(LoginVO vo) {
		return defaultDao.update(userMngSqlNs+"userPswdMsmtNocsClearContent",vo); 
	}
	
	// 비밀번호 일치여부 검사
	public boolean matchUserPswd(LoginVO vo) {
		// 비밀번호 조회
		UserVO userVO = (UserVO)defaultDao.selectOne(userMngSqlNs+"getUserPswd",vo); 
		  
		// 비밀번호 일치여부 판단
		return encryptUtil.matchBCrypt(vo.getUserPswd(), userVO.getUserPswd());
	}
}
