package kr.or.standard.appinit.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.standard.basic.login.vo.LoginVO;
import kr.or.standard.basic.usersupport.lginPlcy.service.LginPlcyService;
import kr.or.standard.basic.usersupport.lginPlcy.vo.LginPlcyVO;
import kr.or.standard.basic.system.logo.service.LogoService;
import kr.or.standard.basic.system.logo.vo.LogoVO;
import kr.or.standard.basic.system.menu.servie.MenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Component 
public class MaInterceptor implements HandlerInterceptor {
	  
	private MenuService menuService;
	private LginPlcyService lginPlcyService;
	private LogoService logoService;

	public MaInterceptor(MenuService menuService, LginPlcyService lginPlcyService, LogoService logoService) {
		this.menuService = menuService;
		this.lginPlcyService = lginPlcyService;
		this.logoService = logoService;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		
		log.info("=================================== MaInterceptor Start ===================================");
		log.info("====== RequestURI : {} ======", request.getRequestURI());
		
		HttpSession session = request.getSession(); 
		/* ================================== 로그인 정책 세션에 담기 ==================================== */
		LginPlcyVO lginPlcyVO = (LginPlcyVO) session.getAttribute("lginPlcy_info");
		if(lginPlcyVO == null) { 
			session.setAttribute("lginPlcy_info", lginPlcyService.selectOne()); 
		}

		/* ================================== 로고 정보 세션에 저장 ==================================== */
		if(session.getAttribute("logoInfo") == null){
			Map<String, Object> logoMap = new HashMap<>();
			 
			List<LogoVO> logoList = logoService.selectActvYnItm();
			for (LogoVO logoVO : logoList){
				logoMap.put(logoVO.getItmCd(), logoVO);
			}
			session.setAttribute("logoInfo", logoMap);
		}


		/* ================================== 예외 처리 ==================================== */
		// 로그인, 로그아웃
		if (request.getRequestURI().indexOf("/ma/login.do") != -1 
				|| request.getRequestURI().indexOf("/ma/logout.do") != -1
		   ) {
			return true;
		}
		
		LoginVO loginVO = (LoginVO) session.getAttribute("ma_user_info");

		// 로그인 정보 있을 경우
		if(loginVO != null) {
			// 권한 정보
			// 로그인 시 세션에 저장된 관리자 권한 조회
			List<String> userAuth = (List<String>) session.getAttribute("ma_user_auth");	
			
			// 메뉴ID 4차 없으면 -> 3차 없으면 -> 2차 없으면 -> 1차 메뉴URL depth 구해오기
			Map<String, String> menuCdMap =  menuService.getMenuCd(request.getRequestURI());
			session.setAttribute("menuCdMap", menuCdMap);
			String menuCd = menuCdMap.get("depth4");
			if(menuCd == null){
				menuCd = menuCdMap.get("depth3");
				if(menuCd == null){
					menuCd = menuCdMap.get("depth2");
					if(menuCd == null){
						menuCd = menuCdMap.get("depth1");
					}
				}
			}
			 
			// 일반 쓰기 권한
			boolean authWrtTF = false;

			// 관리자 권한
			boolean managerWrtAuthTF = false;

			// 권한
			String wrtVal = "";
			
			//권한 여부 체크
			Boolean authCheck = false;
			Boolean bltnbCheck = false;
			// 메뉴 포함시 true
			if(userAuth.contains(menuCd)){
				authCheck = true;
			}else {
				//공통게사판 권한이 있을때 해당하는 게시판인지 체크
				if(userAuth.contains("bltnb")){
					List<String> bltnbAuth = (List<String>) session.getAttribute("ma_bltnb_auth");
					//공통게사판 메뉴 포함시 true
					if(bltnbAuth.contains(menuCd)){
						authCheck = true;
						bltnbCheck = true;
					}
				}
			}
			// 권한이 존재하지 않는데 접근 시 메세지
			if(!authCheck){
				PrintWriter pw = response.getWriter();
				pw.println("<script>alert(\"비정상적인 접근입니다.\");history.back();</script>");
				pw.flush();
				pw.close();
				return false;

			} else {
				// 로그인 시 세션에 저장된 관리자 작성 권한
				Map<String, String> authWrtMap = (Map<String, String>) session.getAttribute("ma_user_wrt_auth");
				if(bltnbCheck) {
					wrtVal = authWrtMap.get("bltnb");
				}else {
					wrtVal = authWrtMap.get(menuCd);					
				}
				// 쓰기를 위한 URL이 포함된 경우
				if( request.getRequestURI().indexOf("insertForm.do") != -1
				 || request.getRequestURI().indexOf("updateForm.do") != -1
				 || request.getRequestURI().toLowerCase().indexOf("proc") != -1) {
					// 읽기 권한만 있는 경우 비정상적인 접근 메세지
					if ("R".equals(wrtVal)) {
						response.setContentType("text/html;charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.println("<script>alert(\"비정상적인 접근입니다.\");history.back();</script>");
						pw.flush();
						pw.close();
						return false;
					}
				}

				// 관리자의 경우 모두 true로
				if ("M".equals(wrtVal)) {
					managerWrtAuthTF = true;
					authWrtTF = true;

				// 일반 쓰기 권한만 true로
				} else if ("W".equals(wrtVal)) {
					authWrtTF = true;

				}
				
				// 쓰기 권한 셋팅
				session.setAttribute("SESSION_WRITE_BTN_KEY", authWrtTF);
				// 관리자 권한 셋팅
				session.setAttribute("SESSION_MANAGER_WRITE_BTN_KEY", managerWrtAuthTF);
				// 권한 String R,W,M
				session.setAttribute("SESSION_WRITE_KEY", wrtVal);
			}
		}else {
			if(isAjaxRequest(request)){
				response.sendError(401);
				return false;
			} else {
				if(request.getRequestURI().contains("popPreview.do") 
				|| request.getRequestURI().contains("ftMenuList")
				|| request.getRequestURI().contains("maMenuList")
				|| request.getRequestURI().contains("myMenuList")
				|| request.getRequestURI().contains("ftAside")
				|| request.getRequestURI().contains("myAside")){
					return true;
				}else {					
					response.sendRedirect("/ma/login.do");
					return false;
				}
			}
		}
		return true;
	}

	private boolean isAjaxRequest(HttpServletRequest request) {
		
		// X-Requested-With 헤더 확인
        String requestedWith = request.getHeader("X-Requested-With");
        
        // 만약 값이 XMLHttpRequest이면 AJAX 요청으로 판단
        boolean isAjaxRequest = "XMLHttpRequest".equals(requestedWith);
        
        return isAjaxRequest;
        
	}

}
