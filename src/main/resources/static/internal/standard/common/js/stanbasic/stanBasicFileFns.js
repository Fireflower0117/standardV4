(function(window) {
const fileFns = {
    // 파일 입력가능 확장자 제어
    fileExecAllowed : function(fileEle, fileDiv) {
        var isFileAble = true;
        if (fileDiv.toUpperCase() === "IMAGE") {
            var ableImgMimeTypeArr = ["gif", "jpg", "jpeg", "tiff", "png"];
            var mimeType = fileFns.getFileMimeType(fileEle);
            isFileAble = $.inArray(mimeType, ableImgMimeTypeArr) == -1 ? false : true;
        }

        return isFileAble;
    }
    // 파일 확장자 조회
    , getFileMimeType : function(eleSelector) {
        var fileVal = $(eleSelector).val();
        var lastIndxDot = fileVal.lastIndexOf(".");
        return fileVal.substring(lastIndxDot + 1);
    }
    //  파일정보조회
    ,getFileInfo : function(fileSelector) {
        var trnObj = {}
        if (htmlFns.getEleType(fileSelector) === "file") {

            var eleFiles = $(fileSelector).prop("files");
            if (eleFiles.length > 0) {
                trnObj.fullFileName = eleFiles[0].name;
                trnObj.fileName = ("" + eleFiles[0].name).substr(0, ("" + eleFiles[0].name).indexOf("."));
                trnObj.fileExt = fileFns.getFileMimeType(fileSelector);
                trnObj.fileType = eleFiles[0].type;
                trnObj.fileSize = eleFiles[0].size;
            }
        }
        return trnObj;
    }

    //  파일다운로드 공통
    , commFileDownLoad : function(fileInfoObj) {
        if (validateFns.isEmpty(fileInfoObj.conditions)) return false;
        fileInfoObj.url = validateFns.isEmpty(fileInfoObj.url) ? '/com/files/opntDownload.ajx' : fileInfoObj.url;
        var excelCondition = {
            httpMethod: "post"
            , data: fileInfoObj.conditions
            , prepareCallback: function (url) {
                console.log(JSON.stringify(fileInfoObj.conditions) + " 다운로드 시작");
            }
        };

        $.fileDownload(fileInfoObj.url, excelCondition);
    }
     //  파일삭제 공통
    ,commFileDelete : function(pFileGrpSeq, pFileSeq) {
        xhrFns.ajax({
            sid: "deletComFile",
            cmd: "update",
            sql: "common.opnt.file.delCommonFile",
            fileGrpSeq: pFileGrpSeq,
            fileSeq: pFileSeq ,
            successFn: function (sid, rs) {
                messageFns.showMsg("삭제 했습니다. ");
            }
        });
    }
    // 파일 용량 Pretty
    ,formatBytes : function(bytes, decimals = 2) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    }
    // 파일 업로드 영역 Display
    ,setFileList( fIleAreaInfo ){
        if(on.valid.isEmpty(fIleAreaInfo?.displayTarget)){
            return ;
        }

        let displayTarget = fIleAreaInfo.displayTarget;
        let atchFileId    = on.str.nvl(fIleAreaInfo.atchFileId, "");
        let atchFileIdNm  = on.str.nvl(fIleAreaInfo.atchFileIdNm,"atchFileId"); //  미입력(아마도.. 1개영역??) FileGroupId="atchFileId"
        let uploadType    = on.str.nvl(fIleAreaInfo.uploadType,"upload");  // 파일 입력Form 기본타입 (upload)
        let maxFileCnt    = on.str.nvl(fIleAreaInfo.maxFileCnt, 10);  // 미입력시 기본 첨부파일10개 기본
        let maxFileSize   = on.str.nvl(fIleAreaInfo.maxFileSize, 50); // 미입력시 기본 트랜잭션당 최대 50Mb

        //  임시칼럼(구분값) 파라미터 받기 (없으면 빈값)
        let tempfilecol1  = on.str.nvl(fIleAreaInfo.tempfilecol1, "");
        let tempfilecol2  = on.str.nvl(fIleAreaInfo.tempfilecol2, "");
        let tempfilecol3  = on.str.nvl(fIleAreaInfo.tempfilecol3, "");
        let tempfilecol4  = on.str.nvl(fIleAreaInfo.tempfilecol4, "");
        let tempfilecol5  = on.str.nvl(fIleAreaInfo.tempfilecol5, "");

        // 확장자 제한 파라미터 처리 (기본: 워드, 한글, 엑셀, 이미지, PDF)
        let defaultMimeType = ["doc", "docx", "hwp", "xls", "xlsx", "pdf", "jpg", "jpeg", "png", "gif", "bmp"];
        let mimetypeArr = Array.isArray(fIleAreaInfo.mimetype) && fIleAreaInfo.mimetype.length > 0
            ? fIleAreaInfo.mimetype // 사용자 정의 파일형대 제약걸기
            : defaultMimeType;

        //  OS 파일 탐색기 필터링용 accept 속성 문자열 조립 (".doc,.docx,.pdf" 형태)
        let acceptStr = mimetypeArr.map(ext => ext.startsWith('.') || ext.includes('/') ? ext : '.' + ext).join(',');

        //  파일영역입력 영역 노출할 확장자 안내 텍스트 조립
        let extGuideText = "  /  허용 파일종류: " + mimetypeArr.join(' ,  ').toLowerCase();

        // 배열 생성
        window["atchFileArr_" + atchFileIdNm] = [];
        window["deleteFileArr_" + atchFileIdNm] = [];

        let totalFileCnt = 0;
        let atchedFileCnt = 0;

        let fileHTML  = "<div class='file_wrap'>"
            fileHTML += "	<input type='hidden' name='atchFileIdTemp' value='" + atchFileId + "' class='atchFileIdTemp'>";
            fileHTML += "	<input type='hidden' name='atchFileIdNm' value='" + atchFileIdNm + "' class='atchFileIdNm'>";
            fileHTML += "	<input type='hidden' name='atchFileId' value='" + atchFileId + "' class='atchFileId'>";
            fileHTML += "	<input type='hidden' name='uploadType' value='" + uploadType + "' class='uploadType'>";
            fileHTML += "	<input type='hidden' name='maxFileCnt' value='" + maxFileCnt + "' class='maxFileCnt'>";
            fileHTML += "	<input type='hidden' name='fileChgYn' value='N' class='fileChgYn'>";
            fileHTML += "   <input type='hidden' name='tempfilecol1' value='" + tempfilecol1 + "' class='tempfilecol1'>";
            fileHTML += "   <input type='hidden' name='tempfilecol2' value='" + tempfilecol2 + "' class='tempfilecol2'>";
            fileHTML += "   <input type='hidden' name='tempfilecol3' value='" + tempfilecol3 + "' class='tempfilecol3'>";
            fileHTML += "   <input type='hidden' name='tempfilecol4' value='" + tempfilecol4 + "' class='tempfilecol4'>";
            fileHTML += "   <input type='hidden' name='tempfilecol5' value='" + tempfilecol5 + "' class='tempfilecol5'>";
            fileHTML += "   <input type='hidden' name='allowedExt' value='" + mimetypeArr.join(',').toLowerCase() + "' class='allowedExt'>";
        if (uploadType === "image") {
            fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' accept='" + acceptStr + "' style='display:none;' multiple onchange='addFiles(this)'>";
            fileHTML += "	<ul class='file_thum atchFileTbody'>";
        } else if (uploadType === "imageView") {
            fileHTML += "    <div class='file_wrap'>";
            fileHTML += "        <ul class='file_thum atchFileTbody'>";
        } else if (uploadType === "byteImage") {
            fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' accept='" + acceptStr + "' style='display:none;' multiple onchange='addFiles(this)'>";

            fileHTML += "	<ul class='file_thum atchFileTbody'>";
        } else if (uploadType === "byteImageView") {
            fileHTML += "    <div class='file_wrap'>";
            fileHTML += "        <ul class='file_thum atchFileTbody'>";
        } else if (uploadType === "view") {
            fileHTML += "	<ul class='file_li'> ";
        } else if (uploadType === "byteView") {
            fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' accept='" + acceptStr + "' style='display:none;' multiple onchange='addFiles(this)'>";
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
            fileHTML += "	<input type='file' name='excelFileTemp' id='excelFileTemp' accept='" + acceptStr + "' class='atchFileTemp' style='display:none;' onchange='addFiles(this)'>";
            fileHTML += "	<input type='text' name='excelFileInfo' id='excelFileInfo' style='width: 300px;' readonly='readonly' placeholder='엑셀파일 업로드'>";
            fileHTML += " 	<button type='button' class='btn bd blue' onclick='btnAddFile(this)'><span class='fa_check'>파일선택</span></button>";
        } else if(uploadType === "upload") {
            fileHTML += "	<input type='file' name='atchFileTemp' class='atchFileTemp' accept='" + acceptStr + "' style='display:none;' multiple onchange='addFiles(this)'>";
            fileHTML += " 	<button type='button' class='btn bd blue btn_fil' onclick='btnAddFile(this)'><span class='fa_check'>파일선택</span></button>";
            fileHTML += " 	<button type='button' class='btn bd red btn_fileDel' onclick='delFile(this)'><span class='fa_remove'>파일삭제</span></button>";
            fileHTML += "   <span>파일은 최대 " + maxFileCnt + "개까지 첨부 가능합니다. (개별 용량 " + maxFileSize + "MB<span class='ext_guide'>" + extGuideText + "</span>)</span>";
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

        // atchFileId (File Group Id)
        if (!on.valid.isEmpty(atchFileId)) {
            on.xhr.ajax({
                  methodType : "POST"
                , url : "/file/getList.do"
                , atchFileId
                , dataType : "json"
                , async : false
                , successFn : function (atchFileList) {
                      if (!on.valid.isEmpty(atchFileList) ) {
                        totalFileCnt = atchFileList.length;
                        atchedFileCnt = atchFileList.length;

                        /** @namespace atchFileList.fileRlNm **/
                        /** @namespace atchFileList.fileSizeVal **/
                        for (let i = 0; i < atchFileList.length; i++) {
                            if (uploadType === "image") {
                                if(i === 0){
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
                                if(i === 0){
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
            });
            // $("#"+atchFileIdNm).attr("data-totalCnt",totalFileCnt);
            $("[name='" + atchFileIdNm + "']").attr("data-totalCnt", totalFileCnt);
        }
        else {
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

        $(displayTarget).html(fileHTML);
    }
    , changeMimeType : function(options) {
        if (!options || on.valid.isEmpty(options.displayTarget)) return;

        var displayTarget  = options.displayTarget;
        var newMimetypes   = options.newMimetypes;
        var newMaxFileCnt  = options.newMaxFileCnt;
        var newMaxFileSize = options.newMaxFileSize;

        var $target = $(displayTarget);
        var atchFileIdNm = $target.find('.atchFileIdNm').val();

        // 기존 첨부파일 모두 날리기 (강제 초기화)
        if (atchFileIdNm) {
            $target.find('.atchFileTbody input[name="fileSn"]').each(function() {
                window["deleteFileArr_" + atchFileIdNm] = window["deleteFileArr_" + atchFileIdNm] || [];
                window["deleteFileArr_" + atchFileIdNm].push($(this).val());
            });

            // 클라이언트 메모리에 대기 중인 새 파일 배열 강제 비우기
            window["atchFileArr_" + atchFileIdNm] = [];

            // UI 비우기 및 '파일 없음' 상태로 되돌리기
            var $tbody = $target.find('.atchFileTbody');
            $tbody.empty();
            var colSpan = $target.find('thead th').length || 3;
            $tbody.append("<tr><td colSpan='" + colSpan + "' class='no_data'>첨부파일이 없습니다.</td></tr>");

            // 파일 갯수 카운트 초기화 및 변경 상태 강제 업데이트
            $target.find('.totalFileCnt').val(0);
            $target.find('.atchedFileCnt').val(0);
            $target.find('.atchFileTemp').val('');
            $target.find('.fileChgYn').val('Y');
        }

        // 확장자 동적 변경 (파라미터가 배열로 정상적으로 들어왔을 때만)
        if (newMimetypes && Array.isArray(newMimetypes)) {
            var acceptStr = newMimetypes.map(function(ext) {
                return ext.startsWith('.') || ext.includes('/') ? ext : '.' + ext;
            }).join(',');
            var allowedExtStr = newMimetypes.join(',').toLowerCase();
            var extGuideText  = "  /  허용 파일종류: " + allowedExtStr;

            $target.find('.atchFileTemp').attr('accept', acceptStr);
            $target.find('.allowedExt').val(allowedExtStr);
            $target.find('.ext_guide').text(extGuideText);
        }

        // 첨부파일 갯수 변경 (값이 존재할 때만)
        if (newMaxFileCnt !== undefined && newMaxFileCnt !== null) {
            $target.find('.maxFileCnt').val(newMaxFileCnt);
            $target.find('.txt_max_cnt').text(newMaxFileCnt);
        }

        // 첨부파일 개별 용량 변경 (값이 존재할 때만)
        if (newMaxFileSize !== undefined && newMaxFileSize !== null) {
            $target.find('.maxFileSize').val(newMaxFileSize);
            $target.find('.txt_max_size').text(newMaxFileSize);
        }
    }

    , fileFormSubmit : function (options) {
        let targetFormIdArr = options.formIdArr;
        let procType = options.procType;
        let successFn = options.successFn;
        let delOpt = on.str.nvl(options.del, "Y"); // 삭제 옵션 기본값 Y

        //  배열 강제화 및 방어 로직 (개발자 가이드)
        if (!Array.isArray(targetFormIdArr) || targetFormIdArr.length === 0) {
            on.msg.showMsg({message : "formId는 반드시 배열 형태(예: ['#form1','.form2' ])로 입력해야 합니다."});
            return false;
        }
        if (on.valid.isEmpty(procType)) {
            on.msg.showMsg({message : "처리 구분값(procType)이 없습니다."});
            return false;
        }

        // 분기문 없이 바로 배열 map 함수로 선택자(Selector) 조립!
        let selector = targetFormIdArr.map(id =>  id + " input[name='atchFileIdNm']").join(", ");

        // 해당 폼 내부에 있는 파일 영역만 타겟팅
        const atchFileArea = $(selector);
        let errorYn = "N";

        let rtnObj = {}; // 첨부파일 그룹정보 (return 대상 Object)
        atchFileArea.each(function () {
            const fileChgYn = $(this).siblings(".fileChgYn").val();
            const atchFileIdNm = $(this).val(); // ex) "atchFileId"
            const atchFileIdTemp = $(this).siblings(".atchFileIdTemp").val(); // 기존 파일 그룹 ID

            //  파일 변경 여부와 상관없이, 기존 파일 ID를 무조건 리턴 객체에 미리 담아둡니다!
            rtnObj[atchFileIdNm] = atchFileIdTemp;

            // 수정이 일어난 경우만 파일 업로드 수행
            if (fileChgYn === "Y") {
                const formData = new FormData();
                const atchFileIdNm = $(this).val();
                const atchFileIdTemp = $(this).siblings(".atchFileIdTemp").val();

                const tempcol1 = $(this).siblings(".tempcol1").val();
                const tempcol2 = $(this).siblings(".tempcol2").val();
                const tempcol3 = $(this).siblings(".tempcol3").val();
                const tempcol4 = $(this).siblings(".tempcol4").val();
                const tempcol5 = $(this).siblings(".tempcol5").val();

                formData.append("atchFileId", atchFileIdTemp);
                formData.append("tempcol1", tempcol1);
                formData.append("tempcol2", tempcol2);
                formData.append("tempcol3", tempcol3);
                formData.append("tempcol4", tempcol4);
                formData.append("tempcol5", tempcol5);

                const atchFileArr = window["atchFileArr_" + atchFileIdNm] || [];
                const deleteFileArr = window["deleteFileArr_" + atchFileIdNm] || [];

                // 새로 추가한 파일 세팅
                if (atchFileArr.length > 0) {
                    for (let i = 0; i < atchFileArr.length; i++) {
                        formData.append("files", atchFileArr[i]);
                    }
                }
                // 기존 파일 삭제가 있을 경우 JSON String 전송
                if (deleteFileArr.length > 0) {
                    formData.append("deleteFileJsonString", JSON.stringify(deleteFileArr));
                }

                // CSRF 토큰 강제 주입 (보안)
                let csrfToken = $("meta[name='_csrf']").attr("content");
                let csrfHeader = $("meta[name='_csrf_header']").attr("content") || "X-CSRF-TOKEN";

                $.ajax({
                      type: "POST"
                    , url: "/file/" + procType + "Proc.do"
                    , data: formData
                    , async: false // 콜백 순차 실행을 위해 동기식 유지
                    , dataType: "json"
                    , contentType: false
                    , processData: false
                    , enctype: "multipart/form-data"
                    , beforeSend: function (xhr) {
                        if (csrfToken && csrfHeader) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        }
                    }
                    , success: function (data) {
                        if (data.result === "Y") {
                            rtnObj[atchFileIdNm] = data.atchFileId;

                            // 전송 완료된 배열 초기화
                            if (delOpt !== "NO_DEL") {
                                delete window["atchFileArr_" + atchFileIdNm];
                                delete window["deleteFileArr_" + atchFileIdNm];
                            }


                        }
                    }
                    , error: function (xhr, status, error) {
                        errorYn = "Y";
                        if (xhr.status === 401 || xhr.status === 403) {
                            on.msg.showMsg({message : "권한이 없거나 세션이 만료되었습니다."});
                        } else {
                            on.msg.showMsg({message : "파일 업로드 도중 에러가 발생했습니다."});
                        }
                    }
                });
            }
        });

        // 파일 업로드 중 에러가 없었다면 본문(게시물) 저장 콜백 함수 실행
        if (errorYn !== "Y" && typeof successFn === "function") {
            successFn(rtnObj);
        }

        return false;
    }
}

  window.fileFns = fileFns;

})(window);