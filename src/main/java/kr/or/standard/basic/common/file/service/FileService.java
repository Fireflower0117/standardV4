package kr.or.standard.basic.common.file.service;


import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.regex.Matcher;

import javax.imageio.ImageIO;

import kr.or.standard.basic.common.file.FileDao;
import kr.or.standard.basic.common.file.vo.FileVO;
import org.apache.commons.lang3.StringUtils;
import org.apache.tika.Tika; 
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper; 

@Service
@Transactional
public class FileService extends EgovAbstractServiceImpl {
	
	@Autowired
	private FileDao fileDao;
  
	@Value("${file.upload.path}")
	private String UPLOAD_PATH;

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
							atchFileId = fileDao.selectFileString("opnt.atchFileMng.getAtchFileId"); 
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
						fileDao.insertFile("opnt.atchFileMng.putAtchFile",fileVO); 
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
		FileVO one = fileDao.selectFileOne("opnt.atchFileMng.getAtchFile",fileVO); 

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
						atchFileId = fileDao.selectFileString("opnt.atchFileMng.getAtchFileId"); 
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
					 
					int effCnt = fileDao.insertFile("opnt.atchFileMng.putAtchFile", fileVO);
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
		List<FileVO>  atchFileList = fileDao.selectFileList("opnt.atchFileMng.putAtchFile", fileVO);
		
		File deleteFile;
		for (FileVO one : atchFileList) {
			deleteFile = new File(one.getPhclFilePthNm() + one.getFileNmPhclFileNm());
			if (deleteFile.exists() && deleteFile.isFile()) {
				//noinspection ResultOfMethodCallIgnored
				deleteFile.delete();
			}
		}
		fileDao.deleteFile("opnt.atchFileMng.delAtchFile", fileVO ); 

		return atchFileId;
	}

	public List<FileVO> getAtchFileList(FileVO vo) { 
		return fileDao.selectFileList("opnt.atchFileMng.getAtchFileList", vo); 
	}

	public FileVO getAtchFile(FileVO vo) {
		return fileDao.selectFileOne("opnt.atchFileMng.getAtchFile", vo); 
	}
	public FileVO getAtchKcaFile(FileVO vo) {
		return fileDao.selectFileOne("opnt.atchFileMng.getAtchKcaFile", vo); 
	}
	// DEXT5UPLOAD. 서버에 업로드 된 파일의 정보를 DB에 등록
	public String uploadFileInfo(final List<FileVO> fileInfoList) throws Exception {
		String atchFileId = fileInfoList.get(0).getAtchFileId();

		int idx = 0;
		for (FileVO fileInfo : fileInfoList) {
			if (idx == 0 && (atchFileId == null || "".equals(atchFileId))) {
				// atchFileId 구함 (최초 등록 시) 
				atchFileId = fileDao.selectFileString("opnt.atchFileMng.getAtchFileId");
			}

			fileInfo.setAtchFileId(atchFileId);
			fileDao.insertFile("opnt.atchFileMng.putAtchFile", fileInfo);  
			idx++;
		}

		return atchFileId;
	}

	// 단일 파일 삭제
	public void deleteFileInfo(final List<FileVO> delFileList) {
		for (FileVO fileVO : delFileList) {
			// 첨부파일 정보 조회.
			FileVO one = fileDao.selectFileOne("opnt.atchFileMng.getAtchFile", fileVO); 

			File deleteFile = new File(one.getPhclFilePthNm() + one.getFileNmPhclFileNm());
			if (deleteFile.exists() && deleteFile.isFile()) {
				//noinspection ResultOfMethodCallIgnored
				deleteFile.delete();
			}
			fileDao.deleteFile("opnt.atchFileMng.delAtchFile", fileVO ); 
		}
	}
}