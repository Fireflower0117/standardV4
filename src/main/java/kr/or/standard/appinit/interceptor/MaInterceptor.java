package kr.or.standard.appinit.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.standard.basic.common.ajax.service.BasicCrudService;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

@Slf4j
@Component
@AllArgsConstructor
public class MaInterceptor implements HandlerInterceptor {

    private final BasicCrudService crudService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String reqUri = request.getRequestURI();
        String method = request.getMethod();
        log.info("====== MaInterceptor RequestURI : {} , method : {} ", reqUri, method);
        log.info("====== MaInterceptor RequestURI : {} , method : {} ", reqUri, method);

        HttpSession session = request.getSession();

        /* ==================================  CSRF 토큰 발급 및 세션 저장 ==================================== */
        // 세션에 토큰이 없으면 새로 생성하여 세션에 영구 저장 (로그아웃 전까지 유지)
        String sessionCsrfToken = (String) session.getAttribute("CSRF_TOKEN");
        log.info("====== MaInterceptor sessionCsrfToken: {} ", sessionCsrfToken);
        if (sessionCsrfToken == null) {
            sessionCsrfToken = UUID.randomUUID().toString();
            session.setAttribute("CSRF_TOKEN", sessionCsrfToken);
        }

        // JSP 화면(Tiles header)에서 쓸 수 있도록 request 영역에 복사
        log.info("====== MaInterceptor request.setAttribute _csrf : {} ", sessionCsrfToken);
        request.setAttribute("_csrf", sessionCsrfToken);



        /* ================================== 예외 처리 ==================================== */
        // 로그인, 로그아웃
        if ( reqUri.indexOf("/ma/login.do") != -1
          || reqUri.indexOf("/ma/loginProcess.do") != -1
          || reqUri.indexOf("/ma/logout.do") != -1
        ) {
            return true; // 로그인이나 로그아웃은 바로 통과
        }

        /* ==================================  CSRF 토큰 검증 (중요!) ==================================== */
        if ("POST".equalsIgnoreCase(method) || "PUT".equalsIgnoreCase(method) || "DELETE".equalsIgnoreCase(method)) {

            // 클라이언트(Ajax 또는 Form)가 보낸 헤더 토큰값 추출
            String headerToken = request.getHeader("X-CSRF-TOKEN");

            // 2. 헤더에 없으면 파라미터에서 찾기 (일반 Form Submit 용)
            if (headerToken == null || headerToken.isEmpty()) {
                headerToken = request.getParameter("_csrf");
            }

            log.info("====== CSRF 토큰 검증 _csrf : {} ", headerToken);

            // 세션의 토큰과 클라이언트가 보낸 토큰이 다르면 차단!
            if (headerToken == null || !headerToken.equals(sessionCsrfToken)) {
                log.warn("====== CSRF Token Mismatch or Missing ======");

                if (isAjaxRequest(request)) {
                    // Ajax 요청일 경우 HTTP 상태 코드 403 Forbidden 반환
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF Token");
                } else {
                    // 일반 Form 요청일 경우 알림창
                    returnResponseMessage(response, "잘못된 접근입니다. (CSRF 에러)");
                }
                return false; // 컨트롤러 진입 차단
            }
        }



        log.info("===================        접근 가능 메뉴 여부 체크        ===================");
        UserVO userVO = (UserVO) session.getAttribute("userDetails");  // Spring Security Details로 전환대상 ...

        if(userVO != null) {

            boolean isXhreq = isAjaxRequest(request);
            if(isXhreq == true ){ return true; } // ajax호출이면 통과

             // 메뉴 접근가능  확인
            CommonMap condiMap = new CommonMap();
            condiMap.put("urlAddr", request.getRequestURI());
            String menuFUncDivCd = request.getParameter("menuFuncDivCd");
            if("template".equals(menuFUncDivCd) || "board".equals(menuFUncDivCd)){
                String menuFuncCd = request.getParameter("menuFuncCd");
                if(menuFuncCd != null && menuFuncCd.trim().length() > 0){
                    condiMap.put("menuFuncCd", menuFuncCd);
                    condiMap.put("menuFUncDivCd", menuFUncDivCd);
                }
            }
            CommonMap rtnMap = crudService.selectOne("on.standard.system.menu.selectMenuPermissionCheck" , condiMap);
            log.info("USER_AUTH ==>> {}", rtnMap);
            if(rtnMap == null) {
                returnResponseMessage(response , "비정상적인 접근이거나 접근권한이 없습니다.");
                return false;
            }
            if(!"Y".equals(rtnMap.get("USE_YN"))){
                log.info("======      Access Permission Denied      ======");
                returnResponseMessage(response , "접근권한이 없습니다.");
                return false;
            }
            request.setAttribute("USER_AUTH", rtnMap);


        }
        else {
                log.info("====== Access Permission Denied : ======");

            // 접근하려던 원래 URL 및 파라미터 추출
            String requestURI  = request.getRequestURI();
            String queryString = request.getQueryString();
            String returnUrl   = requestURI + (queryString != null ? "?" + queryString : "");
            String encodedReturnUrl = java.net.URLEncoder.encode(returnUrl, "UTF-8");

            PrintWriter pw = response.getWriter();
            pw.println("<script>alert(\"비정상적인 접근이거나 접근권한이 없습니다.\");"
                     + "location.href='/ma/login.do?returnUrl=" + encodedReturnUrl + "'; "
                       +"</script>");
            pw.flush(); pw.close();
            return false;
        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 여기에 UUID 기반 token 생성후 request.setAttribute("csrfToken", token) 에 담으면 되는거야?
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    private void returnResponseMessage(HttpServletResponse response, String message) throws IOException {
        PrintWriter pw = response.getWriter();
        pw.println("<script>alert(\""+message+"\");history.back();</script>");
        pw.flush(); pw.close();
    }





    private boolean isAjaxRequest(HttpServletRequest request) {

        // X-Requested-With 헤더 확인
        String requestedWith = request.getHeader("X-Requested-With");

        // 만약 값이 XMLHttpRequest이면 AJAX 요청으로 판단
        return "XMLHttpRequest".equals(requestedWith);

    }

}
