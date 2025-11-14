<%-- <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="org.apache.commons.io.FilenameUtils" %>
<%@page import="java.util.Iterator" %>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@page import="java.io.File, java.util.List, java.io.IOException" %>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.commons.fileupload.FileItem" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>upload</title>
</head>
<body>
<%
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);  //multipart로 전송되었는가 체크

	if (isMultipart) {
		// 설정단계
 		//File temporaryDir = new File("D:\\work\\kati\\workspace\\kamis_new\\WebContent\\ckeditor\\imageUpload");  //업로드된 파일의 임시 저장 폴더
 		super.init(config);
 		String realDir = config.getServletContext().getRealPath(request.getParameter("realDir"));  //실제 저장될 파일경로 ->여기서 널값으로 나와서 이미지 안올라감
 		String sFunc = request.getParameter("CKEditorFuncNum");
 		String realUrl = request.getParameter("realUrl");

 		// 디스크 기반의 파일 아이템 팩토리 생성
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1 * 1024 * 1024);  //최대 메모리 크기
		//factory.setRepository(temporaryDir);  // 임시저장폴더 연결

		// 구현단계
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		upload.setSizeMax(10 * 1024 * 1024);  //최대 업로드 크기
		List<FileItem> items = upload.parseRequest(request); //이 부분에서 파일이 생성
		Iterator iter = items.iterator();

		while (iter.hasNext()) {
			FileItem fileItem = (FileItem) iter.next();
			if (fileItem.isFormField()) {  // File 컴포넌트가 아닌 일반 컴포넌트일 경우
				out.println(fileItem.getFieldName() + "=" + fileItem.getString("euc-kr") + "<br/>");
			}else{
				if (fileItem.getSize() > 0) {  //파일이 업로드 되었나 안되었나 체크
					String fieldName = fileItem.getFieldName();
					//확장자 구하기
					String ext = FilenameUtils.getExtension(fileItem.getName());
					String fileName = FilenameUtils.getBaseName(fileItem.getName()) + "_" + new Date().getTime() + "." + ext;
					String contentType = fileItem.getContentType();
					boolean isInMemory = fileItem.isInMemory();
					long sizeInBytes = fileItem.getSize();


			 		System.out.println("[realDir] : "+ realDir +"<br/>");
			 		System.out.println("[fieldName] : "+ fieldName +"<br/>");
			 		System.out.println("[fileName] : "+ fileName +"<br/>");
			 		System.out.println("[contentType] : "+ contentType +"<br/>");
			 		System.out.println("[isInMemory] : "+ isInMemory +"<br/>");
			 		System.out.println("[sizeInBytes] : "+ sizeInBytes +"<br/>");


			 		out.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + sFunc + ", '"+ realUrl + fileName + "', '완료');</script>");

			 		try {
			 			File uploadedFile = new File(realDir, fileName);
			 			fileItem.write(uploadedFile);  //실제 디렉토리에 카피
			 			//fileItem.delete();   //temp폴더의 파일 제거
			 		} catch(IOException ex) {
			 			out.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + sFunc + ", '"+ realUrl + fileName + "', "+ex+");</script>");
			 			out.println("error : "+ ex +"<br/>");
			 		}
				}
			}
		}
	} else {
// 		out.println("인코딩 타입이 multipart/form-data 가 아님.");
	}
%>
</body>
</html> --%>