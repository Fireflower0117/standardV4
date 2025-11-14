package kr.or.opennote.basic.system.menu.servie;

import kr.or.opennote.basic.bltnb.vo.BltnbVO;
import kr.or.opennote.basic.common.ajax.dao.BasicCrudDao;
import kr.or.opennote.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.opennote.basic.common.domain.CommonMap;
import kr.or.opennote.basic.system.auth.service.AuthService;
import kr.or.opennote.basic.system.auth.vo.AuthVO;
import kr.or.opennote.basic.system.contTmpl.vo.ContTmplVO;
import kr.or.opennote.basic.system.menu.vo.MenuVO;
import kr.or.opennote.basic.system.stat.acsStat.vo.AcsStatVO;
import lombok.RequiredArgsConstructor;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.collections.CollectionUtils;

import org.springframework.cache.annotation.Cacheable;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
@Transactional
public class MenuService extends EgovAbstractServiceImpl {
    
    @Value("${file.env.divn}")
	private String FILE_ENV_DIVN;
	 
	private final BasicCrudDao basicDao; 
	private final CmmnDefaultDao defaultDao;
	private final AuthService authService;
	
	
	// 메뉴관리 메뉴목록 조회
	public List<MenuVO> selectList(MenuVO vo) {
		return (List<MenuVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.menuMngMapper.selectList", vo); 
	};
	
	
	// Excel 메뉴목록 조회
	public List<MenuVO> selectExcelList(MenuVO vo) {
		return (List<MenuVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.menuMngMapper.selectExcelList", vo); 
	};
	
	// header 공통게시판 리스트 조회
	@Cacheable("bltnbMenuList")
	public List<MenuVO> selectMenuBltnbList(String grpAuthId) {
		return (List<MenuVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.menuMngMapper.selectMenuBltnbList", grpAuthId); 
	};
	
	
	// header 메뉴목록 조회
	public List<MenuVO> selectMenuList(MenuVO vo) {
		return (List<MenuVO>)defaultDao.selectList("com.opennote.standard.mapper.basic.menuMngMapper.selectMenuList", vo); 
	};
	
	
	// 메뉴 상세 조회
	public MenuVO selectContents(MenuVO vo) {
		return (MenuVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.menuMngMapper.selectMenuList", vo); 
	};
	
	// 메뉴 게시판 유형 조회
	public String selectBltnbCl(CommonMap condiMap){
		BltnbVO bltnbVo = (BltnbVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.menuMngMapper.inqBltnbCl", condiMap);
		if(bltnbVo == null){ return null; }
		else return bltnbVo.getBltnbCl();
	}
	
	
	// 메뉴명 조회 
	public String selectMenuNm(String menuCd) {
		MenuVO menuvo = new MenuVO();
		menuvo.setMenuCd(menuCd);
		MenuVO rtnVo = (MenuVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.menuMngMapper.selectMenuNm", menuvo);
		if(rtnVo == null){ return null; }
		else return rtnVo.getMenuNm(); 
	};
	
	
	// 메뉴 등록
	public int insertContents(MenuVO vo){	 
		int resultInt = defaultDao.insert("com.opennote.standard.mapper.basic.menuMngMapper.insertContents", vo); 
		// 수정 성공, 컨텐츠 유형 일때
		if(resultInt > 0 && "C".equals(vo.getMenuTpCl())) {
			// 에디터 내용 등록
			this.insertContContents(vo);
		}
		return resultInt ;
	}

	// 메뉴 수정
	public int updateContents(MenuVO vo) {
		int resultInt = defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.updateContents", vo); 
		// 수정 성공, 컨텐츠 유형 일때
		if(resultInt > 0 &&  "C".equals(vo.getMenuTpCl())) {
			// 에디터 내용 수정
			resultInt = this.updateContContents(vo);	
		}
		return resultInt;
	};

	// 메뉴 삭제
	public int deleteContents(HttpServletRequest request, MenuVO vo) throws Exception{
		int resultInt = defaultDao.delete("com.opennote.standard.mapper.basic.menuMngMapper.deleteContents", vo); 
		// 삭제 성공시
		if(resultInt > 0) {
			// 게시판 유형이 컨텐츠 유형 일때
			if("C".equals(vo.getMenuTpCl())){
				// 에디터내용 삭제
				resultInt = this.deleteContContents(vo);
				// 삭제 성공시
				if(resultInt > 0) {				
					// 컨텐츠 HTML 삭제
					this.delContHtml(request,vo);
				}
			}
			//메뉴 순서 재정비
			defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.menuDeleteOrderUpdateContents", vo); 
			
			//하위메뉴 조회 후 해당 메뉴를 상위로 가지고 있는 메뉴 삭제 반복
			vo.setDivn(vo.getMenuCd());
			List<MenuVO> list = this.selectList(vo);
			if(!CollectionUtils.isEmpty(list)) {
				for(MenuVO menuVO : list) {
					this.deleteContents(request,menuVO);
				}
			}
		}
		return resultInt; 
	};
	
	// 메뉴 중복확인
	public int menuCdDuplCheck(MenuVO vo) {
		MenuVO rtnVo = (MenuVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.menuMngMapper.menuDeleteOrderUpdateContents" , vo);
		if(rtnVo == null){ return 0; }
		else return rtnVo.getMenuCnt();  
	};
	
	// 메뉴 본인글 여부 
	public boolean regrCheck(MenuVO vo) {
		MenuVO rtnVo = (MenuVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.menuMngMapper.regrCheck" , vo);
		return rtnVo.getIsMyRegr() == 1 ? true : false; 
	}
	
	// 메뉴 컨텐츠 조회
	public String selectContContents(String menuCd) {
		MenuVO rtnVo = (MenuVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.menuMngMapper.selectContContents" , menuCd);
		if(rtnVo == null){ return ""; }
		else return rtnVo.getEditrCont();   
	};
	
	// 메뉴 컨텐츠내용 등록
	public int insertContContents(MenuVO vo){
		return defaultDao.insert("com.opennote.standard.mapper.basic.menuMngMapper.insertContContents" , vo); 
	}

	// 메뉴 컨텐츠내용 수정
	public int updateContContents(MenuVO vo){
		return defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.updateContContents" , vo); 
	};

	// 메뉴 컨텐츠내용 삭제
	public int deleteContContents(MenuVO vo){
		return defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.deleteContContents" , vo); 
	};
	
	//컨텐츠 pop 건수 조회
	public int popSelectCount(ContTmplVO vo) {
		ContTmplVO rtnVo = (ContTmplVO) defaultDao.selectOne("com.opennote.standard.mapper.basic.contTmplMngMapper.popSelectCount" , vo);
		return Integer.parseInt(rtnVo.getTmplCnt());
	};
	
	//컨텐츠 pop 목록 조회
	public List<ContTmplVO> popSelectList(ContTmplVO vo) {
		return (List<ContTmplVO>) defaultDao.selectList("com.opennote.standard.mapper.basic.contTmplMngMapper.popSelectList" , vo); 
	};
	
	// 컨텐츠 즐겨찾기 건수 조회
	public int fvrtSelectCount(ContTmplVO vo) {
		ContTmplVO rtnVo = (ContTmplVO)defaultDao.selectOne("com.opennote.standard.mapper.basic.contTmplMngMapper.fvrtSelectCount" , vo); 
		return Integer.parseInt( rtnVo.getTmplCnt() );
	};
	
	// 컨텐츠 즐겨찾기 목록 조회
	public List<ContTmplVO> fvrtSelectList(ContTmplVO vo) {
		return (List<ContTmplVO>) defaultDao.selectList("com.opennote.standard.mapper.basic.contTmplMngMapper.fvrtSelectList" , vo); 
	};
	
	//컨텐츠 즐겨찾기 추가
	public int insertFvrtContents(ContTmplVO vo){
		return  defaultDao.insert("com.opennote.standard.mapper.basic.contTmplMngMapper.insertFvrtContents" , vo); 
	}
	
	//컨텐츠 즐겨찾기 삭제
	public int deleteFvrtContents(ContTmplVO vo) {
		return defaultDao.update("com.opennote.standard.mapper.basic.contTmplMngMapper.deleteFvrtContents" , vo); 
	};
	
	
	// header 메뉴리스트 조회
	public MenuVO getMenuList(String menuCd, String grpAuthId, String menuSeCd){
		
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuLvl("1");
		menuVO.setMenuCl(menuCd); 
		menuVO.setGrpAuthId(grpAuthId); 
		menuVO.setMenuSeCd(menuSeCd); 
		List<MenuVO> menuList = this.selectMenuList(menuVO);
		menuVO.setMenuList(menuList);
		for (MenuVO menuVO2 : menuVO.getMenuList()) {
			menuVO2.setMenuLvl("2");
			menuVO2.setMenuCl(menuCd); 
			menuVO2.setGrpAuthId(grpAuthId); 
			menuVO2.setMenuSeCd(menuSeCd);
			List<MenuVO> menu2List = this.selectMenuList(menuVO2);
			menuVO2.setMenuList(menu2List);
			for (MenuVO menuVO3 : menu2List) {
				menuVO3.setMenuLvl("3");
				menuVO3.setMenuCl(menuCd);
				menuVO3.setGrpAuthId(grpAuthId);
				menuVO3.setMenuSeCd(menuSeCd);
				List<MenuVO> menu3List = this.selectMenuList(menuVO3);
				menuVO3.setMenuList(menu3List);
				for (MenuVO menuVO4 : menu3List) {
					menuVO4.setMenuLvl("4");
					menuVO4.setMenuCl(menuCd);
					menuVO4.setGrpAuthId(grpAuthId);
					menuVO4.setMenuSeCd(menuSeCd);
					List<MenuVO> menu4List = this.selectMenuList(menuVO4);
					menuVO4.setMenuList(menu4List);
				}
			}
		}
		
		menuVO.setMenuLvl(null);
		menuVO.setLwrTabYn("Y");
		List<MenuVO> tabList = this.selectMenuList(menuVO);
		menuVO.setTabList(tabList);
		
		return menuVO;
	}
	
	// URL depth 구해오기
	public Map<String, String> getMenuCd(String url) throws Exception {
		Map<String, String> infoMap = new HashMap<String, String>();
		
		String regExpPttrn1 = "/([a-z]{2})/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\_]+\\.?)";
		Pattern ptn1 = Pattern.compile(regExpPttrn1);
		Matcher matcher1 = ptn1.matcher(url);
		
		String regExpPttrn2 = "/([a-z]{2})/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\_]+\\.?)";
		Pattern ptn2 = Pattern.compile(regExpPttrn2);
		Matcher matcher2 = ptn2.matcher(url);

		String regExpPttrn3 = "/([a-z]{2})/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\_]+\\.?)";
		Pattern ptn3 = Pattern.compile(regExpPttrn3);
		Matcher matcher3 = ptn3.matcher(url);
		
		String regExpPttrn4 = "/([a-z]{2})/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\_]+)/([a-zA-Z0-9\\\\_]+)/([a-zA-Z0-9\\\\_]+)/([a-zA-Z0-9\\_]+\\.?)";
		Pattern ptn4 = Pattern.compile(regExpPttrn4);
		Matcher matcher4 = ptn4.matcher(url);

		if(matcher4.find()) {
			infoMap.put("depth0", matcher4.group(1));
			infoMap.put("depth1", matcher4.group(2));
			infoMap.put("depth2", matcher4.group(3));
			infoMap.put("depth3", matcher4.group(4));
			infoMap.put("depth4", matcher4.group(5));
		}else if(matcher3.find()) {
			infoMap.put("depth0", matcher3.group(1));
			infoMap.put("depth1", matcher3.group(2));
			infoMap.put("depth2", matcher3.group(3));
			infoMap.put("depth3", matcher3.group(4));
		}else if(matcher2.find()) {
			infoMap.put("depth0", matcher2.group(1));
			infoMap.put("depth1", matcher2.group(2));
			infoMap.put("depth2", matcher2.group(3));
		}else if(matcher1.find()){
			infoMap.put("depth0", matcher1.group(1));
			infoMap.put("depth1", matcher1.group(2));
		}
		return infoMap;
	}
	
	
	// menu 순서 up
	/*public int orderUp(MenuVO vo) {
        int reuslt = 0; 
        reuslt += defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.orderUpTargetUpdateContents" , vo);
        reuslt += defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.orderUpSelfUpdateContents" , vo);
        return reuslt;
    }*/

	// menu 순서 down
    /*public int orderDown(MenuVO vo) {
        int reuslt = 0;
        reuslt += defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.orderDownTargetUpdateContents" , vo);
        reuslt += defaultDao.update("com.opennote.standard.mapper.basic.menuMngMapper.orderDownSelfUpdateContents" , vo);
        return reuslt;
    }*/
    
    // menu 컨텐츠 관리 method
    public String uploadFolderPath(HttpServletRequest request, String divn, String menuCl) throws Exception{
		
		String uploadFolderPath = request.getSession().getServletContext().getRealPath("/"); 
		uploadFolderPath = uploadFolderPath.replaceAll(File.separator + "\\tmp\\d+", "");
		uploadFolderPath = uploadFolderPath.replace( File.separator + ".metadata" + File.separator + ".plugins" + File.separator + "org.eclipse.wst.server.core" + File.separator + "wtpwebapps", "");
		uploadFolderPath += "WEB-INF" + File.separator + "jsp" + File.separator + "common" + File.separator;
		if("cont".equals(divn)) {
			String envDivn = FILE_ENV_DIVN;
			if(envDivn.equals("local")){
				uploadFolderPath += "cont" + File.separator;
			}
		}else if("menuList".equals(divn) || "aside".equals(divn)) {
			uploadFolderPath += "layout" + File.separator + menuCl+ File.separator + divn + File.separator;			
		}
			
		return uploadFolderPath;
	}
    
    // html 생성 
    public void makeHtml(HttpServletRequest request,String divn, String jspName, String path,String menuCl) throws Exception {
    	String requestURL = request.getRequestURL().toString();
		String baseURL = requestURL.replace(request.getRequestURI(), "");
		String urlStr =  baseURL + path;
		String uploadFolderPath = "";
		
		uploadFolderPath = uploadFolderPath(request, divn, menuCl);			
		
		File folder = new File(uploadFolderPath);
		if(!folder.exists()){
			folder.mkdirs();
		}
		
		String uploadFilePath = uploadFolderPath + jspName + ".jsp";
		
		File file = new File(uploadFilePath);
		BufferedWriter bw = new BufferedWriter(new FileWriter(file));
		
		URL url = new URL(urlStr);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		if(conn != null) {
			conn.setConnectTimeout(10000);
			conn.setUseCaches(false);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String line = "";
			String defaultLine = "<%@ page contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>";
			bw.write(defaultLine);
			while((line = br.readLine()) != null){
				bw.newLine();
				bw.write(line);
			}
			conn.disconnect();
			br.close();
			bw.close();
		}
    }
    
    //  html 삭제
    public void delHtml(HttpServletRequest request, String jspNm,String divn,String menuCl) throws Exception{
		
		String uploadFolderPath = uploadFolderPath(request,divn,menuCl);
		String uploadFilePath = uploadFolderPath + jspNm + ".jsp";
		
		File targetHtml = new File(uploadFilePath);
		if(targetHtml.exists()){
			targetHtml.delete();
		}
	}
	
    // 컨텐츠게시판 html 생성
	public void makeContHtml(HttpServletRequest request, MenuVO menuVO, String forderPath) throws Exception{
		
		if(!StringUtils.isEmpty(menuVO.getMenuCd())){
			String path = forderPath + "popPreview.do?menuCd=" + menuVO.getMenuCd();
			makeHtml(request, "cont", menuVO.getMenuCd(), path, "");
		}
	}
	
	// 컨텐츠게시판 html 삭제
	public void delContHtml(HttpServletRequest request, MenuVO menuVO) throws Exception{
		
		if(!StringUtils.isEmpty(menuVO.getMenuCd())){
			delHtml(request,menuVO.getMenuCd(),"cont","");
		}
	}
	
	// layout html 생성
	public void makeLayoutHtml(HttpServletRequest request, MenuVO menuVO, AuthVO authVO, String forderPath, String divn) throws Exception{
		
		// 메뉴 수정시
		if(menuVO != null) {
			AuthVO paramVO = new AuthVO();
			paramVO.setMenuCd(menuVO.getMenuCd());
			paramVO.setMenuSeCd(menuVO.getMenuCl());
			// 해당 메뉴가 있는 권한Id 목록 조회
			List<AuthVO> resultList = authService.getGrpAuthIdList(paramVO);
			if("delete".equals(divn)) {
				// 메뉴 delete 일때 해당 메뉴권한 삭제
				authService.menuAuthDeleteContents(menuVO.getMenuCd());
			}
			for(AuthVO vo : resultList) {
				// menuList.jsp를 읽어서 header 생성
				String path = forderPath + menuVO.getMenuCl() +"MenuList?grpAuthId=" +vo.getGrpAuthId();
				makeHtml(request, "menuList", vo.getGrpAuthId(), path,  menuVO.getMenuCl());
				// 관리자 메뉴가 아닐시 aside.jsp를 읽어서 aside 생성
				if(!"ma".equals(menuVO.getMenuCl())) {
					String aside = forderPath + menuVO.getMenuCl() + "Aside?grpAuthId=" + vo.getGrpAuthId();
					makeHtml(request, "aside", vo.getGrpAuthId(), aside, menuVO.getMenuCl());
				}
			}
		// 권한 수정시
		}else if(authVO != null && !StringUtils.isEmpty(authVO.getGrpAuthId())){	
			// 관리자 메뉴 수정시
			if(!CollectionUtils.isEmpty(authVO.getMaAuthList())) {
				String maMenuList = forderPath + "maMenuList?grpAuthId=" + authVO.getGrpAuthId();
				makeHtml(request, "menuList", authVO.getGrpAuthId(), maMenuList, "ma");				
			}
			// 사용자 메뉴 수정시
			if(!CollectionUtils.isEmpty(authVO.getFtAuthList())) {
				String ftMenuList = forderPath + "ftMenuList?grpAuthId=" + authVO.getGrpAuthId();
				makeHtml(request, "menuList", authVO.getGrpAuthId(), ftMenuList, "ft");
				String ftAside = forderPath + "ftAside?grpAuthId=" + authVO.getGrpAuthId();
				makeHtml(request, "aside", authVO.getGrpAuthId(), ftAside, "ft");
			}
			// 마이페이지 메뉴 수정시
			if(!CollectionUtils.isEmpty(authVO.getMyAuthList())) {
				String myMenuList = forderPath + "myMenuList?grpAuthId=" + authVO.getGrpAuthId();
				makeHtml(request, "menuList", authVO.getGrpAuthId(), myMenuList, "my");
				String myAside = forderPath + "myAside?grpAuthId=" + authVO.getGrpAuthId();
				makeHtml(request, "aside", authVO.getGrpAuthId(), myAside , "my");
			}
		}	
	}
	
	// layout html 삭제
	public void delLayoutHtml(HttpServletRequest request, String grpAuthId) throws Exception{
		
		delHtml(request,grpAuthId,"menuList","ma");
		delHtml(request,grpAuthId,"menuList","ft");
		delHtml(request,grpAuthId,"menuList","my");
		delHtml(request,grpAuthId,"aside","ft");
		delHtml(request,grpAuthId,"aside","my");
	}

	// 메뉴접속 로그 등록
	public int insertLogContents(AcsStatVO vo) {
		return defaultDao.insert("com.opennote.standard.mapper.basic.menuMngMapper.insertLogContents" , vo); 
	}

	// 메뉴별 접속수 Top5
	public List<CommonMap> selectMenuRank() {
		return basicDao.selectList("com.opennote.standard.mapper.basic.menuMngMapper.selectMenuRank");
		// return menuMngMapper.selectMenuRank();
	}

	// 메뉴별 접속수 Top5 상세
	public List<CommonMap> selectMenuRankDetail(AcsStatVO vo) {
		return basicDao.selectList( "com.opennote.standard.mapper.basic.menuMngMapper.selectMenuRankDetail", vo ); 
	}

	// 메뉴별 접속수(현재날짜)
	public List<CommonMap> selectMenuNow() {
		return basicDao.selectList("com.opennote.standard.mapper.basic.menuMngMapper.selectMenuNow");
	}

	// 메뉴별 접속수(현재날짜) 상세
	public List<CommonMap> selectMenuNowDetail(AcsStatVO vo) {
		return basicDao.selectList("com.opennote.standard.mapper.basic.menuMngMapper.selectMenuNowDetail", vo); 
	}
}
