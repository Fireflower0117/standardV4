let maxFileCnt = 5;			// 최대 첨부파일 수(5개로 임의 설정)
let maxFileSize = 20;		// 첨부파일별 최대 용량(10MB로 임의 설정)

// 첨부파일 view 추가
// atchFileId : 조회할 첨부파일의 ID
// atchFileIdNm : 첨부파일ID를 세팅할 input id
// uploadType : file(일반 업로드. 생략 가능), image(이미지 업로드)
const setFileList = function () {
	
	const getArgs = arguments;
	let atchFileId ="";
	let atchFileIdNm = "";
	let uploadType = "";
	let atchPnu = "";
	
	if(getArgs.length > 1){
		switch (getArgs.length) {
	 		case 3: atchFileId = getArgs[0]; atchFileIdNm = getArgs[1]; uploadType = getArgs[2];break;
	 		case 4: atchFileId = getArgs[0]; atchFileIdNm = getArgs[1]; uploadType = getArgs[2]; maxFileCnt = getArgs[3];break;
	 		case 5: atchFileId = getArgs[0]; atchFileIdNm = getArgs[1]; uploadType = getArgs[2]; maxFileCnt = getArgs[3]; maxFileSize = getArgs[4]; break;
	 		case 6: atchFileId = getArgs[0]; atchFileIdNm = getArgs[1]; uploadType = getArgs[2]; maxFileCnt = getArgs[3]; maxFileSize = getArgs[4]; atchPnu = getArgs[5]; break;
	 	}
	}	
	
	if (uploadType == null || typeof (uploadType) === "undefined" || uploadType === "") {
		uploadType = "upload";
	}

	// 배열 생성
	window["atchFileArr_" + atchFileIdNm] = [];
	window["deleteFileArr_" + atchFileIdNm] = [];

	let totalFileCnt = 0;
	let atchedFileCnt = 0;

	let fileHTML = "<div class='file_wrap'>"
	fileHTML += "	<input type='hidden' name='atchFileIdTemp' value='" + atchFileId + "' class='atchFileIdTemp'>";
	fileHTML += "	<input type='hidden' name='atchFileIdNm' value='" + atchFileIdNm + "' class='atchFileIdNm'>";
	fileHTML += "	<input type='hidden' name='uploadType' value='" + uploadType + "' class='uploadType'>";
	fileHTML += "	<input type='hidden' name='atchPnu' value='" + atchPnu + "' class='atchPnu'>";
	fileHTML += "	<input type='hidden' name='maxFileCnt' value='" + maxFileCnt + "' class='maxFileCnt'>";
	fileHTML += "	<input type='hidden' name='fileChgYn' value='N' class='fileChgYn'>";
	if (uploadType === "image") {
		fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' style='display:none;' multiple onchange='addFiles(this)'>";

		fileHTML += "	<ul class='file_thum atchFileTbody'>";
	} else if (uploadType === "imageView") {
        fileHTML += "    <div class='file_wrap'>";
        fileHTML += "        <ul class='file_thum atchFileTbody'>";	
	} else if (uploadType === "byteImage") {
		fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' style='display:none;' multiple onchange='addFiles(this)'>";

		fileHTML += "	<ul class='file_thum atchFileTbody'>";
	} else if (uploadType === "byteImageView") {
        fileHTML += "    <div class='file_wrap'>";
        fileHTML += "        <ul class='file_thum atchFileTbody'>";	
	} else if (uploadType === "view" || uploadType === "cmntByteView" ) {
		fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' style='display:none;' multiple onchange='addFiles(this)'>";
	} else if (uploadType === "byteView") {
		fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' style='display:none;' multiple onchange='addFiles(this)'>";
		fileHTML += "	<table class='tbl col tbl_file'>";
		fileHTML += "		<caption>첨부파일 업로드 목록</caption>";
		fileHTML += "		<colgroup>";
		fileHTML += "			<col>";
		fileHTML += "			<col style='width:15%'>";
		fileHTML += "		</colgroup>";
		fileHTML += "		<thead>";
		fileHTML += "			<tr>";
		fileHTML += "				<th scope='col'>첨부파일명</th>";
		fileHTML += "				<th scope='col'>용량</th>";
		fileHTML += "			</tr>";
		fileHTML += "		</thead>";
		fileHTML += "		<tbody class='atchFileTbody'>";
	} else if(uploadType === "excel"){
		fileHTML += "	<input type='file' name='excelFileTemp' id='excelFileTemp' class='atchFileTemp' style='display:none;' onchange='addFiles(this)'>";
		fileHTML += "	<input type='text' name='excelFileInfo' id='excelFileInfo' style='width: 300px;' readonly='readonly' placeholder='엑셀파일 업로드'>";
		fileHTML += " 	<button type='button' class='btn bd blue' onclick='btnAddFile(this)'><span class='fa_check'>파일선택</span></button>";
	} else {
		fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' style='display:none;' multiple onchange='addFiles(this)'>";
		fileHTML += " 	<button type='button' class='btn bd blue' onclick='btnAddFile(this)'><span class='fa_check'>파일선택</span></button>";
		fileHTML += " 	<button type='button' class='btn bd red' onclick='delFile(this)'><span class='fa_remove'>파일삭제</span></button>";
		fileHTML += "	<span>파일은 최대 " + maxFileCnt + "개까지 첨부 가능합니다. (개별 용량 " + maxFileSize + "MB)</span>";
		fileHTML += "	<table class='tbl col tbl_file'>";
		fileHTML += "		<caption>첨부파일 업로드 목록</caption>";
		fileHTML += "		<colgroup>";
		fileHTML += "			<col style='width:10%;'>";
		fileHTML += "			<col>";
		fileHTML += "			<col style='width:15%'>";
		fileHTML += "		</colgroup>";
		fileHTML += "		<thead>";
		fileHTML += "			<tr>";
		fileHTML += "				<th scope='col'><input type='checkbox' class='chkAllFiles' title='전체선택' onclick='chkAllFiles(this)'></th>";
		fileHTML += "				<th scope='col'>첨부파일명</th>";
		fileHTML += "				<th scope='col'>용량</th>";
		fileHTML += "			</tr>";
		fileHTML += "		</thead>";
		fileHTML += "		<tbody class='atchFileTbody'>";
	}
	
	if (atchFileId != null && typeof(atchFileId) !== "undefined" && atchFileId !== "") {
		$.ajax({
			type : "POST"
			, url : "/itsm/file/getList.do"
			, data : {"atchFileId" : atchFileId}
			, dataType : "json"
			, async : false
			, success : function (atchFileList) {
				
				let atchFileListLeng = atchFileList.length;
				if (atchFileListLeng > 0) {
					totalFileCnt = atchFileList.length;
					atchedFileCnt = atchFileList.length;
					
					/** @namespace atchFileList.fileRlNm **/
					/** @namespace atchFileList.fileSizeVal **/
					for (let i = 0; i < atchFileListLeng; i++) {
						if (uploadType === "image") {
							if(i == 0){
								/*if(totalFileCnt >= maxFileCnt) {
									fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert' style='display: none;'>";
								} else {
									fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert'>";
								}*/
								fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert'>";
								fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
								fileHTML += "	<div class='file_btns_box r'>";
								fileHTML += "		<span class='fake_file'>";
								fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
								fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
								fileHTML += "		</span>";
								fileHTML += "	</div>";
								fileHTML += "</li>";
							}
							fileHTML += "<li>";
							fileHTML += "	<div class='file_img'><img src='/itsm/file/getImage.do?atchFileId=" + atchFileList[i].atchFileId + "&fileSeqo=" + atchFileList[i].fileSeqo + "' width='100%' onerror='/itsm/images/sub/no_img.png' alt='이미지'></div>";
							fileHTML += "	<div class='file_btns_box r'>";
							fileHTML += "		<label style='display:none'>";
							fileHTML += "			<input type='checkbox' class='check_fileDel' >";
							fileHTML += "			<input type='hidden' name='fileSeqo' value='" + atchFileList[i].fileSeqo + "'>";
							fileHTML += "		</label>";
							fileHTML += "		<span class='file_name'>"+atchFileList[i].fileRlNm+"</span>";
							fileHTML += "		<span class='fake_file'>";
							fileHTML += "			<span class='btn fake_btn btn_file' style='display:none' onclick='btnAddFile(this)'></span>";
							fileHTML += '			<span class="btn btn_file_del" onclick="delImageFile(this)"></span>'; 
							fileHTML += "		</span>";
							fileHTML += "	</div>";
							fileHTML += "</li>";
						} else if(uploadType === "imageView") {
                            fileHTML += "<li>";
                            fileHTML += "    <div class='file_img'><img src='/itsm/file/getImage.do?atchFileId="+ atchFileList[i].atchFileId +"&fileSeqo="+ atchFileList[i].fileSeqo + "' class='image' width='100%' /></div>";
                            fileHTML += "    <div class='file_btns_box r cursor viewPop' data-seq='"+atchFileList[i].fileSeqo+"' onclick='atchFileImageView(this)' data-imageNm='"+atchFileList[i].fileRlNm+"'>이미지 크게 보기</div>";
                            fileHTML += "</li>";	
						} else if(uploadType === "byteImage") {
							if(i == 0){
								/*if(totalFileCnt >= maxFileCnt) {
									fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert' style='display: none;'>";
								} else {
									fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert'>";
								}*/
								fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert'>";
								fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
								fileHTML += "	<div class='file_btns_box r'>";
								fileHTML += "		<span class='fake_file'>";
								fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
								fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
								fileHTML += "		</span>";
								fileHTML += "	</div>";
								fileHTML += "</li>";
							}
							fileHTML += "<li>";
							fileHTML += "	<div class='file_img'><img src='/itsm/file/getByteImage.do?atchFileId=" + atchFileList[i].atchFileId + "&fileSeqo=" + atchFileList[i].fileSeqo + "' width='100%' onerror='/itsm/images/sub/no_img.png' alt='이미지'></div>";
							fileHTML += "	<div class='file_btns_box r'>";
							fileHTML += "		<label style='display:none'>";
							fileHTML += "			<input type='checkbox' class='check_fileDel' >";
							fileHTML += "			<input type='hidden' name='fileSeqo' value='" + atchFileList[i].fileSeqo + "'>";
							fileHTML += "		</label>";
							fileHTML += "		<span class='file_name'>"+atchFileList[i].fileRlNm+"</span>";
							fileHTML += "		<span class='fake_file'>";
							fileHTML += "			<span class='btn fake_btn btn_file' style='display:none' onclick='btnAddFile(this)'></span>";
							fileHTML += '			<span class="btn btn_file_del" onclick="delImageFile(this)"></span>'; 
							fileHTML += "		</span>";
							fileHTML += "	</div>";
							fileHTML += "</li>";
						} else if (uploadType === "byteImageView") {
							fileHTML += "<li>";
                            fileHTML += "    <div class='file_img'><img src='/itsm/file/getByteImage.do?atchFileId="+ atchFileList[i].atchFileId +"&fileSeqo="+ atchFileList[i].fileSeqo + "' class='image' width='100%' /></div>";
                            fileHTML += "    <div class='file_btns_box r cursor viewPop' data-seq='"+atchFileList[i].fileSeqo+"' onclick='atchFileImageView(this)' data-imageNm='"+atchFileList[i].fileRlNm+"'>이미지 크게 보기</div>";
                            fileHTML += "</li>";	
						} else if(uploadType === "view") {
							let fileFextNm = atchFileList[i].fileFextNm.toLowerCase();
							let fileNm = atchFileList[i].fileRlNm;
							fileHTML += '<span style="cursor: pointer;" onclick="fileDown(\'' + atchFileList[i].atchFileId + '\',\'' + atchFileList[i].fileSeqo + '\',\'' + fileNm.replace(/'/g, "\\'") + '\')">' + fileImg(fileFextNm, fileNm) + '</span><br>';
						} else if (uploadType === "byteView") {
							let fileFextNm = atchFileList[i].fileFextNm.toLowerCase();
							let fileNm = atchFileList[i].fileRlNm
							fileHTML += "<tr>";
							fileHTML += '	<td class="pad_l10 no_bdl"><span style="cursor: pointer;" onclick="fileByteDown(\'' + atchFileList[i].atchFileId + '\',\'' + atchFileList[i].fileSeqo + '\',\'' + fileNm + '\')">' + fileImg(fileFextNm, fileNm) + '</span></td>';
							fileHTML += "	<td class='pad_l10 c'>" + convertFileSize(atchFileList[i].fileSizeVal) + "</td>";
							fileHTML += "</tr>";
						} else if (uploadType === "cmntByteView") {
							let fileFextNm = atchFileList[i].fileFextNm.toLowerCase();
							let fileNm = atchFileList[i].fileRlNm
							fileHTML += '<span style="cursor: pointer;" onclick="fileByteDown(\'' + atchFileList[i].atchFileId + '\',\'' + atchFileList[i].fileSeqo + '\',\'' + fileNm + '\')">' + fileImg(fileFextNm, fileNm) + '</span>';
							if(atchFileList[i].fileTpNm.indexOf('image') != -1){
								fileHTML += '&nbsp;&nbsp;<span class="thum_img_info btn_sml" style="cursor: pointer;height: 23px;" onclick="fncPreviewShow(\'' + atchFileList[i].atchFileId + '\',\'' + atchFileList[i].fileSeqo + '\',\'' + fileNm + '\');return false;">';
								fileHTML += '<i class="xi-zoom-in">미리보기</i></span><br>';
							}else{
								fileHTML += '<br>';
							}
						} else {
							fileHTML += "<tr>";
							fileHTML += "	<td class='c no_bdl'>";
							fileHTML += "		<label>";
							fileHTML += "			<input type='checkbox' class='check_fileDel'>";
							fileHTML += "			<input type='hidden' name='fileSeqo' value='" + atchFileList[i].fileSeqo + "'>";
							fileHTML += "		</label>";
							fileHTML += "	</td>";
							fileHTML += "	<td class='pad_l10'>" + atchFileList[i].fileRlNm + "</td>";
							fileHTML += "	<td class='pad_l10'>" + convertFileSize(atchFileList[i].fileSizeVal) + "</td>";
							fileHTML += "</tr>";
						}
						
						
					}
				} else {
					if (uploadType === "image") {
						fileHTML += "<li>";
						fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
						fileHTML += "	<div class='file_btns_box r'>";
						fileHTML += "		<span class='fake_file'>";
						fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
						fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
						fileHTML += "		</span>";
						fileHTML += "	</div>";
						fileHTML += "</li>";
					} else if(uploadType === "imageView") {
                        fileHTML += "<li>";
                        fileHTML += "    <div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
                        fileHTML += "    <div class='file_btns_box r'>";
                        fileHTML += "        <span class='fake_file'>";
                        fileHTML += "            <span class='btn fake_btn btn_file'></span>";
                        fileHTML += "            <span class='btn btn_file_del' style='display:none'></span>";
                        fileHTML += "        </span>";
                        fileHTML += "    </div>";
                        fileHTML += "</li>";
					} else if(uploadType === "byteImage") {
						fileHTML += "<li>";
						fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
						fileHTML += "	<div class='file_btns_box r'>";
						fileHTML += "		<span class='fake_file'>";
						fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
						fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
						fileHTML += "		</span>";
						fileHTML += "	</div>";
						fileHTML += "</li>";
					} else if (uploadType === "byteImageView") {
						fileHTML += "<li>";
                        fileHTML += "    <div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
                        fileHTML += "    <div class='file_btns_box r'>";
                        fileHTML += "        <span class='fake_file'>";
                        fileHTML += "        </span>";
                        fileHTML += "    </div>";
                        fileHTML += "</li>";
					} else if(uploadType === "view" || uploadType === "cmntByteView") {
						fileHTML += "첨부파일이 없습니다.";
					} else if (uploadType === "byteView") {
						fileHTML += "<tr><td colSpan='2' class='no_data'>첨부파일이 없습니다.</td></tr>";
					} else if(uploadType === "excel") {
						fileHTML += "";
					} else {
						fileHTML += "<tr><td colSpan='3' class='no_data'>첨부파일이 없습니다.</td></tr>";
					}
				}
			}
			, error : function () {
				alert("file 호출 오류");
			}
		});
		$("#"+atchFileIdNm).attr("data-totalCnt",totalFileCnt);
	} else {
		if (uploadType === "image") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if(uploadType === "imageView") {
            fileHTML += "<li>";
            fileHTML += "    <div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
            fileHTML += "    <div class='file_btns_box r'>";
            fileHTML += "        <span class='fake_file'>";
            fileHTML += "            <span class='btn fake_btn btn_file'></span>";
            fileHTML += "            <span class='btn btn_file_del' style='display:none'></span>";
            fileHTML += "        </span>";
            fileHTML += "    </div>";
            fileHTML += "</li>";
		} else if(uploadType === "byteImage") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if (uploadType === "byteImageView") {
			fileHTML += "<li>";
            fileHTML += "    <div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
            fileHTML += "    <div class='file_btns_box r'>";
            fileHTML += "        <span class='fake_file'>";
            fileHTML += "        </span>";
            fileHTML += "    </div>";
            fileHTML += "</li>";
		} else if(uploadType === "view" || uploadType === "cmntByteView") {
			fileHTML += "첨부파일이 없습니다.";
		} else if (uploadType === "byteView") {
			fileHTML += "<tr><td colSpan='2' class='no_data'>첨부파일이 없습니다.</td></tr>";
		} else if(uploadType === "excel") {
			fileHTML += "";
		} else {
			fileHTML += "<tr><td colSpan='3' class='no_data'>첨부파일이 없습니다.</td></tr>";
		}
		$("#"+atchFileIdNm).attr("data-totalCnt","0");
	}
	
	if (uploadType === "image") {
		fileHTML += "	</ul>";
	} else if(uploadType === "imageView") {
        fileHTML += "    </ul>";
	} else if(uploadType === "byteImage") {
		fileHTML += "	</ul>";
	} else if (uploadType === "byteImageView") {
		fileHTML += "    </ul>";
	} else if(uploadType === "view" || uploadType === "cmntByteView") {
		fileHTML += "		</tbody>";
		fileHTML += "	</table>";
	} else if (uploadType === "byteView") {
		fileHTML += "		</tbody>";
		fileHTML += "	</table>";
	} else if(uploadType === "excel") {
		fileHTML += "";
	} else {
		fileHTML += "		</tbody>";
		fileHTML += "	</table>";
	}
	fileHTML += "	<input type='hidden' class='totalFileCnt' value='" + totalFileCnt + "'>";
	fileHTML += "	<input type='hidden' class='atchedFileCnt' value='" + atchedFileCnt + "'>";
	fileHTML += "</div>";
	
	return fileHTML;
}

// 전체 선택/해제
const chkAllFiles = function (obj) {
	const isChk = $(obj).is(":checked");
	const atchFileTbody = $(obj).parents("table").children(".atchFileTbody");
	atchFileTbody.find("input").filter(".check_fileDel").prop("checked", isChk);
}

// '파일 선택' 버튼 클릭
const btnAddFile = function (obj) {
	const atchFileTemp = $(obj).parents(".file_wrap").children(".atchFileTemp");
	atchFileTemp.trigger("click");
}

// 첨부파일 추가
const addFiles = function (obj) {
	const atchFileTemp = $(obj);
	const files = atchFileTemp[0].files;
	
	const div = $(obj).parent("div");
	const atchFileIdTemp = div.find(".atchFileIdTemp").val();
	const atchFileIdNm = div.find(".atchFileIdNm").val();
	const uploadType = div.find(".uploadType").val();
	const atchFileNotExist = div.find(".no_data");
	const atchFileTbody = div.find(".atchFileTbody");
	let maxFileTempCnt = Number(div.children(".maxFileCnt").val());
	let totalFileCnt = Number(div.children(".totalFileCnt").val());
	
	// 파일 배열 담기
	const atchFileArr = window["atchFileArr_" + atchFileIdNm];
	const fileArr = Array.prototype.slice.call(files);
	
	// 첨부파일 수 제한 확인
	const currentFileCnt = totalFileCnt + fileArr.length;
	if (currentFileCnt > maxFileCnt) {
		alert("파일은 최대 " + maxFileCnt +"개까지 첨부가능합니다.");
		// 초기화
		atchFileTemp.val("");
		return false;
	}
	
	// 각각의 파일 배열에 담기 및 기타
	fileArr.forEach(function (f) {
		const reader = new FileReader();

		reader.onload = function () {
			const maxFileSizeMb = maxFileSize * 1024 * 1024;
			// 첨부파일 용량 제한 확인(개별)
			if (f.size > maxFileSizeMb) {
				// 첨부파일 용량 제한 확인(개별)
				if (f.size > maxFileSizeMb) {
					alert("최대 첨부파일 용량은 " + maxFileSize + "MB 입니다.");
					return false;
				}
			}
			
			// 확장자 확인
			const delimiter = f.name.lastIndexOf(".");
			const ext = f.name.substring(delimiter + 1).toLowerCase();
			const allowExt = ["jpg", "jpeg", "png", "gif", "bmp", "tif", "tiff"];
			const bltnbClVal = $("#bltnbClVal");
			let imgOnlyYn = "N";
			if (bltnbClVal != null && typeof(bltnbClVal) !== "undefined") {
				if (bltnbClVal.val() === "gr" || bltnbClVal.val() === "gb") {
					imgOnlyYn = "Y";
				}
			}
			if (imgOnlyYn === "N" && uploadType !== "image") {
				allowExt.push("pdf", "word", "hwp", "doc", "docx", "ppt", "pptx", "xlsx", "xls", "txt", "zip", "7zip", "egg");
			}

			if(uploadType === "excel"){
				let excelExt = ["xlsx", "xls"];
				if($.inArray(ext, excelExt) === -1){
					alert("엑셀파일만 업로드 가능합니다.");
					atchFileTemp.val("");
					return false;
				}
			}else{
				if($.inArray(ext, allowExt) === -1) {
					alert("지원하지 않는 파일 확장자입니다.");
					// 초기화
					atchFileTemp.val("");
					return false;
				}
			}


			atchFileArr.push(f);
			
			if (totalFileCnt === 0) {
				atchFileNotExist.parent().remove();
			}
			
			let html = "";
			if (uploadType === "image") {
				html += "<li>";
				html += "	<div class='file_img'><img src='" + reader.result + "' width='100%' onerror='/itsm/images/sub/no_img.png' alt='이미지'></div>";
				html += "	<div class='file_btns_box r'>";
				html += "		<label style='display:none'>";
				html += "			<input type='checkbox' class='check_fileDel'>";
				html += "		</label>";
				html += "		<span class='file_name'>"+f.name+"</span>";
				html += "		<span class='fake_file'>";
				html += "			<span class='btn fake_btn btn_file' style='display:none' onclick='btnAddFile(this)'></span>";
				html += "			<span class='btn btn_file_del' onclick='delImageFile(this)'></span>";
				html += "		</span>";
				html += "	</div>";
				html += "</li>";
			} else if (uploadType === "byteImage") {
				html += "<li>";
				html += "	<div class='file_img'><img src='" + reader.result + "' width='100%' onerror='/itsm/images/sub/no_img.png' alt='이미지'></div>";
				html += "	<div class='file_btns_box r'>";
				html += "		<label style='display:none'>";
				html += "			<input type='checkbox' class='check_fileDel'>";
				html += "		</label>";
				html += "		<span class='file_name'>"+f.name+"</span>";
				html += "		<span class='fake_file'>";
				html += "			<span class='btn fake_btn btn_file' style='display:none' onclick='btnAddFile(this)'></span>";
				html += "			<span class='btn btn_file_del' onclick='delImageFile(this)'></span>";
				html += "		</span>";
				html += "	</div>";
				html += "</li>";
			} else {
				html += "<tr>";
				html += "   <td><input type='checkbox' class='check_fileDel' id='file"+totalFileCnt+"'></td>";
				html += "   <td><div class='file_tit'>";
				html += "   	<label for='file"+totalFileCnt+"'>" + f.name + "</label>";
				html += "   </div></td>";
				html += "   <td>" + convertFileSize(f.size) + "</td>";
				html += "</tr>";
			}
			
			if (uploadType === "image") {
				atchFileTbody.append(html);
			} else if (uploadType === "byteImage") {
				atchFileTbody.append(html);
			} else if (uploadType === "excel"){
				if($("#excelFileInfo").length > 0) {
					$("#excelFileInfo").val(f.name + "(" + convertFileSize(f.size) + ")");
				} else {
					atchFileTbody.append(html);
				}
			} else {
				atchFileTbody.append(html);
			}
			
			totalFileCnt++;
			div.children(".totalFileCnt").val(totalFileCnt);
			div.find(".fileChgYn").val("Y");
			
			$("#"+atchFileIdNm).attr("data-totalCnt",totalFileCnt);
			
			// 이미지 최대 파일수에 도달할경우 추가버튼 제거
			/*if (uploadType === "image") {
				if(totalFileCnt >= maxFileTempCnt) {
					$('#'+atchFileIdNm +'_ImgInsert').hide();
				}
			}*/
		}
		
		reader.readAsDataURL(f);
	});
	
	// 초기화
	if (uploadType !== "excel"){
		atchFileTemp.val("");
	}

	return false;
}

// 파일 삭제
const delFile = function (obj) {
	const div = $(obj).closest(".file_wrap");
	const atchFileIdNm = div.find(".atchFileIdNm").val();
	const uploadType = div.find(".uploadType").val();
	const atchFileTbody = div.find(".atchFileTbody");
	const atchFileIdTemp = div.find(".atchFileIdTemp").val();
	let totalFileCnt = Number(div.children(".totalFileCnt").val());
	const atchedFileCnt = Number(div.children(".atchedFileCnt").val());
	const atchFileArr = window["atchFileArr_" + atchFileIdNm];
	const deleteFileArr = window["deleteFileArr_" + atchFileIdNm];
	console.log($(obj).parent("span").parent("div").children("label").children(".check_fileDel").prop("checked",true));
	console.log($(obj).parent("span").parent("div").children("label").children(".check_fileDel").is(":checked"));
	atchFileTbody.find(".check_fileDel:checked").each(function () {
		console.log($(this));
		let delRow = $(this).parents("tr");
		let delRowIdx = atchFileTbody.find(delRow).index();
		const fileSeqo = $(this).siblings("[name='fileSeqo']").val();
		if (typeof(fileSeqo) === "undefined" || fileSeqo == null || fileSeqo === "") {
			// 새로 추가한 파일이면 atchFileArr에서 제거
			atchFileArr.splice(delRowIdx - atchedFileCnt, 1);
		} else {
			// 기존 첨부파일이면 deleteFileArr에 담기
			const param = {
				"atchFileId" : atchFileIdTemp
				, "fileSeqo" : fileSeqo
			};
			deleteFileArr.push(param);
			div.children(".atchedFileCnt").val(atchedFileCnt - 1); // 기존에 첨부된 파일 삭제시 첨부된 파일건수 - 1 처리 해줘야함
		}
		
		if (totalFileCnt > 0) {
			totalFileCnt--;
			div.children(".totalFileCnt").val(totalFileCnt);
			$("#"+atchFileIdNm).attr("data-totalCnt",totalFileCnt);
		}
		
		// 화면에서 지우기
		atchFileTbody.find("tr").eq(delRowIdx).remove();
		
		div.find(".fileChgYn").val("Y");
		
	});
	
	// 삭제 후 파일 수 확인
	if (Number(div.children(".totalFileCnt").val()) === 0) {
		let fileHTML = "";
		if (uploadType === "image") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if (uploadType === "byteImage") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else {
			fileHTML += "<tr><td colSpan='3' class='no_data'>첨부파일이 없습니다.</td></tr>";
		}
		
		$(".chkAllFiles").prop("checked", false);
		atchFileTbody.html(fileHTML);
	}
	
	
};


// 파일 삭제
const delImageFile = function (obj) {
	const div = $(obj).closest(".file_wrap");
	const atchFileIdNm = div.find(".atchFileIdNm").val();
	const uploadType = div.find(".uploadType").val();
	const atchFileTbody = div.find(".atchFileTbody");
	const atchFileIdTemp = div.find(".atchFileIdTemp").val();
	let totalFileCnt = Number(div.children(".totalFileCnt").val());
	const atchedFileCnt = Number(div.children(".atchedFileCnt").val());
	let maxFileTempCnt = Number(div.children(".maxFileCnt").val());
	
	const atchFileArr = window["atchFileArr_" + atchFileIdNm];
	const deleteFileArr = window["deleteFileArr_" + atchFileIdNm];
	$(obj).parent("span").parent("div").children("label").children(".check_fileDel").prop("checked",true)
	atchFileTbody.find(".check_fileDel:checked").each(function () {
		let delRow = $(this).parents("li");
		let delRowIdx = atchFileTbody.find(delRow).index();
		const fileSeqo = $(this).siblings("[name='fileSeqo']").val();
		if (typeof(fileSeqo) === "undefined" || fileSeqo == null || fileSeqo === "") {
			// 새로 추가한 파일이면 atchFileArr에서 제거
			atchFileArr.splice(delRowIdx-atchedFileCnt-1, 1);
		} else {
			// 기존 첨부파일이면 deleteFileArr에 담기
			const param = {
				"atchFileId" : atchFileIdTemp
				, "fileSeqo" : fileSeqo
			};
			deleteFileArr.push(param);
		}
		
		if (totalFileCnt > 0) {
			totalFileCnt--;
			div.children(".totalFileCnt").val(totalFileCnt);
			$("#"+atchFileIdNm).attr("data-totalCnt",totalFileCnt);
		}
		
		// 화면에서 지우기
		atchFileTbody.find("li").eq(delRowIdx).remove();
		
		div.find(".fileChgYn").val("Y");
		
	});
	
	// 삭제 후 파일 수 확인
	if (Number(div.children(".totalFileCnt").val()) === 0) {
		let fileHTML = "";
		if (uploadType === "image") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if (uploadType === "byteImage") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/component/itsm/images/sub/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else {
			fileHTML += "<tr><td colSpan='3' class='no_data'>첨부파일이 없습니다.</td></tr>";
		}
		
		$(".chkAllFiles").prop("checked", false);
		atchFileTbody.html(fileHTML);
	}
	
	// 삭제 후 최대 파일수 확인후 추가버튼 액션
	/*if(Number(div.children(".totalFileCnt").val()) < maxFileTempCnt) {
		$('#'+atchFileIdNm +'_ImgInsert').show();
	}*/
	
	
};

// 첨부파일 등록/수정/삭제 처리 후 atchFileId 세팅
// targetFormId : formData로 변환할 form id
// procType : insert 등록, update 수정, delete 삭제
// func : 콜백 함수
const fileFormSubmit = function (targetFormId, procType, func, del) {
	if (targetFormId == null || typeof(targetFormId) === "undefined" || targetFormId === "") {
		alert("대상 form이 없습니다.");
		return false;
	}
	if (procType == null || typeof(procType) === "undefined" || procType === "") {
		alert("처리 구분값이 없습니다.");
		return false;
	}
	
	const atchFileArea = $("input[name='atchFileIdNm']");
	
	let errorYn = "N";
	
	atchFileArea.each(function () {
		const fileChgYn = $(this).siblings(".fileChgYn").val();
		
		// 수정이 일어난 경우만 atchFileId 세팅
		if (fileChgYn === "Y") {
			const formData = new FormData();
			const atchFileIdNm = $(this).val();
			const atchFileIdTemp = $(this).siblings(".atchFileIdTemp").val();
			const atchPnu = $(this).siblings(".atchPnu").val();
			// FileVO.atchFileId 세팅
			formData.append("atchFileId", atchFileIdTemp);
			formData.append("pnu", atchPnu);
			
			const atchFileArr = window["atchFileArr_" + atchFileIdNm];
			const deleteFileArr = window["deleteFileArr_" + atchFileIdNm];
			
			// 새로 추가한 파일 전송
			if (atchFileArr.length > 0) {
				for (let i = 0; i < atchFileArr.length; i++) {
					formData.append("files", atchFileArr[i]);
				}
			}
			// 게시물 수정 시 기존 첨부파일 삭제 있을 경우
			if (deleteFileArr.length > 0) {
				formData.append("deleteFileJsonString", JSON.stringify(deleteFileArr));
			}
		
			$.ajax({
				type : "POST"
				, url : "/itsm/file/" + procType + "Proc.do"
				, data : formData
				, async : false
				, dataType : "json"
				, contentType : false
				, processData : false
				, enctype : "multipart/form-data"
				, success : function (data) {
					if (data.result === "Y") {
						// 대상 input에 atchFileId 세팅
						$("#" + atchFileIdNm).val(data.atchFileId);
						if(del !== "NO_DEL"){
							delete window["atchFileArr_" + atchFileIdNm];
							delete window["deleteFileArr_" + atchFileIdNm];
						}
					}
				}
				, error : function () {
					errorYn = "Y";
					alert("파일 업로드 도중 에러 발생");
				}
			});
		}
	});
	
	// 콜백함수 있을 경우만 실행
	if (errorYn !== "Y") {
		if (func) {
			if (typeof func === "function") {
				func();
			}
		}
	}
	
	return false;
};

// 파일 사이즈 표시 변환(소수점 아래 2자리까지 표시)
// bytes : 파일 사이즈(byte 단위)
const convertFileSize = function (bytes) {
	if (bytes === 0) {
		return "0bytes";
	}
	
	const sizes = ["bytes", "KB", "MB", "GB", "TB"];
	const i = Math.floor(Math.log(bytes) / Math.log(1024));
	
	return parseFloat((bytes / Math.pow(1024, i)).toFixed(2)) + "" + sizes[i];
}

function fileDown(fileId, fileSeqo, fileRlnm){
	$("#downAtchFileId").val(fileId);
	$("#downAtchSeqo").val(fileSeqo);
	$("#downAtchRlNm").val(fileRlnm);
	$("#fileDownFrm").attr({
		action : "/itsm/file/down.do",
		method : "post",
		target : "fileDownFrm",
		onsubmit : ""
	}).submit();
}

function fileByteDown(fileId, fileSeqo, fileRlnm){
	$("#downAtchFileId").val(fileId);
	$("#downAtchSeqo").val(fileSeqo);
	$("#downAtchRlNm").val(fileRlnm);
	$("#fileDownFrm").attr({
		action : "/itsm/file/downloadByte.do",
		method : "post",
		target : "_self",
		onsubmit : ""
	}).submit();
}


function fileImg(fileFextNm, fileNm){
	let fileHTML = "";
	if(fileFextNm === "xlsx" || fileFextNm === "xls"){
		fileHTML = "<img src='/component/itsm/images/sub/file_excel.png'>" + fileNm
	} else if(fileFextNm === "pptx" || fileFextNm === "ppt"){
		fileHTML = "<img src='/component/itsm/images/sub/file_ppt.png'>" + fileNm
	} else if(fileFextNm === "docx" || fileFextNm === "doc"){
		fileHTML = "<img src='/component/itsm/images/sub/file_word.png'>" + fileNm
	} else if(fileFextNm === "hwp"){
		fileHTML = "<img src='/component/itsm/images/sub/file_hwp.png'>" + fileNm
	} else if(fileFextNm === "pdf"){
		fileHTML = "<img src='/component/itsm/images/sub/file_pdf.png'>" + fileNm
	} else if(fileFextNm === "zip" || fileFextNm === "7zip" || fileFextNm === "egg"){
		fileHTML = "<img src='/component/itsm/images/sub/file_zip.png'>" + fileNm
	} else if(fileFextNm === "jpg" || fileFextNm === "jpeg" || fileFextNm === "png" || fileFextNm === "gif" || fileFextNm === "bmp" || fileFextNm === "tif" || fileFextNm === "tiff"){
		fileHTML = "<img src='/component/itsm/images/sub/file_img.png'>" + fileNm
	} else {
		fileHTML = fileNm
	}
	return fileHTML;
}


// 이미지 크게보기
// 2022.09.29 구연호 추가
function atchFileImageView(obj){
	
	var src = $(obj).prev().children('.image').attr('src');
	var imageNm = $(obj).attr('data-imageNm');
	console.log(src);
	
	var imgHtml = ''; 
		imgHtml += "<div class='pop_header'><h2 id='title'>"+imageNm+"</h2></div>";
		imgHtml += "<div class='pop_content' style='border-radius:0;'>";
		imgHtml += "<div class='img_wrap' style='height:100%;'><img src='" + src + "' style='display:block; object-fit:contain; width:100%; height:100%;'/></div></div>";
		imgHtml += "<div class='pop_footer'><a href='javascript:void(0)' class='btn lg gray' onclick='modal_hide(this);'>닫기</a></div>";
		modal_show('1000px', '800px', imgHtml);
}



function fncPreviewShow(fileId, seqo, nm){
	fncAjax('/itsm/file/previewImg.do', {"atchFileId" : fileId, "fileSeqo" : seqo, "fileRlNm" : nm}, 'html', true, '', function(data){
		modal_show('1000px','650px',data);
	});
}