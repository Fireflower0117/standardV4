<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
    $(document).ready(function(){

/**************************************************************************
         ********************       Page Local Functions        ********************
         ***************************************************************************/
         const fncTmplFileList = function(){
			// com.standard.usersupport.ContentTemplate
			 on.xhr.ajax({ sql : "com.standard.mapper.usersupport.contTmplMngMapper.selectContTmplFileList"
			           , methodType : "post"
			           , tmplFileSerno : '${param.tmplFileSerno}'
			           , successFn : function(rsList){
						      let tempFIleHtml  = "<ul>";
								  tempFIleHtml += "    <li class='tit'>";
								  tempFIleHtml += "	      <label class='chkAll cursor'>";
								  tempFIleHtml += "	         <input type='checkbox' class='cursor mar_r10'><span>전체선택</span>";
								  tempFIleHtml += "	      </label>";
								  tempFIleHtml += "    </li>";
								  $.each(rsList , function(indx , rs){
									tempFIleHtml += "	<li>";
									tempFIleHtml += "	  <label class='chkList cursor'>";
									tempFIleHtml += "	    <input type='checkbox' class='cursor mar_r10' data-filesn='"+rs.fileSn+"'>";
									tempFIleHtml += "	    <p>"+rs.rlFileNm+"&nbsp;&nbsp;&nbsp;("+rs.fileSzVal+" MB)&nbsp;&nbsp;&nbsp;["+rs.regDt+"]</p>";
									tempFIleHtml += "	  </label>";
									tempFIleHtml += "	  <span class='click_clipboard cursor' data-link='/tmplFile/getFileDown.do?tmplFileSerno="+rs.tmplFileSerno+"&fileSn='"+rs.fileSn+"'>";
									tempFIleHtml += "	  <i class='xi-link-insert'></i>";
									tempFIleHtml += "	  </span>";
									tempFIleHtml += "	</li>";
								  });
								  tempFIleHtml += "</ul>";
						         $("#div_tmplFiles").html(tempFIleHtml);
					   }
			 });
         }


        <%-- 등록시 템플릿파일 먼저 등록해 미리보기 이미지 생성 --%>
        const fncSubmitTmpl = function(){
            if(CKEDITOR.instances.editrCont.getData() && CKEDITOR.instances.editrCont.getData().length){
                var target = $("#td_editor").find("iframe").contents().find(".cke_editable")[0];
                if(target == null || typeof target == "undefined"){
                    alertMsg("editrCont", "red", "에디터 소스 모드를 종료해주세요.");
                    return false;
                }
                html2canvas(target).then(function(canvas) {
                    var imgDataUrl = canvas.toDataURL("image/png");

                    var blobBin = atob(imgDataUrl.split(',')[1]);	// base64 데이터 디코딩
                    var array = [];
                    for (var i = 0; i < blobBin.length; i++) {
                        array.push(blobBin.charCodeAt(i));
                    }
                    var file = new Blob([new Uint8Array(array)], {type: "image/png"});	// Blob 생성

                    const formData = new FormData();
                    formData.append("files", file);	// file data 추가

                    if($("#prvwFileSerno").val()){
                        formData.append("tmplFileSerno", $("#prvwFileSerno").val());
                    }
                    formData.append("divn", "preview");

                    $.ajax({
                        method : "POST",
                        url : "uploadTmplFile",
                        data : formData,
                        dataType : "JSON",
                        contentType : false,
                        processData : false,
                        enctype : "multipart/form-data",
                        success : function (data){
                            $("#prvwFileSerno").val(data.tmplFileSerno);
                        },error : function(xhr, status, error){
                            if (xhr.status == 401) {
                                window.location.reload();
                            }
                            alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
                        },
                        beforeSend : function(){
                            fncLoadingStart();
                        },
                        complete : function(){
                            <%-- ckEditor 데이터 editrCont에 담아주기 --%>
                            $("#editrCont").val(CKEDITOR.instances.editrCont.getData());
                            <%-- 등록 / 수정 --%>
                            fncProc('<c:out value="${searchVO.procType}"/>');
                            fncLoadingEnd();
                        }
                    });
                });
            }
        }

        <%-- 선택된 파일 삭제--%>
        const fncDelTmplFile = function(){

            var delFileList = [];
            var $targetChk = $(".chkList input[type='checkbox']:checked");

            if(!$targetChk.length){
                alert("선택된 파일이 없습니다.");
                return false;
            }else{
                if(!confirm("파일을 삭제하시겠습니까?")){
                    return false;
                }
            }

            $targetChk.each(function(){
                delFileList.push($(this).attr("data-filesn"));
            });

            $.ajax({
                method : "POST",
                url : "delTmplFile",
                data : {tmplFileSerno : $("#tmplFileSerno").val(), tempArr : delFileList.toString()},
                dataType : "JSON",
                success : function (data){
                    alert(data.message);
                },error : function(xhr, status, error){
                    if (xhr.status == 401) {
                        window.location.reload();
                    }
                    alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
                },
                beforeSend : function(){
                    fncLoadingStart();
                },
                complete : function(){
                    fncLoadingEnd();
                }
            }).done(function(data){
                if(data.result == "success"){
                    fncTmplFileList();
                }
            });
        }

        const fncCopyToClip = function(obj) {

            var copyText = $(obj).data("link");
            $("#btn_copy").attr("data-clipboard-text", copyText);
            $("#btn_copy").trigger("click");
            $("#btn_copy").attr("data-clipboard-text", "");
        }


        const fncCopyToClipSet = function(target){

            var clipboard = new ClipboardJS(target);

            clipboard.on('success', function(e) {
                alert(e.text+"\n복사되었습니다.");
                e.clearSelection();
            });

            clipboard.on('error', function(e) {
                alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
            });
        }
         /**************************************************************************
         ***********************        페이지 세팅            ***********************
         ***************************************************************************/

         // 공통코드 / 기타데이터 일괄조회(공통코드 일괄조회)
         let inqPageDataList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "rsTmcl"    , sqlCondi : { uppComCd : "TMCL"   } }  // 템플릿 구분 리스트
                                                                   , {rsId : "rsTmpTmcl" , sqlCondi : { uppComCd : "${param.tmplCl}" } }  // 통합, 개별 템플릿
                                                       ]
                              });

          //통합 템플릿 유형 (개별생성)
        on.html.dynaGenSelectOptions({ targetInfo     : { targetId : "#selTmplCl" }
                                      , optionValInfo : { optId : "comCd" , optTxt : "cdNm", defaultVal : "${param.tmplCl}" }
                                      , dataInfo      : inqPageDataList.rsTmcl
                                     });

        // 개별 템플릿 (개별생성)
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#selTmplTp" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm", defaultVal : "${param.schEtc01}" }
                                     , dataInfo      : inqPageDataList.rsTmpTmcl
                                    });

		// 앨리먼트 일괄생성
		/* on.html.dynaBatchGenConditions([ {  comboInfo     : { type: "select" , targetId : "#selTmplCl" }
										  , optionValInfo : { optId : "comCd" , optTxt : "cdNm", defaultVal : "${param.tmplCl}" }
										  , comboDataInfo : inqPageDataList.rsTmpTmcl
										 }
									   , { comboInfo     : {  type: "radio" , targetId : "#selTmplTp" }
										 , optionValInfo : { optId : "comCd" , optTxt : "cdNm", defaultVal : "${param.schEtc01}" }
										 , comboDataInfo : inqPageDataList.rsTmpTmcl
										 }
									  ]); */

        <%-- CKeditr 설정--%>
	    CKEDITOR.replace("tmplEditrCont",{height : 400, contentsCss: '<c:out value="${pageContext.request.contextPath}"/>'+'/external/ckeditor/contents.css'});

		<%-- 첨부파일 등록폼 생성 --%>
		on.file.setFileList({
		     displayTarget : "#atchFileUpload"
		   , maxFileCnt    : 5  // 입력가능 최대 파일 갯수
		   , maxFileSize   : 20 // Mb(입력가능 최대용량)
		})


        <%-- 파일업로드 경로 복사 trigger--%>
	    fncCopyToClipSet("#btn_copy");

		/**************************************************************************
        *********************       Component  이벤트         **********************
        ***************************************************************************/

		<%-- 템플릿유형 바뀔때마다 템플릿타입 불러오기--%>
		$('#selTmplCl').on('change', function(){
			on.xhr.ajax({ sql        : "on.standard.system.comcode.selectComCode"
                        , uppComCd   : on.html.getEleVal({ele : "#selTmplCl" })
                        , successFn  : function ( data){
							 on.html.dynaGenSelectOptions({ targetInfo   : { targetId : "#selTmplTp" }
								                         , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
								                         , dataInfo      : data

								 });
                         }
                });
		});

        // CheckBox 전체 선택
		$(".chkAll input[type='checkbox']").on("click", function () {
			var chkAll = $(this).prop("checked");
			var $targetChk = $(".chkList").find("input[type='checkbox']");
			if (chkAll) {
				$targetChk.prop('checked', true);
			} else {
				$targetChk.prop('checked', false);
			}
		});

        // CheckBox 선택
		$(".chkList input[type='checkbox']").on("click", function () {
			var chkCnt = $(".chkList input[type='checkbox']").length;
			var chkCnt_checked = $(".chkList input[type='checkbox']:checked").length;
			if(chkCnt === chkCnt_checked && chkCnt){
				$(".chkAll input[type='checkbox']").prop("checked", true);
			}else{
				$(".chkAll input[type='checkbox']").prop("checked", false);
			}
		});

		/**************************************************************************
        ********************       저장 / 수정 Functions        *********************
        ***************************************************************************/
		  <%--템플릿파일 업로드 --%>
         const fncUploadTmplFile = function(obj){

            let maxFileSize= 10 * 1024 * 1024;
            let targetFiles = $(obj)[0].files;

            let fileChk = true;
            for(let i = 0; i < targetFiles.length; i++){
                if(fileChk && (targetFiles[i].size > maxFileSize)){
					 on.msg.showMsg({message : "최대 10MB까지 첨부가능 합니다." });
                    fileChk = false;
                }
            }

            if(!fileChk){return false;}

            const formData = new FormData();
            if($("#tmplFileSerno").val()){
                formData.append("tmplFileSerno", $("#tmplFileSerno").val());
            }
            for(var i =0; i < targetFiles.length; i++){
                formData.append("files", targetFiles[i]);
            }

            $.ajax({
                method : "POST",
                url : "uploadTmplFile",
                data : formData,
                dataType : "JSON",
                contentType : false,
                processData : false,
                enctype : "multipart/form-data",
                error : function(xhr, status, error){
                    if (xhr.status == 401) {
                        window.location.reload();
                    }
                    alert("에러가 발생하였습니다. \n지속적인 에러 발생시 관리자에게 문의해주세요.");
                },
                beforeSend : function(){
                    fncLoadingStart();
                },
                complete : function(){
                    fncLoadingEnd();
                }
            }).done(function(data){
                if(data.result == "fail"){
                    alert(data.failMsg);
                }else{
                    if(data.tmplFileSerno){
                        $("#tmplFileSerno").val(data.tmplFileSerno);
                        fncTmplFileList();
                    }
                }
            });
         }

		 // 유효성 검증 대상 속성
		let contentTmplValidateList   = [ {name : "selTmplCl"        , label : "템플릿 유형"  ,  rule: {"required":true} }
										, {name : "selTmplTp"        , label : "템플릿 타입"  ,  rule: {"required":true} }
										, {name : "tmplExpl"         , label : "텔플릿 설명"  ,  rule: {"required":true} }
										, {name : "atchFileUpload"   , label : "템플릿 파일"  ,  rule: {"required":true} }
										, {name : "tmplEditrCont"    , label : "에디터 내용"  ,  rule: {"required":true} }
										];

		// 등록(저장)
		$("#btnTmplSubmit").on("click", (evt) => {
			 // fncPageBoard('write', 'insertForm.do');  on.xhr.ajax

             // 1. 파일 Upload대상 그룹정리
			 let targetFileAreas = [ { action: "insert" , fileGroupId: "templeteGrpId" ,  fileAreaId : "#atchFileUpload", tempcol1 : "testInput1"  }
			                       ]

			 // 2.파일 Upload 수행
			 on.html.uploadFiles({ uploadFiles : targetFileAreas
			                     , sucessFn    : (fileUpRslt) => {

				                         // 3. FileUpload성공시  내용전달
			                     		 on.html.dynaGenHiddenForm({ formDefine : {  action: "/ma/system/auth/view.do", enctype : "multipart/form-data" , method: "post", isSubmit : true }
																   , validation : { formId : "#contentTemplate" , validationList : contentTmplValidateList  }  // 유효성검증 기능 포함
																   , data       : $("#contentTemplate").serializeArray()  // Data입력관련 (validation과 별개의 Data작업진행
																   , atchFileUpload1 :  fileUpRslt .fileGroupId // 파일업로드 그룹 ID
																   , successFn  : function ( data){
																		 on.html.dynaGenHiddenForm({ formDefine : { fid:"systemConfigForm" , action:"/ma/system/basic/form.do" , method : "post" , isSubmit : true  } }); // HiddenForm 생성및 전송
																     }
			                             });
			                     }
			 });
		});

		// 취소
		$("#btnList").on("click", (evt) => {

		});




    });
</script>


<form name="contentTemplate" id="contentTemplate">
	<!--form:hidden path="tmplSerno"/ -->
	<!--form:hidden path="prvwFileSerno"/ -->
	<!--form:hidden path="tmplFileSerno"/ -->
	<!--jsp:directive.include file="/WEB-INF/jsp/common/incSchFrm.jsp"/ -->
	<div class="board_top">
	    <div class="board_right">
	        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
	    </div>
	</div>
	<table class="board_write">
		<colgroup>
			<col class="w20p"/>
			<col/>
			<col class="w20p"/>
			<col/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="asterisk">*</span>유형/타입</th>
				<td style="display: flex; gap: 10px;">
					<select name="selTmplCl" id="selTmplCl" title="템플릿 유형" style="width: 50%;"></select>
					<select name="selTmplTp" id="selTmplTp" title="템플릿 타입" style="width: 50%;"></select>
				</td>
				<th scope="row"><span class="asterisk">*</span>템플릿 설명</th>
				<td>
					<input type="text" id="tmplExpl" name="tmplExpl" title="템플릿 설명" class="w100p" maxlength="80" required="true"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><strong>템플릿 파일</strong></th>
				<td colspan="3">
				    <div id="atchFileUpload"> </div>
					<div class="filebox">
						<input type="file" id="tmplFile" name="tmplFile" class="file_input" multiple="multiple" />
						<div id="div_tmplFiles"></div>
						<!-- div id="atchFileUpload"> </div -->
						<button id="btn_copy" class="disno"></button>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="asterisk">*</span>에디터 내용</th>
				<td colspan="3" id="td_editor">
					<textarea id="tmplEditrCont" name="tmplEditrCont" class="txt_area w100p"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<div class="btn_area">
    <c:if test="${USER_AUTH.WRITE_YN == 'Y'}">
         <button type="button" id="btnTmplSubmit" class="btn blue">등록</button>
    </c:if>
	<button type="button" id="btnList" class="btn gray">취소</button>
</div>
