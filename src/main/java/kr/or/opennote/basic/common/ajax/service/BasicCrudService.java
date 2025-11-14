package kr.or.opennote.basic.common.ajax.service;

/*import kr.or.kps.partners.common.ajax.dao.CommonDao;
import kr.or.kps.partners.common.domain.CmmnDefaultVO;
import kr.or.kps.partners.common.dto.CommonMap;
import kr.or.kps.partners.common.module.JacksonParsing;
import kr.or.kps.partners.ma.login.vo.LoginVO;
import static kr.or.kps.partners.common.module.JacksonParsing.getBody;
*/

import kr.or.opennote.basic.common.ajax.dao.BasicCrudDao;
import kr.or.opennote.basic.common.domain.CommonMap;
import kr.or.opennote.basic.login.vo.LoginVO;
import kr.or.opennote.basic.module.JacksonParsing;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
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
public class BasicCrudService {
    
    
    @Autowired 
    private BasicCrudDao basicCrudDao; 
      
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

    public CommonMap selectOne(String qid) {
        return selectOne(qid, new CommonMap());
    }

    public CommonMap selectOne(String qid, CommonMap condiMap) {
        setSessionUserInfo(condiMap);
        return basicCrudDao.selectOne(qid, condiMap);
    }
    
     public List<CommonMap> multiSelect(CommonMap paramMap) {
        
        List<CommonMap> rtnList = new ArrayList<CommonMap>();
        
        List<HashMap> selectTargetList = (List<HashMap>)paramMap.get("selectTargets"); 
        for(HashMap actionInfoMap : selectTargetList){
            String sid = ""+actionInfoMap.get("sid");
            String cmd = ""+actionInfoMap.get("cmd");
            String qid = ""+actionInfoMap.get("sql");  
            
            HashMap hCondiMap = (LinkedHashMap)actionInfoMap.get("condition");
            CommonMap condiMap = new CommonMap(hCondiMap); 
            log.info("multiSelect action sid : {} , cmd : {} , qid : {} , condiMap : {}", sid , cmd ,qid , condiMap);
            
            CommonMap rsCMap = new CommonMap(actionInfoMap); 
            if("selectOne".equals(cmd)){
                CommonMap rsMap = basicCrudDao.selectOne(qid, condiMap);
                rsCMap.put(sid+"Rs" , rsMap);
            }
            else if("selectList".equals(cmd)){
                List<CommonMap> rsList = basicCrudDao.selectList(qid, condiMap);
                rsCMap.put(sid+"Rs" , rsList);
            }
            else if("selectPage".equals(cmd)){
                List<CommonMap> rsList = basicCrudDao.selectList(qid, condiMap);
                actionInfoMap.put(sid+"Rs" , rsList);
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
            case "insertlist":
                insertlist(qid, listMap);
                break;  
            case "update":
                update(qid, listMap);
                break;
              case "updatelist": 
                updateList(qid, listMap);
                break;    
            case "delete":
                delete(qid, listMap);
                break;
            case "deletelist":
                deleteList(qid, listMap);
                break;    
        }
        
        // MultiAction
        CommonMap mainCmdMap = listMap.get(0);
        if( mainCmdMap.containsKey("multiActionCmd") ){
            String multiActionStr = ""+mainCmdMap.get("multiActionCmd");
            List<CommonMap> actionList = JacksonParsing.toList(multiActionStr);
            for(CommonMap actionMap : actionList){
                String actionCmd = ""+actionMap.get("cmd");
                String actionSql = ""+actionMap.get("sql");
                List<CommonMap> actiondataList = JacksonParsing.toList(""+actionMap.get("data"));
                setSessionUserInfo(actiondataList);  
                if("insert".equals(actionCmd)){
                    insert(actionSql, actiondataList);
                }else if("update".equals(actionCmd)){
                    update(actionSql, actiondataList);
                }else if("delete".equals(actionCmd)){
                    delete(actionSql, actiondataList);
                } 
            }  
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
            LoginVO loginVO = (LoginVO)session.getAttribute("login_user_info");
            if(loginVO != null){
                for(int i = 0; i < sqlCondiMapList.size(); i++) {
                    setSessionUserInfo(sqlCondiMapList.get(i) );
                }
            }
        }
    }

    private void setSessionUserInfo(CommonMap sqlCondiMap){
    
        ServletRequestAttributes servletReqAttr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletReqAttr.getRequest().getSession(false);
        if(session != null){
            LoginVO loginVO = (LoginVO)session.getAttribute("login_user_info");
            if(loginVO != null){
                 sqlCondiMap.put("userSerno", loginVO.getUserSerno()); 
                 sqlCondiMap.put("userId", loginVO.getUserId());
                 sqlCondiMap.put("grpAuthId", loginVO.getGrpAuthId()); 
            }
        }
    }  
}
