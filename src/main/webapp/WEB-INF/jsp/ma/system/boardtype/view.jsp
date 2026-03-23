<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script>
    $(document).ready(() => {
        /***************************************************************************
        ********************      페이지 기본정보 조회 / 세팅       ********************
        ***************************************************************************/

         // 게시판 유형 조회
         let boardTypeInfo = on.xhr.ajax({ cmd : "selectOne" ,sql : "on.standard.system.boardtype.inqBoardInfo" , boardCd :  '${param.boardCd}' });
         on.html.docSetElementById(boardTypeInfo);

         /**************************************************************************
        ***********************       버튼 관련 이벤트         ***********************
        ***************************************************************************/
        <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
            //  게시판 유형 수정
            $("#btnUpdate").on("click" , (evt) => {
                    on.html.dynaGenHiddenForm({ formDefine : { fid:"boardTypeListForm" , action:"/ma/system/boardtype/update.do" , method : "post" , isSubmit : true  }
                                              , formAttrs  : [ { name : "searchCondition" , value : JSON.stringify(${param.searchCondition}) }
                                                              ,{ name : "boardCd"         , value : '${param.boardCd}' }
                                                    ]
                                       });

            });
        </c:if>

        // 취소 (목록으로)
        $("#btnCancle").on("click" , (evt) => {
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
      <td class="c" id="useYn"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><span class="asterisk">*</span><strong>게시판이름(한글)</strong></th>
      <td class="c" id="boardKorNm"></td>
      <th scope="col" class="c"><strong>게시판이름 (영문)</strong></th>
      <td class="c" id="boardEngNm"></td>
    </tr>
     <tr>
      <th scope="col" class="c"><strong>게시판설명</strong></th>
      <td class="c" colspan="3" id="boardComment"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>공지글 사용여부</strong></th>
      <td class="c" id="ntiYn"></td>
      <th scope="col" class="c"><strong>추천글 사용여부</strong></th>
      <td class="c" id="rcmdYn"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>제목 작성여부</strong></th>
      <td class="c" id="titleYn"></td>
      <th scope="col" class="c"><strong>게시글 내용 작성여부</strong></th>
      <td class="c" id="contentYn"></td>
    </tr>
    <tr>
      <th scope="col" class="c">게시글 Editor적용여부</th>
      <td class="c" id="contentEditorYn"></td>
      <th scope="col" class="c"><strong>첨부파일 가능여부</strong></th>
      <td class="c" id="attchFileYn"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>첨부파일 최대갯수</strong></th>
      <td class="c" id="fileLimitCnt"></td>
      <th scope="col" class="c"><strong>첨부파일 최대용량( ~50Mb)</strong></th>
      <td class="c" id="fileLimitMb"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>비밀글 작성여부</strong></th>
      <td class="c" id="secretYn"></td>
      <th scope="col" class="c"><strong>답글형 게시판 여부</strong></th>
      <td class="c" id="replyYn"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼1</strong></th>
      <td class="c" id="tempCol1"></td>
      <th scope="col" class="c"><strong>임시칼럼2</strong></th>
      <td class="c" id="tempCol2"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼3</strong></th>
      <td class="c" id="tempCol3"></td>
      <th scope="col" class="c"><strong>임시칼럼4</strong></th>
      <td class="c" id="tempCol4"></td>
    </tr>
    <tr>
      <th scope="col" class="c"><strong>임시칼럼5</strong></th>
      <td class="c" id="tempCol5"></td>
      <th scope="col" class="c"><strong>임시칼럼6</strong></th>
      <td class="c" id="tempCol6"></td>
    </tr>
    </tbody>
  </table>
</form>
<div class="btn_area">
  <c:if test="${USER_AUTH.UPDATE_YN== 'Y'}">
    <button type="button" id="btnUpdate" class="btn blue">수정</button>
  </c:if>
  <button type="button" id="btnCancle" class="btn blue">취소</button>
</div>