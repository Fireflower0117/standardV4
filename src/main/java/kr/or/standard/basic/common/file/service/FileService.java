package kr.or.standard.basic.common.file.service;


import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.FileDao;
import kr.or.standard.basic.common.file.vo.FileVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.tika.Tika; 
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper; 

@Slf4j
@Service
@Transactional
public class FileService extends EgovAbstractServiceImpl {
	
	@Autowired
	private FileDao fileDao;
  
	@Value("${file.upload.path}")
	private String UPLOAD_PATH;
	
	public ResponseEntity fileDown(FileVO vo) throws Exception {
		 
	
		log.info("====================");
		log.info("file down log");
		log.info("atchFileId : " + vo.getAtchFileId());
		log.info("fileSeqo : " + vo.getFileSeqo());
		log.info("fileRlNm : " + vo.getFileRlNm());
		log.info("====================");

		// 파일 정보.
		FileVO atchFile = getAtchFile(vo);

		if (vo.getFileRlNm().equals(atchFile.getFileRlNm())) {
			String file = atchFile.getPhclFilePthNm() + atchFile.getFileNmPhclFileNm();

			Path path = Paths.get(file);
			
			Resource resource = new InputStreamResource(Files.newInputStream(path));
			// media type.
			String contentType = StringUtils.isEmpty(atchFile.getFileTpNm()) ? "application/octet-stream" : atchFile.getFileTpNm();

			// url encode file name.
			String encodeFileName = URLEncoder.encode(atchFile.getFileRlNm(), "UTF-8").replaceAll("\\+", "%20");

			return ResponseEntity.ok()
					.contentType(MediaType.parseMediaType(contentType))
					.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeFileName + "\"")
					.body(resource);
		} else {
			throw new FileNotFoundException();
		}
	
	}
	
	public List<FileVO> getFileList(FileVO vo){ 
		List<FileVO> atchFileList = new ArrayList<>();
		if (!"".equals(vo.getAtchFileId())) { 
			atchFileList = getAtchFileList(new FileVO(vo.getAtchFileId()));
		}
		return atchFileList;
	}
	
	public CommonMap jsonProc(String procType, FileVO vo)throws Exception {
		
		CommonMap returnMap = new CommonMap();

		String result = "Y";
		String procMsg = "처리되었습니다.";
		String atchFileId;
		List<MultipartFile> files = vo.getFiles();
		int length = 0;
		if(files != null) {
			for (MultipartFile file : files) {
				length ++;
			}
			returnMap.put("length", length);			
		}
		if ("insert".equals(procType)) {
			atchFileId = uploadFiles(vo);
		} else if ("update".equals(procType)) {
			atchFileId = updateFiles(vo);
		} else {
			atchFileId = deleteFiles(vo.getAtchFileId());
		}
		
		returnMap.put("result", result);
		returnMap.put("procMsg", procMsg);
		returnMap.put("atchFileId", atchFileId);

		return returnMap;
	}
	
	public CommonMap jsonTmplProc(FileVO vo) throws Exception {
		
		CommonMap returnMap = new CommonMap();

		String result = "Y";
		String procMsg = "처리되었습니다.";
		 
		List<FileVO> fileList = tmplUploadFiles(vo);
		
		returnMap.put("result", result);
		returnMap.put("procMsg", procMsg);
		returnMap.put("fileList", fileList);

		return returnMap;
	
	}
	
	public ResponseEntity getImage(String atchFileId, String fileSeqo, String fileNmPhclFileNm)throws Exception{
			 
		FileVO searchVO = new FileVO();
		searchVO.setAtchFileId(atchFileId);
		searchVO.setFileSeqo(fileSeqo);
		searchVO.setFileNmPhclFileNm(fileNmPhclFileNm);

		FileVO fileVO = fileDao.selectFileOne("com.opennote.standard.mapper.basic.atchFileMng.getAtchFile", searchVO);

		Path path = Paths.get(fileVO.getPhclFilePthNm(), fileVO.getFileNmPhclFileNm());
		Resource resource = new InputStreamResource(Files.newInputStream(path));

		String contentType = "";
		if (!"".equals(fileVO.getFileFextNm())) {
			contentType = "image/" + fileVO.getFileFextNm().toLowerCase();
		}

		return ResponseEntity.ok()
				.contentType(MediaType.parseMediaType(contentType))
				.body(resource);
		
	}
	
	public void getByteImage(String atchFileId, String fileSeqo, String fileNmPhclFileNm, HttpServletResponse response) throws Exception{
		
		InputStream is = null; 
		try{ 
			FileVO searchVO = new FileVO();
	
			searchVO.setAtchFileId(atchFileId);
			searchVO.setFileSeqo(fileSeqo);
			searchVO.setFileNmPhclFileNm(fileNmPhclFileNm);
	
			FileVO fileVO =  fileDao.selectFileOne("com.opennote.standard.mapper.basic.atchFileMng.getAtchFile", searchVO); 
			if (fileVO != null) { 
				is = new ByteArrayInputStream(fileVO.getFileByte()); 
				ServletOutputStream os = response.getOutputStream();
				
				int binaryRead; 
				while ((binaryRead = is.read()) != -1) {
					os.write(binaryRead);
				}
			}
		} catch (Exception e) {
			throw e;
		}finally {
			if(is != null) try{ is.close(); } catch(Exception e){} 
		} 
	}
	
	public void downloadByte(String atchFileId, String fileSeqo, String fileNmPhclFileNm, HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		ByteArrayInputStream in = null;
		ServletOutputStream out = null;
		
		FileVO searchVO = new FileVO();
		
		searchVO.setAtchFileId(atchFileId);
		searchVO.setFileSeqo(fileSeqo);
		searchVO.setFileNmPhclFileNm(fileNmPhclFileNm);

		FileVO fileVO =  fileDao.selectFileOne("com.opennote.standard.mapper.basic.atchFileMng.getAtchFile", searchVO);
		
		in = new ByteArrayInputStream(fileVO.getFileByte());
		
		try {
			out = response.getOutputStream();
			String userAgent = request.getHeader("User-Agent");
			
			response.setContentType("application/octet-stream");
			if (userAgent != null && userAgent.indexOf("MSIE") > -1) {
				response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileVO.getFileRlNm(), "UTF-8"));
			} else {
				response.setHeader("Content-disposition", "attachment;filename=" + new String(fileVO.getFileRlNm().getBytes("UTF-8"), "latin1") + ";");
			}
			
			byte[] buf = new byte[8192];
			int bytesread = 0, bytesBuffered = 0;
			while ( (bytesread = in.read(buf)) > -1 ) {
				out.write(buf, 0, bytesread);
				bytesBuffered += bytesread;
				if (bytesBuffered > 1024 * 1024) {
					bytesBuffered = 0;
					out.flush();
				}
			}
			out.close();
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
			if (in != null) {
				try{ in.close(); } catch(Exception e){}
				try{ out.close(); } catch(Exception e){}
			}
		}
	}
	
	// 파일 업로드
	public String uploadFiles(final FileVO vo) throws Exception {
		String atchFileId = vo.getAtchFileId();
		List<MultipartFile> files = vo.getFiles();

		if (files != null) {
			Date date = new Date();

			// upload path
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-HH-");

			// Matcher.quoteReplacement 추가 (windows File.separator 에러)
			String uploadPath = UPLOAD_PATH + format.format(date).replaceAll("-", Matcher.quoteReplacement(File.separator));

			// phys file nm
			format = new SimpleDateFormat("yyyyMMddHHmmss");

			FileVO fileVO = new FileVO();
			int idx = 0;
			File one; 
			if(files.size() > 0) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						if (idx == 0 && (atchFileId == null || "".equals(atchFileId))) {
							// atchFileId 구함 (최초 등록 시)
							atchFileId = fileDao.selectFileString("com.opennote.standard.mapper.basic.atchFileMng.getAtchFileId"); 
						}

						String originalFileName = file.getOriginalFilename();
						// IE에서는 파일 경로가 포함되므로 처리해 줌
						if (originalFileName != null) {
							originalFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1);
						}

						fileVO.setAtchFileId(atchFileId);
						fileVO.setFileRlNm(originalFileName);
						fileVO.setFileSizeVal(String.valueOf(file.getSize()));
						fileVO.setFileTpNm(new Tika().detect(file.getBytes()));
						fileVO.setPhclFilePthNm(uploadPath);
						fileVO.setFileNmPhclFileNm(atchFileId + "_" + idx + "_" + format.format(date));
						fileVO.setFileFextNm(Objects.requireNonNull(file.getOriginalFilename()).substring(file.getOriginalFilename().lastIndexOf(".") + 1));
						fileVO.setFileByte(file.getBytes());
						
						// 폴더 생성.
						one = new File(fileVO.getPhclFilePthNm());

						if (!one.exists()) {
							//noinspection ResultOfMethodCallIgnored
							one.mkdirs();
						}

						// 파일 생성.
						one = new File(fileVO.getPhclFilePthNm() + fileVO.getFileNmPhclFileNm());
						file.transferTo(one);

						// 이미지 파일의 경우.
						if (fileVO.getFileTpNm().contains("image")) {
							BufferedImage image = ImageIO.read(one);
							fileVO.setImgSqrVal(String.valueOf(image.getWidth()));
							fileVO.setImgHghtVal(String.valueOf(image.getHeight()));
						} else {
							fileVO.setImgSqrVal(null);
							fileVO.setImgHghtVal(null);
						}
						fileDao.insertFile("com.opennote.standard.mapper.basic.atchFileMng.putAtchFile",fileVO); 
						idx++;
					}
				}
			}
		}

		return atchFileId;
	}

	public String updateFiles(final FileVO vo) throws Exception {
		List<MultipartFile> files = vo.getFiles();
		String atchFileId = vo.getAtchFileId();
		String deleteFileJsonString = vo.getDeleteFileJsonString();

		FileVO fileVO = new FileVO();
		fileVO.setAtchFileId(atchFileId);

		boolean isNotNull = files != null;
		
		if (StringUtils.isEmpty(atchFileId)) {
			if (isNotNull) {
				// atchFileId = 없음, files = 있음 (새로 업로드).
				return this.uploadFiles(vo);
			}
			// atchFileId = 없음, files = 없음 (아무 동작 없음).
		} else {
			// 기존 첨부파일 중 삭제할 첨부파일
			if (deleteFileJsonString != null) {
				ObjectMapper mapper = new ObjectMapper();
				List<FileVO> deleteFiles = mapper.readValue(deleteFileJsonString, new TypeReference<List<FileVO>>() {});
				for (FileVO del : deleteFiles) {
					this.deleteFile(del);
				}
			}

			// 새로 추가한 첨부파일
			if (isNotNull) {
				// atchFileId = 있음, files = 있음
				return uploadFiles(vo);
			}
		}

		return atchFileId;
	}

	// 단일 파일 삭제
	public void deleteFile(final FileVO fileVO) {
		// 첨부파일 정보 조회.
		// FileVO one = fileMapper.getAtchFile(fileVO);
		FileVO one = fileDao.selectFileOne("com.opennote.standard.mapper.basic.atchFileMng.getAtchFile",fileVO); 

		File deleteFile = new File(one.getPhclFilePthNm() + one.getFileNmPhclFileNm());
		if (deleteFile.exists() && deleteFile.isFile()) {
			//noinspection ResultOfMethodCallIgnored
			deleteFile.delete();
		}
		
		fileDao.deleteFile("opnt.atchFileMng.delAtchFile", fileVO );
		//fileMapper.delAtchFile(fileVO);
	}
	
	
	public List<FileVO> tmplUploadFiles(final FileVO vo) throws Exception {
		List<FileVO> fileList = new ArrayList<>();
		String atchFileId = vo.getAtchFileId();
		List<MultipartFile> files = vo.getFiles();

		if (files != null) {
			Date date = new Date();

			// upload path
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-HH-");

			// Matcher.quoteReplacement 추가 (windows File.separator 에러)
			String uploadPath = UPLOAD_PATH + format.format(date).replaceAll("-", Matcher.quoteReplacement(File.separator));

			// phys file nm
			format = new SimpleDateFormat("yyyyMMddHHmmss");

			FileVO fileVO = new FileVO();
			int idx = 0;
			File one;
			for (MultipartFile file : files) {
				if (!file.isEmpty()) {
					if (idx == 0 && (atchFileId == null || "".equals(atchFileId))) {
						// atchFileId 구함 (최초 등록 시)
						atchFileId = fileDao.selectFileString("com.opennote.standard.mapper.basic.atchFileMng.getAtchFileId"); 
					}

					String originalFileName = file.getOriginalFilename();
					// IE에서는 파일 경로가 포함되므로 처리해 줌
					if (originalFileName != null) {
						originalFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1);
					}

					fileVO.setAtchFileId(atchFileId);
					fileVO.setFileRlNm(originalFileName);
					fileVO.setFileSizeVal(String.valueOf(file.getSize()));
					fileVO.setFileTpNm(new Tika().detect(file.getBytes()));
					fileVO.setPhclFilePthNm(uploadPath);
					fileVO.setFileNmPhclFileNm(atchFileId + "_" + idx + "_" + format.format(date));
					fileVO.setFileFextNm(Objects.requireNonNull(file.getOriginalFilename()).substring(file.getOriginalFilename().lastIndexOf(".") + 1));
					fileVO.setFileByte(file.getBytes());
					
					// 폴더 생성.
					one = new File(fileVO.getPhclFilePthNm());

					if (!one.exists()) {
						//noinspection ResultOfMethodCallIgnored
						one.mkdirs();
					}

					// 파일 생성.
					one = new File(fileVO.getPhclFilePthNm() + fileVO.getFileNmPhclFileNm());
					file.transferTo(one);

					// 이미지 파일의 경우.
					if (fileVO.getFileTpNm().contains("image")) {
						BufferedImage image = ImageIO.read(one);
						fileVO.setImgSqrVal(String.valueOf(image.getWidth()));
						fileVO.setImgHghtVal(String.valueOf(image.getHeight()));
					} else {
						fileVO.setImgSqrVal(null);
						fileVO.setImgHghtVal(null);
					}
					 
					int effCnt = fileDao.insertFile("com.opennote.standard.mapper.basic.atchFileMng.putAtchFile", fileVO);
					fileVO.setEffCnt(effCnt);
					fileList.add(fileVO);
					idx++;
				}
			}
		}

		return fileList;
	}

	// 게시물의 모든 첨부파일 삭제
	public String deleteFiles(final String atchFileId) {
		FileVO fileVO = new FileVO();
		fileVO.setAtchFileId(atchFileId);
		// 첨부파일 정보 조회.
		// List<FileVO> getAtchFileList = fileMapper.getAtchFileList(fileVO);
		List<FileVO>  atchFileList = fileDao.selectFileList("com.opennote.standard.mapper.basic.atchFileMng.putAtchFile", fileVO);
		
		File deleteFile;
		for (FileVO one : atchFileList) {
			deleteFile = new File(one.getPhclFilePthNm() + one.getFileNmPhclFileNm());
			if (deleteFile.exists() && deleteFile.isFile()) {
				//noinspection ResultOfMethodCallIgnored
				deleteFile.delete();
			}
		}
		fileDao.deleteFile("com.opennote.standard.mapper.basic.atchFileMng.delAtchFile", fileVO ); 

		return atchFileId;
	}

	public List<FileVO> getAtchFileList(FileVO vo) { 
		return fileDao.selectFileList("com.opennote.standard.mapper.basic.atchFileMng.getAtchFileList", vo); 
	}

	public FileVO getAtchFile(FileVO vo) { 
		return fileDao.selectFileOne("com.opennote.standard.mapper.basic.atchFileMng.getAtchFile", vo); 
	}
	public FileVO getAtchKcaFile(FileVO vo) {
		return fileDao.selectFileOne("com.opennote.standard.mapper.basic.atchFileMng.getAtchKcaFile", vo); 
	}
	// DEXT5UPLOAD. 서버에 업로드 된 파일의 정보를 DB에 등록
	public String uploadFileInfo(final List<FileVO> fileInfoList) throws Exception {
		String atchFileId = fileInfoList.get(0).getAtchFileId();

		int idx = 0;
		for (FileVO fileInfo : fileInfoList) {
			if (idx == 0 && (atchFileId == null || "".equals(atchFileId))) {
				// atchFileId 구함 (최초 등록 시) 
				atchFileId = fileDao.selectFileString("com.opennote.standard.mapper.basic.atchFileMng.getAtchFileId");
			}

			fileInfo.setAtchFileId(atchFileId);
			fileDao.insertFile("com.opennote.standard.mapper.basic.atchFileMng.putAtchFile", fileInfo);  
			idx++;
		}

		return atchFileId;
	}

	// 단일 파일 삭제
	public void deleteFileInfo(final List<FileVO> delFileList) {
		for (FileVO fileVO : delFileList) {
			// 첨부파일 정보 조회.
			FileVO one = fileDao.selectFileOne("com.opennote.standard.mapper.basic.atchFileMng.getAtchFile", fileVO); 

			File deleteFile = new File(one.getPhclFilePthNm() + one.getFileNmPhclFileNm());
			if (deleteFile.exists() && deleteFile.isFile()) {
				//noinspection ResultOfMethodCallIgnored
				deleteFile.delete();
			}
			fileDao.deleteFile("com.opennote.standard.mapper.basic.atchFileMng.delAtchFile", fileVO ); 
		}
	}
}