<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
    $(document).ready(() => {
		/***************************************************************************
        ***********************      페이지 기본정보 조회        *********************
        ***************************************************************************/


		let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "isDelAbleList"   , sqlCondi : { uppComCd : "IS_DEL_ABLE"  } }
				                                                , {rsId : "useYnList"       , sqlCondi : { uppComCd : "COM_USE_YN"   } }
		                                                        ]
		                     });

        /***************************************************************************
        ***********************        페이지 세팅            ***********************
        ***************************************************************************/


		// 권한사용여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#useYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                     , dataInfo      : inqCdRsltList.useYnList
                                     });

        // 권한 삭제여부
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#isDelAble" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                     , dataInfo      :   inqCdRsltList.isDelAbleList
                                     });


        /***************************************************************************
        ***********************        콤퍼넌트  이벤트        ***********************
        ***************************************************************************/
        let isAuthDupleCkeck = false;
        // 권한 중복여부 확인버튼 이벤트
        $("#btnAuthIdDupl").on("click", (evt) => {

                // 권한ID 유효성 검증 대상
                let systemAuthValidateList  = [ {name : "authId"     , label : "권한ID"           ,  rule: {required:true, minlength : 5, engNumOnly : true} }
                                              ];

                on.xhr.ajax({ sid : "systemAuthDupleChk" // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                            , cmd : "selectOne" , sql : "on.standard.system.auth.selectAuthIdDuplChk"
                            , validation : { formId : "#systemAuthfrm" , validationList : systemAuthValidateList  }  // 유효성검증 기능 포함
                            , authId     : on.html.getEleVal({ele : "#authId" })
                            , successFn  : function (sid, data){
                                     if( data.isAble === "ABLE"){
                                          if(on.msg.confirm({message : "등록가능한 권한명입니다. 등록하시겠습니까?"}) ){
                                              isAuthDupleCkeck = true;
                                          }
                                     }
                                     else {
                                        on.msg.showMsg({message : "이미 등록된 권한명이 있습니다.\n다른 권한명을 선택하세요"});
                                     }
                            }
                });
        });

        // AuthId변경시 기존 유휴성검증 무효화
        $("#authId").on("keydown", (evt) => {
          isAuthDupleCkeck = false;
        });





        /***************************************************************************
        *********************        저장/수정/삭제 수행          ********************
        ***************************************************************************/

			<%-- 등록,수정 처리 --%>
            <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">

               $('#btnRegist').on('click', (evt) => {

                 if(isAuthDupleCkeck === false){
                    on.msg.showMsg({message : "저장전에 권한ID 중복체크먼저 수행하세요."});
                 }

                  // 권한ID 유효성 검증 대상
                 let systemAuthRegValidateList  = [ {name : "authId"      , label : "권한ID"           ,  rule: {required:true, minlength : 5, engNumOnly : true} }
                                                , {name : "useYn"       , label : "권한 사용여부"     ,  rule: {required:true} }
                                                , {name : "isDelAble"   , label : "권한 삭제가능여부"  ,  rule: {required:true} }
                                                , {name : "authKorName" , label : "권한 한글명"       ,  rule: {required:true} }
                                                ];

                 // 권한ID 저장
                 on.xhr.ajax({ sid : "systemAuthRegist" // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                              , cmd : "insert" , sql : "on.standard.system.auth.admin_insertAuthInfo" // AllAdmin만 SQL수행가능
                              , validation : { formId : "#systemAuthfrm" , validationList : systemAuthRegValidateList  }  // 유효성검증 기능 포함
                              , data       : $("#systemAuthfrm").serializeArray()
                              , successFn  : function (sid, data){
                                       on.msg.showMsg({message : "저장되었습니다."});
                                       // 권한 저장성공시 권한 목록 페이지로 이동 (검색입력조건 포함 : searchCondition)
                                       on.html.dynaGenHiddenForm({ formDefine : { fid:"authListForm" , action:"/ma/system/auth/list.do" , method : "post" , isSubmit : true  }
                                                                 , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                                                ]
                                       });
                               }
                 });



			   });
           </c:if>

    });
</script>
<div class="sidebyside">
  <div class="left">
    <h4 class="md_tit">시스템 사용자 권한</h4>
  </div>
  <div class="right">
    <div class="board_top">
      <div class="board_right">
        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
      </div>
    </div>
  </div>
</div>
<form id="systemAuthfrm" name="systemAuthfrm">
  <table class="board_write">
    <caption>내용(권한등록)</caption>
    <colgroup>
      <col>
      <col>
      <col>
      <col>
    </colgroup>
    <tbody>
    <tr>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>권한ID</strong></th>
      <td class="c" colspan="3">
          <input type="text" id="authId" name="authId" class="w30p" title="권한ID" maxlength="30"/>
          <input type="button" id="btnAuthIdDupl" value="중복검사" ></input>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>권한 사용여부</strong></th>
      <td class="c" >
         <select id="useYn" name="useYn" class="w30p" title="권한 사용여부" />
      </td>
      <th scope="col" class="c"><strong>권한 삭제가능여부</strong></th>
      <td class="c" >
        <select id="isDelAble" name="isDelAble" class="w30p" title="권한 삭제가능여부" />
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>권한 한글명</strong></th>
      <td class="c">
        <input type="text" id="authKorName" name="authKorName" class="w50p" title="권한한글명" maxlength="30"/>
      </td>
      <th scope="col" class="c"><strong>권한 영문명</strong></th>
      <td class="c">
        <input type="text" id="authEngName" name="authEngName" class="w50p" title="권한영문명" maxlength="30"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>권한설명</strong></th>
      <td class="c" colspan="3">
        <input type="text" id="authComment" name="authComment" class="w100p" title="권한 설명" maxlength="200"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼1</strong></th>
      <td class="c">
        <input type="text" id="tempCol1" name="tempCol1" class="w50p" title="임시칼럼1" maxlength="50"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼2</strong></th>
      <td class="c">
        <input type="text" id="tempCol2" name="tempCol2" class="w50p" title="임시칼럼2" maxlength="50"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼3</strong></th>
      <td class="c">
        <input type="text" id="tempCol3" name="tempCol3" class="w50p" title="임시칼럼3" maxlength="50"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼4</strong></th>
      <td class="c">
        <input type="text" id="tempCol4" name="tempCol4" class="w50p" title="임시칼럼4" maxlength="50"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼5</strong></th>
      <td class="c">
        <input type="text" id="tempCol5" name="tempCol5" class="w50p" title="임시칼럼5" maxlength="50"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼6</strong></th>
      <td class="c">
        <input type="text" id="tempCol6" name="tempCol6" class="w50p" title="임시칼럼6" maxlength="50"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼7</strong></th>
      <td class="c">
        <input type="text" id="tempCol7" name="tempCol7" class="w50p" title="임시칼럼7" maxlength="50"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼8</strong></th>
      <td class="c">
        <input type="text" id="tempCol8" name="tempCol8" class="w50p" title="임시칼럼8" maxlength="50"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼9</strong></th>
      <td class="c">
        <input type="text" id="tempCol9" name="tempCol9" class="w50p" title="임시칼럼9" maxlength="50"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼10</strong></th>
      <td class="c">
        <input type="text" id="tempCol10" name="tempCol10" class="w50p" title="임시칼럼10" maxlength="50"/>
      </td>
    </tr>
    </tbody>
  </table>
</form>
<div class="btn_area">
  <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
    <button type="button" id="btnRegist" class="btn blue">등록</button>
  </c:if>
</div>