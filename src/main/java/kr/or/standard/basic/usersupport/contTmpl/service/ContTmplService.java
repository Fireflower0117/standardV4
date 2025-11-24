package kr.or.standard.basic.usersupport.contTmpl.service;


import kr.or.standard.appinit.pagination.service.PaginationService;
import kr.or.standard.basic.common.ajax.dao.BasicCrudDao;
import kr.or.standard.basic.common.ajax.dao.CmmnDefaultDao;
import kr.or.standard.basic.common.domain.CmmnDefaultVO;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.view.excel.ExcelView;
import kr.or.standard.basic.system.code.service.CodeService;
import kr.or.standard.basic.system.code.vo.CodeVO;
import kr.or.standard.basic.usersupport.contTmpl.vo.ContTmplVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

@Service
@Transactional
@RequiredArgsConstructor
public class ContTmplService extends EgovAbstractServiceImpl {
    
    private final CodeService codeService;
    private final PaginationService paginationService;
    private final MessageSource messageSource;
    private final BasicCrudDao basicCrudDao;
    private final CmmnDefaultDao defaultDao;
    private final ExcelView excelView;
    
    private final String sqlNs = "com.standard.mapper.usersupport.contTmplMngMapper.";
    
    
    
    @Value("${file.env.divn}")
	private String FILE_ENV_DIVN;
    
    public void list(CmmnDefaultVO searchVO, ModelMap model){
       
        // 템플릿 탭구분 조회
		CodeVO codeVO = new CodeVO();
		codeVO.setCdUppoVal("TMCL");
		model.addAttribute("tmplClList", codeService.selectList(codeVO));
    
    } 
    
    public void addList(ContTmplVO searchVO, ModelMap model) throws Exception{
            
		if(StringUtils.isEmpty(searchVO.getSchEtc00())){
			searchVO.setSchEtc00("TMCL01");
		}
		
		PaginationInfo paginationInfo = paginationService.procPagination(searchVO); 
		ContTmplVO rtnVo = (ContTmplVO)defaultDao.selectOne(sqlNs+"selectCount", searchVO);
		int contTmplCount = Integer.parseInt(rtnVo.getContTmplCount()); 
		paginationInfo.setTotalRecordCount(contTmplCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<ContTmplVO> resultList = (List<ContTmplVO>)defaultDao.selectList(sqlNs+"selectList",searchVO); 
		model.addAttribute("resultList", resultList);
    }
    
    public void insertUpdateForm(ContTmplVO searchVO, ModelMap model, String procType){
		ContTmplVO contTmplVO = new ContTmplVO();
		if("update".equals(procType)) { 
		    contTmplVO = (ContTmplVO) defaultDao.selectOne(sqlNs+"selectContents", searchVO); 
		}
		model.addAttribute("contTmplVO", contTmplVO);
    }
    
    public CommonMap insertProc(ContTmplVO searchVO, BindingResult result){
        
		CommonMap returnMap = new CommonMap();
        
        int resultCnt = defaultDao.insert(sqlNs+"insertContents" , searchVO); 
		// 컨텐츠 저장후 해당 serno값으로 데이터 replace update

		if(resultCnt > 0) {
		    defaultDao.update(sqlNs+"editrContReplace", searchVO); 
			returnMap.put("message", messageSource.getMessage("insert.message", null, null));
		} else {
			returnMap.put("message", messageSource.getMessage("insert.fail.message", null, null));
		}
		returnMap.put("returnUrl", "list.do");
		return returnMap;
    }
    
    public CommonMap updateProc(ContTmplVO searchVO, BindingResult result, HttpSession session){
         
		CommonMap returnMap = new CommonMap(); 
	
		// 관리자권한이 있거나 사용자가 작성자 본인일때만 update
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) {

			int resultCnt = defaultDao.update(sqlNs+"updateContents", searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("update.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("update.fail.message", null, null));
			}
		}else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
		returnMap.put("returnUrl", "list.do");
		return returnMap;
    }
    
    public CommonMap deleteProc(ContTmplVO searchVO, BindingResult result, HttpSession session){
        
         
		CommonMap returnMap = new CommonMap();  
	
		// 관리자권한이 있거나 사용자가 작성자 본인일때만 update
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || regrCheck(searchVO)) { 
		
			int resultCnt = defaultDao.update(sqlNs+"deleteContents", searchVO); 
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
			}		
		}else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
		}
		returnMap.put("returnUrl", "list.do");
        return returnMap;   
    }
    
    public void changeSel(ContTmplVO searchVO, ModelMap model) throws Exception {
        
		// 템플릿 유형 조회
		CodeVO codeVO = new CodeVO();
		codeVO.setCdUppoVal(searchVO.getTmplCl());
		model.addAttribute("selOptionList", codeService.selectList(codeVO));
    }
    
    	// 컨텐츠 파일 등록
	public CommonMap uploadTmplFile(ContTmplVO vo) throws IOException {
		CommonMap returnMap = new CommonMap();
		String result = "success";
		String failMsg = "템플릿 파일 업로드 실패하였습니다.";
		String tmplFileSerno = vo.getTmplFileSerno();
		String divn = "";
		if(!StringUtils.isEmpty(vo.getDivn())){
			divn = vo.getDivn();
		}
		
		long maxFileSize= 10 * 1024 * 1024;

			List<MultipartFile> files = vo.getFiles();
			
			if (files != null) {
			
				ContTmplVO fileVO = new ContTmplVO();
				int idx = 0;
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {

						long fileSzVal = file.getSize();
						if(fileSzVal > maxFileSize){
							returnMap.put("failMsg", failMsg);
							return returnMap;
						}
						
						String rlFileNm = file.getOriginalFilename();
						if(divn.equals("preview")){
							rlFileNm = "preview.png";
						}
						if (rlFileNm != null && !rlFileNm.equals("")) {
							rlFileNm = rlFileNm.substring(rlFileNm.lastIndexOf("\\") + 1);
						}
						
						String fileExtnNm = Objects.requireNonNull(rlFileNm).substring(rlFileNm.lastIndexOf(".") + 1);
						String fileTpNm = file.getContentType();
						String imgWdthSzVal = null;
						String imgHghtSzVal = null;
						
						if (fileTpNm.contains("image")) {
							BufferedImage image = ImageIO.read(file.getInputStream());
							imgWdthSzVal = String.valueOf(image.getWidth());
							imgHghtSzVal = String.valueOf(image.getHeight());
						}
						
						fileVO.setFileSzVal(""+fileSzVal);
						fileVO.setRlFileNm(rlFileNm);
						fileVO.setFileExtnNm(fileExtnNm);
						fileVO.setFileTpNm(fileTpNm);
						fileVO.setImgWdthSzVal(imgWdthSzVal);
						fileVO.setImgHghtSzVal(imgHghtSzVal);
						fileVO.setFileByte(file.getBytes());
						
						if (idx == 0 && (tmplFileSerno == null || "".equals(tmplFileSerno))) {
							// atchFileId 구함 (최초 등록 시)
							ContTmplVO contTmplVO = (ContTmplVO)defaultDao.selectOne(sqlNs+"getTmplFileSerno");
							tmplFileSerno = contTmplVO.getTmplFileSerno();  
							
							fileVO.setTmplFileSerno(tmplFileSerno);
							
							defaultDao.insert(sqlNs+"insertContTmplFileFirst", fileVO); 
						}else{
							fileVO.setTmplFileSerno(tmplFileSerno);
							if(divn.equals("preview")){
								fileVO.setFileSeqo("0");
								defaultDao.update(sqlNs+"updateContTmplFile", fileVO);
							}else{
							    defaultDao.insert(sqlNs+"insertContTmplFileList", fileVO); 
							}
						}

						idx++;
					}
				}
				returnMap.put("tmplFileSerno", tmplFileSerno);
			}
			returnMap.put("result", result);
		return returnMap;
	}
	
	
	public void uploadTmplFile(ContTmplVO searchVO, ModelMap model){ 
	    List<ContTmplVO> fileList = (List<ContTmplVO>)defaultDao.selectList(sqlNs+"selectContTmplFileList", searchVO); 
		model.addAttribute("fileList", fileList);
	}
	
	public CommonMap delTmplFile(ContTmplVO searchVO, BindingResult result,HttpSession session){
	    
		CommonMap returnMap = new CommonMap(); 
		 
		if((boolean) session.getAttribute("SESSION_MANAGER_WRITE_BTN_KEY") || fileRegrCheck(searchVO)) { 
			int resultCnt = defaultDao.update(sqlNs+"deleteContTmplFile", searchVO);
			if(resultCnt > 0) {
				returnMap.put("message", messageSource.getMessage("delete.message", null, null));
				returnMap.put("result", "success");
			} else {
				returnMap.put("message", messageSource.getMessage("delete.fail.message", null, null));
				returnMap.put("result", "fail");
			}
		} else {
			returnMap.put("message", messageSource.getMessage("acs.error.message", null, null));
			returnMap.put("result", "fail");
		}
		return returnMap;
	}
	
	
    
	// 컨텐츠 건수 조회
	/*public int selectCount(ContTmplVO vo) {
		return contTmplMngMapper.selectCount(vo);
	};*/
	
	// 컨텐츠 목록 조회
	/*public List<ContTmplVO> selectList(ContTmplVO vo) {
		return contTmplMngMapper.selectList(vo);
	};*/
	
	// 컨텐츠 Excel 목록 조회
	/*public List<ContTmplVO> selectExcelList(ContTmplVO vo) {
		return contTmplMngMapper.selectExcelList(vo);
	};*/

	// 컨텐츠 상세 조회
	/*public ContTmplVO selectContents(ContTmplVO vo) {
		return contTmplMngMapper.selectContents(vo);
	};*/
	
	// 컨텐츠 등록
	/*public int insertContents(ContTmplVO vo){
		return contTmplMngMapper.insertContents(vo);
	}*/

	// 컨텐츠 수정
	/*public int updateContents(ContTmplVO vo) {
		return contTmplMngMapper.updateContents(vo);
	};*/

	// 컨텐츠 삭제
	/*public int deleteContents(ContTmplVO vo) {
		return contTmplMngMapper.deleteContents(vo);
	};*/
	
	// 컨텐츠 내용 replace
	/*public int editrContReplace(ContTmplVO vo) {
		return contTmplMngMapper.editrContReplace(vo);
	};*/
	
	//콘텐츠 파일 업로드
	/*public String getTmplFileSerno() {
		return contTmplMngMapper.getTmplFileSerno();
	};*/
	
	// 컨텐츠 파일 목록 조회
	/*public List<ContTmplVO> selectContTmplFileList(ContTmplVO vo) {
		return contTmplMngMapper.selectContTmplFileList(vo);
	};*/

	// 컨텐츠 파일 상세 조회
	/*public ContTmplVO selectContTmplFileContents(ContTmplVO vo) { 
		return contTmplMngMapper.selectContTmplFileContents(vo);
	};*/
	

	
	// 컨텐츠 첫번째 파일 등록
	/*public int insertContTmplFileFirst(ContTmplVO vo){
		return contTmplMngMapper.insertContTmplFileFirst(vo);
	}*/
	
	// 컨텐츠 파일 목록 등록
	/*public int insertContTmplFileList(ContTmplVO vo){
		return contTmplMngMapper.insertContTmplFileList(vo);
	}*/

	// 컨텐츠 파일 수정
	/*public int updateContTmplFile(ContTmplVO vo) {
		return contTmplMngMapper.updateContTmplFile(vo);
	};*/

	// 컨텐츠 파일 삭제
	/*public int deleteContTmplFile(ContTmplVO vo) {
		return contTmplMngMapper.deleteContTmplFile(vo);
	};*/
	
	// 컨텐츠게시글 본인글 여부 
	public boolean regrCheck(ContTmplVO vo) {
	    ContTmplVO rtnVo = (ContTmplVO)defaultDao.selectOne(sqlNs+"regrCheck", vo);
		return Integer.parseInt(rtnVo.getIsRegrCheck()) == 1 ? true : false; 
	}
	
	// 컨텐츠 업로드 파일 본인 여부 
	public boolean fileRegrCheck(ContTmplVO vo) {
	    ContTmplVO rtnVo = (ContTmplVO)defaultDao.selectOne(sqlNs+"fileRegrCheck", vo);
	    return Integer.parseInt(rtnVo.getIsFileRegrCheck()) == 1 ? true : false; 
	}
	
	// 컨텐츠 파일 다운로드
	public void getFileDown(String tmplFileSerno, String fileSeqo, HttpServletRequest request , HttpServletResponse response) throws Exception {
		ByteArrayInputStream is = null;
		ServletOutputStream os = null;

		try {
		
		    ContTmplVO contTmplVO = new ContTmplVO(); 
            contTmplVO.setTmplFileSerno(tmplFileSerno);
            contTmplVO.setFileSeqo(fileSeqo); 
            ContTmplVO fileVO = (ContTmplVO)defaultDao.selectOne(sqlNs+"selectContTmplFileContents", contTmplVO);
		
		
			String contentType = ""; 
			if (fileVO == null) {
				throw new Exception();
			}else{
				contentType = fileVO.getFileTpNm().toLowerCase();
			}
			
			is = new ByteArrayInputStream(fileVO.getFileByte());
			os = response.getOutputStream();
			
			if(!contentType.contains("image")){
				String userAgent = request.getHeader("User-Agent");
				response.setContentType("application/octet-stream");
				if (userAgent != null && userAgent.contains("MSIE")) {
					response.setHeader("Content-disposition", "attachment;filename=" + new String(fileVO.getRlFileNm().getBytes("UTF-8"), "latin1") + ";");
				} else {
					response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileVO.getRlFileNm(), "UTF-8") + ";");
				}
			}
			
			byte[] buf = new byte[8192];
			int bytesRead = 0, bytesBuffered = 0;
			while ( (bytesRead = is.read(buf)) > -1 ) {
				os.write(buf, 0, bytesRead);
				bytesBuffered += bytesRead;
				if (bytesBuffered > 1024 * 1024) {
					bytesBuffered = 0;
					os.flush();
				}
			}
			 
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try{ is.close(); }catch (Exception e){}
			}
			if (os != null) {
			    try{ os.flush(); os.close(); }catch (Exception e){} 
			}
		}
	}
	
	public ModelAndView excelDownload(ContTmplVO searchVO, Model model){
	    ModelAndView mav = new ModelAndView(excelView);
		String tit = "컨텐츠목록";
		String url = "/standard/usersupport/contTmplList.xlsx";
		
		List<ContTmplVO> resultList = (List<ContTmplVO>)defaultDao.selectList(sqlNs+"selectExcelList", searchVO);
		 
		
		//HTML 태그 제거
		/*
		 * String regEx = "<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
		 * for(ContTmplVO vo : resultList) {
		 * vo.setEditrCont(vo.getEditrCont().replaceAll(regEx, "")); }
		 */
		
		mav.addObject("target", tit);
		mav.addObject("source", url);
		mav.addObject("resultList", resultList);
		
		return mav;
	
	}
	
	// 컨텐츠 파일 uploadPath
	/*public String uploadFolderPath(HttpServletRequest request)throws Exception {
		
		String uploadFolderPath = request.getSession().getServletContext().getRealPath("/");
		if(FILE_ENV_DIVN.equals("local")){
			uploadFolderPath = uploadFolderPath.replaceAll(File.separator + "\\tmp\\d+", "");
			uploadFolderPath = uploadFolderPath.replace( File.separator + ".metadata" + File.separator + ".plugins" + File.separator + "org.eclipse.wst.server.core" + File.separator + "wtpwebapps", "");
			uploadFolderPath += "WEB-INF" + File.separator + "jsp" + File.separator + "common" + File.separator + "tmpl" + File.separator + "preview";
		}
		return uploadFolderPath;
	}*/
    
    
}
