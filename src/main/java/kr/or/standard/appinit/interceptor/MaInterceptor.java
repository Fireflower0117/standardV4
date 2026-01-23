package kr.or.standard.appinit.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.standard.basic.common.ajax.service.BasicCrudService;
import kr.or.standard.basic.login.vo.LoginVO;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

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
        LoginVO loginVO = (LoginVO) session.getAttribute("user_info");  // Spring Security Details로 전환대상 ...

        if(loginVO == null) {
             // 접근가능 Public 메뉴 URL인지 확인
            crudService.selectOne("" , loginVO);
        }
        else {
            // 지금 로그인한 사용자의 권한으로 접근 가능한 메뉴인지 확인

            //if( ){

           // }
            //else{
                log.info("====== Access Permission Denied : ======");
                PrintWriter pw = response.getWriter();
                pw.println("<script>alert(\"비정상적인 접근이거나 접근권한이 없습니다.\");history.back();</script>");
                pw.flush(); pw.close();
                return false;
          //  }

            // 접근 가능한 메뉴라면  권한 조회 ( Read, Write, Update, Delete , PopupRead, PopupWrite , PupupUpdate, PopupDelete)
        }

        return true;
    }

    private boolean isAjaxRequest(HttpServletRequest request) {

        // X-Requested-With 헤더 확인
        String requestedWith = request.getHeader("X-Requested-With");

        // 만약 값이 XMLHttpRequest이면 AJAX 요청으로 판단
        return "XMLHttpRequest".equals(requestedWith);

    }

}
