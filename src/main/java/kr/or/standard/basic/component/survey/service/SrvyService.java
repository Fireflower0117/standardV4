package kr.or.standard.basic.component.survey.service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.service.FileService;
import kr.or.standard.basic.common.file.vo.FileVO;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.component.survey.vo.SrvyVO;
import kr.or.standard.basic.module.EncryptUtil;
import kr.or.standard.basic.system.menu.servie.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Service
@Transactional 
@RequiredArgsConstructor
public class SrvyService {

    private final FileService fileService; 
    private final PaginationService paginationService; 
    private final MessageSource messageSource;
    private final BasicCrudDao basicCrudDao;
    private final CmmnDefaultDao defaultDao;
    private final ExcelView excelView;
    
    private final String mapperNs = "standard.mapper.component.SrvyMngMapper.";
    
    /*****************************************************************************************************/
    /**************************                 MA  영억                 *********************************/
    /*****************************************************************************************************/        
    
    public void maAddList(SrvyVO searchVO, Model model)  throws Exception { 
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		
		SrvyVO rtnCountVo = (SrvyVO)defaultDao.selectOne(mapperNs+"selectCount" , searchVO);
		int srvyCount = Integer.parseInt(rtnCountVo.getSrvyCount()); 
		paginationInfo.setTotalRecordCount(srvyCount);
		model.addAttribute("paginationInfo", paginationInfo);
         
        List<SrvyVO> resultList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectList" , searchVO); 
		model.addAttribute("resultList", resultList);
    }
    
    public String maForm(SrvyVO searchVO, String procType, Model model){
        
		SrvyVO srvyVO = new SrvyVO();
		if("update".equals(procType)) {
			if(searchVO.getSrvySerno() != null) { 
				 srvyVO = selectContents(searchVO); 
			} else { 
				 return "redirect:list.do"; 
			}
		}
		srvyVO.setProcType(procType);
		model.addAttribute("cmSrvyVO", srvyVO);
		return "";
    }
    
    public void maViewPop(SrvyVO searchVO, Model model){ 
		searchVO.setSrvyClCd("ma");
		SrvyVO srvyVO = selectContents(searchVO);
		model.addAttribute("cmSrvyVO",srvyVO); 
    }
    
    public void maSrvy(SrvyVO searchVO, Model model){ 
		
		searchVO.setSchEtc00("viewPop"); 
		SrvyVO SrvyVO = selectViewContents(searchVO);
		
		model.addAttribute("sctnList",SrvyVO.getSctnList());
		model.addAttribute("qstList",SrvyVO.getQstList());
		model.addAttribute("qstItmList",SrvyVO.getQstItmList());
    }
    
    public CommonMap maInsertProc(SrvyVO searchVO, BindingResult result) throws Exception{
    	
		CommonMap returnMap = new CommonMap();
		
		
		int resultCnt = insertContents(searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		} 
		returnMap.put("returnUrl", "list.do");
		return returnMap;
    }
    
    public CommonMap maUpdateProc(SrvyVO searchVO, BindingResult result, HttpSession session) throws Exception{
    	
		CommonMap returnMap = new CommonMap();
		  
		// 관리자 또는 본인글이 아닌 경우
		if(!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} else { 
			int resultCnt = updateContents(searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
				returnMap.put("returnUrl", "updateForm.do");
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
				returnMap.put("returnUrl", "updateForm.do");
			}
		}
		return returnMap;
    }
    public CommonMap maDeleteProc(SrvyVO searchVO, BindingResult result, HttpSession session){
    	
		
		CommonMap returnMap = new CommonMap();
		
		// 관리자 또는 본인글이 아닌 경우
		if(!(boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY")) {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		} else { 
			int resultCnt = defaultDao.update(mapperNs+"deleteContents", searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
				returnMap.put("returnUrl", "list.do");
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
				returnMap.put("returnUrl", "view.do");
			}
		}
		return returnMap;
    }
    
    public void maResultPop(SrvyVO searchVO, Model model){
			
			searchVO.setSchEtc00("viewPop");
			
			SrvyVO srvyVO = selectContents(searchVO); 
			List<SrvyVO> sctnList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectSctnList" , searchVO); //섹션 리스트
			SrvyVO qstStat = getQstStat(searchVO); //답변 차트 데이터 
			searchVO.setSrvyQstSerno(srvyVO.getSrvyQstSerno());
			
			List<SrvyVO> qstList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstList" , searchVO); //항목 리스트
			List<SrvyVO> qstItmList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstItmList" , searchVO); //항목 아이템 리스트 
			model.addAttribute("cmSrvyVO",srvyVO); 
			model.addAttribute("sctnList",sctnList);
			model.addAttribute("qstStat",qstStat);
			model.addAttribute("qstList",qstList);
			model.addAttribute("qstItmList",qstItmList);  
    }
    
    public void maResultPopDetail(SrvyVO searchVO, Model model){ 
    	SrvyVO srvyVO =  (SrvyVO)defaultDao.selectOne(mapperNs+"selectRplyContents" , searchVO); 
		model.addAttribute("cmSrvyVO",srvyVO); 
    }
    
    public void maResultPopDetailAddList(SrvyVO searchVO, Model model) throws Exception {
    	
			PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
			SrvyVO srvyVO =  (SrvyVO)defaultDao.selectOne(mapperNs+"selectRplyCount" , searchVO);
			int srvyCount = Integer.parseInt(srvyVO.getSrvyCount()); 
			paginationInfo.setTotalRecordCount(srvyCount);
			model.addAttribute("paginationInfo", paginationInfo);
			searchVO.setSchEtc00("PAGE");
			 
			List<SrvyVO> rplyList = getRplyList(searchVO);  
			model.addAttribute("rplyList",rplyList);
    }
    
    public ModelAndView maExcelDownload(SrvyVO searchVO){
    	
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "";
		String url = "";
		List<SrvyVO> resultList = new ArrayList<>();
		
		if(StringUtils.isEmpty(searchVO.getExcelDivn())) {
			tit = "설문조사목록_";			
			url = "/standard/component/Srvy/srvyList.xlsx";
			resultList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectExcelList" , searchVO); 
		}else if("rply".equals(searchVO.getExcelDivn())) {
			tit = "참여자별 설문결과_";
			url = "/standard/component/Srvy/srvyRplyResult.xlsx";
			List<SrvyVO> qstList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"getQstList" , searchVO); 
			searchVO.setQstList(qstList);
			if(qstList.size() > 0) {
				resultList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectRplyExcelList" , searchVO); 
			}
			mav.addObject("qstList", qstList);
		}else if("qst".equals(searchVO.getExcelDivn())){
			tit = "항목별 설문결과_";
			url = "/standard/component/Srvy/srvyQstResult.xlsx";
			resultList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstExcelList" , searchVO); 
		}
		 
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
    }


    /*****************************************************************************************************/
    /**************************                 FT  영억                 *********************************/
    /*****************************************************************************************************/
    
    public void ftAddList(SrvyVO searchVO,Model model) throws Exception{
    
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		SrvyVO rtnCountVo = (SrvyVO)defaultDao.selectOne(mapperNs+"selectCount" , searchVO);
		int srvyCount = Integer.parseInt(rtnCountVo.getSrvyCount()); 
		paginationInfo.setTotalRecordCount(srvyCount);
		model.addAttribute("paginationInfo", paginationInfo);

		List<SrvyVO> resultList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectList" , searchVO); 
		model.addAttribute("resultList", resultList); 
    }
    
    public String ftViewPop(SrvyVO searchVO,Model model){
    	
		searchVO.setSrvyClCd("ft"); 
		SrvyVO srvyVO = selectContents(searchVO);
		
		searchVO.setSchEtc00("viewPop");
		
		SrvyVO rplyVo = (SrvyVO)defaultDao.selectOne(mapperNs+"getRplyCnt" , searchVO);
		int cnt = Integer.parseInt(rplyVo.getSrvyAnsCnt()); //참여여부 확인 
		if(!"Y".equals(srvyVO.getSrvySts()) || !"Y".equals(srvyVO.getSrvyYn()) || cnt > 0) {
			String message = "";
			if(!"Y".equals(srvyVO.getSrvySts())) {
				message = "대기 중인 설문조사 입니다.";
			}else if(!"Y".equals(srvyVO.getSrvyYn())) {
				message = "설문조사 기간이 아닙니다.";
			}else if(cnt > 0 ) {
				message = "설문에 이미 참여하셨습니다.";
			}
			model.addAttribute("message",message);
			return "redirect:list.do"; 
		} 
		model.addAttribute("cmSrvyVO",srvyVO);
		return "";
    }
    
    public void ftSrvy(SrvyVO searchVO,Model model){
    	
		searchVO.setSchEtc00("viewPop"); 
		SrvyVO SrvyVO = selectViewContents(searchVO);
		model.addAttribute("sctnList",SrvyVO.getSctnList());
		model.addAttribute("qstList",SrvyVO.getQstList());
		model.addAttribute("qstItmList",SrvyVO.getQstItmList());
    }
    
    public CommonMap ftAnsProc(SrvyVO searchVO)  throws Exception{
		
		CommonMap returnMap = new CommonMap();
		int resultCnt = insertAnsContents(searchVO); 
		if(resultCnt > 0) {
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		
		returnMap.put("returnUrl", "list.do"); 
		return returnMap; 
    }
    
    public void ftResultPop(SrvyVO searchVO , Model model)throws Exception{
    	
			searchVO.setSchEtc00("viewPop");
			SrvyVO srvyVO = selectContents(searchVO);
			
			List<SrvyVO> sctnList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectSctnList" , searchVO); //섹션 리스트
			 
			SrvyVO qstStat = getQstStat(searchVO); //답변 차트 데이터
			searchVO.setSrvyQstSerno(srvyVO.getSrvyQstSerno());
			
			List<SrvyVO> qstList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstList" , searchVO);  //항목 리스트
			List<SrvyVO> qstItmList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstItmList" , searchVO);  //항목 아이템 리스트 
			model.addAttribute("cmSrvyVO",srvyVO);
			model.addAttribute("sctnList",sctnList);
			model.addAttribute("qstStat",qstStat);
			model.addAttribute("qstList",qstList);
			model.addAttribute("qstItmList",qstItmList);
    }
    
    public void ftResultPopDetailAddList(SrvyVO searchVO, Model model)throws Exception {
    	
			PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
			
			SrvyVO srvyVO =  (SrvyVO)defaultDao.selectOne(mapperNs+"selectRplyCount" , searchVO);
			int srvyCount = Integer.parseInt(srvyVO.getSrvyCount()); 
			paginationInfo.setTotalRecordCount(srvyCount);
			model.addAttribute("paginationInfo", paginationInfo);
			searchVO.setSchEtc00("PAGE");
			 
			List<SrvyVO> rplyList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"getRplyList" , searchVO); 
			model.addAttribute("rplyList",rplyList);
    
    }
    
    public void ftResultPopDetail(SrvyVO searchVO, Model model){
    	
    	SrvyVO srvyVO = (SrvyVO)defaultDao.selectOne(mapperNs+"selectRplyContents" , searchVO);
		model.addAttribute("cmSrvyVO",srvyVO);
    }
     
	
	public SrvyVO selectContents(SrvyVO vo) {
		
		SrvyVO srvyMngVO = (SrvyVO)defaultDao.selectOne(mapperNs+"selectContents" , vo); 
		List<SrvyVO> sctnList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectSctnList" , srvyMngVO); 
		if(sctnList != null && sctnList.size() > 0) {
			for(SrvyVO tmp : sctnList) {
			
			    List<SrvyVO> SrvyList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstList" , tmp); 
				tmp.setQstList(SrvyList);
				
				for(SrvyVO qstVO : tmp.getQstList()) {
					if(qstVO.getSrvyAnsCgVal() != null && !"".equals(qstVO.getSrvyAnsCgVal())){
					    
					    List<SrvyVO> qstItmList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstItmList" , qstVO);
						qstVO.setQstItmList(qstItmList);
						
						SrvyVO rtnVo = (SrvyVO)defaultDao.selectOne(mapperNs+"selectNextSctnYn", qstVO );
						tmp.setSrvyNextSctnYn(rtnVo.getSrvyNextYn());
					}
				}
			}
		}
		srvyMngVO.setSctnList(sctnList);
		return srvyMngVO;
	}
	
	public int insertContents(SrvyVO vo) throws Exception{ 
		int result = defaultDao.insert(mapperNs+"insertContents", vo); 
		if(result > 0) {
			insertQst(vo);
		}
		 
		return result;
	}
	
	public int updateContents(SrvyVO vo) throws Exception{ 
		int result = defaultDao.update(mapperNs+"updateContents", vo); 
		if(result > 0) {
			insertQst(vo);
		}
		 
		return result;
	}
	
	// 설문 미리보기 및 설문 참여용
	public SrvyVO selectViewContents(SrvyVO vo) {
		
		SrvyVO maContSrvyMngVO = (SrvyVO)defaultDao.selectOne(mapperNs+"selectContents", vo );
		List<SrvyVO> sctnList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectSctnList" , maContSrvyMngVO); 
		List<SrvyVO> qstList = new ArrayList<>();
		List<SrvyVO> qstItemList = new ArrayList<>();
		
		if(sctnList != null && sctnList.size() > 0) {
			for(SrvyVO sctnVO : sctnList) { 
				qstList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstList" , maContSrvyMngVO);
				sctnVO.setQstList(qstList);
				qstList.addAll(sctnVO.getQstList());
				
				for(SrvyVO qstVO : sctnVO.getQstList()) {
					if(qstVO.getSrvyAnsCgVal() != null){
						List<SrvyVO> qstItmList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstItmList" , maContSrvyMngVO);
						qstItemList.addAll(qstItmList);
					}
				}
			}
		}
		maContSrvyMngVO.setSctnList(sctnList);
		maContSrvyMngVO.setQstList(qstList);
		maContSrvyMngVO.setQstItmList(qstItemList);
		
		return maContSrvyMngVO;
	}

	// 설문조사 섹션, 항목 insert
	public void insertQst(SrvyVO vo) {
		
		if(vo.getSrvySerno() != null) { 
			defaultDao.update(mapperNs+"deleteQstItmContents" , vo);
			defaultDao.update(mapperNs+"deleteQstContents" , vo);
			defaultDao.update(mapperNs+"deleteSctnContents" , vo); 
		}
		
		if(vo.getSctnList() != null && vo.getSctnList().size() > 0) {
			Iterator<SrvyVO > sctnItor = vo.getSctnList().iterator();
			while(sctnItor.hasNext()) {
				SrvyVO sctnVO = sctnItor.next();
				int resultSctn = 0;
				if(sctnVO.getSrvySctnTitl() != null) {					
					sctnVO.setSrvySerno(vo.getSrvySerno()); 
					resultSctn = defaultDao.insert(mapperNs+"insertSctnContents" , sctnVO); //섹션 insert 
				}
				if(resultSctn > 0) {
					if(sctnVO.getQstList() != null && sctnVO.getQstList().size() > 0) {
						Iterator<SrvyVO > qstItor = sctnVO.getQstList().iterator();
						while(qstItor.hasNext()) {
							SrvyVO qstVO = qstItor.next();
							int resultQst = 0;
							if(qstVO.getSrvyQstTitl() != null && qstVO.getSrvyAnsCgVal() != null && !"".equals(qstVO.getSrvyAnsCgVal())) {
								qstVO.setSrvySerno(vo.getSrvySerno());
								qstVO.setSrvySctnSerno(sctnVO.getSrvySctnSerno()); 
								resultQst = defaultDao.insert(mapperNs+"insertQstContents" , qstVO); //항목 insert
							}
							if(resultQst > 0) {										
								if(qstVO.getQstItmList() != null && qstVO.getQstItmList().size() > 0) {
									Iterator<SrvyVO > qstItmItor = qstVO.getQstItmList().iterator();
									while(qstItmItor.hasNext()) {
										SrvyVO qstItmVO = qstItmItor.next();
										boolean checkCtt = false;
										if("3".equals(qstVO.getSrvyAnsCgVal()) || "4".equals(qstVO.getSrvyAnsCgVal()) || "6".equals(qstVO.getSrvyAnsCgVal()) || "9".equals(qstVO.getSrvyAnsCgVal())) {
											if(qstItmVO.getSrvyQstItmCtt() != null) { //라디오, 체크박스 값 체크
												checkCtt = true;
											}
										}else if("8".equals(qstVO.getSrvyAnsCgVal())) {
											if(qstItmVO.getSrvyItmTpVal1() != null && qstItmVO.getSrvyItmTpVal2() != null) {//날짜 & 시간 선택 체크
												checkCtt = true;
											}
										}else {
											checkCtt = true;
										}
										
										log.info("::::::::::");
										log.info(qstItmVO.getSrvyNextSctnNo());
										log.info("::::::::::");
										
										if(checkCtt) {
											qstItmVO.setSrvySerno(vo.getSrvySerno());
											qstItmVO.setSrvySctnSerno(sctnVO.getSrvySctnSerno());
											qstItmVO.setSrvyQstSerno(qstVO.getSrvyQstSerno()); 
											defaultDao.insert(mapperNs+"insertQstItmContents" , qstItmVO); //항목 옵션 insert
										}
									} 
								} 
							}
						} 
					} 						
				}
			}
		}
	}
	
	
	// 설문 답변 insert
	public int insertAnsContents(SrvyVO vo) throws Exception{
		int result = 0;
		
		
		for (SrvyVO tmp : vo.getRplyList()) {
	    	if(tmp.getSrvyAnsCtt() != null && !"".equals(tmp.getSrvyAnsCtt())){
	    	
	    		SrvyVO srvyRplyCttVo;	
	    		if(tmp.getSrvyAnsCtt().contains("$SPLIT$")){ 
	    			 //체크박스일 때 다중 체크 시 $SPLIT$을 구분자로 문자열을 합쳐서 데이터를 저장하므로 $SPLIT$로 다시 split
	                 String srvyRplyCtt[] = tmp.getSrvyAnsCtt().split("\\$SPLIT\\$");
	                 
	                 for(int i = 0 ; i < srvyRplyCtt.length; i++){
	                 	srvyRplyCttVo = new SrvyVO();
	                 	srvyRplyCttVo.setSrvyQstItmSerno(srvyRplyCtt[i]);
	                 	SrvyVO rplyRtnVo = (SrvyVO)defaultDao.selectOne(mapperNs + "getSrvyRplyCtt" , srvyRplyCttVo );
	                 	String rplyCtt = rplyRtnVo.getSrvyQstItmCtt(); 
	                 	
	                     if(rplyCtt != null && "기타".equals(srvyRplyCtt[i])) {
	                    	 tmp.setRplyCtt(rplyCtt);
	                     }
	                     tmp.setSrvyAnsCtt(srvyRplyCtt[i]);
	                     
	                     result = defaultDao.insert(mapperNs + "insertAnsContents" , tmp);
	                      
	                 }
	            }else {
	            	
	            	srvyRplyCttVo = new SrvyVO();
	                srvyRplyCttVo.setSrvyQstItmSerno(tmp.getSrvyAnsCtt());
	                SrvyVO rplyRtnVo = (SrvyVO)defaultDao.selectOne(mapperNs + "getSrvyRplyCtt" , srvyRplyCttVo );
	            	String rplyCtt = rplyRtnVo.getSrvyQstItmCtt(); 
	            	if(rplyCtt != null && "기타".equals(rplyCtt)) {
	            		tmp.setRplyCtt(rplyCtt);
	            	}
	            	result = defaultDao.insert(mapperNs + "insertAnsContents" , tmp); 
	            }
	    	}
	    }
		
		return result;
	}
	
	// 답변 차트 데이터
	public SrvyVO getQstStat(SrvyVO searchVO) {
	
		SrvyVO ftSrvyJoinVO = (SrvyVO)defaultDao.selectOne(mapperNs+"selectContents", searchVO); 
		List<SrvyVO> sctnList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectSctnList", searchVO); 
        if(sctnList != null && sctnList.size() > 0) { 
            for(SrvyVO tmp : sctnList) {
             
            	List<SrvyVO> qstList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstList", tmp); 
            	tmp.setQstList(qstList);

                for(SrvyVO qstVO : tmp.getQstList()) {
                    if(qstVO.getSrvyAnsCgVal() != null && 7 == Integer.valueOf(qstVO.getSrvyAnsCgVal())){ //선호도
                    	SrvyVO tmpVO = (SrvyVO)defaultDao.selectOne(mapperNs+"selectQstItmContents", qstVO); 
                        int i = Integer.parseInt(tmpVO.getSrvyItmTpVal2());
                        int j = Integer.parseInt(tmpVO.getSrvyItmTpVal3());
                        List<SrvyVO> qstItemList = new ArrayList<>();
                        for (int k = i; k <= j; k++) { //선호도 점수 범위 셋팅
                            SrvyVO addvo = new SrvyVO();
                            addvo.setSrvySerno(tmpVO.getSrvySerno());
                            addvo.setSrvyQstSerno(tmpVO.getSrvyQstSerno());
                            addvo.setSrvyQstItmCtt(String.valueOf(k));
                            addvo.setSrvyAnsCgVal(qstVO.getSrvyAnsCgVal());
                            qstItemList.add(addvo);

                        }
                        qstVO.setQstItmList(qstItemList);
						
						List<SrvyVO> rplyCntList;
                        for(SrvyVO rplyVO : qstVO.getQstItmList()){
                        	rplyCntList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectRplyCntList", rplyVO); 
                        	rplyVO.setRplyList(rplyCntList);
                        }

                    }else if(qstVO.getSrvyAnsCgVal() != null && 3 <= Integer.valueOf(qstVO.getSrvyAnsCgVal()) && Integer.valueOf(qstVO.getSrvyAnsCgVal()) <= 9 && Integer.valueOf(qstVO.getSrvyAnsCgVal()) != 5){
                    	//객관식, 체크박스, 이미지, 동영상 (체크선택 가능한 경우 리스트에 답변 담기)
                    	
                    	List<SrvyVO>  qstItmList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectQstItmList", qstVO);
                    	qstVO.setQstItmList(qstItmList);
                    	List<SrvyVO> rplyCntList;
                        for(SrvyVO rplyVO : qstVO.getQstItmList()){
							rplyCntList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"selectRplyCntList", rplyVO);
                            rplyVO.setRplyList(rplyCntList);
                        }
                    }
                     
                    SrvyVO rplyCntVo = (SrvyVO)defaultDao.selectOne(mapperNs+"getRplyCnt", qstVO); 
                    qstVO.setSrvyAnsCnt(rplyCntVo.getSrvyAnsCnt());
                }
            }
        }
        ftSrvyJoinVO.setSctnList(sctnList);
        return ftSrvyJoinVO;
	}
	
	// 답변 가져오기
	public List<SrvyVO> getRplyList(SrvyVO vo) { 
        List<SrvyVO> rplyList = (List<SrvyVO>)defaultDao.selectList(mapperNs+"getRplyList", vo);
        
        if(rplyList != null && rplyList.size() > 0) {
            for(SrvyVO rplyVO : rplyList) {
                if (StringUtils.stripToNull(rplyVO.getSrvyAnsCgVal()) != null && 5 == Integer.valueOf(rplyVO.getSrvyAnsCgVal())) { //파일
                    List<FileVO> atchFileList = new ArrayList<>();

                    if (rplyVO.getSrvyAnsCtt() != null && !"".equals(rplyVO.getSrvyAnsCtt())) {
                        atchFileList = fileService.getAtchFileList(new FileVO(rplyVO.getSrvyAnsCtt()));
                    }
                    rplyVO.setAtchFileList(atchFileList);
                }
            }
        }
        
        return rplyList;
    }
    
    
    
      
    
	/*public int selectCount(SrvyVO vo) {
		return srvyMngMapper.selectCount(vo);
	}*/
	
	/*public List<SrvyVO> selectList(SrvyVO vo) {
		return srvyMngMapper.selectList(vo);
	}*/
	
	/*public List<SrvyVO> selectExcelList(SrvyVO vo) {
		return srvyMngMapper.selectExcelList(vo);
	}*/
	
	/*public List<SrvyVO> selectQstExcelList(SrvyVO vo) {
		return srvyMngMapper.selectQstExcelList(vo);
	}*/
	
	/*public List<SrvyVO> selectRplyExcelList(SrvyVO vo) {
		return srvyMngMapper.selectRplyExcelList(vo);
	}*/
	
	/*public List<SrvyVO> selectSctnList(SrvyVO vo) {
		return srvyMngMapper.selectSctnList(vo);
	}*/
	
	/*public List<SrvyVO> selectQstList(SrvyVO vo) {
		return srvyMngMapper.selectQstList(vo);
	}*/
	
	/*public List<SrvyVO> selectQstItmList(SrvyVO vo) {
		return srvyMngMapper.selectQstItmList(vo);
	}*/
	
	/*public List<SrvyVO> getQstList(SrvyVO vo) {
		return srvyMngMapper.getQstList(vo);
	}*/
	
	/*public int deleteContents(SrvyVO vo) {
		return srvyMngMapper.deleteContents(vo);
	}*/
	
	/*public int getRplyCnt(SrvyVO vo) {
		return srvyMngMapper.getRplyCnt(vo);
	}*/

	
	/*public int selectRplyCount(SrvyVO vo) {
		return srvyMngMapper.selectRplyCount(vo);
	}*/
	
	/*public SrvyVO selectRplyContents(SrvyVO vo) { 
	 	return srvyMngMapper.selectRplyContents(vo); 
	}*/


}
