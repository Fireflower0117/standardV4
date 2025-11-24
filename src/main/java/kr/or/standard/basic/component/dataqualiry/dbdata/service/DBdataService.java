package kr.or.standard.basic.component.dataqualiry.dbdata.service;

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.component.dataqualiry.dbdata.vo.DBdataVO;
import kr.or.standard.basic.module.ExcelUtil;
import kr.or.standard.basic.usersupport.dictionary.word.vo.WordVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Validator;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class DBdataService extends EgovAbstractServiceImpl {
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final PaginationService paginationService;
    private final ExcelView excelView;
    	 
    private final String sqlNs = "com.standard.mapper.component.DbDataMapper.";
     
	@Value("${spring.datasource.username}")
	private String username;
	
    public void addList(DBdataVO searchVO, Model model) throws Exception {
         
		searchVO.setTableSchema(username); // DB Schema 정보
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		DBdataVO rtnVo = (DBdataVO)defaultDao.selectOne(sqlNs+"selectCount",searchVO);
        int tableCount = Integer.parseInt(rtnVo.getTableCount());
		paginationInfo.setTotalRecordCount(tableCount);
		 
        List<DBdataVO> resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectList",searchVO);  
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
    
    }
    
    public void view(DBdataVO searchVO, Model model){
        
		searchVO.setTableSchema(username); // DB Schema 정보
		// DB 테이블 상세조회
		DBdataVO cmDbDataVO = (DBdataVO)defaultDao.selectOne(sqlNs+"selectContents",searchVO);
		 
		// DB 테이블 컬럼 목록 조회 
		List<DBdataVO> colList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectColList",searchVO);

		model.addAttribute("cmDbDataVO", cmDbDataVO);
		model.addAttribute("colList", colList);
    
    }
    
    public void dataList(DBdataVO searchVO, Model model)throws Exception{
        
		searchVO.setTableSchema(username);	// DB Schema 정보

		// DB 테이블 컬럼 목록 조회 
		List<DBdataVO> colList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectColList",searchVO);
		searchVO.setColList(colList);		// DB 컬럼목록

		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		paginationInfo.setTotalRecordCount(Integer.parseInt(searchVO.getTableRows()));

		// DB 테이블 데이터 목록 조회
		
		List<CommonMap> resultList = basicDao.selectList(sqlNs+"selectDataList",searchVO);  
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
        
    }
    
    public ModelAndView excelDownload(DBdataVO searchVO){
        
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "DB테이블목록";
		String url = "/standard/component/dataquality/dbDataList.xlsx";

		searchVO.setTableSchema(username);	// DB Schema 정보
		searchVO.setSchEtc10("Y");			// 엑셀여부
		
		List<DBdataVO> resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectList",searchVO);  
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
    }
    
    
    
	// DB 테이블 건수 조회
	/*public int selectCount(DBdataVO vo) {
		return dbDataMapper.selectCount(vo);
	};*/

	// DB 테이블 목록 조회
	/*public List<DBdataVO> selectList(DBdataVO vo) {
		return dbDataMapper.selectList(vo);
	};*/

	// DB 테이블 컬럼 목록 조회
	/*public List<DBdataVO> selectColList(DBdataVO vo) {
		return dbDataMapper.selectColList(vo);
	};*/

	// DB 테이블 컬럼 목록 조회
	/*public List<HashMap<String, Object>> selectDataList(DBdataVO vo) {
		return dbDataMapper.selectDataList(vo);
	};*/

	// DB 테이블 상세 조회
	/*public DBdataVO selectContents(DBdataVO vo) {
		return dbDataMapper.selectContents(vo);
	};*/

}
