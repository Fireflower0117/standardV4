package kr.or.opennote.basic.login.controller;

import kr.or.opennote.basic.login.service.MaLoginService;
import kr.or.opennote.basic.system.auth.service.AuthService;
import kr.or.opennote.basic.system.auth.vo.AuthVO;
import kr.or.opennote.basic.system.log.acs.service.MaAcsService;
import kr.or.opennote.basic.system.log.acs.vo.AcsVO;
import kr.or.opennote.basic.system.menu.servie.MenuService;
import kr.or.opennote.basic.system.menu.vo.MenuVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils; 
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.opennote.basic.login.vo.LoginVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MaLoginController {
	 
	
	private final MessageSource messageSource;
	private final MaLoginService maLoginService;
	private final MaAcsService maAcsService;
	
	private final AuthService authService;
	private final MenuService menuService;
	  
	private static final String FOLDER_PATH = "/ma/login/";
	
	@GetMapping("/") 
	public String main() {
		log.info("redirect:/ma/login.do");
		return "redirect:/ma/login.do";
	}
	
	// 로그인 화면
	@GetMapping("/ma/login.do") 
	public String login() { 
		log.info("getMapping /ma/login.do ==>> {}login", FOLDER_PATH );
		return FOLDER_PATH + "login";
	}
	
	// 로그인 처리
	@ResponseBody
	@PostMapping("/ma/login.do") 
	public ResponseEntity<?> login(@Validated(LoginVO.loginCheck.class) @ModelAttribute("loginVO") LoginVO paramLoginVO, BindingResult result, HttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();				
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
		}
		
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		String clientIp = request.getRemoteAddr();
		
		// logVO 객체 생성
		AcsVO logVO = new AcsVO();
		logVO.setAuthAreaCd("MA");
		logVO.setAcsLogIpAddr(clientIp);
		logVO.setAcsId(paramLoginVO.getUserId());
		logVO.setLginYn("N");
		
		log.info("==============================");
        log.info("userId : {}" , paramLoginVO.getUserId());
        log.info("userPwdVal : {}" , paramLoginVO.getUserPswd());
        log.info("clientIp : {}" , clientIp);
        log.info("==============================");
		
        LoginVO loginVO = maLoginService.getCont(paramLoginVO);

		if (loginVO == null) {
			// 아이디가 존재하지 않음
			map.put("message", messageSource.getMessage("login.loginFail.message", null, null));
			map.put("result", false);
			return ResponseEntity.ok(map);
		} else {
			// 비밀번호 불일치
			paramLoginVO.setAuthAreaCd("MA");
			if(!maLoginService.matchUserPswd(paramLoginVO)) {

				// 비밀번호 불일치 건수 증가
				maLoginService.pswdMsmtNocsUpdateContent(loginVO);

				// 로그
				maAcsService.insertContents(logVO);

				map.put("message", messageSource.getMessage("login.loginFail.message", null, null));
				map.put("result", false);
				return ResponseEntity.ok(map);
			}
		}

        // 차단여부 || IP차단여부에 따른 분기
        if("Y".equals(StringUtils.defaultIfBlank(loginVO.getBrkYn(), "N")) || maLoginService.userIpBrkYn(clientIp, loginVO.getUserSerno())) {
        	
        	// 접속이상로그
        	logVO.setIpErrYn("Y");
        	logVO.setLginYn("Y");
        	logVO.setRegrSerno(loginVO.getUserSerno());
        	maAcsService.insertContents(logVO);
        	
        	map.put("message", messageSource.getMessage("login.breakIp.message", null, null));
        	map.put("result", false);
        	
        // 정상 로그인
        } else {
        	
        	// 접속로그
        	logVO.setIpErrYn("N");
        	logVO.setLginYn("Y");
        	logVO.setRegrSerno(loginVO.getUserSerno());
        	maAcsService.insertContents(logVO);
        	
        	// 최종 접속 일시 갱신
        	maLoginService.userLstAcsDtUpdateContent(loginVO);
        	// 비밀번호 불일치 건수 초기화
        	maLoginService.userPswdMsmtNocsClearContent(loginVO);
        	
        	// 회원정보 세션에 할당 vo만 넣기
        	session.setAttribute("ma_user_info", loginVO);

        	// 임시 관리자 메뉴리스트 뿌려주기
        	MenuVO menuVO = (MenuVO) menuService.getMenuList("ma", loginVO.getGrpAuthId() , "MA");
        	session.setAttribute("maMenuList", menuVO.getMenuList());
        	
        	// 회원권한 세션에 할당
			// 관리자 권한 조회
			loginVO.setMenuSeCd("MA");
			List<String> userMaAuth = authService.getAuthList(loginVO);
			session.setAttribute("ma_user_auth", userMaAuth);

			// 관리자 작성 권한 조회
			List<AuthVO> userMaWrtAuth = authService.getWrtAuthList(loginVO);
			Map<String, String> maAuthMap = new HashMap<String, String>();
			List<String> maAuthBltnbMap = new ArrayList<>();
			
			for (AuthVO vo : userMaWrtAuth) {
				maAuthMap.put(vo.getMenuCd(), vo.getWrtAuthYn());
				// 공동게시판 권한있을때만 하위리스트 가져오기
				if("bltnb".equals(vo.getMenuCd())) {
        			List<MenuVO> menuBltnbList = menuService.selectMenuBltnbList(loginVO.getGrpAuthId());
        			for (MenuVO vo2 : menuBltnbList) {
        				maAuthBltnbMap.add(vo2.getMenuCd());
        			}
        			session.setAttribute("ma_bltnb_auth", maAuthBltnbMap);
        		}
			}
			session.setAttribute("ma_user_wrt_auth", maAuthMap);

        	// 메인이 있으면 메인으로, 아니면 권한 첫번째 메뉴 
			String returnUrl = "";
			String menuCd = "";
			
			// 1차 메뉴 url 없는 경우
			if(StringUtils.isEmpty(menuVO.getMenuList().get(0).getMenuUrlAddr())) {
				// 1차 메뉴코드
				menuCd = menuVO.getMenuList().get(0).getMenuCd();
				
				// 2차 메뉴 url 있는 경우
				outerLoop : for(MenuVO depth2VO : menuVO.getMenuList().get(0).getMenuList()) {
					if(depth2VO.getUprMenuCd().equals(menuCd) && depth2VO.getMenuSeqo().equals("1")) {
						menuCd = depth2VO.getMenuCd();
						
						if(!StringUtils.isEmpty(depth2VO.getMenuUrlAddr())) {
							returnUrl = depth2VO.getMenuUrlAddr();
						// 2차 메뉴 url 없는 경우 3차 메뉴 조회
						} else {
							for(MenuVO depth3VO : menuVO.getMenuList().get(0).getMenuList().get(0).getMenuList()) {
								if(depth3VO.getUprMenuCd().equals(menuCd) && depth3VO.getMenuSeqo().equals("1")) {
									if(!StringUtils.isEmpty(depth2VO.getMenuUrlAddr())) {
										returnUrl = depth3VO.getMenuUrlAddr();
										break outerLoop;
									}
								}
							}
						}
						break;
					}
				}
			} else {
				returnUrl = menuVO.getMenuList().get(0).getMenuUrlAddr();
			}
        	map.put("returnUrl", returnUrl);
        	map.put("result", true);
        }
		
		return ResponseEntity.ok(map);
	}
	
	// 로그아웃
	@RequestMapping("/ma/logout.do")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/ma/login.do";
	}
}
 