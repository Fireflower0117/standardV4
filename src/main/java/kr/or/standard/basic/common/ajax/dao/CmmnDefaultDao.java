package kr.or.standard.basic.common.ajax.dao;


import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Slf4j
@Repository
public class CmmnDefaultDao {
    
    @Autowired
    private SqlSession sqlsession;  
    
     /***************************************************************************************************************/
    /*******************************            SELECT     SELECT      SELECT       ********************************/
    /***************************************************************************************************************/
 

    public List<? extends CmmnDefaultVO> selectList(String qid) {
        return selectList(qid, new CommonMap());
    }

    public List<? extends CmmnDefaultVO> selectList(String qid, CommonMap hashMap) { 
        if("selectPage".equals(hashMap.get("cmd"))){
           int rnTop = Integer.parseInt(""+hashMap.get("rn_top"));
           int rnBottom =  Integer.parseInt(""+hashMap.get("rn_bottom")); 
           hashMap.put("rn_limit", rnTop - rnBottom); 
        } 
        log.info("[DAO-SELECT] qid : {} , data : {}", qid, hashMap);
        return sqlsession.selectList(qid, hashMap);
    }
    
    
    public List<? extends CmmnDefaultVO> selectList(String qid, CmmnDefaultVO vo) { 
        if("selectPage".equals(vo.getCmd())){
           int rnTop = Integer.parseInt( vo.getRn_top());
           int rnBottom =  Integer.parseInt(vo.getRn_bottom());
            vo.setRn_limit(rnTop - rnBottom);  
        } 
        log.info("[DAO-SELECT] qid : {} , data : {}", qid, vo);
        return sqlsession.selectList(qid, vo);
    }
    
    public List<? extends CmmnDefaultVO> selectList(String qid, String key) { 
        log.info("[DAO-SELECT LIST] qid : {} , key : {}", qid, key);
        return sqlsession.selectList(qid, key);
    }


    public CmmnDefaultVO selectOne(String qid) {
        return selectOne(qid, new CommonMap());
    }

    public CmmnDefaultVO selectOne(String qid, CmmnDefaultVO vo) { 
        log.info("[DAO-SELECT-ONE]   qid : {} , vo : {} ", qid, vo);
        return sqlsession.selectOne(qid, vo);
    }  
    
    
    public CmmnDefaultVO selectOne(String qid, CommonMap condiMap) { 
        log.info("[DAO-SELECT-ONE]   qid : {} , data : {} ", qid, condiMap);
        return sqlsession.selectOne(qid, condiMap);
    }  
    
     public CmmnDefaultVO selectOne(String qid, String key) { 
        log.info("[DAO-SELECT-ONE]   qid : {} , key : {} ", qid, key);
        return sqlsession.selectOne(qid, key);
    }  
    
    
    /***************************************************************************************************************/
    /*******************************            INSERT     INSERT      INSERT       ********************************/
    /***************************************************************************************************************/
 
    public int insert(String qid, List<? extends CmmnDefaultVO> voList) {
        log.info("[DAO-INSERT-LIST DEFAULT] {}", qid );
        int effRows = 0;
        for (CmmnDefaultVO item : voList) {
            effRows += insert(qid, item);
        }
        log.info("[DAO-INSERT-LIST DEFAULT COMPLETE] qid : {}, effRows : {}", qid, effRows );
        return effRows;
    }
    
    public int insert(String qid, CmmnDefaultVO vo) { 
        log.info("[DAO-INSERT DEFAULT] qid : {} , vo : {}", qid, vo);
        int effCnt = sqlsession.insert(qid, vo);
        vo.setEffCnt(effCnt); 
        return effCnt;
    } 
    
    public int insert(String qid) {
        return insert(qid , new CmmnDefaultVO() );
    }
    
    public int insertList(String qid, List<? extends CmmnDefaultVO> voList) {
        log.info("[DAO-INSERTLIST DEFAULT] qid : {} , size : {} ", qid , voList.size() );
        int effRows = sqlsession.insert(qid, voList);
        log.info("[DAO-INSERTLIST DEFAULT COMPLETE] qid : {}, effRows : {}", qid, effRows );
        return effRows;
    } 

    /***************************************************************************************************************/
    /*******************************            UPDATE     UPDATE      UPDATE       ********************************/
    /***************************************************************************************************************/
    public int update(String qid, List<? extends CmmnDefaultVO> volist) {
        log.info("[DAO-UPDATE-LIST DEFAULT] qid : {}", qid );
        int effRows = 0;
        for (CmmnDefaultVO vo : volist) {
            effRows += update(qid, vo);
        }
        log.info("[DAO-UPDATE-LIST DEFAULT COMPLETE] qid : {} , effRows : {}", qid, effRows);
        return effRows;
    }

    public int update(String qid, CmmnDefaultVO vo) { 
        log.info("[DAO-UPDATE DEFAULT] qid : {} , vo : {}", qid, vo);
        int effCnt = sqlsession.update(qid, vo);
        vo.setEffCnt(effCnt); 
        return effCnt;
    }
     
    public int update(String qid) {
        return update(qid , new CmmnDefaultVO() );
    }

    /***************************************************************************************************************/
    /*******************************            DELETE     DELETE      DELETE       ********************************/
    /***************************************************************************************************************/
    public int delete(String qid, List<? extends CmmnDefaultVO> volist) {
        log.info("[DAO-DELETE-LIST DEFAULT] qid : {}", qid );
        int effRows = 0;
        for (CmmnDefaultVO vo : volist) {
            effRows += delete(qid, vo);
        }
        log.info("[DAO-DELETE-LIST DEFAULT COMPLETE] qid : {} , effRows : {}", qid, effRows);
        return effRows;
    }
    

    public int delete(String qid, CmmnDefaultVO vo) { 
        log.info("[DAO-DELETE DEFAULT] qid : {} , vo : {}", qid, vo);
        int effCnt = sqlsession.delete(qid, vo);
        log.info("[DAO-DELETE COMPLETE] qid : {} , effCnt : {}", qid, effCnt);
        vo.setEffCnt(effCnt); 
        return effCnt;
    }
    
     public int delete(String qid, String str) { 
        log.info("[DAO-DELETE DEFAULT] qid : {} , str : {}", qid, str);
        int effCnt = sqlsession.delete(qid, str);
        log.info("[DAO-DELETE COMPLETE] qid : {} , effCnt : {}", qid, effCnt);
        return effCnt;
    }
    
    public int delete(String qid) {
        return delete(qid , new CmmnDefaultVO() );
    }
  
  

}
