package kr.or.standard.appinit.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.standard.basic.common.ajax.service.BasicCrudService;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.logo.service.LogoService;
import kr.or.standard.basic.system.menu.servie.MenuService;
import kr.or.standard.basic.usersupport.lginPlcy.service.LginPlcyService;
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
public class FtInterceptor implements HandlerInterceptor {

    private final MenuService menuService;
    private final LginPlcyService lginPlcyService;
    private final LogoService logoService;
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
        if (sessionCsrfToken == null) {
            sessionCsrfToken = UUID.randomUUID().toString();
            session.setAttribute("CSRF_TOKEN", sessionCsrfToken);
        }

        // JSP 화면(Tiles header)에서 쓸 수 있도록 request 영역에 복사
        request.setAttribute("_csrf", sessionCsrfToken);


        UserVO userVO = (UserVO) session.getAttribute("userDetails");
        // 로그인 정보 있을 경우
        if(userVO == null) {
             if (  reqUri.indexOf("/ft/main.do") != -1
                || reqUri.indexOf("/ft/mainPop.do") != -1
                || reqUri.indexOf("/ft/join/") != -1
                || reqUri.indexOf("/ft/login.do") != -1
                || reqUri.indexOf("/ft/snsLogin.do") != -1
                || reqUri.indexOf("/ft/logout.do") != -1
                || reqUri.indexOf("/ft/pswdReWriteForm.do") != -1
                || reqUri.indexOf("/ft/findReWriteForm.do") != -1
                || reqUri.indexOf("/ft/findInfoVrfct.do") != -1
                || reqUri.indexOf("/ft/findInfoForm.do") != -1
            ) {
                return true;
            }
            else{
                 log.info("====== Access Permission Denied : ======");
                 PrintWriter pw = response.getWriter();
                 pw.println("<script>alert(\"비정상적인 접근이거나 접근권한이 없습니다.\");history.back();</script>");
                 pw.flush(); pw.close();
                 return false;
             }
        }
        else {


            /* ==================================  CSRF 토큰 검증 (중요!) ==================================== */
            // GET 요청(화면 이동)은 안전하므로 패스, 데이터를 조작하는 POST, PUT, DELETE 요청만 검증
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

            // 메뉴 접근가능  확인
            CommonMap condiMap = new CommonMap();
            condiMap.put("urlAddr", request.getRequestURI());
            condiMap.put("loginUserId", userVO.getUserId());
            CommonMap rtnMap = crudService.selectOne("on.standard.system.menu.selectMenuPermissionCheck" , condiMap);
            log.info("USER_AUTH ==>> {}", rtnMap);
            if(rtnMap == null) {
                returnResponseMessage(response , "비정상적인 접근이거나 접근권한이 없습니다.");
                return false;
            }

            if(!"Y".equals(rtnMap.get("READ_YN"))){
                log.info("======      Access Permission Denied      ======");
                returnResponseMessage(response , "접근권한이 없습니다.");
                return false;
            }
        }

        return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
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
