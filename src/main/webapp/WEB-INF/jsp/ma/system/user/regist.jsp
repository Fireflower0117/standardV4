<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
    $(document).ready(() => {
		/****************************************************************************************************
        ***********************************          페이지 기본정보 조회              *************************
        *****************************************************************************************************/
        // 공통코드 / 조회대상객체 조회 (한페이지 내무 첫번째 Transaction = 서버 1번호출)
        let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "useYnList" , sqlCondi : { uppComCd : "COM_USE_YN"    } }  // 사용여부(공통) cmd : selectList(defualt) , sql :  on.standard.system.comcode.selectComCode (default)
                                                                , {rsId : "joinDivList" , sqlCondi : { uppComCd : "JOIN_DIV"    } }
                                                                ]
		                     });

        // regDivCd 가입경로

		// 권한 정보 조회 (한페이지내부 두번째 Transaction = 서버 2번호출)
		let authInfoObj  = on.xhr.ajax({sid:"userView", sql : "on.standard.system.user.inqUserInfo" , cmd : "selectOne", userId : "${param.userId}" });


      /******************************************************************************************************
        ***********************************              페이지 세팅                  *************************
        *****************************************************************************************************/

      	// 가입경로
		on.html.dynaGenSelectOptions({ comboInfo     : { targetId : "#joinDivCd" }
                                     , optionValInfo : { optId : "COM_CD" , optTxt : "CD_NM" , defaultVal : systemConfigObj.pwdEncAlgorithm }
                                     , comboDataInfo :  inqCdRsltList.joinDivList
                                     });


       /******************************************************************************************************
        ********************************              콤퍼넌트  이벤트                 *************************
        *****************************************************************************************************/


        /***************************************************************************/
        /*********************        저장/수정/삭제 수행          ********************/
        /***************************************************************************/
        <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
              $("#btnSubmit").on("click", (evt) => {
                  // 유효성 검증 대상
                  let systemAuthValidateList  = [ {name : "useYn"       , label : "권한 사용여부" ,  rule: {"required":true} }
                                                , {name : "authKorName" , label : "권한 한글명"   ,  rule: {"required":true} }
                                                ];

                  // 권한 수정
                  on.xhr.ajax({ sid : "authUpdateTran"  // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                              , cmd : "update" , sql : "on.standard.system.auth.updAuthInfo"  // on.standard.system.auth.updAuthInfo SQL을 수행, update 문을 수행한다.
                              , validation : { formId : "#systemAuthfrm" , validationList : systemAuthValidateList  }  // 유효성검증기능 추가 관련
                              , data       : $("#systemAuthfrm").serializeArray()  // Data입력관련 (validation과 별개의 Data작업진행
                              , authId     : "${param.authId}" // ajax data속성 + data 추가  ==>> (successFn, failFn, sql , cmd , validation 외 속성키는 전부 data로 추가입력 )
                              , successFn  : function (sid, data){
                                       on.html.dynaGenHiddenForm({ formDefine : { fid:"authListForm" , action:"/ma/system/auth/list.do" , method : "post" , isSubmit : true  }
                                                                 , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                                                ]
                                       }); // HiddenForm 생성및 전송
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
          <input type="text" id="userId" name="userId" class="w30p" title="사용자ID" maxlength="10"/>
          <input type="button" id="btnUserIdDupl" value="중복검사" ></input>
      </td>
      <th scope="col" class="c"><strong>가입경로</strong></th>
      <td class="c">
          <select id="joinDivCd" name="joinDivCd" class="w30p" title="가입경로" maxlength="10"/>
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
  <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
    <button type="button" id="btnSubmit" class="btn blue">수정</button>
  </c:if>
</div>