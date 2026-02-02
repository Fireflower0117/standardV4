package kr.or.standard.appinit.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.standard.basic.common.ajax.service.BasicCrudService;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.login.vo.LoginVO;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.PrintWriter;

@Slf4j
@Component
@AllArgsConstructor
public class MaInterceptor implements HandlerInterceptor {

    private BasicCrudService crudService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {


        log.info("====== MaInterceptor RequestURI : {}  ======", request.getRequestURI());
        /* ================================== 예외 처리 ==================================== */
        // 로그인, 로그아웃
        if ( request.getRequestURI().indexOf("/ma/login.do") != -1
          || request.getRequestURI().indexOf("/ma/loginProcess.do") != -1
          || request.getRequestURI().indexOf("/ma/logout.do") != -1
        ) {
            return true; // 로그인이나 로그아웃은 바로 통과
        }

        log.info("===================        접근 가능 메뉴 여부 체크        ===================");
        HttpSession session = request.getSession();
        UserVO userVO = (UserVO) session.getAttribute("userDetails");  // Spring Security Details로 전환대상 ...

        if(userVO != null) {

             // 메뉴 접근가능  확인
            CommonMap condiMap = new CommonMap();
            condiMap.put("urlAddr", request.getRequestURI());
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
            request.setAttribute("USER_AUTH", rtnMap);

            // 시스템 운영정책 조회 후


        }
        else {
                log.info("====== Access Permission Denied : ======");
                PrintWriter pw = response.getWriter();
                pw.println("<script>alert(\"비정상적인 접근이거나 접근권한이 없습니다.\");history.back();</script>");
                pw.flush(); pw.close();
                return false;
        }

        return true;
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
