<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
    $(document).ready(() => {
		/****************************************************************************************************
        ***********************************          페이지 기본정보 조회              *************************
        *****************************************************************************************************/
        // 공통코드 / 조회대상객체 조회 (한페이지 내무 첫번째 Transaction = 서버 1번호출)
        let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "useYnList" , sqlCondi : { uppComCd : "COM_USE_YN"    } }  // 사용여부(공통) cmd : selectList(defualt) , sql :  on.standard.system.comcode.selectComCode (default)
                                                                ]
		                     });

		// 권한 정보 조회 (한페이지내부 두번째 Transaction = 서버 2번호출)
		let authInfoObj  = on.xhr.ajax({sid:"userView", sql : "on.standard.system.user.inqUserInfo" , cmd : "selectOne", userId : "${param.userId}" });


      /******************************************************************************************************
        ***********************************              페이지 세팅                  *************************
        *****************************************************************************************************/

        // Page의 속성중 Element Id를 기준으로 자동 매핑
        on.html.docSetElementById( authInfoObj ); // 객체의 속성Key명이 element의 Id와 일치하면 값을 자동으로 세팅한다.


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
      <td class="c" id="userId" ></td>
      <th scope="col" class="c"><strong>가입경로</strong></th>
      <td class="c" id="regDivCd" ></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>사용자 한글명</strong></th>
      <td class="c" id="userKorNm"></td>
      <th scope="col" class="c"><strong>사용자 영문명</strong></th>
      <td class="c" id="userEngNm"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>모바일번호</strong></th>
      <td class="c" id="mobileNo"></td>
       <th scope="col" class="c"><strong>E-Mail</strong></th>
      <td class="c" id="emailAddr"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>마지막로그인 일시</strong></th>
      <td class="c" id="lstLoginDt"></td>
      <th scope="col" class="c"><strong>비밀번호 마지막 변경일시</strong></th>
      <td class="c" id="lstPswdChgDt"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>SNS구분코드</strong></th>
      <td class="c" id="snsSeCd"></td>
      <th scope="col" class="c"><strong>SNS계정</strong></th>
      <td class="c" id="snsAccount"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>통합여부</strong></th>
      <td class="c"  id="intgYn"></td>
      <th scope="col" class="c"><strong>우편번호</strong></th>
      <td class="c"  id="zipNo"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>집주소</strong></th>
      <td class="c"  id="homeAddr"></td>
      <th scope="col" class="c"><strong>집주소상세</strong></th>
      <td class="c"  id="homeAddrDtls"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>소속명</strong></th>
      <td class="c" id="blonNm"></td>
      <th scope="col" class="c"><strong>팩스번호</strong></th>
      <td class="c" id="faxNo"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>직급</strong></th>
      <td class="c" id="jgrpCd"></td>
      <th scope="col" class="c"><strong>직군</strong></th>
      <td class="c" id="jrnkCd"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>탈퇴여부</strong></th>
      <td class="c" id="useYn"></td>
      <th scope="col" class="c"><strong>비밀번호실패횟수</strong></th>
      <td class="c" id="pswdFailCnt"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>차단여부</strong></th>
      <td class="c" id="brkYn"></td>
      <th scope="col" class="c"><strong>차단사유</strong></th>
      <td class="c" id="brkComment"></td>
    </tr>
    </tbody>
  </table>
</form>
<div class="btn_area">
  <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
    <button type="button" id="btnSubmit" class="btn blue">수정</button>
  </c:if>
</div>