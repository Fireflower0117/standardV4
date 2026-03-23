let maxFileCnt = 5;			// 최대 첨부파일 수(5개로 임의 설정)
let maxFileSize = 10;		// 첨부파일별 최대 용량(10MB로 임의 설정)

// 첨부파일 view 추가
// atchFileId : 조회할 첨부파일의 ID
// atchFileIdNm : 첨부파일ID를 세팅할 input id
// uploadType : file(일반 업로드. 생략 가능), image(이미지 업로드)
// deprecated (2026.03.02 KJN) TO-BE : on.file.setFileList로 대체
const setFileList = function () {
	
	const getArgs = arguments;
	let atchFileId ="";
	let atchFileIdNm = "";
	let uploadType = "";
	
	if(getArgs.length > 1){
		switch (getArgs.length) {
	 		case 3: atchFileId = getArgs[0]; atchFileIdNm = getArgs[1]; uploadType = getArgs[2];break;
	 		case 4: atchFileId = getArgs[0]; atchFileIdNm = getArgs[1]; uploadType = getArgs[2]; maxFileCnt = getArgs[3];break;
	 		case 5: atchFileId = getArgs[0]; atchFileIdNm = getArgs[1]; uploadType = getArgs[2]; maxFileCnt = getArgs[3]; maxFileSize = getArgs[4]; break;
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
	} else if (uploadType === "view") {
		fileHTML += "	<ul class='file_li'> ";
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
		fileHTML += " 	<button type='button' class='btn bd blue btn_fil' onclick='btnAddFile(this)'><span class='fa_check'>파일선택</span></button>";
		fileHTML += " 	<button type='button' class='btn bd red btn_fileDel' onclick='delFile(this)'><span class='fa_remove'>파일삭제</span></button>";
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
			, url : "/file/getList.do"
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
								fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
								fileHTML += "	<div class='file_btns_box r'>";
								fileHTML += "	<span>이미지 업로드 최대 " + maxFileCnt + "개 가능</span>";
								fileHTML += "		<span class='fake_file'>";
								fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
								fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
								fileHTML += "		</span>";
								fileHTML += "	</div>";
								fileHTML += "</li>";
							}
							fileHTML += "<li>";
							fileHTML += "	<div class='file_img'><img src='/file/getImage.do?atchFileId=" + atchFileList[i].atchFileId + "&fileSn=" + atchFileList[i].fileSn + "&fileNmPhclFileNm=" + atchFileList[i].fileNmPhclFileNm + "' width='100%' onerror='/internal/standard/common/images/no_img.png' alt='이미지'></div>";
							fileHTML += "	<div class='file_btns_box r'>";
							fileHTML += "		<label style='display:none'>";
							fileHTML += "			<input type='checkbox' class='check_fileDel' >";
							fileHTML += "			<input type='hidden' name='fileSn' value='" + atchFileList[i].fileSn + "'>";
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
                            fileHTML += "    <div class='file_img'><img src='/file/getImage.do?atchFileId="+ atchFileList[i].atchFileId +"&fileSn="+ atchFileList[i].fileSn + "&fileNmPhclFileNm=" + atchFileList[i].fileNmPhclFileNm + "' class='image' width='100%' /></div>";
                            fileHTML += "    <div class='file_btns_box r cursor viewPop' data-seq='"+atchFileList[i].fileSn+"' onclick='atchFileImageView(this)' data-imageNm='"+atchFileList[i].fileRlNm+"'>이미지 크게 보기</div>";
                            fileHTML += "</li>";	
						} else if(uploadType === "byteImage") {
							if(i == 0){
								/*if(totalFileCnt >= maxFileCnt) {
									fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert' style='display: none;'>";
								} else {
									fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert'>";
								}*/
								fileHTML += "<li id='"+atchFileIdNm+"_ImgInsert'>";
								fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
								fileHTML += "	<div class='file_btns_box r'>";
								fileHTML += "		<span class='fake_file'>";
								fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
								fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
								fileHTML += "		</span>";
								fileHTML += "	</div>";
								fileHTML += "</li>";
							}
							fileHTML += "<li>";
							fileHTML += "	<div class='file_img'><img src='/file/getByteImage.do?atchFileId=" + atchFileList[i].atchFileId + "&fileSn=" + atchFileList[i].fileSn + "&fileNmPhclFileNm=" + atchFileList[i].fileNmPhclFileNm + "' width='100%' onerror='/internal/standard/common/images/no_img.png' alt='이미지'></div>";
							fileHTML += "	<div class='file_btns_box r'>";
							fileHTML += "		<label style='display:none'>";
							fileHTML += "			<input type='checkbox' class='check_fileDel' >";
							fileHTML += "			<input type='hidden' name='fileSn' value='" + atchFileList[i].fileSn + "'>";
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
                            fileHTML += "    <div class='file_img'><img src='/file/getByteImage.do?atchFileId="+ atchFileList[i].atchFileId +"&fileSn="+ atchFileList[i].fileSn + "&fileNmPhclFileNm=" + atchFileList[i].fileNmPhclFileNm + "' class='image' width='100%' /></div>";
                            fileHTML += "    <div class='file_btns_box r cursor viewPop' data-seq='"+atchFileList[i].fileSn+"' onclick='atchFileImageView(this)' data-imageNm='"+atchFileList[i].fileRlNm+"'>이미지 크게 보기</div>";
                            fileHTML += "</li>";	
						} else if(uploadType === "view") {
							let fileFextNm = atchFileList[i].fileFextNm.toLowerCase();
							let fileNm = atchFileList[i].fileRlNm
							fileHTML += '<li><a href="javascript:void(0);" onclick="fileDown(\'' + atchFileList[i].atchFileId + '\',\'' + atchFileList[i].fileSn + '\',\'' + fileNm + '\',\''+atchFileList[i].fileNmPhclFileNm+'\')">' + fileImg(fileFextNm, fileNm) + '</a></li>';
						} else if (uploadType === "byteView") {
							let fileFextNm = atchFileList[i].fileFextNm.toLowerCase();
							let fileNm = atchFileList[i].fileRlNm
							fileHTML += "<tr>";
							fileHTML += '	<td class="pad_l10 no_bdl"><span style="cursor: pointer;" onclick="fileByteDown(\'' + atchFileList[i].atchFileId + '\',\'' + atchFileList[i].fileSn + '\',\'' + fileNm + '\',\''+atchFileList[i].fileNmPhclFileNm+'\')">' + fileImg(fileFextNm, fileNm) + '</span></td>';
							fileHTML += "	<td class='pad_l10'>" + convertFileSize(atchFileList[i].fileSizeVal) + "</td>";
							fileHTML += "</tr>";
						} else {
							fileHTML += "<tr>";
							fileHTML += "	<td class='c no_bdl'>";
							fileHTML += "		<label>";
							fileHTML += "			<input type='checkbox' class='check_fileDel'>";
							fileHTML += "			<input type='hidden' name='fileSn' value='" + atchFileList[i].fileSn + "'>";
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
						fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
						fileHTML += "	<div class='file_btns_box r'>";
						fileHTML += "	<span>이미지 업로드 최대 " + maxFileCnt + "개 가능</span>";
						fileHTML += "		<span class='fake_file'>";
						fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
						fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
						fileHTML += "		</span>";
						fileHTML += "	</div>";
						fileHTML += "</li>";
					} else if(uploadType === "imageView") {
                        fileHTML += "<li>";
                        fileHTML += "    <div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
                        fileHTML += "    <div class='file_btns_box r'>";
                        fileHTML += "        <span class='fake_file'>";
                        fileHTML += "            <span class='btn fake_btn btn_file'></span>";
                        fileHTML += "            <span class='btn btn_file_del' style='display:none'></span>";
                        fileHTML += "        </span>";
                        fileHTML += "    </div>";
                        fileHTML += "</li>";
					} else if(uploadType === "byteImage") {
						fileHTML += "<li>";
						fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
						fileHTML += "	<div class='file_btns_box r'>";
						fileHTML += "		<span class='fake_file'>";
						fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
						fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
						fileHTML += "		</span>";
						fileHTML += "	</div>";
						fileHTML += "</li>";
					} else if (uploadType === "byteImageView") {
						fileHTML += "<li>";
                        fileHTML += "    <div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
                        fileHTML += "    <div class='file_btns_box r'>";
                        fileHTML += "        <span class='fake_file'>";
                        fileHTML += "        </span>";
                        fileHTML += "    </div>";
                        fileHTML += "</li>";
					} else if(uploadType === "view") {
						fileHTML += "<tr><td colSpan='2' class='no_data'>첨부파일이 없습니다.</td></tr>";
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
				alert("error");
			}
		});
		$("#"+atchFileIdNm).attr("data-totalCnt",totalFileCnt);
	} else {
		if (uploadType === "image") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "	<span>이미지 업로드 최대 " + maxFileCnt + "개 가능</span>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if(uploadType === "imageView") {
            fileHTML += "<li>";
            fileHTML += "    <div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
            fileHTML += "    <div class='file_btns_box r'>";
            fileHTML += "    </div>";
            fileHTML += "</li>";
		} else if(uploadType === "byteImage") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if (uploadType === "byteImageView") {
			fileHTML += "<li>";
            fileHTML += "    <div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
            fileHTML += "    <div class='file_btns_box r'>";
            fileHTML += "        <span class='fake_file'>";
            fileHTML += "        </span>";
            fileHTML += "    </div>";
            fileHTML += "</li>";
		} else if(uploadType === "view") {
			fileHTML += "<tr><td colSpan='2' class='no_data'>첨부파일이 없습니다.</td></tr>";
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
	} else if(uploadType === "view") {
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
	const atchFileIdNm = div.find(".atchFileIdNm").val();
	const uploadType = div.find(".uploadType").val();
	const atchFileNotExist = div.find(".no_data");
	const atchFileTbody = div.find(".atchFileTbody");

	// 파일 용량 제한 값 (없으면 기본값 세팅 방어)
	let maxFileSizeStr = div.children(".maxFileSize").val();
	let maxFileSize = maxFileSizeStr ? Number(maxFileSizeStr) : 50;
	let maxFileCnt = Number(div.children(".maxFileCnt").val());
	let totalFileCnt = Number(div.children(".totalFileCnt").val());

	// 화면 렌더링 시 숨겨둔 허용 확장자 목록 꺼내기
	const allowedExtStr = div.find(".allowedExt").val();
	let allowedExtArr = [];
	if (allowedExtStr) {
		allowedExtArr = allowedExtStr.split(",");
	}
	/* else {
		allowedExtArr = ["jpg", "jpeg", "png", "gif", "bmp", "tif", "tiff", "pdf", "word", "hwp", "doc", "docx", "ppt", "pptx", "xlsx", "xls", "txt", "zip", "7zip", "egg"];
	} */

	// 파일 배열 담기
	const atchFileArr = window["atchFileArr_" + atchFileIdNm] || [];
	window["atchFileArr_" + atchFileIdNm] = atchFileArr;

	const fileArr = Array.prototype.slice.call(files);

	// 첨부파일 수 제한 확인
	const currentFileCnt = totalFileCnt + fileArr.length;
	if (currentFileCnt > maxFileCnt) {
		on.msg.showMsg({message : "파일은 최대 " + maxFileCnt +"개까지 첨부 가능합니다."});
		// 초기화
		atchFileTemp.val("");
		return false;
	}

	// 각각의 파일 배열에 담기 전, 확장자/용량 1차 검증 (forEach 전에 에러 잡기)
	let hasError = false;
	for (let i = 0; i < fileArr.length; i++) {
		let f = fileArr[i];

		// 용량 검증
		const maxFileSizeMb = maxFileSize * 1024 * 1024;
		if (f.size > maxFileSizeMb) {
			on.msg.showMsg({message : "최대 첨부파일 용량은 " + maxFileSize + "MB 입니다."});
			hasError = true;
			break;
		}

		// 확장자 검증 (탐색기 뚫고 들어온 파일 완벽 차단)
		const delimiter = f.name.lastIndexOf(".");
		const ext = f.name.substring(delimiter + 1).toLowerCase();

		// 엑셀 전용 폼이 아닌 경우, allowedExtArr 배열로 검증
		if (uploadType !== "excel") {
			if ($.inArray(ext, allowedExtArr) === -1) {
				on.msg.showMsg({message : "허용되지 않는 파일 확장자입니다.\n(업로드 가능: " + allowedExtArr.join(", ") + ")"});
				hasError = true;
				break;
			}
		} else {
			// 엑셀 전용일 때 로직 유지
			let excelExt = ["xlsx", "xls"];
			if ($.inArray(ext, excelExt) === -1) {
				on.msg.showMsg({message : "엑셀 파일만 업로드 가능합니다."});
				hasError = true;
				break;
			}
		}
	}

	// 에러가 하나라도 있으면 전체 업로드 중단 및 초기화
	if (hasError) {
		atchFileTemp.val("");
		return false;
	}

	// 검증을 무사히 통과한 파일들만 실제 화면 처리
	fileArr.forEach(function (f) {
		const reader = new FileReader();

		reader.onload = function () {
			atchFileArr.push(f);

			if (totalFileCnt === 0) {
				atchFileNotExist.parent().remove();
			}

			let html = "";
			if (uploadType === "image" || uploadType === "byteImage") {
				html += "<li>";
				html += "  <div class='file_img'><img src='" + reader.result + "' width='100%' onerror='/internal/standard/common/images/no_img.png' alt='이미지'></div>";
				html += "  <div class='file_btns_box r'>";
				html += "     <label style='display:none'>";
				html += "        <input type='checkbox' class='check_fileDel'>";
				html += "     </label>";
				html += "     <span class='file_name'>"+f.name+"</span>";
				html += "     <span class='fake_file'>";
				html += "        <span class='btn fake_btn btn_file' style='display:none' onclick='btnAddFile(this)'></span>";
				html += "        <span class='btn btn_file_del' onclick='delImageFile(this)'></span>";
				html += "     </span>";
				html += "  </div>";
				html += "</li>";
			} else {
				html += "<tr>";
				html += "   <td><input type='checkbox' class='check_fileDel' id='file"+totalFileCnt+"'></td>";
				html += "   <td><div class='file_tit'>";
				html += "      <label for='file"+totalFileCnt+"'>" + f.name + "</label>";
				html += "   </div></td>";
				html += "   <td>" + convertFileSize(f.size) + "</td>";
				html += "</tr>";
			}

			if (uploadType === "image" || uploadType === "byteImage") {
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
		const fileSn = $(this).siblings("[name='fileSn']").val();
		if (typeof(fileSn) === "undefined" || fileSn == null || fileSn === "") {
			// 새로 추가한 파일이면 atchFileArr에서 제거
			atchFileArr.splice(delRowIdx - atchedFileCnt, 1);
		} else {
			// 기존 첨부파일이면 deleteFileArr에 담기
			const param = {
				"atchFileId" : atchFileIdTemp
				, "fileSn" : fileSn
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
			fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "	<span>이미지 업로드 최대 " + maxFileCnt + "개 가능</span>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if (uploadType === "byteImage") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
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
		const fileSn = $(this).siblings("[name='fileSn']").val();
		if (typeof(fileSn) === "undefined" || fileSn == null || fileSn === "") {
			// 새로 추가한 파일이면 atchFileArr에서 제거
			atchFileArr.splice(delRowIdx-atchedFileCnt-1, 1);
		} else {
			// 기존 첨부파일이면 deleteFileArr에 담기
			const param = {
				"atchFileId" : atchFileIdTemp
				, "fileSn" : fileSn
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
			fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
			fileHTML += "	<div class='file_btns_box r'>";
			fileHTML += "	<span>이미지 업로드 최대 " + maxFileCnt + "개 가능</span>";
			fileHTML += "		<span class='fake_file'>";
			fileHTML += "			<span class='btn fake_btn btn_file' onclick='btnAddFile(this)'></span>";
			fileHTML += "			<span class='btn btn_file_del' style='display:none' onclick='delImageFile(this)'></span>";
			fileHTML += "		</span>";
			fileHTML += "	</div>";
			fileHTML += "</li>";
		} else if (uploadType === "byteImage") {
			fileHTML += "<li>";
			fileHTML += "	<div class='file_img'><img src='/internal/standard/common/images/no_img.png' width='100%' alt='이미지'></div>";
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
			// FileVO.atchFileId 세팅
			formData.append("atchFileId", atchFileIdTemp);
			
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
		
			return $.ajax({
				type : "POST"
				, url : "/file/" + procType + "Proc.do"
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
				, error : function (xhr, status, error) {
					
					// 로그인 세션 없는 경우
					if (xhr.status == 401) {
				  		window.location.reload();
					}
					
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

function fileDown(fileId, fileSn, fileRlnm,filePhclNm){
	$("#downAtchFileId").val(fileId);
	$("#downAtchSn").val(fileSn);
	$("#downAtchRlNm").val(fileRlnm);
	$("#downAtchPhclNm").val(filePhclNm);
	$("#fileDownFrm").attr({
		action : "/file/down.do",
		method : "post",
		target : "fileDownFrm",
		onsubmit : ""
	}).submit();
}

function fileByteDown(fileId, fileSn, fileRlnm,filePhclNm){
	$("#downAtchFileId").val(fileId);
	$("#downAtchSn").val(fileSn);
	$("#downAtchRlNm").val(fileRlnm);
	$("#downAtchPhclNm").val(filePhclNm);
	$("#fileDownFrm").attr({
		action : "/file/downloadByte.do",
		method : "post",
		target : "_self",
		onsubmit : ""
	}).submit();
}


function fileImg(fileFextNm, fileNm){
	let fileHTML = "";
	if(fileFextNm === "xlsx" || fileFextNm === "xls"){
		fileHTML = "<img src='/internal/standard/common/images/icon/file_excel.svg'>" + fileNm
	} else if(fileFextNm === "pptx" || fileFextNm === "ppt"){
		fileHTML = "<img src='/internal/standard/common/images/icon/file_ppt.svg'>" + fileNm
	} else if(fileFextNm === "docx" || fileFextNm === "doc"){
		fileHTML = "<img src='/internal/standard/common/images/icon/file_word.svg'>" + fileNm
	} else if(fileFextNm === "hwp"){
		fileHTML = "<img src='/internal/standard/common/images/icon/file_hwp.svg'>" + fileNm
	} else if(fileFextNm === "pdf"){
		fileHTML = "<img src='/internal/standard/common/images/icon/file_pdf.svg'>" + fileNm
	} else if(fileFextNm === "zip" || fileFextNm === "7zip" || fileFextNm === "egg"){
		fileHTML = "<img src='/internal/standard/common/images/icon/file_zip.svg'>" + fileNm
	} else if(fileFextNm === "jpg" || fileFextNm === "jpeg" || fileFextNm === "png" || fileFextNm === "gif" || fileFextNm === "bmp" || fileFextNm === "tif" || fileFextNm === "tiff"){
		fileHTML = "<img src='/internal/standard/common/images/icon/file_img.svg'>" + fileNm
	} else {
		fileHTML = fileNm
	}
	return fileHTML;
}

function atchFileCapture(fileId, divId, fileGetNme) {

	// 첨부파일 ID
	var fileoriJinalId = fileId.replace('FileId','');
	var totalFileCnt = $("#"+fileoriJinalId+"FileUpload").children('.file_wrap').children('.totalFileCnt').val();
	var maxFileTempCnt = $("#"+fileoriJinalId+"FileUpload").children('.file_wrap').children('.maxFileCnt').val();
	var atchFileIdNm = $("#"+fileoriJinalId+"FileUpload").children('.file_wrap').children('.atchFileIdNm').val(); 
	
	// 유효성 검사
	if (totalFileCnt >= maxFileTempCnt) {
		alert("파일은 최대 " + maxFileTempCnt +"개까지 첨부가능합니다.");
		// 초기화
		atchFileTemp.val("");
		return false;
	}

	// 캡쳐동작
	html2canvas($("#"+divId)[0]).then(function(canvas){
		
		var base_data = canvas.toDataURL();

		const date = new Date();

		var time = date.getFullYear()
				+ '' + (Number(date.getMonth()) + Number(1))
				+ '' + date.getDate()
				+ '' + date.getHours()
				+ '' + date.getMinutes()
				+ '' + date.getSeconds()
				+ '' + date.getMilliseconds();
		
		var filename = "";
		
		if(fileGetNme != '' && fileGetNme != null) {
			filename = fileGetNme+".png";
		} else {
			filename = "C_" + time  + ".png";
		}

		
		// 첨부파일 세팅
		
		var arr = base_data.split(','),
	        mime = arr[0].match(/:(.*?);/)[1],
	        bstr = atob(arr[1]),
	        n = bstr.length,
	        u8arr = new Uint8Array(n);
	
	    while(n--){
	        u8arr[n] = bstr.charCodeAt(n);
	    }
	
	    var file = new File([u8arr], filename, {type:mime});
	
		var html = "";
		    html += "<li>";
			html += "	<div class='file_img'><img src='" + base_data + "' width='100%' onerror='/internal/standard/common/images/no_img.png' alt='이미지'></div>";
			html += "	<div class='file_btns_box r'>";
			html += "		<label style='display:none'>";
			html += "			<input type='checkbox' class='check_fileDel'>";
			html += "		</label>";
			html += "		<span class='file_name'>" + filename + "</span>";
			html += "		<span class='fake_file'>";
			html += "			<span class='btn fake_btn btn_file' style='display:none' onclick='btnAddFile(this)'></span>";
			html += "			<span class='btn btn_file_del' onclick='delImageFile(this)'></span>";
			html += "		</span>";
			html += "	</div>";
			html += "</li>";
	
		$("#"+fileoriJinalId+"FileUpload").children('.file_wrap').children('.atchFileTbody').append(html);
	
		var fileChgYn = $("#"+fileoriJinalId+"FileUpload").find(".fileChgYn");
		fileChgYn.val("Y");
		    
		window["atchFileArr_"+fileId].push(file);
		
		$("#"+fileId).attr("data-totalcnt", window["atchFileArr_"+fileId].length);
	
	
		totalFileCnt = $("#"+fileoriJinalId+"FileUpload").children('.file_wrap').children('.totalFileCnt').val();
		$("#"+fileoriJinalId+"FileUpload").children('.file_wrap').children('.totalFileCnt').val(++totalFileCnt);
		$('#'+fileId).attr('data-totalcnt',totalFileCnt)
		
		/*if(Number(totalFileCnt) >= Number(maxFileTempCnt)) {
			console.log(atchFileIdNm +'_ImgInsert');
			$('#'+atchFileIdNm +'_ImgInsert').hide();
		}*/
		
	 });
}


// 화면 캡쳐 다운로드 - 2022.09.29 구연호 추가
// divId  : html 영역 
// fileGetNme : 저장할 이름 - 없어도 됩니다.
function atchFileCaptureDownload(divId, fileGetNme){

	// 캡쳐동작
	html2canvas($("#"+divId)[0]).then(function(canvas){
		
		var base_data = canvas.toDataURL();

		const date = new Date();

		var time = date.getFullYear()
				+ '' + (Number(date.getMonth()) + Number(1))
				+ '' + date.getDate()
				+ '' + date.getHours()
				+ '' + date.getMinutes()
				+ '' + date.getSeconds()
				+ '' + date.getMilliseconds();
		
		var filename = "";
		
		if(fileGetNme != '' && fileGetNme != null) {
			filename = fileGetNme+".png";
		} else {
			filename = "C_" + time  + ".png";
		}
		
		// 캡처 다운로드
		var link = document.createElement("a")
		link.id = 'capture_target';
	    link.download = filename;
	    link.href = base_data;
	    document.body.appendChild(link);
	    link.click();
		$('#capture_target').remove();
	 });
} 

// 이미지 크게보기
// 2022.09.29 구연호 추가
function atchFileImageView(obj){
	
	var src = $(obj).prev().children('.image').attr('src');
	var imageNm = $(obj).attr('data-imageNm');
	console.log(src);
	
	$("#pop_title").html(imageNm);
	var	imgHtml = "<div class='img_wrap'><img src='" + src + "' style='max-height:800px; max-width:100%; margin:0 auto; display:block;'/></div>";
	$(".pop_content").html(imgHtml);
	view_show('image');
}

