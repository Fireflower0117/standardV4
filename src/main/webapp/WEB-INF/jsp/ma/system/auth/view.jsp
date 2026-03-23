<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
    $(document).ready(() => {
		/****************************************************************************************************
        ***********************************          페이지 기본정보 조회              *************************
        *****************************************************************************************************/
        // 공통코드 / 조회대상객체 조회 (한페이지 내무 첫번째 Transaction = 서버 1번호출)
        let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "useYnList"                                                                  , sqlCondi : { uppComCd : "COM_USE_YN"    } } // 사용여부(공통) cmd : selectList(defualt) , sql :  on.standard.system.comcode.selectComCode (default)
                                                                , {rsId : "authInfoMap", cmd: "selectOne" , sql : "on.standard.system.auth.selAuthView", sqlCondi : { authId : "${param.authId}" } } // SQL 조건식의 조건은 반드시 sqlCondi : {} 형태로 입력
					                                            ]
		                     });


      /******************************************************************************************************
        ***********************************              페이지 세팅                  *************************
        *****************************************************************************************************/

        // 비밀번호 갱신주기 사용여부
        on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#useYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "cdNm" }
                                     , dataInfo      : inqCdRsltList.useYnList
                                     });

        // Page의 속성중 Element Id를 기준으로 자동 매핑
        on.html.docSetElementById( inqCdRsltList.authInfoMap ); // 객체의 속성Key명이 element의 Id와 일치하면 값을 자동으로 세팅한다.


        /*****************************************************************************************************
        ********************************            저장/수정/삭제 수행           *******************************
        *****************************************************************************************************/
        <c:if test="${USER_AUTH.DELETE_YN== 'Y'}">
            // 삭제권한이있으면 Event 수행
            $("#btnDelete").on("click", (evt) => {
                if( inqCdRsltList.authInfoMap.isDelAble === 'N'){
                  on.msg.showMsg({message: "삭제불가한 권한입니다."});
                  return ;
                }

                if( on.msg.confirm({message : "정말 삭제하시겠습니까?"}) === true ){
                    on.xhr.ajax({ sid : "authDeleteTran"  // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                                , cmd : "delete" , sql : "on.standard.system.auth.delAuthInfo"
                                , authId     : "${param.authId}" // ajax data속성 + data 추가  ==>> (successFn, failFn, sql , cmd , validation 외 속성키는 전부 data로 추가입력 )
                                , successFn  : function (sid, data){
                                       on.msg.showMsg({message : "삭제했습니다."});

                                       // 권한 목록 페이지 이동 (검색조건 포함 )
                                       on.html.dynaGenHiddenForm({ formDefine : { fid:"authListForm" , action:"/ma/system/auth/list.do" , method : "post" , isSubmit : true  }
                                                                 , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                                                ]
                                       }); // HiddenForm 생성및 전송
                                }
                    });
                }
            });
        </c:if>


        <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
              // 수정권한이있으면 Event 수행
              $("#btnSubmit").on("click", (evt) => {

                  if(!on.msg.confirm({message: "수정하시겠습니까?"}) ){
                       return false;
                  }

                  // 유효성 검증 대상
                  let systemAuthValidateList  = [ {name : "useYn"       , label : "권한 사용여부" ,  rule: {"required":true} }
                                                , {name : "authKorName" , label : "권한 한글명"   ,  rule: {"required":true} }
                                                ];

                  // 권한 수정
                  on.xhr.ajax({ sid : "authUpdateTran"  // sid는 큰의미가 없음 , successFn시점에 sid로 전달하는 값일뿐이다.
                              , cmd : "update" , sql : "on.standard.system.auth.admin_updAuthInfo"  // on.standard.system.auth.admin_updAuthInfo SQL을 수행, update 문을 수행한다. (_admin SQL은 AllAdmin사용자만 수행가능)
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
    <caption>내용(시스템 전반의 운영정책 관리)</caption>
    <colgroup>
      <col>
      <col>
      <col>
      <col>
    </colgroup>
    <tbody>
    <tr>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>권한ID</strong></th>
      <td class="c" id="authId"></td>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>권한 사용여부</strong></th>
      <td>
         <select id="useYn" name="useYn" class="w30p" title="권한 사용여부" maxlength="10"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>권한 한글명</strong></th>
      <td class="c">
        <input type="text" id="authKorName" name="authKorName" class="w50p" title="권한한글명" maxlength="10"/>
      </td>
      <th scope="col" class="c"><strong>권한 영문명</strong></th>
      <td class="c">
        <input type="text" id="authEngName" name="authEngName" class="w50p" title="권한영문명" maxlength="10"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>권한설명</strong></th>
      <td class="c" colspan="3">
        <input type="text" id="authComment" name="authComment" class="w100p" title="권한 설명" maxlength="100"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>등록자</strong></th>
      <td class="c" id="regUserNm"></td>
      <th scope="col" class="c"><strong>등록일시</strong></th>
      <td class="c" id="regYmd"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼1</strong></th>
      <td class="c">
        <input type="text" id="tempCol1" name="tempCol1" class="w50p" title="임시칼럼1" maxlength="10"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼2</strong></th>
      <td class="c">
        <input type="text" id="tempCol2" name="tempCol2" class="w50p" title="임시칼럼2" maxlength="10"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼3</strong></th>
      <td class="c">
        <input type="text" id="tempCol3" name="tempCol3" class="w50p" title="임시칼럼3" maxlength="10"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼4</strong></th>
      <td class="c">
        <input type="text" id="tempCol4" name="tempCol4" class="w50p" title="임시칼럼4" maxlength="10"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼5</strong></th>
      <td class="c">
        <input type="text" id="tempCol5" name="tempCol5" class="w50p" title="임시칼럼5" maxlength="10"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼6</strong></th>
      <td class="c">
        <input type="text" id="tempCol6" name="tempCol6" class="w50p" title="임시칼럼6" maxlength="10"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼7</strong></th>
      <td class="c">
        <input type="text" id="tempCol7" name="tempCol7" class="w50p" title="임시칼럼7" maxlength="10"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼8</strong></th>
      <td class="c">
        <input type="text" id="tempCol8" name="tempCol8" class="w50p" title="임시칼럼8" maxlength="10"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼9</strong></th>
      <td class="c">
        <input type="text" id="tempCol9" name="tempCol9" class="w50p" title="임시칼럼9" maxlength="10"/>
      </td>
      <th scope="col" class="c"><strong>임시칼럼10</strong></th>
      <td class="c">
        <input type="text" id="tempCol10" name="tempCol10" class="w50p" title="임시칼럼10" maxlength="10"/>
      </td>
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