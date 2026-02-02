package kr.or.standard.basic.common.internalviewresolver.service;

import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.system.menu.servie.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.Iterator;

@Slf4j
@Service
@RequiredArgsConstructor
public class OnNameViewService {

    private final CmmnDefaultDao defaultDao;
    private final BasicCrudDao crudDao;
    private final MenuService menuService;

    public String viewResolver(HttpServletRequest request, ModelMap model) throws Exception {

        // URL을 기준으로 메뉴정보를 가져온다.
        CommonMap menuInfoMap = menuService.selectMenuByUrl(request.getRequestURI());
        model.addAttribute("menuInfoMap", menuInfoMap);

        // 전달된 ParameterKey가  searchCondition이라는 이름이 포함되면 이동하는 Page에 전달한다.
        CommonMap paramMap = new CommonMap(request);
        for(Iterator keyIter = paramMap.getKeys().iterator(); keyIter.hasNext();) {
            String key = (String) keyIter.next();
            if(key.indexOf("searchCondition") > -1 ){
                model.addAttribute(key, paramMap.get(key));
            }
        }

        // return Page를 찾는다.
        String layout  = ""+menuInfoMap.get("LAY_OUT");
        String rtnUrl = ""+menuInfoMap.get("RTN_URL");
        log.info("forward Page :: {}", layout+rtnUrl);
        return layout+rtnUrl;
    }
}
