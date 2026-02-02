<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
    $(document).ready(() => {
		/***************************************************************************/
        /***********************      페이지 기본정보 조회        *********************/
        /***************************************************************************/


		let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "algorithmList"   , sqlCondi : { uppComCd : "ENC_ALGORITHM"    } }
				                                                , {rsId : "useYnList"       , sqlCondi : { uppComCd : "COM_USE_YN"       } }
				                                                , {rsId : "pssnPrdCdList"   , sqlCondi : { uppComCd : "PSSN_PRD_CD"      } }
				                                                , {rsId : "fileSaveDivList" , sqlCondi : { uppComCd : "FILE_SAVE_DIV_CD" } }
					                                         // , {rsId : "systemInfoMap"   , cmd: "selectOne" , sql : "on.standard.system.systempolicy.inqSystemPolicy"  } // 시스템 설정 기본정보 조회방법( 공통코드 조회에 포함하는경우 )
		                                                       ]
		                     });

		// 시스템 정보 조회 (별도로 개별적으로 조회할경우)
		let systemConfigObj  = on.xhr.ajax({sid:"systemConfig", sql : "on.standard.system.systempolicy.inqSystemPolicy" , cmd : "selectOne"  });


        /***************************************************************************/
        /***********************        페이지 세팅            ***********************/
        /***************************************************************************/

		// 암호화 알고리즘
		on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#pwdEncAlgorithm" }
                                       , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" , defaultVal : systemConfigObj.pwdEncAlgorithm }
                                       , comboDataInfo :  inqCdRsltList.algorithmList
                                       });

        // 비밀번호 갱신주기 사용여부
        on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#pwdChgCycleUseYn" }
                                       , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" , defaultVal : systemConfigObj.pwdChgCycleUseYn  }
                                       , comboDataInfo :   inqCdRsltList.useYnList
                                       });
        // 비밀번호 갱신주기
        $("#pwdChgCyclDd").val(systemConfigObj.pwdChgCyclDd);

         // 비밀번호 실패시 계정 잠금기능 사용여부
         on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#lginLmtUseYn" }
                                       , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" , defaultVal : systemConfigObj.lginLmtUseYn }
                                       , comboDataInfo :   inqCdRsltList.useYnList
                                       });
         // 비밀번호 잠금기준횟수
        $("#lginFailLmtCnt").val(systemConfigObj.lginFailLmtCnt);


		 // ITMS사용여부
         on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#itsmUseYn" }
                                       , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" , defaultVal : systemConfigObj.itsmUseYn}
                                       , comboDataInfo :   inqCdRsltList.useYnList
                                       });

		 // 탈퇴 사용자 정보 보유기간
		 on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#pwssPrdCd" }
                                       , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" , defaultVal : systemConfigObj.pwssPrdCd }
                                       , comboDataInfo :   inqCdRsltList.pssnPrdCdList
                                       });

		 // 파일 저장방식 구조
		 on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#atchFileSaveDiv" }
                                       , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" , defaultVal : systemConfigObj.AtchFileSaveDiv }
                                       , comboDataInfo :   inqCdRsltList.fileSaveDivList
                                       });

         // 파일저장경로
         $("#atchFilePath").val(systemConfigObj.atchFilePath);

         // MA Login후 기본이동경로
         $("#maDirectPage").val(systemConfigObj.maDirectPage);

         // FT Login후 기본이동경로
         $("#ftDirectPage").val(systemConfigObj.ftDirectPage);


        /***************************************************************************/
        /***********************        콤퍼넌트  이벤트        ***********************/
        /***************************************************************************/






        /***************************************************************************/
        /*********************        저장/수정/삭제 수행          ********************/
        /***************************************************************************/

			<%-- 등록,수정 처리 --%>
            <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">

			//	let validateSuccessFn = function( form ){
			//		alert("validateSuccessFn");
            //              debugger;
			//	}

               $('#btn_submit').on('click', (evt) => {

				   /* let systemConfigValidateObj = { formEle : "#systemConfigfrm" , callbackFn : validateSuccessFn , messageOption : "div"
								              , validateList  : [ {name : "selEncAlgorith"     , label : "암호화알고리즘"           ,  rule: {"required":true} }
										     		            , {name : "selPwdChgCyclUseYn" , label : "비밀번호변경주기"          ,  rule: {"required":true} }
										     		            , {name : "txtPwdChgCyclDd"    , label : "비밀번호변경주기일자"       ,  rule: {"required":true,numberOnly:true} }
                                                                , {name : "selPwdlockUseYn"    , label : "비밀번호실패시 계정잠금여부" ,  rule: {"required":true} }
                                                                , {name : "txtPwdfailCount"    , label : "비밀번호잠금기준횟수"       ,  rule: {"required":true,numberOnly:true} }
                                                                , {name : "selItmsUseYn"       , label : "ITMS 사용여부"            ,  rule: {"required":true} }
                                                                , {name : "selPssnPrdCd"       , label : "탈퇴계정 보유기간 코드"     ,  rule: {"required":true} }
                                                                , {name : "selFileSaveDivCd"   , label : "파일저장 방식 구분"        ,  rule: {"required":true} }
                                                                , {name : "txtFileSavePath"    , label : "파일저장경로"             ,  rule: {"required":true} }
                                                                , {name : "txtMaDirectPage"    , label : "MA Login후 기본이동경로"   ,  rule: {"required":true} }
                                                                , {name : "txtFtDirectPage"    , label : "FT Login후 기본이동경로"   ,  rule: {"required":true} }
                                                                , {name : "txtFileSavePath"    , label : "FT Login후 기본이동경로"   ,  rule: {"required":true} }
												                ]
				    };
				    on.valid.cmValidationCheck(systemConfigValidateObj);*/


				    //  1. form으로 전송하는경우의 Validation
                    /*on.html.dynaGenHiddenForm({ formDefine : { fid:"leftMenuForm", fTarget:menuTraget , action: menuHref , method : "post" , isSubmit : true   }
                                              , formValication : {  validationList :    , messageOption : "div" }
                                              , formAttrs  : { equip_no    : {name : "" , val:"" }
                                                             , date_upload : {name : "" , val:"" }
                                                             }
                                             });*/

                    //  2. jquery.ajax 로 전송하는경우의 Validation (sql의 경우)


                    // 3. jquery.ajax 로 전송하는경우의 Validation (url의 경우)



					let systemConfigValidateList  = [ {name : "pwdEncAlgorithm"     , label : "암호화알고리즘"           ,  rule: {"required":true} }
													, {name : "pwdChgCycleUseYn" , label : "비밀번호변경주기"          ,  rule: {"required":true} }
													, {name : "pwdChgCyclDd"     , label : "비밀번호변경주기일자"       ,  rule: {"required":true,numberOnly:true} }
													, {name : "lginLmtUseYn"     , label : "비밀번호실패시 계정잠금여부" ,  rule: {"required":true} }
													, {name : "LginFailLmtCnt"   , label : "비밀번호잠금기준횟수"       ,  rule: {"required":true,numberOnly:true} }
													, {name : "itsmUseYn"        , label : "ITMS 사용여부"            ,  rule: {"required":true} }
													, {name : "pwssPrdCd"        , label : "탈퇴계정 보유기간 코드"     ,  rule: {"required":true} }
													, {name : "atchFileSaveDiv"  , label : "파일저장 방식 구분"        ,  rule: {"required":true} }
													, {name : "AtchFilePath"     , label : "파일저장경로"             ,  rule: {"required":true} }
													, {name : "maDirectPage"     , label : "MA Login후 기본이동경로"   ,  rule: {"required":true} }
													, {name : "ftDirectPage"     , label : "FT Login후 기본이동경로"   ,  rule: {"required":true} }
													];


                    on.xhr.ajax({ sid : "systemConfigForm" // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
							    , cmd : "update" , sql : "on.standard.system.systempolicy.updSystemPolicy"
							    , validation : { formId : "#systemConfigfrm" , validationList : systemConfigValidateList , messageOption : "div"  }  // 유효성검증 관련
							    , data       : $("#systemConfigfrm").serializeArray()  // Data입력관련 (validation과 별개의 Data작업진행
							    , successFn  : function (sid, data){
										 on.html.dynaGenHiddenForm({ formDefine : { fid:"systemConfigForm" , action:"/ma/system/basic/form.do" , method : "post" , isSubmit : true  } }); // HiddenForm 생성및 전송
					             }
							    , failFn     : function (rsltCd, errMsg){

				                 }
					});


			   });

           </c:if>



    });
</script>
	<div class="sidebyside">
    	<div class="left">
			<h4 class="md_tit">시스템운영 정책</h4>
		</div>
		<div class="right">
			<div class="board_top">
			    <div class="board_right">
			        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
			    </div>
			</div>
		</div>
	</div>
	<form id="systemConfigfrm" name="systemConfigfrm">
		<table class="board_write">
			<caption>내용(시스템 전반의 운영정책 관리)</caption>
			<colgroup>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<tbody>
				<tr>
				   <th scope="col" class="c"><span class="asterisk">*</span><strong>암호화 알고리즘</strong></th>
				   <td class="c">
						<select id="pwdEncAlgorithm" name="pwdEncAlgorithm" class="w30p" title="암호화 알고리즘" />
				   </td>
				   <th></th>
				   <td></td>
				</tr>
				<tr>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>비밀번호변경주기 사용여부</strong></th>
					<td class="c">
						<select id="pwdChgCycleUseYn" name="pwdChgCycleUseYn" class="w30p" title="비밀번호변경주기 사용여부" maxlength="10"/>
					</td>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>비밀번호변경주기</strong></th>
					<td class="c">
						<input type="text" id="pwdChgCyclDd" name="pwdChgCyclDd" class="w30p numOnly" title="비밀번호변경주기" maxlength="10"/><span>일</span>
					</td>
				</tr>
				<tr>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>비밀번호실패시 계정잠금여부</strong></th>
					<td class="c">
						<select id="lginLmtUseYn" name="lginLmtUseYn" class="w30p" title="비밀번호실패시 계정잠금여부" maxlength="10"/>
					</td>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>비밀번호실패 잠금기준횟수</strong></th>
					<td class="c">
						<input type="text" id="lginFailLmtCnt" name="lginFailLmtCnt" class="w30p numOnly" title="비밀번호잠금기준횟수" maxlength="10"/><span>회</span>
					</td>
				</tr>
				 <tr>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>ITMS 사용여부</strong></th>
					<td class="c">
						<select id="itsmUseYn" name="itsmUseYn" class="w30p" title="ITMS여부" maxlength="10"/>
					</td>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>탈퇴계정 보유기간</strong></th>
					<td class="c">
						<select id="pwssPrdCd" name="pwssPrdCd" class="w30p" title="탈퇴계정 보유기간 코드" maxlength="10"/>
					</td>
				</tr>
				 <tr>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>파일저장 방식 구분</strong></th>
					<td class="c">
						<select id="atchFileSaveDiv" name="atchFileSaveDiv" class="w30p" title="파일저장 방식 구분" maxlength="10"/>
					</td>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>파일저장경로</strong></th>
					<td class="c">
						<input type="text" id="atchFilePath" name="atchFilePath" class="w80p" title="파일저장경로" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>MA Login후 기본이동경로</strong></th>
					<td class="c">
					   <input type="text" id="maDirectPage" name="maDirectPage" class="w80p" title="MA Login후 기본이동경로" maxlength="100"/>
					</td>
					<th scope="col" class="c"><span class="asterisk">*</span><strong>FT Login후 기본이동경로</strong></th>
					<td class="c">
						<input type="text" id="ftDirectPage" name="ftDirectPage" class="w80p" title="FT Login후 기본이동경로" maxlength="100"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="btn_area">
		<c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
			<button type="button" id="btn_submit" class="btn blue">수정</button>
		</c:if>
	</div>