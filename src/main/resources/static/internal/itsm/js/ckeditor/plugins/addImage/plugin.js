CKEDITOR.plugins.add('addImage', {
    icons: 'addImage',
    init: function (editor) {
        // 이미지 파일을 저장할 배열
        var selectedImages = [];
        var imageCounter = 1; // 이미지 번호 카운터

        editor.addCommand('cmd-addImage', {
            exec: function (editor) {
                CKEDITOR.dialog.add('imageDialog', function (editor) {
                    return {
                        title: '이미지 첨부',
                        minWidth: 400,
                        minHeight: 200,
                        contents: [{
                            id: 'tab-basic',
                            label: '기본 설정',
                            elements: [{
                                type: 'file',
                                id: 'fileInput',
                                label: '이미지 선택 (최대 10개)',
                                style: 'height:20px;',
                                size: 38,
                                onChange: function () {
                                    var fileList = document.getElementById('fileList');
                                    var fileInputs = this.getInputElement().$.files;

                                    for (var i = 0; i < fileInputs.length; i++) {
                                        var file = fileInputs[i];

                                        // 이미지 확장자 확인
                                        if (!isValidImageFile(file)) {
                                            alert('이미지 파일이 아닙니다: ' + file.name);
                                            continue;
                                        }

                                        // 이미지 파일 중복 체크
                                        var isDuplicate = selectedImages.some(function(existingFile) {
                                            return existingFile.name.toLowerCase() === file.name.toLowerCase();
                                        });

                                        if (isDuplicate) {
                                            alert('이미 첨부된 파일입니다');
                                            continue;
                                        }

                                        // 이미지를 배열에 추가
                                        if (selectedImages.length < 10) {
                                            selectedImages.push(file);
                                            var listItem = document.createElement('div');
                                            listItem.innerHTML = '<span>' + imageCounter + '. ' + file.name + '</span><button class="btn sml removeBtn" onclick="removeImage(' + (selectedImages.length - 1) + ')"><i class="xi-close-min"></i></button>';
                                            fileList.appendChild(listItem);
                                            imageCounter++;
                                        } else {
                                            alert('최대 10개의 이미지만 선택 가능합니다.');
                                            this.reset();
                                            break;
                                        }
                                    }
                                },
                                validate: function () {
                                    var fileInput = this.getInputElement().$.files;

                                    // 이미지 개수 제한 10개
                                    if (fileInput.length + selectedImages.length > 10) {
                                        alert('최대 10개의 이미지만 선택 가능합니다.');
                                        return false;
                                    }

                                    return true;
                                }
                            },
                            {
                                type: 'html',
                                html: '<div id="fileList" style="padding-top:15px!important;"></div>'
                            }]
                        }],
                        buttons: [
                            CKEDITOR.dialog.cancelButton,
                            CKEDITOR.dialog.okButton
                        ],
                        onCancel: function () {
                            // 이미지 리스트 초기화
                            var fileList = document.getElementById('fileList');
                            fileList.innerHTML = '';
                            // 선택된 이미지 배열 초기화
                            selectedImages = [];
                            // 이미지 카운터 초기화
                            imageCounter = 1;
                        },
                        onOk: function () {
                            // FormData 객체 생성
                            var formData = new FormData();

                            for (var i = 0; i < selectedImages.length; i++) {
                                // 각 파일을 FormData에 추가
                                formData.append('files[]', selectedImages[i]);
                            }

                            $.ajax({
                                method: "POST",
                                url: '/file/tmplProc.do',
                                data: formData,
                                processData: false,
                                contentType: false,
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    // 서버로부터 받은 데이터를 처리
                                    if (data.fileList != null || data.fileList != '') {
                                        for (var i = 0; i < data.fileList.length; i++) {
                                            // 에디터에 이미지 추가
                                            editor.insertHtml('<img src="/file/getImage.do?atchFileId=' + data.fileList[i].atchFileId + '&fileSeqo=' + i + '&fileNmPhclFileNm=' + data.fileList[i].fileNmPhclFileNm + '" alt="Image">');
                                        }
                                        alert('등록되었습니다.');
                                    } else {
                                        alert('오류');
                                    }
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    console.error('Upload error:', jqXHR, textStatus, errorThrown);
                                }
                            });

                            // 이미지 리스트 초기화
                            var fileList = document.getElementById('fileList');
                            fileList.innerHTML = '';
                            // 선택된 이미지 배열 초기화
                            selectedImages = [];
                            // 이미지 카운터 초기화
                            imageCounter = 1;
                        },
                    };
                });

                window.removeImage = function (index) {
                    // 선택된 이미지 배열에서 제거
                    selectedImages.splice(index, 1);
                    // 이미지 리스트 갱신
                    var fileList = document.getElementById('fileList');
                    fileList.innerHTML = '';
                    for (var i = 0; i < selectedImages.length; i++) {
                        var fileName = selectedImages[i].name;
                        var listItem = document.createElement('div');
                        listItem.innerHTML = '<span>' + (i + 1) + '. ' + fileName + '</span><button class="btn sml removeBtn" onclick="removeImage(' + i + ')"><i class="xi-close-min"></i></button>';
                        fileList.appendChild(listItem);
                    }
                    // 이미지 카운터 초기화
                    imageCounter = selectedImages.length + 1;
                };

                editor.openDialog('imageDialog');

                var elements = document.getElementsByClassName('cke_editor_editrCont_dialog');
                elements[0].classList.add('ck_img_pop');
            }
        });

        editor.ui.addButton('addImage', {
            label: '이미지 첨부',
            command: 'cmd-addImage',
            toolbar: 'custom'
        });

        // 이미지 파일의 확장자가 jpg, jpeg, png, gif 중 하나인지 확인
        function isValidImageFile(file) {
            var validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
            var fileName = file.name.toLowerCase();
            var fileExtension = fileName.split('.').pop();

            return validExtensions.includes(fileExtension);
        }
    }
});
