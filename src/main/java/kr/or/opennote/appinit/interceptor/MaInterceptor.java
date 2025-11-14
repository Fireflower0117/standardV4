package kr.or.opennote.appinit.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j 
public class MaInterceptor implements HandlerInterceptor {
	 
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		log.info("=================================== maInterceptor Start");
		String reqUri = request.getRequestURI();
		log.info("Request URI : {}",reqUri);
		
		HttpSession session = request.getSession();
 
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
