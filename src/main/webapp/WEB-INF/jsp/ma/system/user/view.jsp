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

		// 사용자 정보 조회 (한페이지내부 두번째 Transaction = 서버 2번호출)
		let authInfoObj  = on.xhr.ajax({sid:"userView", sql : "on.standard.system.user.inqUserInfo" , cmd : "selectOne", userId : "${param.userId}" });


      /******************************************************************************************************
        ***********************************              페이지 세팅                  *************************
        *****************************************************************************************************/

        // Page의 속성중 Element Id를 기준으로 자동 매핑
        on.html.docSetElementById( authInfoObj ); // 객체의 속성Key명이 element의 Id와 일치하면 값을 자동으로 세팅한다.


       /******************************************************************************************************
        ********************************              콤퍼넌트  이벤트                 *************************
        *****************************************************************************************************/


        /******************************************************************************************************
        ********************************              저장/수정/삭제 수행                *************************
        *****************************************************************************************************/

        <c:if test="${USER_AUTH.DELETE_YN== 'Y'}">
             // 삭제권한이 있으면 Event 수행
             $("#btnDelete").on("click", (evt) => {

                if(on.msg.confirm({message : "정말 삭제하시겠습니까.?"}) === true ){
                     // 사용자 삭제
                    on.xhr.ajax({ cmd : "multiAction"
                                , userId   : "${param.userId}" // 전송Data 추가
                                , multiAction : [ {cmd : "delete" , sql : "on.standard.system.user.deleteUserMng"    }
                                                , {cmd : "delete" , sql : "on.standard.system.user.deleteAuthUserMng" }
                                                ]
                                , successFn  : function (data){
                                         on.msg.showMsg({message : "사용자정보를 삭제했습니다."})
                                         on.html.dynaGenHiddenForm({ formDefine : { fid:"userListForm" , action:"/ma/system/user/list.do" , method : "post" , isSubmit : true  }
                                                                   , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                                                  ]
                                         }); // HiddenForm 생성및 전송
                                  }
                    });
                }
             });
        </c:if>

        <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
              // 수정권한이 있으면 Event수행
              $("#btnSubmit").on("click", (evt) => {
                  on.html.dynaGenHiddenForm({ formDefine : { fid:"userUpdateForm"       , action:"/ma/system/user/update.do" , method : "post" , isSubmit : true  }
                                            , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                           , { name : "userId"          , value : "${param.userId}"                        }
                                                           ]
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
    <!-- tr>
      <th scope="col" class="c"><strong>SNS구분코드</strong></th>
      <td class="c" id="snsSeCd"></td>
      <th scope="col" class="c"><strong>SNS계정</strong></th>
      <td class="c" id="snsAccount"></td>
    </tr -->
    <tr>
      <th scope="col" class="c"><strong>등록일</strong></th>
      <td class="c"  id="regDate"></td>
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
  <c:if test="${USER_AUTH.DELETE_YN== 'Y'}">
    <button type="button" id="btnDelete" class="btn blue">삭제</button>
  </c:if>
  <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
    <button type="button" id="btnSubmit" class="btn blue">수정</button>
  </c:if>
</div>