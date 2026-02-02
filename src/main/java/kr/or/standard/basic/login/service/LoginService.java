package kr.or.standard.basic.login.service;


import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.login.vo.LoginVO;
import kr.or.standard.basic.login.vo.SystemPolicyVO;
import kr.or.standard.basic.common.modules.EncryptUtil;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class LoginService extends EgovAbstractServiceImpl  {

	private final MessageSource messageSource;
	private final CmmnDefaultDao defaultDao;
	private final BasicCrudDao crudDao;
	private final EncryptUtil encryptUtil;
	
	// private final String userMngSqlNs = "com.standard.mapper.basic.UserMngMapper.";
	private final String userMngSqlNs = "on.standard.system.usermanage.";


	/** 시스템 정책 정보 조회  **/
	private CommonMap getSystemConfig(){
		return crudDao.selectOne("on.standard.system.systempolicy.inqSystemPolicy");
	}



	/** 관리자 Login Process  **/
	public CommonMap maLoginProcess(LoginVO loginVO, HttpServletRequest request){

		CommonMap rtnMap = new CommonMap();
		HttpSession session = request.getSession();
		String remoteAddr = request.getRemoteAddr();

		log.info("==============   LoginService MA LoginProcess   ===================");
		log.info("userId : {}" , loginVO.getUserId());
		log.info("userPwdVal : {}" , loginVO.getUserPswd());
		log.info("remoteAddr : {}" , remoteAddr);
		log.info("====================================================================");

		// 시스템 정책 확인 (Login 실패정책, 접근IP통제, 중복로그인차단(1계정 1Session정책) ...
		CommonMap systemConfigMap = getSystemConfig();
		log.info("systemConfigMap : {}" , systemConfigMap);
		request.setAttribute("systemPolicyVo", systemConfigMap);


        // DB 사용자 정보 확인  (ID기준)
		UserVO userInfoVo = (UserVO)defaultDao.selectOne(userMngSqlNs+"inqUserInfo", loginVO );

		if (userInfoVo == null) {  // 사용자 존재 여부 판단
			rtnMap.put("message", messageSource.getMessage("login.loginFail.message", null, null));
			rtnMap.put("result", false);
			return rtnMap;
		}
		else {

			// 접근 차단 계정 여부 판단
			if("Y".equals(userInfoVo.getBrkYn())){
				rtnMap.put("message", StringUtils.defaultIfBlank(userInfoVo.getBrkComment(), "접근 차단된 계정입니다.") );
				rtnMap.put("result", false);
				return rtnMap;
			}

			// 비밀번호 동일여부  판단
			if(!userInfoVo.getUserPswd().equals(loginVO.getUserPswd()) ){ // 비밀번호가 같지 않다면.

				/**  시스템 정책 확인  **/
				if("Y".equals(systemConfigMap.get("lginLmtUseYn"))){
					/** 사용자 비밀번호 실패건수 증가(update) **/
					int effCnt = defaultDao.update(userMngSqlNs+"updateUserPswdFailCount", userInfoVo);
					log.info("updateUserPswdFailCount effCnt : {}" , effCnt);

					/*  사용자 비밀번호 실패건수가 MaxCount일 경우 사용자 계정 잠김 */
					int pwdFailCount = Integer.parseInt(userInfoVo.getPswdFailCnt()) + 1; // 기존 실패건수 + 1 = (현재실패건수)
					if(pwdFailCount >= Integer.parseInt(""+ systemConfigMap.get("lginFailLmtCnt"))){
						defaultDao.update(userMngSqlNs+"updUserPswdFailStatus", userInfoVo);
					}

				}

				rtnMap.put("message", messageSource.getMessage("login.loginFail.message", null, null));
				rtnMap.put("result", false);
				return rtnMap;
			}
			else { // 비밀번호가 같다면..

				/* 사용자 RoleList조회  */
				List<UserVO>  userAUthList = (List<UserVO>)defaultDao.selectList(userMngSqlNs+"selectUserRoleList", userInfoVo);

				List<String> authCdList = new ArrayList<String>();
				for(UserVO userAUthVo : userAUthList){
					authCdList.add(userAUthVo.getAuthId());
				}
				userInfoVo.setAuthIdList(authCdList.toString());

				/* 로그인 기록 남기기  */
				userInfoVo.setAuthAreaCd("MA");
				userInfoVo.setLoginDivCd("System");
				userInfoVo.setRemoteAddr(remoteAddr);

				defaultDao.insert(userMngSqlNs+"insUserLoginHist", userInfoVo);


				/* 로그인 실패횟수 0건, 마지막 로그인시간 Update */
				int effCnt = defaultDao.update(userMngSqlNs+"updUserFinalLogin", userInfoVo);
                // #{userId}, #{authAreaCd}, #{userRoleCd}, #{loginDivCd}, #{loginCommnet}

				/* 1계정 1세션 정책 */

				/* IP차단 여부 */

				/* 세션저장 ma_user_info */
				userInfoVo.setUserPswd("");
				session.setAttribute("userDetails", userInfoVo);

				/*  시스템 정책의 첫 Page로 이동 */
				rtnMap.put("returnUrl", ""+systemConfigMap.get("maDirectPage"));
				rtnMap.put("result", true);
			}
		}
		return rtnMap;
	}


	public void maLogout(HttpServletRequest request){
		request.getSession().invalidate();
	}





/*	// 로그인
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
		UserVO_old userVO = (UserVO_old)defaultDao.selectOne(userMngSqlNs+"getUserPswd",vo);
		  
		// 비밀번호 일치여부 판단
		return encryptUtil.matchBCrypt(vo.getUserPswd(), userVO.getUserPswd());
	}*/
}
