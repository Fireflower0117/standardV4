
const fileFns = {
    fileExecAllowed : function(fileEle, fileDiv) {
        var isFileAble = true;
        if (fileDiv.toUpperCase() == "IMAGE") {
            var ableImgMimeTypeArr = ["gif", "jpg", "jpeg", "tiff", "png"];
            var mimeType = fileFns.getFileMimeType(fileEle);
            isFileAble = $.inArray(mimeType, ableImgMimeTypeArr) == -1 ? false : true;
        }

        return isFileAble;
    },
    getFileMimeType : function(eleSelector) {
        var fileVal = $(eleSelector).val();
        var lastIndxDot = fileVal.lastIndexOf(".");
        return fileVal.substring(lastIndxDot + 1);
    },

    getFileInfo : function(fileSelector) {
        var trnObj = {}
        if (htmlFns.getEleType(fileSelector) == "file") {

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
    },
    //  파일다운로드 공통
    commFileDownLoad : function(fileInfoObj) {
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
    },
    //  파일삭제 공통
    commFileDelete : function(pFileGrpSeq, pFileSeq) {
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
    },
    formatBytes : function(bytes, decimals = 2) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    }
}

export default fileFns;