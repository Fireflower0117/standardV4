package kr.or.standard.basic.common.file;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.vo.FileVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Slf4j
@Repository
public class FileDao {
    
    @Autowired
    public SqlSession sqlsession;  
    
    
     /***************************************************************************************************************/
    /*******************************            SELECT     SELECT      SELECT       ********************************/
    /***************************************************************************************************************/
 

    public List<FileVO> selectFileList(String qid) {
        return selectFileList(qid, new CommonMap());
    }

    public List<FileVO> selectFileList(String qid, CommonMap hashMap) { 
        if("selectPage".equals(hashMap.get("cmd"))){
           int rnTop = Integer.parseInt(""+hashMap.get("rn_top"));
           int rnBottom =  Integer.parseInt(""+hashMap.get("rn_bottom")); 
           hashMap.put("rn_limit", rnTop - rnBottom); 
        } 
        log.info("[DAO-SELECT FILE LIST] qid : {} , data : {}", qid, hashMap);
        return sqlsession.selectList(qid, hashMap);
    }
    
    
    public List<FileVO> selectFileList(String qid, FileVO fileVo) { 
        if("selectPage".equals(fileVo.getCmd())){
           int rnTop = Integer.parseInt(fileVo.getRn_top());
           int rnBottom =  Integer.parseInt(fileVo.getRn_bottom());
           
           fileVo.setRn_limit(rnTop - rnBottom);  
        } 
        log.info("[DAO-SELECT FILE LIST] qid : {} ,fileVo  data : {}", qid, fileVo);
        return sqlsession.selectList(qid, fileVo);
    }
    

    public FileVO selectFileOne(String qid) {
        return selectFileOne(qid, new CommonMap());
    }

    public FileVO selectFileOne(String qid, CommonMap hashMap) {
        log.info("[DAO-SELECT FILE-STRING]   qid : {} ,CommonMap data : {} ", qid, hashMap);
        return sqlsession.selectOne(qid, hashMap);
    } 
    
    public FileVO selectFileOne(String qid, FileVO fileVO) {
        log.info("[DAO-SELECT FILE-STRING]   qid : {} ,fileVO data : {} ", qid, fileVO);
        return sqlsession.selectOne(qid, fileVO);
    }
    
    public String selectFileString(String qid) {
        return selectFileString(qid, new CommonMap());
    }
    
    
    public String selectFileString(String qid, CommonMap hashMap) {
        log.info("[DAO-SELECT FILE-STRING]   qid : {} , data : {} ", qid, hashMap);
        return sqlsession.selectOne(qid, hashMap);
    }  


    /***************************************************************************************************************/
    /*******************************            INSERT     INSERT      INSERT       ********************************/
    /***************************************************************************************************************/
 
    public int insertFile(String qid, List<FileVO> fileList) {
        log.info("[DAO-INSERT FILE-LIST] {}", qid );
        int effRows = 0;
        for (FileVO filevo : fileList) {
            effRows += insertFile(qid, filevo);
        }
        log.info("[DAO-INSERT FILE-LIST] qid : {}, effRows : {}", qid, effRows );
        return effRows;
    }

    public int insertFile(String qid, FileVO filevo) { 
        log.info("[DAO-INSERT FILE] " + qid + ", " + filevo);
        int effCnt = sqlsession.insert(qid, filevo);
        filevo.setEffCnt(effCnt); 
        return effCnt;
    } 
 

    /***************************************************************************************************************/
    /*******************************            UPDATE     UPDATE      UPDATE       ********************************/
    /***************************************************************************************************************/
    public int updateFile(String qid, List<FileVO> fileList) {
        log.info("[DAO-UPDATE FILE-LIST] qid : {}", qid );
        int effRows = 0;
        for (FileVO filevo : fileList) {
            effRows += updateFile(qid, filevo);
        }
        log.info("[DAO-UPDATE FILE-LIST] qid : {} , effRows : {}", qid, effRows);
        return effRows;
    }

    public int updateFile(String qid, FileVO filevo) { 
        log.info("[DAO-UPDATE FILE] qid : {} , data : {}", qid, filevo);
        int effCnt = sqlsession.update(qid, filevo);
        filevo.setEffCnt(effCnt); 
        return effCnt;
    }

    /***************************************************************************************************************/
    /*******************************            DELETE     DELETE      DELETE       ********************************/
    /***************************************************************************************************************/
    public int deleteFile(String qid, List<FileVO> filelist) {
        log.info("[DAO-DELETE FILE-LIST] qid : {}", qid );
        int effRows = 0;
        for (FileVO filevO : filelist) {
            effRows += deleteFile(qid, filevO);
        }
        log.info("[DAO-DELETE FILE-LIST COMPLETE] qid : {} , effRows : {}", qid, effRows);
        return effRows;
    }

    public int deleteFile(String qid, FileVO filevo) { 
        log.info("[DAO-DELETE FILE] qid : {} , data : {}", qid, filevo);
        int effCnt = sqlsession.delete(qid, filevo);
        filevo.setEffCnt(effCnt); 
        return effCnt;
    }
  
     
    
}
