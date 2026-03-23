package kr.or.standard.appinit.interceptor;

import kr.or.standard.basic.common.ajax.service.BasicCrudService;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID;

@Slf4j
@Component
@AllArgsConstructor
public class AjaxInterceptor  implements HandlerInterceptor {

    // private final BasicCrudService crudService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String reqUri = request.getRequestURI();
        String method = request.getMethod();
        log.info("====== AjaxInterceptor RequestURI : {} , method : {} ", reqUri, method);
        log.info("====== AjaxInterceptor RequestURI : {} , method : {} ", reqUri, method);

        /*========     비동기(AJAX) 요청 여부 확인     ========*/
        String requestedWith = request.getHeader("X-Requested-With");
        if (!"XMLHttpRequest".equals(requestedWith)) {
            log.warn("비정상 접근: AJAX 요청이 아님 [{}]", request.getRemoteAddr());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Request Type");
            return false;
        }

        /*========     F/W 커스텀 헤더 확인 (웹 브라우저 콘솔 수동 입력 및 Postman 등 툴 방어)     ========*/
        String fwHeader = request.getHeader("X-ON-FRAMEWORK");
        if (!"REQ_VALID".equals(fwHeader)) {
            log.warn("비정상 접근: 프레임워크 규격을 따르지 않은 수동 호출 추정 [{}]", request.getRemoteAddr());
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized Framework Call");
            return false;
        }

        /*========     Referer(출처) 확인 (외부 사이트에서의 도용 방어)    ========*/
        String referer = request.getHeader("Referer");
        // Referer가 아예 없거나(주소창 직접입력/툴), 우리 도메인에서 온 게 아니면 차단
        // ※ 실제 운영 시에는 "http://본인서버도메인" 형식으로 변경하세요.
        if (referer == null || !referer.contains(request.getServerName())) {
            log.warn("비정상 접근: 유효하지 않은 출처(Referer) [{}]", referer);
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid Origin");
            return false;
        }

        /*========     CSRF 토큰 검증 (크로스 사이트 요청 위조 방어)    ========*/
        HttpSession session = request.getSession(false);
        if (session == null) {
            log.warn("세션 만료로 인한 AJAX 차단");
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Session Expired");
            return false;
        }


        String sessionToken = (String) session.getAttribute("CSRF_TOKEN");
        String headerToken = request.getHeader("X-CSRF-TOKEN");

        if (sessionToken == null || !sessionToken.equals(headerToken)) {
            log.warn("비정상 접근: CSRF 토큰 불일치. Session:[{}], Header:[{}]", sessionToken, headerToken);
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF Token");
            return false;
        }

        /*========     공통 변수 추출 (권한 및 쿼리 ID)    ========*/
        String qid = request.getParameter("qid");
        UserVO userInfo = (UserVO) session.getAttribute("userDetails");
        String userAuth = (userInfo != null && userInfo.getUserAuth() != null) ? userInfo.getUserAuth() : "Anonyomus";

        log.info("preHandle reqUri : {} ,  qid: {} , userAuth : {}  ", reqUri, qid , userAuth );
        /*========    SQL 네이밍 룰 기반 권한 검증 (SELECT, CUD 공통 적용)    ========*/
        if (qid != null) {
            if (qid.contains(".admin_")) {  // 관리자 쿼리 방어
                if (!"AllAdmin".equals(userAuth)) {
                    log.warn("시스템 관리자(AllAdmin)외 SQL 실행 권한 없음 : [{}]", qid);
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "해당 데이터를 처리할 권한이 없습니다.");
                    return false;
                }
            }
            else if( qid.contains(".sys_")){ // 시스템 쿼리 방어
                if (!"AllAdmin".equals(userAuth) && !"Operator".equals(userAuth) ) {
                    log.warn("시스템 관리자(AllAdmin), 시스템운영자(Operator)외 SQL 실행 권한 없음 : [{}]", qid);
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "해당 데이터를 처리할 권한이 없습니다.");
                    return false;
                }
            }
            else if( qid.contains(".member_")){ // 회원 쿼리 방어
                if ("Ready".equals(userAuth) || "Anonyomus".equals(userAuth) ) {
                    log.warn("가입승인준비자(Ready), 익명사용자(Anonyomus)외 SQL 실행 권한 없음 : [{}]", qid);
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "해당 데이터를 처리할 권한이 없습니다.");
                    return false;
                }
            }
        }

        // 정상적인 요청으로 판단
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
}
