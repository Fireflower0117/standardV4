package kr.or.standard.basic.common.ajax.service;

/*import kr.or.kps.partners.common.ajax.dao.CommonDao;
import kr.or.kps.partners.common.domain.CmmnDefaultVO;
import kr.or.kps.partners.common.dto.CommonMap;
import kr.or.kps.partners.common.module.JacksonParsing;
import kr.or.kps.partners.ma.login.vo.LoginVO;
import static kr.or.kps.partners.common.module.JacksonParsing.getBody;
*/

import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.modules.JacksonParsing;
import kr.or.standard.basic.usersupport.user.vo.UserVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;




@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class BasicCrudService {

    private final BasicCrudDao basicCrudDao;

    private final CmmnDefaultDao defaultDao;
    /***************************************************************************************************************/
    /*******************************            SELECT     SELECT      SELECT       ********************************/
    /***************************************************************************************************************/

    public List<CommonMap> selectList(String qid) {
        return selectList(qid, new CommonMap());
    }

    public List<CommonMap> selectList(String qid, CommonMap condiMap) {
        setSessionUserInfo(condiMap); 
        return basicCrudDao.selectList(qid, condiMap);
    }

    public List<? extends CmmnDefaultVO> selectList(String qid, CmmnDefaultVO defaultCondiVo) {
        return defaultDao.selectList(qid, defaultCondiVo);
    }

    public CommonMap selectOne(String qid) {
        return selectOne(qid, new CommonMap());
    }

    public CommonMap selectOne(String qid, CommonMap condiMap) {
        setSessionUserInfo(condiMap);
        return basicCrudDao.selectOne(qid, condiMap);
    }

    public CmmnDefaultVO selectOne(String qid, CmmnDefaultVO defaultCondiVo) {
        return defaultDao.selectOne(qid, defaultCondiVo);
    }
    
     public List<CommonMap> multiSelect(CommonMap paramMap) {
        
        List<CommonMap> rtnList = new ArrayList<CommonMap>();
        
        List<HashMap> selectTargetList = (List<HashMap>)paramMap.get("selectTargets"); 
        for(HashMap actionInfoMap : selectTargetList){
            String sid = ""+actionInfoMap.get("sid");
            String rsId = ""+actionInfoMap.get("rsId");
            String cmd = ""+actionInfoMap.get("cmd");
            String qid = ""+actionInfoMap.get("sql");  
            
            HashMap hCondiMap = (LinkedHashMap)actionInfoMap.get("sqlCondi");
            CommonMap condiMap = new CommonMap(hCondiMap); 
            log.info("multiSelect action sid : {} , rsId : {} , cmd : {} , qid : {} , condiMap : {}", sid , rsId,  cmd ,qid , condiMap);
            
            CommonMap rsCMap = new CommonMap(actionInfoMap); 
            if("selectOne".equals(cmd)){
                CommonMap rsMap = basicCrudDao.selectOne(qid, condiMap);
                rsCMap.put(rsId , rsMap);
            }
            else if("selectList".equals(cmd)){
                List<CommonMap> rsList = basicCrudDao.selectList(qid, condiMap);
                rsCMap.put(rsId , rsList);
            }
            else if("selectPage".equals(cmd)){
                List<CommonMap> rsList = basicCrudDao.selectList(qid, condiMap);
                rsCMap.put(rsId , rsList);
            }   
            rtnList.add(rsCMap); 
            log.info("============================================================" );
        } 
        return rtnList;
    }


    /***************************************************************************************************************/
    /*******************************            INSERT     INSERT      INSERT       ********************************/
    /***************************************************************************************************************/

    public int insert(String qid, CommonMap condiMap) {
        setSessionUserInfo(condiMap);
        return basicCrudDao.insert(qid, condiMap);
    }

    public int insert(String qid, List<CommonMap> listMap) {
        setSessionUserInfo(listMap);
        return basicCrudDao.insert(qid, listMap);
    }
    
    public int insertlist(String qid, List<CommonMap> listMap) {
        CommonMap actionAttrs = listMap.get(0); 
        List<CommonMap> insertData = JacksonParsing.toList(""+actionAttrs.get("insertData")); 
        setSessionUserInfo(insertData);
        return basicCrudDao.insert(qid, insertData); 
    }

    public boolean batchInsert(String qid, List<? extends CmmnDefaultVO> listMap) {
        return defaultDao.batchInsert(qid, listMap);
    }

    /***************************************************************************************************************/
    /*******************************            UPDATE     UPDATE      UPDATE       ********************************/
    /***************************************************************************************************************/
    public int update(String qid, CommonMap condiMap) {
        setSessionUserInfo(condiMap);
        return basicCrudDao.update(qid, condiMap);
    }
    
    public int update(String qid, List<CommonMap> listMap) {
        setSessionUserInfo(listMap);
        return basicCrudDao.update(qid, listMap);
    } 
    
    public int updateList(String qid, List<CommonMap> listMap) {
        CommonMap actionAttrs = listMap.get(0); 
        List<CommonMap> upateData = JacksonParsing.toList(""+actionAttrs.get("updateData")); 
        setSessionUserInfo(upateData);
        return basicCrudDao.update(qid, upateData);
    }

    public boolean batchUpdate(String qid, List<? extends CmmnDefaultVO> listMap) {
        return defaultDao.batchUpdate(qid, listMap);
    }
    
    
    
    /***************************************************************************************************************/
    /*******************************            DELETE     DELETE      DELETE       ********************************/
    /***************************************************************************************************************/
    public int delete(String qid, CommonMap condiMap) {
        setSessionUserInfo(condiMap);
        return basicCrudDao.delete(qid, condiMap);
    }

    public int delete(String qid, List<CommonMap> listMap) {
        setSessionUserInfo(listMap);
        return basicCrudDao.delete(qid, listMap);
    }
    
    public int deleteList(String qid, List<CommonMap> listMap) {
         CommonMap actionAttrs = listMap.get(0); 
        List<CommonMap> deleteData = JacksonParsing.toList(""+actionAttrs.get("deleteData")); 
        setSessionUserInfo(deleteData);
        return basicCrudDao.delete(qid, deleteData); 
    }

    public boolean batchDelete(String qid, List<? extends CmmnDefaultVO> listMap) {
        return defaultDao.batchDelete(qid, listMap);
    }

    /***************************************************************************************************************/
    /**********************            MULTI_ACTION     MULTI_ACTION      MULTI_ACTION       ***********************/
    /***************************************************************************************************************/
    public int multiAction( List<CommonMap> listMap) {

        int effRowCnt = 0;
        // MultiAction
        CommonMap mainCmdMap = listMap.get(0);

        CommonMap sqlConfiMap = new CommonMap(mainCmdMap);
        sqlConfiMap.remove("multiAction");

        if( mainCmdMap.containsKey("multiAction") ){
            List<LinkedHashMap> actionList = (List<LinkedHashMap>)mainCmdMap.get("multiAction");
            for(LinkedHashMap actionMap : actionList){
                String actionCmd = ""+actionMap.get("cmd");
                String actionSql = ""+actionMap.get("sql");

                if("insert".equals(actionCmd)){
                    effRowCnt += insert(actionSql, sqlConfiMap);
                }else if("update".equals(actionCmd)){
                    effRowCnt += update(actionSql, sqlConfiMap);
                }else if("delete".equals(actionCmd)){
                    effRowCnt += delete(actionSql, sqlConfiMap);
                }
            }
        }
        return effRowCnt;
    }

 
    /***************************************************************************************************************/
    /*******************************                   MultiActionCmd               ********************************/
    /***************************************************************************************************************/
    @Transactional 
    public synchronized  String doMultiActionExecute(HttpServletRequest request, HttpServletResponse response, String method)throws IOException {
 
        String qid = request.getParameter("qid");  
        List<CommonMap> listMap = null;
        String data = JacksonParsing.getBody(request);

        if(data != null && !data.isEmpty()) {
            listMap = JacksonParsing.toList(data);
        }
        switch(method) {
            case "insert":
                insert(qid, listMap);
                break; 
           /* case "insertlist":
                insertlist(qid, listMap);
                break;  */
            case "update":
                update(qid, listMap);
                break;
            /*case "updatelist":
                updateList(qid, listMap);
                break;*/
            case "delete":
                delete(qid, listMap);
                break;
            /*case "deletelist":
                deleteList(qid, listMap);
                break;*/
            case "multiAction":
                multiAction(listMap);

        }

        return JacksonParsing.toString(listMap);

    }
    
    /***************************************************************************************************************/
    /*******************************          CommonMap into LoginUserInfo          ********************************/
    /***************************************************************************************************************/
    private void setSessionUserInfo(List<CommonMap> sqlCondiMapList){
        ServletRequestAttributes servletReqAttr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletReqAttr.getRequest().getSession(false);
        if(session != null){
            UserVO userVO = (UserVO)session.getAttribute("userDetails");
            if(userVO != null){
                String loginUserId = userVO.getUserId();
                String loginAuthId = userVO.getAuthId();
                for(CommonMap sqlCondiMap : sqlCondiMapList) {
                    sqlCondiMap.put("loginUserId", loginUserId);
                    sqlCondiMap.put("loginAuthId", loginAuthId);
                }
            }
            else {
                for(CommonMap sqlCondiMap : sqlCondiMapList) {
                    sqlCondiMap.put("loginUserId", "AnonymousUser");
                    sqlCondiMap.put("loginAuthId", "AnonymousAuth");
                }
            }
        }
    }

    private void setSessionUserInfo(CommonMap sqlCondiMap){
    
        ServletRequestAttributes servletReqAttr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletReqAttr.getRequest().getSession(false);
        if(session != null){
            UserVO userVO = (UserVO)session.getAttribute("userDetails");
            if(userVO != null){
                 sqlCondiMap.put("loginUserId", userVO.getUserId());
                 sqlCondiMap.put("loginAuthId", userVO.getAuthId());
            }
            else {
                sqlCondiMap.put("loginUserId", "AnonymousUser");
                sqlCondiMap.put("loginAuthId", "AnonymousAuth");
            }
        }
    }  
}
