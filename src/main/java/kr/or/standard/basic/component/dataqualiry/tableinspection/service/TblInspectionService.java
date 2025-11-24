package kr.or.standard.basic.component.dataqualiry.tableinspection.service;

 
import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.component.dataqualiry.dbdata.vo.DBdataVO;
import kr.or.standard.basic.module.ExcelUtil;
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
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class TblInspectionService  extends EgovAbstractServiceImpl  {
    
    
    private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao; 
    private final MessageSource messageSource;
    private final PaginationService paginationService;
    private final ExcelView excelView;
    private final Validator validator;
    private final ExcelUtil excelUtil;
    private final FileService fileService;
     
	@Value("${spring.datasource.username}")
	private String username;
    
    private final String sqlNs = "com.standard.mapper.component.DbDataMapper.";
    
    public void addList(DBdataVO searchVO, Model model) throws Exception{
    
        
		searchVO.setTableSchema(username); // DB Schema 정보
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		DBdataVO rtnVo = (DBdataVO)defaultDao.selectOne(sqlNs+"selectTblDgnsCount",searchVO);
        int tableCount = Integer.parseInt(rtnVo.getTableCount()); 
		paginationInfo.setTotalRecordCount(tableCount);
        
        List<DBdataVO> resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectTblDgnsList",searchVO); 
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
        
    }
    
    public ModelAndView excelDownload(DBdataVO searchVO){
        
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "DB테이블설명_미표시목록";
		String url = "/standard/component/dataquality/colExplList.xlsx";

		searchVO.setTableSchema(username);	// DB Schema 정보
		searchVO.setSchEtc10("Y");			// 엑셀여부
		
		List<DBdataVO> resultList = (List<DBdataVO>)defaultDao.selectList(sqlNs+"selectTblDgnsList",searchVO); 
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);

		return mav;
    
    }
    
	// DB 테이블 설명 미표시 건수 조회
	/*public int selectTblDgnsCount(CmDbDataVO vo) {
		return dbDataMapper.selectTblDgnsCount(vo);
	}*/;

	// DB 테이블 설명 미표시 조회
	/*public List<CmDbDataVO> selectTblDgnsList(CmDbDataVO vo) {
		return dbDataMapper.selectTblDgnsList(vo);
	}*/;
	
}
