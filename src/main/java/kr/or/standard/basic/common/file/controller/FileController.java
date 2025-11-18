package kr.or.standard.basic.common.file.controller;


import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.file.vo.FileVO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
 

import kr.or.standard.basic.common.file.service.FileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j; 

@Slf4j
@Controller
@RequiredArgsConstructor
public class FileController {
   
   	private final FileService fileService; 
    
    
	// 파일 다운로드
	@RequestMapping("/file/down.do")
	public ResponseEntity<Resource> fileDown(FileVO vo) throws Exception { 
	     return fileService.fileDown(vo); 
	}
	
	// atchFileId로 첨부파일 목록 조회
	@ResponseBody
	@PostMapping("/file/getList.do")
	public List<FileVO> getFileList(FileVO vo) { 
	    return fileService.getFileList(vo); 
	}

	@ResponseBody
	@PostMapping("/file/{procType:insert|update|delete}Proc.do")
	public CommonMap jsonProc(@PathVariable String procType, FileVO vo) throws Exception { 
		return fileService.jsonProc(procType, vo); 
	}
	
	@ResponseBody
	@PostMapping("/file/tmplProc.do")
	public CommonMap jsonTmplProc(FileVO vo) throws Exception { 
	    return fileService.jsonTmplProc(vo);  
	}

	@GetMapping("/file/getImage.do")
	public ResponseEntity<Resource> getImage(@RequestParam(name = "atchFileId") String atchFileId, @RequestParam(name = "fileSeqo") String fileSeqo,@RequestParam(name = "fileNmPhclFileNm") String fileNmPhclFileNm) throws Exception { 
		return fileService.getImage(atchFileId , fileSeqo , fileNmPhclFileNm);  
	}
	
	@GetMapping("/file/getByteImage.do")
	public void getByteImage(@RequestParam(name = "atchFileId") String atchFileId, @RequestParam(name = "fileSeqo") String fileSeqo,@RequestParam(name = "fileNmPhclFileNm") String fileNmPhclFileNm, HttpServletResponse response) throws Exception { 
		fileService.getByteImage(atchFileId, fileSeqo, fileNmPhclFileNm , response ); 
	}
	
	@RequestMapping("/file/downloadByte.do")
	public void downloadByte(@RequestParam(name = "atchFileId") String atchFileId, @RequestParam(name = "fileSeqo") String fileSeqo,@RequestParam(name = "fileNmPhclFileNm") String fileNmPhclFileNm, HttpServletRequest request, HttpServletResponse response) throws Exception {
		fileService.downloadByte(atchFileId, fileSeqo, fileNmPhclFileNm , request , response );
	}

}
