package kr.or.standard.basic.system.auth.service;

 import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
 import kr.or.standard.basic.common.domain.CommonMap;
 import kr.or.standard.basic.common.view.excel.ExcelView;
 import kr.or.standard.basic.system.auth.vo.AuthVO;
 import kr.or.standard.basic.system.menu.servie.MenuService;
 import lombok.RequiredArgsConstructor;
 import org.apache.commons.lang3.StringUtils;
 import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
 import org.springframework.context.MessageSource;
 import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.or.standard.basic.login.vo.LoginVO;
import org.springframework.ui.Model;
 import org.springframework.validation.BindingResult;
 import org.springframework.web.bind.annotation.PathVariable;
 import org.springframework.web.servlet.ModelAndView;

 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpSession;
 import java.util.ArrayList;
 import java.util.HashMap;
 import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AuthService  extends EgovAbstractServiceImpl {
	
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final PaginationService paginationService;
	private final MessageSource messageSource; 
	private final ExcelView excelView;
	private final String sqlNs = "com.standard.mapper.basic.MenuAuthMngMapper.";
 
	
	public void addList(AuthVO searchVO, Model model) throws Exception{
		
		
		AuthVO rtnVo = (AuthVO)defaultDao.selectOne(sqlNs+"selectCount", searchVO);
		int count = Integer.parseInt(rtnVo.getAuthCount()); 
		
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO);
		paginationInfo.setTotalRecordCount(count);
		model.addAttribute("paginationInfo", paginationInfo);

		List<AuthVO> resultList = (List<AuthVO>)defaultDao.selectList(sqlNs+"selectList", searchVO);  
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalRecordCount", count);
	} 
	
	public String insertUpdagteForm(AuthVO searchVO, Model model, String procType, HttpSession session){
		
		
			AuthVO authVO = new AuthVO();
	
			if("update".equals(procType)) {
	
				// 일련번호 없는 경우
				if(StringUtils.isEmpty(searchVO.getGrpAuthSerno())) {
					return "redirect:list.do";
				}
	
				// 관리자 또는 본인글인 경우
				if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
					authVO = (AuthVO)defaultDao.selectOne(sqlNs+"selectContents", searchVO);
				}else{
					return "redirect:list.do";
				}
			}
	
			authVO.setMenuSeCd("MA");
			List<AuthVO> maMenuAuthList = selectMenuList(authVO);
	
			authVO.setMenuSeCd("FT");
			List<AuthVO> ftMenuAuthList = selectMenuList(authVO);
	
			authVO.setMenuSeCd("MY");
			List<AuthVO> myMenuAuthList = selectMenuList(authVO);
	
			model.addAttribute("authVO", authVO);
			model.addAttribute("maMenuAuthList", maMenuAuthList);
			model.addAttribute("ftMenuAuthList", ftMenuAuthList);
			model.addAttribute("myMenuAuthList", myMenuAuthList);
			
			return "";
	}
	
	public CommonMap insertProc(AuthVO searchVO, HttpServletRequest request, MenuService menuService) throws Exception{
		
		
		CommonMap returnMap = new CommonMap();

		// 그룹권한ID 중복체크 
		AuthVO rtnVo = (AuthVO)defaultDao.selectOne(sqlNs+"idOvlpSelectCount", searchVO);
		int ovlpCnt = Integer.parseInt( rtnVo.getAuthCount()); 
		if(ovlpCnt > 0){
			// message는 properties
			returnMap.put("message", messageSource.getMessage("admin.message", null, null));
		}

		int resultCnt = insertContents(searchVO);

		if(resultCnt > 0) {
			// layout HTML 생성
			menuService.makeLayoutHtml(request,null, searchVO,"/ma/sys/menu/","");
			
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}

		returnMap.put("returnUrl", "list.do");
		return returnMap;
	}
	
	public CommonMap updateProc(AuthVO searchVO, HttpSession session,HttpServletRequest request, MenuService menuService) throws Exception{
		
		CommonMap returnMap = new CommonMap(); 
		// 관리자 또는 본인글인경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			int resultCnt = updateContents(searchVO);

			if(resultCnt > 0) {
				// 생성된 layout HTML 삭제 후 재생성
				menuService.delLayoutHtml(request,searchVO.getGrpAuthId());
				menuService.makeLayoutHtml(request,null, searchVO,"/ma/sys/menu/","");
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}

		returnMap.put("returnUrl", "list.do");
		return returnMap;
	}
	
	public CommonMap deleteProc(AuthVO searchVO, HttpSession session,HttpServletRequest request, MenuService menuService) throws Exception{
		
		CommonMap returnMap = new CommonMap();

		// 관리자 또는 본인글인경우
		if ((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {
			int resultCnt = defaultDao.update(sqlNs+"deleteContents", searchVO);

			if(resultCnt > 0) {
				// 생성된 layout HTML삭제
				menuService.delLayoutHtml(request,searchVO.getGrpAuthId());
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
				returnMap.put("returnUrl", "list.do");
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
				returnMap.put("returnUrl", "updateForm.do");
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("returnUrl", "list.do");
		}
		return returnMap;
	}
	
	public ModelAndView excelDownload(AuthVO searchVO){
		
		ModelAndView mav = new ModelAndView(excelView);
		String tit = "권한목록";
		String url = "/standard/system/authList.xlsx"; 
		
		List<AuthVO> resultList = (List<AuthVO>)defaultDao.selectList(sqlNs+"selectExcelList" , searchVO);
		  
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		return mav; 
	}
	
	public CommonMap idOvlpChk(AuthVO searchVO){
		
		CommonMap returnMap = new CommonMap();
		AuthVO rtnVo = (AuthVO)defaultDao.selectOne(sqlNs+"idOvlpSelectCount", searchVO);
		int ovlpCnt = Integer.parseInt( rtnVo.getAuthCount()); 
		returnMap.put("ovlpCnt", ovlpCnt);
		return returnMap;
	}
	
	/*public int selectCount(AuthVO vo) {
		AuthVO rtnVo = (AuthVO)defaultDao.selectOne(sqlNs+"selectCount", vo);
		return Integer.parseInt(rtnVo.getAuthCount()); 
	};*/
	
	/*public List<AuthVO> selectList(AuthVO vo) {
		return (List<AuthVO>)defaultDao.selectList(sqlNs+"selectList", vo); 
	};*/

	public List<AuthVO> selectAllList() {
		return (List<AuthVO>)defaultDao.selectList(sqlNs+"selectAllList"); 
	};

	/*public AuthVO selectContents(AuthVO vo) {
		return (AuthVO)defaultDao.selectOne(sqlNs+"selectContents", vo); 
	};*/

	public boolean regrCheck(AuthVO vo) {
		AuthVO rtnVo =  (AuthVO)defaultDao.selectOne(sqlNs+"regrCheck", vo); 
		return Integer.parseInt(rtnVo.getIsMyRegr()) == 1 ? true : false; 
	}
	
	public int insertContents(AuthVO vo){
		 
		// 그룹 권한 입력
		int result = defaultDao.insert(sqlNs+"insertContents" , vo); 

		List<AuthVO> maAuthList = vo.getMaAuthList();

		/* 메뉴 권한 입력 */
		if (maAuthList != null) {
			if (maAuthList.size() > 0) {
				for (AuthVO authVO : maAuthList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MA");
					defaultDao.insert(sqlNs+"authInsertContents" ,authVO ); 
				}
			}
		}

		List<AuthVO> ftAuthFtList = vo.getFtAuthList();

		/* 권한메뉴 사용자 */
		if (ftAuthFtList != null) {
			if (ftAuthFtList.size() > 0) {
				for (AuthVO authVO : ftAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("FT");
					defaultDao.insert(sqlNs+"authInsertContents" ,authVO );  
				}
			}
		}

		List<AuthVO> myAuthFtList = vo.getMyAuthList();

		/* 권한메뉴 사용자 */
		if (myAuthFtList != null) {
			if (myAuthFtList.size() > 0) {
				for (AuthVO authVO : myAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MY"); 
					defaultDao.insert(sqlNs+"authInsertContents" ,authVO );  
				}
			}
		}

		return result;
	}


	public int updateContents(AuthVO vo) {
		 
		// 그룹 권한 수정
		int result = defaultDao.update(sqlNs+"updateContents" , vo);
		  
		// 기존 등록된 메뉴 권한 삭제
		defaultDao.delete(sqlNs+"authDeleteContents", vo);
		  
		List<AuthVO> maAuthList = vo.getMaAuthList();

		/* 메뉴 권한 입력 */
		if (maAuthList != null) {
			if (maAuthList.size() > 0) {
				for (AuthVO authVO : maAuthList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MA");
					defaultDao.insert(sqlNs+"authInsertContents" ,authVO ); 
				}
			}
		}

		List<AuthVO> ftAuthFtList = vo.getFtAuthList();

		/* 권한메뉴 사용자 */
		if (ftAuthFtList != null) {
			if (ftAuthFtList.size() > 0) {
				for (AuthVO authVO : ftAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("FT");
					defaultDao.insert(sqlNs+"authInsertContents" ,authVO ); 
				}
			}
		}

		List<AuthVO> myAuthFtList = vo.getMyAuthList();

		/* 권한메뉴 사용자 */
		if (myAuthFtList != null) {
			if (myAuthFtList.size() > 0) {
				for (AuthVO authVO : myAuthFtList) {
					authVO.setGrpAuthId(vo.getGrpAuthId());
					authVO.setMenuSeCd("MY");
					defaultDao.insert(sqlNs+"authInsertContents" ,authVO ); 
					 
				}
			}
		}

		return result;
	};

	/*public int deleteContents(AuthVO vo) {
		return defaultDao.update(sqlNs+"deleteContents", vo); 
	};*/

	/*public int idOvlpSelectCount(AuthVO vo) {
		 AuthVO rtnVo = (AuthVO)defaultDao.selectOne(sqlNs+"idOvlpSelectCount", vo);
		 return Integer.parseInt( rtnVo.getAuthCount());  
	};*/

	public List<AuthVO> selectMenuList(AuthVO vo) {
		return (List<AuthVO>)defaultDao.selectList(sqlNs+"selectMenuList", vo); 
	};


	// 관리자 권한 취득
	public List<String> getAuthList(LoginVO vo){ 
		 List<AuthVO> rtnList = (List<AuthVO>)defaultDao.selectList(sqlNs+"getAuthList", vo);
		 List<String> authList = new ArrayList<String>();
		 for (AuthVO authVo : rtnList){
		 	authList.add(authVo.getMenuCd()); 
		 } 
		 return authList;
	}


	// 관리자 작성 권한
	public List<AuthVO> getWrtAuthList(LoginVO vo) {
		return (List<AuthVO>)defaultDao.selectList(sqlNs+"getWrtAuthList" , vo); 
	}


	public List<AuthVO> selectExcelList(AuthVO vo){
		return (List<AuthVO>)defaultDao.selectList(sqlNs+"selectExcelList" , vo); 
	}
	
	
	// 권한이 가지고 있는 메뉴 조회
	public List<AuthVO> getGrpAuthIdList(AuthVO vo){
		return (List<AuthVO>)defaultDao.selectList(sqlNs+"getGrpAuthIdList" , vo); 
	}
	
	// 메뉴 권한 삭제
	public int menuAuthDeleteContents(String menuCd) {
		return defaultDao.delete(sqlNs+"getGrpAuthIdList" , menuCd); 
	}
}
