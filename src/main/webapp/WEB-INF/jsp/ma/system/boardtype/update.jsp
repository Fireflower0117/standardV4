<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script>
    $(document).ready(() => {

           // 공통 조회 , 게시판 유형 정보 (일괄조회 1Transaction)
         let inqCdRsltList =  on.xhr.ajaxComCdList({ condiList : [ {rsId : "useYnList"       , sqlCondi : { uppComCd : "COM_USE_YN"   } }
                                                                 , {rsId : "boardTypeInfo"   , cmd : "selectOne" , sql : "on.standard.system.boardtype.inqUpdBoardInfo"   , sqlCondi : { boardCd : '${param.boardCd}'   } }
		                                                            ]
		                      });

            // 게시판 사용여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#useYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      :  inqCdRsltList.useYnList
                                    });

        // 공지글 여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#ntiYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      :  inqCdRsltList.useYnList
                                    });

         // 추천글 여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#rcmdYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      :  inqCdRsltList.useYnList
                                    });

         // 제목 작성 여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#titleYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      :  inqCdRsltList.useYnList
                                    });

         // 내용 작성 여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#contentYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      :  inqCdRsltList.useYnList
                                    });
        // 에디터 적용 여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#contentEditorYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      :  inqCdRsltList.useYnList
                                    });

         // 첨부파일  여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#attchFileYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      :  inqCdRsltList.useYnList
                                    });

         // 비밀글 작성  여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#secretYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      : inqCdRsltList.useYnList
                                    });

        // 답글형 게시판  여부
		on.html.dynaGenSelectOptions({ targetInfo    : { targetId : "#replyYn" }
                                     , optionValInfo : { optId : "comCd" , optTxt : "filter1" }
                                     , dataInfo      : inqCdRsltList.useYnList
                                    });

        // 게시판 유형 정보 값 일괄 자동세팅
        on.html.docSetElementById(inqCdRsltList.boardTypeInfo);

        /**************************************************************************
        ***********************       버튼 관련 이벤트         ***********************
        ***************************************************************************/


               // 게시판 유형 등록 유효성 검증 리스트
               let boardTypeRegValidList = [{name : "boardCd"      , label : "게시판코드"           ,  rule: {required:true, minlength : 3} }
                                           ,{name : "boardKorNm"   , label : "게시판이름(한글)"      ,  rule: {required:true } }
                                           ]

               // 첨부파일 가능여부(판단에 따라 유효성 검증 추가 및 제거)
               $("#attchFileYn").on("change", (evt) => {
                   let attchFIleUseYn = $(evt.target).val();
                   if("Y" === attchFIleUseYn){
                       // 중복 추가 방지: 배열 내에 'fileLimitCnt'가 없을 때만 추가
                       if (!boardTypeRegValidList.some(item => item.name === "fileLimitCnt")) {
                           boardTypeRegValidList.push(
                               {name : "fileLimitCnt", label : "첨부파일제한개수", rule: {required:true}},
                               {name : "fileLimitMb" , label : "첨부파일제한용량", rule: {required:true}}
                           );
                       }
                   }
                   else {
                      // 항목 제거: 'fileLimitCnt'와 'fileLimitMb'가 아닌 객체들만 남기고 배열 덮어쓰기
                       boardTypeRegValidList = boardTypeRegValidList.filter(item =>
                           item.name !== "fileLimitCnt" && item.name !== "fileLimitMb"
                       );
                   }
               });

            // 수정
            <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
                $("#btnUpdate").on("click", (evt) => {
                     on.xhr.ajax({ cmd: "update" , sql : "on.standard.system.boardtype.mergeInsBoardType"
                                 , boardCd :  on.html.getEleVal({ele : "#boardCd" })
                                 , validation : { formId : "#boardTypeForm" , validationList : boardTypeRegValidList  }  // 유효성검증 기능 포함
                                 , data : $("#boardTypeForm").serializeArray()
                                 , successFn : function (rs){
                                       if(rs[0].execResult === "success"){
                                          on.msg.showMsg({message : "게시판유형이 수정되었습니다."});
                                          goList();
                                       }
                                    }
                                 , failFn    : function (err){
                                        on.msg.showMsg({message : err.message});
                                 }
                     });
                });
            </c:if>

        // 취소
        $("#btnCancle").on("click", (evt) => {
             goList();
        });

        // 목록 이동함수 (목록 검색조검 포함)
        function goList(){
           on.html.dynaGenHiddenForm({ formDefine : { fid:"boardTypeListForm" , action:"/ma/system/boardtype/list.do" , method : "post" , isSubmit : true  }
                                     , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                    ]
                                       });

        }

   });
</script>

<div class="sidebyside">
  <div class="left">
    <h4 class="md_tit">게시판 유형 관리</h4>
  </div>
  <div class="right">
    <div class="board_top">
      <div class="board_right">
        <div class="form_guide"><span class="asterisk">*</span>필수입력</div>
      </div>
    </div>
  </div>
</div>
<form id="boardTypeForm" name="boardTypeForm">
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
      <th scope="col" class="c"><span class="asterisk">*</span><strong>게시판코드</strong></th>
      <td class="c" id="boardCd"></td>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>사용여부</strong></th>
      <td class="c">
         <select id="useYn" name="useYn" class="w30p" title="사용여부" />
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>게시판이름(한글)</strong></th>
      <td class="c">
        <input type="text" id="boardKorNm" name="boardKorNm" class="w50p" title="게시판이름(한글)" maxlength="30"/>
      </td>
      <th scope="col" class="c"><strong>게시판이름 (영문)</strong></th>
      <td class="c">
        <input type="text" id="boardEngNm" name="boardEngNm" class="w50p" title="권한영문명" maxlength="30"/>
      </td>
    </tr>
     <tr>
      <th scope="col" class="c"><strong>게시판설명</strong></th>
      <td class="c" colspan="3">
        <input type="text" id="boardComment" name="boardComment"  class="w100p" title="게시판설명" maxlength="200"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>공지글 사용여부</strong></th>
      <td class="c">
         <select id="ntiYn" name="ntiYn" class="w30p" title="공지글 사용여부" />
      </td>
      <th scope="col" class="c"><strong>추천글 사용여부</strong></th>
      <td class="c" >
        <select id="rcmdYn" name="rcmdYn" class="w30p" title="추천글 사용여부" />
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>제목 작성여부</strong></th>
      <td class="c">
          <select id="titleYn" name="titleYn" class="w30p" title="제목 작성여부" />
      </td>
      <th scope="col" class="c"><strong>게시글 내용 작성여부</strong></th>
      <td class="c">
        <select id="contentYn" name="contentYn" class="w30p" title="게시글 내용 작성여부" />
      </td>
    </tr>
    <tr>
      <th scope="col" class="c">게시글 Editor적용여부</th>
      <td class="c"> <select id="contentEditorYn" name="contentEditorYn" class="w30p" title="첨부파일 가능여부" /></td>
      <th scope="col" class="c"><strong>첨부파일 가능여부</strong></th>
      <td class="c">
         <select id="attchFileYn" name="attchFileYn" class="w30p" title="첨부파일 가능여부" />
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>첨부파일 최대갯수</strong></th>
      <td class="c">
        <input type="text" id="fileLimitCnt" name="fileLimitCnt" class="w50p numOnly" title="첨부파일 최대갯수" maxlength="2"/>
      </td>
      <th scope="col" class="c"><strong>첨부파일 최대용량( ~50Mb)</strong></th>
      <td class="c">
        <input type="text" id="fileLimitMb" name="fileLimitMb" class="w50p numOnly" title="첨부파일 최대용량( ~50Mb)" maxlength="2"/>
      </td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>비밀글 작성여부</strong></th>
      <td class="c">
         <select id="secretYn" name="secretYn" class="w30p" title="비밀글 작성여부" />
      </td>
      <th scope="col" class="c"><strong>답글형 게시판 여부</strong></th>
      <td class="c">
        <select id="replyYn"  name="replyYn" class="w30p" title="답글형 게시판 여부" />
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
    </tbody>
  </table>
</form>
<div class="btn_area">
  <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
    <button type="button" id="btnPreView" class="btn blue">미리보기</button>
    <button type="button" id="btnUpdate" class="btn blue">수정</button>
  </c:if>
  <button type="button" id="btnCancle" class="btn blue">취소</button>
</div>