package kr.or.standard.basic.system.basic.service;

import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.module.EncryptUtil;
import kr.or.standard.basic.system.auth.service.AuthService;
import kr.or.standard.basic.system.menu.servie.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class BasicService extends EgovAbstractServiceImpl {

    private final MessageSource messageSource;
    private final CmmnDefaultDao defaultDao;
    private final BasicCrudDao crudDao;
    private final EncryptUtil encryptUtil;
    private final MenuService menuService;

    private final String userMngSqlNs = "opnt.standard.systeminit.basic.";


    public String form(HttpServletRequest request ){


        CommonMap rtnMap = menuService.selectMenuByUrl(request.getRequestURI());

        // 메뉴 테이블 수정 필요(정리)
        defaultDao.selectOne(userMngSqlNs);
        return "";
    }
}
