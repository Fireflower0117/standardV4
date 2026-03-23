package kr.or.standard.basic.common.ajax.dao;
  
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.login.vo.LoginVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Repository
public class BasicCrudDao {
    
    @Autowired
    @Resource(name = "SqlSessionTemplate")
    public SqlSession sqlsession;  
    
     /***************************************************************************************************************/
    /*******************************            SELECT     SELECT      SELECT       ********************************/
    /***************************************************************************************************************/
 

    public List<CommonMap> selectList(String qid) {
        return selectList(qid, new CommonMap());
    }

    public List<CommonMap> selectList(String qid, CommonMap hashMap) { 
        if("selectPage".equals(hashMap.get("cmd"))){
           int rnTop = Integer.parseInt(""+hashMap.get("rn_top"));
           int rnBottom =  Integer.parseInt(""+hashMap.get("rn_bottom")); 
           hashMap.put("rn_limit", rnTop - rnBottom); 
        }
        log.info("[DAO-SELECT] qid : {} , data : {}", qid, hashMap);
        return sqlsession.selectList(qid, hashMap);
    }
    
     public List<CommonMap> selectList(String qid, CmmnDefaultVO vo) { 
        if("selectPage".equals(vo.getCmd())){
           int rnTop = Integer.parseInt( vo.getRn_top());
           int rnBottom =  Integer.parseInt( vo.getRn_bottom()); 
           vo.setRn_limit(rnTop - rnBottom);  
        } 
        log.info("[DAO-SELECT] qid : {} , vo : {}", qid, vo);
        return sqlsession.selectList(qid, vo);
    }

    public CommonMap selectOne(String qid) {
        return selectOne(qid, new CommonMap());
    }

    public CommonMap selectOne(String qid, CommonMap hashMap) {
        log.info("[DAO-SELECT-ONE]   qid : {} , data : {} ", qid, hashMap);
        return sqlsession.selectOne(qid, hashMap);
    } 
    
     public CommonMap selectOne(String qid, CmmnDefaultVO vo) { 
        log.info("[DAO-SELECT-ONE]   qid : {} , vo : {} ", qid, vo);
        return sqlsession.selectOne(qid, vo);
    } 


    /***************************************************************************************************************/
    /*******************************            INSERT     INSERT      INSERT       ********************************/
    /***************************************************************************************************************/
 
    public int insert(String qid, List<CommonMap> hashMapList) {
        log.info("[DAO-INSERT-LIST] {}", qid );
        int totEffRows = 0;
        for (CommonMap item : hashMapList) {
            int effRows = sqlsession.insert(qid, item);
            item.put("execResult", effRows >= 1 ? "success" : "fail" );
            item.put("effCnt", effRows);
            totEffRows = totEffRows + effRows;
        }
        log.info("[DAO-INSERT-LIST COMPLETE] qid : {}, totEffRows : {}", qid, totEffRows );
        return totEffRows;
    }

    public int insert(String qid, CommonMap hashMap) {
        log.info("[DAO-INSERT] " + qid + ", " + hashMap);
        int effCnt = sqlsession.insert(qid, hashMap);
        hashMap.put("execResult", effCnt >= 1 ? "success" : "fail" );
        hashMap.put("effCnt", effCnt);
        log.info("[DAO-INSERT] qid : {}, effCnt : {}", qid, effCnt );
        return effCnt;
    } 
 

    /***************************************************************************************************************/
    /*******************************            UPDATE     UPDATE      UPDATE       ********************************/
    /***************************************************************************************************************/
    public int update(String qid, List<CommonMap> listMap) {
        log.info("[DAO-UPDATE-LIST] qid : {}", qid );
        int totEffRows = 0;
        for (CommonMap item : listMap) {
            int effRows = sqlsession.update(qid, item);
            item.put("execResult", effRows >= 1 ? "success" : "fail" );
            item.put("effCnt", effRows);
            totEffRows = totEffRows + effRows;
        }
        log.info("[DAO-UPDATE-LIST COMPLETE] qid : {} , totEffRows : {}", qid, totEffRows);
        return totEffRows;
    }

    public int update(String qid, CommonMap hashMap) {
        log.info("[DAO-UPDATE] qid : {} , data : {}", qid, hashMap);
        int effCnt = sqlsession.update(qid, hashMap);
        hashMap.put("execResult", effCnt >= 1 ? "success" : "fail" );
        hashMap.put("effCnt", effCnt);
        log.info("[DAO-UPDATE] qid : {} , effRows : {}", qid, effCnt);
        return effCnt;
    }

    /***************************************************************************************************************/
    /*******************************            DELETE     DELETE      DELETE       ********************************/
    /***************************************************************************************************************/
    public int delete(String qid, List<CommonMap> listMap) {
        log.info("[DAO-DELETE-LIST] qid : {}", qid );
        int totEffRows = 0;
        for (CommonMap item : listMap) {
            int effRows = delete(qid, item);
            item.put("execResult", effRows >= 1 ? "success" : "fail" );
            item.put("effCnt", effRows);
            totEffRows = totEffRows + effRows;
        }
        log.info("[DAO-DELETE-LIST COMPLETE] qid : {} , totEffRows : {}", qid, totEffRows);
        return totEffRows;
    }

    public int delete(String qid, CommonMap hashMap) {
        log.info("[DAO-DELETE] qid : {} , data : {}", qid, hashMap);
        int effCnt = sqlsession.delete(qid, hashMap);
        hashMap.put("execResult", effCnt >= 1 ? "success" : "fail" );
        hashMap.put("effCnt", effCnt);
        log.info("[DAO-DELETE] qid : {} , effRows : {}", qid, effCnt);
        return effCnt;
    }
}

