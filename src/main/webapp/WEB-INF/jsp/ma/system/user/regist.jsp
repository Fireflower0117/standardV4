<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
    $(document).ready(() => {
		/****************************************************************************************************
        ***********************************          페이지 기본정보 조회              *************************
        *****************************************************************************************************/
        // 공통코드 / 조회대상객체 조회 (한페이지 내무 첫번째 Transaction = 서버 1번호출)
        let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "userAuthList", sql : "on.standard.system.auth.selectAuthList" }  // 사용여부(공통) cmd : selectList(defualt) , sql :  on.standard.system.comcode.selectComCode (default)
                                                                , {rsId : "joinDivList" , sqlCondi : { uppComCd : "JOIN_DIV"    } }
                                                                ]
		                     });


      /******************************************************************************************************
        ***********************************              페이지 세팅                  *************************
        *****************************************************************************************************/

      	// 가입경로
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#userAuth" }
                                     , optionValInfo : { optId : "authId" , optTxt : "authKorName"  }
                                     , dataInfo      :  inqCdRsltList.userAuthList
                                     });


       /******************************************************************************************************
        ********************************              콤퍼넌트  이벤트                 *************************
        *****************************************************************************************************/
       let isUserIdDupleCkeck = false;

       // 사용자 ID중복 체크
        $("#btnUserIdDupl").on("click", (evt) => {

           // 권한ID 유효성 검증 대상
                let systemUserIdDuplValidateList  = [ {name : "userId"     , label : "사용자ID"           ,  rule: {required:true, minlength : 5, engNumOnly : true} }
                                              ];

                on.xhr.ajax({ sid : "userIdDupleChk" // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                            , cmd : "selectOne" , sql : "on.standard.system.user.selectUserIdDuplChk"
                            , validation : { formId : "#systemUserfrm" , validationList : systemUserIdDuplValidateList  }  // 유효성검증 기능 포함
                            , userId     : on.html.getEleVal({ele : "#userId" })
                            , successFn  : function (sid, data){
                                     if( data.isAble === "ABLE"){
                                          if(on.msg.confirm({message : "등록가능한 사용자ID입니다. 사용하시겠습니까?"}) ){
                                              isUserIdDupleCkeck = true;
                                          }
                                     }
                                     else {
                                        on.msg.showMsg({message : "이미 등록된 사용자ID 입니다.\n다른 ID를 선택하세요"});
                                     }
                            }
                });
        });

         // UserId변경시 기존 유휴성검증 무효화
        $("#userId").on("keydown", (evt) => {
          isUserIdDupleCkeck = false;
        });



        /******************************************************************************************************
        ********************************              저장/수정/삭제 수행                  *************************
        *****************************************************************************************************/
        <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
              $("#btnSubmit").on("click", (evt) => {
                  // 유효성 검증 대상
                  let systemAuthValidateList  = [ {name : "userId"      , label : "사용자ID"         ,  rule: {"required":true, minlength : 5, engNumOnly : true} }
                                                , {name : "userAuth"    , label : "사용자권한"        ,  rule: {"required":true} }
                                                , {name : "userKorNm"   , label : "사용자이름(한글명)" ,  rule: {"required":true} }
                                                , {name : "mobileNo"    , label : "모바일번호"        ,  rule: {"required":true, korMobile:true } }
                                                , {name : "emailAddr"   , label : "E-Mail"          ,  rule: {"required":true, email:true} }
                                                ];

                  // 권한 수정 (ajax형태 )
                  on.xhr.ajax({ sid : "userRegistTran"  // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                              , cmd : "multiAction"
                              , validation : { formId : "#systemUserfrm" , validationList : systemAuthValidateList  }  // 유효성검증기능 추가 관련
                              , data       : $("#systemUserfrm").serializeArray()   // Form Data
                              , userPswd   : on.enc.encrypt({encVal : on.html.getEleVal({ ele : "#userId"})  }) // 전송Data 추가
                              , regDivCd   : "AdminRegist" // 전송Data 추가
                              , multiAction : [ {cmd : "insert" , sql : "on.standard.system.user.insertUserInfo"    }
                                              , {cmd : "insert" , sql : "on.standard.system.user.insertAuthUserMng" }
                                              ]
                              , successFn  : function (sid, data){
                                       on.msg.showMsg({message : "사용자정보를 저장했습니다."})
                                       on.html.dynaGenHiddenForm({ formDefine : { fid:"userListForm" , action:"/ma/system/user/list.do" , method : "post" , isSubmit : true  }
                                                                 , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                                                ]
                                       }); // HiddenForm 생성및 전송
                                }
                  });

                  /*on.html.dynaGenHiddenForm({ formDefine  : { fid:"authListForm" , action:"/ma/system/auth/list.do" , method : "post" , isSubmit : true  }
                                               , validation : { formId : "#systemUserfrm" , validationList : systemAuthValidateList  }  // 유효성검증기능 추가 관련
                                               , formAttrs  : $("#systemUserfrm").serializeArray()
                                               , userPswd   : on.enc.encrypt({encVal : on.html.getEleVal({ ele : "#userId"})  })
                                               , regDivCd   : "AdminRegist"
                   });*/


              });
        </c:if>
    });
</script>
<div class="sidebyside">
  <div class="left">
    <h4 class="md_tit">시스템 사용자 등록</h4>
  </div>
  <div class="right">
    <div class="board_top">
      <div class="board_right">
        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
      </div>
    </div>
  </div>
</div>
<form id="systemUserfrm" name="systemUserfrm">
  <table class="board_write">
    <colgroup>
      <col>
      <col>
      <col>
      <col>
    </colgroup>
    <tbody>
    <tr>
      <th scope="col" class="c"><strong>사용자ID</strong></th>
      <td class="c">
          <input type="text" id="userId" name="userId" class="w30p" title="사용자ID" maxlength="20"/>
          <input type="button" id="btnUserIdDupl" value="중복검사" ></input>
      </td>
      <th scope="col" class="c"><strong>사용자 권한</strong></th>
      <td class="c">
          <select id="userAuth" name="userAuth" class="w30p" title="사용자권한" maxlength="10"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>사용자 한글명</strong></th>
      <td class="c">
         <input type="text" id="userKorNm" name="userKorNm" class="w30p" title="사용자 한글명" maxlength="100"/>
      </td>
      <th scope="col" class="c"><strong>사용자 영문명</strong></th>
      <td class="c">
          <input type="text" id="userEngNm" name="userEngNm" class="w30p" title="사용자 영문명" maxlength="100"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>모바일번호</strong></th>
      <td class="c">
          <input type="text" id="mobileNo" name="mobileNo" class="w30p" title="모바일번호" maxlength="100"/>
      </td>
      <th scope="col" class="c"><strong>E-Mail</strong></th>
      <td class="c">
          <input type="text" id="emailAddr" name="emailAddr" class="w30p" title="E-Mail" maxlength="100"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>집주소</strong></th>
      <td class="c" >
          <input type="text" id="homeAddr" name="homeAddr" class="w30p" title="집주소" maxlength="100"/>
      </td>
      <th scope="col" class="c"><strong>집주소상세</strong></th>
      <td class="c">
          <input type="text" id="homeAddrDtls" name="homeAddrDtls" class="w30p" title="집주소상세" maxlength="100"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>소속명</strong></th>
      <td class="c">
          <input type="text" id="blonNm" name="blonNm" class="w30p" title="소속명" maxlength="100"/>
      </td>
      <th scope="col" class="c"><strong>팩스번호</strong></th>
      <td class="c">
          <input type="text" id="faxNo" name="faxNo" class="w30p" title="팩스번호" maxlength="100"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>직급</strong></th>
      <td class="c">
            <input type="text" id="jgrpCd" name="jgrpCd" class="w30p" title="직급" maxlength="100"/>
      </td>
      <th scope="col" class="c"><strong>직군</strong></th>
      <td class="c">
          <input type="text" id="jrnkCd" name="jrnkCd" class="w30p" title="직군" maxlength="100"/>
      </td>
    </tr>
    </tbody>
  </table>
</form>
<div class="btn_area">
  <c:if test="${USER_AUTH.WRITE_YN== 'Y'}">
    <button type="button" id="btnSubmit" class="btn blue">등록</button>
  </c:if>
</div>